Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6184C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB08621D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB08621D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uJT-0002Ag-Ta
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8uIm-0001Xe-D6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8uIk-0006y5-DS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:16:43 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:35767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8uIh-0006sv-Sd; Mon, 02 Mar 2020 18:16:42 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8DAE7747DFE;
 Tue,  3 Mar 2020 00:16:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 64DF7747DFA; Tue,  3 Mar 2020 00:16:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62836747DCF;
 Tue,  3 Mar 2020 00:16:37 +0100 (CET)
Date: Tue, 3 Mar 2020 00:16:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <d136165f-46c7-8983-9725-2b224742deef@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2003030002340.47473@zero.eik.bme.hu>
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
 <d136165f-46c7-8983-9725-2b224742deef@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1850427645-1583190997=:47473"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
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

--3866299591-1850427645-1583190997=:47473
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2020, Richard Henderson wrote:
> On 3/2/20 3:42 AM, BALATON Zoltan wrote:
>>> The "hardfloat" option works (with other targets) only with ieee745
>>> accumulative exceptions, when the most common of those exceptions, in=
exact, has
>>> already been raised.=C2=A0 And thus need not be raised a second time.
>>
>> Why exactly it's done that way? What are the differences between IEEE =
FP
>> implementations that prevents using hardfloat most of the time instead=
 of only
>> using it in some (although supposedly common) special cases?
>
> While it is possible to read the host's ieee exception word after the h=
ardfloat
> operation, there are two reasons that is undesirable:
>
> (1) It is *slow*.  So slow that it's faster to run the softfloat code i=
nstead.
> I thought it would be easier to find the benchmark numbers that Emilio
> generated when this was tested, but I can't find it.

I remember those benchmarks too and this is also what the paper Alex=20
referred to also confirmed. Also I've found that enabling hardfloat for=20
PPC without doing anything else is slightly slower (on a recent CPU, on=20
older CPUs could be even slower). Interetingly however it does give a=20
speedup for vector instructions (maybe because they don't clear flags=20
between each sub operation). Does that mean these vector instruction=20
helpers are also buggy regarding exceptions?

> (2) IEEE has a number of implementation choices for corner cases, and w=
e need
> to implement the target's choices, not the host's choices.

But how is that related to inexact flag and float_round_nearest_even=20
rounding mode which are the only two things can_use_fpu() function checks=
=20
for?

>> I think CPUs can also raise exceptions when they detect the condition =
in
>> hardware so maybe we should install our FPU exception handler and set =
guest
>> flags from that then we don't need to check and won't have problem wit=
h these
>> bits either. Why is that not possible or isn't done?
>
> If we have to enable and disable host fpu exceptions going in and out o=
f
> softfloat routines, we're back to modifying the host fpu control word, =
which as
> described above, is *slow*.
>
>> That handler could only
>> set a global flag on each exception that targets can be checked by tar=
gets and
>> handle differences. This global flag then can include non-sticky versi=
ons if
>> needed because clearing a global should be less expensive than clearin=
g FPU
>> status reg. But I don't really know, just guessing, somone who knows m=
ore about
>> FPUs probably knows a better way.
>
> I don't know if anyone has tried that variant, where we simply leave th=
e
> exceptions enabled, leave the signal handler enabled, and use a global.
>
> Feel free to try it and benchmark it.

I probably won't try any time soon. I have several other half finished=20
stuff to hack on to not take up another one I likely can't finish, but=20
hope this discussion inspires someone to try it. I'm also interested in=20
the results. If nobody tries in the next two years maybe I get there=20
eventually.

Regards,
BALATON Zoltan
--3866299591-1850427645-1583190997=:47473--

