Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1458EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 00:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C920524695
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 00:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEm4dg9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C920524695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8YjB-00059h-2a
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 19:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j8YiZ-0004hP-EE
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j8YiX-0004e7-Nz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 19:13:55 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:35702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j8YiX-0004dk-Go; Sun, 01 Mar 2020 19:13:53 -0500
Received: by mail-yw1-xc43.google.com with SMTP id a132so1035703ywb.2;
 Sun, 01 Mar 2020 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Y71sxCSUk5FwSYmqU67+ejOcqO5U4q2p0cMxMZxBVmA=;
 b=SEm4dg9ycQ8lZLs1Qx2BJLpKQVrqVCVIbCItZVL+bP8zRsEMETnn2lyIjbVqmr25Bw
 X+drxb8KC3s3cOANPgfDDRro4KcvTw451mxYr7izWVWwQ2JNnkwDiKl5goRu8coatoDl
 G35EHAxaW8w9QLE//ukkuN38w0lSh3L8QC8wEgWPqHri0h7IeNp1uNuewXcLeBMVLjEP
 WCid1euh7Of8cefem0wwOdKBhV13BbzEQc21Wf847GOQR2UDGhG6CSLlFKxDeGPRo4sX
 yEg1P3fjdmsZmBEV2km1LigEhORs6aUDcyE6gCIoHlYe6HBFJALwlrQxBOV8QN88lgiG
 z6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Y71sxCSUk5FwSYmqU67+ejOcqO5U4q2p0cMxMZxBVmA=;
 b=DvJDiFethComMGU74TxFJcegDYA0q/aR9pHIPy3oMw/MZ31lpYLD8Ltynn2+5iUkr6
 wnNNatxJgbemSOljDxrFuvcZyeV7emX2XfS4R9tnwp8b4b3BcAtNynhRCO7C3iJ6Urb8
 T+KqLwKawM+faGJk8s/pnCWRLt8vMmYKblz/el95ajfajc4vJw52AT4MZJm1lohHPYYb
 ejHHPFwc570cHMxv174oo0mpv5IlDBs9Cr0ZRutWdwHVCwvsFVDqkotYxZqVVVP6KCrs
 X+fmukGbVLU7lvrTVRrMFkPeaOWZ00uwnIaLw6xYn4GxnjJ+FSlUD0v4aeqjpB5qv+bv
 hJQg==
X-Gm-Message-State: APjAAAXoK96Q/59RpwhAB0MP7/K30C/2mwn0Ktp0sIn6v8K/mM0yysXH
 ECyXFiqTmS6+JxGjKubxF6U=
X-Google-Smtp-Source: APXvYqwe6UuyMsuFqP21LsgtM20z+0JUaStfccPLhu9ETrRYfAKrExwhGB6LAeQimKqazycOINjQjA==
X-Received: by 2002:a25:97c8:: with SMTP id j8mr11288761ybo.209.1583108032344; 
 Sun, 01 Mar 2020 16:13:52 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id t15sm4081885ywg.20.2020.03.01.16.13.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 01 Mar 2020 16:13:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <878skpxltm.fsf@linaro.org>
Date: Sun, 1 Mar 2020 19:13:49 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE03C155-E46D-4925-BA2B-FABBE2518C8C@gmail.com>
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
 <878skpxltm.fsf@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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


> On Feb 26, 2020, at 1:09 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
>=20
> G 3 <programmingkidx@gmail.com> writes:
>=20
>> Accuracy is an important part of the IEEE 754 floating point =
standard. The
>> whole purpose of this standard is to ensure floating point =
calculations are
>> consistent across multiple CPUs. I believe referring to this patch as
>> inaccurate is itself inaccurate. That gives the impression that this =
patch
>> produces calculations that are not inline with established standards. =
This
>> is not true. The only part of this patch that will produce incorrect =
values
>> are the flags.
>=20
> As I stated further up the thread I'd be happy to take a patch that
> turns this on without the messing about with the FPU flags which =
AFAICT
> breaks the architectural compliance of those instructions. The ability
> to detect inexact results is part of the IEEE spec even if it is
> considerably looser about when the flag should be reset.
>=20
>> There *may* be a program or two out there that depend on
>> these flags, but for the majority of programs that only care about =
basic
>> floating point arithmetic this patch will produce correct values. =
Currently
>> the emulated PowerPC's FPU already produces wrong values for the
>> flags.
>=20
> Those are bugs that should be fixed. The state of the flags after a
> calculation should be considered part of the "values" generated by the
> FPU.
>=20
>> This patch does set the Inexact flag (which I don't like), but since =
I have
>> never encountered any source code that cares for this flag, I can let =
it
>> go. I think giving the user the ability to decide which option to use =
is
>> the best thing to do.
>=20
> Giving the user the option to break things is a poor flag, most of =
QEMUs
> configurable knobs are about trading of size/speed without affecting
> correctness.
>=20
> If the PPC maintainers are happy that hardfloat's speed trade-offs are
> worth it for usual workloads (whatever they may be) then I have no
> objection to making defaulting hardfloat to on - perhaps* even with an
> option to force softfloat if it faster for some workloads.
>=20
>>=20
>> On Wed, Feb 26, 2020 at 10:51 AM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>>=20
>>>=20
>>>=20
>>> On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e =
<alex.bennee@linaro.org>
>>> wrote:
>>>>=20
>>>>=20
>>>> Dino Papararo <skizzato73@msn.com> writes:
>>>>=20
>>>>> Please let's go with hardfloat pps support, it's really a good =
feature
>>> to implement.
>>>>> Even if in a first step it could lead to inaccuracy results, later =
it
>>>>> could solved with other patches.
>>>>=20
>>>> That's the wrong way around. We have regression tests for a reason.
>>>=20
>>> I tend to agree with Alex here, and additionally want to expand more =
on
>>> this topic.
>>>=20
>>> In my view: (that I think is at least very close to the community
>>> consensus)
>>>=20
>>> This is *not* a ppc-specific issue. There exist a principle across =
all
>>> targets
>>> that QEMU FPU calculation must be accurate - exactly as specified in =
any
>>> applicable particular ISA document. Any discrepancy is an outright =
bug.
>>>=20
>>> We even recently had several patches for FPU in ppc target that =
handled
>>> some fairly obscure cases of inaccuracies, I believe they were =
authored
>>> by Paul Clarke, so there are people in ppc community that care about
>>> FPU accuracy (as I guess is the case for any target).
>>>=20
>>> There shouldn't be a target that decides by itself and within itself
>>> "ok, we don't need accuracy, let's trade it for speed". This =
violates
>>> the architecture of QEMU. Please allow that for any given software
>>> project, there is an architecture that should be respected.
>>>=20
>>> This doesn't mean that anybody's experimentation is discouraged. =
No-one
>>> can stop anybody from forking from QEMU upstream tree and do =
whatever
>>> is wanted.
>>>=20
>>> But, this doesn't mean such experimentation will be upstreamed. QEMU
>>> upstream should be collecting place for the best ideas and =
implementations,
>>> not for arbitrary experimentations.
>>>=20
>>> Best regards,
>>> Aleksandar
>>>=20
>>>=20
>>>> I'll happily accept patches to turn on hardfloat for PPC if:
>>>>=20
>>>> a) they don't cause regressions in our fairly extensive floating =
point
>>>> tests
>>>> b) the PPC maintainers are happy with the new performance profile
>>>>=20
>>>> The way forward would be to:
>>>>=20
>>>> 1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
>>>> 2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any =
unneeded
>>>> splatting of flags (if any)
>>>> 3. measure the before/after performance effect and decide if on =
balance
>>>> it's worth keeping
>>>>=20
>>>>> I think it's important for qemu to as global as possible and don't
>>>>> target only recent hardware.
>>>>=20
>>>> Are you referring to guests or hosts? For guests we will always =
favour
>>>> accuracy of speed of emulation. For hosts we need to have IEEE =
compliant
>>>> FPU HW to even stand a chance of using hardfloat.
>>>>=20
>>>> --
>>>> Alex Benn=C3=A9e
>>>>=20
>>>=20
>=20
>=20
> --=20
> Alex Benn=C3=A9e

Ok, I was just looking at Intel's x87 chip documentation. It supports =
IEEE 754 floating point operations and exception flags. This leads me to =
this question. Would simply taking the host exception flags and using =
them to set the PowerPC's FPU's flag be an acceptable solution to this =
problem?=20

These are the flags that all CPU's that support the IEEE 754 standard =
implement:=20
   - division by zero
   - inexact
   - overflow
   - underflow
   - invalid operation

This could be an API that is used to retrieve the host flags' value:
 - get_host_div_zero_flag()
 - get_host_inexact_flag()
 - get_host_overflow_flag()
 - get_host_underflow_flag()
 - get_host_invalid_oper_flag()

We could then use this API to set the PowerPC FPU exception flags.=20

Does this sound like a good solution?=20


