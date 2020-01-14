Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F23C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 22:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A8524656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 22:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ZygE2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A8524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irV9I-0001Ty-P6
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 17:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1irV8I-0000lE-HX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 17:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1irV8C-0006yL-Ge
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 17:57:58 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1irV8B-0006va-Pj; Tue, 14 Jan 2020 17:57:52 -0500
Received: by mail-io1-xd43.google.com with SMTP id x1so15709460iop.7;
 Tue, 14 Jan 2020 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w2sz+Z9P+9iFeen36N1hbiPVBF5Wpf10MhhLo0T0/LY=;
 b=M3ZygE2tALy7OQpqH6hqCbnDmiXpiZkEKdG0S3o7e4RZEWiRbimFTygIFhTjymGVXm
 ep/733fs0vMt6b/foaG1Xf+Y06MEhiL4s7u2u5SuEyb6pAMOQeAIbva8Ehayg2iKsdHZ
 w2oMnEnbHF0aIWRNEZHNJchSLUJBFFgsxHYbOAuLfB0NH3iF0WCgWOw8wYOlIZnNmwOU
 04gmSYPmZV0F2xdClQHNLKcu8IaCOSFOJycutTQcu45JdQ5l+OjnyFtDhfv2tUyZZCb0
 +/rsDGo9IEU2Va7rwQOGj2cO3S8vJguR2qnJBdDms+uHVrTBTg51zAxHQCsenvK0BQxH
 v9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w2sz+Z9P+9iFeen36N1hbiPVBF5Wpf10MhhLo0T0/LY=;
 b=IArMOzRt5NPVjojb1Bax+o2tRRFrBSr6XMkxn8mo7qBtGEdycq2TWR/FA+WMqtakEe
 JirQ0per5SQzNuvdUG3/Wg/259/PcusqYcwg8Y3HEdOcYsAGIR4pi9pg9ixRCdVK0Ms5
 b8exzF/ARxIZKGPo/f2dS60MZblWxWnnQBvX4dSHL67GruyGmunYZSip5bwAbTE8Npy+
 W5x4r0B7qrA2+6UvWStaYQGNZSzyRD0lI47zAu8ulL9yVyzlxv1iNqX5zrfoRI8//a/P
 AzU4d4A6fZG5ZeDJDfd0CbmIdQCTEuEaZ+UpNNvWm4vb4Kokc4fLYG1hIqB9wtPJyDls
 OS6w==
X-Gm-Message-State: APjAAAXM136exLKojBAWRbis6cuRCClNiLlIhmY7whStH2j7LMBZx+k0
 j1qzoy61+zRwA90WctOD7kxHFNm8/iX+gfXrI4w=
X-Google-Smtp-Source: APXvYqzkN3muyp7y47X8+42cy1EQpln8psowAX2XVOJ+w28q9QUP9SDnAep+0WUIqYgkMO5VX5WfCeiaY5daGKF/oTg=
X-Received: by 2002:a05:6602:25d3:: with SMTP id
 d19mr18663869iop.217.1579042670047; 
 Tue, 14 Jan 2020 14:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-13-nieklinnenbank@gmail.com>
 <cca7b552-ed09-fdc4-e80e-fc172e30e9bf@redhat.com>
 <CAPan3Wqso11h47mGdWxbDFE7dPL7wzNGCM6XVB-12SAZhJ0mqA@mail.gmail.com>
In-Reply-To: <CAPan3Wqso11h47mGdWxbDFE7dPL7wzNGCM6XVB-12SAZhJ0mqA@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 14 Jan 2020 23:57:39 +0100
Message-ID: <CAPan3WrkQVb7VhJRYZET_BjEWEOYow-28ft2+4=G-9SNUDm6WA@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] hw/arm/allwinner: add RTC device support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006efabb059c218501"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

--0000000000006efabb059c218501
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 11:52 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> Hi Philippe,
>
> On Mon, Jan 13, 2020 at 11:57 PM Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com>
> wrote:
>
>> On 1/8/20 9:00 PM, Niek Linnenbank wrote:
>> > Allwinner System-on-Chips usually contain a Real Time Clock (RTC)
>> > for non-volatile system date and time keeping. This commit adds a
>> generic
>> > Allwinner RTC device that supports the RTC devices found in Allwinner
>> SoC
>> > family sun4i (A10), sun7i (A20) and sun6i and newer (A31, H2+, H3, etc=
).
>> > The following RTC functionality and features are implemented:
>> >
>> >   * Year-Month-Day read/write
>> >   * Hour-Minute-Second read/write
>> >   * General Purpose storage
>> >
>> > The following boards are extended with the RTC device:
>> >
>> >   * Cubieboard (hw/arm/cubieboard.c)
>> >   * Orange Pi PC (hw/arm/orangepi.c)
>> >
>> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> > ---
>> >   include/hw/arm/allwinner-a10.h |   4 +-
>> >   include/hw/arm/allwinner-h3.h  |   3 +
>> >   include/hw/rtc/allwinner-rtc.h | 129 +++++++++++
>> >   hw/arm/allwinner-a10.c         |   7 +
>> >   hw/arm/allwinner-h3.c          |   9 +-
>> >   hw/rtc/allwinner-rtc.c         | 386 +++++++++++++++++++++++++++++++=
++
>> >   hw/rtc/Makefile.objs           |   1 +
>> >   hw/rtc/trace-events            |   4 +
>> >   8 files changed, 541 insertions(+), 2 deletions(-)
>> >   create mode 100644 include/hw/rtc/allwinner-rtc.h
>> >   create mode 100644 hw/rtc/allwinner-rtc.c
>> >
>> > diff --git a/include/hw/arm/allwinner-a10.h
>> b/include/hw/arm/allwinner-a10.h
>> > index 0e8250b244..81a16092e7 100644
>> > --- a/include/hw/arm/allwinner-a10.h
>> > +++ b/include/hw/arm/allwinner-a10.h
>> > @@ -9,6 +9,7 @@
>> >   #include "hw/net/allwinner_emac.h"
>> >   #include "hw/sd/allwinner-sdhost.h"
>> >   #include "hw/ide/ahci.h"
>> > +#include "hw/rtc/allwinner-rtc.h"
>> >
>> >   #include "target/arm/cpu.h"
>> >
>> > @@ -18,7 +19,7 @@
>> >   #define AW_A10_UART0_REG_BASE   0x01c28000
>> >   #define AW_A10_EMAC_BASE        0x01c0b000
>> >   #define AW_A10_SATA_BASE        0x01c18000
>> > -
>> > +#define AW_A10_RTC_BASE         0x01c20d00
>> >   #define AW_A10_SDRAM_BASE       0x40000000
>> >
>> >   #define TYPE_AW_A10 "allwinner-a10"
>> > @@ -36,6 +37,7 @@ typedef struct AwA10State {
>> >       AwEmacState emac;
>> >       AllwinnerAHCIState sata;
>> >       AwSdHostState mmc0;
>> > +    AwRtcState rtc;
>> >       MemoryRegion sram_a;
>> >   } AwA10State;
>> >
>> > diff --git a/include/hw/arm/allwinner-h3.h
>> b/include/hw/arm/allwinner-h3.h
>> > index d1b3d7ca67..1c275a34ed 100644
>> > --- a/include/hw/arm/allwinner-h3.h
>> > +++ b/include/hw/arm/allwinner-h3.h
>> > @@ -50,6 +50,7 @@
>> >   #include "hw/misc/allwinner-sid.h"
>> >   #include "hw/sd/allwinner-sdhost.h"
>> >   #include "hw/net/allwinner-sun8i-emac.h"
>> > +#include "hw/rtc/allwinner-rtc.h"
>> >   #include "target/arm/cpu.h"
>> >   #include "sysemu/block-backend.h"
>> >
>> > @@ -92,6 +93,7 @@ enum {
>> >       AW_H3_GIC_CPU,
>> >       AW_H3_GIC_HYP,
>> >       AW_H3_GIC_VCPU,
>> > +    AW_H3_RTC,
>> >       AW_H3_CPUCFG,
>> >       AW_H3_SDRAM
>> >   };
>> > @@ -130,6 +132,7 @@ typedef struct AwH3State {
>> >       AwSidState sid;
>> >       AwSdHostState mmc0;
>> >       AwSun8iEmacState emac;
>> > +    AwRtcState rtc;
>> >       GICState gic;
>> >       MemoryRegion sram_a1;
>> >       MemoryRegion sram_a2;
>> > diff --git a/include/hw/rtc/allwinner-rtc.h
>> b/include/hw/rtc/allwinner-rtc.h
>> > new file mode 100644
>> > index 0000000000..e29dfc775f
>> > --- /dev/null
>> > +++ b/include/hw/rtc/allwinner-rtc.h
>> > @@ -0,0 +1,129 @@
>> > +/*
>> > + * Allwinner Real Time Clock emulation
>> > + *
>> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
>> > + *
>> > + * This program is free software: you can redistribute it and/or modi=
fy
>> > + * it under the terms of the GNU General Public License as published =
by
>> > + * the Free Software Foundation, either version 2 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program.  If not, see <http://www.gnu.org/licenses=
/
>> >.
>> > + */
>> > +
>> > +#ifndef HW_MISC_ALLWINNER_RTC_H
>> > +#define HW_MISC_ALLWINNER_RTC_H
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qom/object.h"
>> > +#include "hw/sysbus.h"
>> > +
>> > +/**
>> > + * Constants
>> > + * @{
>> > + */
>> > +
>> > +/** Highest register address used by RTC device */
>> > +#define AW_RTC_REGS_MAXADDR     (0x1F4)
>>
>> I'd start using 0x200 here so in case new SoC use registers in this
>> block range (or undocumented reg) so we don't have to modify
>> allwinner_rtc_vmstate.
>>
>
> Good point, I'll change it to 0x200.
>
>
>> > +
>> > +/** Total number of known registers */
>> > +#define AW_RTC_REGS_NUM         (AW_RTC_REGS_MAXADDR /
>> sizeof(uint32_t))
>> > +
>> > +/** @} */
>> > +
>> > +/**
>> > + * Object model types
>> > + * @{
>> > + */
>> > +
>> > +/** Generic Allwinner RTC device (abstract) */
>> > +#define TYPE_AW_RTC          "allwinner-rtc"
>> > +
>> > +/** Allwinner RTC sun4i family (A10, A12) */
>> > +#define TYPE_AW_RTC_SUN4I    TYPE_AW_RTC "-sun4i"
>> > +
>> > +/** Allwinner RTC sun6i family and newer (A31, H2+, H3, etc) */
>> > +#define TYPE_AW_RTC_SUN6I    TYPE_AW_RTC "-sun6i"
>> > +
>> > +/** Allwinner RTC sun7i family (A20) */
>> > +#define TYPE_AW_RTC_SUN7I    TYPE_AW_RTC "-sun7i"
>> > +
>> > +/** @} */
>> > +
>> > +/**
>> > + * Object model macros
>> > + * @{
>> > + */
>> > +
>> > +#define AW_RTC(obj) \
>> > +    OBJECT_CHECK(AwRtcState, (obj), TYPE_AW_RTC)
>> > +#define AW_RTC_CLASS(klass) \
>> > +     OBJECT_CLASS_CHECK(AwRtcClass, (klass), TYPE_AW_RTC)
>> > +#define AW_RTC_GET_CLASS(obj) \
>> > +     OBJECT_GET_CLASS(AwRtcClass, (obj), TYPE_AW_RTC)
>> > +
>> > +/** @} */
>> > +
>> > +/**
>> > + * Allwinner RTC per-object instance state.
>> > + */
>> > +typedef struct AwRtcState {
>> > +    /*< private >*/
>> > +    SysBusDevice parent_obj;
>> > +    /*< public >*/
>> > +
>> > +    /** Maps I/O registers in physical memory */
>> > +    MemoryRegion iomem;
>> > +
>> > +    /** Array of hardware registers */
>> > +    uint32_t regs[AW_RTC_REGS_NUM];
>> > +
>> > +} AwRtcState;
>> > +
>> > +/**
>> > + * Allwinner RTC class-level struct.
>> > + *
>> > + * This struct is filled by each sunxi device specific code
>> > + * such that the generic code can use this struct to support
>> > + * all devices.
>> > + */
>> > +typedef struct AwRtcClass {
>> > +    /*< private >*/
>> > +    SysBusDeviceClass parent_class;
>> > +    /*< public >*/
>> > +
>> > +    /** Defines device specific register map */
>> > +    const uint8_t *regmap;
>> > +
>> > +    /** Number of entries in regmap */
>> > +    size_t regmap_size;
>>
>> I'd rather call this 'regmap_count'.
>>
> Sure, I'll name it regmap_count.
>
>
>> If you don't use this field, can we remove it?
>>
>
> Actually I think I made a mistake there, thanks for the catch!
> In fact it should be used to verify the guest does not read outside the
> AwRtcClass->regmap.
> I'll correct this in v4.
>
>
>> > +
>> > +    /** Device offset in years to 1900, for struct tm.tm_year */
>> > +    uint8_t year_offset;
>>
>> struct tm uses 'int' for this field.
>>
> OK.
>
> By the way, the behavior I noticed when reading the RTC from NetBSD versu=
s
> Linux is due to a mismatch in
> the base year configured by the two operating systems. Linux starts
> counting from 1970 for the RTC in sun6i (drivers/rtc/rtc-sun6i.c,
> SUN6I_YEAR_MIN),
> while NetBSD uses 2000 as the base year
> (usr/src/sys/arch/arm/sunxi/sunxi_rtc.c, SUN6I_RTC_BASE_YEAR).
> So if the RTC year field is filled with the number 50, it results in 2020
> on Linux, but reads as 2050 on NetBSD.
>
> I'm not sure yet which one is correct. The datasheet does not explicitely
> mention what should be the base/start year,
> only that it is within the range 0..63.
>
>
>> > +
>> > +    /**
>> > +     * Read device specific register
>> > +     *
>> > +     * @offset: register offset to read
>> > +     * @return true if register read successful, false otherwise
>> > +     */
>> > +    bool (*read)(AwRtcState *s, uint32_t offset);
>> > +
>> > +    /**
>> > +     * Write device specific register
>> > +     *
>> > +     * @offset: register offset to write
>> > +     * @data: value to set in register
>> > +     * @return true if register write successful, false otherwise
>> > +     */
>> > +    bool (*write)(AwRtcState *s, uint32_t offset, uint32_t data);
>> > +
>> > +} AwRtcClass;
>> > +
>> > +#endif /* HW_MISC_ALLWINNER_RTC_H */
>> > diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>> > index 61cf3550a6..3f8f9d0d19 100644
>> > --- a/hw/arm/allwinner-a10.c
>> > +++ b/hw/arm/allwinner-a10.c
>> > @@ -46,6 +46,9 @@ static void aw_a10_init(Object *obj)
>> >
>> >       sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
>> >                             TYPE_AW_SDHOST_SUN4I);
>> > +
>> > +    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
>> > +                          TYPE_AW_RTC_SUN4I);
>> >   }
>> >
>> >   static void aw_a10_realize(DeviceState *dev, Error **errp)
>> > @@ -128,6 +131,10 @@ static void aw_a10_realize(DeviceState *dev, Erro=
r
>> **errp)
>> >       sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, s->irq[32]);
>> >       object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
>> >                                 "sd-bus", &error_abort);
>> > +
>> > +    /* RTC */
>> > +    qdev_init_nofail(DEVICE(&s->rtc));
>> > +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->rtc), 0,
>> AW_A10_RTC_BASE, 10);
>> >   }
>> >
>> >   static void aw_a10_class_init(ObjectClass *oc, void *data)
>> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>> > index 77b823e7d8..caa4d8b196 100644
>> > --- a/hw/arm/allwinner-h3.c
>> > +++ b/hw/arm/allwinner-h3.c
>> > @@ -61,6 +61,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
>> >       [AW_H3_GIC_CPU]    =3D 0x01c82000,
>> >       [AW_H3_GIC_HYP]    =3D 0x01c84000,
>> >       [AW_H3_GIC_VCPU]   =3D 0x01c86000,
>> > +    [AW_H3_RTC]        =3D 0x01f00000,
>> >       [AW_H3_CPUCFG]     =3D 0x01f01c00,
>> >       [AW_H3_SDRAM]      =3D 0x40000000
>> >   };
>> > @@ -116,7 +117,6 @@ struct AwH3Unimplemented {
>> >       { "csi",       0x01cb0000, 320 * KiB },
>> >       { "tve",       0x01e00000, 64 * KiB },
>> >       { "hdmi",      0x01ee0000, 128 * KiB },
>> > -    { "rtc",       0x01f00000, 1 * KiB },
>> >       { "r_timer",   0x01f00800, 1 * KiB },
>> >       { "r_intc",    0x01f00c00, 1 * KiB },
>> >       { "r_wdog",    0x01f01000, 1 * KiB },
>> > @@ -244,6 +244,9 @@ static void allwinner_h3_init(Object *obj)
>> >                                "ram-addr", &error_abort);
>> >       object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
>> >                                 "ram-size", &error_abort);
>> > +
>> > +    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
>> > +                          TYPE_AW_RTC_SUN6I);
>> >   }
>> >
>> >   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
>> > @@ -437,6 +440,10 @@ static void allwinner_h3_realize(DeviceState *dev=
,
>> Error **errp)
>> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1,
>> s->memmap[AW_H3_DRAMCTL]);
>> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
>> s->memmap[AW_H3_DRAMPHY]);
>> >
>> > +    /* RTC */
>> > +    qdev_init_nofail(DEVICE(&s->rtc));
>> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_RTC])=
;
>> > +
>> >       /* Unimplemented devices */
>> >       for (int i =3D 0; i < ARRAY_SIZE(unimplemented); i++) {
>> >           create_unimplemented_device(unimplemented[i].device_name,
>> > diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
>> > new file mode 100644
>> > index 0000000000..812fe7f10b
>> > --- /dev/null
>> > +++ b/hw/rtc/allwinner-rtc.c
>> > @@ -0,0 +1,386 @@
>> > +/*
>> > + * Allwinner Real Time Clock emulation
>> > + *
>> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
>> > + *
>> > + * This program is free software: you can redistribute it and/or modi=
fy
>> > + * it under the terms of the GNU General Public License as published =
by
>> > + * the Free Software Foundation, either version 2 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program.  If not, see <http://www.gnu.org/licenses=
/
>> >.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qemu/units.h"
>> > +#include "hw/sysbus.h"
>> > +#include "migration/vmstate.h"
>> > +#include "qemu/log.h"
>> > +#include "qemu/module.h"
>> > +#include "qemu-common.h"
>> > +#include "hw/rtc/allwinner-rtc.h"
>> > +#include "trace.h"
>> > +
>> > +/* RTC registers */
>> > +enum {
>> > +    REG_LOSC =3D 1,        /* Low Oscillator Control */
>> > +    REG_YYMMDD,          /* RTC Year-Month-Day */
>> > +    REG_HHMMSS,          /* RTC Hour-Minute-Second */
>> > +    REG_ALARM1_WKHHMMSS, /* Alarm1 Week Hour-Minute-Second */
>> > +    REG_ALARM1_EN,       /* Alarm1 Enable */
>> > +    REG_ALARM1_IRQ_EN,   /* Alarm1 IRQ Enable */
>> > +    REG_ALARM1_IRQ_STA,  /* Alarm1 IRQ Status */
>> > +    REG_GP0,             /* General Purpose Register 0 */
>> > +    REG_GP1,             /* General Purpose Register 1 */
>> > +    REG_GP2,             /* General Purpose Register 2 */
>> > +    REG_GP3,             /* General Purpose Register 3 */
>> > +
>> > +    /* sun4i registers */
>> > +    REG_ALARM1_DDHHMMSS, /* Alarm1 Day Hour-Minute-Second */
>> > +    REG_CPUCFG,          /* CPU Configuration Register */
>> > +
>> > +    /* sun6i registers */
>> > +    REG_LOSC_AUTOSTA,    /* LOSC Auto Switch Status */
>> > +    REG_INT_OSC_PRE,     /* Internal OSC Clock Prescaler */
>> > +    REG_ALARM0_COUNTER,  /* Alarm0 Counter */
>> > +    REG_ALARM0_CUR_VLU,  /* Alarm0 Counter Current Value */
>> > +    REG_ALARM0_ENABLE,   /* Alarm0 Enable */
>> > +    REG_ALARM0_IRQ_EN,   /* Alarm0 IRQ Enable */
>> > +    REG_ALARM0_IRQ_STA,  /* Alarm0 IRQ Status */
>> > +    REG_ALARM_CONFIG,    /* Alarm Config */
>> > +    REG_LOSC_OUT_GATING, /* LOSC Output Gating Register */
>> > +    REG_GP4,             /* General Purpose Register 4 */
>> > +    REG_GP5,             /* General Purpose Register 5 */
>> > +    REG_GP6,             /* General Purpose Register 6 */
>> > +    REG_GP7,             /* General Purpose Register 7 */
>> > +    REG_RTC_DBG,         /* RTC Debug Register */
>> > +    REG_GPL_HOLD_OUT,    /* GPL Hold Output Register */
>> > +    REG_VDD_RTC,         /* VDD RTC Regulate Register */
>> > +    REG_IC_CHARA,        /* IC Characteristics Register */
>> > +};
>> > +
>> > +/* RTC register flags */
>> > +enum {
>> > +    REG_LOSC_YMD   =3D (1 << 7),
>> > +    REG_LOSC_HMS   =3D (1 << 8),
>> > +};
>> > +
>> > +/* RTC sun4i register map (offset to name) */
>> > +const uint8_t allwinner_rtc_sun4i_regmap[] =3D {
>> > +    [0x0000] =3D REG_LOSC,
>> > +    [0x0004] =3D REG_YYMMDD,
>> > +    [0x0008] =3D REG_HHMMSS,
>> > +    [0x000C] =3D REG_ALARM1_DDHHMMSS,
>> > +    [0x0010] =3D REG_ALARM1_WKHHMMSS,
>> > +    [0x0014] =3D REG_ALARM1_EN,
>> > +    [0x0018] =3D REG_ALARM1_IRQ_EN,
>> > +    [0x001C] =3D REG_ALARM1_IRQ_STA,
>> > +    [0x0020] =3D REG_GP0,
>> > +    [0x0024] =3D REG_GP1,
>> > +    [0x0028] =3D REG_GP2,
>> > +    [0x002C] =3D REG_GP3,
>> > +    [0x003C] =3D REG_CPUCFG,
>> > +};
>> > +
>> > +/* RTC sun6i register map (offset to name) */
>> > +const uint8_t allwinner_rtc_sun6i_regmap[] =3D {
>> > +    [0x0000] =3D REG_LOSC,
>> > +    [0x0004] =3D REG_LOSC_AUTOSTA,
>> > +    [0x0008] =3D REG_INT_OSC_PRE,
>> > +    [0x0010] =3D REG_YYMMDD,
>> > +    [0x0014] =3D REG_HHMMSS,
>> > +    [0x0020] =3D REG_ALARM0_COUNTER,
>> > +    [0x0024] =3D REG_ALARM0_CUR_VLU,
>> > +    [0x0028] =3D REG_ALARM0_ENABLE,
>> > +    [0x002C] =3D REG_ALARM0_IRQ_EN,
>> > +    [0x0030] =3D REG_ALARM0_IRQ_STA,
>> > +    [0x0040] =3D REG_ALARM1_WKHHMMSS,
>> > +    [0x0044] =3D REG_ALARM1_EN,
>> > +    [0x0048] =3D REG_ALARM1_IRQ_EN,
>> > +    [0x004C] =3D REG_ALARM1_IRQ_STA,
>> > +    [0x0050] =3D REG_ALARM_CONFIG,
>> > +    [0x0060] =3D REG_LOSC_OUT_GATING,
>> > +    [0x0100] =3D REG_GP0,
>> > +    [0x0104] =3D REG_GP1,
>> > +    [0x0108] =3D REG_GP2,
>> > +    [0x010C] =3D REG_GP3,
>> > +    [0x0110] =3D REG_GP4,
>> > +    [0x0114] =3D REG_GP5,
>> > +    [0x0118] =3D REG_GP6,
>> > +    [0x011C] =3D REG_GP7,
>> > +    [0x0170] =3D REG_RTC_DBG,
>> > +    [0x0180] =3D REG_GPL_HOLD_OUT,
>> > +    [0x0190] =3D REG_VDD_RTC,
>> > +    [0x01F0] =3D REG_IC_CHARA,
>> > +};
>> > +
>> > +static bool allwinner_rtc_sun4i_read(AwRtcState *s, uint32_t offset)
>> > +{
>> > +    /* no sun4i specific registers currently implemented */
>> > +    return false;
>> > +}
>> > +
>> > +static bool allwinner_rtc_sun4i_write(AwRtcState *s, uint32_t offset,
>> > +                                      uint32_t data)
>> > +{
>> > +    /* no sun4i specific registers currently implemented */
>> > +    return false;
>> > +}
>> > +
>> > +static bool allwinner_rtc_sun6i_read(AwRtcState *s, uint32_t offset)
>> > +{
>> > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
>> > +
>> > +    switch (c->regmap[offset]) {
>> > +    case REG_GP4:             /* General Purpose Register 4 */
>> > +    case REG_GP5:             /* General Purpose Register 5 */
>> > +    case REG_GP6:             /* General Purpose Register 6 */
>> > +    case REG_GP7:             /* General Purpose Register 7 */
>> > +        return true;
>> > +    default:
>> > +        break;
>> > +    }
>> > +    return false;
>> > +}
>> > +
>> > +static bool allwinner_rtc_sun6i_write(AwRtcState *s, uint32_t offset,
>> > +                                      uint32_t data)
>> > +{
>> > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
>> > +
>> > +    switch (c->regmap[offset]) {
>> > +    case REG_GP4:             /* General Purpose Register 4 */
>> > +    case REG_GP5:             /* General Purpose Register 5 */
>> > +    case REG_GP6:             /* General Purpose Register 6 */
>> > +    case REG_GP7:             /* General Purpose Register 7 */
>> > +        return true;
>> > +    default:
>> > +        break;
>> > +    }
>> > +    return false;
>> > +}
>> > +
>> > +static uint64_t allwinner_rtc_read(void *opaque, hwaddr offset,
>> > +                                   unsigned size)
>> > +{
>> > +    AwRtcState *s =3D AW_RTC(opaque);
>> > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
>> > +    uint64_t val =3D 0;
>> > +
>> > +    if (offset >=3D AW_RTC_REGS_MAXADDR) {
>> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
>> 0x%04x\n",
>> > +                      __func__, (uint32_t)offset);
>> > +        return 0;
>> > +    }
>> > +
>> > +    if (!c->regmap[offset]) {
>> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid register
>> 0x%04x\n",
>> > +                          __func__, (uint32_t)offset);
>> > +        return 0;
>> > +    }
>> > +
>> > +    switch (c->regmap[offset]) {
>> > +    case REG_LOSC:       /* Low Oscillator Control */
>> > +        val =3D s->regs[REG_LOSC];
>> > +        s->regs[REG_LOSC] &=3D ~(REG_LOSC_YMD | REG_LOSC_HMS);
>> > +        break;
>> > +    case REG_YYMMDD:     /* RTC Year-Month-Day */
>> > +    case REG_HHMMSS:     /* RTC Hour-Minute-Second */
>> > +    case REG_GP0:        /* General Purpose Register 0 */
>> > +    case REG_GP1:        /* General Purpose Register 1 */
>> > +    case REG_GP2:        /* General Purpose Register 2 */
>> > +    case REG_GP3:        /* General Purpose Register 3 */
>> > +        val =3D s->regs[c->regmap[offset]];
>> > +        break;
>> > +    default:
>> > +        if (!c->read(s, offset)) {
>> > +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented register
>> 0x%04x\n",
>> > +                          __func__, (uint32_t)offset);
>> > +        }
>> > +        val =3D s->regs[c->regmap[offset]];
>> > +        break;
>> > +    }
>> > +
>> > +    trace_allwinner_rtc_read(offset, val);
>> > +    return val;
>> > +}
>> > +
>> > +static void allwinner_rtc_write(void *opaque, hwaddr offset,
>> > +                                uint64_t val, unsigned size)
>> > +{
>> > +    AwRtcState *s =3D AW_RTC(opaque);
>> > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
>> > +
>> > +    if (offset >=3D AW_RTC_REGS_MAXADDR) {
>> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
>> 0x%04x\n",
>> > +                      __func__, (uint32_t)offset);
>> > +        return;
>> > +    }
>> > +
>> > +    if (!c->regmap[offset]) {
>> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid register
>> 0x%04x\n",
>> > +                          __func__, (uint32_t)offset);
>> > +        return;
>> > +    }
>> > +
>> > +    trace_allwinner_rtc_write(offset, val);
>> > +
>> > +    switch (c->regmap[offset]) {
>> > +    case REG_YYMMDD:     /* RTC Year-Month-Day */
>> > +        s->regs[REG_YYMMDD] =3D val;
>> > +        s->regs[REG_LOSC]  |=3D REG_LOSC_YMD;
>> > +        break;
>> > +    case REG_HHMMSS:     /* RTC Hour-Minute-Second */
>> > +        s->regs[REG_HHMMSS] =3D val;
>> > +        s->regs[REG_LOSC]  |=3D REG_LOSC_HMS;
>> > +        break;
>> > +    case REG_GP0:        /* General Purpose Register 0 */
>> > +    case REG_GP1:        /* General Purpose Register 1 */
>> > +    case REG_GP2:        /* General Purpose Register 2 */
>> > +    case REG_GP3:        /* General Purpose Register 3 */
>> > +        s->regs[c->regmap[offset]] =3D val;
>> > +        break;
>> > +    default:
>> > +        if (!c->write(s, offset, val)) {
>> > +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented register
>> 0x%04x\n",
>> > +                          __func__, (uint32_t)offset);
>> > +        }
>> > +        break;
>> > +    }
>> > +}
>> > +
>> > +static const MemoryRegionOps allwinner_rtc_ops =3D {
>> > +    .read =3D allwinner_rtc_read,
>> > +    .write =3D allwinner_rtc_write,
>> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> > +    .valid =3D {
>> > +        .min_access_size =3D 4,
>> > +        .max_access_size =3D 4,
>> > +    },
>> > +    .impl.min_access_size =3D 4,
>> > +};
>> > +
>> > +static void allwinner_rtc_reset(DeviceState *dev)
>> > +{
>> > +    AwRtcState *s =3D AW_RTC(dev);
>> > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(dev);
>> > +    struct tm now;
>> > +
>> > +    /* Clear registers */
>> > +    memset(s->regs, 0, sizeof(s->regs));
>> > +
>> > +    /* Get current datetime */
>> > +    qemu_get_timedate(&now, 0);
>> > +
>> > +    /* Set RTC with current datetime */
>> > +    s->regs[REG_YYMMDD] =3D  ((now.tm_year - c->year_offset) << 16) |
>> > +                           ((now.tm_mon + 1) << 8) |
>> > +                             now.tm_mday;
>> > +    s->regs[REG_HHMMSS] =3D (((now.tm_wday + 6) % 7) << 29) |
>> > +                              (now.tm_hour << 16) |
>> > +                              (now.tm_min << 8) |
>> > +                               now.tm_sec;
>>
>> This doesn't look correct.
>>
>>  From H3 Datasheet (Rev1.2):
>>    4.8.3.4. RTC YY-MM-DD Register (Default Value: 0x00000000)
>>    4.8.3.5. RTC HH-MM-SS Register (Default Value: 0x00000000)
>>
>
> I don't yet fully understand what you mean. Could you please explain a bi=
t
> more what should be changed?
>
> For filling the YYMMDD and HHMMSS register fields, I simply looked at the
> 4.8.3.4 and 4.8.3.5 sections
> and filled it with the time retrieved from qemu_get_timedate. The shifts
> are done so the values are set in the proper bits.
> If I read it with the hwclock -r command under Linux, this reads out OK.
> On NetBSD, this works as well, except for the base year mismatch which I
> explained above.
>
>
>>
>> I'm not sure what is the proper to model this, maybe set this value in
>> init()? If we suspend a machine, migrate it, and resume it, what RTC are
>> we expecting?
>>
> I forgot to reply on this one.

I have not used migration very often, but I did manage to test it a couple
of times
using the 'migrate' command on the Qemu monitor console before I submitted
each
new version of the patch series. My expectation would be that the RTC time
is suspended
along with all the other state of the machine such as memory, I/O devices
etc. So that would mean
the time is 'frozen' until resumed. I think that is what we currently have
here.

Do you think that is correct or should it work differently?



>
>> Rest of the patch looks good.
>>
> Thanks for your feedback Philippe!
> I'm processing it for v4.
>
> Regards,
> Niek
>
>>
>> > +}
>> > +
>> > +static void allwinner_rtc_init(Object *obj)
>> > +{
>> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> > +    AwRtcState *s =3D AW_RTC(obj);
>> > +
>> > +    /* Memory mapping */
>> > +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_rtc_ops, s=
,
>> > +                          TYPE_AW_RTC, 1 * KiB);
>> > +    sysbus_init_mmio(sbd, &s->iomem);
>> > +}
>> > +
>> > +static const VMStateDescription allwinner_rtc_vmstate =3D {
>> > +    .name =3D "allwinner-rtc",
>> > +    .version_id =3D 1,
>> > +    .minimum_version_id =3D 1,
>> > +    .fields =3D (VMStateField[]) {
>> > +        VMSTATE_UINT32_ARRAY(regs, AwRtcState, AW_RTC_REGS_NUM),
>> > +        VMSTATE_END_OF_LIST()
>> > +    }
>> > +};
>> > +
>> > +static void allwinner_rtc_class_init(ObjectClass *klass, void *data)
>> > +{
>> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> > +
>> > +    dc->reset =3D allwinner_rtc_reset;
>> > +    dc->vmsd =3D &allwinner_rtc_vmstate;
>> > +}
>> > +
>> > +static void allwinner_rtc_sun4i_class_init(ObjectClass *klass, void
>> *data)
>> > +{
>> > +    AwRtcClass *arc =3D AW_RTC_CLASS(klass);
>> > +
>> > +    arc->regmap =3D allwinner_rtc_sun4i_regmap;
>> > +    arc->regmap_size =3D ARRAY_SIZE(allwinner_rtc_sun4i_regmap);
>> > +    arc->year_offset =3D 110;
>> > +    arc->read =3D allwinner_rtc_sun4i_read;
>> > +    arc->write =3D allwinner_rtc_sun4i_write;
>> > +}
>> > +
>> > +static void allwinner_rtc_sun6i_class_init(ObjectClass *klass, void
>> *data)
>> > +{
>> > +    AwRtcClass *arc =3D AW_RTC_CLASS(klass);
>> > +
>> > +    arc->regmap =3D allwinner_rtc_sun6i_regmap;
>> > +    arc->regmap_size =3D ARRAY_SIZE(allwinner_rtc_sun6i_regmap);
>> > +    arc->year_offset =3D 70;
>> > +    arc->read =3D allwinner_rtc_sun6i_read;
>> > +    arc->write =3D allwinner_rtc_sun6i_write;
>> > +}
>> > +
>> > +static void allwinner_rtc_sun7i_class_init(ObjectClass *klass, void
>> *data)
>> > +{
>> > +    AwRtcClass *arc =3D AW_RTC_CLASS(klass);
>> > +
>> > +    allwinner_rtc_sun4i_class_init(klass, arc);
>> > +    arc->year_offset =3D 70;
>> > +}
>> > +
>> > +static const TypeInfo allwinner_rtc_info =3D {
>> > +    .name          =3D TYPE_AW_RTC,
>> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> > +    .instance_init =3D allwinner_rtc_init,
>> > +    .instance_size =3D sizeof(AwRtcState),
>> > +    .class_init    =3D allwinner_rtc_class_init,
>> > +    .class_size    =3D sizeof(AwRtcClass),
>> > +    .abstract      =3D true,
>> > +};
>> > +
>> > +static const TypeInfo allwinner_rtc_sun4i_info =3D {
>> > +    .name          =3D TYPE_AW_RTC_SUN4I,
>> > +    .parent        =3D TYPE_AW_RTC,
>> > +    .class_init    =3D allwinner_rtc_sun4i_class_init,
>> > +};
>> > +
>> > +static const TypeInfo allwinner_rtc_sun6i_info =3D {
>> > +    .name          =3D TYPE_AW_RTC_SUN6I,
>> > +    .parent        =3D TYPE_AW_RTC,
>> > +    .class_init    =3D allwinner_rtc_sun6i_class_init,
>> > +};
>> > +
>> > +static const TypeInfo allwinner_rtc_sun7i_info =3D {
>> > +    .name          =3D TYPE_AW_RTC_SUN7I,
>> > +    .parent        =3D TYPE_AW_RTC,
>> > +    .class_init    =3D allwinner_rtc_sun7i_class_init,
>> > +};
>> > +
>> > +static void allwinner_rtc_register(void)
>> > +{
>> > +    type_register_static(&allwinner_rtc_info);
>> > +    type_register_static(&allwinner_rtc_sun4i_info);
>> > +    type_register_static(&allwinner_rtc_sun6i_info);
>> > +    type_register_static(&allwinner_rtc_sun7i_info);
>> > +}
>> > +
>> > +type_init(allwinner_rtc_register)
>> > diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
>> > index 8dc9fcd3a9..12d92feebf 100644
>> > --- a/hw/rtc/Makefile.objs
>> > +++ b/hw/rtc/Makefile.objs
>> > @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
>> >   obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>> >   common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>> >   common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o
>> > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-rtc.o
>> > diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
>> > index d6749f4616..eb57de3bd6 100644
>> > --- a/hw/rtc/trace-events
>> > +++ b/hw/rtc/trace-events
>> > @@ -1,5 +1,9 @@
>> >   # See docs/devel/tracing.txt for syntax documentation.
>> >
>> > +# allwinner-rtc.c
>> > +allwinner_rtc_read(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 "
>> value 0x%" PRIx64
>> > +allwinner_rtc_write(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 =
"
>> value 0x%" PRIx64
>> > +
>> >   # sun4v-rtc.c
>> >   sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx6=
4
>> " value 0x%" PRIx64
>> >   sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%"
>> PRIx64 " value 0x%" PRIx64
>> >
>>
>>
>
> --
> Niek Linnenbank
>
>

--=20
Niek Linnenbank

--0000000000006efabb059c218501
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 14, 2020 at 11:52 PM Niek=
 Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 13, 2020 at 11=
:57 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com"=
 target=3D"_blank">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 1/8/20 9:00 PM, Niek Linnenbank wrot=
e:<br>
&gt; Allwinner System-on-Chips usually contain a Real Time Clock (RTC)<br>
&gt; for non-volatile system date and time keeping. This commit adds a gene=
ric<br>
&gt; Allwinner RTC device that supports the RTC devices found in Allwinner =
SoC<br>
&gt; family sun4i (A10), sun7i (A20) and sun6i and newer (A31, H2+, H3, etc=
).<br>
&gt; The following RTC functionality and features are implemented:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Year-Month-Day read/write<br>
&gt;=C2=A0 =C2=A0* Hour-Minute-Second read/write<br>
&gt;=C2=A0 =C2=A0* General Purpose storage<br>
&gt; <br>
&gt; The following boards are extended with the RTC device:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Cubieboard (hw/arm/cubieboard.c)<br>
&gt;=C2=A0 =C2=A0* Orange Pi PC (hw/arm/orangepi.c)<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-a10.h |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0include/hw/rtc/allwinner-rtc.h | 129 +++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A09 +-<br>
&gt;=C2=A0 =C2=A0hw/rtc/allwinner-rtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
386 +++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/rtc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/rtc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A08 files changed, 541 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/rtc/allwinner-rtc.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/rtc/allwinner-rtc.c<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner=
-a10.h<br>
&gt; index 0e8250b244..81a16092e7 100644<br>
&gt; --- a/include/hw/arm/allwinner-a10.h<br>
&gt; +++ b/include/hw/arm/allwinner-a10.h<br>
&gt; @@ -9,6 +9,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/net/allwinner_emac.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/ide/ahci.h&quot;<br>
&gt; +#include &quot;hw/rtc/allwinner-rtc.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -18,7 +19,7 @@<br>
&gt;=C2=A0 =C2=A0#define AW_A10_UART0_REG_BASE=C2=A0 =C2=A00x01c28000<br>
&gt;=C2=A0 =C2=A0#define AW_A10_EMAC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c0=
b000<br>
&gt;=C2=A0 =C2=A0#define AW_A10_SATA_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c1=
8000<br>
&gt; -<br>
&gt; +#define AW_A10_RTC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01c20d00<b=
r>
&gt;=C2=A0 =C2=A0#define AW_A10_SDRAM_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x4000=
0000<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define TYPE_AW_A10 &quot;allwinner-a10&quot;<br>
&gt; @@ -36,6 +37,7 @@ typedef struct AwA10State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwEmacState emac;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AllwinnerAHCIState sata;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwSdHostState mmc0;<br>
&gt; +=C2=A0 =C2=A0 AwRtcState rtc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a;<br>
&gt;=C2=A0 =C2=A0} AwA10State;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index d1b3d7ca67..1c275a34ed 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -50,6 +50,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
&gt; +#include &quot;hw/rtc/allwinner-rtc.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -92,6 +93,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_CPU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_HYP,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_VCPU,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_RTC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_CPUCFG,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SDRAM<br>
&gt;=C2=A0 =C2=A0};<br>
&gt; @@ -130,6 +132,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwSidState sid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwSdHostState mmc0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwSun8iEmacState emac;<br>
&gt; +=C2=A0 =C2=A0 AwRtcState rtc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/rtc/allwinner-rtc.h b/include/hw/rtc/allwinner=
-rtc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..e29dfc775f<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/rtc/allwinner-rtc.h<br>
&gt; @@ -0,0 +1,129 @@<br>
&gt; +/*<br>
&gt; + * Allwinner Real Time Clock emulation<br>
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
&gt; +#ifndef HW_MISC_ALLWINNER_RTC_H<br>
&gt; +#define HW_MISC_ALLWINNER_RTC_H<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Constants<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +/** Highest register address used by RTC device */<br>
&gt; +#define AW_RTC_REGS_MAXADDR=C2=A0 =C2=A0 =C2=A0(0x1F4)<br>
<br>
I&#39;d start using 0x200 here so in case new SoC use registers in this <br=
>
block range (or undocumented reg) so we don&#39;t have to modify <br>
allwinner_rtc_vmstate.<br></blockquote><div><br></div><div>Good point, I&#3=
9;ll change it to 0x200.</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
&gt; +<br>
&gt; +/** Total number of known registers */<br>
&gt; +#define AW_RTC_REGS_NUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(AW_RTC_REGS=
_MAXADDR / sizeof(uint32_t))<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Object model types<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +/** Generic Allwinner RTC device (abstract) */<br>
&gt; +#define TYPE_AW_RTC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;allwinner=
-rtc&quot;<br>
&gt; +<br>
&gt; +/** Allwinner RTC sun4i family (A10, A12) */<br>
&gt; +#define TYPE_AW_RTC_SUN4I=C2=A0 =C2=A0 TYPE_AW_RTC &quot;-sun4i&quot;=
<br>
&gt; +<br>
&gt; +/** Allwinner RTC sun6i family and newer (A31, H2+, H3, etc) */<br>
&gt; +#define TYPE_AW_RTC_SUN6I=C2=A0 =C2=A0 TYPE_AW_RTC &quot;-sun6i&quot;=
<br>
&gt; +<br>
&gt; +/** Allwinner RTC sun7i family (A20) */<br>
&gt; +#define TYPE_AW_RTC_SUN7I=C2=A0 =C2=A0 TYPE_AW_RTC &quot;-sun7i&quot;=
<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Object model macros<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define AW_RTC(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AwRtcState, (obj), TYPE_AW_RTC)<br>
&gt; +#define AW_RTC_CLASS(klass) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0OBJECT_CLASS_CHECK(AwRtcClass, (klass), TYPE_AW_R=
TC)<br>
&gt; +#define AW_RTC_GET_CLASS(obj) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0OBJECT_GET_CLASS(AwRtcClass, (obj), TYPE_AW_RTC)<=
br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner RTC per-object instance state.<br>
&gt; + */<br>
&gt; +typedef struct AwRtcState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Array of hardware registers */<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[AW_RTC_REGS_NUM];<br>
&gt; +<br>
&gt; +} AwRtcState;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner RTC class-level struct.<br>
&gt; + *<br>
&gt; + * This struct is filled by each sunxi device specific code<br>
&gt; + * such that the generic code can use this struct to support<br>
&gt; + * all devices.<br>
&gt; + */<br>
&gt; +typedef struct AwRtcClass {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDeviceClass parent_class;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Defines device specific register map */<br>
&gt; +=C2=A0 =C2=A0 const uint8_t *regmap;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Number of entries in regmap */<br>
&gt; +=C2=A0 =C2=A0 size_t regmap_size;<br>
<br>
I&#39;d rather call this &#39;regmap_count&#39;.<br></blockquote><div>Sure,=
 I&#39;ll name it regmap_count.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
If you don&#39;t use this field, can we remove it?<br></blockquote><div>=C2=
=A0</div><div>Actually I think I made a mistake there, thanks for the catch=
!</div><div> In fact it should be used to verify the guest does not read ou=
tside the AwRtcClass-&gt;regmap.</div><div>I&#39;ll correct this in v4.</di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Device offset in years to 1900, for struct tm.tm_ye=
ar */<br>
&gt; +=C2=A0 =C2=A0 uint8_t year_offset;<br>
<br>
struct tm uses &#39;int&#39; for this field.<br></blockquote><div>OK.<br></=
div><div><br></div><div>By the way, the behavior I noticed when reading the=
 RTC from NetBSD versus Linux is due to a mismatch in</div><div>the base ye=
ar configured by the two operating systems. Linux starts counting from 1970=
 for the RTC in sun6i (drivers/rtc/rtc-sun6i.c, SUN6I_YEAR_MIN),</div><div>=
while NetBSD uses 2000 as the base year (usr/src/sys/arch/arm/sunxi/sunxi_r=
tc.c, SUN6I_RTC_BASE_YEAR).</div><div>So if the RTC year field is filled wi=
th the number 50, it results in 2020 on Linux, but reads as 2050 on NetBSD.=
</div><div><br></div><div>I&#39;m not sure yet which one is correct. The da=
tasheet does not explicitely mention what should be the base/start year,</d=
iv><div>only that it is within the range 0..63.</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Read device specific register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @offset: register offset to read<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @return true if register read successful, false=
 otherwise<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool (*read)(AwRtcState *s, uint32_t offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Write device specific register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @offset: register offset to write<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @data: value to set in register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @return true if register write successful, fals=
e otherwise<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool (*write)(AwRtcState *s, uint32_t offset, uint32_t =
data);<br>
&gt; +<br>
&gt; +} AwRtcClass;<br>
&gt; +<br>
&gt; +#endif /* HW_MISC_ALLWINNER_RTC_H */<br>
&gt; diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c<br>
&gt; index 61cf3550a6..3f8f9d0d19 100644<br>
&gt; --- a/hw/arm/allwinner-a10.c<br>
&gt; +++ b/hw/arm/allwinner-a10.c<br>
&gt; @@ -46,6 +46,9 @@ static void aw_a10_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;mmc0&quot;,=
 &amp;s-&gt;mmc0, sizeof(s-&gt;mmc0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_SDHOST_SUN4I);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;rtc&quot;, &amp;s-&gt;=
rtc, sizeof(s-&gt;rtc),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_RTC_SUN4I);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void aw_a10_realize(DeviceState *dev, Error **errp)=
<br>
&gt; @@ -128,6 +131,10 @@ static void aw_a10_realize(DeviceState *dev, Erro=
r **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt=
;mmc0), 0, s-&gt;irq[32]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add_alias(OBJECT(s), &quot;s=
d-bus&quot;, OBJECT(&amp;s-&gt;mmc0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;sd-bus&quot;, &amp;er=
ror_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* RTC */<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;rtc));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&amp;s-&gt;rtc),=
 0, AW_A10_RTC_BASE, 10);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void aw_a10_class_init(ObjectClass *oc, void *data)=
<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index 77b823e7d8..caa4d8b196 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -61,6 +61,7 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_GIC_CPU]=C2=A0 =C2=A0 =3D 0x01c82000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_GIC_HYP]=C2=A0 =C2=A0 =3D 0x01c84000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_GIC_VCPU]=C2=A0 =C2=A0=3D 0x01c86000,=
<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_RTC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01f00000,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_CPUCFG]=C2=A0 =C2=A0 =C2=A0=3D 0x01f0=
1c00,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SDRAM]=C2=A0 =C2=A0 =C2=A0 =3D 0x4000=
0000<br>
&gt;=C2=A0 =C2=A0};<br>
&gt; @@ -116,7 +117,6 @@ struct AwH3Unimplemented {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;csi&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01cb0000, 320 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;tve&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x01e00000, 64 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;hdmi&quot;,=C2=A0 =C2=A0 =C2=A0 0x01=
ee0000, 128 * KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;rtc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01f00000=
, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;r_timer&quot;,=C2=A0 =C2=A00x01f0080=
0, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;r_intc&quot;,=C2=A0 =C2=A0 0x01f00c0=
0, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;r_wdog&quot;,=C2=A0 =C2=A0 0x01f0100=
0, 1 * KiB },<br>
&gt; @@ -244,6 +244,9 @@ static void allwinner_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ram-addr&quot;, &amp;error_=
abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add_alias(obj, &quot;ram-siz=
e&quot;, OBJECT(&amp;s-&gt;dramc),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ram-size&quot;, &amp;=
error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;rtc&quot;, &amp;s-&gt;=
rtc, sizeof(s-&gt;rtc),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_RTC_SUN6I);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void allwinner_h3_realize(DeviceState *dev, Error *=
*errp)<br>
&gt; @@ -437,6 +440,10 @@ static void allwinner_h3_realize(DeviceState *dev=
, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dr=
amc), 1, s-&gt;memmap[AW_H3_DRAMCTL]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dr=
amc), 2, s-&gt;memmap[AW_H3_DRAMPHY]);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* RTC */<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;rtc));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;rtc), 0, s-&g=
t;memmap[AW_H3_RTC]);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Unimplemented devices */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; ARRAY_SIZE(unimplem=
ented); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_unimplemented_device(un=
implemented[i].device_name,<br>
&gt; diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..812fe7f10b<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/rtc/allwinner-rtc.c<br>
&gt; @@ -0,0 +1,386 @@<br>
&gt; +/*<br>
&gt; + * Allwinner Real Time Clock emulation<br>
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
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu-common.h&quot;<br>
&gt; +#include &quot;hw/rtc/allwinner-rtc.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +<br>
&gt; +/* RTC registers */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_LOSC =3D 1,=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Low Oscil=
lator Control */<br>
&gt; +=C2=A0 =C2=A0 REG_YYMMDD,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RTC Ye=
ar-Month-Day */<br>
&gt; +=C2=A0 =C2=A0 REG_HHMMSS,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RTC Ho=
ur-Minute-Second */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM1_WKHHMMSS, /* Alarm1 Week Hour-Minute-Second =
*/<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM1_EN,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Alarm1 Enab=
le */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM1_IRQ_EN,=C2=A0 =C2=A0/* Alarm1 IRQ Enable */<=
br>
&gt; +=C2=A0 =C2=A0 REG_ALARM1_IRQ_STA,=C2=A0 /* Alarm1 IRQ Status */<br>
&gt; +=C2=A0 =C2=A0 REG_GP0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 0 */<br>
&gt; +=C2=A0 =C2=A0 REG_GP1,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 1 */<br>
&gt; +=C2=A0 =C2=A0 REG_GP2,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 2 */<br>
&gt; +=C2=A0 =C2=A0 REG_GP3,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 3 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* sun4i registers */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM1_DDHHMMSS, /* Alarm1 Day Hour-Minute-Second *=
/<br>
&gt; +=C2=A0 =C2=A0 REG_CPUCFG,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU Co=
nfiguration Register */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* sun6i registers */<br>
&gt; +=C2=A0 =C2=A0 REG_LOSC_AUTOSTA,=C2=A0 =C2=A0 /* LOSC Auto Switch Stat=
us */<br>
&gt; +=C2=A0 =C2=A0 REG_INT_OSC_PRE,=C2=A0 =C2=A0 =C2=A0/* Internal OSC Clo=
ck Prescaler */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM0_COUNTER,=C2=A0 /* Alarm0 Counter */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM0_CUR_VLU,=C2=A0 /* Alarm0 Counter Current Val=
ue */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM0_ENABLE,=C2=A0 =C2=A0/* Alarm0 Enable */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM0_IRQ_EN,=C2=A0 =C2=A0/* Alarm0 IRQ Enable */<=
br>
&gt; +=C2=A0 =C2=A0 REG_ALARM0_IRQ_STA,=C2=A0 /* Alarm0 IRQ Status */<br>
&gt; +=C2=A0 =C2=A0 REG_ALARM_CONFIG,=C2=A0 =C2=A0 /* Alarm Config */<br>
&gt; +=C2=A0 =C2=A0 REG_LOSC_OUT_GATING, /* LOSC Output Gating Register */<=
br>
&gt; +=C2=A0 =C2=A0 REG_GP4,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 4 */<br>
&gt; +=C2=A0 =C2=A0 REG_GP5,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 5 */<br>
&gt; +=C2=A0 =C2=A0 REG_GP6,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 6 */<br>
&gt; +=C2=A0 =C2=A0 REG_GP7,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* General Purpose Register 7 */<br>
&gt; +=C2=A0 =C2=A0 REG_RTC_DBG,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* RTC De=
bug Register */<br>
&gt; +=C2=A0 =C2=A0 REG_GPL_HOLD_OUT,=C2=A0 =C2=A0 /* GPL Hold Output Regis=
ter */<br>
&gt; +=C2=A0 =C2=A0 REG_VDD_RTC,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* VDD RT=
C Regulate Register */<br>
&gt; +=C2=A0 =C2=A0 REG_IC_CHARA,=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* IC Characte=
ristics Register */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* RTC register flags */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_LOSC_YMD=C2=A0 =C2=A0=3D (1 &lt;&lt; 7),<br>
&gt; +=C2=A0 =C2=A0 REG_LOSC_HMS=C2=A0 =C2=A0=3D (1 &lt;&lt; 8),<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* RTC sun4i register map (offset to name) */<br>
&gt; +const uint8_t allwinner_rtc_sun4i_regmap[] =3D {<br>
&gt; +=C2=A0 =C2=A0 [0x0000] =3D REG_LOSC,<br>
&gt; +=C2=A0 =C2=A0 [0x0004] =3D REG_YYMMDD,<br>
&gt; +=C2=A0 =C2=A0 [0x0008] =3D REG_HHMMSS,<br>
&gt; +=C2=A0 =C2=A0 [0x000C] =3D REG_ALARM1_DDHHMMSS,<br>
&gt; +=C2=A0 =C2=A0 [0x0010] =3D REG_ALARM1_WKHHMMSS,<br>
&gt; +=C2=A0 =C2=A0 [0x0014] =3D REG_ALARM1_EN,<br>
&gt; +=C2=A0 =C2=A0 [0x0018] =3D REG_ALARM1_IRQ_EN,<br>
&gt; +=C2=A0 =C2=A0 [0x001C] =3D REG_ALARM1_IRQ_STA,<br>
&gt; +=C2=A0 =C2=A0 [0x0020] =3D REG_GP0,<br>
&gt; +=C2=A0 =C2=A0 [0x0024] =3D REG_GP1,<br>
&gt; +=C2=A0 =C2=A0 [0x0028] =3D REG_GP2,<br>
&gt; +=C2=A0 =C2=A0 [0x002C] =3D REG_GP3,<br>
&gt; +=C2=A0 =C2=A0 [0x003C] =3D REG_CPUCFG,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* RTC sun6i register map (offset to name) */<br>
&gt; +const uint8_t allwinner_rtc_sun6i_regmap[] =3D {<br>
&gt; +=C2=A0 =C2=A0 [0x0000] =3D REG_LOSC,<br>
&gt; +=C2=A0 =C2=A0 [0x0004] =3D REG_LOSC_AUTOSTA,<br>
&gt; +=C2=A0 =C2=A0 [0x0008] =3D REG_INT_OSC_PRE,<br>
&gt; +=C2=A0 =C2=A0 [0x0010] =3D REG_YYMMDD,<br>
&gt; +=C2=A0 =C2=A0 [0x0014] =3D REG_HHMMSS,<br>
&gt; +=C2=A0 =C2=A0 [0x0020] =3D REG_ALARM0_COUNTER,<br>
&gt; +=C2=A0 =C2=A0 [0x0024] =3D REG_ALARM0_CUR_VLU,<br>
&gt; +=C2=A0 =C2=A0 [0x0028] =3D REG_ALARM0_ENABLE,<br>
&gt; +=C2=A0 =C2=A0 [0x002C] =3D REG_ALARM0_IRQ_EN,<br>
&gt; +=C2=A0 =C2=A0 [0x0030] =3D REG_ALARM0_IRQ_STA,<br>
&gt; +=C2=A0 =C2=A0 [0x0040] =3D REG_ALARM1_WKHHMMSS,<br>
&gt; +=C2=A0 =C2=A0 [0x0044] =3D REG_ALARM1_EN,<br>
&gt; +=C2=A0 =C2=A0 [0x0048] =3D REG_ALARM1_IRQ_EN,<br>
&gt; +=C2=A0 =C2=A0 [0x004C] =3D REG_ALARM1_IRQ_STA,<br>
&gt; +=C2=A0 =C2=A0 [0x0050] =3D REG_ALARM_CONFIG,<br>
&gt; +=C2=A0 =C2=A0 [0x0060] =3D REG_LOSC_OUT_GATING,<br>
&gt; +=C2=A0 =C2=A0 [0x0100] =3D REG_GP0,<br>
&gt; +=C2=A0 =C2=A0 [0x0104] =3D REG_GP1,<br>
&gt; +=C2=A0 =C2=A0 [0x0108] =3D REG_GP2,<br>
&gt; +=C2=A0 =C2=A0 [0x010C] =3D REG_GP3,<br>
&gt; +=C2=A0 =C2=A0 [0x0110] =3D REG_GP4,<br>
&gt; +=C2=A0 =C2=A0 [0x0114] =3D REG_GP5,<br>
&gt; +=C2=A0 =C2=A0 [0x0118] =3D REG_GP6,<br>
&gt; +=C2=A0 =C2=A0 [0x011C] =3D REG_GP7,<br>
&gt; +=C2=A0 =C2=A0 [0x0170] =3D REG_RTC_DBG,<br>
&gt; +=C2=A0 =C2=A0 [0x0180] =3D REG_GPL_HOLD_OUT,<br>
&gt; +=C2=A0 =C2=A0 [0x0190] =3D REG_VDD_RTC,<br>
&gt; +=C2=A0 =C2=A0 [0x01F0] =3D REG_IC_CHARA,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static bool allwinner_rtc_sun4i_read(AwRtcState *s, uint32_t offset)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* no sun4i specific registers currently implemented */=
<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool allwinner_rtc_sun4i_write(AwRtcState *s, uint32_t offset,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t da=
ta)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* no sun4i specific registers currently implemented */=
<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool allwinner_rtc_sun6i_read(AwRtcState *s, uint32_t offset)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (c-&gt;regmap[offset]) {<br>
&gt; +=C2=A0 =C2=A0 case REG_GP4:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 4 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP5:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 5 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP6:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 6 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP7:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 7 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool allwinner_rtc_sun6i_write(AwRtcState *s, uint32_t offset,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t da=
ta)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (c-&gt;regmap[offset]) {<br>
&gt; +=C2=A0 =C2=A0 case REG_GP4:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 4 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP5:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 5 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP6:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 6 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP7:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* General Purpose Register 7 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t allwinner_rtc_read(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(opaque);<br>
&gt; +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);<br>
&gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset &gt;=3D AW_RTC_REGS_MAXADDR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!c-&gt;regmap[offset]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR, &quot;%s: invalid register 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (c-&gt;regmap[offset]) {<br>
&gt; +=C2=A0 =C2=A0 case REG_LOSC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Low Oscilla=
tor Control */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;regs[REG_LOSC];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_LOSC] &amp;=3D ~(REG_LOSC_=
YMD | REG_LOSC_HMS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_YYMMDD:=C2=A0 =C2=A0 =C2=A0/* RTC Year-Month-D=
ay */<br>
&gt; +=C2=A0 =C2=A0 case REG_HHMMSS:=C2=A0 =C2=A0 =C2=A0/* RTC Hour-Minute-=
Second */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 0 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 1 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP2:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 2 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP3:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 3 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;regs[c-&gt;regmap[offset]];=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;read(s, offset)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &q=
uot;%s: unimplemented register 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;regs[c-&gt;regmap[offset]];=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_rtc_read(offset, val);<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_rtc_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(opaque);<br>
&gt; +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset &gt;=3D AW_RTC_REGS_MAXADDR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!c-&gt;regmap[offset]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR, &quot;%s: invalid register 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_rtc_write(offset, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (c-&gt;regmap[offset]) {<br>
&gt; +=C2=A0 =C2=A0 case REG_YYMMDD:=C2=A0 =C2=A0 =C2=A0/* RTC Year-Month-D=
ay */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_YYMMDD] =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_LOSC]=C2=A0 |=3D REG_LOSC_=
YMD;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_HHMMSS:=C2=A0 =C2=A0 =C2=A0/* RTC Hour-Minute-=
Second */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_HHMMSS] =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_LOSC]=C2=A0 |=3D REG_LOSC_=
HMS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_GP0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 0 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 1 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP2:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 2 */<br>
&gt; +=C2=A0 =C2=A0 case REG_GP3:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* General Pur=
pose Register 3 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[c-&gt;regmap[offset]] =3D val;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;write(s, offset, val)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &q=
uot;%s: unimplemented register 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_rtc_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_rtc_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_rtc_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_rtc_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(dev);<br>
&gt; +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(dev);<br>
&gt; +=C2=A0 =C2=A0 struct tm now;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Clear registers */<br>
&gt; +=C2=A0 =C2=A0 memset(s-&gt;regs, 0, sizeof(s-&gt;regs));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Get current datetime */<br>
&gt; +=C2=A0 =C2=A0 qemu_get_timedate(&amp;now, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set RTC with current datetime */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_YYMMDD] =3D=C2=A0 ((now.tm_year - c-&gt;=
year_offset) &lt;&lt; 16) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0((now.tm_mon + 1) &lt;&lt; 8) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0now.tm_mday;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_HHMMSS] =3D (((now.tm_wday + 6) % 7) &lt=
;&lt; 29) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (now.tm_hour &lt;&lt; 16) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (now.tm_min &lt;&lt; 8) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0now.tm_sec;<br>
<br>
This doesn&#39;t look correct.<br>
<br>
=C2=A0From H3 Datasheet (Rev1.2):<br>
=C2=A0 =C2=A04.8.3.4. RTC YY-MM-DD Register (Default Value: 0x00000000)<br>
=C2=A0 =C2=A04.8.3.5. RTC HH-MM-SS Register (Default Value: 0x00000000)<br>=
</blockquote><div><br></div><div>I don&#39;t yet fully understand what you =
mean. Could you please explain a bit more what should be changed?</div><div=
><br></div><div>For filling the YYMMDD and HHMMSS register fields, I simply=
 looked at the 4.8.3.4 and 4.8.3.5 sections</div><div>and filled it with th=
e time retrieved from qemu_get_timedate. The shifts are done so the values =
are set in the proper bits.</div><div>If I read it with the hwclock -r comm=
and under Linux, this reads out OK.</div><div>On NetBSD, this works as well=
, except for the base year mismatch which I explained above.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I&#39;m not sure what is the proper to model this, maybe set this value in =
<br>
init()? If we suspend a machine, migrate it, and resume it, what RTC are <b=
r>
we expecting?<br></blockquote></div></div></blockquote><div>I forgot to rep=
ly on this one.</div><div><br></div><div>I have not used migration very oft=
en, but I did manage to test it a couple of times</div><div>using the &#39;=
migrate&#39; command on the Qemu monitor console before I submitted each</d=
iv><div>new version of the patch series. My expectation would be that the R=
TC time is suspended</div><div>along with all the other state of the machin=
e such as memory, I/O devices etc. So that would mean</div><div>the time is=
 &#39;frozen&#39; until resumed. I think that is what we currently have her=
e.<br></div><div><br></div><div>Do you think that is correct or should it w=
ork differently?<br></div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Rest of the patch looks good.<br></blockquote><div>Thanks for your feedback=
 Philippe!</div><div>I&#39;m processing it for v4.<br></div><div>=C2=A0</di=
v><div>Regards,</div><div>Niek<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_rtc_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;allwinner_rtc_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_RTC, 1 * KiB);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_rtc_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-rtc&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, AwRtcState, AW=
_RTC_REGS_NUM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_rtc_class_init(ObjectClass *klass, void *data)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_rtc_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_rtc_vmstate;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_rtc_sun4i_class_init(ObjectClass *klass, void *=
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwRtcClass *arc =3D AW_RTC_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;regmap =3D allwinner_rtc_sun4i_regmap;<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;regmap_size =3D ARRAY_SIZE(allwinner_rtc_sun4i_=
regmap);<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;year_offset =3D 110;<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;read =3D allwinner_rtc_sun4i_read;<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;write =3D allwinner_rtc_sun4i_write;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_rtc_sun6i_class_init(ObjectClass *klass, void *=
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwRtcClass *arc =3D AW_RTC_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;regmap =3D allwinner_rtc_sun6i_regmap;<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;regmap_size =3D ARRAY_SIZE(allwinner_rtc_sun6i_=
regmap);<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;year_offset =3D 70;<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;read =3D allwinner_rtc_sun6i_read;<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;write =3D allwinner_rtc_sun6i_write;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_rtc_sun7i_class_init(ObjectClass *klass, void *=
data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwRtcClass *arc =3D AW_RTC_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 allwinner_rtc_sun4i_class_init(klass, arc);<br>
&gt; +=C2=A0 =C2=A0 arc-&gt;year_offset =3D 70;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_rtc_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC=
,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_rtc_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwRtcState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_rtc_class_init,<=
br>
&gt; +=C2=A0 =C2=A0 .class_size=C2=A0 =C2=A0 =3D sizeof(AwRtcClass),<br>
&gt; +=C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0 =C2=A0 =3D true,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_rtc_sun4i_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC=
_SUN4I,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_rtc_sun4i_class_=
init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_rtc_sun6i_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC=
_SUN6I,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_rtc_sun6i_class_=
init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_rtc_sun7i_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC=
_SUN7I,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_RTC,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_rtc_sun7i_class_=
init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_rtc_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_rtc_info);<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_rtc_sun4i_info);<br=
>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_rtc_sun6i_info);<br=
>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_rtc_sun7i_info);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_rtc_register)<br>
&gt; diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs<br>
&gt; index 8dc9fcd3a9..12d92feebf 100644<br>
&gt; --- a/hw/rtc/Makefile.objs<br>
&gt; +++ b/hw/rtc/Makefile.objs<br>
&gt; @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o<b=
r>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o<br>
&gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-rtc.o<br>
&gt; diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events<br>
&gt; index d6749f4616..eb57de3bd6 100644<br>
&gt; --- a/hw/rtc/trace-events<br>
&gt; +++ b/hw/rtc/trace-events<br>
&gt; @@ -1,5 +1,9 @@<br>
&gt;=C2=A0 =C2=A0# See docs/devel/tracing.txt for syntax documentation.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# allwinner-rtc.c<br>
&gt; +allwinner_rtc_read(uint64_t addr, uint64_t value) &quot;addr 0x%&quot=
; PRIx64 &quot; value 0x%&quot; PRIx64<br>
&gt; +allwinner_rtc_write(uint64_t addr, uint64_t value) &quot;addr 0x%&quo=
t; PRIx64 &quot; value 0x%&quot; PRIx64<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0# sun4v-rtc.c<br>
&gt;=C2=A0 =C2=A0sun4v_rtc_read(uint64_t addr, uint64_t value) &quot;read: =
addr 0x%&quot; PRIx64 &quot; value 0x%&quot; PRIx64<br>
&gt;=C2=A0 =C2=A0sun4v_rtc_write(uint64_t addr, uint64_t value) &quot;write=
: addr 0x%&quot; PRIx64 &quot; value 0x%&quot; PRIx64<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000006efabb059c218501--

