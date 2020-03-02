Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25AB21739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25AB21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8u56-0007WP-1i
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8u4P-0006yV-9m
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8u4M-0002H6-Px
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:01:52 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:62823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8u4L-0002FO-1D; Mon, 02 Mar 2020 18:01:49 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 29E9B747DFA;
 Tue,  3 Mar 2020 00:01:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E14C5747DCF; Tue,  3 Mar 2020 00:01:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DF20374637E;
 Tue,  3 Mar 2020 00:01:44 +0100 (CET)
Date: Tue, 3 Mar 2020 00:01:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <87d09u8yyh.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2003022251231.47473@zero.eik.bme.hu>
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
 <878skpxltm.fsf@linaro.org> <FE03C155-E46D-4925-BA2B-FABBE2518C8C@gmail.com>
 <2576fd41-8b01-91a0-ca56-792ce65b5092@linaro.org>
 <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
 <87d09u8yyh.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1683699610-1583190104=:47473"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1683699610-1583190104=:47473
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2020, Alex Benn=C3=A9e wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Sun, 1 Mar 2020, Richard Henderson wrote:
>>> On 3/1/20 4:13 PM, Programmingkid wrote:
>>>> Ok, I was just looking at Intel's x87 chip documentation. It
>>>> supports IEEE 754 floating point operations and exception flags.
>>>> This leads me to this question. Would simply taking the host
>>>> exception flags and using them to set the PowerPC's FPU's flag be
>>>> an acceptable solution to this problem?
>>
>> In my understanding that's what is currently done, the problem with
>> PPC as Richard said is the non-sticky versions of some of these bits
>> which need clearing FP exception status before every FPU op which
>> seems to be expensive and slower than using softfloat. So to use
>> hardfloat we either accept that we can't emulate these bits with
>> hardfloat or we need to do something else than clearing flags and
>> checking after every FPU op.
>>
>> While not emulating these bits don't seem to matter for most clients
>> and other PPC emulations got away with it, QEMU prefers accuracy over
>> speed even for rarely used features.
>>
>>> No.
>>>
>>> The primary issue is the FPSCR.FI flag.  This is not an accumulative =
bit, per
>>> ieee754, but per operation.
>>>
>>> The "hardfloat" option works (with other targets) only with ieee745
>>> accumulative exceptions, when the most common of those exceptions, in=
exact, has
>>> already been raised.  And thus need not be raised a second time.
>>
>> Why exactly it's done that way? What are the differences between IEEE
>> FP implementations that prevents using hardfloat most of the time
>> instead of only using it in some (although supposedly common) special
>> cases?
>
> There are a couple of wrinkles. As far as NaN and denormal behaviour
> goes we have enough slack in the spec that different guests have
> slightly different behaviour. See pickNaN and friends in the soft float
> specialisation code. As a result we never try and hand off to hardfloat
> for NaNs, Infs and Zeros. Luckily testing for those cases if a fairly
> small part of the cost of the calculation.
>
> Also things tend to get unstuck on changes to rounding modes.
> Fortunately it doesn't seem to be supper common.

OK but how do these relate to inexact flag and why is that the one that's=
=20
checked for using hardfloat? Also rounding mode is checked but why can't=20
we set the same mode on host and why only use hardfloat in one specific=20
rounding mode? These two checks seem to further limit hardfloat use beyon=
d=20
the above cases or are these the same?

> You can read even more detail in the paper that originally prompted
> Emilio's work:
>
>  "supporting the neon and VFP instruction sets in an LLVM-based
>   binary translator"
>   https://www.thinkmind.org/download.php?articleid=3Dicas_2015_5_20_200=
33

I've only had a quick look at it but seems to not discuss all details.=20
They say the ARM instruction they wanted to emulate have some non-standar=
d=20
flush-to-zero behaviour where exceptions (including inexact) are handled=20
differently. Is this related to the check above and if yes shouldn't that=
=20
only apply to ARM target? Other standard compliant target probably should=
=20
not be limited by this.

They've also found out that clearing and reading host FP flags is "slower=
=20
than QEMU" which is what we have for PPC currently. They say the solution=
=20
is to not use host exceptions at all but calculate the exception flags=20
from software looking at inputs and result instead maybe trying different=
=20
FP ops that test for the exception cases. Unfortunately this paper does=20
not describe how exactly that's done just say maybe it will be described=20
later. It seems like kind of softfloat but using FPU for actual=20
calculation and deduce exeptions without access to intermediate reaults=20
that softfloat may be using. So they can use hardware for calculation=20
which should be the largest part and calculate the flags from software.=20
This way they claim 1.24 to 3.36 times speed up compared to then QEMU=20
(using only softfloat I guess which is still what we have for PPC today).

>>> Per the PowerPC architecture, inexact must be recognized afresh for e=
very
>>> operation.  Which is cheap in hardware but expensive in software.
>>>
>>> And once you're done with FI, FR has been and continues to be emulate=
d incorrectly.
>>
>> I think CPUs can also raise exceptions when they detect the condition
>> in hardware so maybe we should install our FPU exception handler and
>> set guest flags from that then we don't need to check and won't have
>> problem with these bits either. Why is that not possible or isn't
>> done?
>
> One of my original patches did just this:
>
>  Subject: [PATCH] fpu/softfloat: use hardware sqrt if we can (EXPERIMEN=
T!)
>  Date: Tue, 20 Feb 2018 21:01:37 +0000
>  Message-Id: <20180220210137.18018-1-alex.bennee@linaro.org>

It's this patch:
http://patchwork.ozlabs.org/patch/875764/

This at least shows where to hook in FP exception handling but based on=20
the above paper maybe that's not the best solution after all but may wort=
h=20
a try anyway in case it's simpler than what they did.

> The two problems you run into are:
>
> - relying on a trap for inexact will be slow if you keep hitting it

Which is slower? Clearing exception flags before every op and reading the=
m=20
again or trapping for exceptions? I'd expect even if exceptions are commo=
n=20
they should be less frequent than every op (otherwise they would not be=20
"exceptional").

> - reading host FPU flag registers turns out to be pretty expensive

That's what using exceptions should avoid. If we only need to read and=20
clear flags when exception happens that should be less frequent than doin=
g=20
that for every FP op. Hopefully even with the additional overhead of=20
calling the handler if all the handler has to do is set a corresponding=20
flag in a global.

Regards,
BALATON Zoltan
--3866299591-1683699610-1583190104=:47473--

