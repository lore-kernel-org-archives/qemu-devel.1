Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FACC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F65722456
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WW4jGZwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65722456
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLXb-00048w-J4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jvLSr-0005oJ-Tl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:59:21 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jvLSp-0003WB-3Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:59:21 -0400
Received: by mail-oi1-x230.google.com with SMTP id j11so13944598oiw.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fpCH2xXs20luc7pWr52c7kARIxu1wP3GT6gdRE3Sm2o=;
 b=WW4jGZwcgPDKK+BwP2AwLQnkgaDKBj8W5G3gPAw/gDnMnT8rQLhUk30FGVoBKz+rqG
 NDYfPJO+Fdk8zaEiAV7wYgC81+RMWncwD2qlpS48ntqGyVxyqvXhDJoZ7DwU1E9Tq/nq
 1w2qrIgG+9aPgvYVHAjDV2+1bX1z0dF2+QlZWLjtYa71Kp9LpqGwhHJ185A1LTmJGWrL
 15BNpERGGw/hopGmWct1AyVUPfGkrhbmecYz2xnVLi0owMI03IxYks9TSqQ681oLxwUu
 j2RsbHODVHG0K9cEwSsNVxh344KyCq1sZXiVUohlkS1z5B2X95JRJf0QlwsJp4tc9t/P
 PsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fpCH2xXs20luc7pWr52c7kARIxu1wP3GT6gdRE3Sm2o=;
 b=oRSwd5opTm8lXTEKHmFIQjDAYPjb5Aa/RfXtWljA12OjrQTJOzV1RwgMKm1dEckP0h
 QTaLfNIveAzO0GaIQ6cOuujXbWtFY0oVPaWx3BNV6dm/yhamUDzFdXL/O38YyT5BuYD8
 wpRmK1Kcq91uQCZCUtTeWpeiBwBjFWjdFoNXbRhd2+dwN45tmZln0YmsAxemad0UueS/
 ccXxRzVJ5Mk4+oNVfuloyVjRhparqHITSM8PPqhoJ4g3b8cCpZxs8YIHGYYYXc4Tmu07
 cl4ApdaALSHcDlpJP2o63cZRwAEIqpCJW+GIH1p8WETA7+1wxFEOGUsRCpHiGcxaUprC
 XXTA==
X-Gm-Message-State: AOAM530xXLILH7iO8UuLM9aAFIKUafH/b7MIcB+M72yOPaXFmqDSgqm+
 ZTiT6bvyKt4aq/ZcBM75U7rX+UdByyzB1mwKU0Q94w==
X-Google-Smtp-Source: ABdhPJwG1X5webumfjZZGt3y2f5WQAin2zpantl6+e/Kxyv3Ee/2rtkXPhBnbnnujvX10tSBVYPh+QhRsAY/wClIIwE=
X-Received: by 2002:aca:3f8b:: with SMTP id m133mr3531532oia.78.1594735157695; 
 Tue, 14 Jul 2020 06:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
 <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
 <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
 <0ccc7311-02f4-821f-6272-73ab600a8cda@linaro.org>
In-Reply-To: <0ccc7311-02f4-821f-6272-73ab600a8cda@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 14 Jul 2020 21:59:06 +0800
Message-ID: <CAE_xrPg9otd9tbpHL_1DmvZ=3nFNdgkse_nUe=fApTQt1hPCYA@mail.gmail.com>
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000095f17b05aa6736b0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x230.google.com
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

--00000000000095f17b05aa6736b0
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 14, 2020 at 9:21 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/13/20 7:59 PM, Frank Chang wrote:
> > The latest spec specified:
> >
> > Only the low *lg2(SEW) bits* are read to obtain the shift amount from a
> > *register value*.
> > The *immediate* is treated as an *unsigned shift amount*, with a
> *maximum shift
> > amount of 31*.
>
> Which, I hope you will agree is underspecified, and should be reported as
> a bug
> in the manual.
>

Yes, you're correct.
I found out I missed the MASK part in GEN_VEXT_SHIFT_VV() macro,
which this macro is shared between OPIVV and OPIVI format of instructions.
So the same masking methodology should be applied to shift amounts coming
from both register and immediate value.
Spike also does something like:
*vs2 >> (zimm5 & (sew - 1) & 0x1f);* for SEW = 8.

I think spec is kind of misleading to the reader by the way it expresses.


>
> > Looks like the shift amount in the immediate value is not relevant with
> SEW
> > setting.
>
> How can it not be?  It is when the value comes from a register...
>
> > If so, is it better to just use do_opivi_gvec() and implement the logic
> by our
> > own rather than using gvec IR?
>
> No, it is not.  What is the logic you would apply on your own?  There
> should be
> a right answer.
>

I was talking about just calling GEN_OPIVI_TRANS() to generate the helper
functions
defined in vector_helper.c as what I'm doing in the original patch.
But as long as the immediate value should also apply *lg2(SEW) bits*
truncating,
I think I should update GEN_OPIVI_GVEC_TRANS() to utilize gvec IR.


>
> If the answer is that out-of-range shift produces zero, which some
> architectures use, then you can look at the immediate value, see that you
> must
> supply zero, and then fill the vector with zeros from translate.  You need
> not
> call a helper to perform N shifts when you know the result a-priori.
>
> If the answer is that shift values are truncated, which riscv uses
> *everywhere
> else*, then you should truncate the immediate value during translate.
>

I think vsll.vi, vsrl.vi and vsra.vi truncate the out-of-range shift as
other riscv instructions.
I will double confirm that, thanks for the advice.

Frank Chang


>
>
> r~
>

--00000000000095f17b05aa6736b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jul 14, 2020 at 9:21 PM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 7/13/20 7:59 PM, Frank Chang wr=
ote:<br>
&gt; The latest spec specified:<br>
&gt; <br>
&gt; Only the low *lg2(SEW) bits* are read to obtain the shift amount from =
a<br>
&gt; *register value*.<br>
&gt; The *immediate* is treated as an *unsigned shift amount*, with a *maxi=
mum shift<br>
&gt; amount of 31*.<br>
<br>
Which, I hope you will agree is underspecified, and should be reported as a=
 bug<br>
in the manual.<br></blockquote><div><br></div><div>Yes, you&#39;re=C2=A0cor=
rect.</div><div>I found out I missed the MASK part in=C2=A0GEN_VEXT_SHIFT_V=
V() macro,</div><div>which this macro is shared between=C2=A0OPIVV and OPIV=
I=C2=A0format of instructions.</div><div>So the=C2=A0same masking methodolo=
gy should be applied to shift=C2=A0amounts coming from both register=C2=A0a=
nd immediate value.</div><div>Spike also does something like:</div><div><i>=
vs2 &gt;&gt; (zimm5 &amp; (sew - 1) &amp; 0x1f);</i> for SEW =3D 8.</div><d=
iv><br></div><div>I think spec is kind of misleading to the reader by=C2=A0=
the way it expresses.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; Looks like the shift amount in the immediate value is not relevant wit=
h SEW<br>
&gt; setting.<br>
<br>
How can it not be?=C2=A0 It is when the value comes from a register...<br>
<br>
&gt; If so, is it better to just use do_opivi_gvec() and implement the logi=
c by our<br>
&gt; own rather than using gvec IR?<br>
<br>
No, it is not.=C2=A0 What is the logic you would apply on your own?=C2=A0 T=
here should be<br>
a right answer.<br></blockquote><div><br></div><div>I was talking about jus=
t calling GEN_OPIVI_TRANS() to generate the helper functions</div><div>defi=
ned in vector_helper.c as what I&#39;m doing in the original patch.</div><d=
iv>But as long as the immediate value should also apply=C2=A0*lg2(SEW) bits=
* truncating,</div><div>I think I should update GEN_OPIVI_GVEC_TRANS() to u=
tilize gvec IR.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
If the answer is that out-of-range shift produces zero, which some<br>
architectures use, then you can look at the immediate value, see that you m=
ust<br>
supply zero, and then fill the vector with zeros from translate.=C2=A0 You =
need not<br>
call a helper to perform N shifts when you know the result a-priori.<br>
<br>
If the answer is that shift values are truncated, which riscv uses *everywh=
ere<br>
else*, then you should truncate the immediate value during translate.<br></=
blockquote><div><br></div><div>I think=C2=A0<a href=3D"http://vsll.vi">vsll=
.vi</a>, <a href=3D"http://vsrl.vi">vsrl.vi</a> and <a href=3D"http://vsra.=
vi">vsra.vi</a> truncate the out-of-range shift as other=C2=A0riscv instruc=
tions.</div><div>I will double confirm that, thanks for the advice.</div><d=
iv><br></div><div>Frank Chang</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
<br>
r~<br>
</blockquote></div></div>

--00000000000095f17b05aa6736b0--

