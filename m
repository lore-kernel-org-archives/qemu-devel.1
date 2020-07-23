Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE079C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDD7206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RjzMqc/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDD7206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyQpQ-0006E7-PN
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 22:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyQoq-0005mW-Kp
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 22:18:48 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:39522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyQoo-0000fa-E5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 22:18:48 -0400
Received: by mail-oi1-x232.google.com with SMTP id w17so3678068oie.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JVRCT/jvApxzI6mlf1z5VkbHLxRCBfDTSjpNh/APMdY=;
 b=RjzMqc/vE5UVdwYeG1U1RG/phV5T5gmivMqMbTjqc55ZHqG44jEvEi0TH6XggXo9vx
 UaiTE+yku3RnWj4z4Zw3OXcNGofekVzvhnkA9aEkKrP+Hco2jcXP4Tr2VO1/3XcrztDc
 QfhEqX6yK4UGVaijWHhGdTv/yyWsvHSUDiNI3wBK/SjU+g8pfOei8/55C+wApK6FaPyR
 fKoIkKXppbQL3dfz5iV0dkXrO2szy6Q1IvsD2gANwcmQJrz75WgWbPbsjW07AIXrxdKC
 1zCfm8yim2nPNAoPK+ycXcJYdERA5QMdnTIX8buAI+0YBcYj927yVFYB4BBjU10Z38mS
 Iuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JVRCT/jvApxzI6mlf1z5VkbHLxRCBfDTSjpNh/APMdY=;
 b=d04/ZiNuOrJnng/2QEh5J0arcLorWVQLMF/SsNxPjvx8k0LRcCvM3DuBxJKfDn8Z2T
 Yob2DTp94pMKjjEnvCu3QKkAjDdQJqaERG31oavYydBYw1PNA2BJbrLaLYLkuXjHw91t
 DPciSFCYQAWwfJaF/tr0SvSvLU7tFeAgOu851pjDQsrgwD/mRjR/rOeKRXv1oQ15Z3uR
 qDf/+cmeMVLkp31NUR7ZxLtVPLAeh0R8sHQlXfpvVsqVUwhCDKim41SdPxhCuJqPgy9W
 tPBIeZwrqEUi2V31U8qCOKpfmmoSafgQpBsI5kQtfoEJQa3ISa7mvc/0k64RbCXRSO28
 mS+A==
X-Gm-Message-State: AOAM532XuUVNj2vNnIkPxTxwIFrzQFfyDgxqON8ljIAComl5gq6ZPGOw
 BVYBTWjehHs2rouyYBc8/bTPyo55yl3IaO0LOZRIeg==
X-Google-Smtp-Source: ABdhPJxnqmveBrFuu/QT5JK0FKgsceWBqRGGOPoUI5SiPysfOghDhpg/SGyF9UC8UvmzB6PyzZ4XdUvwz1egmnl7nvQ=
X-Received: by 2002:aca:b203:: with SMTP id b3mr2051579oif.118.1595470725084; 
 Wed, 22 Jul 2020 19:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-17-frank.chang@sifive.com>
 <05c8267d-f22b-6714-8806-92edf228091e@linaro.org>
In-Reply-To: <05c8267d-f22b-6714-8806-92edf228091e@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 23 Jul 2020 10:18:34 +0800
Message-ID: <CAE_xrPhNKvaaAqhhx8CwOOGR+eteb92jQsqEjzo73AR5Ek6StQ@mail.gmail.com>
Subject: Re: [RFC v2 16/76] target/riscv: rvv-0.9: add VMA and VTA
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d181f905ab1279ec"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d181f905ab1279ec
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 23, 2020 at 2:00 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> > -static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
> > +static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t
> tot)
> >  {
> > +    if (vta == 0) {
> > +        /* tail element undisturbed */
> > +        return;
> > +    }
> > +
> >      /*
> > +     * Tail element agnostic.
> >       * Split the remaining range to two parts.
> >       * The first part is in the last uint64_t unit.
> >       * The second part start from the next uint64_t unit.
> > @@ -152,41 +168,50 @@ static void vext_clear(void *tail, uint32_t cnt,
> uint32_t tot)
> >      if (cnt % 8) {
> >          part1 = 8 - (cnt % 8);
> >          part2 = tot - cnt - part1;
> > -        memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
> > -        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
> > +        memset((void *)((uintptr_t)tail & ~(7ULL)), 1, part1);
> > +        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 1, part2);
> >      } else {
> > -        memset(tail, 0, part2);
> > +        memset(tail, 1, part2);
> >      }
> >  }
>
> "1s" surely means all bits set to 1, not each byte to 1.
>

You're correct, I can't just simply replace the value from 0 to 1.


>
> Is there any reason to do anything with VTA/VMA at all?  One alternative
> for
> "agnostic" is to leave the values undisturbed.  So the quickest thing for
> qemu
> to do is remove all of this code.  Then we don't have to pass the values in
> translate either.
>
> Which is exactly what is recommended in the 4th paragraph of the notes
> following the VTA/VMA description.
>
>
I was trying to keep these codes as an option for the user to specify the
behaviors of VTA.
But as long as it's easier for QEMU to just treat VTA/VMA as agnostic(no
changes)/undisturbed.
I will remove all the clean functions in my next patchset.


>
> r~
>

Frank Chang

--000000000000d181f905ab1279ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jul 23, 2020 at 2:00 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 7/22/20 2:15 AM, <a href=3D"mai=
lto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wr=
ote:<br>
&gt; -static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)<br>
&gt; +static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32=
_t tot)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 if (vta =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* tail element undisturbed */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Tail element agnostic.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Split the remaining range to two parts.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* The first part is in the last uint64_t uni=
t.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* The second part start from the next uint64=
_t unit.<br>
&gt; @@ -152,41 +168,50 @@ static void vext_clear(void *tail, uint32_t cnt,=
 uint32_t tot)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (cnt % 8) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part1 =3D 8 - (cnt % 8);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part2 =3D tot - cnt - part1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset((void *)((uintptr_t)tail &amp; ~(7=
ULL)), 0, part1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset((void *)(((uintptr_t)tail + 8) &am=
p; ~(7ULL)), 0, part2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset((void *)((uintptr_t)tail &amp; ~(7=
ULL)), 1, part1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset((void *)(((uintptr_t)tail + 8) &am=
p; ~(7ULL)), 1, part2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(tail, 0, part2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(tail, 1, part2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
<br>
&quot;1s&quot; surely means all bits set to 1, not each byte to 1.<br></blo=
ckquote><div><br></div><div>You&#39;re correct, I can&#39;t just simply rep=
lace the value from 0 to 1.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
Is there any reason to do anything with VTA/VMA at all?=C2=A0 One alternati=
ve for<br>
&quot;agnostic&quot; is to leave the values undisturbed.=C2=A0 So the quick=
est thing for qemu<br>
to do is remove all of this code.=C2=A0 Then we don&#39;t have to pass the =
values in<br>
translate either.<br>
<br>
Which is exactly what is recommended in the 4th paragraph of the notes<br>
following the VTA/VMA description.<br>
<br></blockquote><div><br></div><div>I was trying to keep these codes as an=
 option for the user to specify the behaviors of VTA.</div><div>But as long=
 as it&#39;s easier for QEMU to just treat VTA/VMA as agnostic(no changes)/=
undisturbed.</div><div>I will remove all the clean functions in my next pat=
chset.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
r~<br></blockquote><div><br></div><div>Frank Chang=C2=A0</div></div></div>

--000000000000d181f905ab1279ec--

