Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8139DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4859120CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUA5AA6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4859120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzvg-0008Ho-VB
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuD-0006aC-3q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuB-0002cS-55
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:00 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igzuA-0002Ye-UY; Mon, 16 Dec 2019 18:35:59 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c14so9329476wrn.7;
 Mon, 16 Dec 2019 15:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Wav2pjXl3otXM3BwbFA/bmO08NBIfisFM3zxLr/OPUs=;
 b=CUA5AA6SEUw7Takj8G3p4nF+CEifgrSAbByJrCwCyXD8oUl/IV2UAHsDnQNal7UG0v
 hcXaBfJ+6YWqYVb99NVdByLAl3JBN7oj50BGeHHQU0gKo0GFg7cSmlU0qouBYk9yJgIS
 8e9jG6xwrNFxOPdBODcu63m0XKB0xoRpqmWa9wk5AjuI89SA0J2uCsVpOC/hsRPSKY3n
 n3QMwV7I6XlL32JOfeFBM4j2JfHJX3jOu/X3xFBZJpq01KU9xQKCskMF3bMO/cNPrSym
 qeCmLP4icMxbh/5qR3YjwvNBt5+vWunNCJRQFFJ3+FJ6SSFgeIk9y8gGQgyJerZQzLXf
 xAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Wav2pjXl3otXM3BwbFA/bmO08NBIfisFM3zxLr/OPUs=;
 b=iT3RcWQtBNu7IJX6qPsHPfOM2BGZVHxOfRybv93TTmZdywQx1E6YyoTY0kOb55q5QQ
 MAO4ZVQQomTjdtVgJH7nChY+ujaaDqZjZG1f5HCXApZyhthSE2y7ZVoJ6Vvn3w7ktgLu
 TJyBmGDJU226oInQzKudmmeunXS4RQtjTO//TyZed4RoOHSuGThJhvaGj/mX94qYrEgr
 /5SWjzxhFca5E9z7rusgtpJlx7dtyUVtHWee97XRPMIu9P3HOC2zr0JY1Njoh96Ao9Aa
 CrC0Vzm4jamd+dI0jgZVZVBw19E384teNj2NFx4dwc4h38ukSkVruJqiQb6SaKrlApiH
 MIEg==
X-Gm-Message-State: APjAAAXiJoeqnbfr+Z6FljT03jQTXtxzGEPN4y6J05zokpvRcGwct94E
 FX37bSOX32OuikWteLTTrMKGcu48
X-Google-Smtp-Source: APXvYqwoN+JZvzk1J1lkA5N1mbsz18j89puD/P08SKK00AQveP86ykC2vYqOWvw1lPHyS7Ux1/9KEA==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr34928864wru.6.1576539356224; 
 Mon, 16 Dec 2019 15:35:56 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z83sm984501wmg.2.2019.12.16.15.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 15:35:55 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
Date: Tue, 17 Dec 2019 00:35:09 +0100
Message-Id: <20191216233519.29030-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU developers,

Hereby I would like to contribute the following set of patches to QEMU
which add support for the Allwinner H3 System on Chip and the
Orange Pi PC machine. The following features and devices are supported:

 * SMP (Quad Core Cortex A7)
 * Generic Interrupt Controller configuration
 * SRAM mappings
 * Timer device (re-used from Allwinner A10)
 * UART
 * SD/MMC storage controller
 * EMAC ethernet connectivity
 * USB 2.0 interfaces
 * Clock Control Unit
 * System Control module
 * Security Identifier device

Functionality related to graphical output such as HDMI, GPU,
Display Engine and audio are not included. Recently released
mainline Linux kernels (4.19 up to latest master) and mainline U-Boot
are known to work. The SD/MMC code is tested using bonnie++ and
various tools such as fsck, dd and fdisk. The EMAC is verified with iperf3
using -netdev socket.

To build a Linux mainline kernel that can be booted by the Orange Pi PC
machine, simply configure the kernel using the sunxi_defconfig configuration:
 $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make mrproper
 $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make sunxi_defconfig

To be able to use USB storage, you need to manually enable the corresponding
configuration item. Start the kconfig configuration tool:
 $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make menuconfig

Navigate to the following item, enable it and save your configuration:
 Device Drivers > USB support > USB Mass Storage support

Build the Linux kernel with:
 $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j5

To boot the newly build linux kernel in QEMU with the Orange Pi PC machine, use:
 $ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \
     -kernel /path/to/linux/arch/arm/boot/zImage \
     -append 'console=ttyS0,115200' \
     -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb

Note that this kernel does not have a root filesystem. You may provide it
with an official Orange Pi PC image [1] either as an SD card or as
USB mass storage. To boot using the Orange Pi PC Debian image on SD card,
simply add the -sd argument and provide the proper root= kernel parameter:
 $ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \
     -kernel /path/to/linux/arch/arm/boot/zImage \
     -append 'console=ttyS0,115200 root=/dev/mmcblk0p2' \
     -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
     -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img

Alternatively, you can also choose to build and boot a recent buildroot [2]
using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.
To attach an USB mass storage device to the machine, simply append to the command:
 -drive if=none,id=stick,file=myimage.img \
 -device usb-storage,bus=usb-bus.0,drive=stick

U-Boot mainline can be build and configured using the orangepi_pc_defconfig
using similar commands as describe above for Linux. To start U-Boot using
the Orange Pi PC machine, provide the u-boot binary to the -kernel argument:
 $ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \
     -kernel /path/to/uboot/u-boot -sd disk.img

Use the following U-boot commands to load and boot a Linux kernel from SD card:
 -> setenv bootargs console=ttyS0,115200
 -> ext2load mmc 0 0x42000000 zImage
 -> ext2load mmc 0 0x43000000 sun8i-h3-orangepi-pc.dtb
 -> bootz 0x42000000 - 0x43000000

Looking forward to your review comments. I will do my best
to update the patches where needed.

===== CHANGELOG =====

v2:
 * hw/arm/allwinner-h3.c: use cpus array in AwH3State instead of object_new()
 * hw/arm/allwinner-h3.c: use error_abort in aw_h3_realize()
 * hw/arm/allwinner-h3.c: use qdev_init_nofail() in aw_h3_realize()
 * hw/arm/allwinner-h3.c: use qdev_get_gpio_in() instead of irq array
 * hw/arm/allwinner-h3.c: add all missing unimplemented devices (memory map is complete)
 * hw/arm/allwinner-h3.c: add UART1, UART2, UART3 and remove 'if (serial_hd(...))'
 * hw/arm/allwinner-h3.c: remove sysbusdev variable and use SYS_BUS_DEVICE() directly
 * include/hw/arm/allwinner-h3.h: move PPI/SPI defines to allwinner-h3.c as enum
 * include/hw/arm/allwinner-h3.h: replace mem base/size defines with enum and memmap (like aspeed_soc.h)
 * hw/arm/orangepi.c: Only allow Cortex-A7 in machine->cpu_type
 * hw/arm/orangepi.c: Set mc->default_cpu_type to ARM_CPU_TYPE_NAME("cortex-a7")
 * hw/arm/orangepi.c: Use error_abort in orangepi_init()
 * hw/arm/orangepi.c: only allow maximum 1GiB RAM
 * hw/arm/orangepi.c: renamed machine name to 'orangepi-pc'
 * hw/arm/orangepi.c: remove mc->ignore_memory_transaction_failures = true
 * hw/arm/orangepi.c: remove unnecessary check for 'sd-bus'
 * hw/net/allwinner-h3-emac.c: use AW_H3_EMAC() for opaque in read/write functions
 * hw/sd/allwinner-h3-sdhost.c: replace register defines with enums
 * hw/sd/allwinner-h3-sdhost.c: remove 'irq_en' and use if() to set 'irq' in update_irq function
 * hw/sd/allwinner-h3-sdhost.c: simplified if (rlen==) conditions in send_command function
 * hw/sd/allwinner-h3-sdhost.c: use KiB macro to set desc->size
 * hw/sd/allwinner-h3-sdhost.c: use ARRAY_SIZE() macro in reset function
 * hw/misc/allwinner-h3-sid.c: replace randomized identifier with QemuUUID property
 * hw/misc/allwinner-h3-sid.c: add tracing for read/write functions
 * hw/misc/allwinner-h3-sid.c: fix incorrect usage of REG_PRCTL_OP_LOCK/REG_PRCTL_WRITE
 * hw/misc/trace-events: add allwinner_h3_cpucfg* entries in correct patch (#7)
 * hw/*/trace-events: use PRIu32/PRIx32 macros for size and max fields
 * hw/*/allwinner-h3-*.c: set .impl.min_access_size = 4 to restrict MMIO access to 32-bit aligned
 * hw/*/allwinner-h3-*.c: replace register defines with enums
 * hw/*/allwinner-h3-*.c: set VMStateDescription.name with inline string (dont use TYPE macro)
 * include/hw/*/allwinner-h3-*.h: remove MEM_SIZE define and use size inline in the source file
 * target/arm/arm-powerctl.c: invoke arm_rebuild_hflags() after setting CP15 bits

With kind regards,

Niek Linnenbank

[1] http://www.orangepi.org/downloadresources/
[2] https://buildroot.org/download.html
[3] https://www.armbian.com/orange-pi-pc/

Niek Linnenbank (10):
  hw: arm: add Allwinner H3 System-on-Chip
  hw: arm: add Xunlong Orange Pi PC machine
  arm: allwinner-h3: add Clock Control Unit
  arm: allwinner-h3: add USB host controller
  arm: allwinner-h3: add System Control module
  arm/arm-powerctl: rebuild hflags after setting CP15 bits in
    arm_set_cpu_on()
  arm: allwinner-h3: add CPU Configuration module
  arm: allwinner-h3: add Security Identifier device
  arm: allwinner-h3: add SD/MMC host controller
  arm: allwinner-h3: add EMAC ethernet device

 default-configs/arm-softmmu.mak       |   1 +
 hw/usb/hcd-ehci.h                     |   1 +
 include/hw/arm/allwinner-h3.h         |  93 +++
 include/hw/misc/allwinner-h3-clk.h    |  40 ++
 include/hw/misc/allwinner-h3-cpucfg.h |  42 ++
 include/hw/misc/allwinner-h3-sid.h    |  40 ++
 include/hw/misc/allwinner-h3-syscon.h |  42 ++
 include/hw/net/allwinner-h3-emac.h    |  67 +++
 include/hw/sd/allwinner-h3-sdhost.h   |  71 +++
 hw/arm/allwinner-h3.c                 | 442 ++++++++++++++
 hw/arm/orangepi.c                     | 127 ++++
 hw/misc/allwinner-h3-clk.c            | 238 ++++++++
 hw/misc/allwinner-h3-cpucfg.c         | 288 +++++++++
 hw/misc/allwinner-h3-sid.c            | 179 ++++++
 hw/misc/allwinner-h3-syscon.c         | 146 +++++
 hw/net/allwinner-h3-emac.c            | 829 ++++++++++++++++++++++++++
 hw/sd/allwinner-h3-sdhost.c           | 813 +++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c              |  17 +
 target/arm/arm-powerctl.c             |   3 +
 MAINTAINERS                           |   8 +
 hw/arm/Kconfig                        |   9 +
 hw/arm/Makefile.objs                  |   1 +
 hw/misc/Makefile.objs                 |   4 +
 hw/misc/trace-events                  |   9 +
 hw/net/Kconfig                        |   3 +
 hw/net/Makefile.objs                  |   1 +
 hw/net/trace-events                   |  10 +
 hw/sd/Makefile.objs                   |   1 +
 hw/sd/trace-events                    |   7 +
 29 files changed, 3532 insertions(+)
 create mode 100644 include/hw/arm/allwinner-h3.h
 create mode 100644 include/hw/misc/allwinner-h3-clk.h
 create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h
 create mode 100644 include/hw/misc/allwinner-h3-sid.h
 create mode 100644 include/hw/misc/allwinner-h3-syscon.h
 create mode 100644 include/hw/net/allwinner-h3-emac.h
 create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
 create mode 100644 hw/arm/allwinner-h3.c
 create mode 100644 hw/arm/orangepi.c
 create mode 100644 hw/misc/allwinner-h3-clk.c
 create mode 100644 hw/misc/allwinner-h3-cpucfg.c
 create mode 100644 hw/misc/allwinner-h3-sid.c
 create mode 100644 hw/misc/allwinner-h3-syscon.c
 create mode 100644 hw/net/allwinner-h3-emac.c
 create mode 100644 hw/sd/allwinner-h3-sdhost.c

-- 
2.17.1


