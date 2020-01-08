Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE0C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1DB206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4ZBAfeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1DB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozv9-0000oE-Si
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iozuU-0000FK-DV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iozuS-0000e2-KK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:13:21 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iozuS-0000dX-Df
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:13:20 -0500
Received: by mail-pl1-x643.google.com with SMTP id s21so407769plr.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 17:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=81BrgS9WWJ+d5e8LvhW0vX2zDT1GemMSM+3dELgRUIg=;
 b=h4ZBAfehiBRmQX5CcukXP9zu992je1WRDKRFBQejSokrYp3dBoELu95iqeBjsJMtiJ
 nD1wGNVlgy7DAvIvhd964y4bcHVhcVtK7RJeannciHsJrd3c7V3lmvpKn/etcjxDF94q
 l741V1xCjJzXAizWFvrtTSyp4XsVhDav+XoIiz/6sPS5fOy/lneqhKIaCgjcJe/Jx5pa
 Wvdy5PN62w6v1dDuxfpkH38owtg1bnpTq6mywDGDWia8iODcDTPl+tBjgii4RqkYgu99
 q3G8YHA6aIERwUyAe6Xun8ykDgEtfhKyYxugp8GiiGW1y+JsHZCuMygvwvgH0erfcgvf
 Ek/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=81BrgS9WWJ+d5e8LvhW0vX2zDT1GemMSM+3dELgRUIg=;
 b=C0pwcyoeNkkVPHFbuBRtqFAcqIDsjh7TYBFWliG3eatOUur6tOmfsvJBqoPSiSP7iA
 8GOdUSMjH6FRg81AldFNAp2EJ7WCdWOw2ou2X1oHgKMbKzlSfb+FLh3rHoBB/YTsRqU5
 sfY/jPmt2W+evDm1QlgXPuIP6IKH++dMY3g/kua2/P3TtdaF7KOyHgJY4vcAXnIkJTxy
 yp1xHpaSh/5SfW3AqizgbTiAXbqoXrO+grwKQz0WXH16cMhqc3PtVK+S+zjG95dlB/yq
 4EdLfMD0KHK4ds3k6PQLSQ76paA0t1Tg6HUZjE7jWBZ1FObo0ISUAj2egNEVmbO0n4Z/
 hNIA==
X-Gm-Message-State: APjAAAWtBBTXnsN1eU5b/ndTMH6Ky5f4tAIaFZlP4njFEIGnGvh6mpNX
 r1HGXArI/s0UGBAvqXtEIMsxNw==
X-Google-Smtp-Source: APXvYqx6+ByI5cecW30Yox/qwOPJJq9PmUpYo1kLdEbAApS1XY0VO/WsBZ3K4uywRQBMLFs59k+r7Q==
X-Received: by 2002:a17:902:9348:: with SMTP id
 g8mr2747322plp.323.1578445999090; 
 Tue, 07 Jan 2020 17:13:19 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id l2sm815655pff.59.2020.01.07.17.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 17:13:18 -0800 (PST)
Subject: Re: [PATCH v2 5/5] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191220132246.6759-1-alex.bennee@linaro.org>
 <20191220132246.6759-6-alex.bennee@linaro.org>
 <09322c6e-74d9-08d0-1138-f2d5581a7244@linaro.org> <87d0bv4a0o.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <608b5fde-098d-3200-6555-314a6d794992@linaro.org>
Date: Wed, 8 Jan 2020 11:13:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87d0bv4a0o.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 12:27 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 12/21/19 12:22 AM, Alex Bennée wrote:
>>> +#if defined(__arm__)
>>> +    register uintptr_t t asm("r0") = type;
>>> +    register uintptr_t a0 asm("r1") = arg0;
>>> +    asm("svc 0xab"
>>> +        : "=r" (t)
>>> +        : "r" (t), "r" (a0));
>>
>> This is the #ifdef __thumb__ svc code.  Are you enforcing that with
>> command-line arguments?
> 
> No it is dealing with aarch64 vs 32 bit and the __arm__ is a compiler
> symbol. 

I know that.  But you're obviously assuming that the arm compiler is defaulting
to thumb mode, not arm mode, otherwise this doesn't work.

You need to test

#ifdef __arm__
# ifdef __thumb__
#  define SVC  "svc 0xab"
# else
#  define SVC  "svc 0x123456"
# endif
    register ...
    asm(SVC : ...);
#else
    // aarch64
#endif

And run the compiler with -mthumb and -marm to test both.


r~

