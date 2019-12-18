Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8FAC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744A32176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3nmx0KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744A32176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgH8-0006ED-Lw
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgGG-0005jQ-2i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgGC-0006VG-Ar
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:49:35 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihgGB-0006S4-T6; Wed, 18 Dec 2019 15:49:32 -0500
Received: by mail-il1-x141.google.com with SMTP id b15so2884251iln.3;
 Wed, 18 Dec 2019 12:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iWtEX5iWpfFX5/5aJLaNvyTdKGsb22z6bJhbArJSwiE=;
 b=N3nmx0KFkypTD+KP24XDB4xd9WyaUu93VbNdo/yjD2pMqVko+uXPk0CHrOHAOK6uTa
 qReru/+FdKJ7KFL9yT0f5RGO238uK4VRsojWE2uuH2qwY0iIEZJUCWfWvEfg3GgHsuPC
 tNlkox6qpCGaRCcjvLe8wO/fD95yvr2sc5bcftDHV0LdjJJDhZycFNqYWhvGJ88C5auJ
 ri8EKELpb7LxlY5xuIfqeqkNYJB32Rc77pcoURsWgg54ka6jZa2DL85fBmrE5EAGamiF
 h7rIhx0hn+yYuffyrS9IBLrxypp5hxc8TvVlYvk+WJDJfP4EX43Eo3hUVgFz7Pm4++zp
 FOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iWtEX5iWpfFX5/5aJLaNvyTdKGsb22z6bJhbArJSwiE=;
 b=ErnadzqMCQiawgC4iz/XCxPcyvKc/eZNHqzWOnHJLldfwa2a/tee8mIDknaCe17yB5
 VRSxhzx1WDz7tnMd3mtKd11txoQ4MLxXObeX/t/pmgzy9Rue42dz7P7Y/tkEMVKmmt0L
 0FjDzYYbkKplxvaR6YcUSqBzvEVsSssoYGa0TWC9kVucbSYs+tEB2hUYonQt65rodSBm
 AbrR1yWnHmf5r8BKyVapV3tp14lZRsCl0mWgj2O0JEkZ2l32FORg6FV4itN/lacBxy0g
 bInAh+Q5XfLvF9ooFonO0YioikzoXBsZIgidK9eEW1sZ/sSM3+v0O4vKJg44zjGsZ7fM
 5oFg==
X-Gm-Message-State: APjAAAU2HmbD5ls1HCndNZZLrEieNNlEI3Prvuz3lYpK6YdS0xjenjyf
 j4DNDEGIjjaOsPfwpNwzv3dVjR+zuyasIUmP07w=
X-Google-Smtp-Source: APXvYqzaaodGzAqIqWZPz2CrYnXD7dsyUeUpz8QRfLIYf8IKTU1xkkZxlruPFbPiqEDy2naR+D6IS4bJCxaMZ4AtscA=
X-Received: by 2002:a92:c647:: with SMTP id 7mr3832792ill.28.1576702167837;
 Wed, 18 Dec 2019 12:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-9-nieklinnenbank@gmail.com>
 <7153b766-4c3b-5272-3c3e-33e973e74e8f@redhat.com>
In-Reply-To: <7153b766-4c3b-5272-3c3e-33e973e74e8f@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 21:49:15 +0100
Message-ID: <CAPan3Wob3Me-zbESYmFNQ4OczgLnxZZ0CtTxf8AHeRY4QyJ2+w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm: allwinner-h3: add Security Identifier device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a170b4059a0094dc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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

--000000000000a170b4059a0094dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, Dec 17, 2019 at 8:45 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Niek,
>
> On 12/17/19 12:35 AM, Niek Linnenbank wrote:
> > The Security Identifier device in Allwinner H3 System on Chip
> > gives applications a per-board unique identifier. This commit
> > adds support for the Allwinner H3 Security Identifier using
> > a 128-bit UUID value as input.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   include/hw/arm/allwinner-h3.h      |   2 +
> >   include/hw/misc/allwinner-h3-sid.h |  40 +++++++
> >   hw/arm/allwinner-h3.c              |   7 ++
> >   hw/arm/orangepi.c                  |   4 +
> >   hw/misc/allwinner-h3-sid.c         | 179 ++++++++++++++++++++++++++++=
+
> >   hw/misc/Makefile.objs              |   1 +
> >   hw/misc/trace-events               |   4 +
> >   7 files changed, 237 insertions(+)
> >   create mode 100644 include/hw/misc/allwinner-h3-sid.h
> >   create mode 100644 hw/misc/allwinner-h3-sid.c
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index 8128ae6131..c98c1972a6 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -29,6 +29,7 @@
> >   #include "hw/misc/allwinner-h3-clk.h"
> >   #include "hw/misc/allwinner-h3-cpucfg.h"
> >   #include "hw/misc/allwinner-h3-syscon.h"
> > +#include "hw/misc/allwinner-h3-sid.h"
> >   #include "target/arm/cpu.h"
> >
> >   enum {
> > @@ -77,6 +78,7 @@ typedef struct AwH3State {
> >       AwH3ClockState ccu;
> >       AwH3CpuCfgState cpucfg;
> >       AwH3SysconState syscon;
> > +    AwH3SidState sid;
> >       GICState gic;
> >       MemoryRegion sram_a1;
> >       MemoryRegion sram_a2;
> > diff --git a/include/hw/misc/allwinner-h3-sid.h
> b/include/hw/misc/allwinner-h3-sid.h
> > new file mode 100644
> > index 0000000000..79c9a24459
> > --- /dev/null
> > +++ b/include/hw/misc/allwinner-h3-sid.h
> > @@ -0,0 +1,40 @@
> > +/*
> > + * Allwinner H3 Security ID emulation
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
> > +#ifndef HW_MISC_ALLWINNER_H3_SID_H
> > +#define HW_MISC_ALLWINNER_H3_SID_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "qemu/uuid.h"
> > +
> > +#define TYPE_AW_H3_SID    "allwinner-h3-sid"
> > +#define AW_H3_SID(obj)    OBJECT_CHECK(AwH3SidState, (obj),
> TYPE_AW_H3_SID)
> > +
> > +typedef struct AwH3SidState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +    /*< public >*/
> > +
> > +    MemoryRegion iomem;
> > +    uint32_t control;
> > +    uint32_t rdkey;
> > +    QemuUUID identifier;
> > +} AwH3SidState;
> > +
> > +#endif
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index 1a9748ab2e..ba34f905cd 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -196,6 +196,9 @@ static void aw_h3_init(Object *obj)
> >
> >       sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg=
),
> >                             TYPE_AW_H3_CPUCFG);
> > +
> > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> > +                          TYPE_AW_H3_SID);
>
> Here add a property alias:
>
>         object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
>                                   "identifier", &error_abort);
>
> >   }
> >
> >   static void aw_h3_realize(DeviceState *dev, Error **errp)
> > @@ -332,6 +335,10 @@ static void aw_h3_realize(DeviceState *dev, Error
> **errp)
> >       qdev_init_nofail(DEVICE(&s->cpucfg));
> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_CPUCFG]);
> >
> > +    /* Security Identifier */
> > +    qdev_init_nofail(DEVICE(&s->sid));
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
> > +
> >       /* Universal Serial Bus */
> >       sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> >                            qdev_get_gpio_in(DEVICE(&s->gic),
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index 62cefc8c06..b01c4b4f01 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -62,6 +62,10 @@ static void orangepi_init(MachineState *machine)
> >           exit(1);
> >       }
> >
> > +    /* Setup SID properties */
> > +    qdev_prop_set_string(DEVICE(&s->h3->sid), "identifier",
> > +                         "8100c002-0001-0002-0003-000044556677");
>
> And here use the alias:
>
>         qdev_prop_set_string(DEVICE(&s->h3), "identifier",
>                              "8100c002-0001-0002-0003-000044556677");
>

Ah OK, I see what you mean. The boards should be using the SoC object only
and
not directly any of its sub devices, correct?



>
> What means this value? Don't you want to be able to set it from command
> line?
>
The first word 0x02c00081 is the identifying word for the H3 SoC in the SID
data.
After that come the per-device unique specific bytes. This is documented at
the end of this page in 'Currently known SID's' on the linux-sunxi.org Wiki=
:
  https://linux-sunxi.org/SID_Register_Guide

The remaining parts of this value I simply made up without any real meaning=
.
And yes, it would in fact make sense to have the user be able to override
it from the command line.
It is used by U-boot as an input for generating the MAC address. Linux also
reads it, but I did not investigate
how it us used there. I think I did make a TODO of using a cmdline
argument, but later forgot to actually implement it.

Do you have a suggestion how to best provide the command line argument? I
do see '-device driver[,prop=3Dvalue]'
is there in the --help for qemu-system-arm, but it looks like that should
be used by the user for adding PCI / USB devices?


> >       /* Mark H3 object realized */
> >       object_property_set_bool(OBJECT(s->h3), true, "realized",
> &error_abort);
> >       if (error_abort !=3D NULL) {
> > diff --git a/hw/misc/allwinner-h3-sid.c b/hw/misc/allwinner-h3-sid.c
> > new file mode 100644
> > index 0000000000..c472f2bcc6
> > --- /dev/null
> > +++ b/hw/misc/allwinner-h3-sid.c
> > @@ -0,0 +1,179 @@
> > +/*
> > + * Allwinner H3 Security ID emulation
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
> > +#include "qemu/units.h"
> > +#include "hw/sysbus.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/guest-random.h"
> > +#include "qapi/error.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/misc/allwinner-h3-sid.h"
> > +#include "trace.h"
> > +
> > +/* SID register offsets */
> > +enum {
> > +    REG_PRCTL =3D 0x40,   /* Control */
> > +    REG_RDKEY =3D 0x60,   /* Read Key */
> > +};
> > +
> > +/* SID register flags */
> > +enum {
> > +    REG_PRCTL_WRITE   =3D 0x0002, /* Unknown write flag */
> > +    REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
> > +};
> > +
> > +static uint64_t allwinner_h3_sid_read(void *opaque, hwaddr offset,
> > +                                      unsigned size)
> > +{
> > +    const AwH3SidState *s =3D (AwH3SidState *)opaque;
> > +    uint64_t val =3D 0;
> > +
> > +    switch (offset) {
> > +    case REG_PRCTL:    /* Control */
> > +        val =3D s->control;
> > +        break;
> > +    case REG_RDKEY:    /* Read Key */
> > +        val =3D s->rdkey;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        return 0;
> > +    }
> > +
> > +    trace_allwinner_h3_sid_read(offset, val, size);
> > +
> > +    return val;
> > +}
> > +
> > +static void allwinner_h3_sid_write(void *opaque, hwaddr offset,
> > +                                   uint64_t val, unsigned size)
> > +{
> > +    AwH3SidState *s =3D (AwH3SidState *)opaque;
> > +
> > +    trace_allwinner_h3_sid_write(offset, val, size);
> > +
> > +    switch (offset) {
> > +    case REG_PRCTL:    /* Control */
> > +        s->control =3D val;
> > +
> > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
> > +            (s->control & REG_PRCTL_WRITE)) {
> > +            uint32_t id =3D s->control >> 16;
> > +
> > +            if (id < sizeof(QemuUUID)) {
> > +                s->rdkey =3D (s->identifier.data[id]) |
> > +                           (s->identifier.data[id + 1] << 8) |
> > +                           (s->identifier.data[id + 2] << 16) |
> > +                           (s->identifier.data[id + 3] << 24);
>
> This is:
>
>                     s->rdkey =3D ldl_le_p(&s->identifier.data[id]);
>
> > +            }
> > +        }
> > +        s->control &=3D ~REG_PRCTL_WRITE;
> > +        break;
> > +    case REG_RDKEY:    /* Read Key */
>
> Read in a write()?
>
> Maybe we can simply /* fall through */ LOG_GUEST_ERROR?
>

When writing this module, I looked at how U-Boot is using the SID registers
and simply
named the registers after the names used by U-Boot. You can find this part
in arch/arm/mach-sunxi/cpu_info.c:111,
functions sun8i_efuse_read() and sunxi_get_sid(). U-Boot defines
SIDC_RDKEY, so I named the register also rdkey.
I used the U-Boot source because the Allwinner H3 datasheet does not
document the registers. Later I
found the SID page on the linux-sunxi wiki that I mentioned earlier, and
they also describe the same register names:

   https://linux-sunxi.org/SID_Register_Guide

I suspect the information on this page is written based on the source code
from the original SDK (which I did not study btw)


>
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n"=
,
> > +                      __func__, (uint32_t)offset);
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps allwinner_h3_sid_ops =3D {
> > +    .read =3D allwinner_h3_sid_read,
> > +    .write =3D allwinner_h3_sid_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +        .unaligned =3D false
>
> 'false' is the default value, maybe we can omit it?
>

Sure, I'll remove it.


>
> > +    },
> > +    .impl.min_access_size =3D 4,
> > +};
> > +
> > +static void allwinner_h3_sid_reset(DeviceState *dev)
> > +{
> > +    AwH3SidState *s =3D AW_H3_SID(dev);
> > +
> > +    /* Set default values for registers */
> > +    s->control =3D 0;
> > +    s->rdkey =3D 0;
> > +}
> > +
> > +static void allwinner_h3_sid_realize(DeviceState *dev, Error **errp)
> > +{
> > +}
>
> If you don't need realize(), just remove it. However maybe we want to
> check if the identifier is null, either warn/abort or generate a random
> one?
>
OK, removing it!


>
> > +
> > +static void allwinner_h3_sid_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AwH3SidState *s =3D AW_H3_SID(obj);
> > +
> > +    /* Fill UUID with zeroes by default */
> > +    qemu_uuid_parse(UUID_NONE, &s->identifier);
>
> AwH3SidState is zeroed just before this init() call. I think we don't
> need to zeroes the UUID again.
>

Ah OK, so you mean new objects are always zeroed. That makes it
much easier indeed. Thanks, I'll remove those lines.


>
> > +
> > +    /* Memory mapping */
> > +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_sid_ops,
> s,
> > +                          TYPE_AW_H3_SID, 1 * KiB);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +}
> > +
> > +static Property allwinner_h3_sid_properties[] =3D {
> > +    DEFINE_PROP_UUID_NODEFAULT("identifier", AwH3SidState, identifier)=
,
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static const VMStateDescription allwinner_h3_sid_vmstate =3D {
> > +    .name =3D "allwinner-h3-sid",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(control, AwH3SidState),
> > +        VMSTATE_UINT32(rdkey, AwH3SidState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void allwinner_h3_sid_class_init(ObjectClass *klass, void *data=
)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D allwinner_h3_sid_reset;
> > +    dc->realize =3D allwinner_h3_sid_realize;
> > +    dc->vmsd =3D &allwinner_h3_sid_vmstate;
> > +    dc->props =3D allwinner_h3_sid_properties;
> > +}
> > +
> > +static const TypeInfo allwinner_h3_sid_info =3D {
> > +    .name          =3D TYPE_AW_H3_SID,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D allwinner_h3_sid_init,
> > +    .instance_size =3D sizeof(AwH3SidState),
> > +    .class_init    =3D allwinner_h3_sid_class_init,
> > +};
> > +
> > +static void allwinner_h3_sid_register(void)
> > +{
> > +    type_register_static(&allwinner_h3_sid_info);
> > +}
> > +
> > +type_init(allwinner_h3_sid_register)
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index c4ca2ed689..f3620eee4e 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
> >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-clk.o
> >   obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-cpucfg.o
> >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-syscon.o
> > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sid.o
> >   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
> >   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
> >   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index b93089d010..a777844ca3 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -5,6 +5,10 @@ allwinner_h3_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t
> reset_addr) "H3-CPUCFG: c
> >   allwinner_h3_cpucfg_read(uint64_t offset, uint64_t data, unsigned
> size) "H3-CPUCFG: read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %"
> PRIu32
> >   allwinner_h3_cpucfg_write(uint64_t offset, uint64_t data, unsigned
> size) "H3-CPUCFG: write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %"
> PRIu32
> >
> > +# allwinner-h3-sid.c
> > +allwinner_h3_sid_read(uint64_t offset, uint64_t data, unsigned size)
> "H3-SID: read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > +allwinner_h3_sid_write(uint64_t offset, uint64_t data, unsigned size)
> "H3-SID: write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > +
> >   # eccmemctl.c
> >   ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
> >   ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
> >
>
>
Regards,
Niek

--=20
Niek Linnenbank

--000000000000a170b4059a0094dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 17, 2019 at 8:45 AM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Niek,<br>
<br>
On 12/17/19 12:35 AM, Niek Linnenbank wrote:<br>
&gt; The Security Identifier device in Allwinner H3 System on Chip<br>
&gt; gives applications a per-board unique identifier. This commit<br>
&gt; adds support for the Allwinner H3 Security Identifier using<br>
&gt; a 128-bit UUID value as input.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-h3-sid.h |=C2=A0 40 +++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 ++<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-h3-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 179 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A07 files changed, 237 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-h3-sid.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-h3-sid.c<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index 8128ae6131..c98c1972a6 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -29,6 +29,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-clk.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-cpucfg.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-syscon.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-h3-sid.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0enum {<br>
&gt; @@ -77,6 +78,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockState ccu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3CpuCfgState cpucfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysconState syscon;<br>
&gt; +=C2=A0 =C2=A0 AwH3SidState sid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/misc/allwinner-h3-sid.h b/include/hw/misc/allw=
inner-h3-sid.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..79c9a24459<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/misc/allwinner-h3-sid.h<br>
&gt; @@ -0,0 +1,40 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 Security ID emulation<br>
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
&gt; +#ifndef HW_MISC_ALLWINNER_H3_SID_H<br>
&gt; +#define HW_MISC_ALLWINNER_H3_SID_H<br>
&gt; +<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_AW_H3_SID=C2=A0 =C2=A0 &quot;allwinner-h3-sid&quot;<br>
&gt; +#define AW_H3_SID(obj)=C2=A0 =C2=A0 OBJECT_CHECK(AwH3SidState, (obj),=
 TYPE_AW_H3_SID)<br>
&gt; +<br>
&gt; +typedef struct AwH3SidState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +=C2=A0 =C2=A0 uint32_t control;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rdkey;<br>
&gt; +=C2=A0 =C2=A0 QemuUUID identifier;<br>
&gt; +} AwH3SidState;<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index 1a9748ab2e..ba34f905cd 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -196,6 +196,9 @@ static void aw_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;cpucfg&quot=
;, &amp;s-&gt;cpucfg, sizeof(s-&gt;cpucfg),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_CPUCFG);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;sid&quot;, &amp;s-&gt;=
sid, sizeof(s-&gt;sid),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SID);<br>
<br>
Here add a property alias:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_alias(obj, &quot;identifier=
&quot;, OBJECT(&amp;s-&gt;sid),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;identifier&quot;, &amp;=
error_abort);<br>
<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void aw_h3_realize(DeviceState *dev, Error **errp)<=
br>
&gt; @@ -332,6 +335,10 @@ static void aw_h3_realize(DeviceState *dev, Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DEVICE(&amp;s-&gt;cpucfg));=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cp=
ucfg), 0, s-&gt;memmap[AW_H3_CPUCFG]);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Security Identifier */<br>
&gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;sid));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&g=
t;memmap[AW_H3_SID]);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;=
memmap[AW_H3_EHCI0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; index 62cefc8c06..b01c4b4f01 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -62,6 +62,10 @@ static void orangepi_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Setup SID properties */<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&amp;s-&gt;h3-&gt;sid), &qu=
ot;identifier&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-0003-000044556677&quot;);<br>
<br>
And here use the alias:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&amp;s-&gt;h3), &qu=
ot;identifier&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-0003-000044556677&q=
uot;);<br></blockquote><div><br></div><div>Ah OK, I see what you mean. The =
boards should be using the SoC object only and</div><div>not directly any o=
f its sub devices, correct?<br></div><div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
What means this value? Don&#39;t you want to be able to set it from command=
 <br>
line?<br></blockquote><div>The first word 0x02c00081 is the identifying wor=
d for the H3 SoC in the SID data.</div><div>After that come the per-device =
unique specific bytes. This is documented at the end of this page in &#39;C=
urrently known SID&#39;s&#39; on the <a href=3D"http://linux-sunxi.org">lin=
ux-sunxi.org</a> Wiki:</div><div>=C2=A0 <a href=3D"https://linux-sunxi.org/=
SID_Register_Guide">https://linux-sunxi.org/SID_Register_Guide</a></div><di=
v><br></div><div>The remaining parts of this value I simply made up without=
 any real meaning.</div><div>And yes, it would in fact make sense to have t=
he user be able to override it from the command line.</div><div>It is used =
by U-boot as an input for generating the MAC address. Linux also reads it, =
but I did not investigate</div><div>how it us used there. I think I did mak=
e a TODO of using a cmdline argument, but later forgot to actually implemen=
t it.</div><div><br></div><div>Do you have a suggestion how to best provide=
 the command line argument? I do see &#39;-device driver[,prop=3Dvalue]&#39=
;</div><div>is there in the --help for qemu-system-arm, but it looks like t=
hat should be used by the user for adding PCI / USB devices?<br></div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object realized */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(s-&gt;h3), t=
rue, &quot;realized&quot;, &amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error_abort !=3D NULL) {<br>
&gt; diff --git a/hw/misc/allwinner-h3-sid.c b/hw/misc/allwinner-h3-sid.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..c472f2bcc6<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/allwinner-h3-sid.c<br>
&gt; @@ -0,0 +1,179 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 Security ID emulation<br>
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
&gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-h3-sid.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +<br>
&gt; +/* SID register offsets */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_PRCTL =3D 0x40,=C2=A0 =C2=A0/* Control */<br>
&gt; +=C2=A0 =C2=A0 REG_RDKEY =3D 0x60,=C2=A0 =C2=A0/* Read Key */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* SID register flags */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_PRCTL_WRITE=C2=A0 =C2=A0=3D 0x0002, /* Unknown writ=
e flag */<br>
&gt; +=C2=A0 =C2=A0 REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */<br>
&gt; +};<br>
&gt; +<br>
&gt; +static uint64_t allwinner_h3_sid_read(void *opaque, hwaddr offset,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned si=
ze)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const AwH3SidState *s =3D (AwH3SidState *)opaque;<br>
&gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;control;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;rdkey;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
bad read offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_h3_sid_read(offset, val, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_sid_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3SidState *s =3D (AwH3SidState *)opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_h3_sid_write(offset, val, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control =3D val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;control &amp; REG_PRCTL_OP_LOC=
K) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;control &amp; REG_PR=
CTL_WRITE)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t id =3D s-&gt;contr=
ol &gt;&gt; 16;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id &lt; sizeof(QemuUUID=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rdkey =
=3D (s-&gt;identifier.data[id]) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 1] &lt;&lt; 8) |<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 2] &lt;&lt; 16) |<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 3] &lt;&lt; 24);<br=
>
<br>
This is:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt=
;rdkey =3D ldl_le_p(&amp;s-&gt;identifier.data[id]);<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control &amp;=3D ~REG_PRCTL_WRITE;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */<br>
<br>
Read in a write()?<br>
<br>
Maybe we can simply /* fall through */ LOG_GUEST_ERROR?<br></blockquote><di=
v><br></div><div>When writing this module, I looked at how U-Boot is using =
the SID registers and simply</div><div>named the registers after the names =
used by U-Boot. You can find this part in arch/arm/mach-sunxi/cpu_info.c:11=
1,</div><div>functions sun8i_efuse_read() and sunxi_get_sid(). U-Boot defin=
es SIDC_RDKEY, so I named the register also rdkey.</div><div> I used the U-=
Boot source because the Allwinner H3 datasheet does not document the regist=
ers. Later I</div><div>found the SID page on the linux-sunxi wiki that I me=
ntioned earlier, and they also describe the same register names:<br></div><=
div><br></div><div>=C2=A0=C2=A0 <a href=3D"https://linux-sunxi.org/SID_Regi=
ster_Guide">https://linux-sunxi.org/SID_Register_Guide</a></div><div><br></=
div><div>I suspect the information on this page is written based on the sou=
rce code from the original SDK (which I did not study btw)<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
bad write offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_h3_sid_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_h3_sid_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_h3_sid_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D false<br>
<br>
&#39;false&#39; is the default value, maybe we can omit it?<br></blockquote=
><div><br></div><div>Sure, I&#39;ll remove it.<br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_sid_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3SidState *s =3D AW_H3_SID(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set default values for registers */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;control =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rdkey =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_h3_sid_realize(DeviceState *dev, Error **errp)<=
br>
&gt; +{<br>
&gt; +}<br>
<br>
If you don&#39;t need realize(), just remove it. However maybe we want to <=
br>
check if the identifier is null, either warn/abort or generate a random one=
?<br></blockquote><div>OK, removing it!<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +static void allwinner_h3_sid_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwH3SidState *s =3D AW_H3_SID(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Fill UUID with zeroes by default */<br>
&gt; +=C2=A0 =C2=A0 qemu_uuid_parse(UUID_NONE, &amp;s-&gt;identifier);<br>
<br>
AwH3SidState is zeroed just before this init() call. I think we don&#39;t <=
br>
need to zeroes the UUID again.<br></blockquote><div><br></div><div>Ah OK, s=
o you mean new objects are always zeroed. That makes it</div><div>much easi=
er indeed. Thanks, I&#39;ll remove those lines.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;allwinner_h3_sid_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_SID, 1 * KiB);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property allwinner_h3_sid_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UUID_NODEFAULT(&quot;identifier&quot;, AwH3=
SidState, identifier),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_h3_sid_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-h3-sid&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(control, AwH3SidState),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rdkey, AwH3SidState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_sid_class_init(ObjectClass *klass, void *dat=
a)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_h3_sid_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D allwinner_h3_sid_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_h3_sid_vmstate;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;props =3D allwinner_h3_sid_properties;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_h3_sid_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_=
SID,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_h3_sid_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3SidState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_h3_sid_class_ini=
t,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_h3_sid_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_h3_sid_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_h3_sid_register)<br>
&gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
&gt; index c4ca2ed689..f3620eee4e 100644<br>
&gt; --- a/hw/misc/Makefile.objs<br>
&gt; +++ b/hw/misc/Makefile.objs<br>
&gt; @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o<b=
r>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-clk.o<=
br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-cpucfg.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-syscon=
.o<br>
&gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sid.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o<br>
&gt; diff --git a/hw/misc/trace-events b/hw/misc/trace-events<br>
&gt; index b93089d010..a777844ca3 100644<br>
&gt; --- a/hw/misc/trace-events<br>
&gt; +++ b/hw/misc/trace-events<br>
&gt; @@ -5,6 +5,10 @@ allwinner_h3_cpucfg_cpu_reset(uint8_t cpu_id, uint32_=
t reset_addr) &quot;H3-CPUCFG: c<br>
&gt;=C2=A0 =C2=A0allwinner_h3_cpucfg_read(uint64_t offset, uint64_t data, u=
nsigned size) &quot;H3-CPUCFG: read: offset 0x%&quot; PRIx64 &quot; data 0x=
%&quot; PRIx64 &quot; size %&quot; PRIu32<br>
&gt;=C2=A0 =C2=A0allwinner_h3_cpucfg_write(uint64_t offset, uint64_t data, =
unsigned size) &quot;H3-CPUCFG: write: offset 0x%&quot; PRIx64 &quot; data =
0x%&quot; PRIx64 &quot; size %&quot; PRIu32<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# allwinner-h3-sid.c<br>
&gt; +allwinner_h3_sid_read(uint64_t offset, uint64_t data, unsigned size) =
&quot;H3-SID: read: offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &q=
uot; size %&quot; PRIu32<br>
&gt; +allwinner_h3_sid_write(uint64_t offset, uint64_t data, unsigned size)=
 &quot;H3-SID: write: offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 =
&quot; size %&quot; PRIu32<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0# eccmemctl.c<br>
&gt;=C2=A0 =C2=A0ecc_mem_writel_mer(uint32_t val) &quot;Write memory enable=
 0x%08x&quot;<br>
&gt;=C2=A0 =C2=A0ecc_mem_writel_mdr(uint32_t val) &quot;Write memory delay =
0x%08x&quot;<br>
&gt; <br>
<br>
</blockquote></div><div><br></div><div>Regards,</div><div>Niek<br></div><br=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Ni=
ek Linnenbank<br><br></div></div></div></div>

--000000000000a170b4059a0094dc--

