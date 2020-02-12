Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F6C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F66C2465D
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8Q0O0o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F66C2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1zcw-0002cW-Dx
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 16:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j1zbq-0001lC-Rm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j1zbm-0004cd-8b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:31:50 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:46268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j1zbl-0004cA-U5; Wed, 12 Feb 2020 16:31:46 -0500
Received: by mail-il1-x143.google.com with SMTP id t17so3049574ilm.13;
 Wed, 12 Feb 2020 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kLf3Lffm6n1YHTyZdxXqlVH//+pJY01Wz2C7lCO1hD0=;
 b=o8Q0O0o/eaP+vtsArJI9k1F7UaEG9ISNYT6jjjyjP35mGoaTfpptcz0poVd3V9H8y+
 /5JSEcrseaquh4WvUaS7CPsFFGpMn4BrkWrp6hYopUYsxvn11NcA/oDqHJJTzYigtLCN
 cQzHnGp+DEpip2s6l6XesTZHhqiQ+JfDXbKqrKyrlJYoKOj5ilhpralT49UnszLkGLH3
 rvC1s7gCaRo++f/Q7E44nIVRZsvvmWSi1jGJUlaHcUsf60xaqv6N4KTMcU5oijdDPSJN
 AsWeA/ZxGeuGvI7i04aaBPpUsddq4rYjQtQf10wS1UwTI1ocOv1qxC40ZT9aTVhz+6ZN
 3ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kLf3Lffm6n1YHTyZdxXqlVH//+pJY01Wz2C7lCO1hD0=;
 b=QJAuDC9WEItYjWF8CXhYZ6EtkhrOEyVaMa7H94UJXVg7UIXxESxlA0bV6SVasi9fsA
 G2tG1JTM87cJ9ZJHHD1UAB3b+tq4A90xeblZTWZiC6JpZQHzJSxu2oUBOwtMNCG1VUIE
 PXKdVz+y6t25wa5+nd5J/aXWxn9Zdd1zVTKXSlqq93qB/BkquS7BVfg9u9r6PFPSabiu
 7qGbi95fCHz8No+sc0yUMFmKiqSWS0W7acwz2V7x04NY+NZNMw4J5Z4MBw0cjj8Jqork
 i1aIaRD71/iqJ9E9ZtX3mroyrpbTX9ybDalzaR/i4OFW84cgKEOwthEbbPB4IFzYzsaO
 OT1Q==
X-Gm-Message-State: APjAAAXrLIrkxRtsf1CWIKHgrCq3S8XLbEU7L30uY6IdWXDgEXfu/Wlq
 U3QX1JVkgh2iUbd7AUeFhpZhI8H89gT+OkoZza8=
X-Google-Smtp-Source: APXvYqwSngjSCxldq5G9DymMMx+x8/xMHzTvLW6dPhtvmfibyNG6zlFNpJ0oNPmPI/k6rpWe1EPRUXqzpTtq9Bx7NPc=
X-Received: by 2002:a92:88dc:: with SMTP id m89mr13406175ilh.265.1581543104579; 
 Wed, 12 Feb 2020 13:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-8-nieklinnenbank@gmail.com>
 <8be03fbb-74f2-e688-76b1-ab504f25f8e4@redhat.com>
 <20200120175918.GA2949@minyard.net>
 <CAPan3WpJ_L7OyiC0hod0e436xOUZ2sHCfQqRmAsvD7hTPrBsDg@mail.gmail.com>
 <20200203131017.GE2626@minyard.net>
 <CAPan3Wr=JFwHPChPfN6kng9ZZhrbprc8ZuXjHS5cErPuV-FzJg@mail.gmail.com>
In-Reply-To: <CAPan3Wr=JFwHPChPfN6kng9ZZhrbprc8ZuXjHS5cErPuV-FzJg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 12 Feb 2020 22:31:33 +0100
Message-ID: <CAPan3WrE77GePz-mgz1otf1iiK8nDZ+RK2NF5ueRoHbDmpS1_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] hw/arm/allwinner: add Security Identifier device
To: Corey Minyard <cminyard@mvista.com>
Content-Type: multipart/alternative; boundary="000000000000f20da2059e67b255"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f20da2059e67b255
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Corey,

On Thu, Feb 6, 2020 at 10:09 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> Hi Corey,
>
> On Mon, Feb 3, 2020 at 2:10 PM Corey Minyard <cminyard@mvista.com> wrote:
>
>> On Sun, Feb 02, 2020 at 10:27:49PM +0100, Niek Linnenbank wrote:
>> > Hi Corey,
>> >
>> > Thanks for reviewing!
>> >
>> > On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard <cminyard@mvista.com>
>> wrote:
>> >
>> > > On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe Mathieu-Daud=C3=
=A9
>> wrote:
>> > > > Cc'ing Corey/David for good advices about using UUID.
>> > >
>> > > Is there any reason you didn't use the built-in qemu UUID for this?
>> It
>> > > would simplify things in general.
>> > >
>> >
>> > Currently the Allwinner SID device is using the QemuUUID type from
>> > include/qemu/uuid.h.
>> > Is that the build-in UUID you are referring to or should I use somethi=
ng
>> > else?
>>
>> You are using the QemuUUID type, which is of course what you should do,
>> but you aren't using the UUID generated by qemu (at least that I can
>> find).
>> That in include/sysemu/sysemu.h and is named qemu_uuid.  Whether you
>> should use that or not depends on your needs.  If you just need some
>> uuid, then that's what you should probably use.  If you need something
>> the user can individually control for this device, for instance, then
>> that probably won't do.
>>
>
> Ah I did not know about the qemu_uuid variable, thanks for pointing that
> out.
> Basically the SID identifier is a number that is unique for each board
> that comes
> out of the factory. It is currently used by U-Boot to as input to generat=
e
> a MAC address.
>
> If I understand correctly, qemu_uuid is optional and by default zero.
> However the SID value should not be zero, as otherwise U-Boot can't pick =
a
> MAC address
> resulting in a non-working ethernet device.
>
> Currently the hw/arm/orangepi.c machine specifies a fixed SID to be used
> for the emulated board,
> also containing a prefix (8100c002) that indicates the H3 chipset. One
> thing that I am strugling with is that
> I'm not able to override the property using '-global', if
> hw/arm/orangepi.c initializes the property with qdev_prop_set_string:
>
> $ qemu-system-arm -M orangepi-pc -kernel u-boot -nographic -nic user \
> -global allwinner-sid.identifier=3D8100c002-0001-0002-0003-000044556688
>
> If I don't set the property in hw/arm/orangepi.c, I can set it with
> '-global'. Do you perhaps have a
> recommendation how to improve that? Basically what is needed is that the
> machine sets the default
> property including the chip prefix, and that the user can override it.
> Although it is not required for a
> working emulated board, it would be a nice-to-have that the user can set
> it.
>

FYI and possibly others who have a similar usecase, I figured out how to do
this. In the machine init function,
after creating the new SoC object, simply check if the identifier has a
value:

+    if (qemu_uuid_is_null(&s->h3->sid.identifier)) {
+        qdev_prop_set_string(DEVICE(s->h3), "identifier",
+                             "8100c002-0001-0002-0003-000044556677");
+    }

That way, if the user passed -global to override it, the machine will not
overrule the user's value
and by default the machine sets an identifier containing the H3 specific
chip prefix.

Regards,
Niek


>
>> >
>> >
>> > > Also, in case no one else say, you have tabs in your code that you
>> need
>> > > to get rid of.
>> > >
>> > >
>> > If there are any tabs in the code, it was not intended. I re-checked
>> this
>> > patch and others
>> > again but found no tabs in the code.
>> > Could you please point out where you found the extra tabs?
>>
>> My apologies, I saw 1-character misalignments, and that usually means
>> that there's a tab.  But it looks like it has something to do with the
>> way it was forwarded.  I didn't get the original email.
>>
>> Ah yes that is possible indeed. I'll add you to the CC list for the next
> version of this patch series.
>
> Regards,
> Niek
>
>
>> -corey
>>
>> >
>> > Regards,
>> > Niek
>> >
>> >
>> > > -corey
>> > >
>> > > >
>> > > > On 1/8/20 9:00 PM, Niek Linnenbank wrote:
>> > > > > The Security Identifier device found in various Allwinner System
>> on
>> > > Chip
>> > > > > designs gives applications a per-board unique identifier. This
>> commit
>> > > > > adds support for the Allwinner Security Identifier using a 128-b=
it
>> > > > > UUID value as input.
>> > > > >
>> > > > > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> > > > > ---
>> > > > >   include/hw/arm/allwinner-h3.h   |   3 +
>> > > > >   include/hw/misc/allwinner-sid.h |  61 ++++++++++++
>> > > > >   hw/arm/allwinner-h3.c           |  11 ++-
>> > > > >   hw/arm/orangepi.c               |   4 +
>> > > > >   hw/misc/allwinner-sid.c         | 170
>> > > ++++++++++++++++++++++++++++++++
>> > > > >   hw/misc/Makefile.objs           |   1 +
>> > > > >   hw/misc/trace-events            |   4 +
>> > > > >   7 files changed, 253 insertions(+), 1 deletion(-)
>> > > > >   create mode 100644 include/hw/misc/allwinner-sid.h
>> > > > >   create mode 100644 hw/misc/allwinner-sid.c
>> > > > >
>> > > > > diff --git a/include/hw/arm/allwinner-h3.h
>> > > b/include/hw/arm/allwinner-h3.h
>> > > > > index 5a25a92eae..9ed365507c 100644
>> > > > > --- a/include/hw/arm/allwinner-h3.h
>> > > > > +++ b/include/hw/arm/allwinner-h3.h
>> > > > > @@ -46,6 +46,7 @@
>> > > > >   #include "hw/misc/allwinner-h3-ccu.h"
>> > > > >   #include "hw/misc/allwinner-cpucfg.h"
>> > > > >   #include "hw/misc/allwinner-h3-sysctrl.h"
>> > > > > +#include "hw/misc/allwinner-sid.h"
>> > > > >   #include "target/arm/cpu.h"
>> > > > >   /**
>> > > > > @@ -63,6 +64,7 @@ enum {
>> > > > >       AW_H3_SRAM_A2,
>> > > > >       AW_H3_SRAM_C,
>> > > > >       AW_H3_SYSCTRL,
>> > > > > +    AW_H3_SID,
>> > > > >       AW_H3_EHCI0,
>> > > > >       AW_H3_OHCI0,
>> > > > >       AW_H3_EHCI1,
>> > > > > @@ -115,6 +117,7 @@ typedef struct AwH3State {
>> > > > >       AwH3ClockCtlState ccu;
>> > > > >       AwCpuCfgState cpucfg;
>> > > > >       AwH3SysCtrlState sysctrl;
>> > > > > +    AwSidState sid;
>> > > > >       GICState gic;
>> > > > >       MemoryRegion sram_a1;
>> > > > >       MemoryRegion sram_a2;
>> > > > > diff --git a/include/hw/misc/allwinner-sid.h
>> > > b/include/hw/misc/allwinner-sid.h
>> > > > > new file mode 100644
>> > > > > index 0000000000..41189967e2
>> > > > > --- /dev/null
>> > > > > +++ b/include/hw/misc/allwinner-sid.h
>> > > > > @@ -0,0 +1,61 @@
>> > > > > +/*
>> > > > > + * Allwinner Security ID emulation
>> > > > > + *
>> > > > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com=
>
>> > > > > + *
>> > > > > + * This program is free software: you can redistribute it and/o=
r
>> > > modify
>> > > > > + * it under the terms of the GNU General Public License as
>> published
>> > > by
>> > > > > + * the Free Software Foundation, either version 2 of the
>> License, or
>> > > > > + * (at your option) any later version.
>> > > > > + *
>> > > > > + * This program is distributed in the hope that it will be
>> useful,
>> > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty =
of
>> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
>> > > > > + * GNU General Public License for more details.
>> > > > > + *
>> > > > > + * You should have received a copy of the GNU General Public
>> License
>> > > > > + * along with this program.  If not, see <
>> > > http://www.gnu.org/licenses/>.
>> > > > > + */
>> > > > > +
>> > > > > +#ifndef HW_MISC_ALLWINNER_SID_H
>> > > > > +#define HW_MISC_ALLWINNER_SID_H
>> > > > > +
>> > > > > +#include "qemu/osdep.h"
>> > > > > +#include "qom/object.h"
>> > > > > +#include "hw/sysbus.h"
>> > > > > +#include "qemu/uuid.h"
>> > > > > +
>> > > > > +/**
>> > > > > + * Object model
>> > > > > + * @{
>> > > > > + */
>> > > > > +
>> > > > > +#define TYPE_AW_SID    "allwinner-sid"
>> > > > > +#define AW_SID(obj) \
>> > > > > +    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
>> > > > > +
>> > > > > +/** @} */
>> > > > > +
>> > > > > +/**
>> > > > > + * Allwinner Security ID object instance state
>> > > > > + */
>> > > > > +typedef struct AwSidState {
>> > > > > +    /*< private >*/
>> > > > > +    SysBusDevice parent_obj;
>> > > > > +    /*< public >*/
>> > > > > +
>> > > > > +    /** Maps I/O registers in physical memory */
>> > > > > +    MemoryRegion iomem;
>> > > > > +
>> > > > > +    /** Control register defines how and what to read */
>> > > > > +    uint32_t control;
>> > > > > +
>> > > > > +    /** RdKey register contains the data retrieved by the devic=
e
>> */
>> > > > > +    uint32_t rdkey;
>> > > > > +
>> > > > > +    /** Stores the emulated device identifier */
>> > > > > +    QemuUUID identifier;
>> > > > > +
>> > > > > +} AwSidState;
>> > > > > +
>> > > > > +#endif /* HW_MISC_ALLWINNER_SID_H */
>> > > > > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>> > > > > index e9ad6d23df..af7317e86a 100644
>> > > > > --- a/hw/arm/allwinner-h3.c
>> > > > > +++ b/hw/arm/allwinner-h3.c
>> > > > > @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =3D {
>> > > > >       [AW_H3_SRAM_A2]    =3D 0x00044000,
>> > > > >       [AW_H3_SRAM_C]     =3D 0x00010000,
>> > > > >       [AW_H3_SYSCTRL]    =3D 0x01c00000,
>> > > > > +    [AW_H3_SID]        =3D 0x01c14000,
>> > > > >       [AW_H3_EHCI0]      =3D 0x01c1a000,
>> > > > >       [AW_H3_OHCI0]      =3D 0x01c1a400,
>> > > > >       [AW_H3_EHCI1]      =3D 0x01c1b000,
>> > > > > @@ -76,7 +77,6 @@ struct AwH3Unimplemented {
>> > > > >       { "mmc0",      0x01c0f000, 4 * KiB },
>> > > > >       { "mmc1",      0x01c10000, 4 * KiB },
>> > > > >       { "mmc2",      0x01c11000, 4 * KiB },
>> > > > > -    { "sid",       0x01c14000, 1 * KiB },
>> > > > >       { "crypto",    0x01c15000, 4 * KiB },
>> > > > >       { "msgbox",    0x01c17000, 4 * KiB },
>> > > > >       { "spinlock",  0x01c18000, 4 * KiB },
>> > > > > @@ -196,6 +196,11 @@ static void allwinner_h3_init(Object *obj)
>> > > > >       sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg,
>> > > sizeof(s->cpucfg),
>> > > > >                             TYPE_AW_CPUCFG);
>> > > > > +
>> > > > > +    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
>> > > > > +                          TYPE_AW_SID);
>> > > > > +    object_property_add_alias(obj, "identifier", OBJECT(&s->sid=
),
>> > > > > +                              "identifier", &error_abort);
>> > > > >   }
>> > > > >   static void allwinner_h3_realize(DeviceState *dev, Error **err=
p)
>> > > > > @@ -316,6 +321,10 @@ static void allwinner_h3_realize(DeviceStat=
e
>> > > *dev, Error **errp)
>> > > > >       qdev_init_nofail(DEVICE(&s->cpucfg));
>> > > > >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
>> > > s->memmap[AW_H3_CPUCFG]);
>> > > > > +    /* Security Identifier */
>> > > > > +    qdev_init_nofail(DEVICE(&s->sid));
>> > > > > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0,
>> s->memmap[AW_H3_SID]);
>> > > > > +
>> > > > >       /* Universal Serial Bus */
>> > > > >       sysbus_create_simple(TYPE_AW_H3_EHCI,
>> s->memmap[AW_H3_EHCI0],
>> > > > >                            qdev_get_gpio_in(DEVICE(&s->gic),
>> > > > > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
>> > > > > index 051184f14f..a7f870c88b 100644
>> > > > > --- a/hw/arm/orangepi.c
>> > > > > +++ b/hw/arm/orangepi.c
>> > > > > @@ -54,6 +54,10 @@ static void orangepi_init(MachineState
>> *machine)
>> > > > >       object_property_set_int(OBJECT(s->h3), 24000000,
>> "clk1-freq",
>> > > > >                               &error_abort);
>> > > > > +    /* Setup SID properties */
>> > > > > +    qdev_prop_set_string(DEVICE(s->h3), "identifier",
>> > > > > +                         "8100c002-0001-0002-0003-000044556677"=
);
>> > > > > +
>> > > > >       /* Mark H3 object realized */
>> > > > >       object_property_set_bool(OBJECT(s->h3), true, "realized",
>> > > &error_abort);
>> > > > > diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
>> > > > > new file mode 100644
>> > > > > index 0000000000..954de935bc
>> > > > > --- /dev/null
>> > > > > +++ b/hw/misc/allwinner-sid.c
>> > > > > @@ -0,0 +1,170 @@
>> > > > > +/*
>> > > > > + * Allwinner Security ID emulation
>> > > > > + *
>> > > > > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com=
>
>> > > > > + *
>> > > > > + * This program is free software: you can redistribute it and/o=
r
>> > > modify
>> > > > > + * it under the terms of the GNU General Public License as
>> published
>> > > by
>> > > > > + * the Free Software Foundation, either version 2 of the
>> License, or
>> > > > > + * (at your option) any later version.
>> > > > > + *
>> > > > > + * This program is distributed in the hope that it will be
>> useful,
>> > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty =
of
>> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
>> > > > > + * GNU General Public License for more details.
>> > > > > + *
>> > > > > + * You should have received a copy of the GNU General Public
>> License
>> > > > > + * along with this program.  If not, see <
>> > > http://www.gnu.org/licenses/>.
>> > > > > + */
>> > > > > +
>> > > > > +#include "qemu/osdep.h"
>> > > > > +#include "qemu/units.h"
>> > > > > +#include "hw/sysbus.h"
>> > > > > +#include "migration/vmstate.h"
>> > > > > +#include "qemu/log.h"
>> > > > > +#include "qemu/module.h"
>> > > > > +#include "qemu/guest-random.h"
>> > > > > +#include "qapi/error.h"
>> > > > > +#include "hw/qdev-properties.h"
>> > > > > +#include "hw/misc/allwinner-sid.h"
>> > > > > +#include "trace.h"
>> > > > > +
>> > > > > +/* SID register offsets */
>> > > > > +enum {
>> > > > > +    REG_PRCTL =3D 0x40,   /* Control */
>> > > > > +    REG_RDKEY =3D 0x60,   /* Read Key */
>> > > > > +};
>> > > > > +
>> > > > > +/* SID register flags */
>> > > > > +enum {
>> > > > > +    REG_PRCTL_WRITE   =3D 0x0002, /* Unknown write flag */
>> > > > > +    REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
>> > > > > +};
>> > > > > +
>> > > > > +static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,
>> > > > > +                                   unsigned size)
>> > > > > +{
>> > > > > +    const AwSidState *s =3D AW_SID(opaque);
>> > > > > +    uint64_t val =3D 0;
>> > > > > +
>> > > > > +    switch (offset) {
>> > > > > +    case REG_PRCTL:    /* Control */
>> > > > > +        val =3D s->control;
>> > > > > +        break;
>> > > > > +    case REG_RDKEY:    /* Read Key */
>> > > > > +        val =3D s->rdkey;
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offse=
t
>> > > 0x%04x\n",
>> > > > > +                      __func__, (uint32_t)offset);
>> > > > > +        return 0;
>> > > > > +    }
>> > > > > +
>> > > > > +    trace_allwinner_sid_read(offset, val, size);
>> > > > > +
>> > > > > +    return val;
>> > > > > +}
>> > > > > +
>> > > > > +static void allwinner_sid_write(void *opaque, hwaddr offset,
>> > > > > +                                uint64_t val, unsigned size)
>> > > > > +{
>> > > > > +    AwSidState *s =3D AW_SID(opaque);
>> > > > > +
>> > > > > +    trace_allwinner_sid_write(offset, val, size);
>> > > > > +
>> > > > > +    switch (offset) {
>> > > > > +    case REG_PRCTL:    /* Control */
>> > > > > +        s->control =3D val;
>> > > > > +
>> > > > > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
>> > > > > +            (s->control & REG_PRCTL_WRITE)) {
>> > > > > +            uint32_t id =3D s->control >> 16;
>> > > > > +
>> > > > > +            if (id < sizeof(QemuUUID)) {
>> > > > > +                s->rdkey =3D (s->identifier.data[id]) |
>> > > > > +                           (s->identifier.data[id + 1] << 8) |
>> > > > > +                           (s->identifier.data[id + 2] << 16) |
>> > > > > +                           (s->identifier.data[id + 3] << 24);
>> > > > > +            }
>> > > > > +        }
>> > > > > +        s->control &=3D ~REG_PRCTL_WRITE;
>> > > > > +        break;
>> > > > > +    case REG_RDKEY:    /* Read Key */
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offse=
t
>> > > 0x%04x\n",
>> > > > > +                      __func__, (uint32_t)offset);
>> > > > > +        break;
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > > > +static const MemoryRegionOps allwinner_sid_ops =3D {
>> > > > > +    .read =3D allwinner_sid_read,
>> > > > > +    .write =3D allwinner_sid_write,
>> > > > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> > > > > +    .valid =3D {
>> > > > > +        .min_access_size =3D 4,
>> > > > > +        .max_access_size =3D 4,
>> > > > > +    },
>> > > > > +    .impl.min_access_size =3D 4,
>> > > > > +};
>> > > > > +
>> > > > > +static void allwinner_sid_reset(DeviceState *dev)
>> > > > > +{
>> > > > > +    AwSidState *s =3D AW_SID(dev);
>> > > > > +
>> > > > > +    /* Set default values for registers */
>> > > > > +    s->control =3D 0;
>> > > > > +    s->rdkey =3D 0;
>> > > > > +}
>> > > > > +
>> > > > > +static void allwinner_sid_init(Object *obj)
>> > > > > +{
>> > > > > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> > > > > +    AwSidState *s =3D AW_SID(obj);
>> > > > > +
>> > > > > +    /* Memory mapping */
>> > > > > +    memory_region_init_io(&s->iomem, OBJECT(s),
>> &allwinner_sid_ops, s,
>> > > > > +                           TYPE_AW_SID, 1 * KiB);
>> > > > > +    sysbus_init_mmio(sbd, &s->iomem);
>> > > > > +}
>> > > > > +
>> > > > > +static Property allwinner_sid_properties[] =3D {
>> > > > > +    DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState,
>> identifier),
>> > > > > +    DEFINE_PROP_END_OF_LIST()
>> > > > > +};
>> > > > > +
>> > > > > +static const VMStateDescription allwinner_sid_vmstate =3D {
>> > > > > +    .name =3D "allwinner-sid",
>> > > > > +    .version_id =3D 1,
>> > > > > +    .minimum_version_id =3D 1,
>> > > > > +    .fields =3D (VMStateField[]) {
>> > > > > +        VMSTATE_UINT32(control, AwSidState),
>> > > > > +        VMSTATE_UINT32(rdkey, AwSidState),
>> > > > > +        VMSTATE_END_OF_LIST()
>> > > > > +    }
>> > > > > +};
>> > > > > +
>> > > > > +static void allwinner_sid_class_init(ObjectClass *klass, void
>> *data)
>> > > > > +{
>> > > > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> > > > > +
>> > > > > +    dc->reset =3D allwinner_sid_reset;
>> > > > > +    dc->vmsd =3D &allwinner_sid_vmstate;
>> > > > > +    dc->props =3D allwinner_sid_properties;
>> > > > > +}
>> > > > > +
>> > > > > +static const TypeInfo allwinner_sid_info =3D {
>> > > > > +    .name          =3D TYPE_AW_SID,
>> > > > > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> > > > > +    .instance_init =3D allwinner_sid_init,
>> > > > > +    .instance_size =3D sizeof(AwSidState),
>> > > > > +    .class_init    =3D allwinner_sid_class_init,
>> > > > > +};
>> > > > > +
>> > > > > +static void allwinner_sid_register(void)
>> > > > > +{
>> > > > > +    type_register_static(&allwinner_sid_info);
>> > > > > +}
>> > > > > +
>> > > > > +type_init(allwinner_sid_register)
>> > > > > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> > > > > index 12c2c306b5..59500d5681 100644
>> > > > > --- a/hw/misc/Makefile.objs
>> > > > > +++ b/hw/misc/Makefile.objs
>> > > > > @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshm=
em.o
>> > > > >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o
>> > > > >   obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-cpucfg.o
>> > > > >   common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sysctrl.o
>> > > > > +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o
>> > > > >   common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o
>> > > > >   common-obj-$(CONFIG_NSERIES) +=3D cbus.o
>> > > > >   common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o
>> > > > > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> > > > > index d3e0952429..67d8bf493c 100644
>> > > > > --- a/hw/misc/trace-events
>> > > > > +++ b/hw/misc/trace-events
>> > > > > @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id,
>> uint32_t
>> > > reset_addr) "id %u, reset_ad
>> > > > >   allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned
>> size)
>> > > "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>> > > > >   allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigne=
d
>> > > size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>> > > > > +# allwinner-sid.c
>> > > > > +allwinner_sid_read(uint64_t offset, uint64_t data, unsigned siz=
e)
>> > > "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>> > > > > +allwinner_sid_write(uint64_t offset, uint64_t data, unsigned
>> size)
>> > > "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
>> > > > > +
>> > > > >   # eccmemctl.c
>> > > > >   ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
>> > > > >   ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
>> > > > >
>> > > >
>> > >
>> >
>> >
>> > --
>> > Niek Linnenbank
>>
>
>
> --
> Niek Linnenbank
>
>

--=20
Niek Linnenbank

--000000000000f20da2059e67b255
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Corey,<br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 6, 2020 at 10:09 PM Niek Lin=
nenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmai=
l.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div>Hi Corey,<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 3, 2020 at 2:10 PM Core=
y Minyard &lt;<a href=3D"mailto:cminyard@mvista.com" target=3D"_blank">cmin=
yard@mvista.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Sun, Feb 02, 2020 at 10:27:49PM +0100, Niek Linnenbank wr=
ote:<br>
&gt; Hi Corey,<br>
&gt; <br>
&gt; Thanks for reviewing!<br>
&gt; <br>
&gt; On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard &lt;<a href=3D"mailto:cm=
inyard@mvista.com" target=3D"_blank">cminyard@mvista.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe Mathieu-Daud=
=C3=A9 wrote:<br>
&gt; &gt; &gt; Cc&#39;ing Corey/David for good advices about using UUID.<br=
>
&gt; &gt;<br>
&gt; &gt; Is there any reason you didn&#39;t use the built-in qemu UUID for=
 this?=C2=A0 It<br>
&gt; &gt; would simplify things in general.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Currently the Allwinner SID device is using the QemuUUID type from<br>
&gt; include/qemu/uuid.h.<br>
&gt; Is that the build-in UUID you are referring to or should I use somethi=
ng<br>
&gt; else?<br>
<br>
You are using the QemuUUID type, which is of course what you should do,<br>
but you aren&#39;t using the UUID generated by qemu (at least that I can fi=
nd).<br>
That in include/sysemu/sysemu.h and is named qemu_uuid.=C2=A0 Whether you<b=
r>
should use that or not depends on your needs.=C2=A0 If you just need some<b=
r>
uuid, then that&#39;s what you should probably use.=C2=A0 If you need somet=
hing<br>
the user can individually control for this device, for instance, then<br>
that probably won&#39;t do.<br></blockquote><div><br></div><div>Ah I did no=
t know about the qemu_uuid variable, thanks for pointing that out.</div><di=
v>Basically the SID identifier is a number that is unique for each board th=
at comes</div><div>out of the factory. It is currently used by U-Boot to as=
 input to generate a MAC address.</div><div><br></div><div>If I understand =
correctly, qemu_uuid is optional and by default zero. </div><div>However th=
e SID value should not be zero, as otherwise U-Boot can&#39;t pick a MAC ad=
dress</div><div>resulting in a non-working ethernet device.<br></div><div><=
br></div><div>Currently the hw/arm/orangepi.c machine specifies a fixed SID=
 to be used for the emulated board,</div><div>also containing a prefix (810=
0c002) that indicates the H3 chipset. One thing that I am strugling with is=
 that</div><div>I&#39;m not able to override the property using &#39;-globa=
l&#39;, if hw/arm/orangepi.c initializes the property with qdev_prop_set_st=
ring:<br></div><div><br></div><div>$ qemu-system-arm -M orangepi-pc -kernel=
 u-boot -nographic -nic user \<br></div><div>-global allwinner-sid.identifi=
er=3D8100c002-0001-0002-0003-000044556688</div><div>=C2=A0</div><div>If I d=
on&#39;t set the property in hw/arm/orangepi.c, I can set it with &#39;-glo=
bal&#39;. Do you perhaps have a</div><div>recommendation how to improve tha=
t? Basically what is needed is that the machine sets the default</div><div>=
property including the chip prefix, and that the user can override it. Alth=
ough it is not required for a</div><div>working emulated board, it would be=
 a nice-to-have that the user can set it.<br></div></div></div></blockquote=
><div><br></div><div>FYI and possibly others who have a similar usecase, I =
figured out how to do this. In the machine init function,</div><div>after c=
reating the new SoC object, simply check if the identifier has a value:<br>=
</div><div><br></div><div>+ =C2=A0 =C2=A0if (qemu_uuid_is_null(&amp;s-&gt;h=
3-&gt;sid.identifier)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_stri=
ng(DEVICE(s-&gt;h3), &quot;identifier&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;8100c002-0001-0002-0003-000044556677&quot;);<br>+ =C2=A0 =C2=A0}</div>=
<div><br></div><div>That way, if the user passed -global to override it, th=
e machine will not overrule the user&#39;s value</div><div>and by default t=
he machine sets an identifier containing the H3 specific chip prefix.</div>=
<div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_quote"><div></div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt; Also, in case no one else say, you have tabs in your code that yo=
u need<br>
&gt; &gt; to get rid of.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; If there are any tabs in the code, it was not intended. I re-checked t=
his<br>
&gt; patch and others<br>
&gt; again but found no tabs in the code.<br>
&gt; Could you please point out where you found the extra tabs?<br>
<br>
My apologies, I saw 1-character misalignments, and that usually means<br>
that there&#39;s a tab.=C2=A0 But it looks like it has something to do with=
 the<br>
way it was forwarded.=C2=A0 I didn&#39;t get the original email.<br>
<br></blockquote><div>Ah yes that is possible indeed. I&#39;ll add you to t=
he CC list for the next version of this patch series.</div><div><br></div><=
div>Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
-corey<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Niek<br>
&gt; <br>
&gt; <br>
&gt; &gt; -corey<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt; &gt; &gt; &gt; The Security Identifier device found in various Allwinn=
er System on<br>
&gt; &gt; Chip<br>
&gt; &gt; &gt; &gt; designs gives applications a per-board unique identifie=
r. This commit<br>
&gt; &gt; &gt; &gt; adds support for the Allwinner Security Identifier usin=
g a 128-bit<br>
&gt; &gt; &gt; &gt; UUID value as input.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<=
br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0include/hw/misc/allwinner-sid.h |=C2=A0 61 =
++++++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 11 ++-<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/misc/allwinner-sid.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 170<br>
&gt; &gt; ++++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A07 files changed, 253 insertions(+), 1 delet=
ion(-)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0create mode 100644 include/hw/misc/allwinne=
r-sid.h<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0create mode 100644 hw/misc/allwinner-sid.c<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/include/hw/arm/allwinner-h3.h<br>
&gt; &gt; b/include/hw/arm/allwinner-h3.h<br>
&gt; &gt; &gt; &gt; index 5a25a92eae..9ed365507c 100644<br>
&gt; &gt; &gt; &gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; &gt; &gt; &gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; &gt; &gt; &gt; @@ -46,6 +46,7 @@<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-ccu.h&q=
uot;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-cpucfg.h&q=
uot;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-sysctrl=
.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0/**<br>
&gt; &gt; &gt; &gt; @@ -63,6 +64,7 @@ enum {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A2,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_C,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_SYSCTRL,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AW_H3_SID,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_EHCI0,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_OHCI0,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_EHCI1,<br>
&gt; &gt; &gt; &gt; @@ -115,6 +117,7 @@ typedef struct AwH3State {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3ClockCtlState ccu;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwCpuCfgState cpucfg;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysCtrlState sysctrl;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AwSidState sid;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; &gt; &gt; &gt; diff --git a/include/hw/misc/allwinner-sid.h<br>
&gt; &gt; b/include/hw/misc/allwinner-sid.h<br>
&gt; &gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; &gt; index 0000000000..41189967e2<br>
&gt; &gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; &gt; +++ b/include/hw/misc/allwinner-sid.h<br>
&gt; &gt; &gt; &gt; @@ -0,0 +1,61 @@<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * Allwinner Security ID emulation<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"m=
ailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com<=
/a>&gt;<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * This program is free software: you can redistribute=
 it and/or<br>
&gt; &gt; modify<br>
&gt; &gt; &gt; &gt; + * it under the terms of the GNU General Public Licens=
e as published<br>
&gt; &gt; by<br>
&gt; &gt; &gt; &gt; + * the Free Software Foundation, either version 2 of t=
he License, or<br>
&gt; &gt; &gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * This program is distributed in the hope that it wil=
l be useful,<br>
&gt; &gt; &gt; &gt; + * but WITHOUT ANY WARRANTY; without even the implied =
warranty of<br>
&gt; &gt; &gt; &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
.=C2=A0 See the<br>
&gt; &gt; &gt; &gt; + * GNU General Public License for more details.<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * You should have received a copy of the GNU General =
Public License<br>
&gt; &gt; &gt; &gt; + * along with this program.=C2=A0 If not, see &lt;<br>
&gt; &gt; <a href=3D"http://www.gnu.org/licenses/" rel=3D"noreferrer" targe=
t=3D"_blank">http://www.gnu.org/licenses/</a>&gt;.<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#ifndef HW_MISC_ALLWINNER_SID_H<br>
&gt; &gt; &gt; &gt; +#define HW_MISC_ALLWINNER_SID_H<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qom/object.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/**<br>
&gt; &gt; &gt; &gt; + * Object model<br>
&gt; &gt; &gt; &gt; + * @{<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#define TYPE_AW_SID=C2=A0 =C2=A0 &quot;allwinner-sid&q=
uot;<br>
&gt; &gt; &gt; &gt; +#define AW_SID(obj) \<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 OBJECT_CHECK(AwSidState, (obj), TYPE_AW_=
SID)<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/** @} */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/**<br>
&gt; &gt; &gt; &gt; + * Allwinner Security ID object instance state<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +typedef struct AwSidState {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memor=
y */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /** Control register defines how and wha=
t to read */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t control;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /** RdKey register contains the data ret=
rieved by the device */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t rdkey;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /** Stores the emulated device identifie=
r */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 QemuUUID identifier;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +} AwSidState;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#endif /* HW_MISC_ALLWINNER_SID_H */<br>
&gt; &gt; &gt; &gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h=
3.c<br>
&gt; &gt; &gt; &gt; index e9ad6d23df..af7317e86a 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; &gt; &gt; &gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; &gt; &gt; &gt; @@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] =
=3D {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A2]=C2=A0 =C2=A0 =
=3D 0x00044000,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_C]=C2=A0 =C2=A0 =
=C2=A0=3D 0x00010000,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_SYSCTRL]=C2=A0 =C2=A0 =
=3D 0x01c00000,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 [AW_H3_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x01c14000,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_EHCI0]=C2=A0 =C2=A0 =
=C2=A0 =3D 0x01c1a000,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_OHCI0]=C2=A0 =C2=A0 =
=C2=A0 =3D 0x01c1a400,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_H3_EHCI1]=C2=A0 =C2=A0 =
=C2=A0 =3D 0x01c1b000,<br>
&gt; &gt; &gt; &gt; @@ -76,7 +77,6 @@ struct AwH3Unimplemented {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc0&quot;,=C2=A0 =C2=
=A0 =C2=A0 0x01c0f000, 4 * KiB },<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc1&quot;,=C2=A0 =C2=
=A0 =C2=A0 0x01c10000, 4 * KiB },<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmc2&quot;,=C2=A0 =C2=
=A0 =C2=A0 0x01c11000, 4 * KiB },<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 { &quot;sid&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A00x01c14000, 1 * KiB },<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;crypto&quot;,=C2=A0 =
=C2=A0 0x01c15000, 4 * KiB },<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;msgbox&quot;,=C2=A0 =
=C2=A0 0x01c17000, 4 * KiB },<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;spinlock&quot;,=C2=A0=
 0x01c18000, 4 * KiB },<br>
&gt; &gt; &gt; &gt; @@ -196,6 +196,11 @@ static void allwinner_h3_init(Obje=
ct *obj)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &q=
uot;cpucfg&quot;, &amp;s-&gt;cpucfg,<br>
&gt; &gt; sizeof(s-&gt;cpucfg),<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_CPUCFG);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;sid&quo=
t;, &amp;s-&gt;sid, sizeof(s-&gt;sid),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_SID);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;ide=
ntifier&quot;, OBJECT(&amp;s-&gt;sid),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;identifier&quot;=
, &amp;error_abort);<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0static void allwinner_h3_realize(DeviceStat=
e *dev, Error **errp)<br>
&gt; &gt; &gt; &gt; @@ -316,6 +321,10 @@ static void allwinner_h3_realize(D=
eviceState<br>
&gt; &gt; *dev, Error **errp)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(DEVICE(&amp;=
s-&gt;cpucfg));<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVIC=
E(&amp;s-&gt;cpucfg), 0,<br>
&gt; &gt; s-&gt;memmap[AW_H3_CPUCFG]);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Security Identifier */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;sid))=
;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&g=
t;sid), 0, s-&gt;memmap[AW_H3_SID]);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br=
>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_=
H3_EHCI, s-&gt;memmap[AW_H3_EHCI0],<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&g=
t;gic),<br>
&gt; &gt; &gt; &gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; &gt; &gt; &gt; index 051184f14f..a7f870c88b 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/arm/orangepi.c<br>
&gt; &gt; &gt; &gt; +++ b/hw/arm/orangepi.c<br>
&gt; &gt; &gt; &gt; @@ -54,6 +54,10 @@ static void orangepi_init(MachineSta=
te *machine)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJEC=
T(s-&gt;h3), 24000000, &quot;clk1-freq&quot;,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Setup SID properties */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(s-&gt;h3), &=
quot;identifier&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-0003-0000445=
56677&quot;);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object realized */=
<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJE=
CT(s-&gt;h3), true, &quot;realized&quot;,<br>
&gt; &gt; &amp;error_abort);<br>
&gt; &gt; &gt; &gt; diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinne=
r-sid.c<br>
&gt; &gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; &gt; index 0000000000..954de935bc<br>
&gt; &gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; &gt; +++ b/hw/misc/allwinner-sid.c<br>
&gt; &gt; &gt; &gt; @@ -0,0 +1,170 @@<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * Allwinner Security ID emulation<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"m=
ailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com<=
/a>&gt;<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * This program is free software: you can redistribute=
 it and/or<br>
&gt; &gt; modify<br>
&gt; &gt; &gt; &gt; + * it under the terms of the GNU General Public Licens=
e as published<br>
&gt; &gt; by<br>
&gt; &gt; &gt; &gt; + * the Free Software Foundation, either version 2 of t=
he License, or<br>
&gt; &gt; &gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * This program is distributed in the hope that it wil=
l be useful,<br>
&gt; &gt; &gt; &gt; + * but WITHOUT ANY WARRANTY; without even the implied =
warranty of<br>
&gt; &gt; &gt; &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
.=C2=A0 See the<br>
&gt; &gt; &gt; &gt; + * GNU General Public License for more details.<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * You should have received a copy of the GNU General =
Public License<br>
&gt; &gt; &gt; &gt; + * along with this program.=C2=A0 If not, see &lt;<br>
&gt; &gt; <a href=3D"http://www.gnu.org/licenses/" rel=3D"noreferrer" targe=
t=3D"_blank">http://www.gnu.org/licenses/</a>&gt;.<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/units.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/log.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/module.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qapi/error.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/misc/allwinner-sid.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;trace.h&quot;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* SID register offsets */<br>
&gt; &gt; &gt; &gt; +enum {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL =3D 0x40,=C2=A0 =C2=A0/* Contr=
ol */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_RDKEY =3D 0x60,=C2=A0 =C2=A0/* Read =
Key */<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* SID register flags */<br>
&gt; &gt; &gt; &gt; +enum {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL_WRITE=C2=A0 =C2=A0=3D 0x0002, =
/* Unknown write flag */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock op=
eration */<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static uint64_t allwinner_sid_read(void *opaque, hwadd=
r offset,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0un=
signed size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 const AwSidState *s =3D AW_SID(opaque);<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control =
*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;control;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key=
 */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt;rdkey;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ER=
ROR, &quot;%s: out-of-bounds offset<br>
&gt; &gt; 0x%04x\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_sid_read(offset, val, si=
ze);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return val;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void allwinner_sid_write(void *opaque, hwaddr o=
ffset,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, u=
nsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(opaque);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_sid_write(offset, val, s=
ize);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=A0 /* Control =
*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control =3D val;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;control &amp; R=
EG_PRCTL_OP_LOCK) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;contr=
ol &amp; REG_PRCTL_WRITE)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t id =
=3D s-&gt;control &gt;&gt; 16;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id &lt; =
sizeof(QemuUUID)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;rdkey =3D (s-&gt;identifier.data[id]) |<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 1]=
 &lt;&lt; 8) |<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 2]=
 &lt;&lt; 16) |<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.data[id + 3]=
 &lt;&lt; 24);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control &amp;=3D ~RE=
G_PRCTL_WRITE;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=A0 /* Read Key=
 */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ER=
ROR, &quot;%s: out-of-bounds offset<br>
&gt; &gt; 0x%04x\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const MemoryRegionOps allwinner_sid_ops =3D {<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D allwinner_sid_read,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D allwinner_sid_write,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 },<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void allwinner_sid_reset(DeviceState *dev)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(dev);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Set default values for registers */<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;control =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;rdkey =3D 0;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void allwinner_sid_init(Object *obj)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj=
);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(obj);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, =
OBJECT(s), &amp;allwinner_sid_ops, s,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_SID, 1 * KiB);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);=
<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static Property allwinner_sid_properties[] =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UUID_NODEFAULT(&quot;identif=
ier&quot;, AwSidState, identifier),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const VMStateDescription allwinner_sid_vmstate =
=3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-sid&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(control, Aw=
SidState),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rdkey, AwSi=
dState),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void allwinner_sid_class_init(ObjectClass *klas=
s, void *data)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);=
<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_sid_reset;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_sid_vmsta=
te;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;props =3D allwinner_sid_propertie=
s;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const TypeInfo allwinner_sid_info =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_AW_SID,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D T=
YPE_SYS_BUS_DEVICE,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_sid_init,<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwSidState),<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_s=
id_class_init,<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void allwinner_sid_register(void)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_sid_=
info);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +type_init(allwinner_sid_register)<br>
&gt; &gt; &gt; &gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.o=
bjs<br>
&gt; &gt; &gt; &gt; index 12c2c306b5..59500d5681 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/misc/Makefile.objs<br>
&gt; &gt; &gt; &gt; +++ b/hw/misc/Makefile.objs<br>
&gt; &gt; &gt; &gt; @@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) +=
=3D ivshmem.o<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allw=
inner-h3-ccu.o<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-c=
pucfg.o<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_H3) +=3D allw=
inner-h3-sysctrl.o<br>
&gt; &gt; &gt; &gt; +common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-sid.o=
<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysc=
tl.o<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br=
>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemc=
tl.o<br>
&gt; &gt; &gt; &gt; diff --git a/hw/misc/trace-events b/hw/misc/trace-event=
s<br>
&gt; &gt; &gt; &gt; index d3e0952429..67d8bf493c 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/misc/trace-events<br>
&gt; &gt; &gt; &gt; +++ b/hw/misc/trace-events<br>
&gt; &gt; &gt; &gt; @@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu=
_id, uint32_t<br>
&gt; &gt; reset_addr) &quot;id %u, reset_ad<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0allwinner_cpucfg_read(uint64_t offset, uint=
64_t data, unsigned size)<br>
&gt; &gt; &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot;=
 size %&quot; PRIu32<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0allwinner_cpucfg_write(uint64_t offset, uin=
t64_t data, unsigned<br>
&gt; &gt; size) &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 =
&quot; size %&quot; PRIu32<br>
&gt; &gt; &gt; &gt; +# allwinner-sid.c<br>
&gt; &gt; &gt; &gt; +allwinner_sid_read(uint64_t offset, uint64_t data, uns=
igned size)<br>
&gt; &gt; &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot;=
 size %&quot; PRIu32<br>
&gt; &gt; &gt; &gt; +allwinner_sid_write(uint64_t offset, uint64_t data, un=
signed size)<br>
&gt; &gt; &quot;offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64 &quot;=
 size %&quot; PRIu32<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0# eccmemctl.c<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0ecc_mem_writel_mer(uint32_t val) &quot;Writ=
e memory enable 0x%08x&quot;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0ecc_mem_writel_mdr(uint32_t val) &quot;Writ=
e memory delay 0x%08x&quot;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Niek Linnenbank<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f20da2059e67b255--

