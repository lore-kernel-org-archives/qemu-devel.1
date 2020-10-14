Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F06C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575B321D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKoCpF3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575B321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSn08-0004yt-AR
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSmxx-0003qB-Kh; Wed, 14 Oct 2020 16:01:46 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:46002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSmxt-0006eu-GC; Wed, 14 Oct 2020 16:01:41 -0400
Received: by mail-lf1-x135.google.com with SMTP id r127so798130lff.12;
 Wed, 14 Oct 2020 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3APxZco9hgu6w5JH6mAukHW0NDibRfskrsn/17uHKhY=;
 b=rKoCpF3wffiMg8PeHoDNfjyy39VTz9/wcWBj5tKzupLtcwI+mm6ReaMTMPWjGvYruR
 jqD/n5hdMEUm0XgY3E6KWN4B/6OQAVLHZyNXx00hzdaVxeZza/gfcqim+lbXkqJn3nqB
 1SbC37Y3zdsMFnv22g++S84a64+SKlFCB9K+l3Mvr2W5M/rwSmKPTOJDDuKHQ+5M4UyP
 Mxkc1x4W96sp+OwSWKcAp7dU1iP1mWKE3XGZG4E6Weza3xlFyoiZEV8XuCWy3lFtBPCl
 tLyILW8NcH4Ev4XczTKOy198XhHHHFmDnGA3KNMQ4SL96ZiUIhsEjLGGm/E5bpEy8SZ6
 tq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3APxZco9hgu6w5JH6mAukHW0NDibRfskrsn/17uHKhY=;
 b=S8QgSTvB0Wrr8VSo5RlG3+rIr+ye94Qqjp05rKVZyBqmoiKTwEk5iqeWvaNHV+6bvV
 yP3AKaHIMP8V+z6S4Ffk5RAb1PnbUCPLk7qbxvRQmpUKsePTVw+dYUWDj/ebLlIwMxf2
 6rqE9fhiAU1DoGmwRsO57GLHPOrXsQkmDuaEoOJa8tkSIWGvWM41mc/LA29iPQynfwuZ
 KxM9kokrfHNgUK7gKTxw3CN2bMe0HNi4kgvCErC2SAUs6NsmvnXkqXX2h2w5PpHpRJa0
 3BJJMmsRrdGiuc30l55aWMp5KkHG3Zus6Bewqyp11RhpJ77x2nFikKB2S2I/OIlO2S3/
 8/Wg==
X-Gm-Message-State: AOAM533lxQdnmHqWYaL34mgum5eTrtbb2v0dq5O7bFW3UfFDeEYuYmjp
 L1mJ5ydYHw5DGIe/k/87W6v7rIRmgeHG7EyAx8E=
X-Google-Smtp-Source: ABdhPJx6GfKNRq0dUN74SClA9HCzeqLV4+XpfKK4x6NnORSys8UpW4ZVqqW1D4Wx1JnKk0cxduJAwGNp7tnBsTDctVc=
X-Received: by 2002:ac2:5506:: with SMTP id j6mr257720lfk.290.1602705693255;
 Wed, 14 Oct 2020 13:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
 <20201014170159.26932-4-space.monkey.delivers@gmail.com>
 <3395cef5-79d4-078a-29ad-48639e4cd56d@linaro.org>
In-Reply-To: <3395cef5-79d4-078a-29ad-48639e4cd56d@linaro.org>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Wed, 14 Oct 2020 23:01:22 +0300
Message-ID: <CAFukJ-CQ0VKiCerbAK4LZ8Dkn2PutFZXv0iJQe-Z-tweKThj4w@mail.gmail.com>
Subject: Re: [PATCH 3/5] [RISCV_PM] Print new PM CSRs in QEMU logs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000086aae705b1a6ff29"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x135.google.com
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "space.monkey.delivers@gmail.com" <space.monkey.delivers@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000086aae705b1a6ff29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all thank you so much for reviewing these patches!

>RVJ.
Thanks, I missed this typo, will fix it.

>Probably you only want to dump the set that's current.
I don't know for sure how anyone would be using this while debugging PM
related code, but I like the idea, so I'll try to do it, thanks!

=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 21:41, Richard Hen=
derson <richard.henderson@linaro.org
>:

> On 10/14/20 10:01 AM, Alexey Baturo wrote:
> > +    if (riscv_has_ext(env, RVH)) {
>
> RVJ.
>
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mmte    ",
> env->mmte);
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmbase ",
> env->upmbase);
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmbase ",
> env->spmbase);
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmbase ",
> env->mpmbase);
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmmask ",
> env->upmmask);
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmmask ",
> env->spmmask);
> > +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmmask ",
> env->mpmmask);
>
> Probably you only want to dump the set that's current.
>
>
> r~
>

--00000000000086aae705b1a6ff29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>First of all thank you so much for reviewing these pa=
tches!</div><div><br></div>&gt;RVJ.<div>Thanks, I missed this typo, will fi=
x it.</div><div><br></div><div>&gt;Probably you only want to dump the set t=
hat&#39;s current.</div><div>I don&#39;t know for sure how anyone would be =
using this while debugging PM related code, but I like the idea, so I&#39;l=
l try to do it, thanks!</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=
=B3. =D0=B2 21:41, Richard Henderson &lt;<a href=3D"mailto:richard.henderso=
n@linaro.org">richard.henderson@linaro.org</a>&gt;:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 10/14/20 10:01 AM, Alexey Baturo wro=
te:<br>
&gt; +=C2=A0 =C2=A0 if (riscv_has_ext(env, RVH)) {<br>
<br>
RVJ.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;mmte=C2=A0 =C2=A0 &quot;, env-&gt;mmte);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;upmbase &quot;, env-&gt;upmbase);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;spmbase &quot;, env-&gt;spmbase);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;mpmbase &quot;, env-&gt;mpmbase);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;upmmask &quot;, env-&gt;upmmask);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;spmmask &quot;, env-&gt;spmmask);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fprintf(f, &quot; %s &quot; TARGET_F=
MT_lx &quot;\n&quot;, &quot;mpmmask &quot;, env-&gt;mpmmask);<br>
<br>
Probably you only want to dump the set that&#39;s current.<br>
<br>
<br>
r~<br>
</blockquote></div>

--00000000000086aae705b1a6ff29--

