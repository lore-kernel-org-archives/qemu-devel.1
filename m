Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED139C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11762073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11762073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecsB-0003Vc-Ok
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1iecrI-0002Uj-6O
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1iecrG-0007Oc-HF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:35:12 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:41065
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1iecr8-0007MP-P2; Tue, 10 Dec 2019 05:35:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 1D4798138C;
 Tue, 10 Dec 2019 11:34:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aBl5xW3mX5DS; Tue, 10 Dec 2019 11:34:59 +0100 (CET)
Received: from localhost.localdomain (lfbn-tou-1-352-33.w86-206.abo.wanadoo.fr
 [86.206.184.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id C928881388;
 Tue, 10 Dec 2019 11:34:58 +0100 (CET)
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <6d774864-2bea-ecd6-0b14-a28d0756bfbc@adacore.com>
Date: Tue, 10 Dec 2019 11:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit=C2=A0:
> Dear QEMU developers,
>=20
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
>=20
>   * SMP (Quad Core Cortex A7)
>   * Generic Interrupt Controller configuration
>   * SRAM mappings
>   * Timer device (re-used from Allwinner A10)
>   * UART
>   * SD/MMC storage controller
>   * EMAC ethernet connectivity
>   * USB 2.0 interfaces
>   * Clock Control Unit
>   * System Control module
>   * Security Identifier device
>=20
> Functionality related to graphical output such as HDMI, GPU,
> Display Engine and audio are not included. Recently released
> mainline Linux kernels (4.19 up to latest master) and mainline U-Boot
> are known to work. The SD/MMC code is tested using bonnie++ and
> various tools such as fsck, dd and fdisk. The EMAC is verified with ipe=
rf3
> using -netdev socket.
>=20
> To build a Linux mainline kernel that can be booted by the Orange Pi PC
> machine, simply configure the kernel using the sunxi_defconfig configur=
ation:
>   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
>   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make sunxi_defconfig
>=20
> To be able to use USB storage, you need to manually enable the correspo=
nding
> configuration item. Start the kconfig configuration tool:
>   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuconfig
>=20
> Navigate to the following item, enable it and save your configuration:
>   Device Drivers > USB support > USB Mass Storage support
>=20
> Build the Linux kernel with:
>   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
>=20
> To boot the newly build linux kernel in QEMU with the Orange Pi PC mach=
ine, use:
>   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>       -kernel /path/to/linux/arch/arm/boot/zImage \
>       -append 'console=3DttyS0,115200' \
>       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
>=20
> Note that this kernel does not have a root filesystem. You may provide =
it
> with an official Orange Pi PC image [1] either as an SD card or as
> USB mass storage. To boot using the Orange Pi PC Debian image on SD car=
d,
> simply add the -sd argument and provide the proper root=3D kernel param=
eter:
>   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>       -kernel /path/to/linux/arch/arm/boot/zImage \
>       -append 'console=3DttyS0,115200 root=3D/dev/mmcblk0p2' \
>       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
>       -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
>=20
> Alternatively, you can also choose to build and boot a recent buildroot=
 [2]
> using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.
> To attach an USB mass storage device to the machine, simply append to t=
he command:
>   -drive if=3Dnone,id=3Dstick,file=3Dmyimage.img \
>   -device usb-storage,bus=3Dusb-bus.0,drive=3Dstick
>=20
> U-Boot mainline can be build and configured using the orangepi_pc_defco=
nfig
> using similar commands as describe above for Linux. To start U-Boot usi=
ng
> the Orange Pi PC machine, provide the u-boot binary to the -kernel argu=
ment:
>   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>       -kernel /path/to/uboot/u-boot -sd disk.img
>=20
> Use the following U-boot commands to load and boot a Linux kernel from =
SD card:
>   -> setenv bootargs console=3DttyS0,115200
>   -> ext2load mmc 0 0x42000000 zImage
>   -> ext2load mmc 0 0x43000000 sun8i-h2-plus-orangepi-zero.dtb
>   -> bootz 0x42000000 - 0x43000000
>=20
> Looking forward to your review comments. I will do my best
> to update the patches where needed.
>=20
> With kind regards,
>=20
> Niek Linnenbank
>=20
> [1] http://www.orangepi.org/downloadresources/
> [2] https://buildroot.org/download.html
> [3] https://www.armbian.com/orange-pi-pc/

Works well on my side with vanilla linux-4.9.13 built with gcc-8.3.0 + bu=
sybox
and sun8i-h3-orangepi-one.dtb.

Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>

>=20
> Niek Linnenbank (10):
>    hw: arm: add Allwinner H3 System-on-Chip
>    hw: arm: add Xunlong Orange Pi PC machine
>    arm: allwinner-h3: add Clock Control Unit
>    arm: allwinner-h3: add USB host controller
>    arm: allwinner-h3: add System Control module
>    arm/arm-powerctl: set NSACR.{CP11,CP10} bits in arm_set_cpu_on()
>    arm: allwinner-h3: add CPU Configuration module
>    arm: allwinner-h3: add Security Identifier device
>    arm: allwinner-h3: add SD/MMC host controller
>    arm: allwinner-h3: add EMAC ethernet device
>=20
>   MAINTAINERS                           |   8 +
>   default-configs/arm-softmmu.mak       |   1 +
>   hw/arm/Kconfig                        |   9 +
>   hw/arm/Makefile.objs                  |   1 +
>   hw/arm/allwinner-h3.c                 | 316 ++++++++++
>   hw/arm/orangepi.c                     | 114 ++++
>   hw/misc/Makefile.objs                 |   4 +
>   hw/misc/allwinner-h3-clk.c            | 227 ++++++++
>   hw/misc/allwinner-h3-cpucfg.c         | 280 +++++++++
>   hw/misc/allwinner-h3-sid.c            | 162 ++++++
>   hw/misc/allwinner-h3-syscon.c         | 139 +++++
>   hw/misc/trace-events                  |   5 +
>   hw/net/Kconfig                        |   3 +
>   hw/net/Makefile.objs                  |   1 +
>   hw/net/allwinner-h3-emac.c            | 786 +++++++++++++++++++++++++
>   hw/net/trace-events                   |  10 +
>   hw/sd/Makefile.objs                   |   1 +
>   hw/sd/allwinner-h3-sdhost.c           | 791 +++++++++++++++++++++++++=
+
>   hw/sd/trace-events                    |   7 +
>   hw/usb/hcd-ehci-sysbus.c              |  17 +
>   hw/usb/hcd-ehci.h                     |   1 +
>   include/hw/arm/allwinner-h3.h         | 130 +++++
>   include/hw/misc/allwinner-h3-clk.h    |  41 ++
>   include/hw/misc/allwinner-h3-cpucfg.h |  44 ++
>   include/hw/misc/allwinner-h3-sid.h    |  42 ++
>   include/hw/misc/allwinner-h3-syscon.h |  43 ++
>   include/hw/net/allwinner-h3-emac.h    |  69 +++
>   include/hw/sd/allwinner-h3-sdhost.h   |  73 +++
>   target/arm/arm-powerctl.c             |   3 +
>   29 files changed, 3328 insertions(+)
>   create mode 100644 hw/arm/allwinner-h3.c
>   create mode 100644 hw/arm/orangepi.c
>   create mode 100644 hw/misc/allwinner-h3-clk.c
>   create mode 100644 hw/misc/allwinner-h3-cpucfg.c
>   create mode 100644 hw/misc/allwinner-h3-sid.c
>   create mode 100644 hw/misc/allwinner-h3-syscon.c
>   create mode 100644 hw/net/allwinner-h3-emac.c
>   create mode 100644 hw/sd/allwinner-h3-sdhost.c
>   create mode 100644 include/hw/arm/allwinner-h3.h
>   create mode 100644 include/hw/misc/allwinner-h3-clk.h
>   create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h
>   create mode 100644 include/hw/misc/allwinner-h3-sid.h
>   create mode 100644 include/hw/misc/allwinner-h3-syscon.h
>   create mode 100644 include/hw/net/allwinner-h3-emac.h
>   create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
>=20

