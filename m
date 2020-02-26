Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF5C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B54620801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaOJCMMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B54620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j708P-0005Xf-DZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j7070-0004Rk-Ns
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j706y-0007ab-TH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:04:42 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j706y-0007Md-Dn; Wed, 26 Feb 2020 12:04:40 -0500
Received: by mail-lj1-x242.google.com with SMTP id o15so3944605ljg.6;
 Wed, 26 Feb 2020 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9g9JAEFBabOEuVsE3+Aj/EUGVTXQuPQ10SJm3NYyXnQ=;
 b=NaOJCMMs1+EJczm681cR0ldqEXr3NsEkKdQZB5j/5MeL6g2dq8jgp3Ubl1BNtJqOEj
 0ygucQWzC2/xTc2UygYel9Fgpp0HNSwoTSPxrptF9rR3Ibp137paOmJZq/m/GArRW4BW
 ZtaXqdDIGH7GLk5l6JRdUkMJFuNbey44PK6koFbGHwYZ89V+L4KU52BQTrbmGV/Hggb8
 J8lDItVY04ptXZBUKI+EoTH7i4shImh8fIlRzpFxr7iknRSnw+hHnzNRFjauS/YUARfM
 RAXgbnoKRdVR9M4Y1xwTETAxK6oqAFFAY9gdpt64SNMPQo3M94iAYBeyLZsM4uTh0ZTT
 Vxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9g9JAEFBabOEuVsE3+Aj/EUGVTXQuPQ10SJm3NYyXnQ=;
 b=EC4+HzwEQYLDQ30FCAFmsJgHl5o5RrXpmu0Nh/weoEf4+ARPuKWHSVpVCW2S9lYWKt
 BOZPhSlpzIANPll0ac/F6G86pMilVsGOVGH04N3coMG2suOkB3zLjR/fbCOKEnkUFdzT
 uhOviVvsGjk+BQbt+9mZHb00IMXSQEqeT2tuIsARCIVujSccqu7gjSNMESHn5AWy7fJ4
 AT/OjYXDja71Uj8uOXzqWVfM5OpSa5e1OUccw4aQgZwyfCgpE4H7/auXMUYb2k0ZH1aL
 xrfQ/zTMe3Ng4ziD0/47LkHzGjTBE097Y3AXo5RXaM2DFpW0Jk3pp/stBwirJ48mUGpX
 X32g==
X-Gm-Message-State: ANhLgQ1zcZyagrd7shuCZqc80PieXkWQnxlj9Sf3cOAp4WfApgQ15LGQ
 fvfEb550tSiFQNXq6048OKh2PMpVbZEtMaAQrw0=
X-Google-Smtp-Source: APXvYqyOEvTPF4fh/Poe0eR/NcetdtXlqpyNdpKPE/2yQply2O8QxVy5vSUMlwqsDfTFBUegajuFfRV5BM5zHdRevug=
X-Received: by 2002:a2e:99c5:: with SMTP id l5mr3490883ljj.88.1582736678436;
 Wed, 26 Feb 2020 09:04:38 -0800 (PST)
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
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
In-Reply-To: <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 26 Feb 2020 12:04:26 -0500
Message-ID: <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007dc369059f7d9997"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007dc369059f7d9997
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Accuracy is an important part of the IEEE 754 floating point standard. The
whole purpose of this standard is to ensure floating point calculations are
consistent across multiple CPUs. I believe referring to this patch as
inaccurate is itself inaccurate. That gives the impression that this patch
produces calculations that are not inline with established standards. This
is not true. The only part of this patch that will produce incorrect values
are the flags. There *may* be a program or two out there that depend on
these flags, but for the majority of programs that only care about basic
floating point arithmetic this patch will produce correct values. Currently
the emulated PowerPC's FPU already produces wrong values for the flags.
This patch does set the Inexact flag (which I don't like), but since I have
never encountered any source code that cares for this flag, I can let it
go. I think giving the user the ability to decide which option to use is
the best thing to do.

On Wed, Feb 26, 2020 at 10:51 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
> >
> >
> > Dino Papararo <skizzato73@msn.com> writes:
> >
> > > Please let's go with hardfloat pps support, it's really a good featur=
e
> to implement.
> > > Even if in a first step it could lead to inaccuracy results, later it
> > > could solved with other patches.
> >
> > That's the wrong way around. We have regression tests for a reason.
>
> I tend to agree with Alex here, and additionally want to expand more on
> this topic.
>
> In my view: (that I think is at least very close to the community
> consensus)
>
> This is *not* a ppc-specific issue. There exist a principle across all
> targets
> that QEMU FPU calculation must be accurate - exactly as specified in any
> applicable particular ISA document. Any discrepancy is an outright bug.
>
> We even recently had several patches for FPU in ppc target that handled
> some fairly obscure cases of inaccuracies, I believe they were authored
> by Paul Clarke, so there are people in ppc community that care about
> FPU accuracy (as I guess is the case for any target).
>
> There shouldn't be a target that decides by itself and within itself
> "ok, we don't need accuracy, let's trade it for speed". This violates
> the architecture of QEMU. Please allow that for any given software
> project, there is an architecture that should be respected.
>
> This doesn't mean that anybody's experimentation is discouraged. No-one
> can stop anybody from forking from QEMU upstream tree and do whatever
> is wanted.
>
> But, this doesn't mean such experimentation will be upstreamed. QEMU
> upstream should be collecting place for the best ideas and implementation=
s,
> not for arbitrary experimentations.
>
> Best regards,
> Aleksandar
>
>
> > I'll happily accept patches to turn on hardfloat for PPC if:
> >
> >  a) they don't cause regressions in our fairly extensive floating point
> >  tests
> >  b) the PPC maintainers are happy with the new performance profile
> >
> > The way forward would be to:
> >
> >  1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
> >  2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any unneede=
d
> >  splatting of flags (if any)
> >  3. measure the before/after performance effect and decide if on balanc=
e
> >  it's worth keeping
> >
> > > I think it's important for qemu to as global as possible and don't
> > > target only recent hardware.
> >
> > Are you referring to guests or hosts? For guests we will always favour
> > accuracy of speed of emulation. For hosts we need to have IEEE complian=
t
> > FPU HW to even stand a chance of using hardfloat.
> >
> > --
> > Alex Benn=C3=A9e
> >
>

--0000000000007dc369059f7d9997
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Accuracy is an important part of the IEEE 754 floatin=
g point standard. The whole purpose of this standard is to ensure floating =
point calculations are consistent across multiple CPUs. I believe referring=
 to this patch as inaccurate is itself inaccurate. That gives the impressio=
n that this patch produces calculations that are not inline with establishe=
d standards. This is not true. The only part of this patch that will produc=
e incorrect values are the flags. There *may* be a program or two out there=
 that depend on these flags, but for the majority of programs that only car=
e about basic floating point arithmetic this patch will produce correct val=
ues. Currently the emulated PowerPC&#39;s FPU already produces wrong values=
 for the flags. This patch does set the Inexact flag (which I don&#39;t lik=
e), but since I have never encountered any source code that cares for this =
flag, I can let it go. I think giving the user the ability to decide which =
option to use is the best thing to do.<br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 10:=
51 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com=
">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><br><br>On Wed, Feb 26, 2020 =
at 3:29 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" t=
arget=3D"_blank">alex.bennee@linaro.org</a>&gt; wrote:<br>&gt;<br>&gt;<br>&=
gt; Dino Papararo &lt;<a href=3D"mailto:skizzato73@msn.com" target=3D"_blan=
k">skizzato73@msn.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; Please let&#39;s=
 go with hardfloat pps support, it&#39;s really a good feature to implement=
.<br>&gt; &gt; Even if in a first step it could lead to inaccuracy results,=
 later it<br>&gt; &gt; could solved with other patches.<br>&gt;<br><div>&gt=
; That&#39;s the wrong way around. We have regression tests for a reason.</=
div><div><br></div><div>I tend to agree with Alex here, and additionally wa=
nt to expand more on</div><div>this topic.</div><div><br></div><div>In my v=
iew: (that I think is at least very close to the community consensus)<br></=
div><div><br></div><div>This is *not* a ppc-specific issue. There exist a p=
rinciple across all targets</div><div>that QEMU FPU calculation must be acc=
urate - exactly as specified in any</div><div>applicable particular ISA doc=
ument. Any discrepancy is an outright bug.</div><div><br></div><div>We even=
 recently had several patches for FPU in ppc target that handled</div><div>=
some fairly obscure cases of inaccuracies, I believe they were authored</di=
v><div>by Paul Clarke, so there are people in ppc community that care about=
</div><div>FPU accuracy (as I guess is the case for any target).<br></div><=
div><br></div><div>There shouldn&#39;t be a target that decides by itself a=
nd within itself</div><div>&quot;ok, we don&#39;t need accuracy, let&#39;s =
trade it for speed&quot;. This violates</div><div>the architecture of QEMU.=
 Please allow that for any given software</div><div>project, there is an ar=
chitecture that should be respected.<br></div><div><br></div><div>This does=
n&#39;t mean that anybody&#39;s experimentation is discouraged. No-one</div=
><div>can stop anybody from forking from QEMU upstream tree and do whatever=
</div><div>is wanted.</div><div><br></div><div>But, this doesn&#39;t mean s=
uch experimentation will be upstreamed. QEMU</div><div>upstream should be c=
ollecting place for the best ideas and implementations,</div><div>not for a=
rbitrary experimentations.</div><div><br></div><div>Best regards,</div><div=
>Aleksandar<br></div><div><br></div><div><br></div><div></div>&gt;  I&#39;l=
l happily accept patches to turn on hardfloat for PPC if:<br>&gt;<br>&gt; =
=C2=A0a) they don&#39;t cause regressions in our fairly extensive floating =
point<br>&gt; =C2=A0tests<br>&gt; =C2=A0b) the PPC maintainers are happy wi=
th the new performance profile<br>&gt;<br>&gt; The way forward would be to:=
<br>&gt;<br>&gt; =C2=A01. patch to drop #if defined(TARGET_PPC) || defined(=
__FAST_MATH__)<br>&gt; =C2=A02. audit target/ppc/fpu_helper.c w.r.t chip ma=
nual and fix any unneeded<br>&gt; =C2=A0splatting of flags (if any)<br>&gt;=
 =C2=A03. measure the before/after performance effect and decide if on bala=
nce<br>&gt; =C2=A0it&#39;s worth keeping<br>&gt;<br>&gt; &gt; I think it&#3=
9;s important for qemu to as global as possible and don&#39;t<br>&gt; &gt; =
target only recent hardware.<br>&gt;<br>&gt; Are you referring to guests or=
 hosts? For guests we will always favour<br>&gt; accuracy of speed of emula=
tion. For hosts we need to have IEEE compliant<br>&gt; FPU HW to even stand=
 a chance of using hardfloat.<br>&gt;<br>&gt; --<br>&gt; Alex Benn=C3=A9e<b=
r>&gt;<br></div>
</blockquote></div>

--0000000000007dc369059f7d9997--

