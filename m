Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96892075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96892075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzuH-0000np-21
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juztK-00080w-UU
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:57:14 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:55701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juztI-0006wA-48
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:57:14 -0400
Received: from player795.ha.ovh.net (unknown [10.108.57.49])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 558FB1E11E1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 16:57:08 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 680E6142DC8CC;
 Mon, 13 Jul 2020 14:57:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001f96fcc40-627d-4d4c-8dbf-4367d235ca7f,29C60B8BFD44B6CD822E82BF6A6060F4508BB267)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org,
 f4bug@amsat.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
Date: Mon, 13 Jul 2020 16:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709003608.3834629-11-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8521654920742800297
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.165.38; envelope-from=clg@kaod.org;
 helo=6.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 10:57:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
> one built with OpenBMC. For example like this:
> 
> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
> qemu-system-arm -machine quanta-gsj -nographic \
> 	-bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
> 	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

May be we don't need to create the flash object if dinfo is NULL.


Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>

Nice ! 

We need a SPI controller model and a network device model now. 

npcm7xx_bootrom.bin is a bit of a pain. Could we include it in 
the QEMU roms ? 

C.





>================================================
> BootBlock by Nuvoton Technology Corp. Ver 10.10.9
>================================================

BB Basic
Oct 27 2019
10:10:49
 
 


>CORSTC         = 0x04000003=>0x4fff9f9d
>WD0RCR         = 0xffffffff=>0x4fff9f9d
>WD1RCR         = 0xffffffff=>0x4fff9f9d
>WD2RCR         = 0xffffffff=>0x4fff9f9d
>SWRSTC1        = 0x00000003=>0x4fff9f9d
>SWRSTC2        = 0x00000000=>0x4fff9f9d
>SWRSTC3        = 0x00000000=>0x4fff9f9d
>SWRSTC4        = 0x00000000=>0x4fff9f9d
>CLKEN1         = 0xffffffff
>CLKEN2         = 0xffffffff
>CLKEN3         = 0xffffffff
>CLKSEL         = 0x004aaaaa=>0x01f18fc9
>CLKDIV1        = 0x5413f855=>0x5413fa55
>CLKDIV2        = 0xaa4f8f9f=>0xeb4f8f9f
>CLKDIV3        = 0x00000100=>0x0000027e
>PLLCON0        = 0x80222101=>0x80202101
>PLLCON1        = 0x80202101=>0x80402101
>PLLCON2        = 0x80c02105
>VSRCR          = 0x00000000
>INTCR2         = 0x00080000=>0x000c0000
>RESSR          = 0x80000000
>MFSEL1         = 0x00000000=>0x00000a00
>MFSEL2         = 0x00000000
>MFSEL3         = 0x00000000
>MFSEL4         = 0x00000000
>DSCNT          = 0x000000c0
>SMC_CTL        = 0x00000000
>GPnDOUT(7)     = 0x00000000
>GPnOE(7)       = 0x00000000
>FIU_DRD_CFG    = 0x030011bb
>FIU_DWR_CFG    = 0x03000002
>FIU_CFG(0)     = 0x0000000b
>FIU_CFG(3)     = 0x0000000b
>FLOCKR1        = 0x00000000
>RLOCKR1        = 0x00000000
>FCFG1          = 0x20000000=>0x1a000000
>FCFG2          = 0x20000000=>0x1a000000
>MDLR           = 0x00300395
>SPSWC          = 0x00000003=>0x00000000
>LCR(2)         = 0x00000000
>LCR(3)         = 0x00000000
>IPSRST2        = 0x80000000
>PWRON          = 0x00001fff
>ETSR           = 0x00000000
>FUSTRAP        = 0x00000000
>SCRPAD         = 0x00000000

>OTP values:
>FINAL_TEST_SIGNATURE (Product OTP)   =  0x00000000 0x00000000
>FUSTRAP                              =  0x00000000
>CP_FUSTRAP                           =  0x00000000
>DAC_CALIB                            =  0x00000000
>ADC_CALIB                            =  0x00000000
>DIE_LOCATION                         =  0x00000000
>DERIVATIVE                           =  0x00300395

>Device: Poleg BMC NPCM730

>set INTCR3_GFXRDEN and INTCR3_GFXRSTDLY
>INTCR          = 0x0000035e=>0x0004831e
>INTCR2         = 0x00080000
>INTCR3         = 0x00001202=>0x06001252
>EB
>Board manufacturer: Nuvoton 

> CPU CLK is 800000000 Hz   (header val is 800000000 Hz )
> MC  CLK is 800000000 Hz   (header val is 800000000 Hz )

>PLL0 = 800MHz 
>PLL1 = 800MHz 
>PLL2 = 480MHz 
>APB1 = 25MHz  
>APB2 = 50MHz 
>APB3 = 50MHz 
>APB4 = 25MHz 
>APB5 = 100MHz 
>SPI0 = 20MHz 
>SPI3 = 20MHz 
>ADC  = 25MHz 
>CP   = 200MHz 
>TMC  = 25MHz 
>GFX  = 160MHz 
>PCI  = 133MHz 


> PLLs were not reconfigured by BB
>Last reset was PORST 
>vgaioen=0 and don't mux gspi.

>HOST IF: LPC
>Host LPC Released>MC already configured.

>Skip DDR init.
>Basic mode


bootblock at 0x80000000, uboot at 0x8000e000, image num 0
>set FIU0 FIU_DRD_CFG to  0x30111bc 

>copied uboot image to 0x8000, size 0x620f0, from 0x8000e000 

>ROM mailbox status :  ST_ROM_NO_STATUS                            

>imageState: 		img0=  IMAGE_NOT_TESTED             img1=  IMAGE_NOT_TESTED             img2= IMAGE_NOT_TESTED             

>BB mailbox status :  ST_ROM_NO_STATUS                            
>imageState: 		img0=  IMAGE_NOT_TESTED             img1=  IMAGE_NOT_TESTED             img2= IMAGE_NOT_TESTED             
>Boot block run for 277403 us.

>Jump to uboot at 0x8000


U-Boot 2019.01 (Jun 15 2020 - 08:23:29 +0000)

CPU: NPCM7XX A1 @ Model: Nuvoton npcm750 Development Board
Board: Nuvoton npcm750 Development Board
DRAM:  464 MiB
l2_pl310_init
OTP: NPCM750 module bind OK
RNG: NPCM750 RNG module bind OK
AES: NPCM750 AES module bind OK
SHA: NPCM750 SHA module bind OK
MMC:   sdhci_setup_cfg: Hardware doesn't specify base clock frequency
sdhci1@f0842000 - probe failed: -22
sdhci_setup_cfg: Hardware doesn't specify base clock frequency

Loading Environment from SPI Flash... SF: Detected mx25l25635f with page size 256 Bytes, erase size 64 KiB, total 32 MiB, mapped at 80000000
*** Warning - bad CRC, using default environment

In:    serial0@f0001000
Out:   serial0@f0001000
Err:   serial0@f0001000
Net:   
Error: gmac0@f0802000 address not set.
eth-1: gmac0@f0802000
Error: gmac1@f0804000 address not set.
, eth-1: gmac1@f0804000
Error: emc0@f0825000 address not set.
, eth-1: emc0@f0825000
Error: emc1@f0825000 address not set.
, eth-1: emc1@f0825000
Security is NOT enabled
SF: Detected mx25l25635f with page size 256 Bytes, erase size 64 KiB, total 32 MiB, mapped at 80000000
Hit any key to stop autoboot:  0 
Booting Kernel from flash
+++ uimage at 0x80200000
Using bootargs: earlycon=uart8250,mmio32,0xf0001000 root=/dev/ram console=ttyS0,115200n8 mem=464M ramdisk_size=48000 basemac=
## Loading kernel from FIT Image at 80200000 ...
   Using 'conf@nuvoton-npcm730-gsj.dtb' configuration
   Trying 'kernel@1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x80200124
     Data Size:    3049504 Bytes = 2.9 MiB
     Architecture: ARM
     OS:           Linux
     Load Address: 0x00008000
     Entry Point:  0x00008000
     Hash algo:    sha256
     Hash value:   2c3b4ad63288300ab380774501a930b5a55683df90f1f23b9329393187194865
   Verifying Hash Integrity ... sha256+ OK
## Loading ramdisk from FIT Image at 80200000 ...
   Using 'conf@nuvoton-npcm730-gsj.dtb' configuration
   Trying 'ramdisk@1' ramdisk subimage
     Description:  obmc-phosphor-initramfs
     Type:         RAMDisk Image
     Compression:  uncompressed
     Data Start:   0x804f1814
     Data Size:    1097672 Bytes = 1 MiB
     Architecture: ARM
     OS:           Linux
     Load Address: unavailable
     Entry Point:  unavailable
     Hash algo:    sha256
     Hash value:   7a8ac1c81726efb38ec4ee2db0c6291e9788b7a13c4de158644ad912537fe008
   Verifying Hash Integrity ... sha256+ OK
## Loading fdt from FIT Image at 80200000 ...
   Using 'conf@nuvoton-npcm730-gsj.dtb' configuration
   Trying 'fdt@nuvoton-npcm730-gsj.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x804e8a58
     Data Size:    36079 Bytes = 35.2 KiB
     Architecture: ARM
     Hash algo:    sha256
     Hash value:   cbc6ffb46a6f195e59ed86e9596424df5dc022c807f221487f970faa321f2cd6
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0x804e8a58
   Loading Kernel Image ... OK
   Loading Ramdisk to 012f4000, end 013fffc8 ... OK
   Loading Device Tree to 012e8000, end 012f3cee ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 5.4.32-7dc9442 (oe-user@oe-host) (gcc version 10.1.0 (GCC)) #1 SMP Thu Jun 25 06:55:32 UTC 2020
CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
OF: fdt: Machine model: Quanta GSJ Board (Device Tree v12)
earlycon: uart8250 at MMIO32 0xf0001000 (options '')
printk: bootconsole [uart8250] enabled
Memory policy: Data cache writeback
CPU: All CPU(s) started in SVC mode.
percpu: Embedded 18 pages/cpu s43724 r8192 d21812 u73728
Built 1 zonelists, mobility grouping on.  Total pages: 117856
Kernel command line: earlycon=uart8250,mmio32,0xf0001000 root=/dev/ram console=ttyS0,115200n8 mem=464M ramdisk_size=48000 basemac=
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 456772K/475136K available (7168K kernel code, 457K rwdata, 1780K rodata, 1024K init, 2151K bss, 18364K reserved, 0K cma-reserved)
ftrace: allocating 25188 entries in 50 pages
rcu: Hierarchical RCU implementation.
rcu: 	RCU event tracing is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 1 lines
L2C-310 dynamic clock gating disabled, standby mode disabled
L2C-310 cache controller enabled, 16 ways, 512 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76450001
random: get_random_bytes called from start_kernel+0x2bc/0x458 with crng_init=0
clocksource: npcm7xx-timer1: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 597268854 ns
Enabling NPCM7xx clocksource timer base: cd80a000, IRQ: 17 
Console: colour dummy device 80x30
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
Calibrating delay loop... 1515.11 BogoMIPS (lpj=7575552)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x100000 - 0x100060
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU1: Spectre v2: using BPIALL workaround
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (3174.80 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 512 (order: 3, 32768 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
NPCM7xx Pinctrl driver probed
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
clocksource: Switched to clocksource npcm7xx-timer1
thermal_sys: Registered thermal governor 'step_wise'
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes, linear)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 1072K
workingset: timestamp_bits=30 max_order=17 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Key type cifs.idmap registered
jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
NET: Registered protocol family 38
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
io scheduler mq-deadline registered
io scheduler kyber registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
printk: console [ttyS0] disabled
f0001000.serial: ttyS0 at MMIO 0xf0001000 (irq = 29, base_baud = 1500000) is a Nuvoton 16550
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [uart8250] disabled
printk: bootconsole [uart8250] disabled
f0002000.serial: ttyS1 at MMIO 0xf0002000 (irq = 30, base_baud = 1500000) is a Nuvoton 16550
f0003000.serial: ttyS2 at MMIO 0xf0003000 (irq = 31, base_baud = 1500000) is a Nuvoton 16550
f0004000.serial: ttyS3 at MMIO 0xf0004000 (irq = 32, base_baud = 1500000) is a Nuvoton 16550
brd: module loaded
loop: module loaded
NPCM7xx PCI Mailbox probed
spi_master spi0: /ahb/fiu@fb000000/spi-nor@0 has no valid 'spi-max-frequency' property (-22)
spi_master spi0: Failed to create SPI device for /ahb/fiu@fb000000/spi-nor@0
libphy: Fixed MDIO Bus: probed
8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffffe
pgd = (ptrval)
[fffffffe] *pgd=1cfff841, *pte=00000000, *ppte=00000000
Internal error: Oops: 27 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.32-7dc9442 #1
Hardware name: NPCM7XX Chip family
PC is at get_mac_address.constprop.0+0x30/0xb8
LR is at 0x4
pc : [<b0521614>]    lr : [<00000004>]    psr: a0000013
sp : cc0bbd08  ip : 00000000  fp : cc0bbd24
r10: 00000001  r9 : cc218888  r8 : cc218500
r7 : cc1aa410  r6 : cc1aa400  r5 : 00000000  r4 : cc218000
r3 : cc44d108  r2 : 00000000  r1 : cc1aa42c  r0 : fffffffe
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 00004059  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xcc0bbd08 to 0xcc0bc000)
bd00:                   cc218000 00000000 cc1aa400 cc1aa410 cc0bbd64 cc0bbd28
bd20: b0522964 b05215f0 00000000 00000000 00000000 b0d854b4 b0b44a94 00000000
bd40: cc1aa410 b0b44a94 00000000 b0d854b4 b0b44a94 b0b683a0 cc0bbd84 cc0bbd68
bd60: b04b5cb4 b0522638 cc1aa410 b0d854b0 00000000 00000000 cc0bbdc4 cc0bbd88
bd80: b04b309c b04b5c68 b0b44a94 cc1aa410 cc1aa504 00000000 cc0bbdc4 cc1aa410
bda0: b0b44a94 cc1aa454 b0b44a94 b0a00510 b0a53854 b0a78aa8 cc0bbdf4 cc0bbdc8
bdc0: b04b3860 b04b2e90 cc1aa410 b0b44a94 cc1aa410 cc1aa410 00000000 cc1aa454
bde0: b0b44a94 b0a00510 cc0bbe14 cc0bbdf8 b04b3bac b04b3758 00000000 b0b44a94
be00: cc1aa410 b0b3dd20 cc0bbe34 cc0bbe18 b04b3d38 b04b3b40 00000000 b0b44a94
be20: b04b3be8 b0b3dd20 cc0bbe64 cc0bbe38 b04b0c14 b04b3bf4 cc45bb80 cc08ac58
be40: cc1abcb4 b0b03e08 cc0bbe74 b0b44a94 cc45bb80 00000000 cc0bbe74 cc0bbe68
be60: b04b2748 b04b0bb0 cc0bbe9c cc0bbe78 b04b213c b04b2728 b093d1b0 b078a5a8
be80: b0b44a94 00000000 ffffe000 00000000 cc0bbeb4 cc0bbea0 b04b4940 b04b2020
bea0: b0b3dd20 b0a2dd84 cc0bbecc cc0bbeb8 b04b5c04 b04b4870 b0b5eb00 b0a2dd84
bec0: cc0bbedc cc0bbed0 b0a2dda8 b04b5bc0 cc0bbf4c cc0bbee0 b0102d80 b0a2dd90
bee0: 00000006 00000000 b0a00510 b0b03e00 b08e51fc b08e521c b08e5248 b0a00510
bf00: 00000000 00000006 00000006 000000ba cc0bbf34 ccc3d465 ccc3d46d b0b03e08
bf20: b09bbac4 00000007 b0b72700 b0b03e08 00000007 b0b72700 b0a53834 b09bbac4
bf40: cc0bbf94 cc0bbf50 b0a01280 b0102cbc 00000006 00000006 00000000 b0a00510
bf60: ffffe000 000000ba cc0bbf8c 00000000 b0794eb4 00000000 00000000 00000000
bf80: 00000000 00000000 cc0bbfac cc0bbf98 b0794ecc b0a01130 00000000 b0794eb4
bfa0: 00000000 cc0bbfb0 b01010e8 b0794ec0 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Backtrace: 
[<b05215e4>] (get_mac_address.constprop.0) from [<b0522964>] (npcm7xx_ether_probe+0x338/0x4d0)
 r7:cc1aa410 r6:cc1aa400 r5:00000000 r4:cc218000
[<b052262c>] (npcm7xx_ether_probe) from [<b04b5cb4>] (platform_drv_probe+0x58/0xa4)
 r10:b0b683a0 r9:b0b44a94 r8:b0d854b4 r7:00000000 r6:b0b44a94 r5:cc1aa410
 r4:00000000
[<b04b5c5c>] (platform_drv_probe) from [<b04b309c>] (really_probe+0x218/0x4c8)
 r7:00000000 r6:00000000 r5:b0d854b0 r4:cc1aa410
[<b04b2e84>] (really_probe) from [<b04b3860>] (driver_probe_device+0x114/0x15c)
 r10:b0a78aa8 r9:b0a53854 r8:b0a00510 r7:b0b44a94 r6:cc1aa454 r5:b0b44a94
 r4:cc1aa410
[<b04b374c>] (driver_probe_device) from [<b04b3bac>] (device_driver_attach+0x78/0xb4)
 r8:b0a00510 r7:b0b44a94 r6:cc1aa454 r5:00000000 r4:cc1aa410
[<b04b3b34>] (device_driver_attach) from [<b04b3d38>] (__driver_attach+0x150/0x158)
 r7:b0b3dd20 r6:cc1aa410 r5:b0b44a94 r4:00000000
[<b04b3be8>] (__driver_attach) from [<b04b0c14>] (bus_for_each_dev+0x70/0xd0)
 r7:b0b3dd20 r6:b04b3be8 r5:b0b44a94 r4:00000000
[<b04b0ba4>] (bus_for_each_dev) from [<b04b2748>] (driver_attach+0x2c/0x30)
 r6:00000000 r5:cc45bb80 r4:b0b44a94
[<b04b271c>] (driver_attach) from [<b04b213c>] (bus_add_driver+0x128/0x214)
[<b04b2014>] (bus_add_driver) from [<b04b4940>] (driver_register+0xdc/0x118)
 r7:00000000 r6:ffffe000 r5:00000000 r4:b0b44a94
[<b04b4864>] (driver_register) from [<b04b5c04>] (__platform_driver_register+0x50/0x58)
 r5:b0a2dd84 r4:b0b3dd20
[<b04b5bb4>] (__platform_driver_register) from [<b0a2dda8>] (npcm7xx_ether_driver_init+0x24/0x28)
 r5:b0a2dd84 r4:b0b5eb00
[<b0a2dd84>] (npcm7xx_ether_driver_init) from [<b0102d80>] (do_one_initcall+0xd0/0x260)
[<b0102cb0>] (do_one_initcall) from [<b0a01280>] (kernel_init_freeable+0x15c/0x1f4)
 r7:b09bbac4 r6:b0a53834 r5:b0b72700 r4:00000007
[<b0a01124>] (kernel_init_freeable) from [<b0794ecc>] (kernel_init+0x18/0x120)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:b0794eb4
 r4:00000000
[<b0794eb4>] (kernel_init) from [<b01010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xcc0bbfb0 to 0xcc0bbff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r5:b0794eb4 r4:00000000
Code: e5960190 eb0399cc e3500000 159431c8 (15902000) 
---[ end trace a0f295d64d5e2753 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           5.4.32-7dc9442 #1
Hardware name: NPCM7XX Chip family
Backtrace: 
[<b0107c4c>] (dump_backtrace) from [<b010823c>] (show_stack+0x20/0x24)
 r7:00000000 r6:600f0193 r5:00000000 r4:b0b5b1b8
[<b010821c>] (show_stack) from [<b077b170>] (dump_stack+0x94/0xa8)
[<b077b0dc>] (dump_stack) from [<b010a20c>] (handle_IPI+0x1f0/0x38c)
 r7:00000000 r6:00000004 r5:b0b5eb64 r4:b0b729e0
[<b010a01c>] (handle_IPI) from [<b0102264>] (gic_handle_irq+0x9c/0xa0)
 r10:00000000 r9:cc0f5f48 r8:cd803100 r7:cd802100 r6:cd80210c r5:b0b37db4
 r4:b0b04504
[<b01021c8>] (gic_handle_irq) from [<b0101a8c>] (__irq_svc+0x6c/0x90)
Exception stack(0xcc0f5f48 to 0xcc0f5f90)
5f40:                   00000000 00001764 ccc33774 b01112e0 cc0f4000 00000001
5f60: b0b03e28 b0b03e6c b0b5e72c b08e5e98 00000000 cc0f5fa4 cc0f5fa8 cc0f5f98
5f80: b0104114 b0104118 600f0013 ffffffff
 r9:cc0f4000 r8:b0b5e72c r7:cc0f5f7c r6:ffffffff r5:600f0013 r4:b0104118
[<b01040d4>] (arch_cpu_idle) from [<b014b240>] (do_idle+0xec/0x140)
[<b014b154>] (do_idle) from [<b014b56c>] (cpu_startup_entry+0x28/0x2c)
 r9:410fc090 r8:00004059 r7:b0b729e8 r6:10c0387d r5:00000001 r4:0000008a
[<b014b544>] (cpu_startup_entry) from [<b0109d7c>] (secondary_start_kernel+0x184/0x18c)
[<b0109bf8>] (secondary_start_kernel) from [<001026ec>] (0x1026ec)
 r5:00000051 r4:1c0cc059
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


