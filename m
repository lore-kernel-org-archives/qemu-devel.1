Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3329214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3329214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jUO-0002vI-0U
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8jTa-0002Px-Jb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8jTY-0004e1-U6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:43:09 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:23408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8jTY-0004bq-O7; Mon, 02 Mar 2020 06:43:08 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5516374637C;
 Mon,  2 Mar 2020 12:42:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2C62D745953; Mon,  2 Mar 2020 12:42:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 29EBF74569F;
 Mon,  2 Mar 2020 12:42:57 +0100 (CET)
Date: Mon, 2 Mar 2020 12:42:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <2576fd41-8b01-91a0-ca56-792ce65b5092@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
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
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: Dino Papararo <skizzato73@msn.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Mar 2020, Richard Henderson wrote:
> On 3/1/20 4:13 PM, Programmingkid wrote:
>> Ok, I was just looking at Intel's x87 chip documentation. It supports 
>> IEEE 754 floating point operations and exception flags. This leads me 
>> to this question. Would simply taking the host exception flags and 
>> using them to set the PowerPC's FPU's flag be an acceptable solution to 
>> this problem?

In my understanding that's what is currently done, the problem with PPC as 
Richard said is the non-sticky versions of some of these bits which need 
clearing FP exception status before every FPU op which seems to be 
expensive and slower than using softfloat. So to use hardfloat we either 
accept that we can't emulate these bits with hardfloat or we need to do 
something else than clearing flags and checking after every FPU op.

While not emulating these bits don't seem to matter for most clients and 
other PPC emulations got away with it, QEMU prefers accuracy over speed 
even for rarely used features.

> No.
>
> The primary issue is the FPSCR.FI flag.  This is not an accumulative bit, per
> ieee754, but per operation.
>
> The "hardfloat" option works (with other targets) only with ieee745
> accumulative exceptions, when the most common of those exceptions, inexact, has
> already been raised.  And thus need not be raised a second time.

Why exactly it's done that way? What are the differences between IEEE FP 
implementations that prevents using hardfloat most of the time instead of 
only using it in some (although supposedly common) special cases?

> Per the PowerPC architecture, inexact must be recognized afresh for every
> operation.  Which is cheap in hardware but expensive in software.
>
> And once you're done with FI, FR has been and continues to be emulated incorrectly.

I think CPUs can also raise exceptions when they detect the condition in 
hardware so maybe we should install our FPU exception handler and set 
guest flags from that then we don't need to check and won't have problem 
with these bits either. Why is that not possible or isn't done? The 
softfloat code has a comment that working with exceptions is not pleasent 
but why? Isn't setting flags from a handler easier than checking 
separately for each op? If this is because of differences in how flags are 
handled by different targets we don't have to do that from the host FPU 
exception handler. That handler could only set a global flag on each 
exception that targets can be checked by targets and handle differences. 
This global flag then can include non-sticky versions if needed because 
clearing a global should be less expensive than clearing FPU status reg. 
But I don't really know, just guessing, somone who knows more about FPUs 
probably knows a better way.

Regards,
BALATON Zoltan

