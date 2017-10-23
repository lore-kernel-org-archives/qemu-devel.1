Received: from eggs.gnu.org ([2001:4830:134:3::10]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e6RKv-0008QT-46
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e6RKq-0006T4-50
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:15:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e6RKp-0006R9-OM
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:15:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id y39so15763134wrd.4
	for <qemu-devel@nongnu.org>; Sun, 22 Oct 2017 18:15:18 -0700 (PDT)
References: <20171022161312.4xlitnw2bknvv7ml@ubuntu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <240b64ec-0236-a4ee-2e6a-f39800a9f9b0@redhat.com>
Date: Mon, 23 Oct 2017 03:15:15 +0200
MIME-Version: 1.0
In-Reply-To: <20171022161312.4xlitnw2bknvv7ml@ubuntu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Unable to clone git repository from git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Eduardo_A._Bustamante_L=c3=b3pez?=" <dualbus@gmail.com>, qemu-devel@nongnu.org

On 22/10/2017 18:13, Eduardo A. Bustamante López wrote:
> (please keep me CC'ed, I'm not subscribed)
> 
> Hi,
> 
> I apologize if this is not the right mailing list for this report. I'm unable to clone the git repository from
> git://git.qemu.org/qemu.git (which is listed on https://www.qemu.org/contribute/).
> 
> I'm getting TCP RST's when I try to clone it, as indicated by the packet capture:
> 
>   dualbus@ubuntu:~/src/qemu$ git clone git://git.qemu.org/qemu.git
>   Cloning into 'qemu'...
>   fatal: read error: Connection reset by peer
> 
>   dualbus@ubuntu:~/src/qemu$ git clone git://git.qemu.org/qemu.git
>   Cloning into 'qemu'...
>   fatal: Could not read from remote repository.
>   
>   Please make sure you have the correct access rights
>   and the repository exists.

Thanks for your report, we will look into it soon.  In the meanwhile,
you can use the github mirror:

   git clone git://github.com/qemu/qemu

Paolo

> 
>   ---
> 
>   dualbus@ubuntu:~$ sudo tcpdump -n 'host git.qemu.org'
>   tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
>   listening on eno1, link-type EN10MB (Ethernet), capture size 262144 bytes
>   10:29:34.459497 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [S], seq 1870728944, win 29200, options [mss 1460,sackOK,TS val 500213983 ecr 0,nop,wscale 7], length 0
>   10:29:35.487129 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [S], seq 1870728944, win 29200, options [mss 1460,sackOK,TS val 500214240 ecr 0,nop,wscale 7], length 0
>   10:29:35.487854 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [S.], seq 1436706601, ack 1870728945, win 28960, options [mss 1380,sackOK,TS val 3511630652 ecr 500213983,nop,wscale 10], length 0
>   10:29:35.487949 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [.], ack 1, win 229, options [nop,nop,TS val 500214240 ecr 3511630652], length 0
>   10:29:35.488077 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [P.], seq 1:49, ack 1, win 229, options [nop,nop,TS val 500214240 ecr 3511630652], length 48
>   10:29:36.604320 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [S.], seq 1436706601, ack 1870728945, win 28960, options [mss 1380,sackOK,TS val 3511631678 ecr 500213983,nop,wscale 10], length 0
>   10:29:36.604378 IP 192.168.1.108.43168 > 172.99.69.163.9418: Flags [.], ack 1, win 229, options [nop,nop,TS val 500214519 ecr 3511630652], length 0
>   10:29:36.608418 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [.], ack 49, win 29, options [nop,nop,TS val 3511631682 ecr 500214240], length 0
>   10:29:36.608943 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [R.], seq 1, ack 49, win 29, options [nop,nop,TS val 0 ecr 500214240], length 0
>   10:29:37.553793 IP 172.99.69.163.9418 > 192.168.1.108.43168: Flags [R.], seq 1, ack 49, win 229, length 0
>   10:29:40.037068 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [S], seq 4085609936, win 29200, options [mss 1460,sackOK,TS val 500215377 ecr 0,nop,wscale 7], length 0
>   10:29:41.038109 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [S.], seq 1040747289, ack 4085609937, win 28960, options [mss 1380,sackOK,TS val 3511636236 ecr 500215377,nop,wscale 10], length 0
>   10:29:41.038218 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [.], ack 1, win 229, options [nop,nop,TS val 500215627 ecr 3511636236], length 0
>   10:29:41.038398 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [P.], seq 1:49, ack 1, win 229, options [nop,nop,TS val 500215627 ecr 3511636236], length 48
>   10:29:42.111622 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [F.], seq 1, ack 1, win 29, options [nop,nop,TS val 3511637236 ecr 500215627], length 0
>   10:29:42.113384 IP 192.168.1.108.43170 > 172.99.69.163.9418: Flags [F.], seq 49, ack 2, win 229, options [nop,nop,TS val 500215896 ecr 3511637236], length 0
>   10:29:42.121555 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [R], seq 1040747290, win 0, length 0
>   10:29:43.121773 IP 172.99.69.163.9418 > 192.168.1.108.43170: Flags [R.], seq 2, ack 50, win 229, length 0
>   ^C
>   18 packets captured
>   27 packets received by filter
>   0 packets dropped by kernel
> 
> 
> I was able to clone it via HTTPS, but now I'm having issues updating the git submodules
> 
>   dualbus@ubuntu:~/src/qemu/qemu$ git submodule update ui/keycodemapdb
>   Cloning into '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'...
>   fatal: Could not read from remote repository.
>   
>   Please make sure you have the correct access rights
>   and the repository exists.
>   fatal: clone of 'git://git.qemu.org/keycodemapdb.git' into submodule path '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'
>   failed
>   Failed to clone 'ui/keycodemapdb'. Retry scheduled
>   Cloning into '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'...
>   fatal: Could not read from remote repository.
>   
>   Please make sure you have the correct access rights
>   and the repository exists.
>   fatal: clone of 'git://git.qemu.org/keycodemapdb.git' into submodule path '/home/dualbus/src/qemu/qemu/ui/keycodemapdb'
>   failed
>   Failed to clone 'ui/keycodemapdb' a second time, aborting
> 
