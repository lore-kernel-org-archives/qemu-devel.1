Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E45246B6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3fQNBhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E45246B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ci7-00066m-R3
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 23:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8chQ-0005Zw-KC
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8chP-0005Tg-G1
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:29:00 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8chP-0005TV-8Y
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:28:59 -0500
Received: by mail-pl1-x644.google.com with SMTP id g6so3677692plp.6
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 20:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ggkPERYoO0l1s1R5xU83EsvDuqSg7Mz0smp6isNcmCo=;
 b=F3fQNBhOkwlz+/486xi6A7iwZr0e97f21Vmno2A8YCcmvKjHjyaB9mIYBOea25fAWT
 AG4rEA2iCN0AXMIMsVDJQp8WJD7O0jDi2omJwto7iIqgkFUUitQmFAeNb8rl4pI1cktu
 BRFrll/axWr99RpMe22h5LhQEkJK38dZ/4EVdyu3i+d6fexl4E7kOUW+yiF3SvT1gycA
 idOgC2rGSeN8akSANjXSJxMnbSeKnbZMS8ng2LPN6yimW0pC5CI7y4G8H5M43rKY+tfS
 Lrhdqg1h47vqsAoTn6zFfBhrv4YUym39G0sLk55fuE2+AHcsixjfwVaFY6yLofBp7+YW
 tI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ggkPERYoO0l1s1R5xU83EsvDuqSg7Mz0smp6isNcmCo=;
 b=WYGegrDGVy2qow0w2Kh5QeXVMCduttCfkQZsNg6dvcaswyaz4OghWnIjsnyOylC8WI
 wSRo0suzOvJ+ONjktQ5Eiz7IiZQA+e8tqyBrEw7ZJLTnNmbwQI+sncahBGU5jJubIBV3
 W4jDLCC0Jjg1fVERIFMfrOdGYnV5RlNPth8UvhZiTlb4cEp3P7R3cb5Og5zU8fyZmOCc
 3UeS3hHSreS5j4B6pfVOs85ojIuckRqPKggMQlNMum3JGhcc3kKNwYEb4MsdMBucqgye
 9Syad+N5K0xSWFwrZGgnOx2fLG4V4Nm4Qo24JAdNQ9MnNlWvy+lZWBc1QGr+WWshw6EV
 VYRQ==
X-Gm-Message-State: APjAAAVZ36iqxADOxCEt+mz2meGOCc+MLMeit0NPc5YXffqAorho27IE
 srjpJ4FHHXTecnWZ30cYrOeBNQ==
X-Google-Smtp-Source: APXvYqyQs9DdsseaPN5ERKrUdN6txHMV6ofUzo/FpXcL5O+uUBuEo3mcdxJI7dqFjROoQ/V5ScgjmQ==
X-Received: by 2002:a17:902:b949:: with SMTP id
 h9mr16617797pls.57.1583123338176; 
 Sun, 01 Mar 2020 20:28:58 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i24sm412944pfo.92.2020.03.01.20.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 20:28:57 -0800 (PST)
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: Programmingkid <programmingkidx@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
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
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2576fd41-8b01-91a0-ca56-792ce65b5092@linaro.org>
Date: Sun, 1 Mar 2020 20:28:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <FE03C155-E46D-4925-BA2B-FABBE2518C8C@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 3/1/20 4:13 PM, Programmingkid wrote:
> Ok, I was just looking at Intel's x87 chip documentation. It supports IEEE 754 floating point operations and exception flags. This leads me to this question. Would simply taking the host exception flags and using them to set the PowerPC's FPU's flag be an acceptable solution to this problem? 

No.

The primary issue is the FPSCR.FI flag.  This is not an accumulative bit, per
ieee754, but per operation.

The "hardfloat" option works (with other targets) only with ieee745
accumulative exceptions, when the most common of those exceptions, inexact, has
already been raised.  And thus need not be raised a second time.

Per the PowerPC architecture, inexact must be recognized afresh for every
operation.  Which is cheap in hardware but expensive in software.

And once you're done with FI, FR has been and continues to be emulated incorrectly.


r~

