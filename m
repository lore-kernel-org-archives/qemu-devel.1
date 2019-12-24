Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F56C2D0C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 04:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83DB206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 04:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83DB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijbtz-0005jL-Qt
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 23:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ijbt9-00059s-Ue
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 23:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ijbt8-000637-Et
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 23:33:43 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59176)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ijbt8-0005ww-8u; Mon, 23 Dec 2019 23:33:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 508B123EE8;
 Mon, 23 Dec 2019 23:33:35 -0500 (EST)
Date: Tue, 24 Dec 2019 15:33:40 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: NetBSD/arc on MIPS Magnum, was Re: [PATCH 00/10] Fixes for
 DP8393X SONIC device emulation
In-Reply-To: <alpine.LNX.2.21.1.1912241016420.42@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1.1912241504560.11@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
 <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
 <CAL1e-=hRs0EMz7ZTt+GXMfyHW8arq-h-m1Dzd3jz+vqP82+zjA@mail.gmail.com>
 <CAL1e-=iTBxqCsNCbGpONdewE4uTDG=OAV36fF_Cq9=i6KQhMaA@mail.gmail.com>
 <alpine.LNX.2.21.1.1912200912360.8@nippy.intranet>
 <636043f1-bd84-f00d-55a5-7d58aab6cd57@redhat.com>
 <alpine.LNX.2.21.1.1912241016420.42@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Dec 2019, Finn Thain wrote:

> 
> I know precious little about NetBSD installation and MIPS Magnum. What I 
> wrote above was guesswork. Hence this could be a NetBSD bug or user 
> error.
> 

It was bugs and user error.

The user error was not using the serial console. The NetBSD/arc 
installation guide says that only serial console is supported for MIPS 
Magnum.

The bugs include regressions in NetBSD. (See below.)

The other issue is that the ARC firmware didn't work properly until I 
defined one or more 'boot selections', even though none of these will ever 
be selected.

> Does there exist a known-good combination of NetBSD/arc and 
> qemu-system-mips64el releases?
> 

The commit log says that Herv? Poussineau used NetBSD 5.1 with dp8393x in 
the past, so I tried that.

Here are the steps I used:

./mips64el-softmmu/qemu-system-mips64el -M magnum -L .  
-drive if=scsi,unit=2,media=cdrom,format=raw,file=arccd-5.1.iso
-global ds1225y.filename=nvram -global ds1225y.size=8200
-serial stdio -serial null
-nic bridge,model=dp83932,mac=00:00:00:02:03:04

-> Run setup -> Initialize system -> Set default configurations
	800x688
	3.5 1.44 M
	No
	7

-> Set default environment
	CD-ROM
	2

-> Set environment variables
	CONSOLEIN
	multi()serial(0)term()
	CONSOLEOUT
	multi()serial(0)term()

-> Exit

Now restart QEMU. The ARC menu should appear on the tty.

-> Run a program

	scsi(0)cdrom(2)fdisk(0)boot scsi(0)cdrom(2)fdisk(0)netbsd

That doesn't work. Add a boot selection.

-> Run setup -> Manage startup -> Add a boot selection -> Scsi CD-ROM 0
	\os\nt\osloader.exe
	Yes
	\winnt
	Windows NT
	No

Somehow, that seems to help. Now restart QEMU.

-> Run a program

        scsi(0)cdrom(2)fdisk(0)boot scsi(0)cdrom(2)fdisk(0)netbsd

NetBSD/arc Bootstrap, Revision 1.1
(builds@b7.netbsd.org, Sat Nov  6 14:06:36 UTC 2010)
devopen: scsi(0)cdrom(2)fdisk(0) type disk file netbsd
5502064+289092=0x5860e0
Copyright (c) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
    2006, 2007, 2008, 2009, 2010
    The NetBSD Foundation, Inc.  All rights reserved.
Copyright (c) 1982, 1986, 1989, 1991, 1993
    The Regents of the University of California.  All rights reserved.

NetBSD 5.1 (RAMDISK) #0: Sat Nov  6 14:17:36 UTC 2010
        builds@b7.netbsd.org:/home/builds/ab/netbsd-5-1-RELEASE/arc/201011061943Z-obj/home/builds/ab/netbsd-5-1-RELEASE/src/sys/arch/arc/compile/RAMDISK
MIPS Magnum
total memory = 128 MB
avail memory = 117 MB
mainbus0 (root)
cpu0 at mainbus0: MIPS R4000 CPU (0x400) Rev. 0.0 with MIPS R4010 FPC Rev. 0.0
cpu0: 8KB/16B direct-mapped L1 Instruction cache, 48 TLB entries
cpu0: 8KB/16B direct-mapped write-back L1 Data cache
jazzio0 at mainbus0
timer0 at jazzio0 addr 0xe0000228
mcclock0 at jazzio0 addr 0xe0004000: mc146818 compatible time-of-day clock
LPT1 at jazzio0 addr 0xe0008000 intr 0 not configured
fdc0 at jazzio0 addr 0xe0003000 intr 1
fd0 at fdc0 drive 1: 1.44MB, 80 cyl, 2 head, 18 sec
MAGNUM at jazzio0 addr 0xe000c000 intr 2 not configured
VXL at jazzio0 addr 0xe0800000 intr 3 not configured
sn0 at jazzio0 addr 0xe0001000 intr 4: SONIC Ethernet
sonic: write 0x0015 to reg CR
sonic: write 0x0080 to reg CR
sonic: write 0x0000 to reg IMR
sonic: write 0x7fff to reg ISR
sonic: write 0x0000 to reg CR
sn0: Ethernet address 00:00:00:00:00:00
asc0 at jazzio0 addr 0xe0002000 intr 5: NCR53C94, 25MHz, SCSI ID 7
scsibus0 at asc0: 8 targets, 8 luns per target
pckbc0 at jazzio0 addr 0xe0005000 intr 6
pckbd0 at pckbc0 (kbd slot)
wskbd0 at pckbd0 (mux ignored)
pms at jazzio0 addr 0xe0005000 intr 7 not configured
com0 at jazzio0 addr 0xe0006000 intr 8: ns16550a, working fifo
com0: txfifo disabled
com0: console
com1 at jazzio0 addr 0xe0007000 intr 9: ns16550a, working fifo
com1: txfifo disabled
jazzisabr0 at mainbus0
isa0 at jazzisabr0
isapnp0 at isa0 port 0x279: ISA Plug 'n Play device support
scsibus0: waiting 2 seconds for devices to settle...
cd0 at scsibus0 target 2 lun 0: <QEMU, QEMU CD-ROM, 2.5+> cdrom removable
cd1 at scsibus0 target 4 lun 0: <QEMU, QEMU CD-ROM, 2.5+> cdrom removable
boot device: <unknown>
root on md0a dumps on md0b
root file system type: ffs
WARNING: preposterous TOD clock time
WARNING: using filesystem time
WARNING: CHECK AND RESET THE DATE!
erase ^H, werase ^W, kill ^U, intr ^C, status ^T
Terminal type? [vt100] 
Erase is backspace.                                                     
(I)nstall, (S)hell or (H)alt ? s
# ifconfig sn0 10.2.3.4/24
# ping
usage: 
ping [-adDfLnoPqQrRv] [-c count] [-g gateway] [-h host] [-i interval] [-I addr]
     [-l preload] [-p pattern] [-s size] [-t tos] [-T ttl] [-w maxwait] host


My initial testing shows that NetBSD 5.1 doesn't like my v2 patch series. 
I'll debug that before I send v3.

BTW, there seem to be regressions in NetBSD 8.1 compared to NetBSD 5.1. 

The 'boot' program on the 8.1 ISO just hangs.

If I use the 'boot' program from the 5.1 ISO to load the 'netbsd' 
binary from the 8.1 ISO, I get a crash:

-> Run a program

	scsi(0)cdrom(2)fdisk(0)boot scsi(0)cdrom(4)fdisk(0)netbsd

NetBSD/arc Bootstrap, Revision 1.1
(builds@b7.netbsd.org, Sat Nov  6 14:06:36 UTC 2010)
devopen: scsi(0)cdrom(4)fdisk(0) type disk file netbsd
7902064|
Jazz Monitor. Version 174
Press H for help, Q to quit.
AdEL exception occurred.
 at=149f4800 v0=00000000 v1=8003d698 a0=807f3d40 a1=80eff158 a2=00000800
 a3=80eff188 t0=00000001 t1=00000001 t2=80045400 t3=800232d8 t4=000a4fa4
 t5=00000000 t6=00746669 t7=00746685 s0=80f0cab8 s1=00000800 s2=80eff1d0
 s3=80f10000 s4=80f0ee18 s5=80f0ee18 s6=00028eef s7=00000000 t8=00746685
 t9=c0000000 k0=80041f50 k1=80000194 gp=80f0c540 sp=80eff128 s8=80f0ca30
 ra=80023310 psr=20000803 epc=8002331c cause=00004010 errorepc=00000000
 badvaddr=00746689
>

I haven't tried the latest iso (9.0-rc1).

