
!/bin/bash
##projeto
function MENU(){
OPCAO=$( dialog						\
	--stdout					\
	--menu "Escolha uma das opções"			\
	0 0 0						\
	1 "Criar usuário"				\
	2 "apagar usuário"				\
	3 "Criar grupo"					\
	4 "apagar grupo"				\
	5 "Alterar Senha"				\
	6 "Mostrar passwd"				\
	7 "Alterar usuário do grupo"		        \
	8 "Mostrar usuários"				\
	9 "Mostrar grupos"				\
	10 "Voltar")

case $OPCAO in
 	1) CUSR ;;
	2) AUSR ;;
	3) CGRP ;;
	4) AGRP ;;
	5) APAS	;;
	6) PAWD ;;
	7) AUGR ;;
	8) MUSR ;;
	9) MGRP ;;
	"10") bash /Projeto/menu.sh ;;
	*) dialog --msgbox "Opção Invalida. Digite novamente" ;;
esac
}
CUSR(){
	NOME=$(	dialog --stdout --inputbox "Digite o nome do usuário" 0 0)
	useradd $NOME
case $? in
	0) dialog --msgbox "Usuário criado com sucesso!" 0 0; MENU;;
	1) dialog --msgbox "Tente novamente!" 0 0; CUSR;;
	9) dialog --msgbox "Usuário já existe" 0 0;;

esac
MENU
}
AUSR(){
	NOME=$(	dialog --stdout --inputbox "Digite o nome do usuário" 0 0)
	userdel -f $NOME
case $? in
	0) dialog --msgbox "Usuário apagado com sucesso!" 0 0; MENU;;
	1) dialog --msgbox "Tente novamente!" 0 0; AUSR;;
	6) dialog --msgbox "Usuário não existe" 0 0;;
esac
MENU
}
CGRP(){
	NOME=$(	dialog --stdout --inputbox "Digite o nome do grupo" 0 0)
	groupadd $NOME
	case $? in
	0) dialog --msgbox "Grupo criado com sucesso!" 0 0; MENU;;
	1) dialog --msgbox "Tente novamente!" 0 0; CUSR;;
	9) dialog --msgbox "Esse grupo já existe" 0 0;;
	esac
	MENU
}
AGRP(){
	NOME=$(	dialog --stdout --inputbox "Digite o nome do grupo" 0 0)
	groupdel $NOME
case $? in
	0) dialog --msgbox "Grupo apagado com sucesso!" 0 0; MENU;;
	1) dialog --msgbox "Tente novamente!" 0 0; AGRP;;
	6) dialog --msgbox "Grupo inexistente" 0 0;;
esac

}
APAS(){
	NOME=$(	dialog --stdout --passwordbox "Digite a nova senha" 0 0)
	passwd $NOME
	COCO=$(	dialog --stdout --passwordbox "Digite a senha novamente" 0 0)
	case $? in
	0) dialog --msgbox "Senha do usuário atual modificada" 0 0; MENU;;
	1) dialog --msgbox "Tente novamente!" 0 0; APAS;;
	10) dialog --msgbox "Não foi possível atualizar a senha" 0 0;;
	*) dialog --msgbox "$?" 0 0;;

esac

}
PAWD(){
	dialog --textbox /etc/passwd 0 0
	MENU
}
AUGR(){
	NOME=$(	dialog --stdout --inputbox "Digite o nome do usuario" 0 0)
	GRUPO=$( dialog --stdout --inputbox "Digite o nome do grupo" 0 0)

	gpasswd -a  $NOME $GRUPO
case $? in
	0) dialog --msgbox "Usuario movido para $GRUPO" 0 0; MENU;;
	1) dialog --msgbox "Tente novamente!" 0 0; AUGR;;
esac
}
MUSR(){
	dialog --textbox /etc/passwd 0 0
}
MGRP(){
	dialog --textbox /etc/group 0 0
case $? in
	0) MENU;;
	*) dialog --msgbox 'Erro: $?'
esac
}

MENU
