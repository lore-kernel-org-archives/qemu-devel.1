Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C81DC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EB8206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGRj2AxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EB8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it97h-00084i-Fz
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 06:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1it96w-0007WW-En
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1it96t-0002lH-L7
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:51:22 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1it96t-0002l4-Bk; Sun, 19 Jan 2020 06:51:19 -0500
Received: by mail-il1-x144.google.com with SMTP id z12so25007007iln.11;
 Sun, 19 Jan 2020 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Z5hCkiejUKYZe5HGAm2SNriVtp+XM17RnOZJbpinqM=;
 b=WGRj2AxA8R+a2ZE0Eg2r810hTKmodkDBwMhHcjH0mNw/5VQt2O2AU214E1yx3UVV9r
 KvBYCew1mdwbiMnRxlutVMMkiQ/lllgL+Tyw3hqGQWTvIlfWuUtf+3jjIQ6r67qySkfk
 Dpbq4FNUI4KU7fzOWXD6bzeNPdkPX2xgeSRxEU8XH9+cRMCh16II/sgwYhHQBersuhay
 kNegvU0tVID9g/zAKbnznEfP3dUatwe2XOTkHgzsj85UCZG7pLtyTKVhqpUzAQZYiytF
 /qIFZYJTPXmFJwnYrv5sC4wL+ESLOWLytdpeD+8k0OkdD4yGgh+TIzlVS1JFF8D33Rz9
 G0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Z5hCkiejUKYZe5HGAm2SNriVtp+XM17RnOZJbpinqM=;
 b=murRaD5kmoJvEYVTE6s7a12xbP/y58OWVjtiKIUH5fs+JUomX1pa39IpHb6jX36wbH
 35wX9aVE6xGLLcF8vK2gy5Kuzk6/r+VhB6ABw+d/LOQy/qypJriornk6JSIFU8VzKNk4
 U6gUnrlsqoZ9CcWjVOBOPEdMbknd6oVRrd8HBhFN7EPffFBYcIK9Oi9wkRDgZd2Ws8Iz
 C/7Tzw051X9uyRbrQezBdaLvK+7k/7ape0VUkF2eQKCKpGPPH4z9MQsRcocDmKmQ4WMq
 s23WX8a8Wmqx2tzS2FhKDD2sN3/GNKsgNzSXIhS3Lou/+Qlm6R7fihxbgMoAHFdoNY7P
 pB2A==
X-Gm-Message-State: APjAAAUSC+qygAKW6Jrd7zHTOLVIgK81ko8HUwI/+X6T4IomBdG3axru
 z6NjDWuJUXF/CKx9RYhJCmyZkiSq9brELgeXms+bdaq3
X-Google-Smtp-Source: APXvYqyMeuQuhrOoNnINKQ2+hbcVpAeLdGx2MjXSmzpmDKX10Pnmc7dCUV+M8CA2a/cYd4oyqGyjJSWi/mErzAOCaLk=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr6338646ilq.306.1579434678460; 
 Sun, 19 Jan 2020 03:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
In-Reply-To: <20200119005102.3847-1-nieklinnenbank@gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 19 Jan 2020 12:51:06 +0100
Message-ID: <CAPan3Wo-DcUnf2Ct=H_-_DSD_RSYBM+dpAD4z0U=nqTYnDDOzw@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Add Allwinner H3 SoC and Orange Pi PC Machine
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f4a6d6059c7cca16"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 jasowang@redhat.com, b.galvani@gmail.com, qemu-arm <qemu-arm@nongnu.org>,
 imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f4a6d6059c7cca16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2020, 01:51 Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> Dear QEMU developers,
>
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
>
>  * SMP (Quad Core Cortex A7)
>  * Generic Interrupt Controller configuration
>  * SRAM mappings
>  * SDRAM controller
>  * Real Time Clock
>  * Timer device (re-used from Allwinner A10)
>  * UART
>  * SD/MMC storage controller
>  * EMAC ethernet connectivity
>  * USB 2.0 interfaces
>  * Clock Control Unit
>  * System Control module
>  * Security Identifier device
>
> Functionality related to graphical output such as HDMI, GPU,
> Display Engine and audio are not included. Recently released
> mainline Linux kernels (4.19 up to latest master), mainline U-Boot
> and NetBSD 9.0-RC1 are known to work.
>
> For full details on how to use the Orange Pi PC machine, see the file
> docs/orangepi.rst which is included as a patch in this series.
>
> The contents of this patch series is available on Github at:
>
>   https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v3


I forgot to update this link in the cover letter to v4. The correct link is=
:

https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v4


>
> The followings are currently known issues in this series:
>
>   - NetBSD 9.0-RC1 reads out year 2050 from RTC, while Linux works fine
>      -> This is due to difference in base year defined by the
> corresponding drivers
>   - RTC date & time is not persistent
>   - boot0 custom Allwinner bootloader not yet working
>   - Watchdog not yet implemented, affects U-Boot 'reset' and
> shutdown/reboot
>      -> This is part of the existing A10 timer that needs to be
> generalized first
>
> Looking forward to your review comments. I will do my best
> to update the patches where needed.
>
> =3D=3D=3D=3D=3D CHANGELOG =3D=3D=3D=3D=3D
> v4:
>  * docs/orangepi.rst: correct SDRAM size in board description: 512MB ->
> 1GiB
>  * hw/arm/orangepi.c: correct SDRAM size in commit message: 512MB -> 1GiB
>  * hw/arm/orangepi.c: set .nb_cpus in the orangepi_binfo struct static
> initialisation
>  * hw/arm/orangepi.c: remove .board_id from orangepi_binfo struct
>  * hw/arm/orangepi.c: move BIOS check to top of orangepi_init()
>  * hw/arm/orangepi.c: change clk1-freq argument 24000000 to 24 * 1000 *
> 1000 for readability
>  * hw/arm/orangepi.c: rephrase 1GiB check error message
>  * include/hw/arm/allwinner-h3.h: improved comments
>  * hw/arm/allwinner-h3.c: remove duplicate initialization and declaration
> of i variable
>  * hw/arm/allwinner-h3.c: use DEVICE(&s->cpus[i]) instead of qemu_get_cpu=
()
>  * hw/arm/allwinner-h3.c: use qdev API instead of object API in CPU
> initialization part
>  * hw/arm/allwinner-h3.c: add note that UARTs are connected to APB2_CLK,
> for future clocktree API
>  * hw/arm/allwinner-h3.c: extend commit message for Boot ROM with
> description for the 32KiB size
>  * hw/rtc/allwinner-rtc.c: correct usage of AwRtcClass->regmap_size for
> checking r/w offset
>  * hw/misc/allwinner-cpucfg.c: remove 64-bit counter, as it is unused by
> Linux/U-Boot/NetBSD
>  * hw/misc/allwinner-cpucfg.c: add CPU_EXCEPTION_LEVEL_ON_RESET constant
>  * hw/misc/allwinner-cpucfg.c: break instead of return after logging gues=
t
> error, for tracing
>  * hw/misc/allwinner-cpucfg.c: reduce duplication in switch/case for
> REG_CPUX_RST_CTRL in write function
>  * include/hw/rtc/allwinner-rtc.h: increase AW_RTC_REGS_MAXADDR to 0x200
>  * include/hw/rtc/allwinner-rtc.h: change type of AwRtcClass->year_offset
> to int, to match struct tm
>  * tests/acceptance/boot_linux_console.py: remove calls to vm.set_machine=
()
>  * tests/acceptance/boot_linux_console.py: added NetBSD test by Philippe
>  * docs/orangepi.rst: removed some unneeded words/typos
>  * docs/orangepi.rst: remove usage of -j5 for calling make (not all users
> have >=3D 4 SMP cores)
>  * include/hw/*/allwinner*.h: moved #include "qemu/osdep.h" and unneeded
> #includes to .c file
>
> v3: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg01534.html
>     https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v3
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03265.html
>     https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v2
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00320.html
>     https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v1
>
> With kind regards,
>
> Niek Linnenbank
>
> Niek Linnenbank (13):
>   hw/arm: add Allwinner H3 System-on-Chip
>   hw/arm: add Xunlong Orange Pi PC machine
>   hw/arm/allwinner-h3: add Clock Control Unit
>   hw/arm/allwinner-h3: add USB host controller
>   hw/arm/allwinner-h3: add System Control module
>   hw/arm/allwinner: add CPU Configuration module
>   hw/arm/allwinner: add Security Identifier device
>   hw/arm/allwinner: add SD/MMC host controller
>   hw/arm/allwinner-h3: add EMAC ethernet device
>   hw/arm/allwinner-h3: add Boot ROM support
>   hw/arm/allwinner-h3: add SDRAM controller device
>   hw/arm/allwinner: add RTC device support
>   docs: add Orange Pi PC document
>
> Philippe Mathieu-Daud=C3=A9 (7):
>   tests/boot_linux_console: Add a quick test for the OrangePi PC board
>   tests/boot_linux_console: Add initrd test for the Orange Pi PC board
>   tests/boot_linux_console: Add a SD card test for the OrangePi PC board
>   tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi
>     PC
>   Acceptance tests: Extract _console_interaction()
>   Acceptance tests: Add interrupt_interactive_console_until_pattern()
>   tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi
>     PC
>
>  docs/orangepi.rst                         | 199 +++++
>  default-configs/arm-softmmu.mak           |   1 +
>  hw/usb/hcd-ehci.h                         |   1 +
>  include/hw/arm/allwinner-a10.h            |   4 +
>  include/hw/arm/allwinner-h3.h             | 163 ++++
>  include/hw/misc/allwinner-cpucfg.h        |  52 ++
>  include/hw/misc/allwinner-h3-ccu.h        |  66 ++
>  include/hw/misc/allwinner-h3-dramc.h      | 106 +++
>  include/hw/misc/allwinner-h3-sysctrl.h    |  67 ++
>  include/hw/misc/allwinner-sid.h           |  60 ++
>  include/hw/net/allwinner-sun8i-emac.h     |  99 +++
>  include/hw/rtc/allwinner-rtc.h            | 128 ++++
>  include/hw/sd/allwinner-sdhost.h          | 135 ++++
>  hw/arm/allwinner-a10.c                    |  19 +
>  hw/arm/allwinner-h3.c                     | 476 ++++++++++++
>  hw/arm/cubieboard.c                       |  15 +
>  hw/arm/orangepi.c                         | 127 ++++
>  hw/misc/allwinner-cpucfg.c                | 269 +++++++
>  hw/misc/allwinner-h3-ccu.c                | 243 ++++++
>  hw/misc/allwinner-h3-dramc.c              | 358 +++++++++
>  hw/misc/allwinner-h3-sysctrl.c            | 140 ++++
>  hw/misc/allwinner-sid.c                   | 170 +++++
>  hw/net/allwinner-sun8i-emac.c             | 871 ++++++++++++++++++++++
>  hw/rtc/allwinner-rtc.c                    | 386 ++++++++++
>  hw/sd/allwinner-sdhost.c                  | 848 +++++++++++++++++++++
>  hw/usb/hcd-ehci-sysbus.c                  |  17 +
>  MAINTAINERS                               |   9 +
>  hw/arm/Kconfig                            |   9 +
>  hw/arm/Makefile.objs                      |   1 +
>  hw/misc/Makefile.objs                     |   5 +
>  hw/misc/trace-events                      |  19 +
>  hw/net/Kconfig                            |   3 +
>  hw/net/Makefile.objs                      |   1 +
>  hw/net/trace-events                       |  10 +
>  hw/rtc/Makefile.objs                      |   1 +
>  hw/rtc/trace-events                       |   4 +
>  hw/sd/Makefile.objs                       |   1 +
>  hw/sd/trace-events                        |   7 +
>  tests/acceptance/avocado_qemu/__init__.py |  59 +-
>  tests/acceptance/boot_linux_console.py    | 210 ++++++
>  40 files changed, 5345 insertions(+), 14 deletions(-)
>  create mode 100644 docs/orangepi.rst
>  create mode 100644 include/hw/arm/allwinner-h3.h
>  create mode 100644 include/hw/misc/allwinner-cpucfg.h
>  create mode 100644 include/hw/misc/allwinner-h3-ccu.h
>  create mode 100644 include/hw/misc/allwinner-h3-dramc.h
>  create mode 100644 include/hw/misc/allwinner-h3-sysctrl.h
>  create mode 100644 include/hw/misc/allwinner-sid.h
>  create mode 100644 include/hw/net/allwinner-sun8i-emac.h
>  create mode 100644 include/hw/rtc/allwinner-rtc.h
>  create mode 100644 include/hw/sd/allwinner-sdhost.h
>  create mode 100644 hw/arm/allwinner-h3.c
>  create mode 100644 hw/arm/orangepi.c
>  create mode 100644 hw/misc/allwinner-cpucfg.c
>  create mode 100644 hw/misc/allwinner-h3-ccu.c
>  create mode 100644 hw/misc/allwinner-h3-dramc.c
>  create mode 100644 hw/misc/allwinner-h3-sysctrl.c
>  create mode 100644 hw/misc/allwinner-sid.c
>  create mode 100644 hw/net/allwinner-sun8i-emac.c
>  create mode 100644 hw/rtc/allwinner-rtc.c
>  create mode 100644 hw/sd/allwinner-sdhost.c
>
> --
> 2.17.1
>

--000000000000f4a6d6059c7cca16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sun, Jan 19, 2020, 01:51 Niek Linnenbank &lt;<a hre=
f=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Dear QEMU developers,<br>
<br>
Hereby I would like to contribute the following set of patches to QEMU<br>
which add support for the Allwinner H3 System on Chip and the<br>
Orange Pi PC machine. The following features and devices are supported:<br>
<br>
=C2=A0* SMP (Quad Core Cortex A7)<br>
=C2=A0* Generic Interrupt Controller configuration<br>
=C2=A0* SRAM mappings<br>
=C2=A0* SDRAM controller<br>
=C2=A0* Real Time Clock<br>
=C2=A0* Timer device (re-used from Allwinner A10)<br>
=C2=A0* UART<br>
=C2=A0* SD/MMC storage controller<br>
=C2=A0* EMAC ethernet connectivity<br>
=C2=A0* USB 2.0 interfaces<br>
=C2=A0* Clock Control Unit<br>
=C2=A0* System Control module<br>
=C2=A0* Security Identifier device<br>
<br>
Functionality related to graphical output such as HDMI, GPU,<br>
Display Engine and audio are not included. Recently released<br>
mainline Linux kernels (4.19 up to latest master), mainline U-Boot<br>
and NetBSD 9.0-RC1 are known to work.<br>
<br>
For full details on how to use the Orange Pi PC machine, see the file<br>
docs/orangepi.rst which is included as a patch in this series.<br>
<br>
The contents of this patch series is available on Github at:<br>
<br>
=C2=A0 <a href=3D"https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-=
v3" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/niek=
linnenbank/qemu/tree/allwinner-h3-v3</a></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I forgot to update this link in the c=
over letter to v4. The correct link is:</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><a href=3D"https://github.com/nieklinnenbank/qemu/tree/allw=
inner-h3-v4">https://github.com/nieklinnenbank/qemu/tree/allwinner-h3-v4</a=
><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><br>
<br>
The followings are currently known issues in this series:<br>
<br>
=C2=A0 - NetBSD 9.0-RC1 reads out year 2050 from RTC, while Linux works fin=
e<br>
=C2=A0 =C2=A0 =C2=A0-&gt; This is due to difference in base year defined by=
 the corresponding drivers<br>
=C2=A0 - RTC date &amp; time is not persistent<br>
=C2=A0 - boot0 custom Allwinner bootloader not yet working<br>
=C2=A0 - Watchdog not yet implemented, affects U-Boot &#39;reset&#39; and s=
hutdown/reboot<br>
=C2=A0 =C2=A0 =C2=A0-&gt; This is part of the existing A10 timer that needs=
 to be generalized first<br>
<br>
Looking forward to your review comments. I will do my best<br>
to update the patches where needed.<br>
<br>
=3D=3D=3D=3D=3D CHANGELOG =3D=3D=3D=3D=3D<br>
v4:<br>
=C2=A0* docs/orangepi.rst: correct SDRAM size in board description: 512MB -=
&gt; 1GiB<br>
=C2=A0* hw/arm/orangepi.c: correct SDRAM size in commit message: 512MB -&gt=
; 1GiB<br>
=C2=A0* hw/arm/orangepi.c: set .nb_cpus in the orangepi_binfo struct static=
 initialisation<br>
=C2=A0* hw/arm/orangepi.c: remove .board_id from orangepi_binfo struct<br>
=C2=A0* hw/arm/orangepi.c: move BIOS check to top of orangepi_init()<br>
=C2=A0* hw/arm/orangepi.c: change clk1-freq argument 24000000 to 24 * 1000 =
* 1000 for readability<br>
=C2=A0* hw/arm/orangepi.c: rephrase 1GiB check error message<br>
=C2=A0* include/hw/arm/allwinner-h3.h: improved comments<br>
=C2=A0* hw/arm/allwinner-h3.c: remove duplicate initialization and declarat=
ion of i variable<br>
=C2=A0* hw/arm/allwinner-h3.c: use DEVICE(&amp;s-&gt;cpus[i]) instead of qe=
mu_get_cpu()<br>
=C2=A0* hw/arm/allwinner-h3.c: use qdev API instead of object API in CPU in=
itialization part<br>
=C2=A0* hw/arm/allwinner-h3.c: add note that UARTs are connected to APB2_CL=
K, for future clocktree API<br>
=C2=A0* hw/arm/allwinner-h3.c: extend commit message for Boot ROM with desc=
ription for the 32KiB size<br>
=C2=A0* hw/rtc/allwinner-rtc.c: correct usage of AwRtcClass-&gt;regmap_size=
 for checking r/w offset<br>
=C2=A0* hw/misc/allwinner-cpucfg.c: remove 64-bit counter, as it is unused =
by Linux/U-Boot/NetBSD<br>
=C2=A0* hw/misc/allwinner-cpucfg.c: add CPU_EXCEPTION_LEVEL_ON_RESET consta=
nt<br>
=C2=A0* hw/misc/allwinner-cpucfg.c: break instead of return after logging g=
uest error, for tracing<br>
=C2=A0* hw/misc/allwinner-cpucfg.c: reduce duplication in switch/case for R=
EG_CPUX_RST_CTRL in write function<br>
=C2=A0* include/hw/rtc/allwinner-rtc.h: increase AW_RTC_REGS_MAXADDR to 0x2=
00<br>
=C2=A0* include/hw/rtc/allwinner-rtc.h: change type of AwRtcClass-&gt;year_=
offset to int, to match struct tm<br>
=C2=A0* tests/acceptance/boot_linux_console.py: remove calls to vm.set_mach=
ine()<br>
=C2=A0* tests/acceptance/boot_linux_console.py: added NetBSD test by Philip=
pe<br>
=C2=A0* docs/orangepi.rst: removed some unneeded words/typos<br>
=C2=A0* docs/orangepi.rst: remove usage of -j5 for calling make (not all us=
ers have &gt;=3D 4 SMP cores)<br>
=C2=A0* include/hw/*/allwinner*.h: moved #include &quot;qemu/osdep.h&quot; =
and unneeded #includes to .c file<br>
<br>
v3: <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg015=
34.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.=
org/archive/html/qemu-devel/2020-01/msg01534.html</a><br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/nieklinnenbank/qemu/tree/allwin=
ner-h3-v3" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.c=
om/nieklinnenbank/qemu/tree/allwinner-h3-v3</a><br>
<br>
v2: <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg032=
65.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.=
org/archive/html/qemu-devel/2019-12/msg03265.html</a><br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/nieklinnenbank/qemu/tree/allwin=
ner-h3-v2" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.c=
om/nieklinnenbank/qemu/tree/allwinner-h3-v2</a><br>
<br>
v1: <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg003=
20.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.=
org/archive/html/qemu-devel/2019-12/msg00320.html</a><br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/nieklinnenbank/qemu/tree/allwin=
ner-h3-v1" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.c=
om/nieklinnenbank/qemu/tree/allwinner-h3-v1</a><br>
<br>
With kind regards,<br>
<br>
Niek Linnenbank<br>
<br>
Niek Linnenbank (13):<br>
=C2=A0 hw/arm: add Allwinner H3 System-on-Chip<br>
=C2=A0 hw/arm: add Xunlong Orange Pi PC machine<br>
=C2=A0 hw/arm/allwinner-h3: add Clock Control Unit<br>
=C2=A0 hw/arm/allwinner-h3: add USB host controller<br>
=C2=A0 hw/arm/allwinner-h3: add System Control module<br>
=C2=A0 hw/arm/allwinner: add CPU Configuration module<br>
=C2=A0 hw/arm/allwinner: add Security Identifier device<br>
=C2=A0 hw/arm/allwinner: add SD/MMC host controller<br>
=C2=A0 hw/arm/allwinner-h3: add EMAC ethernet device<br>
=C2=A0 hw/arm/allwinner-h3: add Boot ROM support<br>
=C2=A0 hw/arm/allwinner-h3: add SDRAM controller device<br>
=C2=A0 hw/arm/allwinner: add RTC device support<br>
=C2=A0 docs: add Orange Pi PC document<br>
<br>
Philippe Mathieu-Daud=C3=A9 (7):<br>
=C2=A0 tests/boot_linux_console: Add a quick test for the OrangePi PC board=
<br>
=C2=A0 tests/boot_linux_console: Add initrd test for the Orange Pi PC board=
<br>
=C2=A0 tests/boot_linux_console: Add a SD card test for the OrangePi PC boa=
rd<br>
=C2=A0 tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi=
<br>
=C2=A0 =C2=A0 PC<br>
=C2=A0 Acceptance tests: Extract _console_interaction()<br>
=C2=A0 Acceptance tests: Add interrupt_interactive_console_until_pattern()<=
br>
=C2=A0 tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi=
<br>
=C2=A0 =C2=A0 PC<br>
<br>
=C2=A0docs/orangepi.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 199 +++++<br>
=C2=A0default-configs/arm-softmmu.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/arm/allwinner-a10.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 163 ++++<br>
=C2=A0include/hw/misc/allwinner-cpucfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 52 ++<br>
=C2=A0include/hw/misc/allwinner-h3-ccu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 66 ++<br>
=C2=A0include/hw/misc/allwinner-h3-dramc.h=C2=A0 =C2=A0 =C2=A0 | 106 +++<br=
>
=C2=A0include/hw/misc/allwinner-h3-sysctrl.h=C2=A0 =C2=A0 |=C2=A0 67 ++<br>
=C2=A0include/hw/misc/allwinner-sid.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 60 ++<br>
=C2=A0include/hw/net/allwinner-sun8i-emac.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 99 +=
++<br>
=C2=A0include/hw/rtc/allwinner-rtc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 128 ++++<br>
=C2=A0include/hw/sd/allwinner-sdhost.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
135 ++++<br>
=C2=A0hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 +<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 476 ++++++++++++<br>
=C2=A0hw/arm/cubieboard.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +<br>
=C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 127 ++++<br>
=C2=A0hw/misc/allwinner-cpucfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 269 +++++++<br>
=C2=A0hw/misc/allwinner-h3-ccu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 243 ++++++<br>
=C2=A0hw/misc/allwinner-h3-dramc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 358 +++++++++<br>
=C2=A0hw/misc/allwinner-h3-sysctrl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 140 ++++<br>
=C2=A0hw/misc/allwinner-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 170 +++++<br>
=C2=A0hw/net/allwinner-sun8i-emac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 871 ++++++++++++++++++++++<br>
=C2=A0hw/rtc/allwinner-rtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 386 ++++++++++<br>
=C2=A0hw/sd/allwinner-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 848 +++++++++++++++++++++<br>
=C2=A0hw/usb/hcd-ehci-sysbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 17 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +<br=
>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 +<br>
=C2=A0hw/net/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/net/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +<br>
=C2=A0hw/rtc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/rtc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0tests/acceptance/avocado_qemu/__init__.py |=C2=A0 59 +-<br>
=C2=A0tests/acceptance/boot_linux_console.py=C2=A0 =C2=A0 | 210 ++++++<br>
=C2=A040 files changed, 5345 insertions(+), 14 deletions(-)<br>
=C2=A0create mode 100644 docs/orangepi.rst<br>
=C2=A0create mode 100644 include/hw/arm/allwinner-h3.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-cpucfg.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-ccu.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-dramc.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-sysctrl.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-sid.h<br>
=C2=A0create mode 100644 include/hw/net/allwinner-sun8i-emac.h<br>
=C2=A0create mode 100644 include/hw/rtc/allwinner-rtc.h<br>
=C2=A0create mode 100644 include/hw/sd/allwinner-sdhost.h<br>
=C2=A0create mode 100644 hw/arm/allwinner-h3.c<br>
=C2=A0create mode 100644 hw/arm/orangepi.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-cpucfg.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-ccu.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-dramc.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-sysctrl.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-sid.c<br>
=C2=A0create mode 100644 hw/net/allwinner-sun8i-emac.c<br>
=C2=A0create mode 100644 hw/rtc/allwinner-rtc.c<br>
=C2=A0create mode 100644 hw/sd/allwinner-sdhost.c<br>
<br>
-- <br>
2.17.1<br>
</blockquote></div></div></div>

--000000000000f4a6d6059c7cca16--

