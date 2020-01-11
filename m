Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9BC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 20:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678DF20842
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 20:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzG/XtrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678DF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqNet-0001vC-G8
	for qemu-devel@archiver.kernel.org; Sat, 11 Jan 2020 15:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iqNds-0001GJ-5r
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 15:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iqNdn-0000vE-97
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 15:45:55 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f]:33659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iqNdm-0000ph-QI; Sat, 11 Jan 2020 15:45:51 -0500
Received: by mail-il1-x12f.google.com with SMTP id v15so4711551iln.0;
 Sat, 11 Jan 2020 12:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z5xHQMA0ixVn1As3mCrgMIrT7Wu17O7dCP3n6MboRXg=;
 b=fzG/XtrK/C39dNzF1xIgy5oyRQNr2V+61uubp8clwjkkumWtEfhCWg4mb6LUorksiN
 eco/VpYwndxLv/rg3Xn+H0kEmpa1Zuaj4PbzjO3o9VfueShUQ0YP76mPMCXKe+m5Et+Y
 aMOooYSYZ2YkOMpnG3o93o4VvboSW5K7F8HDksTkUjoxzfo7cWMOR8K2zbAfTOvKi8+S
 VUWf2oKIEgkiINvgArAM8FEONS3KJRfUhvU1w7h30WR7PLQijE6RN3xoRW+NRDeeyXs6
 fTrKlg1y2IaJxzccLUCpJr2C6tTPZheRSJkEIkH8nWthjtZ6M67BBu5drBMLdjnCrOKb
 Qwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z5xHQMA0ixVn1As3mCrgMIrT7Wu17O7dCP3n6MboRXg=;
 b=TJpp9HfJzuzO4Z8DFu9C0rBwep6pzIntop/RCgM6mAQ7jgV9ASSftBSG19j7td6x9d
 3jjdtyeqgeq0yDsRkyxSLJ4HWV8jpfjO3hG//d0gWPZJec1Y6G4+HspTrJwVwKUCgY2o
 gCIlxuL8NAV06Ir5mNu9UWA9jsJQq/iRTPC58s3yFQmdZyrmN+ZUh7xaLdZpqOCWi+zC
 VcoeVL21TNxSOW2HN8INz179sxZ30us3Tl20hclLhD0U6RxNZwBwe2bJ0hs1xJlNk+ci
 JdGssUWoB4lY5LS+GO6Q+Oy7gos1fvVp1BL7nY4N7pBROUhF4mm8WHloFveA838KH8i5
 TrNQ==
X-Gm-Message-State: APjAAAXh5q9+mzORe0EJ898TZ0n//jfiUytvfImD06ZeAJP2pL/PmDik
 zrrl55hjKNjZiAh0bT9L1lufLkFXKydonLV5YNtasw==
X-Google-Smtp-Source: APXvYqyCjH3+HtaSmU3iWpToCwVBVqFLtio1IzIHpogB5yfedVyLhRRn2OtYF4Ox9bTHCHECE9Ug5RtNDTeuDjvVm+Q=
X-Received: by 2002:a92:a103:: with SMTP id v3mr8717725ili.265.1578775549832; 
 Sat, 11 Jan 2020 12:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-2-nieklinnenbank@gmail.com>
 <d1a13b5c-1308-17b3-601c-429a645ae7ec@redhat.com>
In-Reply-To: <d1a13b5c-1308-17b3-601c-429a645ae7ec@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 11 Jan 2020 21:45:38 +0100
Message-ID: <CAPan3WqHVroJQVrQfGTpUSbS7DZ94v61ThA1pLstH+9mhrkMpw@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] hw/arm: add Allwinner H3 System-on-Chip
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d3f4fd059be353c8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12f
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3f4fd059be353c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2020 at 12:13 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> > The Allwinner H3 is a System on Chip containing four ARM Cortex A7
> > processor cores. Features and specifications include DDR2/DDR3 memory,
> > SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and
>
> "Ethernet"
>
> > various I/O modules. This commit adds support for the Allwinner H3
> > System on Chip.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   default-configs/arm-softmmu.mak |   1 +
> >   include/hw/arm/allwinner-h3.h   | 107 +++++++++++
> >   hw/arm/allwinner-h3.c           | 328 +++++++++++++++++++++++++++++++=
+
> >   MAINTAINERS                     |   7 +
> >   hw/arm/Kconfig                  |   8 +
> >   hw/arm/Makefile.objs            |   1 +
> >   6 files changed, 452 insertions(+)
> >   create mode 100644 include/hw/arm/allwinner-h3.h
> >   create mode 100644 hw/arm/allwinner-h3.c
> >
> > diff --git a/default-configs/arm-softmmu.mak
> b/default-configs/arm-softmmu.mak
> > index 1f2e0e7fde..d75a239c2c 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=3Dy
> >   CONFIG_FSL_IMX7=3Dy
> >   CONFIG_FSL_IMX6UL=3Dy
> >   CONFIG_SEMIHOSTING=3Dy
> > +CONFIG_ALLWINNER_H3=3Dy
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > new file mode 100644
> > index 0000000000..4e2e6202a9
> > --- /dev/null
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -0,0 +1,107 @@
> > +/*
> > + * Allwinner H3 System on Chip emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +/*
> > + * The Allwinner H3 is a System on Chip containing four ARM Cortex A7
> > + * processor cores. Features and specifications include DDR2/DDR3
> memory,
> > + * SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and
> > + * various I/O modules.
> > + *
> > + * This implementation is based on the following datasheet:
> > + *
> > + *   https://linux-sunxi.org/File:Allwinner_H3_Datasheet_V1.2.pdf
> > + *
> > + * The latest datasheet and more info can be found on the Linux Sunxi
> wiki:
> > + *
> > + *   https://linux-sunxi.org/H3
> > + */
> > +
> > +#ifndef HW_ARM_ALLWINNER_H3_H
> > +#define HW_ARM_ALLWINNER_H3_H
> > +
> > +#include "qemu/osdep.h"
>
> Check CODING_STYLE.rst:
>
>    Do not include "qemu/osdep.h" from header files since
>    the .c file will have already included it.
>
> > +#include "qom/object.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/units.h"
> > +#include "hw/qdev-core.h"
> > +#include "hw/arm/boot.h"
>
> Please only keep the minimum required headers here, move the rest to the
> source files.
>
> > +#include "hw/timer/allwinner-a10-pit.h"
> > +#include "hw/intc/arm_gic.h"
> > +#include "target/arm/cpu.h"
>
> These looks OK in this header.
>
> Thanks, I'll also apply these changes to the other patches as well. I did
the same there.


> > +
> > +/**
> > + * Allwinner H3 device list
> > + *
> > + * This enumeration is can be used refer to a particular device in the
> > + * Allwinner H3 SoC. For example, the physical memory base address for
> > + * each device can be found in the AwH3State object in the memmap memb=
er
> > + * using the device enum value as index.
> > + *
> > + * @see AwH3State
> > + */
> > +enum {
> > +    AW_H3_SRAM_A1,
> > +    AW_H3_SRAM_A2,
> > +    AW_H3_SRAM_C,
> > +    AW_H3_PIT,
> > +    AW_H3_UART0,
> > +    AW_H3_UART1,
> > +    AW_H3_UART2,
> > +    AW_H3_UART3,
> > +    AW_H3_GIC_DIST,
> > +    AW_H3_GIC_CPU,
> > +    AW_H3_GIC_HYP,
> > +    AW_H3_GIC_VCPU,
> > +    AW_H3_SDRAM
> > +};
> > +
> > +/** Total number of CPU cores in the SoC */
>
> "the H3 SoC"
>
> > +#define AW_H3_NUM_CPUS      (4)
> > +
> > +/**
> > + * Allwinner H3 object model
> > + * @{
> > + */
> > +
> > +/** Object type for the Allwinner H3 SoC */
> > +#define TYPE_AW_H3 "allwinner-h3"
> > +
> > +/** Convert input object to Allwinner H3 state object */
> > +#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)
> > +
> > +/** @} */
> > +
> > +/**
> > + * Allwinner H3 object instance state
>
> I find this comment more noisy than helpful.
>
> > + */
> > +typedef struct AwH3State {
> > +    /*< private >*/
> > +    DeviceState parent_obj;
> > +    /*< public >*/
> > +
> > +    ARMCPU cpus[AW_H3_NUM_CPUS];
> > +    const hwaddr *memmap;
> > +    AwA10PITState timer;
> > +    GICState gic;
> > +    MemoryRegion sram_a1;
> > +    MemoryRegion sram_a2;
> > +    MemoryRegion sram_c;
> > +} AwH3State;
> > +
> > +#endif /* HW_ARM_ALLWINNER_H3_H */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > new file mode 100644
> > index 0000000000..c1ef31e875
> > --- /dev/null
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -0,0 +1,328 @@
> > +/*
> > + * Allwinner H3 System on Chip emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "exec/address-spaces.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "qemu/units.h"
> > +#include "cpu.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/char/serial.h"
> > +#include "hw/misc/unimp.h"
> > +#include "sysemu/sysemu.h"
> > +#include "hw/arm/allwinner-h3.h"
> > +
> > +/* Memory map */
> > +const hwaddr allwinner_h3_memmap[] =3D {
> > +    [AW_H3_SRAM_A1]    =3D 0x00000000,
> > +    [AW_H3_SRAM_A2]    =3D 0x00044000,
> > +    [AW_H3_SRAM_C]     =3D 0x00010000,
> > +    [AW_H3_PIT]        =3D 0x01c20c00,
> > +    [AW_H3_UART0]      =3D 0x01c28000,
> > +    [AW_H3_UART1]      =3D 0x01c28400,
> > +    [AW_H3_UART2]      =3D 0x01c28800,
> > +    [AW_H3_UART3]      =3D 0x01c28c00,
> > +    [AW_H3_GIC_DIST]   =3D 0x01c81000,
> > +    [AW_H3_GIC_CPU]    =3D 0x01c82000,
> > +    [AW_H3_GIC_HYP]    =3D 0x01c84000,
> > +    [AW_H3_GIC_VCPU]   =3D 0x01c86000,
> > +    [AW_H3_SDRAM]      =3D 0x40000000
> > +};
> > +
> > +/* List of unimplemented devices */
> > +struct AwH3Unimplemented {
> > +    const char *device_name;
> > +    hwaddr base;
> > +    hwaddr size;
> > +} unimplemented[] =3D {
> > +    { "d-engine",  0x01000000, 4 * MiB },
> > +    { "d-inter",   0x01400000, 128 * KiB },
> > +    { "syscon",    0x01c00000, 4 * KiB },
> > +    { "dma",       0x01c02000, 4 * KiB },
> > +    { "nfdc",      0x01c03000, 4 * KiB },
> > +    { "ts",        0x01c06000, 4 * KiB },
> > +    { "keymem",    0x01c0b000, 4 * KiB },
> > +    { "lcd0",      0x01c0c000, 4 * KiB },
> > +    { "lcd1",      0x01c0d000, 4 * KiB },
> > +    { "ve",        0x01c0e000, 4 * KiB },
> > +    { "mmc0",      0x01c0f000, 4 * KiB },
> > +    { "mmc1",      0x01c10000, 4 * KiB },
> > +    { "mmc2",      0x01c11000, 4 * KiB },
> > +    { "sid",       0x01c14000, 1 * KiB },
> > +    { "crypto",    0x01c15000, 4 * KiB },
> > +    { "msgbox",    0x01c17000, 4 * KiB },
> > +    { "spinlock",  0x01c18000, 4 * KiB },
> > +    { "usb0-otg",  0x01c19000, 4 * KiB },
> > +    { "usb0",      0x01c1a000, 4 * KiB },
> > +    { "usb1",      0x01c1b000, 4 * KiB },
> > +    { "usb2",      0x01c1c000, 4 * KiB },
> > +    { "usb3",      0x01c1d000, 4 * KiB },
>
> To avoid the churn in patch #4, directly name them usb-phy:
>
>         { "usb0-phy",  0x01c1a000, 4 * KiB },
>         { "usb1-phy",  0x01c1b000, 4 * KiB },
>         { "usb2-phy",  0x01c1c000, 4 * KiB },
>         { "usb3-phy",  0x01c1d000, 4 * KiB },
>
>
The reason I choose to do it like this is that in this patch all of the USB
devices are unimplemented (including the PHY).
In patch 4, the USB devices are implemented, except for the USB-PHY
specifics which aren't part of the OHCI/EHCI but
also not required to be fully emulated for a functional USB stack in the
guest.
So to make it clear that only the USB-PHY part remains unimplemented in
patch 4, I renamed it to 'usb*-phy' in patch 4.

Does that make sense, or would you like me to change it anyway?


> > +    { "smc",       0x01c1e000, 4 * KiB },
> > +    { "ccu",       0x01c20000, 1 * KiB },
> > +    { "pio",       0x01c20800, 1 * KiB },
> > +    { "owa",       0x01c21000, 1 * KiB },
> > +    { "pwm",       0x01c21400, 1 * KiB },
> > +    { "keyadc",    0x01c21800, 1 * KiB },
> > +    { "pcm0",      0x01c22000, 1 * KiB },
> > +    { "pcm1",      0x01c22400, 1 * KiB },
> > +    { "pcm2",      0x01c22800, 1 * KiB },
> > +    { "audio",     0x01c22c00, 2 * KiB },
> > +    { "smta",      0x01c23400, 1 * KiB },
> > +    { "ths",       0x01c25000, 1 * KiB },
> > +    { "uart0",     0x01c28000, 1 * KiB },
> > +    { "uart1",     0x01c28400, 1 * KiB },
> > +    { "uart2",     0x01c28800, 1 * KiB },
> > +    { "uart3",     0x01c28c00, 1 * KiB },
> > +    { "twi0",      0x01c2ac00, 1 * KiB },
> > +    { "twi1",      0x01c2b000, 1 * KiB },
> > +    { "twi2",      0x01c2b400, 1 * KiB },
> > +    { "scr",       0x01c2c400, 1 * KiB },
> > +    { "emac",      0x01c30000, 64 * KiB },
> > +    { "gpu",       0x01c40000, 64 * KiB },
> > +    { "hstmr",     0x01c60000, 4 * KiB },
> > +    { "dramcom",   0x01c62000, 4 * KiB },
> > +    { "dramctl0",  0x01c63000, 4 * KiB },
> > +    { "dramphy0",  0x01c65000, 4 * KiB },
> > +    { "spi0",      0x01c68000, 4 * KiB },
> > +    { "spi1",      0x01c69000, 4 * KiB },
> > +    { "csi",       0x01cb0000, 320 * KiB },
> > +    { "tve",       0x01e00000, 64 * KiB },
> > +    { "hdmi",      0x01ee0000, 128 * KiB },
> > +    { "rtc",       0x01f00000, 1 * KiB },
> > +    { "r_timer",   0x01f00800, 1 * KiB },
> > +    { "r_intc",    0x01f00c00, 1 * KiB },
> > +    { "r_wdog",    0x01f01000, 1 * KiB },
> > +    { "r_prcm",    0x01f01400, 1 * KiB },
> > +    { "r_twd",     0x01f01800, 1 * KiB },
> > +    { "r_cpucfg",  0x01f01c00, 1 * KiB },
> > +    { "r_cir-rx",  0x01f02000, 1 * KiB },
> > +    { "r_twi",     0x01f02400, 1 * KiB },
> > +    { "r_uart",    0x01f02800, 1 * KiB },
> > +    { "r_pio",     0x01f02c00, 1 * KiB },
> > +    { "r_pwm",     0x01f03800, 1 * KiB },
> > +    { "core-dbg",  0x3f500000, 128 * KiB },
> > +    { "tsgen-ro",  0x3f506000, 4 * KiB },
> > +    { "tsgen-ctl", 0x3f507000, 4 * KiB },
> > +    { "ddr-mem",   0x40000000, 2 * GiB },
> > +    { "n-brom",    0xffff0000, 32 * KiB },
> > +    { "s-brom",    0xffff0000, 64 * KiB }
> > +};
> > +
> > +/* Per Processor Interrupts */
> > +enum {
> > +    AW_H3_GIC_PPI_MAINT     =3D  9,
> > +    AW_H3_GIC_PPI_HYPTIMER  =3D 10,
> > +    AW_H3_GIC_PPI_VIRTTIMER =3D 11,
> > +    AW_H3_GIC_PPI_SECTIMER  =3D 13,
> > +    AW_H3_GIC_PPI_PHYSTIMER =3D 14
> > +};
> > +
> > +/* Shared Processor Interrupts */
> > +enum {
> > +    AW_H3_GIC_SPI_UART0     =3D  0,
> > +    AW_H3_GIC_SPI_UART1     =3D  1,
> > +    AW_H3_GIC_SPI_UART2     =3D  2,
> > +    AW_H3_GIC_SPI_UART3     =3D  3,
> > +    AW_H3_GIC_SPI_TIMER0    =3D 18,
> > +    AW_H3_GIC_SPI_TIMER1    =3D 19,
> > +};
> > +
> > +/* Allwinner H3 constants */
>
> Another not very useful comment.
>
> > +enum {
> > +    AW_H3_GIC_NUM_SPI       =3D 128
> > +};
> > +
> > +static void allwinner_h3_init(Object *obj)
> > +{
> > +    AwH3State *s =3D AW_H3(obj);
> > +
> > +    s->memmap =3D allwinner_h3_memmap;
> > +
> > +    for (int i =3D 0; i < AW_H3_NUM_CPUS; i++) {
> > +        object_initialize_child(obj, "cpu[*]", &s->cpus[i],
> sizeof(s->cpus[i]),
> > +                                ARM_CPU_TYPE_NAME("cortex-a7"),
> > +                                &error_abort, NULL);
> > +    }
> > +
> > +    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> > +                          TYPE_ARM_GIC);
> > +
> > +    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
> > +                          TYPE_AW_A10_PIT);
> > +    object_property_add_alias(obj, "clk0-freq", OBJECT(&s->timer),
> > +                              "clk0-freq", &error_abort);
> > +    object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
> > +                              "clk1-freq", &error_abort);
> > +}
> > +
> > +static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AwH3State *s =3D AW_H3(dev);
> > +    unsigned i =3D 0;
>
> No need to initialize i since you re-init it in the for().
>
> > +
> > +    /* CPUs */
> > +    for (i =3D 0; i < AW_H3_NUM_CPUS; i++) {
> > +
> > +        /* Provide Power State Coordination Interface */
> > +        object_property_set_int(OBJECT(&s->cpus[i]),
> QEMU_PSCI_CONDUIT_HVC,
> > +                                "psci-conduit", &error_abort);
> > +
> > +        /* Disable secondary CPUs */
> > +        object_property_set_bool(OBJECT(&s->cpus[i]), i > 0,
> > +                                "start-powered-off", &error_abort);
> > +
> > +        /* All exception levels required */
> > +        object_property_set_bool(OBJECT(&s->cpus[i]),
> > +                                 true, "has_el3", &error_abort);
> > +
> > +        object_property_set_bool(OBJECT(&s->cpus[i]),
> > +                                 true, "has_el2", &error_abort);
>
> You previously used the object API, ...
>
> > +
> > +        /* Mark realized */
> > +        qdev_init_nofail(DEVICE(&s->cpus[i]));
>
> ... and here switch to the qdev API. Odd.
>
> > +    }
> > +
> > +    /* Generic Interrupt Controller */
> > +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_H3_GIC_NUM_SPI=
 +
> > +                                                     GIC_INTERNAL);
> > +    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
> > +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H3_NUM_CPUS);
> > +    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions",
> false);
> > +    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions"=
,
> true);
> > +    qdev_init_nofail(DEVICE(&s->gic));
> > +
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> s->memmap[AW_H3_GIC_DIST]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
> s->memmap[AW_H3_GIC_CPU]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
> s->memmap[AW_H3_GIC_HYP]);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> s->memmap[AW_H3_GIC_VCPU]);
> > +
> > +    /*
> > +     * Wire the outputs from each CPU's generic timer and the GICv3
> > +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> > +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's
> inputs.
> > +     */
> > +    for (i =3D 0; i < AW_H3_NUM_CPUS; i++) {
> > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
>
> Why not use DEVICE(&s->cpus[i])?
>
> > +        int ppibase =3D AW_H3_GIC_NUM_SPI + i * GIC_INTERNAL +
> GIC_NR_SGIS;
> > +        int irq;
> > +        /*
> > +         * Mapping from the output timer irq lines from the CPU to the
> > +         * GIC PPI inputs used for this board.
> > +         */
> > +        const int timer_irq[] =3D {
> > +            [GTIMER_PHYS] =3D AW_H3_GIC_PPI_PHYSTIMER,
> > +            [GTIMER_VIRT] =3D AW_H3_GIC_PPI_VIRTTIMER,
> > +            [GTIMER_HYP]  =3D AW_H3_GIC_PPI_HYPTIMER,
> > +            [GTIMER_SEC]  =3D AW_H3_GIC_PPI_SECTIMER,
> > +        };
> > +
> > +        /* Connect CPU timer outputs to GIC PPI inputs */
> > +        for (irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> > +            qdev_connect_gpio_out(cpudev, irq,
> > +                                  qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                                   ppibase +
> timer_irq[irq]));
> > +        }
> > +
> > +        /* Connect GIC outputs to CPU interrupt inputs */
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + AW_H3_NUM_CPUS=
,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (2 *
> AW_H3_NUM_CPUS),
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (3 *
> AW_H3_NUM_CPUS),
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> > +
> > +        /* GIC maintenance signal */
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (4 *
> AW_H3_NUM_CPUS),
> > +                           qdev_get_gpio_in(DEVICE(&s->gic),
> > +                                            ppibase +
> AW_H3_GIC_PPI_MAINT));
> > +    }
> > +
> > +    /* Timer */
> > +    qdev_init_nofail(DEVICE(&s->timer));
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_PIT]=
);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
> > +                       qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_TIMER0));
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 1,
> > +                       qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_TIMER1));
> > +
> > +    /* SRAM */
> > +    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
> > +                            64 * KiB, &error_abort);
> > +    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
> > +                            32 * KiB, &error_abort);
> > +    memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
> > +                            44 * KiB, &error_abort);
>
> This looks like an ECC SRAM layout, but no info about this in the
> datasheet...
>
> > +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_A1],
> > +                                &s->sram_a1);
> > +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_A2],
> > +                                &s->sram_a2);
> > +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_C],
> > +                                &s->sram_c);
> > +
> > +    /* UART0 */
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
> > +                   qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART0),
> > +                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
>
> This is APB2_CLK / 16. Can you add a comment, so it will be easier to
> adapt to the future clocktree API?
>
> Sure, I can add it. I also see that the UART is connected to APB2 in the
datasheet.
Only I don't yet see where it does the divide by 16. Could you please
explain where you found that?
Then I can also add the source / reference as well.

Thanks, all the other comments I'll process for v4.

Regards,
Niek

> +    /* UART1 */
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART1], 2,
> > +                   qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART1),
> > +                   115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);
> > +    /* UART2 */
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART2], 2,
> > +                   qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART2),
> > +                   115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);
> > +    /* UART3 */
> > +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART3], 2,
> > +                   qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_UART3),
> > +                   115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
> > +
> > +    /* Unimplemented devices */
> > +    for (int i =3D 0; i < ARRAY_SIZE(unimplemented); i++) {
>
> You already declared i, earlier.
>
> > +        create_unimplemented_device(unimplemented[i].device_name,
> > +                                    unimplemented[i].base,
> > +                                    unimplemented[i].size);
> > +    }
> > +}
> > +
> > +static void allwinner_h3_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    dc->realize =3D allwinner_h3_realize;
> > +    /* Reason: uses serial_hds and nd_table */
> > +    dc->user_creatable =3D false;
> > +}
> > +
> > +static const TypeInfo allwinner_h3_type_info =3D {
> > +    .name =3D TYPE_AW_H3,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(AwH3State),
> > +    .instance_init =3D allwinner_h3_init,
> > +    .class_init =3D allwinner_h3_class_init,
> > +};
> > +
> > +static void allwinner_h3_register_types(void)
> > +{
> > +    type_register_static(&allwinner_h3_type_info);
> > +}
> > +
> > +type_init(allwinner_h3_register_types)
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd2dc137a3..dc2d7991bf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -481,6 +481,13 @@ F: hw/*/allwinner*
> >   F: include/hw/*/allwinner*
> >   F: hw/arm/cubieboard.c
> >
> > +Allwinner-h3
> > +M: Niek Linnenbank <nieklinnenbank@gmail.com>
> > +L: qemu-arm@nongnu.org
> > +S: Maintained
> > +F: hw/*/allwinner-h3*
> > +F: include/hw/*/allwinner-h3*
> > +
> >   ARM PrimeCell and CMSDK devices
> >   M: Peter Maydell <peter.maydell@linaro.org>
> >   L: qemu-arm@nongnu.org
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index c6e7782580..ebf8d2325f 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -291,6 +291,14 @@ config ALLWINNER_A10
> >       select SERIAL
> >       select UNIMP
> >
> > +config ALLWINNER_H3
> > +    bool
> > +    select ALLWINNER_A10_PIT
> > +    select SERIAL
> > +    select ARM_TIMER
> > +    select ARM_GIC
> > +    select UNIMP
> > +
> >   config RASPI
> >       bool
> >       select FRAMEBUFFER
> > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > index fe749f65fd..956e496052 100644
> > --- a/hw/arm/Makefile.objs
> > +++ b/hw/arm/Makefile.objs
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o
> >   obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
> >   obj-$(CONFIG_STRONGARM) +=3D strongarm.o
> >   obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
> > +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o
> >   obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
> >   obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
> >   obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
> >
>
>

--=20
Niek Linnenbank

--000000000000d3f4fd059be353c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 9, 2020 at 12:13 AM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt; The Allwinner H3 is a System on Chip containing four ARM Cortex A7<br>
&gt; processor cores. Features and specifications include DDR2/DDR3 memory,=
<br>
&gt; SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and<br>
<br>
&quot;Ethernet&quot;<br>
<br>
&gt; various I/O modules. This commit adds support for the Allwinner H3<br>
&gt; System on Chip.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0default-configs/arm-softmmu.mak |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0| 107 ++++++++++=
+<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 328 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 =C2=A0hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A06 files changed, 452 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/arm/allwinner-h3.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/arm/allwinner-h3.c<br>
&gt; <br>
&gt; diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak<br>
&gt; index 1f2e0e7fde..d75a239c2c 100644<br>
&gt; --- a/default-configs/arm-softmmu.mak<br>
&gt; +++ b/default-configs/arm-softmmu.mak<br>
&gt; @@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_FSL_IMX7=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_FSL_IMX6UL=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_SEMIHOSTING=3Dy<br>
&gt; +CONFIG_ALLWINNER_H3=3Dy<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..4e2e6202a9<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -0,0 +1,107 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 System on Chip emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * The Allwinner H3 is a System on Chip containing four ARM Cortex A7=
<br>
&gt; + * processor cores. Features and specifications include DDR2/DDR3 mem=
ory,<br>
&gt; + * SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and<=
br>
&gt; + * various I/O modules.<br>
&gt; + *<br>
&gt; + * This implementation is based on the following datasheet:<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0<a href=3D"https://linux-sunxi.org/File:Allwinner_H3_D=
atasheet_V1.2.pdf" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi=
.org/File:Allwinner_H3_Datasheet_V1.2.pdf</a><br>
&gt; + *<br>
&gt; + * The latest datasheet and more info can be found on the Linux Sunxi=
 wiki:<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0<a href=3D"https://linux-sunxi.org/H3" rel=3D"noreferr=
er" target=3D"_blank">https://linux-sunxi.org/H3</a><br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_ARM_ALLWINNER_H3_H<br>
&gt; +#define HW_ARM_ALLWINNER_H3_H<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
<br>
Check CODING_STYLE.rst:<br>
<br>
=C2=A0 =C2=A0Do not include &quot;qemu/osdep.h&quot; from header files sinc=
e<br>
=C2=A0 =C2=A0the .c file will have already included it.<br>
<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;hw/qdev-core.h&quot;<br>
&gt; +#include &quot;hw/arm/boot.h&quot;<br>
<br>
Please only keep the minimum required headers here, move the rest to the <b=
r>
source files.<br>
<br>
&gt; +#include &quot;hw/timer/allwinner-a10-pit.h&quot;<br>
&gt; +#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt; +#include &quot;target/arm/cpu.h&quot;<br>
<br>
These looks OK in this header.<br>
<br></blockquote><div>Thanks, I&#39;ll also apply these changes to the othe=
r patches as well. I did the same there.<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner H3 device list<br>
&gt; + *<br>
&gt; + * This enumeration is can be used refer to a particular device in th=
e<br>
&gt; + * Allwinner H3 SoC. For example, the physical memory base address fo=
r<br>
&gt; + * each device can be found in the AwH3State object in the memmap mem=
ber<br>
&gt; + * using the device enum value as index.<br>
&gt; + *<br>
&gt; + * @see AwH3State<br>
&gt; + */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 AW_H3_SRAM_A1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_SRAM_A2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_SRAM_C,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_PIT,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_UART0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_UART1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_UART2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_UART3,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_DIST,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_CPU,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_HYP,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_VCPU,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_SDRAM<br>
&gt; +};<br>
&gt; +<br>
&gt; +/** Total number of CPU cores in the SoC */<br>
<br>
&quot;the H3 SoC&quot;<br>
<br>
&gt; +#define AW_H3_NUM_CPUS=C2=A0 =C2=A0 =C2=A0 (4)<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner H3 object model<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +/** Object type for the Allwinner H3 SoC */<br>
&gt; +#define TYPE_AW_H3 &quot;allwinner-h3&quot;<br>
&gt; +<br>
&gt; +/** Convert input object to Allwinner H3 state object */<br>
&gt; +#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner H3 object instance state<br>
<br>
I find this comment more noisy than helpful.<br>
<br>
&gt; + */<br>
&gt; +typedef struct AwH3State {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 DeviceState parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ARMCPU cpus[AW_H3_NUM_CPUS];<br>
&gt; +=C2=A0 =C2=A0 const hwaddr *memmap;<br>
&gt; +=C2=A0 =C2=A0 AwA10PITState timer;<br>
&gt; +=C2=A0 =C2=A0 GICState gic;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sram_a1;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sram_a2;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion sram_c;<br>
&gt; +} AwH3State;<br>
&gt; +<br>
&gt; +#endif /* HW_ARM_ALLWINNER_H3_H */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c1ef31e875<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -0,0 +1,328 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 System on Chip emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;exec/address-spaces.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/char/serial.h&quot;<br>
&gt; +#include &quot;hw/misc/unimp.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt; +<br>
&gt; +/* Memory map */<br>
&gt; +const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20c00,<=
br>
&gt; +=C2=A0 =C2=A0 [AW_H3_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28400,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_UART2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28800,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_UART3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28c00,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_GIC_DIST]=C2=A0 =C2=A0=3D 0x01c81000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_GIC_CPU]=C2=A0 =C2=A0 =3D 0x01c82000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_GIC_HYP]=C2=A0 =C2=A0 =3D 0x01c84000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_GIC_VCPU]=C2=A0 =C2=A0=3D 0x01c86000,<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_SDRAM]=C2=A0 =C2=A0 =C2=A0 =3D 0x40000000<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* List of unimplemented devices */<br>
&gt; +struct AwH3Unimplemented {<br>
&gt; +=C2=A0 =C2=A0 const char *device_name;<br>
&gt; +=C2=A0 =C2=A0 hwaddr base;<br>
&gt; +=C2=A0 =C2=A0 hwaddr size;<br>
&gt; +} unimplemented[] =3D {<br>
&gt; +=C2=A0 =C2=A0 { &quot;d-engine&quot;,=C2=A0 0x01000000, 4 * MiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;d-inter&quot;,=C2=A0 =C2=A00x01400000, 128 * Ki=
B },<br>
&gt; +=C2=A0 =C2=A0 { &quot;syscon&quot;,=C2=A0 =C2=A0 0x01c00000, 4 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;dma&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c02000=
, 4 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;nfdc&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c03000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;ts&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c06000=
, 4 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;keymem&quot;,=C2=A0 =C2=A0 0x01c0b000, 4 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;lcd0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c0c000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;lcd1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c0d000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;ve&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c0e000=
, 4 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;mmc0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c0f000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;mmc1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c10000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;mmc2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c11000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;sid&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c14000=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;crypto&quot;,=C2=A0 =C2=A0 0x01c15000, 4 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;msgbox&quot;,=C2=A0 =C2=A0 0x01c17000, 4 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;spinlock&quot;,=C2=A0 0x01c18000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;usb0-otg&quot;,=C2=A0 0x01c19000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;usb0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1a000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;usb1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1b000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;usb2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1c000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;usb3&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1d000, 4 *=
 KiB },<br>
<br>
To avoid the churn in patch #4, directly name them usb-phy:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;usb0-phy&quot;,=C2=A0 0x01c1a000, 4 * K=
iB },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;usb1-phy&quot;,=C2=A0 0x01c1b000, 4 * K=
iB },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;usb2-phy&quot;,=C2=A0 0x01c1c000, 4 * K=
iB },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;usb3-phy&quot;,=C2=A0 0x01c1d000, 4 * K=
iB },<br>
<br></blockquote><div><br></div><div>The reason I choose to do it like this=
 is that in this patch all of the USB devices are unimplemented (including =
the PHY).</div><div>In patch 4, the USB devices are implemented, except for=
 the USB-PHY specifics which aren&#39;t part of the OHCI/EHCI but</div><div=
>also not required to be fully emulated for a functional USB stack in the g=
uest.</div><div>So to make it clear that only the USB-PHY part remains unim=
plemented in patch 4, I renamed it to &#39;usb*-phy&#39; in patch 4.</div><=
div><br></div><div>Does that make sense, or would you like me to change it =
anyway?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +=C2=A0 =C2=A0 { &quot;smc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c1e000=
, 4 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;ccu&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c20000=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;pio&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c20800=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;owa&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c21000=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;pwm&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c21400=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;keyadc&quot;,=C2=A0 =C2=A0 0x01c21800, 1 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;pcm0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c22000, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;pcm1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c22400, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;pcm2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c22800, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;audio&quot;,=C2=A0 =C2=A0 =C2=A00x01c22c00, 2 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;smta&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c23400, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;ths&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c25000=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;uart0&quot;,=C2=A0 =C2=A0 =C2=A00x01c28000, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;uart1&quot;,=C2=A0 =C2=A0 =C2=A00x01c28400, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;uart2&quot;,=C2=A0 =C2=A0 =C2=A00x01c28800, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;uart3&quot;,=C2=A0 =C2=A0 =C2=A00x01c28c00, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;twi0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c2ac00, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;twi1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c2b000, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;twi2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c2b400, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;scr&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c2c400=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;emac&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c30000, 64 =
* KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;gpu&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c40000=
, 64 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;hstmr&quot;,=C2=A0 =C2=A0 =C2=A00x01c60000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;dramcom&quot;,=C2=A0 =C2=A00x01c62000, 4 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;dramctl0&quot;,=C2=A0 0x01c63000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;dramphy0&quot;,=C2=A0 0x01c65000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;spi0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c68000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;spi1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c69000, 4 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;csi&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01cb0000=
, 320 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;tve&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01e00000=
, 64 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;hdmi&quot;,=C2=A0 =C2=A0 =C2=A0 0x01ee0000, 128=
 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;rtc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01f00000=
, 1 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_timer&quot;,=C2=A0 =C2=A00x01f00800, 1 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_intc&quot;,=C2=A0 =C2=A0 0x01f00c00, 1 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_wdog&quot;,=C2=A0 =C2=A0 0x01f01000, 1 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_prcm&quot;,=C2=A0 =C2=A0 0x01f01400, 1 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_twd&quot;,=C2=A0 =C2=A0 =C2=A00x01f01800, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_cpucfg&quot;,=C2=A0 0x01f01c00, 1 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;r_cir-rx&quot;,=C2=A0 0x01f02000, 1 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;r_twi&quot;,=C2=A0 =C2=A0 =C2=A00x01f02400, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_uart&quot;,=C2=A0 =C2=A0 0x01f02800, 1 * KiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_pio&quot;,=C2=A0 =C2=A0 =C2=A00x01f02c00, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;r_pwm&quot;,=C2=A0 =C2=A0 =C2=A00x01f03800, 1 *=
 KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;core-dbg&quot;,=C2=A0 0x3f500000, 128 * KiB },<=
br>
&gt; +=C2=A0 =C2=A0 { &quot;tsgen-ro&quot;,=C2=A0 0x3f506000, 4 * KiB },<br=
>
&gt; +=C2=A0 =C2=A0 { &quot;tsgen-ctl&quot;, 0x3f507000, 4 * KiB },<br>
&gt; +=C2=A0 =C2=A0 { &quot;ddr-mem&quot;,=C2=A0 =C2=A00x40000000, 2 * GiB =
},<br>
&gt; +=C2=A0 =C2=A0 { &quot;n-brom&quot;,=C2=A0 =C2=A0 0xffff0000, 32 * KiB=
 },<br>
&gt; +=C2=A0 =C2=A0 { &quot;s-brom&quot;,=C2=A0 =C2=A0 0xffff0000, 64 * KiB=
 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Per Processor Interrupts */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_PPI_MAINT=C2=A0 =C2=A0 =C2=A0=3D=C2=A0 9,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_PPI_HYPTIMER=C2=A0 =3D 10,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_PPI_VIRTTIMER =3D 11,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_PPI_SECTIMER=C2=A0 =3D 13,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_PPI_PHYSTIMER =3D 14<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Shared Processor Interrupts */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_UART0=C2=A0 =C2=A0 =C2=A0=3D=C2=A0 0,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_UART1=C2=A0 =C2=A0 =C2=A0=3D=C2=A0 1,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_UART2=C2=A0 =C2=A0 =C2=A0=3D=C2=A0 2,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_UART3=C2=A0 =C2=A0 =C2=A0=3D=C2=A0 3,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_TIMER0=C2=A0 =C2=A0 =3D 18,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_SPI_TIMER1=C2=A0 =C2=A0 =3D 19,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Allwinner H3 constants */<br>
<br>
Another not very useful comment.<br>
<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 AW_H3_GIC_NUM_SPI=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 128<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3State *s =3D AW_H3(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;memmap =3D allwinner_h3_memmap;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; AW_H3_NUM_CPUS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(obj, &quot;cpu[*]=
&quot;, &amp;s-&gt;cpus[i], sizeof(s-&gt;cpus[i]),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARM_CPU_TYPE_NAME(&quot;cortex-a=
7&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort, NULL);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;gic&quot;, &amp;s-&gt;=
gic, sizeof(s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_ARM_GIC);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;timer&quot;, &amp;s-&g=
t;timer, sizeof(s-&gt;timer),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_A10_PIT);<br>
&gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;clk0-freq&quot;, O=
BJECT(&amp;s-&gt;timer),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;clk0-freq&quot;, &amp;error_abort=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;clk1-freq&quot;, O=
BJECT(&amp;s-&gt;timer),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;clk1-freq&quot;, &amp;error_abort=
);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3State *s =3D AW_H3(dev);<br>
&gt; +=C2=A0 =C2=A0 unsigned i =3D 0;<br>
<br>
No need to initialize i since you re-init it in the for().<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* CPUs */<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_H3_NUM_CPUS; i++) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Provide Power State Coordination Inter=
face */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt=
;cpus[i]), QEMU_PSCI_CONDUIT_HVC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;psci-conduit&quot;, &amp;e=
rror_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable secondary CPUs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&g=
t;cpus[i]), i &gt; 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;start-powered-off&quot;, &=
amp;error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* All exception levels required */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&g=
t;cpus[i]),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &quot;has_el3&quot;,=
 &amp;error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&g=
t;cpus[i]),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &quot;has_el2&quot;,=
 &amp;error_abort);<br>
<br>
You previously used the object API, ...<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mark realized */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;cpus[i=
]));<br>
<br>
... and here switch to the qdev API. Odd.<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Generic Interrupt Controller */<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-=
irq&quot;, AW_H3_GIC_NUM_SPI +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIC_INTERNAL);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;revi=
sion&quot;, 2);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-=
cpu&quot;, AW_H3_NUM_CPUS);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;has-sec=
urity-extensions&quot;, false);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;has-vir=
tualization-extensions&quot;, true);<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;gic));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 0, s-&g=
t;memmap[AW_H3_GIC_DIST]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 1, s-&g=
t;memmap[AW_H3_GIC_CPU]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 2, s-&g=
t;memmap[AW_H3_GIC_HYP]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 3, s-&g=
t;memmap[AW_H3_GIC_VCPU]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Wire the outputs from each CPU&#39;s generic ti=
mer and the GICv3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* maintenance interrupt signal to the appropriate=
 GIC PPI inputs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and the GIC&#39;s IRQ/FIQ/VIRQ/VFIQ interrupt o=
utputs to the CPU&#39;s inputs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_H3_NUM_CPUS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *cpudev =3D DEVICE(qemu_get_c=
pu(i));<br>
<br>
Why not use DEVICE(&amp;s-&gt;cpus[i])?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ppibase =3D AW_H3_GIC_NUM_SPI + i * G=
IC_INTERNAL + GIC_NR_SGIS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Mapping from the output timer irq=
 lines from the CPU to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* GIC PPI inputs used for this boar=
d.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int timer_irq[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_PHYS] =3D AW_H3_GIC=
_PPI_PHYSTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_VIRT] =3D AW_H3_GIC=
_PPI_VIRTTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_HYP]=C2=A0 =3D AW_H=
3_GIC_PPI_HYPTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [GTIMER_SEC]=C2=A0 =3D AW_H=
3_GIC_PPI_SECTIMER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Connect CPU timer outputs to GIC PPI i=
nputs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (irq =3D 0; irq &lt; ARRAY_SIZE(timer=
_irq); irq++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(cpude=
v, irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&=
amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ppibase + timer_irq[irq]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Connect GIC outputs to CPU interrupt i=
nputs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-=
&gt;gic), i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-=
&gt;gic), i + AW_H3_NUM_CPUS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-=
&gt;gic), i + (2 * AW_H3_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-=
&gt;gic), i + (3 * AW_H3_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* GIC maintenance signal */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-=
&gt;gic), i + (4 * AW_H3_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ppibase + AW_H3_GIC_PPI_MAINT));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Timer */<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;timer));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0, s-=
&gt;memmap[AW_H3_PIT]);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_TIMER0=
));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;timer), 1,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_TIMER1=
));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* SRAM */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_a1, OBJECT(dev),=
 &quot;sram A1&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 64 * KiB, &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_a2, OBJECT(dev),=
 &quot;sram A2&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32 * KiB, &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;sram_c, OBJECT(dev), =
&quot;sram C&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 44 * KiB, &amp;error_abort);<br>
<br>
This looks like an ECC SRAM layout, but no info about this in the <br>
datasheet...<br>
<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_A1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_a1);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_A2],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_a2);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_C],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;sram_c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* UART0 */<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART0], 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);<br>
<br>
This is APB2_CLK / 16. Can you add a comment, so it will be easier to <br>
adapt to the future clocktree API?<br>
<br></blockquote><div>Sure, I can add it. I also see that the UART is conne=
cted to APB2 in the datasheet.</div><div>Only I don&#39;t yet see where it =
does the divide by 16. Could you please explain where you found that?</div>=
<div>Then I can also add the source / reference as well.<br></div><div>=C2=
=A0</div><div>Thanks, all the other comments I&#39;ll process for v4.</div>=
<div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 /* UART1 */<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART1], 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);<br>
&gt; +=C2=A0 =C2=A0 /* UART2 */<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART2], 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);<br>
&gt; +=C2=A0 =C2=A0 /* UART3 */<br>
&gt; +=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART3], 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART3),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Unimplemented devices */<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ARRAY_SIZE(unimplemented); i++=
) {<br>
<br>
You already declared i, earlier.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(unimplemented=
[i].device_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unimplemented[i].b=
ase,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unimplemented[i].s=
ize);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_class_init(ObjectClass *oc, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D allwinner_h3_realize;<br>
&gt; +=C2=A0 =C2=A0 /* Reason: uses serial_hds and nd_table */<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;user_creatable =3D false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_h3_type_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_AW_H3,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3State),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_h3_init,<br>
&gt; +=C2=A0 =C2=A0 .class_init =3D allwinner_h3_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_h3_type_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_h3_register_types)<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index cd2dc137a3..dc2d7991bf 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -481,6 +481,13 @@ F: hw/*/allwinner*<br>
&gt;=C2=A0 =C2=A0F: include/hw/*/allwinner*<br>
&gt;=C2=A0 =C2=A0F: hw/arm/cubieboard.c<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +Allwinner-h3<br>
&gt; +M: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" ta=
rget=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; +L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank">qemu-arm@=
nongnu.org</a><br>
&gt; +S: Maintained<br>
&gt; +F: hw/*/allwinner-h3*<br>
&gt; +F: include/hw/*/allwinner-h3*<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0ARM PrimeCell and CMSDK devices<br>
&gt;=C2=A0 =C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank=
">qemu-arm@nongnu.org</a><br>
&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt; index c6e7782580..ebf8d2325f 100644<br>
&gt; --- a/hw/arm/Kconfig<br>
&gt; +++ b/hw/arm/Kconfig<br>
&gt; @@ -291,6 +291,14 @@ config ALLWINNER_A10<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select SERIAL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select UNIMP<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config ALLWINNER_H3<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 select ALLWINNER_A10_PIT<br>
&gt; +=C2=A0 =C2=A0 select SERIAL<br>
&gt; +=C2=A0 =C2=A0 select ARM_TIMER<br>
&gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
&gt; +=C2=A0 =C2=A0 select UNIMP<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config RASPI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select FRAMEBUFFER<br>
&gt; diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs<br>
&gt; index fe749f65fd..956e496052 100644<br>
&gt; --- a/hw/arm/Makefile.objs<br>
&gt; +++ b/hw/arm/Makefile.objs<br>
&gt; @@ -34,6 +34,7 @@ obj-$(CONFIG_DIGIC) +=3D digic.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_STRONGARM) +=3D strongarm.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboar=
d.o<br>
&gt; +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o r=
aspi.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu1=
02.o<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000d3f4fd059be353c8--

