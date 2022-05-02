#!/bin/bash

kernel=$(uname -r)
CPUMAN=$(cat /proc/cpuinfo | grep "vendor_id" | cut -d":" -f2)
CORES=$(cat /proc/cpuinfo | grep "cpu cores" | cut -d":" -f2)
TOTALMEMORY=$(free -mh | grep "Mem" | awk '{print $2}')
FREEMEMORY=$(free -mh | grep "Mem" | awk '{print $4}')
FREEDISK=$(lsblk | grep "sda" | awk '{print $4}' | paste -sd " " | awk '{print $1}')

autoenum()
{
printf "====================================\n"
printf "CPU Manufacture\t:\t$CPUMAN\n"
printf "Number of Cores\t:\t$CORES\n"
printf "RAM Memory\t:\t$TOTALMEMORY\n"
printf "Free RAM\t:\t$FREEMEMORY\n"
printf "Total disk size\t:\t$FREEDISK\n"
printf "====================================\n"
}


mainmenu()
{
	echo -ne "
++++++++++++++++++++++++++++++++++++++++++
Linux Enum [Kernel Ver.$kernel]
++++++++++++++++++++++++++++++++++++++++++
1] Auto Enum
2] Manual Enum
3] Exit
Input: "
	read -r ans
	case $ans in
	1)
		autoenum
		mainmenu
		;;
	2)
		submenu
		;;
	3) 
		exit 1
		;;
	*)
		printf "++++++++++++WRONG INPUT++++++++++++++\n"
		mainmenu
		;;
	"")
		printf "==========input from menu=========\n"
		mainmenu
		;;
esac
}
 	

submenu()
{
echo -ne "
+++++++++++++++++++++++++++++++
SUBMENU
+++++++++++++++++++++++++++++++
1] CPU Manufacturer
2] Number of cores
3] RAM memory
4] Free RAM
5] Total disk size
6] Return to main menu
Input: "
        read -r ans
        case $ans in
        1)
                printf "===================================\n"
		printf "CPU Manufacture\t:\t$CPUMAN\n"
		printf "===================================\n"
                submenu
                ;;
        2)
		printf "===================================\n"
                printf "Number of Cores\t:\t$CORES\n"
                printf "===================================\n"
                submenu
                ;;
        3)
		 printf "===================================\n"
		printf "RAM Memory\t:\t$TOTALMEMORY\n"
                printf "===================================\n"
            	 submenu
		;;
	4)
                printf "===================================\n"
		printf "Free RAM\t:\t$FREEMEMORY\n"
                printf "===================================\n"

		submenu
                ;;
	5)
                printf "===================================\n"
		printf "Total disk size\t:\t$FREEDISK\n"
		printf "===================================\n"
		submenu
		;;
	6)
		mainmenu
		;;
	*)
                printf "++++++++++++wrong input++++++++++++\n"
                submenu
                ;;
        "")
                printf "+++++++++++input from menu+++++++++++++\n"
                submenu
                ;;

esac

}

mainmenu
