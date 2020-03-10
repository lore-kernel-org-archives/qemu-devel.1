Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E330C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B338C222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6XB9PjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B338C222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBluQ-0001YP-Rx
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBltJ-0008U7-Fg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBltE-0007eR-2C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:54:17 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131]:37184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBlt4-0007DS-7a; Tue, 10 Mar 2020 16:54:02 -0400
Received: by mail-il1-x131.google.com with SMTP id a6so13351737ilc.4;
 Tue, 10 Mar 2020 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lUFLPcazjwZSnqvjJ233PgYZdDDi3AdDtEXYGJBfnnA=;
 b=p6XB9PjBOe73aWYYgqMDxL3RKpFyxo/RITHtLMx5d7yzTTuRuTwF9LWN6HRagcibfp
 kEvqed6YF0aXIcrV0UB4Ed+lZWd7ob4cy5IZS6ExaUDMMt+Nh984QpFdvTVjK/Ps8ToL
 3L3mcEf0Y+Hw64d8IveNjQXfNH85inu5HbGca+wBP9cChaDNrN2iqWYBu6FNzfudse7Y
 TDMAagk5xia5av/8KE5QWRW2NdhHMfWSmrMDs3Bom8kDw9tNg1GUeLkfyRKN/FUtSn6t
 5wNff3idegjhjhRguwJRL7hQrSZQY/uQi7otKeSekpsqMuZf29wIXcQhRFys5XgPYRGo
 Ijxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lUFLPcazjwZSnqvjJ233PgYZdDDi3AdDtEXYGJBfnnA=;
 b=isFQ2LSqedLP9pXO/FJm5p6LXDlwdtFoQEEwDHVt3dxLAYk4qiYv12aAMU2LEO6BI7
 woXqOxQLPvxWvnqomAAyzOAqK9TXFF8nujTW6lsWPtpJ+6aFHUaUm+s5Mg93nYOl72S9
 1+kJ8mv6sRViq/dymWg0/d0AzixzjrgRqW/fs2TcmzExeAJOLycBOTZXc4sVBnqr7Ohf
 kryWyWTzly06REdFd64X69Qw2D2nBOh29CSD3ra8Ul0o36ncFBt1CUJxFFEau+Ac+r8v
 7sTVjrT4qe+CKxm3+Rf3NURv+PRqGN43xiyAShsiS84Ph21J0UWzrJWj0Gw4Piv8qSbX
 UhZA==
X-Gm-Message-State: ANhLgQ21OatZ6pUt6m3GK1uHw4HlE5XURjuDkv54Xy6pIri/F59Jyv0q
 CXSG7OYNfrx6sy6f2F3PY4+umOWBjfeXaHdKgkc=
X-Google-Smtp-Source: ADFU+vt9DxKNusQWtqNLjPXmRgKd1yCpYpubAhkiVDhcOuJc7SV4zqcoUAsT64H3BI+jMf9USgQUYpaDL8goiEJRRLw=
X-Received: by 2002:a92:58d0:: with SMTP id z77mr13745382ilf.67.1583873641302; 
 Tue, 10 Mar 2020 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-3-peter.maydell@linaro.org>
In-Reply-To: <20200309215818.2021-3-peter.maydell@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 21:53:49 +0100
Message-ID: <CAPan3Wo9XH8ziPTjFJJa=q4p9bXd-VzA2DkL+iApHOZm0rnS7w@mail.gmail.com>
Subject: Re: [PATCH 2/5] docs/system: Split target-arm.rst into sub-documents
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c2505b05a0865193"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::131
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c2505b05a0865193
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Mon, Mar 9, 2020 at 10:58 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

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
>
>  ARM SMMU
>  M: Eric Auger <eric.auger@redhat.com>
> @@ -615,6 +616,7 @@ F: hw/arm/integratorcp.c
>  F: hw/misc/arm_integrator_debug.c
>  F: include/hw/misc/arm_integrator_debug.h
>  F: tests/acceptance/machine_arm_integratorcp.py
> +F: docs/system/arm/integratorcp.rst
>
>  MCIMX6UL EVK / i.MX6ul
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -673,6 +675,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/musicpal.c
> +F: docs/system/arm/musicpal.rst
>
>  nSeries
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -689,6 +692,7 @@ F: include/hw/display/blizzard.h
>  F: include/hw/input/tsc2xxx.h
>  F: include/hw/misc/cbus.h
>  F: tests/acceptance/machine_arm_n8x0.py
> +F: docs/system/arm/nseries.rst
>
>  Palm
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -698,6 +702,7 @@ S: Odd Fixes
>  F: hw/arm/palm.c
>  F: hw/input/tsc210x.c
>  F: include/hw/input/tsc2xxx.h
> +F: docs/system/arm/palm.rst
>
>  Raspberry Pi
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -719,6 +724,7 @@ F: hw/arm/realview*
>  F: hw/cpu/realview_mpcore.c
>  F: hw/intc/realview_gic.c
>  F: include/hw/intc/realview_gic.h
> +F: docs/system/arm/realview.rst
>
>  PXA2XX
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -738,6 +744,7 @@ F: hw/misc/max111x.c
>  F: include/hw/arm/pxa.h
>  F: include/hw/arm/sharpsl.h
>  F: include/hw/display/tc6393xb.h
> +F: docs/system/arm/xscale.rst
>
>  SABRELITE / i.MX6
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -773,6 +780,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/stellaris*
>  F: include/hw/input/gamepad.h
> +F: docs/system/arm/stellaris.rst
>
>  Versatile Express
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -786,6 +794,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/versatile*
>  F: hw/misc/arm_sysctl.c
> +F: docs/system/arm/versatile.rst
>
>  Virt
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/docs/system/arm/integratorcp.rst
> b/docs/system/arm/integratorcp.rst
> new file mode 100644
> index 00000000000..3232b43a08b
> --- /dev/null
> +++ b/docs/system/arm/integratorcp.rst
> @@ -0,0 +1,16 @@
> +Integrator/CP (``integratorcp``)
> +================================
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
> +===============================
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
> +================================================
>
+
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
> +=================================
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
> +Arm Realview boards (``realview-eb``, ``realview-eb-mpcore``,
> ``realview-pb-a8``, ``realview-pbx-a9``)
>
> +======================================================================================================
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
> +==================================================
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
> +=================================
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
> +=======================================================
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
> +Sharp XScale-based PDA models (``akita``, ``borzoi``, ``spitz``,
> ``terrier``)
>
> +=============================================================================
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
>
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
> --
> 2.20.1
>
>

-- 
Niek Linnenbank

--000000000000c2505b05a0865193
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2020 at 10:58 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.o=
rg">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Currently the documentation for Arm system emul=
ator targets is in a<br>
single target-arm.rst.=C2=A0 This describes only some of the boards and<br>
often in a fairly abbreviated fashion. Restructure it so that each<br>
board has its own documentation file in the docs/system/arm/<br>
subdirectory.<br>
<br>
This will hopefully encourage us to write board documentation that<br>
describes the board in detail, rather than a few brief paragraphs<br>
in a single long page. The table of contents should also help users<br>
to find the board they care about faster.<br>
<br>
Once the structure is in place we&#39;ll be able to move microvm.rst<br>
from the top-level docs/ directory.<br>
<br>
All the text from the old page is retained, except for the final<br>
paragraph (&quot;A Linux 2.6 test image is available on the QEMU web site.<=
br>
More information is available in the QEMU mailing-list archive.&quot;),<br>
which is deleted. The git history shows this was originally added<br>
in reference to the integratorcp board (at that time the only<br>
Arm board that was supported), and has subsequently gradually been<br>
further and further separated from the integratorcp documentation<br>
by the insertion of other board documentation sections. It&#39;s<br>
extremely out of date and no longer accurate, since AFAICT there<br>
isn&#39;t an integratorcp kernel on the website any more; so better<br>
deleted than retained.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
A subsequent patch will add some text that at least gestures<br>
in the direction of some of the more obvious missing info,<br>
eg 64-bit boards.<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 ++<br>
=C2=A0docs/system/arm/integratorcp.rst |=C2=A0 16 +++<br>
=C2=A0docs/system/arm/musicpal.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 19 +++<br>
=C2=A0docs/system/arm/nseries.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 33 +++++<br>
=C2=A0docs/system/arm/palm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 =
++++<br>
=C2=A0docs/system/arm/realview.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 34 +++++<br>
=C2=A0docs/system/arm/stellaris.rst=C2=A0 =C2=A0 |=C2=A0 26 ++++<br>
=C2=A0docs/system/arm/sx1.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 =
+++<br>
=C2=A0docs/system/arm/versatile.rst=C2=A0 =C2=A0 |=C2=A0 29 ++++<br>
=C2=A0docs/system/arm/xscale.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 29 ++++<=
br>
=C2=A0docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 225 ++--------=
---------------------<br>
=C2=A011 files changed, 249 insertions(+), 212 deletions(-)<br>
=C2=A0create mode 100644 docs/system/arm/integratorcp.rst<br>
=C2=A0create mode 100644 docs/system/arm/musicpal.rst<br>
=C2=A0create mode 100644 docs/system/arm/nseries.rst<br>
=C2=A0create mode 100644 docs/system/arm/palm.rst<br>
=C2=A0create mode 100644 docs/system/arm/realview.rst<br>
=C2=A0create mode 100644 docs/system/arm/stellaris.rst<br>
=C2=A0create mode 100644 docs/system/arm/sx1.rst<br>
=C2=A0create mode 100644 docs/system/arm/versatile.rst<br>
=C2=A0create mode 100644 docs/system/arm/xscale.rst<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 36d0c6887a9..31a1b423df1 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -155,6 +155,7 @@ F: include/hw/cpu/a*mpcore.h<br>
=C2=A0F: disas/arm.c<br>
=C2=A0F: disas/arm-a64.cc<br>
=C2=A0F: disas/libvixl/<br>
+F: docs/system/target-arm.rst<br>
<br>
=C2=A0ARM SMMU<br>
=C2=A0M: Eric Auger &lt;<a href=3D"mailto:eric.auger@redhat.com" target=3D"=
_blank">eric.auger@redhat.com</a>&gt;<br>
@@ -615,6 +616,7 @@ F: hw/arm/integratorcp.c<br>
=C2=A0F: hw/misc/arm_integrator_debug.c<br>
=C2=A0F: include/hw/misc/arm_integrator_debug.h<br>
=C2=A0F: tests/acceptance/machine_arm_integratorcp.py<br>
+F: docs/system/arm/integratorcp.rst<br>
<br>
=C2=A0MCIMX6UL EVK / i.MX6ul<br>
=C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" targ=
et=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
@@ -673,6 +675,7 @@ M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@li=
naro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
=C2=A0L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank">qemu-arm@=
nongnu.org</a><br>
=C2=A0S: Odd Fixes<br>
=C2=A0F: hw/arm/musicpal.c<br>
+F: docs/system/arm/musicpal.rst<br>
<br>
=C2=A0nSeries<br>
=C2=A0M: Andrzej Zaborowski &lt;<a href=3D"mailto:balrogg@gmail.com" target=
=3D"_blank">balrogg@gmail.com</a>&gt;<br>
@@ -689,6 +692,7 @@ F: include/hw/display/blizzard.h<br>
=C2=A0F: include/hw/input/tsc2xxx.h<br>
=C2=A0F: include/hw/misc/cbus.h<br>
=C2=A0F: tests/acceptance/machine_arm_n8x0.py<br>
+F: docs/system/arm/nseries.rst<br>
<br>
=C2=A0Palm<br>
=C2=A0M: Andrzej Zaborowski &lt;<a href=3D"mailto:balrogg@gmail.com" target=
=3D"_blank">balrogg@gmail.com</a>&gt;<br>
@@ -698,6 +702,7 @@ S: Odd Fixes<br>
=C2=A0F: hw/arm/palm.c<br>
=C2=A0F: hw/input/tsc210x.c<br>
=C2=A0F: include/hw/input/tsc2xxx.h<br>
+F: docs/system/arm/palm.rst<br>
<br>
=C2=A0Raspberry Pi<br>
=C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" targ=
et=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
@@ -719,6 +724,7 @@ F: hw/arm/realview*<br>
=C2=A0F: hw/cpu/realview_mpcore.c<br>
=C2=A0F: hw/intc/realview_gic.c<br>
=C2=A0F: include/hw/intc/realview_gic.h<br>
+F: docs/system/arm/realview.rst<br>
<br>
=C2=A0PXA2XX<br>
=C2=A0M: Andrzej Zaborowski &lt;<a href=3D"mailto:balrogg@gmail.com" target=
=3D"_blank">balrogg@gmail.com</a>&gt;<br>
@@ -738,6 +744,7 @@ F: hw/misc/max111x.c<br>
=C2=A0F: include/hw/arm/pxa.h<br>
=C2=A0F: include/hw/arm/sharpsl.h<br>
=C2=A0F: include/hw/display/tc6393xb.h<br>
+F: docs/system/arm/xscale.rst<br>
<br>
=C2=A0SABRELITE / i.MX6<br>
=C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" targ=
et=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
@@ -773,6 +780,7 @@ L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_bl=
ank">qemu-arm@nongnu.org</a><br>
=C2=A0S: Maintained<br>
=C2=A0F: hw/*/stellaris*<br>
=C2=A0F: include/hw/input/gamepad.h<br>
+F: docs/system/arm/stellaris.rst<br>
<br>
=C2=A0Versatile Express<br>
=C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" targ=
et=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
@@ -786,6 +794,7 @@ L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_bl=
ank">qemu-arm@nongnu.org</a><br>
=C2=A0S: Maintained<br>
=C2=A0F: hw/*/versatile*<br>
=C2=A0F: hw/misc/arm_sysctl.c<br>
+F: docs/system/arm/versatile.rst<br>
<br>
=C2=A0Virt<br>
=C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" targ=
et=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integratorc=
p.rst<br>
new file mode 100644<br>
index 00000000000..3232b43a08b<br>
--- /dev/null<br>
+++ b/docs/system/arm/integratorcp.rst<br>
@@ -0,0 +1,16 @@<br>
+Integrator/CP (``integratorcp``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+The ARM Integrator/CP board is emulated with the following devices:<br>
+<br>
+-=C2=A0 ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU<br>
+<br>
+-=C2=A0 Two PL011 UARTs<br>
+<br>
+-=C2=A0 SMC 91c111 Ethernet adapter<br>
+<br>
+-=C2=A0 PL110 LCD controller<br>
+<br>
+-=C2=A0 PL050 KMI with PS/2 keyboard and mouse.<br>
+<br>
+-=C2=A0 PL181 MultiMedia Card Interface with SD card.<br>
diff --git a/docs/system/arm/musicpal.rst b/docs/system/arm/musicpal.rst<br=
>
new file mode 100644<br>
index 00000000000..35c22212486<br>
--- /dev/null<br>
+++ b/docs/system/arm/musicpal.rst<br>
@@ -0,0 +1,19 @@<br>
+Freecom MusicPal (``musicpal``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+The Freecom MusicPal internet radio emulation includes the following<br>
+elements:<br>
+<br>
+-=C2=A0 Marvell MV88W8618 ARM core.<br>
+<br>
+-=C2=A0 32 MB RAM, 256 KB SRAM, 8 MB flash.<br>
+<br>
+-=C2=A0 Up to 2 16550 UARTs<br>
+<br>
+-=C2=A0 MV88W8xx8 Ethernet controller<br>
+<br>
+-=C2=A0 MV88W8618 audio controller, WM8750 CODEC and mixer<br>
+<br>
+-=C2=A0 128x64 display with brightness control<br>
+<br>
+-=C2=A0 2 buttons, 2 navigation wheels with button function<br>
diff --git a/docs/system/arm/nseries.rst b/docs/system/arm/nseries.rst<br>
new file mode 100644<br>
index 00000000000..b000b6d13bb<br>
--- /dev/null<br>
+++ b/docs/system/arm/nseries.rst<br>
@@ -0,0 +1,33 @@<br>
+Nokia N800 and N810 tablets (``n800``, ``n810``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /<br>
+48) emulation supports the following elements:<br>
+<br>
+-=C2=A0 Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)<br>
+<br>
+-=C2=A0 RAM and non-volatile OneNAND Flash memories<br>
+<br>
+-=C2=A0 Display connected to EPSON remote framebuffer chip and OMAP on-chi=
p<br>
+=C2=A0 =C2=A0display controller and a LS041y3 MIPI DBI-C controller<br>
+<br>
+-=C2=A0 TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen<br>
+=C2=A0 =C2=A0controllers driven through SPI bus<br>
+<br>
+-=C2=A0 National Semiconductor LM8323-controlled qwerty keyboard driven<br=
>
+=C2=A0 =C2=A0through |I2C| bus<br>
+<br>
+-=C2=A0 Secure Digital card connected to OMAP MMC/SD host<br>
+<br>
+-=C2=A0 Three OMAP on-chip UARTs and on-chip STI debugging console<br>
+<br>
+-=C2=A0 Mentor Graphics \&quot;Inventra\&quot; dual-role USB controller em=
bedded in a<br>
+=C2=A0 =C2=A0TI TUSB6010 chip - only USB host mode is supported<br>
+<br>
+-=C2=A0 TI TMP105 temperature sensor driven through |I2C| bus<br>
+<br>
+-=C2=A0 TI TWL92230C power management companion with an RTC on<br>
+=C2=A0 =C2=A0|I2C| bus<br>
+<br>
+-=C2=A0 Nokia RETU and TAHVO multi-purpose chips with an RTC, connected<br=
>
+=C2=A0 =C2=A0through CBUS<br>
diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst<br>
new file mode 100644<br>
index 00000000000..0eabf63e0e7<br>
--- /dev/null<br>
+++ b/docs/system/arm/palm.rst<br>
@@ -0,0 +1,23 @@<br>
+Palm Tungsten|E PDA (``cheetah``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+The Palm Tungsten|E PDA (codename \&quot;Cheetah\&quot;) emulation include=
s the<br>
+following elements:<br>
+<br>
+-=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM 925T core)<br>
+<br>
+-=C2=A0 ROM and RAM memories (ROM firmware image can be loaded with<br>
+=C2=A0 =C2=A0-option-rom)<br>
+<br>
+-=C2=A0 On-chip LCD controller<br>
+<br>
+-=C2=A0 On-chip Real Time Clock<br>
+<br>
+-=C2=A0 TI TSC2102i touchscreen controller / analog-digital converter /<br=
>
+=C2=A0 =C2=A0Audio CODEC, connected through MicroWire and |I2S| busses<br>
+<br>
+-=C2=A0 GPIO-connected matrix keypad<br>
+<br>
+-=C2=A0 Secure Digital card connected to OMAP MMC/SD host<br>
+<br>
+-=C2=A0 Three on-chip UARTs<br>
diff --git a/docs/system/arm/realview.rst b/docs/system/arm/realview.rst<br=
>
new file mode 100644<br>
index 00000000000..8e08eb5da16<br>
--- /dev/null<br>
+++ b/docs/system/arm/realview.rst<br>
@@ -0,0 +1,34 @@<br>
+Arm Realview boards (``realview-eb``, ``realview-eb-mpcore``, ``realview-p=
b-a8``, ``realview-pbx-a9``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
+<br>
+Several variants of the ARM RealView baseboard are emulated, including<br>
+the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only<br=
>
+certain Linux kernel configurations work out of the box on these boards.<b=
r>
+<br>
+Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET<b=
r>
+enabled in the kernel, and expect 512M RAM. Kernels for The PBX-A9 board<b=
r>
+should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET<br>
+disabled and expect 1024M RAM.<br>
+<br>
+The following devices are emulated:<br>
+<br>
+-=C2=A0 ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU<b=
r>
+<br>
+-=C2=A0 ARM AMBA Generic/Distributed Interrupt Controller<br>
+<br>
+-=C2=A0 Four PL011 UARTs<br>
+<br>
+-=C2=A0 SMC 91c111 or SMSC LAN9118 Ethernet adapter<br>
+<br>
+-=C2=A0 PL110 LCD controller<br>
+<br>
+-=C2=A0 PL050 KMI with PS/2 keyboard and mouse<br>
+<br>
+-=C2=A0 PCI host bridge<br>
+<br>
+-=C2=A0 PCI OHCI USB controller<br>
+<br>
+-=C2=A0 LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM<br>
+=C2=A0 =C2=A0devices<br>
+<br>
+-=C2=A0 PL181 MultiMedia Card Interface with SD card.<br>
diff --git a/docs/system/arm/stellaris.rst b/docs/system/arm/stellaris.rst<=
br>
new file mode 100644<br>
index 00000000000..8af4ad79c79<br>
--- /dev/null<br>
+++ b/docs/system/arm/stellaris.rst<br>
@@ -0,0 +1,26 @@<br>
+Stellaris boards (``lm3s6965evb``, ``lm3s811evb``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
+<br>
+The Luminary Micro Stellaris LM3S811EVB emulation includes the following<b=
r>
+devices:<br>
+<br>
+-=C2=A0 Cortex-M3 CPU core.<br>
+<br>
+-=C2=A0 64k Flash and 8k SRAM.<br>
+<br>
+-=C2=A0 Timers, UARTs, ADC and |I2C| interface.<br>
+<br>
+-=C2=A0 OSRAM Pictiva 96x16 OLED with SSD0303 controller on<br>
+=C2=A0 =C2=A0|I2C| bus.<br>
+<br>
+The Luminary Micro Stellaris LM3S6965EVB emulation includes the<br>
+following devices:<br>
+<br>
+-=C2=A0 Cortex-M3 CPU core.<br>
+<br>
+-=C2=A0 256k Flash and 64k SRAM.<br>
+<br>
+-=C2=A0 Timers, UARTs, ADC, |I2C| and SSI interfaces.<br>
+<br>
+-=C2=A0 OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via<br=
>
+=C2=A0 =C2=A0SSI.<br>
diff --git a/docs/system/arm/sx1.rst b/docs/system/arm/sx1.rst<br>
new file mode 100644<br>
index 00000000000..321993bc098<br>
--- /dev/null<br>
+++ b/docs/system/arm/sx1.rst<br>
@@ -0,0 +1,18 @@<br>
+Siemens SX1 (``sx1``, ``sx1-v1``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+The Siemens SX1 models v1 and v2 (default) basic emulation. The<br>
+emulation includes the following elements:<br>
+<br>
+-=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM 925T core)<br>
+<br>
+-=C2=A0 ROM and RAM memories (ROM firmware image can be loaded with<br>
+=C2=A0 =C2=A0-pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of =
32MB<br>
+<br>
+-=C2=A0 On-chip LCD controller<br>
+<br>
+-=C2=A0 On-chip Real Time Clock<br>
+<br>
+-=C2=A0 Secure Digital card connected to OMAP MMC/SD host<br>
+<br>
+-=C2=A0 Three on-chip UARTs<br>
diff --git a/docs/system/arm/versatile.rst b/docs/system/arm/versatile.rst<=
br>
new file mode 100644<br>
index 00000000000..48b6ca0a020<br>
--- /dev/null<br>
+++ b/docs/system/arm/versatile.rst<br>
@@ -0,0 +1,29 @@<br>
+Arm Versatile boards (``versatileab``, ``versatilepb``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
+<br>
+The ARM Versatile baseboard is emulated with the following devices:<br>
+<br>
+-=C2=A0 ARM926E, ARM1136 or Cortex-A8 CPU<br>
+<br>
+-=C2=A0 PL190 Vectored Interrupt Controller<br>
+<br>
+-=C2=A0 Four PL011 UARTs<br>
+<br>
+-=C2=A0 SMC 91c111 Ethernet adapter<br>
+<br>
+-=C2=A0 PL110 LCD controller<br>
+<br>
+-=C2=A0 PL050 KMI with PS/2 keyboard and mouse.<br>
+<br>
+-=C2=A0 PCI host bridge. Note the emulated PCI bridge only provides access=
<br>
+=C2=A0 =C2=A0to PCI memory space. It does not provide access to PCI IO spa=
ce. This<br>
+=C2=A0 =C2=A0means some devices (eg. ne2k_pci NIC) are not usable, and oth=
ers (eg.<br>
+=C2=A0 =C2=A0rtl8139 NIC) are only usable when the guest drivers use the m=
emory<br>
+=C2=A0 =C2=A0mapped control registers.<br>
+<br>
+-=C2=A0 PCI OHCI USB controller.<br>
+<br>
+-=C2=A0 LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM<br>
+=C2=A0 =C2=A0devices.<br>
+<br>
+-=C2=A0 PL181 MultiMedia Card Interface with SD card.<br>
diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst<br>
new file mode 100644<br>
index 00000000000..19da2eff352<br>
--- /dev/null<br>
+++ b/docs/system/arm/xscale.rst<br>
@@ -0,0 +1,29 @@<br>
+Sharp XScale-based PDA models (``akita``, ``borzoi``, ``spitz``, ``terrier=
``)<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
+<br>
+The XScale-based clamshell PDA models (\&quot;Spitz\&quot;, \&quot;Akita\&=
quot;, \&quot;Borzoi\&quot;<br>
+and \&quot;Terrier\&quot;) emulation includes the following peripherals:<b=
r>
+<br>
+-=C2=A0 Intel PXA270 System-on-chip (ARM V5TE core)<br>
+<br>
+-=C2=A0 NAND Flash memory<br>
+<br>
+-=C2=A0 IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \&quot;A=
kita\&quot;<br>
+<br>
+-=C2=A0 On-chip OHCI USB controller<br>
+<br>
+-=C2=A0 On-chip LCD controller<br>
+<br>
+-=C2=A0 On-chip Real Time Clock<br>
+<br>
+-=C2=A0 TI ADS7846 touchscreen controller on SSP bus<br>
+<br>
+-=C2=A0 Maxim MAX1111 analog-digital converter on |I2C| bus<br>
+<br>
+-=C2=A0 GPIO-connected keyboard controller and LEDs<br>
+<br>
+-=C2=A0 Secure Digital card connected to PXA MMC/SD host<br>
+<br>
+-=C2=A0 Three on-chip UARTs<br>
+<br>
+-=C2=A0 WM8750 audio CODEC on |I2C| and |I2S| busses<br>
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst<br>
index d2a3b44ce88..c7df6fc1f97 100644<br>
--- a/docs/system/target-arm.rst<br>
+++ b/docs/system/target-arm.rst<br>
@@ -3,215 +3,16 @@<br>
=C2=A0ARM System emulator<br>
=C2=A0-------------------<br>
<br>
-Use the executable ``qemu-system-arm`` to simulate a ARM machine. The<br>
-ARM Integrator/CP board is emulated with the following devices:<br>
-<br>
--=C2=A0 ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU<br>
-<br>
--=C2=A0 Two PL011 UARTs<br>
-<br>
--=C2=A0 SMC 91c111 Ethernet adapter<br>
-<br>
--=C2=A0 PL110 LCD controller<br>
-<br>
--=C2=A0 PL050 KMI with PS/2 keyboard and mouse.<br>
-<br>
--=C2=A0 PL181 MultiMedia Card Interface with SD card.<br>
-<br>
-The ARM Versatile baseboard is emulated with the following devices:<br>
-<br>
--=C2=A0 ARM926E, ARM1136 or Cortex-A8 CPU<br>
-<br>
--=C2=A0 PL190 Vectored Interrupt Controller<br>
-<br>
--=C2=A0 Four PL011 UARTs<br>
-<br>
--=C2=A0 SMC 91c111 Ethernet adapter<br>
-<br>
--=C2=A0 PL110 LCD controller<br>
-<br>
--=C2=A0 PL050 KMI with PS/2 keyboard and mouse.<br>
-<br>
--=C2=A0 PCI host bridge. Note the emulated PCI bridge only provides access=
<br>
-=C2=A0 =C2=A0to PCI memory space. It does not provide access to PCI IO spa=
ce. This<br>
-=C2=A0 =C2=A0means some devices (eg. ne2k_pci NIC) are not usable, and oth=
ers (eg.<br>
-=C2=A0 =C2=A0rtl8139 NIC) are only usable when the guest drivers use the m=
emory<br>
-=C2=A0 =C2=A0mapped control registers.<br>
-<br>
--=C2=A0 PCI OHCI USB controller.<br>
-<br>
--=C2=A0 LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM<br>
-=C2=A0 =C2=A0devices.<br>
-<br>
--=C2=A0 PL181 MultiMedia Card Interface with SD card.<br>
-<br>
-Several variants of the ARM RealView baseboard are emulated, including<br>
-the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only<br=
>
-certain Linux kernel configurations work out of the box on these boards.<b=
r>
-<br>
-Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET<b=
r>
-enabled in the kernel, and expect 512M RAM. Kernels for The PBX-A9 board<b=
r>
-should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET<br>
-disabled and expect 1024M RAM.<br>
-<br>
-The following devices are emulated:<br>
-<br>
--=C2=A0 ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU<b=
r>
-<br>
--=C2=A0 ARM AMBA Generic/Distributed Interrupt Controller<br>
-<br>
--=C2=A0 Four PL011 UARTs<br>
-<br>
--=C2=A0 SMC 91c111 or SMSC LAN9118 Ethernet adapter<br>
-<br>
--=C2=A0 PL110 LCD controller<br>
-<br>
--=C2=A0 PL050 KMI with PS/2 keyboard and mouse<br>
-<br>
--=C2=A0 PCI host bridge<br>
-<br>
--=C2=A0 PCI OHCI USB controller<br>
-<br>
--=C2=A0 LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM<br>
-=C2=A0 =C2=A0devices<br>
-<br>
--=C2=A0 PL181 MultiMedia Card Interface with SD card.<br>
-<br>
-The XScale-based clamshell PDA models (\&quot;Spitz\&quot;, \&quot;Akita\&=
quot;, \&quot;Borzoi\&quot;<br>
-and \&quot;Terrier\&quot;) emulation includes the following peripherals:<b=
r>
-<br>
--=C2=A0 Intel PXA270 System-on-chip (ARM V5TE core)<br>
-<br>
--=C2=A0 NAND Flash memory<br>
-<br>
--=C2=A0 IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \&quot;A=
kita\&quot;<br>
-<br>
--=C2=A0 On-chip OHCI USB controller<br>
-<br>
--=C2=A0 On-chip LCD controller<br>
-<br>
--=C2=A0 On-chip Real Time Clock<br>
-<br>
--=C2=A0 TI ADS7846 touchscreen controller on SSP bus<br>
-<br>
--=C2=A0 Maxim MAX1111 analog-digital converter on |I2C| bus<br>
-<br>
--=C2=A0 GPIO-connected keyboard controller and LEDs<br>
-<br>
--=C2=A0 Secure Digital card connected to PXA MMC/SD host<br>
-<br>
--=C2=A0 Three on-chip UARTs<br>
-<br>
--=C2=A0 WM8750 audio CODEC on |I2C| and |I2S| busses<br>
-<br>
-The Palm Tungsten|E PDA (codename \&quot;Cheetah\&quot;) emulation include=
s the<br>
-following elements:<br>
-<br>
--=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM 925T core)<br>
-<br>
--=C2=A0 ROM and RAM memories (ROM firmware image can be loaded with<br>
-=C2=A0 =C2=A0-option-rom)<br>
-<br>
--=C2=A0 On-chip LCD controller<br>
-<br>
--=C2=A0 On-chip Real Time Clock<br>
-<br>
--=C2=A0 TI TSC2102i touchscreen controller / analog-digital converter /<br=
>
-=C2=A0 =C2=A0Audio CODEC, connected through MicroWire and |I2S| busses<br>
-<br>
--=C2=A0 GPIO-connected matrix keypad<br>
-<br>
--=C2=A0 Secure Digital card connected to OMAP MMC/SD host<br>
-<br>
--=C2=A0 Three on-chip UARTs<br>
-<br>
-Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /<br>
-48) emulation supports the following elements:<br>
-<br>
--=C2=A0 Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)<br>
-<br>
--=C2=A0 RAM and non-volatile OneNAND Flash memories<br>
-<br>
--=C2=A0 Display connected to EPSON remote framebuffer chip and OMAP on-chi=
p<br>
-=C2=A0 =C2=A0display controller and a LS041y3 MIPI DBI-C controller<br>
-<br>
--=C2=A0 TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen<br>
-=C2=A0 =C2=A0controllers driven through SPI bus<br>
-<br>
--=C2=A0 National Semiconductor LM8323-controlled qwerty keyboard driven<br=
>
-=C2=A0 =C2=A0through |I2C| bus<br>
-<br>
--=C2=A0 Secure Digital card connected to OMAP MMC/SD host<br>
-<br>
--=C2=A0 Three OMAP on-chip UARTs and on-chip STI debugging console<br>
-<br>
--=C2=A0 Mentor Graphics \&quot;Inventra\&quot; dual-role USB controller em=
bedded in a<br>
-=C2=A0 =C2=A0TI TUSB6010 chip - only USB host mode is supported<br>
-<br>
--=C2=A0 TI TMP105 temperature sensor driven through |I2C| bus<br>
-<br>
--=C2=A0 TI TWL92230C power management companion with an RTC on<br>
-=C2=A0 =C2=A0|I2C| bus<br>
-<br>
--=C2=A0 Nokia RETU and TAHVO multi-purpose chips with an RTC, connected<br=
>
-=C2=A0 =C2=A0through CBUS<br>
-<br>
-The Luminary Micro Stellaris LM3S811EVB emulation includes the following<b=
r>
-devices:<br>
-<br>
--=C2=A0 Cortex-M3 CPU core.<br>
-<br>
--=C2=A0 64k Flash and 8k SRAM.<br>
-<br>
--=C2=A0 Timers, UARTs, ADC and |I2C| interface.<br>
-<br>
--=C2=A0 OSRAM Pictiva 96x16 OLED with SSD0303 controller on<br>
-=C2=A0 =C2=A0|I2C| bus.<br>
-<br>
-The Luminary Micro Stellaris LM3S6965EVB emulation includes the<br>
-following devices:<br>
-<br>
--=C2=A0 Cortex-M3 CPU core.<br>
-<br>
--=C2=A0 256k Flash and 64k SRAM.<br>
-<br>
--=C2=A0 Timers, UARTs, ADC, |I2C| and SSI interfaces.<br>
-<br>
--=C2=A0 OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via<br=
>
-=C2=A0 =C2=A0SSI.<br>
-<br>
-The Freecom MusicPal internet radio emulation includes the following<br>
-elements:<br>
-<br>
--=C2=A0 Marvell MV88W8618 ARM core.<br>
-<br>
--=C2=A0 32 MB RAM, 256 KB SRAM, 8 MB flash.<br>
-<br>
--=C2=A0 Up to 2 16550 UARTs<br>
-<br>
--=C2=A0 MV88W8xx8 Ethernet controller<br>
-<br>
--=C2=A0 MV88W8618 audio controller, WM8750 CODEC and mixer<br>
-<br>
--=C2=A0 128x64 display with brightness control<br>
-<br>
--=C2=A0 2 buttons, 2 navigation wheels with button function<br>
-<br>
-The Siemens SX1 models v1 and v2 (default) basic emulation. The<br>
-emulation includes the following elements:<br>
-<br>
--=C2=A0 Texas Instruments OMAP310 System-on-chip (ARM 925T core)<br>
-<br>
--=C2=A0 ROM and RAM memories (ROM firmware image can be loaded with<br>
-=C2=A0 =C2=A0-pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of =
32MB<br>
-<br>
--=C2=A0 On-chip LCD controller<br>
-<br>
--=C2=A0 On-chip Real Time Clock<br>
-<br>
--=C2=A0 Secure Digital card connected to OMAP MMC/SD host<br>
-<br>
--=C2=A0 Three on-chip UARTs<br>
-<br>
-A Linux 2.6 test image is available on the QEMU web site. More<br>
-information is available in the QEMU mailing-list archive.<br>
+Use the executable ``qemu-system-arm`` to simulate a ARM machine.<br>
+<br>
+.. toctree::<br>
+<br>
+=C2=A0 =C2=A0arm/integratorcp<br>
+=C2=A0 =C2=A0arm/versatile<br>
+=C2=A0 =C2=A0arm/realview<br>
+=C2=A0 =C2=A0arm/xscale<br>
+=C2=A0 =C2=A0arm/palm<br>
+=C2=A0 =C2=A0arm/nseries<br>
+=C2=A0 =C2=A0arm/stellaris<br>
+=C2=A0 =C2=A0arm/musicpal<br>
+=C2=A0 =C2=A0arm/sx1<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000c2505b05a0865193--

