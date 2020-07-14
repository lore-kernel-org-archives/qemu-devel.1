Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D355C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BBE2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FwbpxDPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BBE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBBM-0005ZG-FG
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jvBAf-00057Q-9L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:59:53 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:45358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jvBAa-0003mf-Bk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:59:52 -0400
Received: by mail-ot1-x335.google.com with SMTP id h1so11656435otq.12
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 19:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZmRaRt6MxQlbtjG3pd9shXgA2Px7RKTIjzuc+Um3MjM=;
 b=FwbpxDPWwE8Ub3UJMX1OFqvv2pgQGn4d98+yomx4QOjr9fEiyZaI/Xm8rZkQ16gV8v
 7KX5iT7Ol+PUTonu233ggxfrO1AQV8UoIWKXg74YugAXOJQpxwEideM+Lk4OAieJNKcf
 biMmnPMS0gS+R0wN9I9ZidP+8dNubjzjHn16qiYNRBaxvbPOW6Jui7rP56/0VlE+zw8M
 xM/w29zvc11Lpz26KAs/TFeJFstigRqyCaiBNW9ETCO2wqCY4FBzhWeIToKVj5tMkOLc
 LUDbJxhIT5WRHTqpWcZ+NXl2Luqv/NwJ65X7A2/qPO7s2dQaFuqVe8edwt9RcON0lGnZ
 8FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZmRaRt6MxQlbtjG3pd9shXgA2Px7RKTIjzuc+Um3MjM=;
 b=nWueWaYmEGGPgoRzxZguD8dxO/lNxzI79tQqnzaMjFrc8bKwy2AD4EOrCIjcXnv972
 hezIQjPnQBK5OQsw1F8medZ5EkJLHL9+g1Z1NSffS4GDtVFcWGWmYrTGVJ/lTProOJ8X
 VIGWotL+EkMHDPeA2+VF22O2a9sKrcjYnO6wXawRz7L4LWYoijQ44ACeNmuj32ja8gO3
 AlcxPXy6GReEDSCXYG/jmejL1BxzNhRIoSXJsVGTSjhpeLGbbLMn5v74yxvpmbvgE2nn
 Oruvs/rZGPKZD+oYjlL3X+LRAZ50MJG18p/kyLN1aehOHIoSSKEpooW1BSUDp/MZTxKc
 4kUg==
X-Gm-Message-State: AOAM532IqIes4Fl3F+CAC0WqNaa9jU/qB3fWngJedLRN6X1+MQJdlmOF
 VIestj9ycASE/8/cxf9tUxq21sBL3h4PXFOe67A7Fg==
X-Google-Smtp-Source: ABdhPJwhiZU3hQX2SIjv7UIF6DslwV+8hkEVkUy9xV9lsbgYCel+RqP8EZ2XgUR81QtDhfjZrqMucIjMWH4pRQ4DMso=
X-Received: by 2002:a9d:5e93:: with SMTP id f19mr2112218otl.175.1594695586645; 
 Mon, 13 Jul 2020 19:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
 <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
In-Reply-To: <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 14 Jul 2020 10:59:35 +0800
Message-ID: <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f79cb205aa5dffb0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x335.google.com
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

--000000000000f79cb205aa5dffb0
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 11, 2020 at 12:27 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > vsll.vi, vsrl.vi, vsra.vi cannot use shli gvec as it requires the
> > shift immediate value to be within the range: [0.. SEW bits].
> > Otherwise, it will hit the assertion:
> > tcg_debug_assert(shift >= 0 && shift < (8 << vece));
> >
> > However, RVV spec does not have such constraint, therefore we have to
> > use helper functions instead.
>
> Why do you say that?  It does have such a constraint:
>
> # Only the low lg2(SEW) bits are read to obtain the shift amount from a
> register value.
>
> While that only talks about the register value, I sincerely doubt that the
> same
> truncation does not actually apply to immediates.
>
> And if the entire immediate value does apply, the manual should certainly
> specify what should happen in that case.  And at present it doesn't.
>
> It seems to me the bug is the bare use of GEN_OPIVI_GVEC_TRANS and thence
> do_opivi_gvec.  The ZX parameter should be extended to more than just
> "zero vs
> sign-extend", it should have an option for truncating the immediate to
> s->sew.
>
>
> r~
>

The latest spec specified:

Only the low *lg2(SEW) bits* are read to obtain the shift amount from
a *register
value*.
The *immediate* is treated as an *unsigned shift amount*, with a *maximum
shift amount of 31*.

Looks like the shift amount in the immediate value is not relevant with SEW
setting.
If so, is it better to just use do_opivi_gvec() and implement the logic by
our own rather than using gvec IR?

Frank Chang

--000000000000f79cb205aa5dffb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Jul 11, 2020 at 12:27 AM Richard =
Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hende=
rson@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On 7/10/20 3:48 AM, <a href=3D"ma=
ilto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> w=
rote:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; <br>
&gt; <a href=3D"http://vsll.vi" rel=3D"noreferrer" target=3D"_blank">vsll.v=
i</a>, <a href=3D"http://vsrl.vi" rel=3D"noreferrer" target=3D"_blank">vsrl=
.vi</a>, <a href=3D"http://vsra.vi" rel=3D"noreferrer" target=3D"_blank">vs=
ra.vi</a> cannot use shli gvec as it requires the<br>
&gt; shift immediate value to be within the range: [0.. SEW bits].<br>
&gt; Otherwise, it will hit the assertion:<br>
&gt; tcg_debug_assert(shift &gt;=3D 0 &amp;&amp; shift &lt; (8 &lt;&lt; vec=
e));<br>
&gt; <br>
&gt; However, RVV spec does not have such constraint, therefore we have to<=
br>
&gt; use helper functions instead.<br>
<br>
Why do you say that?=C2=A0 It does have such a constraint:<br>
<br>
# Only the low lg2(SEW) bits are read to obtain the shift amount from a<br>
register value.<br>
<br>
While that only talks about the register value, I sincerely doubt that the =
same<br>
truncation does not actually apply to immediates.<br>
<br>
And if the entire immediate value does apply, the manual should certainly<b=
r>
specify what should happen in that case.=C2=A0 And at present it doesn&#39;=
t.<br>
<br>
It seems to me the bug is the bare use of GEN_OPIVI_GVEC_TRANS and thence<b=
r>
do_opivi_gvec.=C2=A0 The ZX parameter should be extended to more than just =
&quot;zero vs<br>
sign-extend&quot;, it should have an option for truncating the immediate to=
 s-&gt;sew.<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>The latest spec specified:</div><div=
><br></div>Only the low <b>lg2(SEW) bits</b> are read to obtain the shift a=
mount from a <b>register value</b>.<br><div>The <b>immediate</b> is treated=
 as an <b>unsigned shift amount</b>, with a <b>maximum shift amount of 31</=
b>.</div><div><br></div><div>Looks like the shift amount in the immediate v=
alue is not relevant with SEW setting.</div><div>If so, is it better to jus=
t use do_opivi_gvec() and implement the logic by our own rather than using =
gvec IR?</div><div><br></div><div>Frank Chang</div></div></div>

--000000000000f79cb205aa5dffb0--

