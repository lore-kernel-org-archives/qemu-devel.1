Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C699AC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC8D2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC8D2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioagj-0000BA-K5
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 17:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ioaep-0007nS-LC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ioaen-0000C8-S3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:15:31 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59160)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ioaen-00009i-KT; Mon, 06 Jan 2020 17:15:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7A4DB2A81A;
 Mon,  6 Jan 2020 17:15:24 -0500 (EST)
Date: Tue, 7 Jan 2020 09:15:26 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: NetBSD/arc on MIPS Magnum, was Re: [PATCH 00/10] Fixes for
 DP8393X SONIC device emulation
In-Reply-To: <8fe965fe-5cf5-2b1e-1f4c-c3e9ce06107d@reactos.org>
Message-ID: <alpine.LNX.2.21.1.2001061843490.65@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
 <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
 <CAL1e-=hRs0EMz7ZTt+GXMfyHW8arq-h-m1Dzd3jz+vqP82+zjA@mail.gmail.com>
 <CAL1e-=iTBxqCsNCbGpONdewE4uTDG=OAV36fF_Cq9=i6KQhMaA@mail.gmail.com>
 <alpine.LNX.2.21.1.1912200912360.8@nippy.intranet>
 <636043f1-bd84-f00d-55a5-7d58aab6cd57@redhat.com>
 <alpine.LNX.2.21.1.1912241016420.42@nippy.intranet>
 <alpine.LNX.2.21.1.1912241504560.11@nippy.intranet>
 <8fe965fe-5cf5-2b1e-1f4c-c3e9ce06107d@reactos.org>
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
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Dec 2019, hpoussin@reactos.org wrote:

> > 
> > I haven't tried the latest iso (9.0-rc1).
> > 

I found that NetBSD 9.0-rc1 has the same regressions.

> 
> Hello Finn,
> 
> Thanks for finding the required steps to boot NetBSD on MIPS Magnum. I 
> was trying to find how to let it work on non-configured machine since 
> some days!
> You indeed need my patch at
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05037.html
> 

Thanks. As it turned out, I didn't need that patch in order to get 
NetBSD/arc 5.1 working. But I applied the patch anyway after I found that 
a Linux/mips kernel produced DMA errors. But the errors remain (see 
below).

With a few minor Linux patches and a mipsel busybox build, I was able to 
boot to a prompt. ESP SCSI works, but not SONIC ethernet. My dp8393x patch 
series was not sufficient to make ethernet work (no regression though).

NetBSD/arc Bootstrap, Revision 1.1
(builds@b7.netbsd.org, Sat Nov  6 14:06:36 UTC 2010)
devopen: scsi(0)cdrom(4)fdisk(0) type disk file vmlinux
5991052+141348 [656192+872841]=0x74eb98
Linux version 5.4.0-00003-g34add35b08c0 (fthain@nippy) (gcc version 4.6.4 (btc)) #24 Mon Jan 6 20:10:57 AEDT 2020
ARCH: Microsoft-Jazz
PROMLIB: ARC firmware Version 1 Revision 2
CPU0 revision is: 00000400 (R4000PC)
FPU revision is: 00000500
printk: debug: ignoring loglevel setting.
Primary instruction cache 8kB, VIPT, direct mapped, linesize 16 bytes.
Primary data cache 8kB, direct mapped, VIPT, cache aliases, linesize 16 bytes
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000000ffffff]
  Normal   [mem 0x0000000001000000-0x0000000007ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
On node 0 totalpages: 32768
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 224 pages used for memmap
  Normal zone: 28672 pages, LIFO batch:7
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists, mobility grouping on.  Total pages: 32512
Kernel command line: scsi(0)cdrom(4)fdisk(0)vmlinux root=/dev/sda rw ignore_loglevel ip=192.168.66.11 init=/bin/sh
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 123396K/131072K available (4716K kernel code, 168K rwdata, 812K rodata, 184K init, 100K bss, 7676K reserved, 0K cma-reserved)
NR_IRQS: 128
random: get_random_bytes called from start_kernel+0x32c/0x4e0 with crng_init=0
Console: colour dummy device 80x25
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
Calibrating delay loop... 990.41 BogoMIPS (lpj=4952064)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 3072 bytes, linear)
NET: Registered protocol family 16
VDMA: R4030 DMA pagetables initialized.
SCSI subsystem initialized
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 0, 4096 bytes, linear)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes, linear)
NET: Registered protocol family 1
workingset: timestamp_bits=30 max_order=15 bucket_order=0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler mq-deadline registered
io scheduler kyber registered
Console: switching to colour frame buffer device 100x37
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
printk: console [ttyS0] disabled
serial8250.0: ttyS0 at MMIO 0xe0006000 (irq = 32, base_baud = 115200) is a 16550A
printk: console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0xe0007000 (irq = 33, base_baud = 115200) is a 16550A
loop: module loaded
jazz_esp jazz_esp.0: esp0: regs[(ptrval):(ptrval)] irq[29]
jazz_esp jazz_esp.0: esp0: is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
random: fast init done
scsi host0: esp
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
scsi target0:0:0: Beginning Domain Validation
scsi target0:0:0: Domain Validation skipping write tests
scsi target0:0:0: Ending Domain Validation
scsi 0:0:2:0: CD-ROM            QEMU     QEMU CD-ROM      2.5+ PQ: 0 ANSI: 5
scsi target0:0:2: Beginning Domain Validation
scsi target0:0:2: Domain Validation skipping write tests
scsi target0:0:2: Ending Domain Validation
scsi 0:0:4:0: CD-ROM            QEMU     QEMU CD-ROM      2.5+ PQ: 0 ANSI: 5
scsi target0:0:4: Beginning Domain Validation
scsi target0:0:4: Domain Validation skipping write tests
scsi target0:0:4: Ending Domain Validation
sd 0:0:0:0: [sda] 120000 512-byte logical blocks: (61.4 MB/58.6 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 63 00 00 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SONIC ethernet @e0001000, MAC 01:00:1c:00:01:00, IRQ 28
serio: i8042 KBD port at 0xe0005000,0xe0005001 irq 30
serio: i8042 AUX port at 0xe0005000,0xe0005001 irq 31
NET: Registered protocol family 10
Segment Routing with IPv6
sd 0:0:0:0: [sda] Attached SCSI disk
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
input: AT Raw Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
EXT4-fs (sda): warning: mounting unchecked fs, running e2fsck is recommended
EXT4-fs (sda): mounted filesystem without journal. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 8:0.
Freeing prom memory: 376k freed
Freeing prom memory: 60k freed
Freeing prom memory: 4k freed
Freeing unused kernel memory: 184K
This architecture does not have kernel memory protection.
Run /bin/sh as init process
VDMA: Channel 0: Address error!
VDMA: Channel 0: Memory error!

The patches may be found at,

https://github.com/fthain/linux/commits/magnum 
https://github.com/fthain/linux/commits/mac68k
https://github.com/fthain/qemu/commits/sonic

I'll post them when I've finished testing.

