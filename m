Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF27C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478362077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiSWpiIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478362077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ielch-0004AV-D3
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ielbu-0003Xe-Pd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ielbs-00079i-A0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:55:54 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ielbs-00079L-2S; Tue, 10 Dec 2019 14:55:52 -0500
Received: by mail-il1-x142.google.com with SMTP id r81so17288070ilk.0;
 Tue, 10 Dec 2019 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1dIZZM/9ov80ebOhF4v5HlOS5BwOWDRL3nqtdeKRMI4=;
 b=DiSWpiIooBSFWqTa8eHBGcond2A+qeITtzPcTmfiDp+Ux1wv6hN+sfDVVyCqyDLvAi
 nPlmRkwahNsh9D57sUHJ1miIgprEYMpUKNhcm5pJJh18TnJPzVPKEFCWn/PYoapkr+f+
 U7e78xdwswsxmhtnBFQKLM4ye/JMwtPoXgNAD5nqRWxtH5oyIB6OpkHMW8GBifbbrQnE
 dnuMsZ+Dx2se09OVaEqli8PKc31ddZyMTIJ5Sphm/y3mWPFud7UgoSElCxixqfMbjgIp
 N9PCWOQuRX0vAw5PKubRCSj5Ab/KgDGiElcyOSLpGlNXO6jvX2IeQVNjehG7nLikfhiZ
 GKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1dIZZM/9ov80ebOhF4v5HlOS5BwOWDRL3nqtdeKRMI4=;
 b=AaXfVdlhQfn+DCDr+lgKe7d3/v2OVGlN04cZmzd+vDxDozG6OGg4lQZVH7UNBgFfL5
 fW5mjbIHBLNLh+Xwxex3VxkMxi1FPoULniVLKu5Sx5rout1eyWOuF9xG9tImIKWuX3EH
 aAbBW0nBEy8+A5hIWdpvUIP/+C87UEamcQY4JdBzjyOkLdcjiMuZqSR/tQ565sv1MR5W
 6ri8sfX8H1ZiDXe1hF+GMn4mTT11nvkAPsZTYGu4RyteilPUTMdBopEtOrjAFC12W3bL
 hMibxrlSzd3aNcxHtAM/CzXC/OqZYZfSVYj0rbHo+FXFXk3gRlC+fpdRw+z/pw7wpZ4h
 Ma0Q==
X-Gm-Message-State: APjAAAVVG/eHpUhoqZ3yQSVJtVtVDqNy5Oivyw6l77CuRtdUoPcOboAX
 jgum/SgZI3dAnhx11TzFSJwmUHyBFoA4D22CpTE=
X-Google-Smtp-Source: APXvYqwkSAa+qCJICiNlJ3ueqeehm7sglbISd92hpmdB7F/CMx4P0nEmmZD9GCiCXQP6dlXK+TO2Id0Gydi2ZpVcUEc=
X-Received: by 2002:a92:d084:: with SMTP id h4mr36000622ilh.265.1576007750959; 
 Tue, 10 Dec 2019 11:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <6d774864-2bea-ecd6-0b14-a28d0756bfbc@adacore.com>
In-Reply-To: <6d774864-2bea-ecd6-0b14-a28d0756bfbc@adacore.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Dec 2019 20:55:39 +0100
Message-ID: <CAPan3Wq8Hs-qV=S_esth-Fyp8VsrO2WhC3khJUZ2-UghAWkZUw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: KONRAD Frederic <frederic.konrad@adacore.com>
Content-Type: multipart/alternative; boundary="00000000000028c75e05995ee654"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000028c75e05995ee654
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Tue, Dec 10, 2019 at 11:34 AM KONRAD Frederic <
frederic.konrad@adacore.com> wrote:

>
>
> Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit :
> > Dear QEMU developers,
> >
> > Hereby I would like to contribute the following set of patches to QEMU
> > which add support for the Allwinner H3 System on Chip and the
> > Orange Pi PC machine. The following features and devices are supported:
> >
> >   * SMP (Quad Core Cortex A7)
> >   * Generic Interrupt Controller configuration
> >   * SRAM mappings
> >   * Timer device (re-used from Allwinner A10)
> >   * UART
> >   * SD/MMC storage controller
> >   * EMAC ethernet connectivity
> >   * USB 2.0 interfaces
> >   * Clock Control Unit
> >   * System Control module
> >   * Security Identifier device
> >
> > Functionality related to graphical output such as HDMI, GPU,
> > Display Engine and audio are not included. Recently released
> > mainline Linux kernels (4.19 up to latest master) and mainline U-Boot
> > are known to work. The SD/MMC code is tested using bonnie++ and
> > various tools such as fsck, dd and fdisk. The EMAC is verified with
> iperf3
> > using -netdev socket.
> >
> > To build a Linux mainline kernel that can be booted by the Orange Pi PC
> > machine, simply configure the kernel using the sunxi_defconfig
> configuration:
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make sunxi_defconfig
> >
> > To be able to use USB storage, you need to manually enable the
> corresponding
> > configuration item. Start the kconfig configuration tool:
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuconfig
> >
> > Navigate to the following item, enable it and save your configuration:
> >   Device Drivers > USB support > USB Mass Storage support
> >
> > Build the Linux kernel with:
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
> >
> > To boot the newly build linux kernel in QEMU with the Orange Pi PC
> machine, use:
> >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
> >       -kernel /path/to/linux/arch/arm/boot/zImage \
> >       -append 'console=3DttyS0,115200' \
> >       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
> >
> > Note that this kernel does not have a root filesystem. You may provide =
it
> > with an official Orange Pi PC image [1] either as an SD card or as
> > USB mass storage. To boot using the Orange Pi PC Debian image on SD car=
d,
> > simply add the -sd argument and provide the proper root=3D kernel
> parameter:
> >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
> >       -kernel /path/to/linux/arch/arm/boot/zImage \
> >       -append 'console=3DttyS0,115200 root=3D/dev/mmcblk0p2' \
> >       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
> >       -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
> >
> > Alternatively, you can also choose to build and boot a recent buildroot
> [2]
> > using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.
> > To attach an USB mass storage device to the machine, simply append to
> the command:
> >   -drive if=3Dnone,id=3Dstick,file=3Dmyimage.img \
> >   -device usb-storage,bus=3Dusb-bus.0,drive=3Dstick
> >
> > U-Boot mainline can be build and configured using the
> orangepi_pc_defconfig
> > using similar commands as describe above for Linux. To start U-Boot usi=
ng
> > the Orange Pi PC machine, provide the u-boot binary to the -kernel
> argument:
> >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
> >       -kernel /path/to/uboot/u-boot -sd disk.img
> >
> > Use the following U-boot commands to load and boot a Linux kernel from
> SD card:
> >   -> setenv bootargs console=3DttyS0,115200
> >   -> ext2load mmc 0 0x42000000 zImage
> >   -> ext2load mmc 0 0x43000000 sun8i-h2-plus-orangepi-zero.dtb
> >   -> bootz 0x42000000 - 0x43000000
> >
> > Looking forward to your review comments. I will do my best
> > to update the patches where needed.
> >
> > With kind regards,
> >
> > Niek Linnenbank
> >
> > [1] http://www.orangepi.org/downloadresources/
> > [2] https://buildroot.org/download.html
> > [3] https://www.armbian.com/orange-pi-pc/
>
> Works well on my side with vanilla linux-4.9.13 built with gcc-8.3.0 +
> busybox
> and sun8i-h3-orangepi-one.dtb.
>

> Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
>
> Thank you for testing! Great, I'll add the tag for the next v2 of the
patches.

Regards,
Niek


> >
> > Niek Linnenbank (10):
> >    hw: arm: add Allwinner H3 System-on-Chip
> >    hw: arm: add Xunlong Orange Pi PC machine
> >    arm: allwinner-h3: add Clock Control Unit
> >    arm: allwinner-h3: add USB host controller
> >    arm: allwinner-h3: add System Control module
> >    arm/arm-powerctl: set NSACR.{CP11,CP10} bits in arm_set_cpu_on()
> >    arm: allwinner-h3: add CPU Configuration module
> >    arm: allwinner-h3: add Security Identifier device
> >    arm: allwinner-h3: add SD/MMC host controller
> >    arm: allwinner-h3: add EMAC ethernet device
> >
> >   MAINTAINERS                           |   8 +
> >   default-configs/arm-softmmu.mak       |   1 +
> >   hw/arm/Kconfig                        |   9 +
> >   hw/arm/Makefile.objs                  |   1 +
> >   hw/arm/allwinner-h3.c                 | 316 ++++++++++
> >   hw/arm/orangepi.c                     | 114 ++++
> >   hw/misc/Makefile.objs                 |   4 +
> >   hw/misc/allwinner-h3-clk.c            | 227 ++++++++
> >   hw/misc/allwinner-h3-cpucfg.c         | 280 +++++++++
> >   hw/misc/allwinner-h3-sid.c            | 162 ++++++
> >   hw/misc/allwinner-h3-syscon.c         | 139 +++++
> >   hw/misc/trace-events                  |   5 +
> >   hw/net/Kconfig                        |   3 +
> >   hw/net/Makefile.objs                  |   1 +
> >   hw/net/allwinner-h3-emac.c            | 786 +++++++++++++++++++++++++
> >   hw/net/trace-events                   |  10 +
> >   hw/sd/Makefile.objs                   |   1 +
> >   hw/sd/allwinner-h3-sdhost.c           | 791 +++++++++++++++++++++++++=
+
> >   hw/sd/trace-events                    |   7 +
> >   hw/usb/hcd-ehci-sysbus.c              |  17 +
> >   hw/usb/hcd-ehci.h                     |   1 +
> >   include/hw/arm/allwinner-h3.h         | 130 +++++
> >   include/hw/misc/allwinner-h3-clk.h    |  41 ++
> >   include/hw/misc/allwinner-h3-cpucfg.h |  44 ++
> >   include/hw/misc/allwinner-h3-sid.h    |  42 ++
> >   include/hw/misc/allwinner-h3-syscon.h |  43 ++
> >   include/hw/net/allwinner-h3-emac.h    |  69 +++
> >   include/hw/sd/allwinner-h3-sdhost.h   |  73 +++
> >   target/arm/arm-powerctl.c             |   3 +
> >   29 files changed, 3328 insertions(+)
> >   create mode 100644 hw/arm/allwinner-h3.c
> >   create mode 100644 hw/arm/orangepi.c
> >   create mode 100644 hw/misc/allwinner-h3-clk.c
> >   create mode 100644 hw/misc/allwinner-h3-cpucfg.c
> >   create mode 100644 hw/misc/allwinner-h3-sid.c
> >   create mode 100644 hw/misc/allwinner-h3-syscon.c
> >   create mode 100644 hw/net/allwinner-h3-emac.c
> >   create mode 100644 hw/sd/allwinner-h3-sdhost.c
> >   create mode 100644 include/hw/arm/allwinner-h3.h
> >   create mode 100644 include/hw/misc/allwinner-h3-clk.h
> >   create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h
> >   create mode 100644 include/hw/misc/allwinner-h3-sid.h
> >   create mode 100644 include/hw/misc/allwinner-h3-syscon.h
> >   create mode 100644 include/hw/net/allwinner-h3-emac.h
> >   create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
> >
>


--=20
Niek Linnenbank

--00000000000028c75e05995ee654
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Frederic,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 10, 2019 at 11:34 AM KONR=
AD Frederic &lt;<a href=3D"mailto:frederic.konrad@adacore.com">frederic.kon=
rad@adacore.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br>
<br>
Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit=C2=A0:<br>
&gt; Dear QEMU developers,<br>
&gt; <br>
&gt; Hereby I would like to contribute the following set of patches to QEMU=
<br>
&gt; which add support for the Allwinner H3 System on Chip and the<br>
&gt; Orange Pi PC machine. The following features and devices are supported=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* SMP (Quad Core Cortex A7)<br>
&gt;=C2=A0 =C2=A0* Generic Interrupt Controller configuration<br>
&gt;=C2=A0 =C2=A0* SRAM mappings<br>
&gt;=C2=A0 =C2=A0* Timer device (re-used from Allwinner A10)<br>
&gt;=C2=A0 =C2=A0* UART<br>
&gt;=C2=A0 =C2=A0* SD/MMC storage controller<br>
&gt;=C2=A0 =C2=A0* EMAC ethernet connectivity<br>
&gt;=C2=A0 =C2=A0* USB 2.0 interfaces<br>
&gt;=C2=A0 =C2=A0* Clock Control Unit<br>
&gt;=C2=A0 =C2=A0* System Control module<br>
&gt;=C2=A0 =C2=A0* Security Identifier device<br>
&gt; <br>
&gt; Functionality related to graphical output such as HDMI, GPU,<br>
&gt; Display Engine and audio are not included. Recently released<br>
&gt; mainline Linux kernels (4.19 up to latest master) and mainline U-Boot<=
br>
&gt; are known to work. The SD/MMC code is tested using bonnie++ and<br>
&gt; various tools such as fsck, dd and fdisk. The EMAC is verified with ip=
erf3<br>
&gt; using -netdev socket.<br>
&gt; <br>
&gt; To build a Linux mainline kernel that can be booted by the Orange Pi P=
C<br>
&gt; machine, simply configure the kernel using the sunxi_defconfig configu=
ration:<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrpro=
per<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make sunxi=
_defconfig<br>
&gt; <br>
&gt; To be able to use USB storage, you need to manually enable the corresp=
onding<br>
&gt; configuration item. Start the kconfig configuration tool:<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuc=
onfig<br>
&gt; <br>
&gt; Navigate to the following item, enable it and save your configuration:=
<br>
&gt;=C2=A0 =C2=A0Device Drivers &gt; USB support &gt; USB Mass Storage supp=
ort<br>
&gt; <br>
&gt; Build the Linux kernel with:<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5<b=
r>
&gt; <br>
&gt; To boot the newly build linux kernel in QEMU with the Orange Pi PC mac=
hine, use:<br>
&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nographic =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200&#39; \<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/sun8i-=
h3-orangepi-pc.dtb<br>
&gt; <br>
&gt; Note that this kernel does not have a root filesystem. You may provide=
 it<br>
&gt; with an official Orange Pi PC image [1] either as an SD card or as<br>
&gt; USB mass storage. To boot using the Orange Pi PC Debian image on SD ca=
rd,<br>
&gt; simply add the -sd argument and provide the proper root=3D kernel para=
meter:<br>
&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nographic =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200 root=3D/=
dev/mmcblk0p2&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/sun8i-=
h3-orangepi-pc.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-sd OrangePi_pc_debian_stretch_server_linux5=
.3.5_v1.0.img<br>
&gt; <br>
&gt; Alternatively, you can also choose to build and boot a recent buildroo=
t [2]<br>
&gt; using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.=
<br>
&gt; To attach an USB mass storage device to the machine, simply append to =
the command:<br>
&gt;=C2=A0 =C2=A0-drive if=3Dnone,id=3Dstick,file=3Dmyimage.img \<br>
&gt;=C2=A0 =C2=A0-device usb-storage,bus=3Dusb-bus.0,drive=3Dstick<br>
&gt; <br>
&gt; U-Boot mainline can be build and configured using the orangepi_pc_defc=
onfig<br>
&gt; using similar commands as describe above for Linux. To start U-Boot us=
ing<br>
&gt; the Orange Pi PC machine, provide the u-boot binary to the -kernel arg=
ument:<br>
&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nographic =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/uboot/u-boot -sd disk.img<b=
r>
&gt; <br>
&gt; Use the following U-boot commands to load and boot a Linux kernel from=
 SD card:<br>
&gt;=C2=A0 =C2=A0-&gt; setenv bootargs console=3DttyS0,115200<br>
&gt;=C2=A0 =C2=A0-&gt; ext2load mmc 0 0x42000000 zImage<br>
&gt;=C2=A0 =C2=A0-&gt; ext2load mmc 0 0x43000000 sun8i-h2-plus-orangepi-zer=
o.dtb<br>
&gt;=C2=A0 =C2=A0-&gt; bootz 0x42000000 - 0x43000000<br>
&gt; <br>
&gt; Looking forward to your review comments. I will do my best<br>
&gt; to update the patches where needed.<br>
&gt; <br>
&gt; With kind regards,<br>
&gt; <br>
&gt; Niek Linnenbank<br>
&gt; <br>
&gt; [1] <a href=3D"http://www.orangepi.org/downloadresources/" rel=3D"nore=
ferrer" target=3D"_blank">http://www.orangepi.org/downloadresources/</a><br=
>
&gt; [2] <a href=3D"https://buildroot.org/download.html" rel=3D"noreferrer"=
 target=3D"_blank">https://buildroot.org/download.html</a><br>
&gt; [3] <a href=3D"https://www.armbian.com/orange-pi-pc/" rel=3D"noreferre=
r" target=3D"_blank">https://www.armbian.com/orange-pi-pc/</a><br>
<br>
Works well on my side with vanilla linux-4.9.13 built with gcc-8.3.0 + busy=
box<br>
and sun8i-h3-orangepi-one.dtb.<br></blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
Tested-by: KONRAD Frederic &lt;<a href=3D"mailto:frederic.konrad@adacore.co=
m" target=3D"_blank">frederic.konrad@adacore.com</a>&gt;<br>
<br></blockquote><div>Thank you for testing! Great, I&#39;ll add the tag fo=
r the next v2 of the patches.</div><div><br></div><div>Regards,</div><div>N=
iek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt; <br>
&gt; Niek Linnenbank (10):<br>
&gt;=C2=A0 =C2=A0 hw: arm: add Allwinner H3 System-on-Chip<br>
&gt;=C2=A0 =C2=A0 hw: arm: add Xunlong Orange Pi PC machine<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add Clock Control Unit<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add USB host controller<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add System Control module<br>
&gt;=C2=A0 =C2=A0 arm/arm-powerctl: set NSACR.{CP11,CP10} bits in arm_set_c=
pu_on()<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add CPU Configuration module<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add Security Identifier device<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add SD/MMC host controller<br>
&gt;=C2=A0 =C2=A0 arm: allwinner-h3: add EMAC ethernet device<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 =C2=A0default-configs/arm-softmmu.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 316 ++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 114 ++++<br>
&gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-clk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 227 ++++++++<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-cpucfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 280 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 162 ++++++<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-syscon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 139 +++++<br>
&gt;=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0hw/net/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/net/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/net/allwinner-h3-emac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 786 +++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +<br>
&gt;=C2=A0 =C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/sd/allwinner-h3-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 791 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ehci-sysbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 17 +<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 130 +++++<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-clk.h=C2=A0 =C2=A0 |=C2=A0 41=
 ++<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-cpucfg.h |=C2=A0 44 ++<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-sid.h=C2=A0 =C2=A0 |=C2=A0 42=
 ++<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-syscon.h |=C2=A0 43 ++<br>
&gt;=C2=A0 =C2=A0include/hw/net/allwinner-h3-emac.h=C2=A0 =C2=A0 |=C2=A0 69=
 +++<br>
&gt;=C2=A0 =C2=A0include/hw/sd/allwinner-h3-sdhost.h=C2=A0 =C2=A0|=C2=A0 73=
 +++<br>
&gt;=C2=A0 =C2=A0target/arm/arm-powerctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A029 files changed, 3328 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/allwinner-h3.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/orangepi.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-clk.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-cpucfg.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-sid.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-syscon.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/net/allwinner-h3-emac.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/sd/allwinner-h3-sdhost.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-clk.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h<b=
r>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-sid.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-syscon.h<b=
r>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/net/allwinner-h3-emac.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/sd/allwinner-h3-sdhost.h<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000028c75e05995ee654--

