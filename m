Received: from eggs.gnu.org ([2001:4830:134:3::10]:49722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyfe1-00043Y-0I
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyfdx-0003Hn-Od
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:27:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyfdx-0003H2-KZ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:27:13 -0400
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
Date: Wed, 21 Mar 2018 16:27:03 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 21/03/2018 14:29, Howard Spoelstra wrote:
> Obviously not, but this doesn't make things better... ;-)
> 
> C:\qemu-debugging>gdb --args c:\qemu-master\qemu-system-ppc.exe -L
> c:\qemu-master\pc-bios -boot d -m 256 -M mac99 -prom-env
> "boot-args=-v" -prom-env "auto-boot?=true" -prom-env "vga-ndrv?=true"
> -drive file=c:\Mac-disks\debian-9.0-powerpc-NETINST-1.iso,format=raw,media=cdrom
> -device usb-mouse -device usb-kbd -netdev user,id=network01 -device
> sungem,netdev=network01,mac=52:54:00:12:34:56 -sdl -drive
> file=c:\Mac-disks\9.2.img,format=raw,media=disk
> This binary was built by Equation Solution <http://www.Equation.com>.
> GNU gdb (GDB) 7.12
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-w64-mingw32".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from c:\qemu-master\qemu-system-ppc.exe...done.

You need to "r"un the program here. :)

Also probably "b aio_context_set_poll_params" is useful before you run
the program, to trap the moment in which the function is called.

Thanks,

Paolo

> (gdb) thread apply all bt full
> (gdb) bt
> No stack.
> (gdb)
> 
> Best,
> Howard
> 
