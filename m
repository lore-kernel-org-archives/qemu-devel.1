Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0CEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7709F208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jLc9Eb1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7709F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1S7a-0000M6-Q0
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k1S71-0008Jx-DI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:18:03 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:36708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k1S6z-00013d-FS
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:18:02 -0400
Received: by mail-ot1-x32c.google.com with SMTP id l27so15109508oti.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YAevHYOMUCxW8wCIyWkQiy80AHfiQ3gSTdimD+dt2uQ=;
 b=jLc9Eb1yxAKSD6i7nVYaNUPc8WVeUEqz4wnF9ZkgGkSSgpjXvs3hqKgR1Ywfvrix/U
 f1+TmOE1sXvcwaks8AZDjt9F4oAgcwmBWLKeoxkxzE9OIjKwVaodF8fLQlH+92SlI7aF
 ZgrtpraECoX34fCraor5ZBjs0toXViHuALzdGmns5roT3Sm+DWOA768jKTh2Rm29vDvm
 SWy5QpeCfjPPubyIztuFjxd7PowpZMZmOPtEmj00js+NK/kG3gLTpD/k5jEclLrCRYzE
 xB8i9zeeHPHKwo/5IVwW5DhxyHy80TqpPc/B7Nm5RlqYgkEyi6oovSV8bjDgHCs+BMni
 PChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YAevHYOMUCxW8wCIyWkQiy80AHfiQ3gSTdimD+dt2uQ=;
 b=E+7AYeAvEWpxeXz9M6+1L4IDzUIcD3ZnmmcNvJ9enrJX+y/5n3COfXaIaYeWqavddI
 TLaxgCrEV5WKZFh0PHAnZWGwi5s6k6Elb8TCmnnvDPIKfBam5YxEYtd4oIKDRzULaWbv
 AqErKeLpWqA65jPZH0G7fPNzvDeASPTMqjONT5KmkpoyDkXxqppbvPi3STblQsBi+7Em
 L6y16zdvYxnsER0YUMC9Ss0p68ogPBIwE32F/86pJNV2wPrPKugG2COqRYLqzyNz6ED3
 3sueJF6bzd8yTTAUT7K4IBCpNYBIMlbiaBDbtT9Pg7jGKwQJZUzCtQ/LJvfaiQPJKuce
 PE0A==
X-Gm-Message-State: AOAM532GV9YCzETVHTsrZKZGOCjj36UKtFPTC1akVXhLU00U2Hh8YOfY
 +3DMg2cWlvKHIkSBVfdlbkULuS+n3MFv/lQsov0hGg==
X-Google-Smtp-Source: ABdhPJx9W5UaJnCOPoCT3osRt38Cjsh0RRNU4ZMcGXZvlLrxQpvHq/MNkgPQagbZikabldrYylRIhEmWlI00czdxMzU=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr2426326oti.139.1596190679582; 
 Fri, 31 Jul 2020 03:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-44-frank.chang@sifive.com>
 <0b042afa-61e4-d6a4-7fbd-2c359026b8aa@linaro.org>
In-Reply-To: <0b042afa-61e4-d6a4-7fbd-2c359026b8aa@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 31 Jul 2020 18:17:48 +0800
Message-ID: <CAE_xrPhOJ3nUJJ_9o2m8EcJsBbpdEUz78qEt71mtFoF8gKgtiA@mail.gmail.com>
Subject: Re: [RFC v2 43/76] target/riscv: rvv-0.9: integer extension
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000073685805abba1aac"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--00000000000073685805abba1aac
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 31, 2020 at 4:35 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> > +    static gen_helper_gvec_3_ptr * const fns[6][4] = {
> > +        {
> > +            NULL, gen_helper_vzext_vf2_h,
> > +            gen_helper_vzext_vf2_w, gen_helper_vzext_vf2_d
> > +        },
> > +        {
> > +            NULL, NULL,
> > +            gen_helper_vzext_vf4_w, gen_helper_vzext_vf4_d,
> > +        },
> > +        {
> > +            NULL, NULL,
> > +            NULL, gen_helper_vzext_vf8_d
> > +        },
> > +        {
> > +            NULL, gen_helper_vsext_vf2_h,
> > +            gen_helper_vsext_vf2_w, gen_helper_vsext_vf2_d
> > +        },
> > +        {
> > +            NULL, NULL,
> > +            gen_helper_vsext_vf4_w, gen_helper_vsext_vf4_d,
> > +        },
> > +        {
> > +            NULL, NULL,
> > +            NULL, gen_helper_vsext_vf8_d
> > +        }
> > +    };
>
> I don't understand why there aren't more functions in this table.  As far
> as I
> can see, the only NULLs should be at [*][0].
>
>
> r~
>

As source EEW has to be 1/2, 1/4, 1/8 of SEW and the source EEW must be
a supported width (Section 12.3).

Shouldn't it impossible to have the cases, e.g.
vzext.vf4 with SEW = 16, i.e. EEW = SEW / 4 = 4 bits
vzext.vf8 with SEW = 16, i.e. EEW = SEW / 8 = 2 bits
vzext.vf8 with SEW = 32, i.e. EEW = SEW / 8 = 4 bits

Frank Chang

--00000000000073685805abba1aac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jul 31, 2020 at 4:35 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_bla=
nk">richard.henderson@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/22/20 2:16 =
AM, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang=
@sifive.com</a> wrote:<br>
&gt; +=C2=A0 =C2=A0 static gen_helper_gvec_3_ptr * const fns[6][4] =3D {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, gen_helper_vzext_vf2_=
h,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_vzext_vf2_w, gen=
_helper_vzext_vf2_d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_vzext_vf4_w, gen=
_helper_vzext_vf4_d,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, gen_helper_vzext_vf8_=
d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, gen_helper_vsext_vf2_=
h,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_vsext_vf2_w, gen=
_helper_vsext_vf2_d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_vsext_vf4_w, gen=
_helper_vsext_vf4_d,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, gen_helper_vsext_vf8_=
d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 };<br>
<br>
I don&#39;t understand why there aren&#39;t more functions in this table.=
=C2=A0 As far as I<br>
can see, the only NULLs should be at [*][0].<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>As source EEW has to be 1/2, 1/4, 1/=
8 of SEW and the source EEW must be</div><div>a supported width (Section 12=
.3).</div><div><br></div><div>Shouldn&#39;t it impossible to have the cases=
, e.g.</div><div>vzext.vf4 with SEW =3D 16, i.e. EEW =3D SEW / 4 =3D 4 bits=
</div><div>vzext.vf8 with SEW =3D 16, i.e. EEW =3D SEW / 8 =3D 2 bits</div>=
<div>vzext.vf8 with SEW =3D 32, i.e. EEW =3D SEW / 8 =3D 4 bits</div><div><=
br></div><div>Frank Chang</div></div></div>

--00000000000073685805abba1aac--

