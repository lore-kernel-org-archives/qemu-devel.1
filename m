Received: from eggs.gnu.org ([2001:4830:134:3::10]:39830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eygWe-0001fS-FA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eygWd-0008F8-Jn
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:23:44 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:44667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eygWd-0008Es-F0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:23:43 -0400
Received: by mail-ot0-x22d.google.com with SMTP id x6-v6so4759585otg.11
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:23:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
	<397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 21 Mar 2018 17:23:42 +0100
Message-ID: <CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

> You need to "r"un the program here. :)
>
> Also probably "b aio_context_set_poll_params" is useful before you run
> the program, to trap the moment in which the function is called.
>

Hi, that got me here:

(gdb) run
Starting program: c:\qemu-master\qemu-system-ppc.exe -L
c:\qemu-master\pc-bios -boot d -m 256 -M mac99 -prom-env
"boot-args=-v" -prom-env "auto-boot?=true" -prom-env "vga-ndrv?=true"
-drive "file=c:\Mac-disks\debian-9.0-powerpc-NETINST-1.iso,format=raw,media=cdrom"
-device usb-mouse -device usb-kbd -netdev "user,id=network01" -device
"sungem,netdev=network01,mac=52:54:00:12:34:56" -sdl -drive
"file=c:\Mac-disks\9.2.img,format=raw,media=disk"
[New Thread 10844.0x24d0]
warning: FTH: (10844): *** Fault tolerant heap shim applied to current
process. This is usually due to previous crashes. ***
[New Thread 10844.0x1224]
[New Thread 10844.0x2a30]
[New Thread 10844.0x2594]
[New Thread 10844.0x32a8]

Thread 1 hit Breakpoint 1, aio_context_set_poll_params (ctx=0xc14a9b0,
max_ns=32768, grow=0, shrink=0, errp=0x362f968)
    at util/aio-win32.c:413
413     in util/aio-win32.c
(gdb) s
error_setg_internal (errp=0x362f968, src=0xe166e0 <__func__.58569+32>
"util/aio-win32.c", line=413,
    func=0xe16740 <__func__.59050> "aio_context_set_poll_params",
    fmt=0xe16708 <__func__.58569+72> "AioContext polling is not
implemented on Windows") at util/error.c:91
91      util/error.c: No such file or directory.
(gdb) s
94      in util/error.c
