Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21837C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7D5214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkInd3WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7D5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEeK-0000zJ-Vh
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igEXR-0001rQ-QN
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igEXQ-0005Ug-4M
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:01:21 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igEXP-0005Qs-Rr; Sat, 14 Dec 2019 16:01:20 -0500
Received: by mail-il1-x144.google.com with SMTP id g12so2391745ild.2;
 Sat, 14 Dec 2019 13:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sXWObjGl6OXDF8vN7Nqi0HgJ+038kWVON6shVGrmC1c=;
 b=CkInd3WLl4a51MtgtS6zQTWZ7yMlPbWRXrd3iJUTv5NfUuPuapCJ4p0fgebx77p6Yh
 L9c1mEhLw0aMf5ay7e7ukJghXAaiDmBoYW5XsAYiJoLQM3HimU/MxtkVVPyzP0ZFczHu
 wSaXXGvUeKjpfuua7BHoB8Q86l/E7AgqJ51SwAMlX7AkmDn7Xevsz6UohOWxtU+OMbVf
 kkesjzw3qYmczaLkLsqX2B6guPS1LRuRu0wHe35yZrFMUJ4vK2OfBOABj6FXxuZwFIgP
 6+Bex16D0CGOnsiB9+BOp6wz6cnyywlRzg7o1eSdrXW8S0uslujVq+tfR1dVkpQSvzo/
 zzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sXWObjGl6OXDF8vN7Nqi0HgJ+038kWVON6shVGrmC1c=;
 b=CL7ZYI4i/uYP5DostDVPb44Vv1dziospi2Q/tM9DOoPB65GTfn5+mVpLIrHmQ/Pcwu
 HZzsHurXWXNpgbPfxmNUKCekHQbaJrKE2GaMLd/r7BcQz2m3kjSyDREHgcKzh+D5ndZe
 AyGh0z3Tn3REIDWYhR7hjw3MsyZvtYIgwxQoLAyjjMrlwNefAOObPIHKm6ykHA8TVfAM
 8I6XUprMj7tUaLucrAoeBrv41we7XjDV8pXxyPxP1SBPpDFPIv3ZwvZuXBJoRaOIebT+
 jZN3nGDJi8fTM1m3pFYhqpccMgUw9G19P/ibse1BBDzcXpvwILwyKbZub5une/wBy7NH
 m/Pw==
X-Gm-Message-State: APjAAAW9v56kIoO1tnfumdUwytTqf3Y8RH/c8mESC5OuSrVFnvcyp8Be
 FfvQQgGlhkSUMP2dZTAy3/7BK6NohklDVfHbVpR6xQ==
X-Google-Smtp-Source: APXvYqw8q1mlKhmAF2iTgALI0Y9x9CQqCZmXjzTNgOxbnywffKma10PDNXO+RgCD+gX/HQmLS5s/jZNYLfdCkxPPBXs=
X-Received: by 2002:a92:d203:: with SMTP id y3mr5682158ily.28.1576355542949;
 Sat, 14 Dec 2019 12:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
 <CAPan3Woq_EJAE6s-N5dAApAgzexGr4M-OtFkiHuMN_Xp=8_bTQ@mail.gmail.com>
 <457e0620-c11e-8e5a-df1c-93f95f52eda8@redhat.com>
In-Reply-To: <457e0620-c11e-8e5a-df1c-93f95f52eda8@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 14 Dec 2019 21:32:11 +0100
Message-ID: <CAPan3Won=aRx29SBJxvGTfRTUqL_R4txS4VF2hQ6eZ4QRSGxWw@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002d63fc0599afe013"
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002d63fc0599afe013
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2019 at 2:59 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/13/19 10:00 PM, Niek Linnenbank wrote:
> > On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     Hi Niek,
> >
> >     On 12/11/19 11:34 PM, Niek Linnenbank wrote:
> >      > Ping!
> >      >
> >      > Anyone would like to comment on this driver?
> >      >
> >      > I finished the rework on all previous comments in this series.
> >      >
> >      > Currently debugging the hflags error reported by Philippe.
> >      > After that, I'm ready to send out v2 of these patches.
> >      >
> >      > Regards,
> >      > Niek
> >      >
> >      > On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenbank
> >      > <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>
> >     <mailto:nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>>=
>
> >     wrote:
> >      >
> >      >     The Allwinner H3 System on Chip contains an integrated stora=
ge
> >      >     controller for Secure Digital (SD) and Multi Media Card (MMC=
)
> >      >     interfaces. This commit adds support for the Allwinner H3
> >      >     SD/MMC storage controller with the following emulated
> features:
> >      >
> >      >       * DMA transfers
> >      >       * Direct FIFO I/O
> >      >       * Short/Long format command responses
> >      >       * Auto-Stop command (CMD12)
> >      >       * Insert & remove card detection
> >      >
> >      >     Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>
> >      >     <mailto:nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>>
> >      >     ---
> >      >       hw/arm/allwinner-h3.c               |  20 +
> >      >       hw/arm/orangepi.c                   |  17 +
> >      >       hw/sd/Makefile.objs                 |   1 +
> >      >       hw/sd/allwinner-h3-sdhost.c         | 791
> >     ++++++++++++++++++++++++++++
> >      >       hw/sd/trace-events                  |   7 +
> >      >       include/hw/arm/allwinner-h3.h       |   2 +
> >      >       include/hw/sd/allwinner-h3-sdhost.h |  73 +++
> >      >       7 files changed, 911 insertions(+)
> >      >       create mode 100644 hw/sd/allwinner-h3-sdhost.c
> >      >       create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
> [...]
> > Thanks again for all of your helpful comments Philippe!
> > I've started to rework the patch.
> >
> > One question about adding tags in the commit message: should I
> > already add 'Reviewed-by: ' when I re-send v2 of this patch? Or should
> > that be added after you have seen the v2 changes?
>
> You shouldn't add the Reviewed-by tag until explicitly given by the
> reviewer. If the changes are trivial, it is easy to conditionally give
> the tag such "If ... is done: R-b", "With ... fixed: R-b".
>

OK, thanks for clarifying, I'll keep that in mind.


>
> Since this is your first contribution, I have been more careful. Also
> since your patch is already of very good quality, I'v been a bit picky
> regarding few details.
>

Sure, that makes sense indeed. And I very much appreciate your feedback
Philippe,
so please keep doing that, even about the small details ;-)


>
> Since there are too many comments, so I prefer to fully review the v2 of
> this patch again.
>
> Yes, true indeed.

Regards,
Niek


> Regards,
>
> Phil.
>
>

--=20
Niek Linnenbank

--0000000000002d63fc0599afe013
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Dec 14, 2019 at 2:59 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 12/13/19 10:00 PM, Niek Linnenbank wrote:<br>
&gt; On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Niek,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/11/19 11:34 PM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Ping!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Anyone would like to comment on this driver?<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I finished the rework on all previous comment=
s in this series.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Currently debugging the hflags error reported=
 by Philippe.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; After that, I&#39;m ready to send out v2 of t=
hese patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Niek<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenba=
nk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;<a href=3D"mailto:nieklinnenbank@gmail.co=
m" target=3D"_blank">nieklinnenbank@gmail.com</a> &lt;mailto:<a href=3D"mai=
lto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a> &lt;mailto:<a href=3D"ma=
ilto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</=
a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0The Allwinner H3 System on=
 Chip contains an integrated storage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0controller for Secure Digi=
tal (SD) and Multi Media Card (MMC)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0interfaces. This commit ad=
ds support for the Allwinner H3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0SD/MMC storage controller =
with the following emulated features:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA transfers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Direct FIFO I/O<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Short/Long format=
 command responses<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Auto-Stop command=
 (CMD12)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Insert &amp; remo=
ve card detection<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Niek Linnen=
bank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">niek=
linnenbank@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/arm/allwinner-h3=
.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/arm/orangepi.c=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 17 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/sd/Makefile.objs=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/sd/allwinner-h3-=
sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 791<br>
&gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/sd/trace-events=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A07 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/arm/allw=
inner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/sd/allwi=
nner-h3-sdhost.h |=C2=A0 73 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A07 files changed, 91=
1 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 =
hw/sd/allwinner-h3-sdhost.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 =
include/hw/sd/allwinner-h3-sdhost.h<br>
[...]<br>
&gt; Thanks again for all of your helpful comments Philippe!<br>
&gt; I&#39;ve started to rework the patch.<br>
&gt; <br>
&gt; One question about adding tags in the commit message: should I<br>
&gt; already add &#39;Reviewed-by: &#39; when I re-send v2 of this patch? O=
r should<br>
&gt; that be added after you have seen the v2 changes?<br>
<br>
You shouldn&#39;t add the Reviewed-by tag until explicitly given by the <br=
>
reviewer. If the changes are trivial, it is easy to conditionally give <br>
the tag such &quot;If ... is done: R-b&quot;, &quot;With ... fixed: R-b&quo=
t;.<br></blockquote><div><br></div><div>OK, thanks for clarifying, I&#39;ll=
 keep that in mind.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
Since this is your first contribution, I have been more careful. Also <br>
since your patch is already of very good quality, I&#39;v been a bit picky =
<br>
regarding few details.<br></blockquote><div>=C2=A0</div><div>Sure, that mak=
es sense indeed. And I very much appreciate your feedback Philippe,</div><d=
iv>so please keep doing that, even about the small details ;-)<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Since there are too many comments, so I prefer to fully review the v2 of <b=
r>
this patch again.<br>
<br></blockquote><div>Yes, true indeed.<br></div><div><br></div><div>Regard=
s,</div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000002d63fc0599afe013--

