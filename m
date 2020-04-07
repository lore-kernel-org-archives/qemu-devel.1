Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B9020731
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuQ04LqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B9020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmGI-0004MP-6Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jLmFP-00035l-53
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jLmFN-0002He-LD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:18:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:34138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jLmFN-0002Gs-FP; Tue, 07 Apr 2020 07:18:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id a23so1140425plm.1;
 Tue, 07 Apr 2020 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CF3gOlnW99ViW50A0bylsf/xaCeuOWODgCFdEY0Qavg=;
 b=NuQ04LqGKKrf19B7891wEdqkIO6xuM1G14oOrogDuZeB2ar1RI5RcuT4nZUCJ7DQaz
 IqJ8Mav/H9PZTUKRKnbagijtlbBUkmClprOD9UkwomhAM+pufeNk6EdkzMjqJjCcBDXe
 3GTpAaVC280cSRGS+OhJ52sJGIqCxi/Q2RB2ggu9qYt6pOZBe6up+/AvBGpIzsf8lVc7
 ZoKzYIZ5rEWjJxrF2Ta2SgSTKoaKlcAjGEBzkVORKeHduyPX/us15IZtBmaHLddGlLhp
 mPM4TwfXnGFmeL23ell+cpiy0t+RMRp2Ls0a8jQagdD8yFJNghXlw4u1D+vlsDnf4CJs
 KSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CF3gOlnW99ViW50A0bylsf/xaCeuOWODgCFdEY0Qavg=;
 b=Pyl53imW1Y9cSHMmlo8a+aLjWBwRReI2RvUlQJ9FwAbiHtnx6zWbBPAIein+Fooi0r
 PhQDConK4I0bAo5fT/b0dxpkixKrDd9OLFbL/JE3thROx6qHBgavUrbU9KwDPIrP6bHX
 8Hj7C3E8ZxrsxSHEpo9b/nty6DkEHZW0u7wKNu9LmAHT7r5A49zSodJ9em/Xuy1Z2/Ak
 5czArLt6jV4ymzz1tZ40lVMcMPP/8JEJoHFRL37aubCyLuxihpQpfvBgsz8t9DyMnZQf
 bDaPLH194aeShnYq+xR3uE6F0KgDDXJROALsMmjPM5VTGZaPvJBJryu83v4304bE5DyM
 uIoA==
X-Gm-Message-State: AGi0PuYKMjUpNnhP17xnPsm87vR3NQRgcDGEJcuA76jn0ncScHFFhML5
 QyfzBiUab7Kiy75TigBTF60=
X-Google-Smtp-Source: APiQypLhCWoQpqUXTfDUl2I7BbtHdCbstP9BwjKupGzIMAEJIHh8iYRjXEoI1RBkZ+59OINeDL0lQA==
X-Received: by 2002:a17:90a:2489:: with SMTP id
 i9mr2040804pje.183.1586258304133; 
 Tue, 07 Apr 2020 04:18:24 -0700 (PDT)
Received: from hyd1358.marvell.com ([115.113.156.2])
 by smtp.googlemail.com with ESMTPSA id
 s137sm14357855pfs.45.2020.04.07.04.18.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Apr 2020 04:18:23 -0700 (PDT)
From: sundeep.lkml@gmail.com
To: jasowang@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [Qemu devel PATCH v3 0/3] Add SmartFusion2 EMAC block
Date: Tue,  7 Apr 2020 16:45:31 +0530
Message-Id: <1586258134-6932-1-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

This patch set emulates Ethernet MAC block
present in Microsemi SmartFusion2 SoC.

v3:
  Added SmartFusion2 ethernet test to tests/acceptance
v2:
  No changes. Fixed Signed-off mail id in patch 2/2

Testing:

1. Download u-boot.bin, uImage and msf2-devkit.dtb from
   https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
2. Copy uImage and msf2-devkit.dtb to suitable Qemu tftp directory
3. Launch Qemu by
   ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio -kernel \
   u-boot.bin -display none -nic user,tftp=<qemu tftp directory>

Example:
./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio -kernel u-boot -display none -nic user,tftp=/home/hyd1358/qemu_tftp

U-Boot 2010.03-00000-ga7695d6 (Apr 04 2020 - 15:07:27)

CPU  : SmartFusion2 SoC (Cortex-M3 Hard IP)
Freqs: CORTEX-M3=142MHz,PCLK0=71MHz,PCLK1=71MHz
Board: M2S-FG484-SOM Rev 1A, www.emcraft.com
DRAM:  64 MB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   M2S_MAC

Hit any key to stop autoboot:  3  0 

M2S-FG484-SOM> run netboot
Using M2S_MAC device
TFTP from server 10.0.2.2; our IP address is 10.0.2.15
Filename 'uImage'.
Load address: 0xa0007fc0
Loading: *#################################################################
 #################################################################
 #################################################################
 ###############################################################
done
Bytes transferred = 3681568 (382d20 hex)
Using M2S_MAC device
TFTP from server 10.0.2.2; our IP address is 10.0.2.15
Filename 'msf2-devkit.dtb'.
Load address: 0xa0000200
Loading: *#
done
Bytes transferred = 1712 (6b0 hex)
## Booting kernel from Legacy Image at a0007fc0 ...
   Image Name:   
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3681504 Bytes =  3.5 MB
   Load Address: a0008000
   Entry Point:  a0008001
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-gb0e5502-dirty (hyd1358@hyd1358) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-189) ) #85 PREEMPT Sat Apr 4 23:26:40 IST 2020
[    0.000000] CPU: ARMv7-M [410fc231] revision 1 (ARMv7M), cr=00000000
[    0.000000] CPU: unknown data cache, unknown instruction cache
[    0.000000] Machine model: Microsemi SmartFusion 2 development board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: console=ttyS0,115200n8 panic=10 mem=64M@0xa0000000 earlyprintk
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 61212K/65536K available (1612K kernel code, 75K rwdata, 680K rodata, 1224K init, 120K bss, 4324K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0x00000000 - 0x00001000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
[    0.000000]     lowmem  : 0xa0000000 - 0xa4000000   (  64 MB)
[    0.000000]     modules : 0xa0000000 - 0xa0800000   (   8 MB)
[    0.000000]       .text : 0xa0008000 - 0xa02453e8   (2293 kB)
[    0.000000]       .init : 0xa0246000 - 0xa0378000   (1224 kB)
[    0.000000]       .data : 0xa0378000 - 0xa038ace0   (  76 kB)
[    0.000000]        .bss : 0xa038ace0 - 0xa03a8ea0   ( 121 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
.
.
.
[    0.445184] Found M2S MAC at 0x40041000, irq 18
[    0.448810] libphy: msf2 MII bus: probed
[    0.527047] ipip: IPv4 over IPv4 tunneling driver
[    0.532367] NET: Registered protocol family 10
[    0.542307] sit: IPv6 over IPv4 tunneling driver
[    0.544655] NET: Registered protocol family 17
[    0.565395] Freeing unused kernel memory: 1224K (a0246000 - a0378000)
init started: BusyBox v1.31.1 (2020-01-25 20:01:06 IST)
starting pid 26, tty '': '/etc/rc'
starting pid 31, tty '/dev/ttyS0': '/bin/hush -i'


BusyBox v1.31.1 (2020-01-25 20:01:06 IST) hush - the humble shell
Enter 'help' for a list of built-in commands.

/ # ifconfig eth0 10.0.2.15
[   11.116091] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
/ # [   11.653634] eth0: link up (100/full)
[   11.655246] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

/ # ls
dev   proc  sys   etc   usr   bin   tmp   sbin  mnt   init
/ # tftp -gr uImage 10.0.2.2
[   40.780983] random: nonblocking pool is initialized
/ # ls
dev     sys     usr     tmp     mnt     uImage
proc    etc     bin     sbin    init
/ #    


Subbaraya Sundeep (3):
  hw/net: Add Smartfusion2 emac block
  msf2: Add EMAC block to SmartFusion2 SoC
  tests/boot_linux_console: Add ethernet test to SmartFusion2

 MAINTAINERS                            |   2 +
 hw/arm/msf2-soc.c                      |  21 +-
 hw/net/Makefile.objs                   |   1 +
 hw/net/msf2-emac.c                     | 556 +++++++++++++++++++++++++++++++++
 include/hw/arm/msf2-soc.h              |   3 +
 include/hw/net/msf2-emac.h             |  50 +++
 tests/acceptance/boot_linux_console.py |  15 +-
 7 files changed, 642 insertions(+), 6 deletions(-)
 create mode 100644 hw/net/msf2-emac.c
 create mode 100644 include/hw/net/msf2-emac.h

-- 
2.7.4


