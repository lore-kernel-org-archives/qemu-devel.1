Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15025C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FAC206F0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEMvku+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FAC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtTH-00084L-Ts
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxR-0002b5-Bq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxN-0000cI-Hc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxK-0000Y6-El; Mon, 02 Dec 2019 16:10:06 -0500
Received: by mail-wm1-x342.google.com with SMTP id f4so775853wmj.1;
 Mon, 02 Dec 2019 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LEn9j1X544VOGdDqcFyPUsPjhPLUxtiH/o0b4RFTF1E=;
 b=hEMvku+HxXFrtCH1xtIajvdSr/C+PUBdv2Fet/yl+OwJEbRXojjQzZY014UAZoucjp
 VFhhRPLXdj62/117gVf8gOMHUB6iPUHYBZWi84cMlPXKoS1XITnKtaGVcCg4zjSLJ7O+
 8cd58bxvixqVo9NDEEfukoldTpx1HVpo5+qeR7CZOTKcputw/BEw3XYmQtbt96Bh0Vzw
 sHQR7jI4/5wyvBksLF96tCXh8wc3IihTX64o/GMI0hbAjhynh28rleB7zL8J5R6qvWDU
 BDy5r0GwV5r9aQ+KwiKBCVYHFffS5BL0kk3bJYuJWcs3oh6bXXOW4kQpkoE3qs4BaYuG
 sAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LEn9j1X544VOGdDqcFyPUsPjhPLUxtiH/o0b4RFTF1E=;
 b=bizGrgq9RaVWRGbNwpOYeWHkoCNJ3bAV30vNFCQlhKlcVN7rDllv/O/H7APBtjupxh
 aBKhW0hzOY210SzpABn48CIYFY2PfyOxG+D+aTYq6dKUlst3kVCkNjdRxkTqY5IbItEC
 2y5Ferqwj6O47ZEI0XP8POhxu98OUpSAQm/elwy4G8jN/MI3R+Ioo6qlJfzINpcB3C9y
 UsvnKjzpc6biFami8e7e69OFk52VVI5owvr2jPl44Oi/f+H17mv+2py86LQrbF565UiU
 lxUB+cn4Z+bC3QQzjtd+yUAW8lJu/yPp8a+3xGKjqvD9b2CrB7/Q3ObHDJiP/G/M9XWW
 94vw==
X-Gm-Message-State: APjAAAXNj86efFF7iZEJdV/z8VnRSmsz1IYC314i2xwQC8HaCTYpKA9g
 b2D8YjQw/6FzOHSHv99l3tZGB2ha
X-Google-Smtp-Source: APXvYqzrlNrtMOZkbwP829x1e9OHf1FO0oYhLeXbnXLcsXAAtMVaxR49D9Apa/xD9Tpgnsb2DsRAgg==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr11697248wmc.6.1575320996724; 
 Mon, 02 Dec 2019 13:09:56 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:09:56 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
Date: Mon,  2 Dec 2019 22:09:37 +0100
Message-Id: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:21 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
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
 $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
     -kernel /path/to/linux/arch/arm/boot/zImage \
     -append 'console=ttyS0,115200' \
     -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb

Note that this kernel does not have a root filesystem. You may provide it
with an official Orange Pi PC image [1] either as an SD card or as
USB mass storage. To boot using the Orange Pi PC Debian image on SD card,
simply add the -sd argument and provide the proper root= kernel parameter:
 $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
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
 $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
     -kernel /path/to/uboot/u-boot -sd disk.img

Use the following U-boot commands to load and boot a Linux kernel from SD card:
 -> setenv bootargs console=ttyS0,115200
 -> ext2load mmc 0 0x42000000 zImage
 -> ext2load mmc 0 0x43000000 sun8i-h2-plus-orangepi-zero.dtb
 -> bootz 0x42000000 - 0x43000000

Looking forward to your review comments. I will do my best
to update the patches where needed.

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
  arm/arm-powerctl: set NSACR.{CP11,CP10} bits in arm_set_cpu_on()
  arm: allwinner-h3: add CPU Configuration module
  arm: allwinner-h3: add Security Identifier device
  arm: allwinner-h3: add SD/MMC host controller
  arm: allwinner-h3: add EMAC ethernet device

 MAINTAINERS                           |   8 +
 default-configs/arm-softmmu.mak       |   1 +
 hw/arm/Kconfig                        |   9 +
 hw/arm/Makefile.objs                  |   1 +
 hw/arm/allwinner-h3.c                 | 316 ++++++++++
 hw/arm/orangepi.c                     | 114 ++++
 hw/misc/Makefile.objs                 |   4 +
 hw/misc/allwinner-h3-clk.c            | 227 ++++++++
 hw/misc/allwinner-h3-cpucfg.c         | 280 +++++++++
 hw/misc/allwinner-h3-sid.c            | 162 ++++++
 hw/misc/allwinner-h3-syscon.c         | 139 +++++
 hw/misc/trace-events                  |   5 +
 hw/net/Kconfig                        |   3 +
 hw/net/Makefile.objs                  |   1 +
 hw/net/allwinner-h3-emac.c            | 786 +++++++++++++++++++++++++
 hw/net/trace-events                   |  10 +
 hw/sd/Makefile.objs                   |   1 +
 hw/sd/allwinner-h3-sdhost.c           | 791 ++++++++++++++++++++++++++
 hw/sd/trace-events                    |   7 +
 hw/usb/hcd-ehci-sysbus.c              |  17 +
 hw/usb/hcd-ehci.h                     |   1 +
 include/hw/arm/allwinner-h3.h         | 130 +++++
 include/hw/misc/allwinner-h3-clk.h    |  41 ++
 include/hw/misc/allwinner-h3-cpucfg.h |  44 ++
 include/hw/misc/allwinner-h3-sid.h    |  42 ++
 include/hw/misc/allwinner-h3-syscon.h |  43 ++
 include/hw/net/allwinner-h3-emac.h    |  69 +++
 include/hw/sd/allwinner-h3-sdhost.h   |  73 +++
 target/arm/arm-powerctl.c             |   3 +
 29 files changed, 3328 insertions(+)
 create mode 100644 hw/arm/allwinner-h3.c
 create mode 100644 hw/arm/orangepi.c
 create mode 100644 hw/misc/allwinner-h3-clk.c
 create mode 100644 hw/misc/allwinner-h3-cpucfg.c
 create mode 100644 hw/misc/allwinner-h3-sid.c
 create mode 100644 hw/misc/allwinner-h3-syscon.c
 create mode 100644 hw/net/allwinner-h3-emac.c
 create mode 100644 hw/sd/allwinner-h3-sdhost.c
 create mode 100644 include/hw/arm/allwinner-h3.h
 create mode 100644 include/hw/misc/allwinner-h3-clk.h
 create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h
 create mode 100644 include/hw/misc/allwinner-h3-sid.h
 create mode 100644 include/hw/misc/allwinner-h3-syscon.h
 create mode 100644 include/hw/net/allwinner-h3-emac.h
 create mode 100644 include/hw/sd/allwinner-h3-sdhost.h

-- 
2.17.1


