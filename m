Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F45C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 08:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2641A2173B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 08:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sgow9rR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2641A2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzGHA-0005cr-4b
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 04:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzGGN-0004z8-Fv
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 04:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzGGM-0003ON-9s
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 04:10:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzGGM-0003Ng-3f
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 04:10:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id g67so425751wme.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BZdDCuqJqJYcgNGw8QD3afizhnfR29dZ+p9G36xcPhQ=;
 b=Sgow9rR8GQf8kWkpa2UR60WDiKHAcy/qnbrnP1coPvzgKj/qIlINcWDFyRdagWgIlL
 fToMiVVk9G4I9xSyFx/1ygiDqmZIpADIqGb3EHjZFhdQKWxvnJjvfKpfm3B6xIPnEjis
 hSr7pwnherdLHv+U6znkbt24EADJPv84m9+imMP4QWDm3edqEFWMMDRTAgCEkGJ9cYGi
 sBD90CLMbbz61qAed4EgijcVG1RCIx9Eg3AtNebrUUUJKiGhup4RfbNegwiObJbUSJzK
 TB/0OJ/E12caF/rCReLThpcX5MBsP0xw9HHQVgxBnvkuZ6KMxFhMqwuZ8a4MXALsW7pA
 2x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZdDCuqJqJYcgNGw8QD3afizhnfR29dZ+p9G36xcPhQ=;
 b=CrcKu1WGtlFIXs5gQsofFQ+koFmZC0X/jWIB9VKBi4ASbfVZeLo99t7Cq64q64ChqH
 Zs1KPNJ5rUB6zJ/W4l+hGqm8Ngw9uhLolMJV/aQci+jtU7o4rc011omrWlzPT00SmrEc
 MQavIlfRLooFKgdhqYWevZyrnJZeq0XY9xjSlrv8UK0gQ0Sngk9t4NKh1GQ3NtH6BjDL
 WfWzzeTlYdRS0KfR1kEz8wYr6y7RCw0YxoCC8Z0s3yUszMKfoD/n+dZ5JCLKrlQtrtgF
 lOD/p72a5SiCEXhg2MXM+GGSTAvHdqzxU2ZVcI2ILgEYrjn4c/UdOgRtdWAnQckZAt6a
 4WrA==
X-Gm-Message-State: APjAAAXbGuC+E6TOzxD5mmLcdBglssPvop+HwxkiFBYspNhNdkQFocJq
 0PX+HJ6RknB4TKQ7+3Vf9ramGg==
X-Google-Smtp-Source: APXvYqxQb1p0wS1cDGoHUva/vw9LdjPfvYplHZPAz/cwrUOxHDegIwyuCODRTQz7E77+FBr6i9RShQ==
X-Received: by 2002:a1c:a957:: with SMTP id s84mr14718936wme.65.1566115804539; 
 Sun, 18 Aug 2019 01:10:04 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id c65sm17187995wma.44.2019.08.18.01.10.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 01:10:03 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "Paul A. Clarke" <pc@us.ibm.com>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
Date: Sun, 18 Aug 2019 09:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 11:59 PM, Aleksandar Markovic wrote:
>> From: "Paul A. Clarke" <pc@us.ibm.com>
...
>>   ISA 3.0B has xscvdpspn leaving its result in word 1 of the target
> register,
>>   and mffprwz expecting its input to come from word 0 of the source
> register.
>>   This sequence fails with QEMU, as a shift is required between those two
>>   instructions.  However, the hardware splats the result to both word 0
> and
>>   word 1 of its output register, so the shift is not necessary.
>>   Expect a future revision of the ISA to specify this behavior.
>>
> 
> Hmmm... Isn't this a gcc bug (using undocumented hardware feature), given
> everything you said here?

The key here is "expect a future revision of the ISA to specify this behavior".

It's clearly within IBM's purview to adjust the specification to document a
previously undocumented hardware feature.


r~

