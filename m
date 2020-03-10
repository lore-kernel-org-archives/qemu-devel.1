Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA4AC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4E4205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9LH97si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4E4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfud-0003Px-9P
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBftW-000229-Jq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBftT-00048k-DN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:30:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBftT-000445-1d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:30:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id r15so11099510wrx.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZnJ3ROediuoRptqJm1+D+W0HKkG1ZLu8MLifgQihlq8=;
 b=Q9LH97si969swJ4YJGqS0eSSPc+D5Ek6Mes47M4yy06Igugzr+loU09kcK+G3oW9qQ
 jrq67XlJZE8Jc+lLIQuaPFXtpz9aDfPmBBDb6owFTWAuRC42fdZfrfNL5+u39ls2Zb3i
 dx9by9a+s/wWS/03F31RKIeuEj8ex6kKymtPP8ZDJp2S/1UmuXkAgBc4EBqLQhq2hnxt
 tCqOL/dCdsU6Tql/Fd4h32fCZKX5X1V/zA5mlurDsN+Aei3Qyu788n0YdZLCeABMXtAl
 sCyfv8LVqodkmd0OuMEDYCqZASSw9TNaeFp6T8BgRXMpwUPAjbzWyYO6TjskhvUvAuN9
 Kgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZnJ3ROediuoRptqJm1+D+W0HKkG1ZLu8MLifgQihlq8=;
 b=tdZXJJov409qHm6uLVfBiB1bOp1/2H5OgaBhaW6/U+BeNFePHEiTfcK4KdLg4gWzOZ
 anLakMWwakIuCfOIhKAkKe/iHwKtMw7eRdASVekT+k3+rf28gLlV4DTjY78WvuXBLr0Y
 Ac1ds/LQsU1hCM45Ak4pwU0xhmzReu/yyrU04eJUkz7Ltse6sK+MD1nFwbFOrp+ovLPK
 +fe+1Un0b+YiqFXngB0hT81511722+JQJxBTKyJcArICHluF2CsWeLBt2ow41i2sqsV2
 v4bJCyG1qcwCN0xKUGwlQhbPYi5WueITDDc54exKFP1cmgm9cBG3ChlyRwMvrpKtJEf6
 9iOw==
X-Gm-Message-State: ANhLgQ0zfrt982KpO4dfeLDzBn8/wxYxs1KiW9IeIoHM69m+xh4ehvsD
 r3wK59YrYHfyjlnNv1JttfZcmQ==
X-Google-Smtp-Source: ADFU+vu748z2YedtuI9TM4fPXW5V0107++FjBIDS//vE//P5Jvg8NX9hIR5gIxSxV8v6OgIbeTjNew==
X-Received: by 2002:adf:f94f:: with SMTP id q15mr27337961wrr.65.1583850601850; 
 Tue, 10 Mar 2020 07:30:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c85sm4444298wmd.48.2020.03.10.07.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:30:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A5BD11FF7E;
 Tue, 10 Mar 2020 14:29:59 +0000 (GMT)
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/5] docs/system: Split target-arm.rst into sub-documents
In-reply-to: <20200309215818.2021-3-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 14:29:59 +0000
Message-ID: <87a74oi8pk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Currently the documentation for Arm system emulator targets is in a
> single target-arm.rst.  This describes only some of the boards and
> often in a fairly abbreviated fashion. Restructure it so that each
> board has its own documentation file in the docs/system/arm/
> subdirectory.
>
> This will hopefully encourage us to write board documentation that
> describes the board in detail, rather than a few brief paragraphs
> in a single long page. The table of contents should also help users
> to find the board they care about faster.
>
> Once the structure is in place we'll be able to move microvm.rst
> from the top-level docs/ directory.
>
> All the text from the old page is retained, except for the final
> paragraph ("A Linux 2.6 test image is available on the QEMU web site.
> More information is available in the QEMU mailing-list archive."),
> which is deleted. The git history shows this was originally added
> in reference to the integratorcp board (at that time the only
> Arm board that was supported), and has subsequently gradually been
> further and further separated from the integratorcp documentation
> by the insertion of other board documentation sections. It's
> extremely out of date and no longer accurate, since AFAICT there
> isn't an integratorcp kernel on the website any more; so better
> deleted than retained.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> A subsequent patch will add some text that at least gestures
> in the direction of some of the more obvious missing info,
> eg 64-bit boards.
> ---
>  MAINTAINERS                      |   9 ++
>  docs/system/arm/integratorcp.rst |  16 +++
>  docs/system/arm/musicpal.rst     |  19 +++
>  docs/system/arm/nseries.rst      |  33 +++++
>  docs/system/arm/palm.rst         |  23 ++++
>  docs/system/arm/realview.rst     |  34 +++++
>  docs/system/arm/stellaris.rst    |  26 ++++
>  docs/system/arm/sx1.rst          |  18 +++
>  docs/system/arm/versatile.rst    |  29 ++++
>  docs/system/arm/xscale.rst       |  29 ++++
>  docs/system/target-arm.rst       | 225 ++-----------------------------
>  11 files changed, 249 insertions(+), 212 deletions(-)
>  create mode 100644 docs/system/arm/integratorcp.rst
>  create mode 100644 docs/system/arm/musicpal.rst
>  create mode 100644 docs/system/arm/nseries.rst
>  create mode 100644 docs/system/arm/palm.rst
>  create mode 100644 docs/system/arm/realview.rst
>  create mode 100644 docs/system/arm/stellaris.rst
>  create mode 100644 docs/system/arm/sx1.rst
>  create mode 100644 docs/system/arm/versatile.rst
>  create mode 100644 docs/system/arm/xscale.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36d0c6887a9..31a1b423df1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -155,6 +155,7 @@ F: include/hw/cpu/a*mpcore.h
>  F: disas/arm.c
>  F: disas/arm-a64.cc
>  F: disas/libvixl/
> +F: docs/system/target-arm.rst
>=20=20
>  ARM SMMU
>  M: Eric Auger <eric.auger@redhat.com>
> @@ -615,6 +616,7 @@ F: hw/arm/integratorcp.c
>  F: hw/misc/arm_integrator_debug.c
>  F: include/hw/misc/arm_integrator_debug.h
>  F: tests/acceptance/machine_arm_integratorcp.py
> +F: docs/system/arm/integratorcp.rst
>=20=20
>  MCIMX6UL EVK / i.MX6ul
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -673,6 +675,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/musicpal.c
> +F: docs/system/arm/musicpal.rst
>=20=20
>  nSeries
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -689,6 +692,7 @@ F: include/hw/display/blizzard.h
>  F: include/hw/input/tsc2xxx.h
>  F: include/hw/misc/cbus.h
>  F: tests/acceptance/machine_arm_n8x0.py
> +F: docs/system/arm/nseries.rst
>=20=20
>  Palm
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -698,6 +702,7 @@ S: Odd Fixes
>  F: hw/arm/palm.c
>  F: hw/input/tsc210x.c
>  F: include/hw/input/tsc2xxx.h
> +F: docs/system/arm/palm.rst
>=20=20
>  Raspberry Pi
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -719,6 +724,7 @@ F: hw/arm/realview*
>  F: hw/cpu/realview_mpcore.c
>  F: hw/intc/realview_gic.c
>  F: include/hw/intc/realview_gic.h
> +F: docs/system/arm/realview.rst
>=20=20
>  PXA2XX
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -738,6 +744,7 @@ F: hw/misc/max111x.c
>  F: include/hw/arm/pxa.h
>  F: include/hw/arm/sharpsl.h
>  F: include/hw/display/tc6393xb.h
> +F: docs/system/arm/xscale.rst
>=20=20
>  SABRELITE / i.MX6
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -773,6 +780,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/stellaris*
>  F: include/hw/input/gamepad.h
> +F: docs/system/arm/stellaris.rst
>=20=20
>  Versatile Express
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -786,6 +794,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/versatile*
>  F: hw/misc/arm_sysctl.c
> +F: docs/system/arm/versatile.rst
>=20=20
>  Virt
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integrato=
rcp.rst
> new file mode 100644
> index 00000000000..3232b43a08b
> --- /dev/null
> +++ b/docs/system/arm/integratorcp.rst
> @@ -0,0 +1,16 @@
> +Integrator/CP (``integratorcp``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ARM Integrator/CP board is emulated with the following devices:
> +
> +-  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
> +
> +-  Two PL011 UARTs
> +
> +-  SMC 91c111 Ethernet adapter
> +
> +-  PL110 LCD controller
> +
> +-  PL050 KMI with PS/2 keyboard and mouse.
> +
> +-  PL181 MultiMedia Card Interface with SD card.
> diff --git a/docs/system/arm/musicpal.rst b/docs/system/arm/musicpal.rst
> new file mode 100644
> index 00000000000..35c22212486
> --- /dev/null
> +++ b/docs/system/arm/musicpal.rst
> @@ -0,0 +1,19 @@
> +Freecom MusicPal (``musicpal``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +The Freecom MusicPal internet radio emulation includes the following
> +elements:
> +
> +-  Marvell MV88W8618 ARM core.
> +
> +-  32 MB RAM, 256 KB SRAM, 8 MB flash.
> +
> +-  Up to 2 16550 UARTs
> +
> +-  MV88W8xx8 Ethernet controller
> +
> +-  MV88W8618 audio controller, WM8750 CODEC and mixer
> +
> +-  128x64 display with brightness control
> +
> +-  2 buttons, 2 navigation wheels with button function
> diff --git a/docs/system/arm/nseries.rst b/docs/system/arm/nseries.rst
> new file mode 100644
> index 00000000000..b000b6d13bb
> --- /dev/null
> +++ b/docs/system/arm/nseries.rst
> @@ -0,0 +1,33 @@
> +Nokia N800 and N810 tablets (``n800``, ``n810``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
> +48) emulation supports the following elements:
> +
> +-  Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
> +
> +-  RAM and non-volatile OneNAND Flash memories
> +
> +-  Display connected to EPSON remote framebuffer chip and OMAP on-chip
> +   display controller and a LS041y3 MIPI DBI-C controller
> +
> +-  TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen
> +   controllers driven through SPI bus
> +
> +-  National Semiconductor LM8323-controlled qwerty keyboard driven
> +   through |I2C| bus
> +
> +-  Secure Digital card connected to OMAP MMC/SD host
> +
> +-  Three OMAP on-chip UARTs and on-chip STI debugging console
> +
> +-  Mentor Graphics \"Inventra\" dual-role USB controller embedded in a
> +   TI TUSB6010 chip - only USB host mode is supported
> +
> +-  TI TMP105 temperature sensor driven through |I2C| bus
> +
> +-  TI TWL92230C power management companion with an RTC on
> +   |I2C| bus
> +
> +-  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
> +   through CBUS
> diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst
> new file mode 100644
> index 00000000000..0eabf63e0e7
> --- /dev/null
> +++ b/docs/system/arm/palm.rst
> @@ -0,0 +1,23 @@
> +Palm Tungsten|E PDA (``cheetah``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
> +following elements:
> +
> +-  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> +
> +-  ROM and RAM memories (ROM firmware image can be loaded with
> +   -option-rom)
> +
> +-  On-chip LCD controller
> +
> +-  On-chip Real Time Clock
> +
> +-  TI TSC2102i touchscreen controller / analog-digital converter /
> +   Audio CODEC, connected through MicroWire and |I2S| busses
> +
> +-  GPIO-connected matrix keypad
> +
> +-  Secure Digital card connected to OMAP MMC/SD host
> +
> +-  Three on-chip UARTs
> diff --git a/docs/system/arm/realview.rst b/docs/system/arm/realview.rst
> new file mode 100644
> index 00000000000..8e08eb5da16
> --- /dev/null
> +++ b/docs/system/arm/realview.rst
> @@ -0,0 +1,34 @@
> +Arm Realview boards (``realview-eb``, ``realview-eb-mpcore``, ``realview=
-pb-a8``, ``realview-pbx-a9``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Several variants of the ARM RealView baseboard are emulated, including
> +the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only
> +certain Linux kernel configurations work out of the box on these boards.
> +
> +Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> +enabled in the kernel, and expect 512M RAM. Kernels for The PBX-A9 board
> +should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> +disabled and expect 1024M RAM.
> +
> +The following devices are emulated:
> +
> +-  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
> +
> +-  ARM AMBA Generic/Distributed Interrupt Controller
> +
> +-  Four PL011 UARTs
> +
> +-  SMC 91c111 or SMSC LAN9118 Ethernet adapter
> +
> +-  PL110 LCD controller
> +
> +-  PL050 KMI with PS/2 keyboard and mouse
> +
> +-  PCI host bridge
> +
> +-  PCI OHCI USB controller
> +
> +-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
> +   devices
> +
> +-  PL181 MultiMedia Card Interface with SD card.
> diff --git a/docs/system/arm/stellaris.rst b/docs/system/arm/stellaris.rst
> new file mode 100644
> index 00000000000..8af4ad79c79
> --- /dev/null
> +++ b/docs/system/arm/stellaris.rst
> @@ -0,0 +1,26 @@
> +Stellaris boards (``lm3s6965evb``, ``lm3s811evb``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The Luminary Micro Stellaris LM3S811EVB emulation includes the following
> +devices:
> +
> +-  Cortex-M3 CPU core.
> +
> +-  64k Flash and 8k SRAM.
> +
> +-  Timers, UARTs, ADC and |I2C| interface.
> +
> +-  OSRAM Pictiva 96x16 OLED with SSD0303 controller on
> +   |I2C| bus.
> +
> +The Luminary Micro Stellaris LM3S6965EVB emulation includes the
> +following devices:
> +
> +-  Cortex-M3 CPU core.
> +
> +-  256k Flash and 64k SRAM.
> +
> +-  Timers, UARTs, ADC, |I2C| and SSI interfaces.
> +
> +-  OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via
> +   SSI.
> diff --git a/docs/system/arm/sx1.rst b/docs/system/arm/sx1.rst
> new file mode 100644
> index 00000000000..321993bc098
> --- /dev/null
> +++ b/docs/system/arm/sx1.rst
> @@ -0,0 +1,18 @@
> +Siemens SX1 (``sx1``, ``sx1-v1``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Siemens SX1 models v1 and v2 (default) basic emulation. The
> +emulation includes the following elements:
> +
> +-  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> +
> +-  ROM and RAM memories (ROM firmware image can be loaded with
> +   -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB
> +
> +-  On-chip LCD controller
> +
> +-  On-chip Real Time Clock
> +
> +-  Secure Digital card connected to OMAP MMC/SD host
> +
> +-  Three on-chip UARTs
> diff --git a/docs/system/arm/versatile.rst b/docs/system/arm/versatile.rst
> new file mode 100644
> index 00000000000..48b6ca0a020
> --- /dev/null
> +++ b/docs/system/arm/versatile.rst
> @@ -0,0 +1,29 @@
> +Arm Versatile boards (``versatileab``, ``versatilepb``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The ARM Versatile baseboard is emulated with the following devices:
> +
> +-  ARM926E, ARM1136 or Cortex-A8 CPU
> +
> +-  PL190 Vectored Interrupt Controller
> +
> +-  Four PL011 UARTs
> +
> +-  SMC 91c111 Ethernet adapter
> +
> +-  PL110 LCD controller
> +
> +-  PL050 KMI with PS/2 keyboard and mouse.
> +
> +-  PCI host bridge. Note the emulated PCI bridge only provides access
> +   to PCI memory space. It does not provide access to PCI IO space. This
> +   means some devices (eg. ne2k_pci NIC) are not usable, and others (eg.
> +   rtl8139 NIC) are only usable when the guest drivers use the memory
> +   mapped control registers.
> +
> +-  PCI OHCI USB controller.
> +
> +-  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
> +   devices.
> +
> +-  PL181 MultiMedia Card Interface with SD card.
> diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst
> new file mode 100644
> index 00000000000..19da2eff352
> --- /dev/null
> +++ b/docs/system/arm/xscale.rst
> @@ -0,0 +1,29 @@
> +Sharp XScale-based PDA models (``akita``, ``borzoi``, ``spitz``, ``terri=
er``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The XScale-based clamshell PDA models (\"Spitz\", \"Akita\", \"Borzoi\"
> +and \"Terrier\") emulation includes the following peripherals:
> +
> +-  Intel PXA270 System-on-chip (ARM V5TE core)
> +
> +-  NAND Flash memory
> +
> +-  IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \"Akita\"
> +
> +-  On-chip OHCI USB controller
> +
> +-  On-chip LCD controller
> +
> +-  On-chip Real Time Clock
> +
> +-  TI ADS7846 touchscreen controller on SSP bus
> +
> +-  Maxim MAX1111 analog-digital converter on |I2C| bus
> +
> +-  GPIO-connected keyboard controller and LEDs
> +
> +-  Secure Digital card connected to PXA MMC/SD host
> +
> +-  Three on-chip UARTs
> +
> +-  WM8750 audio CODEC on |I2C| and |I2S| busses
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index d2a3b44ce88..c7df6fc1f97 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -3,215 +3,16 @@
>  ARM System emulator
>  -------------------
>=20=20
> -Use the executable ``qemu-system-arm`` to simulate a ARM machine. The
> -ARM Integrator/CP board is emulated with the following devices:
> -
> --  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
> -
> --  Two PL011 UARTs
> -
> --  SMC 91c111 Ethernet adapter
> -
> --  PL110 LCD controller
> -
> --  PL050 KMI with PS/2 keyboard and mouse.
> -
> --  PL181 MultiMedia Card Interface with SD card.
> -
> -The ARM Versatile baseboard is emulated with the following devices:
> -
> --  ARM926E, ARM1136 or Cortex-A8 CPU
> -
> --  PL190 Vectored Interrupt Controller
> -
> --  Four PL011 UARTs
> -
> --  SMC 91c111 Ethernet adapter
> -
> --  PL110 LCD controller
> -
> --  PL050 KMI with PS/2 keyboard and mouse.
> -
> --  PCI host bridge. Note the emulated PCI bridge only provides access
> -   to PCI memory space. It does not provide access to PCI IO space. This
> -   means some devices (eg. ne2k_pci NIC) are not usable, and others (eg.
> -   rtl8139 NIC) are only usable when the guest drivers use the memory
> -   mapped control registers.
> -
> --  PCI OHCI USB controller.
> -
> --  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
> -   devices.
> -
> --  PL181 MultiMedia Card Interface with SD card.
> -
> -Several variants of the ARM RealView baseboard are emulated, including
> -the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only
> -certain Linux kernel configurations work out of the box on these boards.
> -
> -Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> -enabled in the kernel, and expect 512M RAM. Kernels for The PBX-A9 board
> -should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> -disabled and expect 1024M RAM.
> -
> -The following devices are emulated:
> -
> --  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
> -
> --  ARM AMBA Generic/Distributed Interrupt Controller
> -
> --  Four PL011 UARTs
> -
> --  SMC 91c111 or SMSC LAN9118 Ethernet adapter
> -
> --  PL110 LCD controller
> -
> --  PL050 KMI with PS/2 keyboard and mouse
> -
> --  PCI host bridge
> -
> --  PCI OHCI USB controller
> -
> --  LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM
> -   devices
> -
> --  PL181 MultiMedia Card Interface with SD card.
> -
> -The XScale-based clamshell PDA models (\"Spitz\", \"Akita\", \"Borzoi\"
> -and \"Terrier\") emulation includes the following peripherals:
> -
> --  Intel PXA270 System-on-chip (ARM V5TE core)
> -
> --  NAND Flash memory
> -
> --  IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \"Akita\"
> -
> --  On-chip OHCI USB controller
> -
> --  On-chip LCD controller
> -
> --  On-chip Real Time Clock
> -
> --  TI ADS7846 touchscreen controller on SSP bus
> -
> --  Maxim MAX1111 analog-digital converter on |I2C| bus
> -
> --  GPIO-connected keyboard controller and LEDs
> -
> --  Secure Digital card connected to PXA MMC/SD host
> -
> --  Three on-chip UARTs
> -
> --  WM8750 audio CODEC on |I2C| and |I2S| busses
> -
> -The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
> -following elements:
> -
> --  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> -
> --  ROM and RAM memories (ROM firmware image can be loaded with
> -   -option-rom)
> -
> --  On-chip LCD controller
> -
> --  On-chip Real Time Clock
> -
> --  TI TSC2102i touchscreen controller / analog-digital converter /
> -   Audio CODEC, connected through MicroWire and |I2S| busses
> -
> --  GPIO-connected matrix keypad
> -
> --  Secure Digital card connected to OMAP MMC/SD host
> -
> --  Three on-chip UARTs
> -
> -Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
> -48) emulation supports the following elements:
> -
> --  Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
> -
> --  RAM and non-volatile OneNAND Flash memories
> -
> --  Display connected to EPSON remote framebuffer chip and OMAP on-chip
> -   display controller and a LS041y3 MIPI DBI-C controller
> -
> --  TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen
> -   controllers driven through SPI bus
> -
> --  National Semiconductor LM8323-controlled qwerty keyboard driven
> -   through |I2C| bus
> -
> --  Secure Digital card connected to OMAP MMC/SD host
> -
> --  Three OMAP on-chip UARTs and on-chip STI debugging console
> -
> --  Mentor Graphics \"Inventra\" dual-role USB controller embedded in a
> -   TI TUSB6010 chip - only USB host mode is supported
> -
> --  TI TMP105 temperature sensor driven through |I2C| bus
> -
> --  TI TWL92230C power management companion with an RTC on
> -   |I2C| bus
> -
> --  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
> -   through CBUS
> -
> -The Luminary Micro Stellaris LM3S811EVB emulation includes the following
> -devices:
> -
> --  Cortex-M3 CPU core.
> -
> --  64k Flash and 8k SRAM.
> -
> --  Timers, UARTs, ADC and |I2C| interface.
> -
> --  OSRAM Pictiva 96x16 OLED with SSD0303 controller on
> -   |I2C| bus.
> -
> -The Luminary Micro Stellaris LM3S6965EVB emulation includes the
> -following devices:
> -
> --  Cortex-M3 CPU core.
> -
> --  256k Flash and 64k SRAM.
> -
> --  Timers, UARTs, ADC, |I2C| and SSI interfaces.
> -
> --  OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via
> -   SSI.
> -
> -The Freecom MusicPal internet radio emulation includes the following
> -elements:
> -
> --  Marvell MV88W8618 ARM core.
> -
> --  32 MB RAM, 256 KB SRAM, 8 MB flash.
> -
> --  Up to 2 16550 UARTs
> -
> --  MV88W8xx8 Ethernet controller
> -
> --  MV88W8618 audio controller, WM8750 CODEC and mixer
> -
> --  128x64 display with brightness control
> -
> --  2 buttons, 2 navigation wheels with button function
> -
> -The Siemens SX1 models v1 and v2 (default) basic emulation. The
> -emulation includes the following elements:
> -
> --  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> -
> --  ROM and RAM memories (ROM firmware image can be loaded with
> -   -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB
> -
> --  On-chip LCD controller
> -
> --  On-chip Real Time Clock
> -
> --  Secure Digital card connected to OMAP MMC/SD host
> -
> --  Three on-chip UARTs
> -
> -A Linux 2.6 test image is available on the QEMU web site. More
> -information is available in the QEMU mailing-list archive.
> +Use the executable ``qemu-system-arm`` to simulate a ARM machine.
> +
> +.. toctree::
> +
> +   arm/integratorcp
> +   arm/versatile
> +   arm/realview
> +   arm/xscale
> +   arm/palm
> +   arm/nseries
> +   arm/stellaris
> +   arm/musicpal
> +   arm/sx1


--=20
Alex Benn=C3=A9e

