Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE3C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6B42465D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7ccIPB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6B42465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71oD-0001XI-Vi
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j71md-0000P7-Nh
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j71mc-0007U6-1k
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:51:47 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j71mb-0007RT-SL; Wed, 26 Feb 2020 13:51:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id b18so605884oie.2;
 Wed, 26 Feb 2020 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yDF1hnCrfNGayvyXqcyqGUj5djCxuR4JcjvlqtA5400=;
 b=b7ccIPB9cpw3SCRsEbKlbrQg+fXBCLwd1cLYQJ+9p2RA5oBfp1dSq9Ylir1SIKiM11
 8JbxpNUy4TTukgRyCgJ5SBJ8DHeGGJ0r+gVR/EQG0ZDpXwPMmZq1q3B5qoe0rlKrsG9/
 Fys500A8TZJxR/Ay1eahq3Hmwyy0v9sAPqEONdJI/U6W3x+lvU5I/mxr/O+LwG2GL1VY
 keJWtsoKbyK5md7pj5Ix/OsJm+Gks8A0aC20tR33velPEln+teBZ1dn9A6ItVGVp0vNy
 LKEWl2+bN+1qk6OoZdW0XQI1kKO+Evo3KnPNY1rYQD0CksbgdYY94Qu9M09Fpdc4SaT6
 2wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yDF1hnCrfNGayvyXqcyqGUj5djCxuR4JcjvlqtA5400=;
 b=lT4y+TiekcVCgWPp+kF5q7AC0IP1u2v1/JJ5ENLXsXfL+UBCMvRnGLF9Opypxras+n
 Z9cNg5luurFKT+08SIkmcuOsW9pikSBw7DXe3X4pzUVchtMgNePvhCSDmBAx5rqbMStV
 oQy1/tPsD8o/a+kbFvxRFeuoEtZae8BaGuTz/wyMw4arhDALkovAC7OICCYkSPhDl/0Q
 987WYkzArNkgXeQQqGSfR7o2isGfsEeasrhMIoxK1S/pxYrGcmKfyYuZuhcUt5E+LT3h
 azy2nHa1ncDFxg2pWgYNl+9fB2aUkTCXammmKtJ1rw4AlBNekKc4JJVmp1/6CUdZEtXe
 Ihwg==
X-Gm-Message-State: APjAAAVZVcfCV1YSNUQtdnS0twA5ljh++foqt+j6znkjtuLi2IzWUhUF
 M3nUkvbXnP/12XiXTQl002TKNoKxR1l4jMO5CUc=
X-Google-Smtp-Source: APXvYqzeqNSMTve6UEyD/NNAWTWFMTeJJR6dqTybM3jX+mGBdb0b11QtX9TzjCyS23G/2mxI63vQhHxD0V7WOEccdfw=
X-Received: by 2002:aca:5844:: with SMTP id m65mr349608oib.136.1582743104955; 
 Wed, 26 Feb 2020 10:51:44 -0800 (PST)
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
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
 <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
 <AM4PR07MB350693B43AE3987D317948ADCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
In-Reply-To: <AM4PR07MB350693B43AE3987D317948ADCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 19:51:33 +0100
Message-ID: <CAL1e-=iiL8r0P0smAYfU=Fo0yj4QsHjC7OpDFQ-7BhTryEhPnQ@mail.gmail.com>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: Dino Papararo <skizzato73@msn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>, "cota@braap.org" <cota@braap.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 7:14 PM Dino Papararo <skizzato73@msn.com> wrote:
>
> I think we all agree the best solution is to resolve powerpc issues about=
 hardfloat current implementation.
> I think also powerpc is an important branch of qemu, for hystorical, pres=
ent and (why not?) future reasons, and it must NOT be left behind.
> So I would invite best Qemu community's skilled programmers to work on th=
is and solve the issue maybe in few days.
> The same group who worked on recent altivec optimizations is able to make=
 a good patch even for this.
>
> In a subordinate way I'd like to implement anyway hardfloat support for p=
owerpc, advising users about inaccurancy of results/flags and letting them =
choose.

Just to be clear, concluding from your surrounding sentences, you don't
mean here to implement "hardfloat support for powerpc", but something
like "improve performance of ppc FPU emulation by misusing hardfloat
support and giving up accuracy". I think we have to be honest between
ourselves.

Regards,
Aleksandar

> Of course I understand, and in part agree, on all your objections.
> Simply I prefer have always a choice.
>
> Best Regards,
> Dino Papararo
>
> -----Messaggio originale-----
> Da: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Inviato: mercoled=C3=AC 26 febbraio 2020 18:27
> A: G 3 <programmingkidx@gmail.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>; Dino Papararo <skizzato73@=
msn.com>; QEMU Developers <qemu-devel@nongnu.org>; qemu-ppc@nongnu.org; How=
ard Spoelstra <hsp.cat7@gmail.com>; luigi burdo <intermediadc@hotmail.com>;=
 David Gibson <david@gibson.dropbear.id.au>
> Oggetto: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>
> On Wed, Feb 26, 2020 at 6:04 PM G 3 <programmingkidx@gmail.com> wrote:
> >
> > Accuracy is an important part of the IEEE 754 floating point standard. =
The whole purpose of this standard is to ensure floating point calculations=
 are consistent across multiple CPUs. I believe referring to this patch as =
inaccurate is itself inaccurate. That gives the impression that this patch =
produces calculations that are not inline with established standards. This =
is not true. The only part of this patch that will produce incorrect values=
 are the flags. There *may* be a program or two out there that depend on th=
ese flags, but for the majority of programs that only care about basic floa=
ting point arithmetic this patch will produce correct values. Currently the=
 emulated PowerPC's FPU already produces wrong values for the flags. This p=
atch does set the Inexact flag (which I don't like), but since I have never=
 encountered any source code that cares for this flag, I can let it go. I t=
hink giving the user the ability to decide which option to use is the best =
thing to do.
> >
>
> From the experiments described above, the patch in question changes the b=
ehavior of applications (for example, sound is different with and without t=
he patch), which is in contradiction with your claim that you "never encoun=
tered any source code that cares for this flag" and that "the only part of =
this patch that will produce incorrect values are the flags".
>
> In other words, and playing further with them:
>
> The claim that "referring to this patch as inaccurate is itself inaccurat=
e" is itself inaccurate.
>
> Best regards,
> Aleksandar
>
>
> > On Wed, Feb 26, 2020 at 10:51 AM Aleksandar Markovic <aleksandar.m.mail=
@gmail.com> wrote:
> >>
> >>
> >>
> >> On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >> >
> >> >
> >> > Dino Papararo <skizzato73@msn.com> writes:
> >> >
> >> > > Please let's go with hardfloat pps support, it's really a good fea=
ture to implement.
> >> > > Even if in a first step it could lead to inaccuracy results,
> >> > > later it could solved with other patches.
> >> >
> >> > That's the wrong way around. We have regression tests for a reason.
> >>
> >> I tend to agree with Alex here, and additionally want to expand more
> >> on this topic.
> >>
> >> In my view: (that I think is at least very close to the community
> >> consensus)
> >>
> >> This is *not* a ppc-specific issue. There exist a principle across
> >> all targets that QEMU FPU calculation must be accurate - exactly as
> >> specified in any applicable particular ISA document. Any discrepancy i=
s an outright bug.
> >>
> >> We even recently had several patches for FPU in ppc target that
> >> handled some fairly obscure cases of inaccuracies, I believe they
> >> were authored by Paul Clarke, so there are people in ppc community
> >> that care about FPU accuracy (as I guess is the case for any target).
> >>
> >> There shouldn't be a target that decides by itself and within itself
> >> "ok, we don't need accuracy, let's trade it for speed". This violates
> >> the architecture of QEMU. Please allow that for any given software
> >> project, there is an architecture that should be respected.
> >>
> >> This doesn't mean that anybody's experimentation is discouraged.
> >> No-one can stop anybody from forking from QEMU upstream tree and do
> >> whatever is wanted.
> >>
> >> But, this doesn't mean such experimentation will be upstreamed. QEMU
> >> upstream should be collecting place for the best ideas and
> >> implementations, not for arbitrary experimentations.
> >>
> >> Best regards,
> >> Aleksandar
> >>
> >>
> >> > I'll happily accept patches to turn on hardfloat for PPC if:
> >> >
> >> >  a) they don't cause regressions in our fairly extensive floating
> >> > point  tests
> >> >  b) the PPC maintainers are happy with the new performance profile
> >> >
> >> > The way forward would be to:
> >> >
> >> >  1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
> >> > 2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any
> >> > unneeded  splatting of flags (if any)  3. measure the before/after
> >> > performance effect and decide if on balance  it's worth keeping
> >> >
> >> > > I think it's important for qemu to as global as possible and
> >> > > don't target only recent hardware.
> >> >
> >> > Are you referring to guests or hosts? For guests we will always
> >> > favour accuracy of speed of emulation. For hosts we need to have
> >> > IEEE compliant FPU HW to even stand a chance of using hardfloat.
> >> >
> >> > --
> >> > Alex Benn=C3=A9e
> >> >

