Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B09C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481AD206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8SynKuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481AD206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGSkg-0000Qk-GM
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jGSjy-0008J3-An
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jGSjw-0003xi-W3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:28:02 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jGSjw-0003wy-PW; Mon, 23 Mar 2020 15:28:00 -0400
Received: by mail-io1-xd41.google.com with SMTP id e20so15192870ios.12;
 Mon, 23 Mar 2020 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=baIBv6VF/SVGWRh9jRcClqoT54bPPkrrJgnnfOBWU2c=;
 b=W8SynKuL1AAaNKs8S8jnH/IwC3oeF28oNv6TNJpynNpcrtM8uJHcQZ/PvDxySKRMwW
 TN6Fc4HwDtEWOtN3zdu2MvaRMEus2RsWy6vbvfDGrpRhrA82Pxlo2fanHJr4wGRIOp10
 4M5PrV1WYG0vgPJKNVvQvFjLoc/XXfL99NhZVl9fjzwiLsWBUwzDtJ3RMnR1edFMUM+2
 AS0B20hVi5v2gmA3YvTnhZ05xHgWzdnXXnZPGyCimCgl7FLznllyqlrezGnlG3cOpGVc
 BdcNUm1pkmRI+scyWMl1HgOgexknA5SzukAbQhqOqDR5lf4lxvToecC1GVt5xLaN7ro0
 4oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=baIBv6VF/SVGWRh9jRcClqoT54bPPkrrJgnnfOBWU2c=;
 b=g0IfDP3TFdWZFcSViPbPXNT/htadGTxK+kH7exafHeRirJxl+FgDb1dyjPKpN6Z+r3
 RcqcMpVOBhAJQUitX92bJtt2E2Re9siqNPhN2rXRnN6nWx99HP/aPwHQP4RT3ISSMyai
 7U9L7Ih/P09G9hEGCuaYyHmjqi/eb93fyr163JVbgXe/MEvRCdlgzrOAKdZSi3rhPg3G
 uJLL+63xZ51xETBiXnBIomc7WEJlkoDtJEEBjpvZWTzCoWQ/g/Z9Ec36LwZW+OWEcll/
 ezsJNq211sHeo2CpP3qDaIbarIaz/KtqnJwIW4RNZeu1oQbVXKi/swEfX2VXRIPaLKlg
 SVrw==
X-Gm-Message-State: ANhLgQ1eZM12s/gnVg0zAMxE6OUGgeIwGMpHJn3itj1YBrLYSA4GokV/
 W7hDssLSnUaM8iifnk3sdMFgBQl35NYveI0PBJ4=
X-Google-Smtp-Source: ADFU+vvt2D/XmzEebgpPJJ0tGrP3NvXB48cKwEYFGXbrtoyXL2M59G7rpYM32CoPZg3jrAsmZWaHdAj5CdWsm5ru0BM=
X-Received: by 2002:a02:6669:: with SMTP id l41mr10776576jaf.126.1584991679835; 
 Mon, 23 Mar 2020 12:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200322205439.15231-1-nieklinnenbank@gmail.com>
 <20200322205439.15231-2-nieklinnenbank@gmail.com>
 <CAFEAcA-dr4_tTevqJmjEy1_W5Thv1c+8ETf=-R2jTeBp-1HmOw@mail.gmail.com>
In-Reply-To: <CAFEAcA-dr4_tTevqJmjEy1_W5Thv1c+8ETf=-R2jTeBp-1HmOw@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 23 Mar 2020 20:27:48 +0100
Message-ID: <CAPan3WrOTm2pS+9y4TSUf+z5kvkCemsnP0h-Ejm=06Fr1iyKBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/misc/allwinner-h3-dramc: enforce 64-bit multiply
 when calculating row mirror address
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000c760d05a18aa275"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

--0000000000000c760d05a18aa275
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Sun, Mar 22, 2020 at 10:18 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sun, 22 Mar 2020 at 20:54, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >
> > The allwinner_h3_dramc_map_rows function simulates row addressing
> behavior
> > when bootloader software attempts to detect the amount of available
> SDRAM.
> >
> > Currently the line that calculates the 64-bit address of the mirrored row
> > uses a signed 32-bit multiply operation that in theory could result in
> the
> > upper 32-bit be all 1s. This commit ensures that the row mirror address
> > is calculated using only 64-bit operations.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >  hw/misc/allwinner-h3-dramc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
> > index 2b5260260e..f9f05b5384 100644
> > --- a/hw/misc/allwinner-h3-dramc.c
> > +++ b/hw/misc/allwinner-h3-dramc.c
> > @@ -85,8 +85,8 @@ static void
> allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
> >
> >      } else if (row_bits_actual) {
> >          /* Row bits not matching ram_size, install the rows mirror */
> > -        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
> > -                                                  bank_bits)) *
> page_size);
> > +        hwaddr row_mirror = s->ram_addr + ((1UL << (row_bits_actual +
> > +                                                    bank_bits)) *
> page_size);
>
> This needs to be a "ULL" suffix... (I just sent a different email
> with the rationale).
>

Ah ofcourse, it should be ULL indeed. And I can't think of any reason why I
made this mistake.
I simply overlooked it, thanks. I'm resending this patch with the proper
ULL suffix.

Regards,
Niek


>
> thanks
> -- PMM
>


-- 
Niek Linnenbank

--0000000000000c760d05a18aa275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Peter,<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 22, 2020 at 10:1=
8 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.ma=
ydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Sun, 22 Mar 2020 at 20:54, Niek Linnenbank &lt;<a href=
=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail=
.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The allwinner_h3_dramc_map_rows function simulates row addressing beha=
vior<br>
&gt; when bootloader software attempts to detect the amount of available SD=
RAM.<br>
&gt;<br>
&gt; Currently the line that calculates the 64-bit address of the mirrored =
row<br>
&gt; uses a signed 32-bit multiply operation that in theory could result in=
 the<br>
&gt; upper 32-bit be all 1s. This commit ensures that the row mirror addres=
s<br>
&gt; is calculated using only 64-bit operations.<br>
&gt;<br>
&gt; Reported-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/misc/allwinner-h3-dramc.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc=
.c<br>
&gt; index 2b5260260e..f9f05b5384 100644<br>
&gt; --- a/hw/misc/allwinner-h3-dramc.c<br>
&gt; +++ b/hw/misc/allwinner-h3-dramc.c<br>
&gt; @@ -85,8 +85,8 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlS=
tate *s, uint8_t row_bits,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else if (row_bits_actual) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Row bits not matching ram_size, i=
nstall the rows mirror */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr row_mirror =3D s-&gt;ram_addr + ((=
1 &lt;&lt; (row_bits_actual +<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank_bits)) * page_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr row_mirror =3D s-&gt;ram_addr + ((=
1UL &lt;&lt; (row_bits_actual +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank_bits)) * page_size);<br>
<br>
This needs to be a &quot;ULL&quot; suffix... (I just sent a different email=
<br>
with the rationale).<br></blockquote><div><br></div><div>Ah ofcourse, it sh=
ould be ULL indeed. And I can&#39;t think of any reason why I made this mis=
take.</div><div>I simply overlooked it, thanks. I&#39;m resending this patc=
h with the proper ULL suffix.</div><div><br></div><div>Regards,</div><div>N=
iek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000000c760d05a18aa275--

