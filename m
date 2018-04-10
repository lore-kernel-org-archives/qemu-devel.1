Received: from eggs.gnu.org ([2001:4830:134:3::10]:57212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f5kmr-0001UT-B2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f5kmp-0007xS-P7
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:21:41 -0400
MIME-Version: 1.0
In-Reply-To: <CAHP4M8VSzm4L6oS06J-e93FwjuHM=weJf2MegCaDNH8MPbsqgA@mail.gmail.com>
References: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
	<87efjov999.fsf@linaro.org>
	<CAHP4M8W-WuBmJUdb6LGR1t3tPayrnaS+b1ZZ1zew71aM==-imA@mail.gmail.com>
	<87d0z8v78e.fsf@linaro.org>
	<CAHP4M8VSzm4L6oS06J-e93FwjuHM=weJf2MegCaDNH8MPbsqgA@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Tue, 10 Apr 2018 09:51:31 +0530
Message-ID: <CAHP4M8U3wJ6qwwVoU_=h2ZiE7VDhJUogXfo1BHm+Q780czA8jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Crash when running hello-world unikernel for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, rumpkernel-users@freelists.org

Following is the gdb details :

##########################################################################################
ajay@debian:~/rumprun-arm32$ gdb --args qemu-system-arm -machine virt
-nographic -kernel helloer.bin
GNU gdb (Debian 7.7.1+dfsg-5) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-linux-gnueabihf".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from qemu-system-arm...(no debugging symbols found)...done.
(gdb) r
Starting program: /usr/bin/qemu-system-arm -machine virt -nographic
-kernel helloer.bin
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/arm-linux-gnueabihf/libthread_db.so.1".
[New Thread 0xb388f290 (LWP 3140)]
qemu: fatal: Trying to execute code outside RAM or ROM at 0x00100000

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000
Program received signal SIGUSR1, User defined signal 1.
[Switching to Thread 0xb388f290 (LWP 3140)]
0xb5e80f42 in write () at ../sysdeps/unix/syscall-template.S:81
81    ../sysdeps/unix/syscall-template.S: No such file or directory.
(gdb) bt
#0  0xb5e80f42 in write () at ../sysdeps/unix/syscall-template.S:81
#1  0xb5e45c84 in _IO_new_file_write (f=0xb5ee29f0 <_IO_2_1_stderr_>,
    data=0xb388c5a0, n=12) at fileops.c:1253
#2  0xb5e454b2 in new_do_write (fp=fp@entry=0xb5ee29f0 <_IO_2_1_stderr_>,
    data=data@entry=0xb388c5a0 "R04=00000000", to_do=to_do@entry=12)
    at fileops.c:530
#3  0xb5e460d0 in _IO_new_file_xsputn (f=0xb5ee29f0 <_IO_2_1_stderr_>,
    data=<optimized out>, n=12) at fileops.c:1335
#4  0xb5e2bc8e in buffered_vfprintf (s=s@entry=0xb5ee29f0 <_IO_2_1_stderr_>,
    format=format@entry=0x263e68 "R%02d=%08x", args=...) at vfprintf.c:2369
#5  0xb5e28418 in _IO_vfprintf_internal (s=0xb5ee29f0 <_IO_2_1_stderr_>,
    format=0x263e68 "R%02d=%08x", format@entry=0x84ad60 "pg\201", ap=...,
    ap@entry=...) at vfprintf.c:1296
#6  0xb5e2ee00 in __fprintf (stream=<optimized out>,
    format=0x263e68 "R%02d=%08x") at fprintf.c:32
#7  0x000dc352 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)
#0  0xb5e80f42 in write () at ../sysdeps/unix/syscall-template.S:81
#1  0xb5e45c84 in _IO_new_file_write (f=0xb5ee29f0 <_IO_2_1_stderr_>,
    data=0xb388c5a0, n=12) at fileops.c:1253
#2  0xb5e454b2 in new_do_write (fp=fp@entry=0xb5ee29f0 <_IO_2_1_stderr_>,
    data=data@entry=0xb388c5a0 "R04=00000000", to_do=to_do@entry=12)
    at fileops.c:530
#3  0xb5e460d0 in _IO_new_file_xsputn (f=0xb5ee29f0 <_IO_2_1_stderr_>,
    data=<optimized out>, n=12) at fileops.c:1335
#4  0xb5e2bc8e in buffered_vfprintf (s=s@entry=0xb5ee29f0 <_IO_2_1_stderr_>,
    format=format@entry=0x263e68 "R%02d=%08x", args=...) at vfprintf.c:2369
#5  0xb5e28418 in _IO_vfprintf_internal (s=0xb5ee29f0 <_IO_2_1_stderr_>,
    format=0x263e68 "R%02d=%08x", format@entry=0x84ad60 "pg\201", ap=...,
    ap@entry=...) at vfprintf.c:1296
#6  0xb5e2ee00 in __fprintf (stream=<optimized out>,
    format=0x263e68 "R%02d=%08x") at fprintf.c:32
#7  0x000dc352 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
##########################################################################################

On Tue, Apr 10, 2018 at 9:44 AM, Ajay Garg <ajaygargnsit@gmail.com> wrote:
> Thanks Alex for the reply ..
>
>>
>> Can you run under -s -S and gdb step the *guest* and see where it ends
>> up. The above error is usually indicative of the guest going off into
>> the weeds somewhere because the hardware isn't what it expects.
>>
>
> So, after your reply that it might be because of the
> hardware-mismatch, I kinda took a detour, and installed a arm32 "virt"
> machine on qemu on a x86_64 host, as per the steps at
> https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemus-32-bit-arm-virt-board/
>
> All went fine, and then I compiled rumprun on this "virt" guest.
> Finally, upon running, I now get this :
>
> ##########################################################################################
> ajay@debian:~/rumprun-arm32$ qemu-system-arm -machine virt -nographic
> -kernel helloer.bin
> qemu: fatal: Trying to execute code outside RAM or ROM at 0x00100000
>
> R00=00000000 R01=00000000 R02=00000000 R03=00000000
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=00000000 R14=00000000 R15=00100000
> PSR=400001d3 -Z-- A svc32
> s00=00000000 s01=00000000 d00=0000000000000000
> s02=00000000 s03=00000000 d01=0000000000000000
> s04=00000000 s05=00000000 d02=0000000000000000
> s06=00000000 s07=00000000 d03=0000000000000000
> s08=00000000 s09=00000000 d04=0000000000000000
> s10=00000000 s11=00000000 d05=0000000000000000
> s12=00000000 s13=00000000 d06=0000000000000000
> s14=00000000 s15=00000000 d07=0000000000000000
> s16=00000000 s17=00000000 d08=0000000000000000
> s18=00000000 s19=00000000 d09=0000000000000000
> s20=00000000 s21=00000000 d10=0000000000000000
> s22=00000000 s23=00000000 d11=0000000000000000
> s24=00000000 s25=00000000 d12=0000000000000000
> s26=00000000 s27=00000000 d13=0000000000000000
> s28=00000000 s29=00000000 d14=0000000000000000
> s30=00000000 s31=00000000 d15=0000000000000000
> s32=00000000 s33=00000000 d16=0000000000000000
> s34=00000000 s35=00000000 d17=0000000000000000
> s36=00000000 s37=00000000 d18=0000000000000000
> s38=00000000 s39=00000000 d19=0000000000000000
> s40=00000000 s41=00000000 d20=0000000000000000
> s42=00000000 s43=00000000 d21=0000000000000000
> s44=00000000 s45=00000000 d22=0000000000000000
> s46=00000000 s47=00000000 d23=0000000000000000
> s48=00000000 s49=00000000 d24=0000000000000000
> s50=00000000 s51=00000000 d25=0000000000000000
> s52=00000000 s53=00000000 d26=0000000000000000
> s54=00000000 s55=00000000 d27=0000000000000000
> s56=00000000 s57=00000000 d28=0000000000000000
> s58=00000000 s59=00000000 d29=0000000000000000
> s60=00000000 s61=00000000 d30=0000000000000000
> s62=00000000 s63=00000000 d31=0000000000000000
> FPSCR: 00000000
> Aborted
> ##########################################################################################
>
>
> Additionally, I compiled rumprun on a beaglebone-green-wireless (arm32
> machine), and did the same test.
> (Fortunately), I got the exact same stacktrace as above, so I guess
> it's no more  an issue with hardware-mismatch now ..
>
> Not sure if this is an issue with qemu now, or rumprun ...
>
>
> Thanks and Regards,
> Ajay



-- 
Regards,
Ajay
