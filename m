Received: from eggs.gnu.org ([2001:4830:134:3::10]:41379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1ckR2j-0004R8-54
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1ckR2g-0007lG-Fc
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:57:25 -0500
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:35181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1ckR2g-0007kQ-9m
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:57:22 -0500
Received: by mail-qk0-x229.google.com with SMTP id v125so53300125qkh.2
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 23:57:20 -0800 (PST)
MIME-Version: 1.0
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Sun, 5 Mar 2017 08:57:19 +0100
Message-ID: <CAJy91CaOxWeGAnpSU8ETpbaWQCdp6W6heYTcr5qtKQjE9qQh5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] versatilepb cannot load roofs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear QEMU developers,

I have a problem when running qemu to build a system with versatilepb,
linux zImage and rootfs. the qemu cmdl is as follows.

../qemu/build/arm-softmmu/qemu-system-arm.exe -M versatilepb -kernel zImage
-dtb versatile-pb.dtb -initrd ramfs.gz -nographic -append "console=3DttyAMA=
0
root=3D/dev/ram0"

However, the running result is the same as the case without the initrd
file, which is "Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)".

The kernel is configured with versatile_defconfig, ramfs.gz is created by
busybox 1.25.1. I am using QEMU 2.8.50 and Linux 4.7. I've also tried with
Linux 2.6.35 and 3.2.8, and still versatilepb gives this kernel panic.

The whole booting message is in the end of the message.

I see "vpb_sic_write: Bad register offset 0x2c". Is it a qemu issue? Or
something i did is wrong or not enough?

Please help. Thanks in advance.

Best,
Jiahuan



$ ../qemu/build/arm-softmmu/qemu-system-arm.exe -M versatilepb -kernel
zImage -dtb versatile-pb.dtb -initrd ramfs.gz -nographic -append
"console=3DttyAMA0 root=3D/dev/ram0"
trying to register pipe
pipe registerd
dsound: Could not initialize DirectSoundCapture
dsound: Reason: No sound driver is available for use, or the given GUID is
not a valid DirectSound device ID
Uncompressing Linux... done, booting the kernel.
vpb_sic_write: Bad register offset 0x2c
Booting Linux on physical CPU 0x0
Linux version 4.7.0 (jiahuan@jiahuan-VirtualBox) (gcc version 4.9.3
20141031 (prerelease) (Linaro GCC 2014.11) ) #1 Fri Mar 3 09:53:20 CET 2017
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00093177
CPU: VIVT data cache, VIVT instruction cache
Machine model: ARM Versatile PB
Memory policy: Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=3DttyAMA0 root=3D/dev/ram0
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 124224K/131072K available (3321K kernel code, 115K rwdata, 920K
rodata, 156K init, 130K bss, 6848K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc042ca68   (4243 kB)
      .init : 0xc042d000 - 0xc0454000   ( 156 kB)
      .data : 0xc0454000 - 0xc0470f00   ( 116 kB)
       .bss : 0xc0470f00 - 0xc0491728   ( 131 kB)
NR_IRQS:16 nr_irqs:16 16
VIC @c8800000: id 0x00041190, vendor 0x41
FPGA IRQ chip 0 "intc" @ c8802000, 20 irqs, parent IRQ: 47
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1911260446275 ns
sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every
2147483647500ns
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
Console: colour dummy device 80x30
Calibrating delay loop... 769.63 BogoMIPS (lpj=3D3848192)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x8400 - 0x8458
VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
19112604462750000 ns
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/smc@10100000
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/mpmc@10110000
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/sctl@101e0000
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/watchdog@101e1000
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/sci@101f0000
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/ssp@101f4000
of_amba_device_create(): amba_device_add() failed (-19) for
/amba/fpga/sci@a000
Serial: AMBA PL011 UART driver
101f1000.uart: ttyAMA0 at MMIO 0x101f1000 (irq =3D 28, base_baud =3D 0) is =
a
PL011 rev1
console [ttyAMA0] enabled
101f2000.uart: ttyAMA1 at MMIO 0x101f2000 (irq =3D 29, base_baud =3D 0) is =
a
PL011 rev1
101f3000.uart: ttyAMA2 at MMIO 0x101f3000 (irq =3D 30, base_baud =3D 0) is =
a
PL011 rev1
uart-pl011 10009000.uart: aliased and non-aliased serial devices found in
device tree. Serial port enumeration may be unpredictable.
10009000.uart: ttyAMA3 at MMIO 0x10009000 (irq =3D 54, base_baud =3D 0) is =
a
PL011 rev1
clocksource: Switched to clocksource arm,sp804
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 940K (c4000000 - c40eb000)
NetWinder Floating Point Emulator V0.97 (double precision)
futex hash table entries: 256 (order: -1, 3072 bytes)
workingset: timestamp_bits=3D29 max_order=3D15 bucket_order=3D0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pl061_gpio 101e4000.gpio: PL061 GPIO chip @0x101e4000 registered
pl061_gpio 101e5000.gpio: PL061 GPIO chip @0x101e5000 registered
pl061_gpio 101e6000.gpio: PL061 GPIO chip @0x101e6000 registered
pl061_gpio 101e7000.gpio: PL061 GPIO chip @0x101e7000 registered
clcd-pl11x dev:20: PL110 rev0 at 0x10120000
clcd-pl11x dev:20: Versatile hardware, VGA display
Console: switching to colour frame buffer device 80x60
brd: module loaded
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
smc91x 10010000.net eth0: SMC91C11xFD (rev 1) at c8a66000 IRQ 41
smc91x 10010000.net eth0: Ethernet addr: 52:54:00:12:34:56
mousedev: PS/2 mouse device common for all mice
rtc-ds1307 0-0068: rtc core: registered ds1338 as rtc0
rtc-ds1307 0-0068: 56 bytes nvram
versatile reboot driver registered
mmci-pl18x fpga:05: mmc0: PL181 manf 41 rev0 at 0x10005000 irq 59,60 (pio)
mmci-pl18x fpga:0b: mmc1: PL181 manf 41 rev0 at 0x1000b000 irq 49,50 (pio)
input: AT Raw Set 2 keyboard as /devices/platform/amba/amba:fp
ga/10006000.kmi/serio0/input/input0
leds-syscon 10000000.core-module:led@08.0: registered LED versatile:0
leds-syscon 10000000.core-module:led@08.1: registered LED versatile:1
leds-syscon 10000000.core-module:led@08.2: registered LED versatile:2
leds-syscon 10000000.core-module:led@08.3: registered LED versatile:3
leds-syscon 10000000.core-module:led@08.4: registered LED versatile:4
leds-syscon 10000000.core-module:led@08.5: registered LED versatile:5
leds-syscon 10000000.core-module:led@08.6: registered LED versatile:6
leds-syscon 10000000.core-module:led@08.7: registered LED versatile:7
ledtrig-cpu: registered to indicate activity on CPUs
NET: Registered protocol family 17
rtc-ds1307 0-0068: setting system clock to 2017-03-03 09:53:29 UTC
(1488534809)
input: ImExPS/2 BYD TouchPad as /devices/platform/amba/amba:fp
ga/10007000.kmi/serio1/input/input2
List of all partitions:
0100            4096 ram0  (driver?)
0101            4096 ram1  (driver?)
0102            4096 ram2  (driver?)
0103            4096 ram3  (driver?)
0104            4096 ram4  (driver?)
0105            4096 ram5  (driver?)
0106            4096 ram6  (driver?)
0107            4096 ram7  (driver?)
0108            4096 ram8  (driver?)
0109            4096 ram9  (driver?)
010a            4096 ram10  (driver?)
010b            4096 ram11  (driver?)
010c            4096 ram12  (driver?)
010d            4096 ram13  (driver?)
010e            4096 ram14  (driver?)
010f            4096 ram15  (driver?)
No filesystem could mount root, tried:  ext2 cramfs minix romfs
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
CPU: 0 PID: 1 Comm: swapper Not tainted 4.7.0 #1
Hardware name: ARM-Versatile (Device Tree Support)
[<c001b1f4>] (unwind_backtrace) from [<c001861c>] (show_stack+0x10/0x14)
[<c001861c>] (show_stack) from [<c006f9e8>] (panic+0xb4/0x228)
[<c006f9e8>] (panic) from [<c042e1a0>] (mount_block_root+0x20c/0x284)
[<c042e1a0>] (mount_block_root) from [<c042e40c>] (mount_root+0xf8/0x124)
[<c042e40c>] (mount_root) from [<c042e598>] (prepare_namespace+0x160/0x1b4)
[<c042e598>] (prepare_namespace) from [<c042ddb4>]
(kernel_init_freeable+0x184/0x1cc)
[<c042ddb4>] (kernel_init_freeable) from [<c0329700>] (kernel_init+0x8/0xf8=
)
[<c0329700>] (kernel_init) from [<c0014e30>] (ret_from_fork+0x14/0x24)
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
