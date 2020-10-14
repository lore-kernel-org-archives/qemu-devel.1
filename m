Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD81C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532932222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL1K5CMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532932222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnCX-00062D-50
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSnA6-0004kD-H2; Wed, 14 Oct 2020 16:14:14 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSnA4-0008Dw-8t; Wed, 14 Oct 2020 16:14:14 -0400
Received: by mail-lf1-x141.google.com with SMTP id j30so896302lfp.4;
 Wed, 14 Oct 2020 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pJJ5wVt0lCxb9PaF07erlTCzDN1vQl9gDqXy4uftNL0=;
 b=JL1K5CMYTR1baa+CSwpz7e/KWf5Z7A6Vd7phT+p+RdzGEQx7yIupP8G580hJoNdUTW
 +a+S5RkLJsrY/EO78An7UmAEg7pU2gOuKslWbjGNuAF85AbokNEdNTC77QJCgDRzIk81
 Abw1HC7SKv0Wbd8cGhUkdqIAo8FHjb1EkyVMVV4ko4CBINwPQhe/xikXz81eEwIE0WqF
 QXrQxv7S9VDaEPkzsJtL1WRwrDy96tRcyXDU+eqpBBE0/ZQQz/hoNywIkMw9D/TGxv2v
 kvfrbZeZ49NugG30BowRABePP+9A36f6E/pfO1k4jtQ+Hw/V+MC1DU3HAtjN/7enqWoj
 3YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pJJ5wVt0lCxb9PaF07erlTCzDN1vQl9gDqXy4uftNL0=;
 b=DsU398INMHcx4+cMaMbyggdzmc7bxq3sQ/y063G5SO4XDzV3EX5ZVSk6HR1zzd0N+G
 KJmqcxu3n7/xCukW0HqzYQhSrw+RDg1Trg4RKn0LgLcBMn2jtw5m6UftF8hdtX5+6mVz
 XRqT79Ak1UoIsvu8VVEFmtMVS0Z4DMkA6mMN6u9CrUSCsiOUt52ivlA6RODwz9PhU4mT
 YMI9uAvjKJMn4wTQUISnWpF9rCNUTvG+QA7cNo2jiTUVeI1ey1aI1wtLY49ikD+vux1o
 PfCNR9YvDRSxP0U+Wa+xec+gXzvjyX1VJgoniVyj0Vgc+kYs13dtIaVuv6iWX85x8VEd
 p+jA==
X-Gm-Message-State: AOAM532vLljbZ1p9XgK2Kf816wTLAsRni6KM8y9zDojeglGdHdlig6r2
 X5hbH2YM2x3KDzvJxRjdv7HelYq4H8FnbOo2daY=
X-Google-Smtp-Source: ABdhPJw/S081ag8Lqmupg3uJOSf4dZgpMx4nloHlBTidr1IHBbWheHjPgqzJrLoe0D2X33OgODUuJEAKV261VB3WCgw=
X-Received: by 2002:a19:8191:: with SMTP id c139mr268970lfd.333.1602706450077; 
 Wed, 14 Oct 2020 13:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
 <20201014170159.26932-6-space.monkey.delivers@gmail.com>
 <a4c7ff19-0b5b-263b-51da-80b5caea8f27@linaro.org>
In-Reply-To: <a4c7ff19-0b5b-263b-51da-80b5caea8f27@linaro.org>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Wed, 14 Oct 2020 23:13:58 +0300
Message-ID: <CAFukJ-Am8XsbeUW-=_GgvDN3PNXp_FLDUCZtQzZ1JWFE8woNhA@mail.gmail.com>
Subject: Re: [PATCH 5/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a2dc3205b1a72cca"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 GAPPY_SUBJECT=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a2dc3205b1a72cca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The if is redundant, since that will have been done in
cpu_get_tb_cpu_state while assigning pm_enabled.
I totally agree here, however I tried to do explicit checks, so this
functionality is available only if a special option is supplied.
But if you think that's too much and I could do just mov(dst, src) in case
PM is disabled, I'd gladly fix that.

> I suggest you drop apply_pointer_masking and just use
gen_pm_adjust_address.
Sure, will do.

Thanks!



=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 22:24, Richard Hen=
derson <richard.henderson@linaro.org
>:

> On 10/14/20 10:01 AM, Alexey Baturo wrote:
> > +    if (has_ext(ctx, RVJ)) {
> > +        src1 =3D apply_pointer_masking(ctx, src1);
> > +    }
>
> The if is redundant, since that will have been done in cpu_get_tb_cpu_sta=
te
> while assigning pm_enabled.
>
> The test for pm_enabled is in gen_pm_adjust_address.
>
> The final thing is that the API for apply_pointer_masking is misleading.
> Here,
> it appears as if you are allocating a new temporary and assigning it to
> src1.
> Which is not the case.
>
> I suggest you drop apply_pointer_masking and just use
> gen_pm_adjust_address.
>
>
> r~
>

--000000000000a2dc3205b1a72cca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; The if is redundant, since that will have been done i=
n cpu_get_tb_cpu_state while assigning pm_enabled.<div>I totally agree here=
, however I tried to do explicit checks, so this functionality is available=
 only if a special option is supplied.</div><div>But if you think that&#39;=
s too much and I could do just mov(dst, src) in case PM is disabled, I&#39;=
d gladly=C2=A0fix that.</div><div><br></div><div>&gt; I suggest you drop ap=
ply_pointer_masking and just use gen_pm_adjust_address.</div><div>Sure, wil=
l do.</div><div><br></div><div>Thanks!</div><div><br></div><div><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 22:24, Richard Hen=
derson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderso=
n@linaro.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 10/14/20 10:01 AM, Alexey Baturo wrote:<br>
&gt; +=C2=A0 =C2=A0 if (has_ext(ctx, RVJ)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src1 =3D apply_pointer_masking(ctx, src1)=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
The if is redundant, since that will have been done in cpu_get_tb_cpu_state=
<br>
while assigning pm_enabled.<br>
<br>
The test for pm_enabled is in gen_pm_adjust_address.<br>
<br>
The final thing is that the API for apply_pointer_masking is misleading.=C2=
=A0 Here,<br>
it appears as if you are allocating a new temporary and assigning it to src=
1.<br>
Which is not the case.<br>
<br>
I suggest you drop apply_pointer_masking and just use gen_pm_adjust_address=
.<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000a2dc3205b1a72cca--

