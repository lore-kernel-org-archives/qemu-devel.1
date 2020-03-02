Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF4C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A6921775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocWRyNjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A6921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8obP-00015q-DM
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8oaS-0000C6-23
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8oaQ-0005Ny-7O
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:10:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8oaP-0005Nh-Uq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:10:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id n7so633749wrt.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=R6APj7DdAefTT7Rhx8kpfWajX0cRra514I2s+GEEDtI=;
 b=ocWRyNjmAiJf3KNItmgL39rYz/ZQgtzMIKmQ2DGsaytdcL15YDV4GCHUpgI/PhmXIL
 8AYWDgz7WIafwmSZOlDouHhLQuf9ObasYDQpIi+35tIdZBEPlTiTIgmg/p/dRLisaUZR
 KnJaOVdMkP2r0ORMVgX+p7dcy0kHdlXJZr+ojNGXIGk2D4vaLgbYmQP0048CCRA3vklB
 +jJj7KnqsiKhDoMcYFY+MtO5aBeBsuKiUiu8wgCHUNJWZHeG6V8OknXCPfS2AycGZa8f
 b2LQL9qikMo3II0tDk2sIv7/uJp7iE6ykiLqF0bzkptN9j6xoL8K0ne9FWBvWk5KZRrg
 vEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=R6APj7DdAefTT7Rhx8kpfWajX0cRra514I2s+GEEDtI=;
 b=RCfMysdsg+i6OaUQNE03ap4Db3rLgQRH8O6q7xwNlSmCRkkgx2iOITZ5bWCjGyjYxd
 1goMO90o46LWOPPwrR/oXhCJHfveloWcuYgOo42vDYDt3uztdvVY4UshfNwaqfcjVLmS
 lUmLU0+y31QZ6iKGGdCTKmPn51ImmgGFhX0EmQk7d06UAMQvohCR+jDkzSwmSV4+jnOn
 p79yRJPBijelbK/piuTYSOYAlbt5lD8qsZGA7revFL5ElAxqhFJXgJLCZOveDb2JJdqk
 cXZOljsQbrOEZlSeN23BOs/0/nMoz96UqHxLKM3CllPd+p4Nuwazo2gtIe73pafZhQjD
 gmGQ==
X-Gm-Message-State: ANhLgQ2dBQiixansiiA40t7pDyEpGH1T+IUj95Olaxjf5cjXvkctL9qi
 SZtljfNmQMgSOgvVLEtJjGrY3g==
X-Google-Smtp-Source: ADFU+vvK+rMTNJI3QGPzmeMkX/qzF2C3exykYTYfKqnxi0sE3cnYw1ReTlIYnHWxrKej+i1Iv/iYVw==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr539854wro.51.1583169032043;
 Mon, 02 Mar 2020 09:10:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm1161345wrr.45.2020.03.02.09.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:10:30 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F03C1FF87;
 Mon,  2 Mar 2020 17:10:30 +0000 (GMT)
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
 <FE03C155-E46D-4925-BA2B-FABBE2518C8C@gmail.com>
 <2576fd41-8b01-91a0-ca56-792ce65b5092@linaro.org>
 <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-reply-to: <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
Date: Mon, 02 Mar 2020 17:10:30 +0000
Message-ID: <87d09u8yyh.fsf@linaro.org>
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


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Sun, 1 Mar 2020, Richard Henderson wrote:
>> On 3/1/20 4:13 PM, Programmingkid wrote:
>>> Ok, I was just looking at Intel's x87 chip documentation. It
>>> supports IEEE 754 floating point operations and exception flags.
>>> This leads me to this question. Would simply taking the host
>>> exception flags and using them to set the PowerPC's FPU's flag be
>>> an acceptable solution to this problem?
>
> In my understanding that's what is currently done, the problem with
> PPC as Richard said is the non-sticky versions of some of these bits
> which need clearing FP exception status before every FPU op which
> seems to be expensive and slower than using softfloat. So to use
> hardfloat we either accept that we can't emulate these bits with
> hardfloat or we need to do something else than clearing flags and
> checking after every FPU op.
>
> While not emulating these bits don't seem to matter for most clients
> and other PPC emulations got away with it, QEMU prefers accuracy over
> speed even for rarely used features.
>
>> No.
>>
>> The primary issue is the FPSCR.FI flag.  This is not an accumulative bit=
, per
>> ieee754, but per operation.
>>
>> The "hardfloat" option works (with other targets) only with ieee745
>> accumulative exceptions, when the most common of those exceptions, inexa=
ct, has
>> already been raised.  And thus need not be raised a second time.
>
> Why exactly it's done that way? What are the differences between IEEE
> FP implementations that prevents using hardfloat most of the time
> instead of only using it in some (although supposedly common) special
> cases?

There are a couple of wrinkles. As far as NaN and denormal behaviour
goes we have enough slack in the spec that different guests have
slightly different behaviour. See pickNaN and friends in the soft float
specialisation code. As a result we never try and hand off to hardfloat
for NaNs, Infs and Zeros. Luckily testing for those cases if a fairly
small part of the cost of the calculation.

Also things tend to get unstuck on changes to rounding modes.
Fortunately it doesn't seem to be supper common.=20

You can read even more detail in the paper that originally prompted
Emilio's work:

  "supporting the neon and VFP instruction sets in an LLVM-based
   binary translator"
   https://www.thinkmind.org/download.php?articleid=3Dicas_2015_5_20_20033

>> Per the PowerPC architecture, inexact must be recognized afresh for every
>> operation.  Which is cheap in hardware but expensive in software.
>>
>> And once you're done with FI, FR has been and continues to be emulated i=
ncorrectly.
>
> I think CPUs can also raise exceptions when they detect the condition
> in hardware so maybe we should install our FPU exception handler and
> set guest flags from that then we don't need to check and won't have
> problem with these bits either. Why is that not possible or isn't
> done?

One of my original patches did just this:

  Subject: [PATCH] fpu/softfloat: use hardware sqrt if we can (EXPERIMENT!)
  Date: Tue, 20 Feb 2018 21:01:37 +0000
  Message-Id: <20180220210137.18018-1-alex.bennee@linaro.org>

The two problems you run into are:

 - relying on a trap for inexact will be slow if you keep hitting it
 - reading host FPU flag registers turns out to be pretty expensive

> The softfloat code has a comment that working with exceptions is
> not pleasent but why? Isn't setting flags from a handler easier than
> checking separately for each op? If this is because of differences in
> how flags are handled by different targets we don't have to do that
> from the host FPU exception handler. That handler could only set a
> global flag on each exception that targets can be checked by targets
> and handle differences. This global flag then can include non-sticky
> versions if needed because clearing a global should be less expensive
> than clearing FPU status reg. But I don't really know, just guessing,
> somone who knows more about FPUs probably knows a better way.
>
> Regards,
> BALATON Zoltan


--=20
Alex Benn=C3=A9e

