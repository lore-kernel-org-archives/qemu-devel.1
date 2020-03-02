Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5CDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DB2222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mql4TFbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB2222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8oNE-0004mE-QO
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8oM4-0003Wg-8Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8oM2-0001ui-UU
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:55:43 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8oM2-0001sd-B9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:55:42 -0500
Received: by mail-pf1-x441.google.com with SMTP id q9so10653pfs.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EzT9uRaY9gQORX5Lh+od6C/QJcDspBhPN3bKLFpbCiA=;
 b=Mql4TFbwhsr6pM/wIFnPm4WaWRGHIeul80eL+ZQfM8tBc7RZ7tt1TNCbPR69kSyMyb
 MmIA4e0Z1sLeIKADR0PWP7S5W2/skmVr6S3+qHDH2ZHyrAo02ywKD1BhyRKdlcCe6VE+
 FhJ94FSeUxV8SfBOIFVkA9fwgIBcA8VCdNdbkjX6PQ9lXMYq2YmgdEHdX7+c5lddwMnN
 mPcrzGila76py0ZgkGSAiJ4rhFqrgC8SlNtUT68tnrMpv5zL82ydnXuj4RQ9WUzVZOVr
 TZdeT/dQz689Rs9gMLjmVR4t7WtsMVaRj93cm8ku+ycs644sSLK07bon2zh4wwiyk8ue
 NaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EzT9uRaY9gQORX5Lh+od6C/QJcDspBhPN3bKLFpbCiA=;
 b=qVCY2LZ8nLL5dW6xz9VsrfK+2ghsfr2JoyR/pGd8pYwamyFDWzGw3But2UHHSupcrl
 pIROvsks3sNeOdiwFPqcykaKk36e2R1gnvVEVzK13WZs2qNLzwxtGCV1ZYa4mUUSLTT3
 3CXTtQ9pgjIykbFRzHaHE0MmLgsdWjtluEdLDBurr4f1Hx5QPo5fVponWTNVxvhT9jAN
 5WYcENVfgxCnqTKOsUJBi/xv8402UfXN1jlJeZfmDrPmKBp9sXrmJjxPuNugWcUdthQi
 5xCDwq4WmB5eAjJfJ5fVnuE53sWh7zel6btXBks/9zn2arEOA1TKvqjlUnHn+sSJxjrH
 Df6A==
X-Gm-Message-State: ANhLgQ0+bXPQfmaA+Ndo3ZD5w/WWP6/YjgZ9LpWRdreOWxC03WNMQH/V
 3PBQEzp4n5AeGXaJApg0Oo6a0w==
X-Google-Smtp-Source: ADFU+vsvEAm1bw3c48oHUZH+OJXZ59ErFv/u/jx8OV617BvSXuCM3LDRoZ0RK5J9sMYlbvPVrLnDrg==
X-Received: by 2002:a62:1709:: with SMTP id 9mr19074pfx.196.1583168140986;
 Mon, 02 Mar 2020 08:55:40 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h74sm175292pjb.46.2020.03.02.08.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 08:55:40 -0800 (PST)
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
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
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d136165f-46c7-8983-9725-2b224742deef@linaro.org>
Date: Mon, 2 Mar 2020 08:55:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 3:42 AM, BALATON Zoltan wrote:
>> The "hardfloat" option works (with other targets) only with ieee745
>> accumulative exceptions, when the most common of those exceptions, inexact, has
>> already been raised.  And thus need not be raised a second time.
> 
> Why exactly it's done that way? What are the differences between IEEE FP
> implementations that prevents using hardfloat most of the time instead of only
> using it in some (although supposedly common) special cases?

While it is possible to read the host's ieee exception word after the hardfloat
operation, there are two reasons that is undesirable:

(1) It is *slow*.  So slow that it's faster to run the softfloat code instead.
 I thought it would be easier to find the benchmark numbers that Emilio
generated when this was tested, but I can't find it.

(2) IEEE has a number of implementation choices for corner cases, and we need
to implement the target's choices, not the host's choices.

> I think CPUs can also raise exceptions when they detect the condition in
> hardware so maybe we should install our FPU exception handler and set guest
> flags from that then we don't need to check and won't have problem with these
> bits either. Why is that not possible or isn't done?

If we have to enable and disable host fpu exceptions going in and out of
softfloat routines, we're back to modifying the host fpu control word, which as
described above, is *slow*.

> That handler could only
> set a global flag on each exception that targets can be checked by targets and
> handle differences. This global flag then can include non-sticky versions if
> needed because clearing a global should be less expensive than clearing FPU
> status reg. But I don't really know, just guessing, somone who knows more about
> FPUs probably knows a better way.

I don't know if anyone has tried that variant, where we simply leave the
exceptions enabled, leave the signal handler enabled, and use a global.

Feel free to try it and benchmark it.


r~

