Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254AC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 20:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF38206D3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 20:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt5EAKtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF38206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyMAJ-0003Jj-Sx
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 15:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyM9f-0002l3-Oe
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 15:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyM9c-0004Xh-FD
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 15:47:43 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iyM9c-0004WQ-2B; Sun, 02 Feb 2020 15:47:40 -0500
Received: by mail-io1-xd43.google.com with SMTP id k24so14445462ioc.4;
 Sun, 02 Feb 2020 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ohC8Bdc+TsTTgBiiKMC9C50ISFWVPgXdwzCNXKGxrI=;
 b=Wt5EAKtSQmD14dm/NzQj/jKZiz7kedJXRCZYNJct4N75q9Bsg4QrnfzPOFA9MXyZqw
 i2p0LdtYnadjjHFoG5THGnhKL9iY7DE34wpjkoqphvgnl3Lq0geZ0RKAtK8d2C0d4aKj
 amPSRcXSi75Lwmm1GrNeG4EW/Pz16+QUo9DRTW+jmPwtZzddstzlYvisi3aalNwz5Kiy
 ssZ1XTK8jQvjIf2FLGubmYvn899/nMTVB9bAAJ5UYOpqu5+T15GZ/T107khq0RXGFB2q
 GX8lFkbSWCVVdGRrcsBk4lWv4RkFWXONA60dduktfmSwGU1PDu/lnVTxpdS0nedWnpSH
 5PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ohC8Bdc+TsTTgBiiKMC9C50ISFWVPgXdwzCNXKGxrI=;
 b=UGT1R5m99WIZqKOgZywxj+b9su/cYVO47eY9NqIi3MYJ1t36XPKXvXyYxCLAFBlANm
 GWBE7e1YUZAfLjH+Oh0N17HOJXsC9KaA5Wv4yXlRv9CkecjEmmuocqeVJaupjvbneG/w
 uwZZ4LjfwRghaAl0EcSqjqYrQevAivL9BdRfYZ2sUmE5+0e23As4Kb6PSS/bU7whsXPI
 LzCTmaOij291NFYPMdZ7J3SKC99/r5zH4Nhi+T5vqS2E0PNajEaNj1jiM6f905CJRPXq
 gQcfB7Mg8eQYHrzoOrUKm6aAFoaxIUuvyWHCln1s1Iu0EOJ7sP7ICXeA+ZcHN0+WzqXy
 zK7A==
X-Gm-Message-State: APjAAAX7aJu0Nv/nCKpCjCLSXm/J3AwM83iWGtRRRnnQuJwpEbP0QWFM
 dJhs0ER7PEGMGhV30qv2RYY9VODiXY/aFg9BQL4=
X-Google-Smtp-Source: APXvYqxSPOvi6f8/ZEzD8sgrunsKQE8i2ebVpNqJX+5rQNPPjsYTsm7NdJ5lyebUJVBaGSmDvlUUBZeUCxA/8NUjm9w=
X-Received: by 2002:a6b:7902:: with SMTP id i2mr15691027iop.67.1580676459131; 
 Sun, 02 Feb 2020 12:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-8-nieklinnenbank@gmail.com>
 <0e46df1c-d140-23f0-6dbc-c7eb233010e5@redhat.com>
In-Reply-To: <0e46df1c-d140-23f0-6dbc-c7eb233010e5@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 2 Feb 2020 21:47:28 +0100
Message-ID: <CAPan3Wr2otKWNOX2qa5UEQ1hVSMLb9SdPopvr=xCf-Du9P29uw@mail.gmail.com>
Subject: Re: [PATCH v4 07/20] hw/arm/allwinner: add Security Identifier device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d9f710059d9deac2"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 imammedo@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d9f710059d9deac2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2020 at 7:57 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> > The Security Identifier device found in various Allwinner System on Chi=
p
> > designs gives applications a per-board unique identifier. This commit
> > adds support for the Allwinner Security Identifier using a 128-bit
> > UUID value as input.
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   include/hw/arm/allwinner-h3.h   |   3 +
> >   include/hw/misc/allwinner-sid.h |  60 +++++++++++
> >   hw/arm/allwinner-h3.c           |  11 ++-
> >   hw/arm/orangepi.c               |   4 +
> >   hw/misc/allwinner-sid.c         | 170 +++++++++++++++++++++++++++++++=
+
> >   hw/misc/Makefile.objs           |   1 +
> >   hw/misc/trace-events            |   4 +
> >   7 files changed, 252 insertions(+), 1 deletion(-)
> >   create mode 100644 include/hw/misc/allwinner-sid.h
> >   create mode 100644 hw/misc/allwinner-sid.c
> >
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index dc729176ab..85416d9d64 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -42,6 +42,7 @@
> >   #include "hw/misc/allwinner-h3-ccu.h"
> >   #include "hw/misc/allwinner-cpucfg.h"
> >   #include "hw/misc/allwinner-h3-sysctrl.h"
> > +#include "hw/misc/allwinner-sid.h"
> >   #include "target/arm/cpu.h"
> >
> >   /**
> > @@ -59,6 +60,7 @@ enum {
> >       AW_H3_SRAM_A2,
> >       AW_H3_SRAM_C,
> >       AW_H3_SYSCTRL,
> > +    AW_H3_SID,
> >       AW_H3_EHCI0,
> >       AW_H3_OHCI0,
> >       AW_H3_EHCI1,
> > @@ -114,6 +116,7 @@ typedef struct AwH3State {
> >       AwH3ClockCtlState ccu;
> >       AwCpuCfgState cpucfg;
> >       AwH3SysCtrlState sysctrl;
> > +    AwSidState sid;
> >       GICState gic;
> >       MemoryRegion sram_a1;
> >       MemoryRegion sram_a2;
> > diff --git a/include/hw/misc/allwinner-sid.h
> b/include/hw/misc/allwinner-sid.h
> > new file mode 100644
> > index 0000000000..4c1fa4762b
> > --- /dev/null
> > +++ b/include/hw/misc/allwinner-sid.h
> > @@ -0,0 +1,60 @@
> > +/*
> > + * Allwinner Security ID emulation
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
> > +#ifndef HW_MISC_ALLWINNER_SID_H
> > +#define HW_MISC_ALLWINNER_SID_H
> > +
> > +#include "qom/object.h"
> > +#include "hw/sysbus.h"
> > +#include "qemu/uuid.h"
> > +
> > +/**
> > + * Object model
> > + * @{
> > + */
> > +
> > +#define TYPE_AW_SID    "allwinner-sid"
> > +#define AW_SID(obj) \
> > +    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
> > +
> > +/** @} */
> > +
> > +/**
> > + * Allwinner Security ID object instance state
> > + */
> > +typedef struct AwSidState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +    /*< public >*/
> > +
> > +    /** Maps I/O registers in physical memory */
> > +    MemoryRegion iomem;
> > +
> > +    /** Control register defines how and what to read */
> > +    uint32_t control;
> > +
> > +    /** RdKey register contains the data retrieved by the device */
> > +    uint32_t rdkey;
> > +
> > +    /** Stores the emulated device identifier */
> > +    QemuUUID identifier;
> > +
> > +} AwSidState;
> > +
> > +#endif /* HW_MISC_ALLWINNER_SID_H */
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index daa2d3c819..919fba6cf6 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
> >       [AW_H3_SRAM_A2]    =3D 0x00044000,
> >       [AW_H3_SRAM_C]     =3D 0x00010000,
> >       [AW_H3_SYSCTRL]    =3D 0x01c00000,
> > +    [AW_H3_SID]        =3D 0x01c14000,
> >       [AW_H3_EHCI0]      =3D 0x01c1a000,
> >       [AW_H3_OHCI0]      =3D 0x01c1a400,
> >       [AW_H3_EHCI1]      =3D 0x01c1b000,
> > @@ -78,7 +79,6 @@ struct AwH3Unimplemented {
> >       { "mmc0",      0x01c0f000, 4 * KiB },
> >       { "mmc1",      0x01c10000, 4 * KiB },
> >       { "mmc2",      0x01c11000, 4 * KiB },
> > -    { "sid",       0x01c14000, 1 * KiB },
> >       { "crypto",    0x01c15000, 4 * KiB },
> >       { "msgbox",    0x01c17000, 4 * KiB },
> >       { "spinlock",  0x01c18000, 4 * KiB },
> > @@ -198,6 +198,11 @@ static void allwinner_h3_init(Object *obj)
> >
> >       sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg=
),
> >                             TYPE_AW_CPUCFG);
> > +
> > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> > +                          TYPE_AW_SID);
> > +    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
> > +                              "identifier", &error_abort);
> >   }
> >
> >   static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> > @@ -315,6 +320,10 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
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
> > index 866f5f7cd6..5b60f35a80 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -61,6 +61,10 @@ static void orangepi_init(MachineState *machine)
> >       object_property_set_int(OBJECT(s->h3), 24 * 1000 * 1000,
> "clk1-freq",
> >                               &error_abort);
> >
> > +    /* Setup SID properties */
> > +    qdev_prop_set_string(DEVICE(s->h3), "identifier",
> > +                         "8100c002-0001-0002-0003-000044556677");
>
> This part misses a comment that we are enforcing the same UUID on all
> VMs (for now).
>

Good idea, I'll add that in a comment.


>
> > +
> >       /* Mark H3 object realized */
> >       object_property_set_bool(OBJECT(s->h3), true, "realized",
> &error_abort);
> >
> > diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
> > new file mode 100644
> > index 0000000000..954de935bc
> > --- /dev/null
> > +++ b/hw/misc/allwinner-sid.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + * Allwinner Security ID emulation
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
> > +#include "hw/misc/allwinner-sid.h"
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
> > +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,
> > +                                   unsigned size)
> > +{
> > +    const AwSidState *s =3D AW_SID(opaque);
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
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        return 0;
> > +    }
> > +
> > +    trace_allwinner_sid_read(offset, val, size);
> > +
> > +    return val;
> > +}
> > +
> > +static void allwinner_sid_write(void *opaque, hwaddr offset,
> > +                                uint64_t val, unsigned size)
> > +{
> > +    AwSidState *s =3D AW_SID(opaque);
> > +
> > +    trace_allwinner_sid_write(offset, val, size);
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
> > +            }
> > +        }
> > +        s->control &=3D ~REG_PRCTL_WRITE;
> > +        break;
> > +    case REG_RDKEY:    /* Read Key */
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                      __func__, (uint32_t)offset);
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps allwinner_sid_ops =3D {
> > +    .read =3D allwinner_sid_read,
> > +    .write =3D allwinner_sid_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +    .impl.min_access_size =3D 4,
> > +};
> > +
> > +static void allwinner_sid_reset(DeviceState *dev)
> > +{
> > +    AwSidState *s =3D AW_SID(dev);
> > +
> > +    /* Set default values for registers */
> > +    s->control =3D 0;
> > +    s->rdkey =3D 0;
> > +}
> > +
> > +static void allwinner_sid_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AwSidState *s =3D AW_SID(obj);
> > +
> > +    /* Memory mapping */
> > +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sid_ops, s,
> > +                           TYPE_AW_SID, 1 * KiB);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +}
> > +
> > +static Property allwinner_sid_properties[] =3D {
> > +    DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier),
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static const VMStateDescription allwinner_sid_vmstate =3D {
> > +    .name =3D "allwinner-sid",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(control, AwSidState),
> > +        VMSTATE_UINT32(rdkey, AwSidState),
>
> We need to migrate the UUID too:
>
>             VMSTATE_UINT8_ARRAY_V(identifier.data, AwSidState,
> sizeof(QemuUUID), 1),
>

Previously in v1 Peter explained that when using a fixed value for the
identifier,
migration should not be needed [1]. On the other hand, having it anyway in
the VMState
shouldn't break anything and also avoids that we forget about it later, so
I'll add it, thanks!

Regards,
Niek

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01203.html



>
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void allwinner_sid_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D allwinner_sid_reset;
> > +    dc->vmsd =3D &allwinner_sid_vmstate;
> > +    dc->props =3D allwinner_sid_properties;
> > +}
> > +
> > +static const TypeInfo allwinner_sid_info =3D {
> > +    .name          =3D TYPE_AW_SID,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D allwinner_sid_init,
> > +    .instance_size =3D sizeof(AwSidState),
> > +    .class_init    =3D allwinner_sid_class_init,
> > +};
> > +
> > +static void allwinner_sid_register(void)
> > +{
> > +    type_register_static(&allwinner_sid_info);
> > +}
> > +
> > +type_init(allwinner_sid_register)
> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > index f3788a5903..daa734036e 100644
> > --- a/hw/misc/Makefile.objs
> > +++ b/hw/misc/Makefile.objs
> > @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o
> >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
> >   obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o
> >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sysctrl.o
> > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o
> >   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
> >   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
> >   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index ede1650672..4f38328d9c 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t
> reset_addr) "id %u, reset_ad
> >   allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> >   allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> >
> > +# allwinner-sid.c
> > +allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > +allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size)
> "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
> > +
> >   # eccmemctl.c
> >   ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
> >   ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
> >
>
>

--=20
Niek Linnenbank

--000000000000d9f710059d9deac2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 7:57 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt; The Security Identifier device found in various Allwinner System on Ch=
ip<br>
&gt; designs gives applications a per-board unique identifier. This commit<=
br>
&gt; adds support for the Allwinner Security Identifier using a 128-bit<br>
&gt; UUID value as input.<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0|=C2=A0 =C2=A03 =
+<br>
&gt;=C2=A0 =C2=A0include/hw/misc/allwinner-sid.h |=C2=A0 60 +++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 11 ++-<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 170 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A07 files changed, 252 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinner-sid.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-sid.c<br>
&gt; <br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index dc729176ab..85416d9d64 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -42,6 +42,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-cpucfg.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-sysctrl.h&quot;<br>
&gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt; @@ -59,6 +60,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_C,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SYSCTRL,<br>
&gt; +=C2=A0 =C2=A0 AW_H3_SID,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_EHCI0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_OHCI0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_EHCI1,<br>
&gt; @@ -114,6 +116,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockCtlState ccu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwCpuCfgState cpucfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysCtrlState sysctrl;<br>
&gt; +=C2=A0 =C2=A0 AwSidState sid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/allwinn=
er-sid.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..4c1fa4762b<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/misc/allwinner-sid.h<br>
&gt; @@ -0,0 +1,60 @@<br>
&gt; +/*<br>
&gt; + * Allwinner Security ID emulation<br>
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
&gt; +#ifndef HW_MISC_ALLWINNER_SID_H<br>
&gt; +#define HW_MISC_ALLWINNER_SID_H<br>
&gt; +<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Object model<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define TYPE_AW_SID=C2=A0 =C2=A0 &quot;allwinner-sid&quot;<br>
&gt; +#define AW_SID(obj) \<br>
&gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner Security ID object instance state<br>
&gt; + */<br>
&gt; +typedef struct AwSidState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Control register defines how and what to read */<br=
>
&gt; +=C2=A0 =C2=A0 uint32_t control;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** RdKey register contains the data retrieved by the d=
evice */<br>
&gt; +=C2=A0 =C2=A0 uint32_t rdkey;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Stores the emulated device identifier */<br>
&gt; +=C2=A0 =C2=A0 QemuUUID identifier;<br>
&gt; +<br>
&gt; +} AwSidState;<br>
&gt; +<br>
&gt; +#endif /* HW_MISC_ALLWINNER_SID_H */<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index daa2d3c819..919fba6cf6 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x0001=
0000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c00000,=
<br>
&gt; +=C2=A0 =C2=A0 [AW_H3_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c14000,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1=
a000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1=
a400,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1=
b000,<br>
&gt; @@ -78,7 +79,6 @@ struct AwH3Unimplemented {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc0&quot;,=C2=A0 =C2=A0 =C2=A0 0x01=
c0f000, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc1&quot;,=C2=A0 =C2=A0 =C2=A0 0x01=
c10000, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01=
c11000, 4 * KiB },<br>
&gt; -=C2=A0 =C2=A0 { &quot;sid&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c14000=
, 1 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;crypto&quot;,=C2=A0 =C2=A0 0x01c1500=
0, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;msgbox&quot;,=C2=A0 =C2=A0 0x01c1700=
0, 4 * KiB },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;spinlock&quot;,=C2=A0 0x01c18000, 4 =
* KiB },<br>
&gt; @@ -198,6 +198,11 @@ static void allwinner_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;cpucfg&quot=
;, &amp;s-&gt;cpucfg, sizeof(s-&gt;cpucfg),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_CPUCFG);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;sid&quot;, &amp;s-&gt;=
sid, sizeof(s-&gt;sid),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_SID);<br>
&gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;identifier&quot;, =
OBJECT(&amp;s-&gt;sid),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;identifier&quot;, &amp;error_abor=
t);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void allwinner_h3_realize(DeviceState *dev, Error *=
*errp)<br>
&gt; @@ -315,6 +320,10 @@ static void allwinner_h3_realize(DeviceState *dev=
, Error **errp)<br>
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
&gt; index 866f5f7cd6..5b60f35a80 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -61,6 +61,10 @@ static void orangepi_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(s-&gt;h3), 24=
 * 1000 * 1000, &quot;clk1-freq&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Setup SID properties */<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(s-&gt;h3), &quot;identifier=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-0003-000044556677&quot;);<br>
<br>
This part misses a comment that we are enforcing the same UUID on all <br>
VMs (for now).<br></blockquote><div><br></div><div>Good idea, I&#39;ll add =
that in a comment.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object realized */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(s-&gt;h3), t=
rue, &quot;realized&quot;, &amp;error_abort);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..954de935bc<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/allwinner-sid.c<br>
&gt; @@ -0,0 +1,170 @@<br>
&gt; +/*<br>
&gt; + * Allwinner Security ID emulation<br>
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
&gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
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
&gt; +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const AwSidState *s =3D AW_SID(opaque);<br>
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
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_sid_read(offset, val, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_sid_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(opaque);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_sid_write(offset, val, size);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control &amp;=3D ~REG_PRCTL_WRITE;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_sid_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_sid_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_sid_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_sid_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set default values for registers */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;control =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rdkey =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_sid_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;allwinner_sid_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_SID, 1 * KiB);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property allwinner_sid_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UUID_NODEFAULT(&quot;identifier&quot;, AwSi=
dState, identifier),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_sid_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-sid&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(control, AwSidState),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rdkey, AwSidState),<br>
<br>
We need to migrate the UUID too:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY_V(identifier.=
data, AwSidState, <br>
sizeof(QemuUUID), 1),<br></blockquote><div><br></div><div>Previously in v1 =
Peter explained that when using a fixed value for the identifier,</div><div=
>migration should not be needed [1]. On the other hand, having it anyway in=
 the VMState</div><div>shouldn&#39;t break anything and also avoids that we=
 forget about it later, so I&#39;ll add it, thanks!<br></div><div><br></div=
><div>Regards,</div><div>Niek<br></div><div><br></div><div>[1] <a href=3D"h=
ttps://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01203.html">https:/=
/lists.gnu.org/archive/html/qemu-devel/2019-12/msg01203.html</a></div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_sid_class_init(ObjectClass *klass, void *data)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_sid_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_sid_vmstate;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;props =3D allwinner_sid_properties;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_sid_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SID=
,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_sid_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwSidState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_sid_class_init,<=
br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_sid_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_sid_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_sid_register)<br>
&gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
&gt; index f3788a5903..daa734036e 100644<br>
&gt; --- a/hw/misc/Makefile.objs<br>
&gt; +++ b/hw/misc/Makefile.objs<br>
&gt; @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o<b=
r>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o<=
br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sysctr=
l.o<br>
&gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o<br>
&gt; diff --git a/hw/misc/trace-events b/hw/misc/trace-events<br>
&gt; index ede1650672..4f38328d9c 100644<br>
&gt; --- a/hw/misc/trace-events<br>
&gt; +++ b/hw/misc/trace-events<br>
&gt; @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t r=
eset_addr) &quot;id %u, reset_ad<br>
&gt;=C2=A0 =C2=A0allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsi=
gned size) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot=
; size %&quot; PRIu32<br>
&gt;=C2=A0 =C2=A0allwinner_cpucfg_write(uint64_t offset, uint64_t data, uns=
igned size) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quo=
t; size %&quot; PRIu32<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# allwinner-sid.c<br>
&gt; +allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) &qu=
ot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %&quot;=
 PRIu32<br>
&gt; +allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) &q=
uot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot; size %&quot=
; PRIu32<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0# eccmemctl.c<br>
&gt;=C2=A0 =C2=A0ecc_mem_writel_mer(uint32_t val) &quot;Write memory enable=
 0x%08x&quot;<br>
&gt;=C2=A0 =C2=A0ecc_mem_writel_mdr(uint32_t val) &quot;Write memory delay =
0x%08x&quot;<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000d9f710059d9deac2--

