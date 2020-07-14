Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D29C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7352E20B80
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IEyw8hJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7352E20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCjy-0001S5-PY
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jvCjE-000103-DO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:39:40 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:41087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jvCjB-0002UX-1V
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:39:40 -0400
Received: by mail-ot1-x333.google.com with SMTP id a21so11948366otq.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 21:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u3qAweFNJ6WHi8MtwgaGsVD1PoKriZDZAZPxQuIwsCM=;
 b=IEyw8hJi2rNmCpsQgaAlek9T6G+9Qf1f5aotyy5oWDn97k4EtOYoTKn4bSHBWUeljZ
 Cgll4wFuGGtEfED7qqHjDG1OPEBgxa09ETi9D9RbfKiLUys9iiFH5VTxF5CTgOUVC5sY
 ANEx1XEmZZz1YKt/rHyDPYFTazNbVECTFEwevK9lnUaWsX3WWAQc7Hla1T3qMowvgVIU
 7XvSRrS/BLV8KMMV4dJE6Ohq/hNa/7TtQJYVVrMCEQRBYyLF9UCK8fikYJYvKAKq/dbM
 e/2RdnXLFdgB/c+HRJneNQvFnE+Z3v+6bvp+V1M89LHBI4MTlSu8zAMp7TG1dqzpFxYF
 H6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u3qAweFNJ6WHi8MtwgaGsVD1PoKriZDZAZPxQuIwsCM=;
 b=pPsLhw2njiNoisInZOmTQfyLBtLj5LgY9JAMNR/9b68clT52YNzgyMUStHVG9CtM+/
 Dns3tLQ7pBZU9fpvdwV6LLQgSSq0T/0Yis+qjNaQJVvUXytYo1Z53ITCbDy3YoySXsmR
 LQSykct8AFKwTAL16A8mbGVLiGdx1fJFOYs+x+yBeu2xw3YfBGD74ahIXtzArV91ZiB5
 BteKgFMlshcr7ResAcyPaKL2tSetdPTHWQpf1wJ4124Y5mxQ+SHa+ptVrTv1OaZpVm/u
 m828KyTgptmLrvFg/lQ6H/8Wo5ubwni5CBxcPjTvGPeVOKIQy+pr4+yv59rUpxB32FpI
 ydZg==
X-Gm-Message-State: AOAM533DuNKVw2U0eYdKuxr/igCHSeUVMyU1iZtHwJRsGKfhCJK6tl3f
 8T1P9Ud38gKuWDkWH1JVF3dA5joM1fK3Yimv68RM+A==
X-Google-Smtp-Source: ABdhPJwmzjuzNJq8FmVBKZURCSXfY/8BSMwahm4lYiDvrbdk4HwAaLLVESJw80M7cXWgMXx9PpkSQ+6+cuQR6pU/gzQ=
X-Received: by 2002:a05:6830:1d0:: with SMTP id
 r16mr2748184ota.188.1594701575529; 
 Mon, 13 Jul 2020 21:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
 <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
 <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
 <407ef5d5-d9d9-9619-b6e3-456f8a5b4bfb@c-sky.com>
In-Reply-To: <407ef5d5-d9d9-9619-b6e3-456f8a5b4bfb@c-sky.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 14 Jul 2020 12:39:24 +0800
Message-ID: <CAE_xrPiNfu2f0fMfVes6PF-HPRuP7-dFuVEidMYFGLfwGhdcEA@mail.gmail.com>
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: multipart/alternative; boundary="000000000000eebb8c05aa5f64bf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x333.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eebb8c05aa5f64bf
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 14, 2020 at 11:35 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:

>
>
> On 2020/7/14 10:59, Frank Chang wrote:
>
> On Sat, Jul 11, 2020 at 12:27 AM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
>> > From: Frank Chang <frank.chang@sifive.com>
>> >
>> > vsll.vi, vsrl.vi, vsra.vi cannot use shli gvec as it requires the
>> > shift immediate value to be within the range: [0.. SEW bits].
>> > Otherwise, it will hit the assertion:
>> > tcg_debug_assert(shift >= 0 && shift < (8 << vece));
>> >
>> > However, RVV spec does not have such constraint, therefore we have to
>> > use helper functions instead.
>>
>> Why do you say that?  It does have such a constraint:
>>
>> # Only the low lg2(SEW) bits are read to obtain the shift amount from a
>> register value.
>>
>> While that only talks about the register value, I sincerely doubt that
>> the same
>> truncation does not actually apply to immediates.
>>
>> And if the entire immediate value does apply, the manual should certainly
>> specify what should happen in that case.  And at present it doesn't.
>>
>> It seems to me the bug is the bare use of GEN_OPIVI_GVEC_TRANS and thence
>> do_opivi_gvec.  The ZX parameter should be extended to more than just
>> "zero vs
>> sign-extend", it should have an option for truncating the immediate to
>> s->sew.
>>
>>
>> r~
>>
>
> The latest spec specified:
>
> Only the low *lg2(SEW) bits* are read to obtain the shift amount from a *register
> value*.
> The *immediate* is treated as an *unsigned shift amount*, with a *maximum
> shift amount of 31*.
>
> Looks like the shift amount in the immediate value is not relevant with
> SEW setting.
> If so, is it better to just use do_opivi_gvec() and implement the logic by
> our own rather than using gvec IR?
>
>
> In my opinion, it doesn't matter to truncate the immediate to s->sew
> before calling the gvec IR,
> whether the constraint of immediate exits or not.
>
> Zhiwei
>
>
> Frank Chang
>
>
>
The current issue I've encountered is the test like:

*vsetvli t0,t0,e8,m1,tu,mu,d1*
*vsll.vi <http://vsll.vi> v30, v30, 27*
where the SEW is 8 (i.e. vece = 0), but the immediate value is: 27.
The instruction doesn't violate the requirement specified in spec as its
value is less then 31.
However, it can't pass *tcg_debug_assert(shift >= 0 && shift < (8 <<
vece));* assertion if tcg debug option is enabled.

Frank Chang

--000000000000eebb8c05aa5f64bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jul 14, 2020 at 11:35 AM LIU Zhiw=
ei &lt;<a href=3D"mailto:zhiwei_liu@c-sky.com">zhiwei_liu@c-sky.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
 =20
   =20
 =20
  <div>
    <br>
    <br>
    <div>On 2020/7/14 10:59, Frank Chang wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">On Sat, Jul 11, 2020 at 12:27 AM Richard
          Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" tar=
get=3D"_blank">richard.henderson@linaro.org</a>&gt;
          wrote:<br>
        </div>
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/10/20 3:48=
 AM, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chan=
g@sifive.com</a> wrote:<br>
            &gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive=
.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
            &gt; <br>
            &gt; <a href=3D"http://vsll.vi" rel=3D"noreferrer" target=3D"_b=
lank">vsll.vi</a>, <a href=3D"http://vsrl.vi" rel=3D"noreferrer" target=3D"=
_blank">vsrl.vi</a>, <a href=3D"http://vsra.vi" rel=3D"noreferrer" target=
=3D"_blank">vsra.vi</a> cannot use shli gvec as
            it requires the<br>
            &gt; shift immediate value to be within the range: [0.. SEW
            bits].<br>
            &gt; Otherwise, it will hit the assertion:<br>
            &gt; tcg_debug_assert(shift &gt;=3D 0 &amp;&amp; shift &lt; (8
            &lt;&lt; vece));<br>
            &gt; <br>
            &gt; However, RVV spec does not have such constraint,
            therefore we have to<br>
            &gt; use helper functions instead.<br>
            <br>
            Why do you say that?=C2=A0 It does have such a constraint:<br>
            <br>
            # Only the low lg2(SEW) bits are read to obtain the shift
            amount from a<br>
            register value.<br>
            <br>
            While that only talks about the register value, I sincerely
            doubt that the same<br>
            truncation does not actually apply to immediates.<br>
            <br>
            And if the entire immediate value does apply, the manual
            should certainly<br>
            specify what should happen in that case.=C2=A0 And at present i=
t
            doesn&#39;t.<br>
            <br>
            It seems to me the bug is the bare use of
            GEN_OPIVI_GVEC_TRANS and thence<br>
            do_opivi_gvec.=C2=A0 The ZX parameter should be extended to mor=
e
            than just &quot;zero vs<br>
            sign-extend&quot;, it should have an option for truncating the
            immediate to s-&gt;sew.<br>
            <br>
            <br>
            r~<br>
          </blockquote>
          <div><br>
          </div>
          <div>The latest spec specified:</div>
          <div><br>
          </div>
          Only the low <b>lg2(SEW) bits</b> are read to obtain the
          shift amount from a <b>register value</b>.<br>
          <div>The <b>immediate</b> is treated as an <b>unsigned shift
              amount</b>, with a <b>maximum shift amount of 31</b>.</div>
          <div><br>
          </div>
          <div>Looks like the shift amount in the immediate value is not
            relevant with SEW setting.</div>
          <div>If so, is it better to just use do_opivi_gvec() and
            implement the logic by our own rather than using gvec IR?</div>
        </div>
      </div>
    </blockquote>
    <br>
    In my opinion, it doesn&#39;t matter to truncate the immediate to
    s-&gt;sew before calling the gvec IR, <br>
    whether the constraint of immediate exits or not. <br>
    <br>
    Zhiwei<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div><br>
          </div>
          <div>Frank Chang</div>
        </div>
      </div>
    </blockquote>
    <br></div></blockquote><div><br></div><div>The current issue I&#39;ve e=
ncountered is the test like:</div><div><i>vsetvli	t0,t0,e8,m1,tu,mu,d1<br><=
/i></div><div><i><a href=3D"http://vsll.vi">vsll.vi</a> v30, v30, 27</i></d=
iv><div>where the SEW is 8 (i.e. vece =3D 0), but the immediate value is: 2=
7.</div><div>The instruction doesn&#39;t violate the requirement specified =
in spec as its value is less then 31.</div><div>However, it can&#39;t pass =
<i style=3D"">tcg_debug_assert(shift &gt;=3D 0 &amp;&amp; shift &lt; (8
            &lt;&lt; vece));</i> assertion if tcg debug option is enabled.<=
/div><div><br></div><div>Frank Chang</div></div></div>

--000000000000eebb8c05aa5f64bf--

