Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D05C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0586120838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl47yjBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0586120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6yyY-0001tH-6z
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6yxu-0001HL-2q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6yxs-000430-Lr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:51:13 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6yxs-000423-G2; Wed, 26 Feb 2020 10:51:12 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so3405440otd.2;
 Wed, 26 Feb 2020 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C9lhhcNPy2HWUmWE8Kn9+PrxwCx4WWJo+IeC/i85UWw=;
 b=Xl47yjBxa5NpYrL9jroJJYNahV0bMG4Vuw+BFp9DO+C/j3tpsTuQnrt6xi8sy9tTmu
 rgVHBNjqonZVZGmLUUcO8yKoRCJlMW7CWoHu4YHaxG1ehU1mENooFDzrs/fMQpXK8W4q
 430WP6Wjhw5mEuZ5ZSSI3+WXncaAYhD27YOhmQIHWgKxmnKf7bYD2InAG8JytGRUihDT
 hfBzffHalHejvX3SDHn5oTPmNPyl2R8/tv/1lzi15WfBN3zqlDDPNxg0ByGPqNtPPJSL
 00qgbnywqPfV0CX8HOuS+uoy0vpXPJzybQrkHwkEwB3Fun912+60mZJMIbq2ucN0HxCY
 c3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C9lhhcNPy2HWUmWE8Kn9+PrxwCx4WWJo+IeC/i85UWw=;
 b=neMn/nzZYriscEGY5Ojs7KgRnwr95WE7JxeetmZLY0MSQnCTM5+KV+8V9GZztb3uXD
 VW9IDpB8LorUop+J69vuJrZIpj0MAMPmWaP4LFW8mtmgSX0Cqf6r994if1pwmSFKSWKQ
 QdRmyr+jMFemcPUwhHi9/+H/w0/HkyzDsWMfKBrUQ6swcfzGphXv8rsFP38keqJ68YGF
 8dBf/2BmOnEGMcBg2KR1+0a5eRB0f92MgIzh0mee3Bo2QWDqg8Zfgzq9mg4nCSJL8oCc
 62sl+JwaNExEbQojTQya7pHCHxZhbIeo2VhbaYm2CxdpIOgRHgmA6uwXJ+wn3s0q+0GB
 lJlw==
X-Gm-Message-State: APjAAAURdCvF3MfG8cwMX5T/lrY6nLQh0khi1AB1vdzU+ZOpDJFK4rDX
 MVJHzecVqpyR+dNsD3EcnNPie/Xf8YW/imT13OY=
X-Google-Smtp-Source: APXvYqwZZBW6+TQgK8CYlTukF0xbm8ljGxpDPMb7OUSlabo1Nv0H7L/odhxj3AeA1+QBzdlKjMdCOhvxi+QM2vXwm+M=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr3480801otk.64.1582732271221;
 Wed, 26 Feb 2020 07:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
In-Reply-To: <87eeuhxw0y.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 16:50:58 +0100
Message-ID: <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cd05e7059f7c9255"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd05e7059f7c9255
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Dino Papararo <skizzato73@msn.com> writes:
>
> > Please let's go with hardfloat pps support, it's really a good feature
to implement.
> > Even if in a first step it could lead to inaccuracy results, later it
> > could solved with other patches.
>
> That's the wrong way around. We have regression tests for a reason.

I tend to agree with Alex here, and additionally want to expand more on
this topic.

In my view: (that I think is at least very close to the community consensus=
)

This is *not* a ppc-specific issue. There exist a principle across all
targets
that QEMU FPU calculation must be accurate - exactly as specified in any
applicable particular ISA document. Any discrepancy is an outright bug.

We even recently had several patches for FPU in ppc target that handled
some fairly obscure cases of inaccuracies, I believe they were authored
by Paul Clarke, so there are people in ppc community that care about
FPU accuracy (as I guess is the case for any target).

There shouldn't be a target that decides by itself and within itself
"ok, we don't need accuracy, let's trade it for speed". This violates
the architecture of QEMU. Please allow that for any given software
project, there is an architecture that should be respected.

This doesn't mean that anybody's experimentation is discouraged. No-one
can stop anybody from forking from QEMU upstream tree and do whatever
is wanted.

But, this doesn't mean such experimentation will be upstreamed. QEMU
upstream should be collecting place for the best ideas and implementations,
not for arbitrary experimentations.

Best regards,
Aleksandar


> I'll happily accept patches to turn on hardfloat for PPC if:
>
>  a) they don't cause regressions in our fairly extensive floating point
>  tests
>  b) the PPC maintainers are happy with the new performance profile
>
> The way forward would be to:
>
>  1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
>  2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any unneeded
>  splatting of flags (if any)
>  3. measure the before/after performance effect and decide if on balance
>  it's worth keeping
>
> > I think it's important for qemu to as global as possible and don't
> > target only recent hardware.
>
> Are you referring to guests or hosts? For guests we will always favour
> accuracy of speed of emulation. For hosts we need to have IEEE compliant
> FPU HW to even stand a chance of using hardfloat.
>
> --
> Alex Benn=C3=A9e
>

--000000000000cd05e7059f7c9255
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e &=
lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt;=
 wrote:<br>&gt;<br>&gt;<br>&gt; Dino Papararo &lt;<a href=3D"mailto:skizzat=
o73@msn.com">skizzato73@msn.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; Please=
 let&#39;s go with hardfloat pps support, it&#39;s really a good feature to=
 implement.<br>&gt; &gt; Even if in a first step it could lead to inaccurac=
y results, later it<br>&gt; &gt; could solved with other patches.<br>&gt;<b=
r><div>&gt; That&#39;s the wrong way around. We have regression tests for a=
 reason.</div><div><br></div><div>I tend to agree with Alex here, and addit=
ionally want to expand more on</div><div>this topic.</div><div><br></div><d=
iv>In my view: (that I think is at least very close to the community consen=
sus)<br></div><div><br></div><div>This is *not* a ppc-specific issue. There=
 exist a principle across all targets</div><div>that QEMU FPU calculation m=
ust be accurate - exactly as specified in any</div><div>applicable particul=
ar ISA document. Any discrepancy is an outright bug.</div><div><br></div><d=
iv>We even recently had several patches for FPU in ppc target that handled<=
/div><div>some fairly obscure cases of inaccuracies, I believe they were au=
thored</div><div>by Paul Clarke, so there are people in ppc community that =
care about</div><div>FPU accuracy (as I guess is the case for any target).<=
br></div><div><br></div><div>There shouldn&#39;t be a target that decides b=
y itself and within itself</div><div>&quot;ok, we don&#39;t need accuracy, =
let&#39;s trade it for speed&quot;. This violates</div><div>the architectur=
e of QEMU. Please allow that for any given software</div><div>project, ther=
e is an architecture that should be respected.<br></div><div><br></div><div=
>This doesn&#39;t mean that anybody&#39;s experimentation is discouraged. N=
o-one</div><div>can stop anybody from forking from QEMU upstream tree and d=
o whatever</div><div>is wanted.</div><div><br></div><div>But, this doesn&#3=
9;t mean such experimentation will be upstreamed. QEMU</div><div>upstream s=
hould be collecting place for the best ideas and implementations,</div><div=
>not for arbitrary experimentations.</div><div><br></div><div>Best regards,=
</div><div>Aleksandar<br></div><div><br></div><div><br></div><div></div>&gt=
;  I&#39;ll happily accept patches to turn on hardfloat for PPC if:<br>&gt;=
<br>&gt; =C2=A0a) they don&#39;t cause regressions in our fairly extensive =
floating point<br>&gt; =C2=A0tests<br>&gt; =C2=A0b) the PPC maintainers are=
 happy with the new performance profile<br>&gt;<br>&gt; The way forward wou=
ld be to:<br>&gt;<br>&gt; =C2=A01. patch to drop #if defined(TARGET_PPC) ||=
 defined(__FAST_MATH__)<br>&gt; =C2=A02. audit target/ppc/fpu_helper.c w.r.=
t chip manual and fix any unneeded<br>&gt; =C2=A0splatting of flags (if any=
)<br>&gt; =C2=A03. measure the before/after performance effect and decide i=
f on balance<br>&gt; =C2=A0it&#39;s worth keeping<br>&gt;<br>&gt; &gt; I th=
ink it&#39;s important for qemu to as global as possible and don&#39;t<br>&=
gt; &gt; target only recent hardware.<br>&gt;<br>&gt; Are you referring to =
guests or hosts? For guests we will always favour<br>&gt; accuracy of speed=
 of emulation. For hosts we need to have IEEE compliant<br>&gt; FPU HW to e=
ven stand a chance of using hardfloat.<br>&gt;<br>&gt; --<br>&gt; Alex Benn=
=C3=A9e<br>&gt;<br></div>

--000000000000cd05e7059f7c9255--

