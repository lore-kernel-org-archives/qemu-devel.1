Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED07C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E52206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjgW/Vkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E52206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9P8-0001sd-Px
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1kT9N7-0000fu-KF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:57:09 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1kT9N5-0008Fb-CG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:57:09 -0400
Received: by mail-qk1-x744.google.com with SMTP id s14so130698qkg.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Faxp1yfdn5rIQZrOuBIIO6wrhr5De7Qra4k5sPWnqOY=;
 b=NjgW/VkgDLTIC6tvSBJCM8rLMSIy0cISvEpGy7Ggl5FqLNdY4zbCapmi0GMjVcB8vT
 O4lawZhSHHIxYocz/NWCNQRyBLXjLCVpfpoOW6BuXNQqpiec1y7xrACY/DcWvyI/mg63
 iMTMTiZ7UhkpJwJ6jgh2CPSXqaISHrz+Nbi1VO4jgQIjk3eob9V1Jdn7RZ7TbRGftbyc
 K0HeXJgukrGvXAAN1spqvJZPdCPP5Ysc+ENWGF+/YEGABcvrwu1qAd5pZ7+jRzeQkX9E
 IKfVkO9LTCCBfnbnKI6XEHndl5j5rzDbnEErWrVEInypU6MUbfWIlrKFpYHtP1mnh4jy
 Jrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Faxp1yfdn5rIQZrOuBIIO6wrhr5De7Qra4k5sPWnqOY=;
 b=Cpcapbe4pea98sGuLiJgksAPWbBWjSHcXrn1TCTJC9LOfduJILwxymG+bUc1gYMl4X
 ixxcDqOnTitbtGuZJcQd60TGlOBFwBbye5hnSNts3QyJXLeXdNSH3vjdiBPu/Z438K6G
 7z7NZSKARKkXrldcpobyca4/xPnzdlGrs43yyH0V+PP3f58DbXskRiGWaM/y/PqgQiOy
 kMPCS1GRYEe4PhP5M9VZ3IxT8F9kGb/UxwV66JYPJuZoFSXgJ4AQj51omEoopeLKHF7c
 sG3DD+Be7wWmJ2YpmhOTMavayO36p7adL04cvvrOCml4SmsA1gnMrK5CbAmcvGU/d9nw
 BKQw==
X-Gm-Message-State: AOAM530g5UYAhW1K6rX4RrAbyjVWhsQmVGFnZtoBItzeBgB0iE8xgkg9
 947XqW7QZH2IjM/RUZLT9yPF24Koq+q8ZE2B71g=
X-Google-Smtp-Source: ABdhPJwPrZE5U1PyYZ7oA6AYl2+nhVZV0IDQD07Hk2zdd0KcGWc/4rcbfjvOh1vFkQp/2Ey4b5vCnSAqdCrIYMnFdvE=
X-Received: by 2002:a37:48c6:: with SMTP id v189mr493897qka.378.1602791826100; 
 Thu, 15 Oct 2020 12:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201004182506.2038515-1-f4bug@amsat.org>
 <CALHRZuoJpFNOJ+PDMPQvu4B+sCB3=3S03ieL99Y7tZwVmBS03w@mail.gmail.com>
In-Reply-To: <CALHRZuoJpFNOJ+PDMPQvu4B+sCB3=3S03ieL99Y7tZwVmBS03w@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 15 Oct 2020 22:56:17 +0300
Message-ID: <CAK4993h-V8RkG70+pVR35iLA3RJDn7SNZ_fw44Ez9YwR5fu31w@mail.gmail.com>
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000071966505b1bb0d0f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=mrolnik@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: James Hogan <jhogan@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Sven Schnelle <svens@stackframe.org>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, David Carlier <devnexen@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000071966505b1bb0d0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Michael Rolnik <mrolnik@gmail.com <pauldzim@gmail.com>>

On Mon, Oct 12, 2020 at 8:56 AM sundeep subbaraya <sundeep.lkml@gmail.com>
wrote:

> Acked-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>
> Thanks,
> Sundeep
>
> On Sun, Oct 4, 2020 at 11:55 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> wrote:
> >
> > These individual contributors have a number of contributions,
> > add them to the 'individual' group map.
> >
> > Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Cc: Alistair Francis <alistair@alistair23.me>
> > Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> > Cc: David Carlier <devnexen@gmail.com>
> > Cc: Finn Thain <fthain@telegraphics.com.au>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> > Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n <dirty.ice.hu@gmail.com>
> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: Michael Rolnik <mrolnik@gmail.com>
> > Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Paul Zimmerman <pauldzim@gmail.com>
> > Cc: Stefan Weil <sw@weilnetz.de>
> > Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > Cc: Sven Schnelle <svens@stackframe.org>
> > Cc: Thomas Huth <huth@tuxfamily.org>
> > Cc: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > To the developers Cc'ed: If you agree with your entry, please
> > reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> > care, please either reply with Nack-by or ignore this patch.
> > I'll repost in 2 weeks as formal patch (not RFC) with only the
> > entries acked by their author.
> > ---
> >  contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++
> >  contrib/gitdm/group-map-redhat      |  1 -
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/gitdm/group-map-individuals
> b/contrib/gitdm/group-map-individuals
> > index cf8a2ce367..b478fd4576 100644
> > --- a/contrib/gitdm/group-map-individuals
> > +++ b/contrib/gitdm/group-map-individuals
> > @@ -16,3 +16,25 @@ aurelien@aurel32.net
> >  balaton@eik.bme.hu
> >  e.emanuelegiuseppe@gmail.com
> >  andrew.smirnov@gmail.com
> > +sw@weilnetz.de
> > +huth@tuxfamily.org
> > +laurent@vivier.eu
> > +atar4qemu@gmail.com
> > +hpoussin@reactos.org
> > +deller@gmx.de
> > +alistair@alistair23.me
> > +fthain@telegraphics.com.au
> > +svens@stackframe.org
> > +aleksandar.qemu.devel@gmail.com
> > +jhogan@kernel.org
> > +paulburton@kernel.org
> > +vr_qemu@t-online.de
> > +nieklinnenbank@gmail.com
> > +devnexen@gmail.com
> > +jcd@tribudubois.net
> > +dirty.ice.hu@gmail.com
> > +mrolnik@gmail.com
> > +pauldzim@gmail.com
> > +linux@roeck-us.net
> > +sundeep.lkml@gmail.com
> > +ahmedkhaledkaraman@gmail.com
> > diff --git a/contrib/gitdm/group-map-redhat
> b/contrib/gitdm/group-map-redhat
> > index d15db2d35e..4a8ca84b36 100644
> > --- a/contrib/gitdm/group-map-redhat
> > +++ b/contrib/gitdm/group-map-redhat
> > @@ -3,6 +3,5 @@
> >  #
> >
> >  david@gibson.dropbear.id.au
> > -laurent@vivier.eu
> >  pjp@fedoraproject.org
> >  armbru@pond.sub.org
> > --
> > 2.26.2
> >
>


--=20
Best Regards,
Michael Rolnik

--00000000000071966505b1bb0d0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:sans-serif;font-size:12.8px">Ac=
ked-<span class=3D"gmail-il">by</span>: Michael Rolnik &lt;mrolnik</span><a=
 href=3D"mailto:pauldzim@gmail.com" target=3D"_blank" style=3D"color:rgb(66=
,133,244);text-decoration-line:none;font-family:sans-serif;font-size:12.8px=
">@gmail.com</a><span style=3D"font-family:sans-serif;font-size:12.8px">&gt=
;</span><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Mon, Oct 12, 2020 at 8:56 AM sundeep subbaraya &lt;<a href=
=3D"mailto:sundeep.lkml@gmail.com">sundeep.lkml@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Acked-by: Subbaray=
a Sundeep &lt;<a href=3D"mailto:sundeep.lkml@gmail.com" target=3D"_blank">s=
undeep.lkml@gmail.com</a>&gt;<br>
<br>
Thanks,<br>
Sundeep<br>
<br>
On Sun, Oct 4, 2020 at 11:55 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"=
mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wrote:<br=
>
&gt;<br>
&gt; These individual contributors have a number of contributions,<br>
&gt; add them to the &#39;individual&#39; group map.<br>
&gt;<br>
&gt; Cc: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" =
target=3D"_blank">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
&gt; Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gm=
ail.com" target=3D"_blank">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
&gt; Cc: Alistair Francis &lt;<a href=3D"mailto:alistair@alistair23.me" tar=
get=3D"_blank">alistair@alistair23.me</a>&gt;<br>
&gt; Cc: Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com" target=
=3D"_blank">atar4qemu@gmail.com</a>&gt;<br>
&gt; Cc: David Carlier &lt;<a href=3D"mailto:devnexen@gmail.com" target=3D"=
_blank">devnexen@gmail.com</a>&gt;<br>
&gt; Cc: Finn Thain &lt;<a href=3D"mailto:fthain@telegraphics.com.au" targe=
t=3D"_blank">fthain@telegraphics.com.au</a>&gt;<br>
&gt; Cc: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"=
_blank">linux@roeck-us.net</a>&gt;<br>
&gt; Cc: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" target=3D"_blank=
">deller@gmx.de</a>&gt;<br>
&gt; Cc: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.org" =
target=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
&gt; Cc: James Hogan &lt;<a href=3D"mailto:jhogan@kernel.org" target=3D"_bl=
ank">jhogan@kernel.org</a>&gt;<br>
&gt; Cc: Jean-Christophe Dubois &lt;<a href=3D"mailto:jcd@tribudubois.net" =
target=3D"_blank">jcd@tribudubois.net</a>&gt;<br>
&gt; Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n &lt;<a href=3D"mailto:dirty.ice.=
hu@gmail.com" target=3D"_blank">dirty.ice.hu@gmail.com</a>&gt;<br>
&gt; Cc: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"=
_blank">laurent@vivier.eu</a>&gt;<br>
&gt; Cc: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"=
_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Cc: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" ta=
rget=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; Cc: Paul Burton &lt;<a href=3D"mailto:paulburton@kernel.org" target=3D=
"_blank">paulburton@kernel.org</a>&gt;<br>
&gt; Cc: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com" target=3D=
"_blank">pauldzim@gmail.com</a>&gt;<br>
&gt; Cc: Stefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank=
">sw@weilnetz.de</a>&gt;<br>
&gt; Cc: Subbaraya Sundeep &lt;<a href=3D"mailto:sundeep.lkml@gmail.com" ta=
rget=3D"_blank">sundeep.lkml@gmail.com</a>&gt;<br>
&gt; Cc: Sven Schnelle &lt;<a href=3D"mailto:svens@stackframe.org" target=
=3D"_blank">svens@stackframe.org</a>&gt;<br>
&gt; Cc: Thomas Huth &lt;<a href=3D"mailto:huth@tuxfamily.org" target=3D"_b=
lank">huth@tuxfamily.org</a>&gt;<br>
&gt; Cc: Volker R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de" tar=
get=3D"_blank">vr_qemu@t-online.de</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt; ---<br>
&gt; To the developers Cc&#39;ed: If you agree with your entry, please<br>
&gt; reply with a Reviewed-by/Acked-by tag. If you disagree or doesn&#39;t<=
br>
&gt; care, please either reply with Nack-by or ignore this patch.<br>
&gt; I&#39;ll repost in 2 weeks as formal patch (not RFC) with only the<br>
&gt; entries acked by their author.<br>
&gt; ---<br>
&gt;=C2=A0 contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++<=
br>
&gt;=C2=A0 contrib/gitdm/group-map-redhat=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<b=
r>
&gt;=C2=A0 2 files changed, 22 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group=
-map-individuals<br>
&gt; index cf8a2ce367..b478fd4576 100644<br>
&gt; --- a/contrib/gitdm/group-map-individuals<br>
&gt; +++ b/contrib/gitdm/group-map-individuals<br>
&gt; @@ -16,3 +16,25 @@ <a href=3D"mailto:aurelien@aurel32.net" target=3D"_=
blank">aurelien@aurel32.net</a><br>
&gt;=C2=A0 <a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@=
eik.bme.hu</a><br>
&gt;=C2=A0 <a href=3D"mailto:e.emanuelegiuseppe@gmail.com" target=3D"_blank=
">e.emanuelegiuseppe@gmail.com</a><br>
&gt;=C2=A0 <a href=3D"mailto:andrew.smirnov@gmail.com" target=3D"_blank">an=
drew.smirnov@gmail.com</a><br>
&gt; +<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank">sw@weilnetz.de</a=
><br>
&gt; +<a href=3D"mailto:huth@tuxfamily.org" target=3D"_blank">huth@tuxfamil=
y.org</a><br>
&gt; +<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">laurent@vivier=
.eu</a><br>
&gt; +<a href=3D"mailto:atar4qemu@gmail.com" target=3D"_blank">atar4qemu@gm=
ail.com</a><br>
&gt; +<a href=3D"mailto:hpoussin@reactos.org" target=3D"_blank">hpoussin@re=
actos.org</a><br>
&gt; +<a href=3D"mailto:deller@gmx.de" target=3D"_blank">deller@gmx.de</a><=
br>
&gt; +<a href=3D"mailto:alistair@alistair23.me" target=3D"_blank">alistair@=
alistair23.me</a><br>
&gt; +<a href=3D"mailto:fthain@telegraphics.com.au" target=3D"_blank">fthai=
n@telegraphics.com.au</a><br>
&gt; +<a href=3D"mailto:svens@stackframe.org" target=3D"_blank">svens@stack=
frame.org</a><br>
&gt; +<a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_blank">=
aleksandar.qemu.devel@gmail.com</a><br>
&gt; +<a href=3D"mailto:jhogan@kernel.org" target=3D"_blank">jhogan@kernel.=
org</a><br>
&gt; +<a href=3D"mailto:paulburton@kernel.org" target=3D"_blank">paulburton=
@kernel.org</a><br>
&gt; +<a href=3D"mailto:vr_qemu@t-online.de" target=3D"_blank">vr_qemu@t-on=
line.de</a><br>
&gt; +<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">nieklin=
nenbank@gmail.com</a><br>
&gt; +<a href=3D"mailto:devnexen@gmail.com" target=3D"_blank">devnexen@gmai=
l.com</a><br>
&gt; +<a href=3D"mailto:jcd@tribudubois.net" target=3D"_blank">jcd@tribudub=
ois.net</a><br>
&gt; +<a href=3D"mailto:dirty.ice.hu@gmail.com" target=3D"_blank">dirty.ice=
.hu@gmail.com</a><br>
&gt; +<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.=
com</a><br>
&gt; +<a href=3D"mailto:pauldzim@gmail.com" target=3D"_blank">pauldzim@gmai=
l.com</a><br>
&gt; +<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-u=
s.net</a><br>
&gt; +<a href=3D"mailto:sundeep.lkml@gmail.com" target=3D"_blank">sundeep.l=
kml@gmail.com</a><br>
&gt; +<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blank">ahm=
edkhaledkaraman@gmail.com</a><br>
&gt; diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-=
redhat<br>
&gt; index d15db2d35e..4a8ca84b36 100644<br>
&gt; --- a/contrib/gitdm/group-map-redhat<br>
&gt; +++ b/contrib/gitdm/group-map-redhat<br>
&gt; @@ -3,6 +3,5 @@<br>
&gt;=C2=A0 #<br>
&gt;<br>
&gt;=C2=A0 <a href=3D"mailto:david@gibson.dropbear.id.au" target=3D"_blank"=
>david@gibson.dropbear.id.au</a><br>
&gt; -<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">laurent@vivier=
.eu</a><br>
&gt;=C2=A0 <a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@f=
edoraproject.org</a><br>
&gt;=C2=A0 <a href=3D"mailto:armbru@pond.sub.org" target=3D"_blank">armbru@=
pond.sub.org</a><br>
&gt; --<br>
&gt; 2.26.2<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000071966505b1bb0d0f--

