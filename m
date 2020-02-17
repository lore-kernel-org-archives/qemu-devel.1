Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A42C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381C52064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA6Js8ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381C52064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mBp-0003KS-Fa
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j3mAD-0000OP-2k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j3mAA-0005ij-Km
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:34:40 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j3mAA-0005hu-At; Mon, 17 Feb 2020 14:34:38 -0500
Received: by mail-il1-x144.google.com with SMTP id s85so15205206ill.11;
 Mon, 17 Feb 2020 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fEVMIIQ96FX3VUZKtUePl/vfZoq3yp6AbT/Ral18fPM=;
 b=GA6Js8ahXZ0Il2kMpfbsZTccaMFqiINsrz7qBr6HsOSuINfO5nA2KQ5FMm4k+x/Qtd
 3nrCwawj1hjGfwCsoEY1E6pkeCjgr2wciloSXgMWKgqhhLV6b7iDqT2PKrvsZxmjwvy7
 5wXzOHuMIH+/Ai2VhrVO7q5aZxKMduGj4m4ZJqa0ieas6E8sFCDoUJMUzGHYEYLJju+J
 GKrWnnlbEZjHUvkXvxDKra74hoJTV/3S3FIPLuRHMlaIWPkSI2yHSkoteVNF1OwaQCS7
 Ijq2pvQPtefWku2iRR8mdHmnAQtkvUvpZF+ox8K0DltmMIwmPBD5y0DadeOuq+EipeDm
 r5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fEVMIIQ96FX3VUZKtUePl/vfZoq3yp6AbT/Ral18fPM=;
 b=GQ/jUN7oJ5q13dTZTZu/CMKmj/BmG7d7RUPVuRD9xgdocqj/sbxcgQHexSpJWOjCj0
 wTyIMPUd7R7rYYc6g9jAt7PIAM0S7NF3JNiGYTdMFhhQxkPBk391dixSuJPGTbnx3PRR
 yMwlMBZWPL0UCCdCBnsfNtG9koOWqj2H7v76iqQ3zYqs6xtqs0VhqcDoeQIsNgqXw+zh
 20R+puqxUFKNuhQOPui1MKcwl8eU5sEQDIdDMhvS9GMMhM7kHIgRFIbG52YTdghxe1ej
 CJBHiDgMyBLHht4j3wFYBYZGwYiaalNDMn/VCKCF7WAxg+S4G2nk0B7itZ+1qj0hy5Vf
 J8gQ==
X-Gm-Message-State: APjAAAWTQuwyaQ+Q754fNSbL5NA8NVsmDyL4P56gszMJajMz3VBw9W68
 EgpibpVDi9YE+kcTbBzzD0Bm7s0nD2Ieo+pRU9s=
X-Google-Smtp-Source: APXvYqzObUb1R1ui0bRfZFvYNOqhEU0nRFZXm6naT61Ev9WlMm4TJde8I94+xyal/Da0z8F+JOBcinGM3pv7WbEmG4w=
X-Received: by 2002:a92:81d9:: with SMTP id q86mr15274561ilk.67.1581968077215; 
 Mon, 17 Feb 2020 11:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-8-nieklinnenbank@gmail.com>
 <8be03fbb-74f2-e688-76b1-ab504f25f8e4@redhat.com>
 <20200120175918.GA2949@minyard.net>
 <CAPan3WpJ_L7OyiC0hod0e436xOUZ2sHCfQqRmAsvD7hTPrBsDg@mail.gmail.com>
 <20200203131017.GE2626@minyard.net>
 <CAPan3Wr=JFwHPChPfN6kng9ZZhrbprc8ZuXjHS5cErPuV-FzJg@mail.gmail.com>
 <CAPan3WrE77GePz-mgz1otf1iiK8nDZ+RK2NF5ueRoHbDmpS1_w@mail.gmail.com>
 <CAP+75-XQKisiLaTFXc2JuCvORkfFjfs0UPzjzyj1PrKGScR7Ow@mail.gmail.com>
In-Reply-To: <CAP+75-XQKisiLaTFXc2JuCvORkfFjfs0UPzjzyj1PrKGScR7Ow@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 17 Feb 2020 20:34:25 +0100
Message-ID: <CAPan3WqVrrbuQ2tiMr58bcd0Gie5Ym4=pXCG68trdqxmurgMcA@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] hw/arm/allwinner: add Security Identifier device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000049dab1059ecaa516"
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049dab1059ecaa516
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 11:48 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> )-.On Wed, Feb 12, 2020 at 10:31 PM Niek Linnenbank
> <nieklinnenbank@gmail.com> wrote:
> >
> > Hi Corey,
> >
> > On Thu, Feb 6, 2020 at 10:09 PM Niek Linnenbank <
> nieklinnenbank@gmail.com> wrote:
> >>
> >> Hi Corey,
> >>
> >> On Mon, Feb 3, 2020 at 2:10 PM Corey Minyard <cminyard@mvista.com>
> wrote:
> >>>
> >>> On Sun, Feb 02, 2020 at 10:27:49PM +0100, Niek Linnenbank wrote:
> >>> > Hi Corey,
> >>> >
> >>> > Thanks for reviewing!
> >>> >
> >>> > On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard <cminyard@mvista.com>
> wrote:
> >>> >
> >>> > > On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe Mathieu-Daud=
=C3=A9
> wrote:
> >>> > > > Cc'ing Corey/David for good advices about using UUID.
> >>> > >
> >>> > > Is there any reason you didn't use the built-in qemu UUID for
> this?  It
> >>> > > would simplify things in general.
> >>> > >
> >>> >
> >>> > Currently the Allwinner SID device is using the QemuUUID type from
> >>> > include/qemu/uuid.h.
> >>> > Is that the build-in UUID you are referring to or should I use
> something
> >>> > else?
> >>>
> >>> You are using the QemuUUID type, which is of course what you should d=
o,
> >>> but you aren't using the UUID generated by qemu (at least that I can
> find).
> >>> That in include/sysemu/sysemu.h and is named qemu_uuid.  Whether you
> >>> should use that or not depends on your needs.  If you just need some
> >>> uuid, then that's what you should probably use.  If you need somethin=
g
> >>> the user can individually control for this device, for instance, then
> >>> that probably won't do.
> >>
> >>
> >> Ah I did not know about the qemu_uuid variable, thanks for pointing
> that out.
> >> Basically the SID identifier is a number that is unique for each board
> that comes
> >> out of the factory. It is currently used by U-Boot to as input to
> generate a MAC address.
> >>
> >> If I understand correctly, qemu_uuid is optional and by default zero.
> >> However the SID value should not be zero, as otherwise U-Boot can't
> pick a MAC address
> >> resulting in a non-working ethernet device.
> >>
> >> Currently the hw/arm/orangepi.c machine specifies a fixed SID to be
> used for the emulated board,
> >> also containing a prefix (8100c002) that indicates the H3 chipset. One
> thing that I am strugling with is that
>
> Suggestion while reading this, you might display a warning if the user
> provided UUID doesn't start with 8100c002.
>

Yeah sure, I can add a warning for it.


>
> >> I'm not able to override the property using '-global', if
> hw/arm/orangepi.c initializes the property with qdev_prop_set_string:
> >>
> >> $ qemu-system-arm -M orangepi-pc -kernel u-boot -nographic -nic user \
> >> -global allwinner-sid.identifier=3D8100c002-0001-0002-0003-00004455668=
8
> >>
> >> If I don't set the property in hw/arm/orangepi.c, I can set it with
> '-global'. Do you perhaps have a
> >> recommendation how to improve that? Basically what is needed is that
> the machine sets the default
> >> property including the chip prefix, and that the user can override it.
> Although it is not required for a
> >> working emulated board, it would be a nice-to-have that the user can
> set it.
> >
> >
> > FYI and possibly others who have a similar usecase, I figured out how t=
o
> do this. In the machine init function,
> > after creating the new SoC object, simply check if the identifier has a
> value:
> >
> > +    if (qemu_uuid_is_null(&s->h3->sid.identifier)) {
> > +        qdev_prop_set_string(DEVICE(s->h3), "identifier",
> > +                             "8100c002-0001-0002-0003-000044556677");
>
> Similarly, display a warning "No UUID provided, using default one..."
> (or generate one 8100c002-XXX)?
>

If its allright with you, I would prefer not to display a warning for the
default behavior.
The other boards are also not displaying such warnings and it keeps the
qemu output clean.


>
> > +    }
> >
> > That way, if the user passed -global to override it, the machine will
> not overrule the user's value
> > and by default the machine sets an identifier containing the H3 specifi=
c
> chip prefix.
> >
> [...]
> >>> > > > > --- /dev/null
> >>> > > > > +++ b/hw/misc/allwinner-sid.c
> >>> > > > > @@ -0,0 +1,170 @@
> >>> > > > > +/*
> >>> > > > > + * Allwinner Security ID emulation
> >>> > > > > + *
> >>> > > > > + * Copyright (C) 2019 Niek Linnenbank <
> nieklinnenbank@gmail.com>
> >>> > > > > + *
> >>> > > > > + * This program is free software: you can redistribute it
> and/or
> >>> > > modify
> >>> > > > > + * it under the terms of the GNU General Public License as
> published
> >>> > > by
> >>> > > > > + * the Free Software Foundation, either version 2 of the
> License, or
> >>> > > > > + * (at your option) any later version.
> >>> > > > > + *
> >>> > > > > + * This program is distributed in the hope that it will be
> useful,
> >>> > > > > + * but WITHOUT ANY WARRANTY; without even the implied
> warranty of
> >>> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> the
> >>> > > > > + * GNU General Public License for more details.
> >>> > > > > + *
> >>> > > > > + * You should have received a copy of the GNU General Public
> License
> >>> > > > > + * along with this program.  If not, see <
> >>> > > http://www.gnu.org/licenses/>.
> >>> > > > > + */
> >>> > > > > +
> >>> > > > > +#include "qemu/osdep.h"
> >>> > > > > +#include "qemu/units.h"
> >>> > > > > +#include "hw/sysbus.h"
> >>> > > > > +#include "migration/vmstate.h"
> >>> > > > > +#include "qemu/log.h"
> >>> > > > > +#include "qemu/module.h"
> >>> > > > > +#include "qemu/guest-random.h"
> >>> > > > > +#include "qapi/error.h"
> >>> > > > > +#include "hw/qdev-properties.h"
> >>> > > > > +#include "hw/misc/allwinner-sid.h"
> >>> > > > > +#include "trace.h"
> >>> > > > > +
> >>> > > > > +/* SID register offsets */
> >>> > > > > +enum {
> >>> > > > > +    REG_PRCTL =3D 0x40,   /* Control */
> >>> > > > > +    REG_RDKEY =3D 0x60,   /* Read Key */
> >>> > > > > +};
> >>> > > > > +
> >>> > > > > +/* SID register flags */
> >>> > > > > +enum {
> >>> > > > > +    REG_PRCTL_WRITE   =3D 0x0002, /* Unknown write flag */
> >>> > > > > +    REG_PRCTL_OP_LOCK =3D 0xAC00, /* Lock operation */
> >>> > > > > +};
> >>> > > > > +
> >>> > > > > +static uint64_t allwinner_sid_read(void *opaque, hwaddr
> offset,
> >>> > > > > +                                   unsigned size)
> >>> > > > > +{
> >>> > > > > +    const AwSidState *s =3D AW_SID(opaque);
> >>> > > > > +    uint64_t val =3D 0;
> >>> > > > > +
> >>> > > > > +    switch (offset) {
> >>> > > > > +    case REG_PRCTL:    /* Control */
> >>> > > > > +        val =3D s->control;
> >>> > > > > +        break;
> >>> > > > > +    case REG_RDKEY:    /* Read Key */
> >>> > > > > +        val =3D s->rdkey;
> >>> > > > > +        break;
> >>> > > > > +    default:
> >>> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds
> offset
> >>> > > 0x%04x\n",
> >>> > > > > +                      __func__, (uint32_t)offset);
> >>> > > > > +        return 0;
> >>> > > > > +    }
> >>> > > > > +
> >>> > > > > +    trace_allwinner_sid_read(offset, val, size);
> >>> > > > > +
> >>> > > > > +    return val;
> >>> > > > > +}
> >>> > > > > +
> >>> > > > > +static void allwinner_sid_write(void *opaque, hwaddr offset,
> >>> > > > > +                                uint64_t val, unsigned size)
> >>> > > > > +{
> >>> > > > > +    AwSidState *s =3D AW_SID(opaque);
> >>> > > > > +
> >>> > > > > +    trace_allwinner_sid_write(offset, val, size);
> >>> > > > > +
> >>> > > > > +    switch (offset) {
> >>> > > > > +    case REG_PRCTL:    /* Control */
> >>> > > > > +        s->control =3D val;
> >>> > > > > +
> >>> > > > > +        if ((s->control & REG_PRCTL_OP_LOCK) &&
> >>> > > > > +            (s->control & REG_PRCTL_WRITE)) {
> >>> > > > > +            uint32_t id =3D s->control >> 16;
> >>> > > > > +
> >>> > > > > +            if (id < sizeof(QemuUUID)) {
> >>> > > > > +                s->rdkey =3D (s->identifier.data[id]) |
> >>> > > > > +                           (s->identifier.data[id + 1] << 8)=
 |
> >>> > > > > +                           (s->identifier.data[id + 2] << 16=
)
> |
> >>> > > > > +                           (s->identifier.data[id + 3] << 24=
);
>
> Maybe you want:
>
>   s->rdkey =3D ldl_le_p(s->identifier.data);
>

Thanks Philippe, I'll use this function to set s->rdkey.

Regards,
Niek


>
> >>> > > > > +            }
> >>> > > > > +        }
> >>> > > > > +        s->control &=3D ~REG_PRCTL_WRITE;
> >>> > > > > +        break;
> >>> > > > > +    case REG_RDKEY:    /* Read Key */
> >>> > > > > +        break;
> >>> > > > > +    default:
> >>> > > > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds
> offset
> >>> > > 0x%04x\n",
> >>> > > > > +                      __func__, (uint32_t)offset);
> >>> > > > > +        break;
> >>> > > > > +    }
> >>> > > > > +}
> > > > > > +}
> [...]
>
>

--=20
Niek Linnenbank

--00000000000049dab1059ecaa516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12, 2020 at 11:48 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">)-.On Wed, Feb 12, 2020 at 10:31 PM Niek Linnenbank<br>
&lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinne=
nbank@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Corey,<br>
&gt;<br>
&gt; On Thu, Feb 6, 2020 at 10:09 PM Niek Linnenbank &lt;<a href=3D"mailto:=
nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Corey,<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Feb 3, 2020 at 2:10 PM Corey Minyard &lt;<a href=3D"mailto=
:cminyard@mvista.com" target=3D"_blank">cminyard@mvista.com</a>&gt; wrote:<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sun, Feb 02, 2020 at 10:27:49PM +0100, Niek Linnenbank wrot=
e:<br>
&gt;&gt;&gt; &gt; Hi Corey,<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Thanks for reviewing!<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; On Mon, Jan 20, 2020 at 6:59 PM Corey Minyard &lt;<a href=
=3D"mailto:cminyard@mvista.com" target=3D"_blank">cminyard@mvista.com</a>&g=
t; wrote:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; &gt; On Sat, Jan 18, 2020 at 04:25:08PM +0100, Philippe M=
athieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt; &gt; &gt; &gt; Cc&#39;ing Corey/David for good advices about u=
sing UUID.<br>
&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt; &gt; &gt; Is there any reason you didn&#39;t use the built-in =
qemu UUID for this?=C2=A0 It<br>
&gt;&gt;&gt; &gt; &gt; would simplify things in general.<br>
&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Currently the Allwinner SID device is using the QemuUUID =
type from<br>
&gt;&gt;&gt; &gt; include/qemu/uuid.h.<br>
&gt;&gt;&gt; &gt; Is that the build-in UUID you are referring to or should =
I use something<br>
&gt;&gt;&gt; &gt; else?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You are using the QemuUUID type, which is of course what you s=
hould do,<br>
&gt;&gt;&gt; but you aren&#39;t using the UUID generated by qemu (at least =
that I can find).<br>
&gt;&gt;&gt; That in include/sysemu/sysemu.h and is named qemu_uuid.=C2=A0 =
Whether you<br>
&gt;&gt;&gt; should use that or not depends on your needs.=C2=A0 If you jus=
t need some<br>
&gt;&gt;&gt; uuid, then that&#39;s what you should probably use.=C2=A0 If y=
ou need something<br>
&gt;&gt;&gt; the user can individually control for this device, for instanc=
e, then<br>
&gt;&gt;&gt; that probably won&#39;t do.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Ah I did not know about the qemu_uuid variable, thanks for pointin=
g that out.<br>
&gt;&gt; Basically the SID identifier is a number that is unique for each b=
oard that comes<br>
&gt;&gt; out of the factory. It is currently used by U-Boot to as input to =
generate a MAC address.<br>
&gt;&gt;<br>
&gt;&gt; If I understand correctly, qemu_uuid is optional and by default ze=
ro.<br>
&gt;&gt; However the SID value should not be zero, as otherwise U-Boot can&=
#39;t pick a MAC address<br>
&gt;&gt; resulting in a non-working ethernet device.<br>
&gt;&gt;<br>
&gt;&gt; Currently the hw/arm/orangepi.c machine specifies a fixed SID to b=
e used for the emulated board,<br>
&gt;&gt; also containing a prefix (8100c002) that indicates the H3 chipset.=
 One thing that I am strugling with is that<br>
<br>
Suggestion while reading this, you might display a warning if the user<br>
provided UUID doesn&#39;t start with 8100c002.<br></blockquote><div><br></d=
iv><div>Yeah sure, I can add a warning for it.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; I&#39;m not able to override the property using &#39;-global&#39;,=
 if hw/arm/orangepi.c initializes the property with qdev_prop_set_string:<b=
r>
&gt;&gt;<br>
&gt;&gt; $ qemu-system-arm -M orangepi-pc -kernel u-boot -nographic -nic us=
er \<br>
&gt;&gt; -global allwinner-sid.identifier=3D8100c002-0001-0002-0003-0000445=
56688<br>
&gt;&gt;<br>
&gt;&gt; If I don&#39;t set the property in hw/arm/orangepi.c, I can set it=
 with &#39;-global&#39;. Do you perhaps have a<br>
&gt;&gt; recommendation how to improve that? Basically what is needed is th=
at the machine sets the default<br>
&gt;&gt; property including the chip prefix, and that the user can override=
 it. Although it is not required for a<br>
&gt;&gt; working emulated board, it would be a nice-to-have that the user c=
an set it.<br>
&gt;<br>
&gt;<br>
&gt; FYI and possibly others who have a similar usecase, I figured out how =
to do this. In the machine init function,<br>
&gt; after creating the new SoC object, simply check if the identifier has =
a value:<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (qemu_uuid_is_null(&amp;s-&gt;h3-&gt;sid.identifier)=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(s-&gt;h3), &q=
uot;identifier&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;8100c002-0001-0002-0003-0000445566=
77&quot;);<br>
<br>
Similarly, display a warning &quot;No UUID provided, using default one...&q=
uot;<br>
(or generate one 8100c002-XXX)?<br></blockquote><div><br></div><div>If its =
allright with you, I would prefer not to display a warning for the default =
behavior.</div><div>The other boards are also not displaying such warnings =
and it keeps the qemu output clean.<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; That way, if the user passed -global to override it, the machine will =
not overrule the user&#39;s value<br>
&gt; and by default the machine sets an identifier containing the H3 specif=
ic chip prefix.<br>
&gt;<br>
[...]<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; --- /dev/null<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +++ b/hw/misc/allwinner-sid.c<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; @@ -0,0 +1,170 @@<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +/*<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * Allwinner Security ID emulation<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + *<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * Copyright (C) 2019 Niek Linnenbank &lt=
;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenba=
nk@gmail.com</a>&gt;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + *<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * This program is free software: you can=
 redistribute it and/or<br>
&gt;&gt;&gt; &gt; &gt; modify<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * it under the terms of the GNU General =
Public License as published<br>
&gt;&gt;&gt; &gt; &gt; by<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * the Free Software Foundation, either v=
ersion 2 of the License, or<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * (at your option) any later version.<br=
>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + *<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * This program is distributed in the hop=
e that it will be useful,<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * but WITHOUT ANY WARRANTY; without even=
 the implied warranty of<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE.=C2=A0 See the<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * GNU General Public License for more de=
tails.<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + *<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * You should have received a copy of the=
 GNU General Public License<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + * along with this program.=C2=A0 If not,=
 see &lt;<br>
&gt;&gt;&gt; &gt; &gt; <a href=3D"http://www.gnu.org/licenses/" rel=3D"nore=
ferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;.<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; + */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;qemu/units.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;migration/vmstate.h&quot;<=
br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;qemu/log.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;qemu/module.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;qemu/guest-random.h&quot;<=
br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;hw/qdev-properties.h&quot;=
<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;hw/misc/allwinner-sid.h&qu=
ot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +#include &quot;trace.h&quot;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +/* SID register offsets */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +enum {<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL =3D 0x40,=C2=A0 =
=C2=A0/* Control */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_RDKEY =3D 0x60,=C2=A0 =
=C2=A0/* Read Key */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +};<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +/* SID register flags */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +enum {<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL_WRITE=C2=A0 =C2=
=A0=3D 0x0002, /* Unknown write flag */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 REG_PRCTL_OP_LOCK =3D 0xAC0=
0, /* Lock operation */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +};<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +static uint64_t allwinner_sid_read(void *=
opaque, hwaddr offset,<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0unsigned size)<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +{<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 const AwSidState *s =3D AW_=
SID(opaque);<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=
=A0 /* Control */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt=
;control;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=
=A0 /* Read Key */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s-&gt=
;rdkey;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask=
(LOG_GUEST_ERROR, &quot;%s: out-of-bounds offset<br>
&gt;&gt;&gt; &gt; &gt; 0x%04x\n&quot;,<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_sid_read(of=
fset, val, size);<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return val;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +}<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +static void allwinner_sid_write(void *opa=
que, hwaddr offset,<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
64_t val, unsigned size)<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +{<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AwSidState *s =3D AW_SID(op=
aque);<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_sid_write(o=
ffset, val, size);<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_PRCTL:=C2=A0 =C2=
=A0 /* Control */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control=
 =3D val;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;co=
ntrol &amp; REG_PRCTL_OP_LOCK) &amp;&amp;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (s-&gt;control &amp; REG_PRCTL_WRITE)) {<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 uint32_t id =3D s-&gt;control &gt;&gt; 16;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (id &lt; sizeof(QemuUUID)) {<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 s-&gt;rdkey =3D (s-&gt;identifier.data[id]) |<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.d=
ata[id + 1] &lt;&lt; 8) |<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.d=
ata[id + 2] &lt;&lt; 16) |<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;identifier.d=
ata[id + 3] &lt;&lt; 24);<br>
<br>
Maybe you want:<br>
<br>
=C2=A0 s-&gt;rdkey =3D ldl_le_p(s-&gt;identifier.data);<br></blockquote><di=
v><br></div><div>Thanks Philippe, I&#39;ll use this function to set s-&gt;r=
dkey.</div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;control=
 &amp;=3D ~REG_PRCTL_WRITE;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case REG_RDKEY:=C2=A0 =C2=
=A0 /* Read Key */<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask=
(LOG_GUEST_ERROR, &quot;%s: out-of-bounds offset<br>
&gt;&gt;&gt; &gt; &gt; 0x%04x\n&quot;,<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt; &gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; &gt; +}<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000049dab1059ecaa516--

