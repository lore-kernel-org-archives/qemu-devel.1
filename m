Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C5C4BA20
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11842465D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVJm2Doq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11842465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7189-0006ef-TQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j717T-0005zA-45
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j717R-0004qV-FF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:09:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j717R-0004pI-5y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:09:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id e8so4292434wrm.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4ZsADryMv+IgzvvPDpx+ckMqF+dMcvxdxQdNRLesCnU=;
 b=aVJm2DoqGJvuK0BRAknklCBQx3dDGDrsNgRhfUsF6pwb1MdcIcbWJNGXQLIdmE3FgC
 D4h2JcCW7BKh2s0GUpybL277uj7soe7Ug7fBy7Zwl1EN4okHe4q4q6fQQXA3t5BPEtwu
 /y6CyErUjmar2mOPgvw96x9itOLQSKniC9ogXTikFfckB482TvxkK9IcuWrICxO0Hprp
 yQxDXe9HJiX/yDMyX28Pnt5qTxvEPIAmZg65MmudA0TmC4y3x3GytraESIE2VSb8YGf4
 UV9ktZ3vqJOVObSxNsXdCMNKGJ1jbEzM+7EQuCDgty/1MpmS+qe0U7YsjYPakLdkhkoy
 LQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4ZsADryMv+IgzvvPDpx+ckMqF+dMcvxdxQdNRLesCnU=;
 b=rpBVxh45naXcJogVlfnxZ/KEx4id7Yh3AZnhKG0gL0YNB0rxgXJ+a3Cf5xl+aOhVbX
 vWdyMKPgl+Ok1K3AnP3dQ7ky1oxxCrpYDS3cKeZu7huLm+3ul6k+ZMXw6mMdY/v4recA
 W33HByCY/vhnyyguP5TDHd0DYsCcvd4NgssIku3cyhmXXT3iHkPJvEMkTW5BA8UOab07
 eoiSjJ6VMopRZip+76RvNxKrIrcxuHDBGCkUjPVtL6dXppIELgutfFBoRRNy54+N06NH
 oll30wwdmSm/7ZGfSyuzb57LBJoAircyxOzJqCpcMVNvjdTnuuXux3838OLkGMQCqMeg
 imNA==
X-Gm-Message-State: APjAAAUEWWPz6wYePh1ooSo9U7mU/ZwuMKZfnzmX9D5AoFxLWiVBgQIK
 IwWNwooklmiBqTSmUYCMsRwI0Q==
X-Google-Smtp-Source: APXvYqy948GVspRA7DfEFnN2rwRF1LYOttxWqRDzv0BzhfDpb6VYejeqA0NeQNPvVVSuBClBCnKD6g==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr6775489wrq.155.1582740551706; 
 Wed, 26 Feb 2020 10:09:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y131sm4259027wmc.13.2020.02.26.10.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:09:10 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAD911FF87;
 Wed, 26 Feb 2020 18:09:09 +0000 (GMT)
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
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: G 3 <programmingkidx@gmail.com>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-reply-to: <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
Date: Wed, 26 Feb 2020 18:09:09 +0000
Message-ID: <878skpxltm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


G 3 <programmingkidx@gmail.com> writes:

> Accuracy is an important part of the IEEE 754 floating point standard. The
> whole purpose of this standard is to ensure floating point calculations a=
re
> consistent across multiple CPUs. I believe referring to this patch as
> inaccurate is itself inaccurate. That gives the impression that this patch
> produces calculations that are not inline with established standards. This
> is not true. The only part of this patch that will produce incorrect valu=
es
> are the flags.

As I stated further up the thread I'd be happy to take a patch that
turns this on without the messing about with the FPU flags which AFAICT
breaks the architectural compliance of those instructions. The ability
to detect inexact results is part of the IEEE spec even if it is
considerably looser about when the flag should be reset.

> There *may* be a program or two out there that depend on
> these flags, but for the majority of programs that only care about basic
> floating point arithmetic this patch will produce correct values. Current=
ly
> the emulated PowerPC's FPU already produces wrong values for the
> flags.

Those are bugs that should be fixed. The state of the flags after a
calculation should be considered part of the "values" generated by the
FPU.

> This patch does set the Inexact flag (which I don't like), but since I ha=
ve
> never encountered any source code that cares for this flag, I can let it
> go. I think giving the user the ability to decide which option to use is
> the best thing to do.

Giving the user the option to break things is a poor flag, most of QEMUs
configurable knobs are about trading of size/speed without affecting
correctness.

If the PPC maintainers are happy that hardfloat's speed trade-offs are
worth it for usual workloads (whatever they may be) then I have no
objection to making defaulting hardfloat to on - perhaps* even with an
option to force softfloat if it faster for some workloads.

>
> On Wed, Feb 26, 2020 at 10:51 AM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> wrote:
>> >
>> >
>> > Dino Papararo <skizzato73@msn.com> writes:
>> >
>> > > Please let's go with hardfloat pps support, it's really a good featu=
re
>> to implement.
>> > > Even if in a first step it could lead to inaccuracy results, later it
>> > > could solved with other patches.
>> >
>> > That's the wrong way around. We have regression tests for a reason.
>>
>> I tend to agree with Alex here, and additionally want to expand more on
>> this topic.
>>
>> In my view: (that I think is at least very close to the community
>> consensus)
>>
>> This is *not* a ppc-specific issue. There exist a principle across all
>> targets
>> that QEMU FPU calculation must be accurate - exactly as specified in any
>> applicable particular ISA document. Any discrepancy is an outright bug.
>>
>> We even recently had several patches for FPU in ppc target that handled
>> some fairly obscure cases of inaccuracies, I believe they were authored
>> by Paul Clarke, so there are people in ppc community that care about
>> FPU accuracy (as I guess is the case for any target).
>>
>> There shouldn't be a target that decides by itself and within itself
>> "ok, we don't need accuracy, let's trade it for speed". This violates
>> the architecture of QEMU. Please allow that for any given software
>> project, there is an architecture that should be respected.
>>
>> This doesn't mean that anybody's experimentation is discouraged. No-one
>> can stop anybody from forking from QEMU upstream tree and do whatever
>> is wanted.
>>
>> But, this doesn't mean such experimentation will be upstreamed. QEMU
>> upstream should be collecting place for the best ideas and implementatio=
ns,
>> not for arbitrary experimentations.
>>
>> Best regards,
>> Aleksandar
>>
>>
>> > I'll happily accept patches to turn on hardfloat for PPC if:
>> >
>> >  a) they don't cause regressions in our fairly extensive floating point
>> >  tests
>> >  b) the PPC maintainers are happy with the new performance profile
>> >
>> > The way forward would be to:
>> >
>> >  1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
>> >  2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any unneed=
ed
>> >  splatting of flags (if any)
>> >  3. measure the before/after performance effect and decide if on balan=
ce
>> >  it's worth keeping
>> >
>> > > I think it's important for qemu to as global as possible and don't
>> > > target only recent hardware.
>> >
>> > Are you referring to guests or hosts? For guests we will always favour
>> > accuracy of speed of emulation. For hosts we need to have IEEE complia=
nt
>> > FPU HW to even stand a chance of using hardfloat.
>> >
>> > --
>> > Alex Benn=C3=A9e
>> >
>>


--=20
Alex Benn=C3=A9e

