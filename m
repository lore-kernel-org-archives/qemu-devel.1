Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C5C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D955B206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbJeZf35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D955B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3e7-0000En-2g
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jH3Zz-0003Lb-K6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jH3Zy-0006gI-Dm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:48:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jH3Zy-0006er-7K
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:48:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id d5so2394892wrn.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AE85nmQ98UVGTlYj011lU1PvMAc8nGVf54bavmknjxs=;
 b=gbJeZf35gbiymTmkfPNQYnAh8hYrjXA4wJxJfA1jgAk225NA5JkAWHnJrgBntISwMb
 DnkfWsz2wKS/aIB88mt7btY3mhdS3qeP08QFPKzXL6d8QqHetpV49aIOokeltEFbZj1U
 LekJ3qxNzcsLrI1o7PuWCESQKfvFl1YqUvUPEVYQ2+WCDQbj1jHVgHXYk789+JLHRccC
 yY1YVYzqkyAMN+uj4x1PZDyBpHRoFw/GNq5cexvEiGoVMGIfKubX/5y5c+Ma4VqDS8G1
 2B3d/mtNEg7Ag2HDKN3ArsStM0npZkw/zlhju+za4plomsxp/sfHe3U4CAFHOKwNM1NN
 TOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AE85nmQ98UVGTlYj011lU1PvMAc8nGVf54bavmknjxs=;
 b=iRlODd6VbZZdENKxchP76fZoZ/hkEcx6W8OqQ3Nkumr+n0lgRFF1DjE3oj8cdxSc07
 KNBeXiGriGosYkOZgpGNsQC+b2qTL7qn/2heOlQK/1FJQygyQgfCzRocGx07mWhGhNW4
 cNTIHNhKeM5BjvM9uWJ+BoVS9tA5QPSe7Gc+KlAQg9pvTkCNXIqaad4gKgVB05tfkHem
 c+a7v7qCvLU1zXw6GREclp6n1WhIpdKP3y1lCby04ew12tFoXDFpxg2ylo/91h5kGrvU
 m13K/uYm7ApO9bhz1G9JGOW7U6wZFc+6ibevEvMiMhc/HQ2cW/H8nYzNVqveELywqJTR
 C6dw==
X-Gm-Message-State: ANhLgQ3UBKh93sRC0K/zpLqrJbspWlL8DtAPs+Wbu1iz0O7k6DkWlvmx
 Dxypsd+0xH8kYas/5IoWbDcaRDx+VJi2NAcMrN8=
X-Google-Smtp-Source: ADFU+vsH9GBzGYfJWFaNCrDpIueVFWbZBqGV1iYxknrPSAL3+tl9Qa2NMfxsgk9oplbYCAFuVylrb2lBAltXv05UCRQ=
X-Received: by 2002:adf:ba47:: with SMTP id t7mr2593424wrg.147.1585133288435; 
 Wed, 25 Mar 2020 03:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <aa622b1d-e28a-c3f1-d18a-73e8a67c8ccf@linaro.org>
 <CAHiYmc7R_Y7s5DaVHf=0rkxf7N2qTSLXdTdL_vy6mH+hVdwLqA@mail.gmail.com>
In-Reply-To: <CAHiYmc7R_Y7s5DaVHf=0rkxf7N2qTSLXdTdL_vy6mH+hVdwLqA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 25 Mar 2020 12:47:50 +0200
Message-ID: <CAHiYmc5nzmk0EiN6U8Wd3h3xBwim1frEXk=27tngfagHwTvYQw@mail.gmail.com>
Subject: Re: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000094353105a1ab9ae1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: aurelien@aurel32.net, aleksandar.rikalo@rt-rk.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000094353105a1ab9ae1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12:44 Sre, 25.03.2020. Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> 16:59 Uto, 24.03.2020. Richard Henderson <richard.henderson@linaro.org>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On 3/24/20 5:22 AM, Jiaxun Yang wrote:
> > > Loongson multimedia condition instructions were previously
implemented as
> > > write 0 to rd due to lack of documentation. So I just confirmed with
Loongson
> > > about their encoding and implemented them correctly.
> > >
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Acked-by: Huacai Chen <chenhc@lemote.com>
> > > ---
> > > v1: Use deposit opreations according to Richard's suggestion.
> > > ---
> > >  target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
> > >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >
>
> I just have a couple of mon-essential suggestions wrt coding style, but
since all that is really of very insignificant nauture, I wouldn't even
mention them.
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemi.devel@gmail.com>
>

Sorry, there was a typo. It should be:

Reviewed-by: Aleksandar Markovic <aleksandar.qem u.devel@gmail.com>

("u" instead of "i" in "qemi")

> May I ask you, Richard, to select this patch for your next TCG-for-5.0
queue, so that I don't go through a MIPS queue process for just a single
patch?
>
> Thanks to all involved people!
>
> Aleksandar
>
> >
> > r~

--00000000000094353105a1ab9ae1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">12:44 Sre, 25.03.2020. Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt;<br>
&gt; 16:59 Uto, 24.03.2020. Richard Henderson &lt;<a href=3D"mailto:richard=
.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; On 3/24/20 5:22 AM, Jiaxun Yang wrote:<br>
&gt; &gt; &gt; Loongson multimedia condition instructions were previously i=
mplemented as<br>
&gt; &gt; &gt; write 0 to rd due to lack of documentation. So I just confir=
med with Loongson<br>
&gt; &gt; &gt; about their encoding and implemented them correctly.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang=
@flygoat.com">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; &gt; &gt; Acked-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.co=
m">chenhc@lemote.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; v1: Use deposit opreations according to Richard&#39;s sugges=
tion.<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 target/mips/translate.c | 35 +++++++++++++++++++++++++=
++++++----<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 31 insertions(+), 4 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.hend=
erson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; I just have a couple of mon-essential suggestions wrt coding style, bu=
t since all that is really of very insignificant nauture, I wouldn&#39;t ev=
en mention them.<br>
&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemi=
.devel@gmail.com">aleksandar.qemi.devel@gmail.com</a>&gt;<br>
&gt;</p>
<p dir=3D"ltr">Sorry, there was a typo. It should be:</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;aleksandar.qem <a href=
=3D"mailto:u.devel@gmail.com">u.devel@gmail.com</a>&gt;</p>
<p dir=3D"ltr">(&quot;u&quot; instead of &quot;i&quot; in &quot;qemi&quot;)=
</p>
<p dir=3D"ltr">&gt; May I ask you, Richard, to select this patch for your n=
ext TCG-for-5.0 queue, so that I don&#39;t go through a MIPS queue process =
for just a single patch?<br>
&gt;<br>
&gt; Thanks to all involved people!<br>
&gt;<br>
&gt; Aleksandar<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; r~<br>
</p>

--00000000000094353105a1ab9ae1--

