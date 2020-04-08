Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A9C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4202A206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSNnIrBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4202A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMCgI-0006HB-8N
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 11:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMCf5-0005Wy-FG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jMCf1-0007xj-KO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:30:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jMCez-0007v5-Gs
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:30:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id a25so8322119wrd.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l4T1pQSHBTYuGXGCCLdL70om8t4BS/c6rU+az+IchgE=;
 b=XSNnIrBqqX2nOUCTbVMrqYH8QCdJvljS72ToNqiHtMs3+WCxqoYGVl5S8myGLw6NW9
 h/CzcKl+S/57WarmRsftoarovA0e/uTZWujm9ac+J3ieWJmXXtO8/dbDymecD//F9QFe
 ApVqtMy1sW+cvGtEb54/JTVxkfFgd+e1Y9FXfjqIlz+wrhLH8377HBJUEYiDTJdZn3IP
 ObJ2Xvw7sHGTmtlwNoxiFO+/y42GTlnp8lAvuMZBvHofLqcVw8t3jCH4R3OSY1jEiaz/
 XKpeqRMqEH60jiqE/6ezmT5rUFf1bT/umKoPUx4luAJ23ZwTltMzZ9g+/4wieyXmZCnR
 PGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l4T1pQSHBTYuGXGCCLdL70om8t4BS/c6rU+az+IchgE=;
 b=sYSoaoHa363FZavjCN2xRIAt5pEdXeuKsWu7OWqbwJ/C15ciw14m1mxSF591sLkcLz
 dVE+yzkjQ1hiZFHdBA9KrB3d5Q7wutntFs6vXb4TzmRpsZU0g3/lZYHQustXv0ROm5d6
 S1cm4MUZtgfmbBLEMId/HB5lJuVayo2JvJqZ4Iy+xLOx/uzXcVX8iM1pT8VRx08UXin8
 ltwuMLtuQtVbp3H49MqOaLrV0LdIwO3pz/wfUJswQ20y7ur81C2wYzf8vupnIAIFqFeu
 Y0PVVKcex4nuJjyTbY+F2Z2m3MWFG14QkZKo/degvltLZhjqBz+QBUBMpvCpVVnzDb+z
 FP5A==
X-Gm-Message-State: AGi0PuZWNwyvMjGUbtI3k7UKjxvTM1nqdDSNRt5A7Hn8fvHjNGJ0z4D0
 pplJot64PFQZOJss8+7mfYq4j3nwaQDEuJzVvhs=
X-Google-Smtp-Source: APiQypL24MREZC6DvBGWhkOG/OrH2Y1E50sWaZfx3LhGLqbgpBqVddLUirpsLmX5hNj4KjRW49+OPlMKpCn+GR+YS1c=
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1475919wrw.162.1586359834432; 
 Wed, 08 Apr 2020 08:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1586337380-25217-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 8 Apr 2020 17:30:16 +0200
Message-ID: <CAHiYmc61GZSvvwhCaC0B5q0GrEUN3CevDvNTEEWLE9PCJqVbvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
To: Huacai Chen <chenhc@lemote.com>
Content-Type: multipart/alternative; boundary="0000000000006ad9f405a2c92e43"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006ad9f405a2c92e43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:08 Sre, 08.04.2020. Huacai Chen <chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> I submitted the MIPS/fulong2e support about ten years ago, and after
> that I became a MIPS kernel developer. Last year, Philippe Mathieu-
> Daud=C3=A9 asked me that whether I can be a reviewer of MIPS/fulong2e, an=
d I
> promised that I will do some QEMU work in the next year (i.e., 2020 and
> later). I think now (and also in future) I can have some spare time, so
> I can finally do some real work on QEMU/MIPS. And if possible, I hope I
> can be a co-maintainer of MIPS/fulong2e.
>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 642c8e0..3281ff2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
>  Fulong 2E
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> --
> 2.7.0
>

First of all, I want to express great pleasure and delight seing your
series, and this patch in particular.

A warm welcome to QEMU developers communities!

We are currenyly very busy preparing QEMU 5.0 release, and additionaly,
Easter holidays are in next few days or week (different parts od Christian
world have different calendars), so, fot thay and other reasons, don't
expect promot replies from us.

I would also like to see Jiaxng at least having official reviewer status,
but, of course, only if he wants that.

Yours,
and wishing you and all people from China best health!

Aleksandar

--0000000000006ad9f405a2c92e43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:08 Sre, 08.04.2020. Huacai Chen &lt;<a href=3D"mailto:che=
nhc@lemote.com">chenhc@lemote.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; I submitted the MIPS/fulong2e support about ten years ago, and after<b=
r>
&gt; that I became a MIPS kernel developer. Last year, Philippe Mathieu-<br=
>
&gt; Daud=C3=A9 asked me that whether I can be a reviewer of MIPS/fulong2e,=
 and I<br>
&gt; promised that I will do some QEMU work in the next year (i.e., 2020 an=
d<br>
&gt; later). I think now (and also in future) I can have some spare time, s=
o<br>
&gt; I can finally do some real work on QEMU/MIPS. And if possible, I hope =
I<br>
&gt; can be a co-maintainer of MIPS/fulong2e.<br>
&gt;<br>
&gt; Cc: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.=
yang@flygoat.com</a>&gt;<br>
&gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">ch=
enhc@lemote.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0MAINTAINERS | 1 +<br>
&gt; =C2=A01 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 642c8e0..3281ff2 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c<br>
&gt; =C2=A0Fulong 2E<br>
&gt; =C2=A0M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat=
.org">f4bug@amsat.org</a>&gt;<br>
&gt; =C2=A0M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt; =C2=A0S: Odd Fixes<br>
&gt; =C2=A0F: hw/mips/mips_fulong2e.c<br>
&gt; =C2=A0F: hw/isa/vt82c686.c<br>
&gt; -- <br>
&gt; 2.7.0<br>
&gt;</p>
<p dir=3D"ltr">First of all, I want to express great pleasure and delight s=
eing your series, and this patch in particular.</p>
<p dir=3D"ltr">A warm welcome to QEMU developers communities!</p>
<p dir=3D"ltr">We are currenyly very busy preparing QEMU 5.0 release, and a=
dditionaly, Easter holidays are in next few days or week (different parts o=
d Christian world have different calendars), so, fot thay and other reasons=
, don&#39;t expect promot replies from us.</p>
<p dir=3D"ltr">I would also like to see Jiaxng at least having official rev=
iewer status, but, of course, only if he wants that.</p>
<p dir=3D"ltr">Yours,<br>
and wishing you and all people from China best health!</p>
<p dir=3D"ltr">Aleksandar</p>

--0000000000006ad9f405a2c92e43--

