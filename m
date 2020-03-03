Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538CCC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF7221D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fC2sxLJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF7221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vA9-0006qa-BX
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8v9U-0006EM-JF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8v9T-0007vI-G8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:11:12 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8v9T-0007uE-97
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:11:11 -0500
Received: by mail-pg1-x542.google.com with SMTP id b1so619522pgm.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HARsVpylA93jQk3wr5knnUeg3ev/jLI7nAcGD3O8xb4=;
 b=fC2sxLJxb5FXTbVl9425cnwM8p9b62I5TAnN/sF9iKvbiirxiRz2YtzWAuljAGODtm
 weZcvwHWtozJUP34e8u90QMCpPvAXSAbNalm+ZYHYVlhzFSpVVesJCbLLCj3WtNwb6cz
 1kZ0sod6WVgRGKajxji8GZ9bgr13T/e0GagYRBC0jg0y3EVTLyB82p01AS7/bcfUj+to
 1tHeq+ngLIwKXQaVIeClCiUX4cu1yfOD+snYLEziu0lFD733ksneESlL+2qhP0/DyQkZ
 4Buy6NZhwvGC0KJjyhRKYWDoUGs2NS626iXL32TqZanaT6o9G1HGbliXKEyAsusnBmLM
 FzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HARsVpylA93jQk3wr5knnUeg3ev/jLI7nAcGD3O8xb4=;
 b=iBPcHvijPVsG2jUr7sKnRR61b4BvAbyS1/+zNUdoE1kmK6YA+eWHM8Sx24DjC2BaVS
 qCT7kNqhhSX0lqKxjtHmA46F/Qmxr2CG0C/ZjesqBf0ESqSu9+GPoorzODF/AjDxAZJH
 h1lx+VaEpFM/HIxlcI4/N/ZrLRzhNfz/wMM/9RF8ZnhNxSWM2t4x2tMmV0Ww3MIPGZyC
 yWROGyA/MpaB9KXTbYkqxNtMyMqqabndpoEi+4g3Pdz0NfIBvgxTFYXVZrsRfvSiMIvZ
 qGZ8FfGMpmsaVbpcMjtsOp4SkwO7FNIkK/Lzp78Opnq4flIburgsreeKTwuzgsg9aPuD
 wpJQ==
X-Gm-Message-State: ANhLgQ0bFl4rpTwfJsQM8pNuydgo6fVY5jMdl+F90rn9nIIY0T2cXCpX
 Yaz/pxuYgk00VczWi7Eygwutfw==
X-Google-Smtp-Source: ADFU+vuWie7Eyed1pn0MdgOOLVGmwm+Brkf9isSyLR4GbeS8Omkb3z4kCRMvnfS6ljVGp7NrPbdd1A==
X-Received: by 2002:aa7:829a:: with SMTP id s26mr1494647pfm.64.1583194270125; 
 Mon, 02 Mar 2020 16:11:10 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w128sm21891692pgb.55.2020.03.02.16.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 16:11:09 -0800 (PST)
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
 <d136165f-46c7-8983-9725-2b224742deef@linaro.org>
 <alpine.BSF.2.22.395.2003030002340.47473@zero.eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ffecedad-d695-ebef-d494-fce307631223@linaro.org>
Date: Mon, 2 Mar 2020 16:11:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003030002340.47473@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
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

On 3/2/20 3:16 PM, BALATON Zoltan wrote:
>> (2) IEEE has a number of implementation choices for corner cases, and we need
>> to implement the target's choices, not the host's choices.
> 
> But how is that related to inexact flag and float_round_nearest_even rounding
> mode which are the only two things can_use_fpu() function checks for?

float_round_nearest_even is the default rounding mode, and is what the host fpu
has been set for.  In order to use hardfloat for a different rounding mode, we
would need to change the host fpu control register, which is slow.

Inexact is the only flag that we cannot compute easily from the inputs and
output.  We check for NaN and Inf as inputs and outputs,
which is the clue that we may have to raise Invalid or Overflow.


r~

