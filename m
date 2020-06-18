Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC18C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D6E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTQWTUWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D6E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm3fY-0005mI-KD
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3ey-0005Fa-Dl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:09:28 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3ew-00069o-61
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:09:28 -0400
Received: by mail-pf1-x441.google.com with SMTP id 64so3523647pfv.11
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DeMCD9ZgvzYWO8ceIBouP20gs0sZUCMM6IQ5zwMXNXw=;
 b=KTQWTUWTo11TkwI11hSDM6NGjDY7HlpOAu8MwQZbDs1sMrlSaR2E9xjKRy7mQvv9Ph
 rwMu+n97AKcWlZ+H+/26lrHIfGUHDiJQ7RCRYlLK+hK1BWq7cBlpsNrDjnTZHiolehBF
 Bj+1U8fbzaMil/08B0XfVnJM4nniNEC3P9FTFbwMrld3JWrvr0iWL2K9d9Cf8lktHXWg
 SaoFjRAIiayvHj0qDQbi+YY9vM4Y5oceLTv/wDUSj6Dr/UkEMOHYP6i1E/XslDGUj6qX
 aAXpx6ZRjd6Py0vmFWjQd4q9IiT1QTmA2W/Cxpswmn7uprpETcxTMOqTQXuZRnqOTmXv
 rKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DeMCD9ZgvzYWO8ceIBouP20gs0sZUCMM6IQ5zwMXNXw=;
 b=eFUQvFAUtnwIxb5Cb++f8l+MhSwcLmfolNgCQbrrdpNbEHA5XCeVdAxzWAzfCT8qGQ
 tBgud6CqM+0k2dVg1TeKis++vctKgnIffFUKCLmHYs5v7Xi8QhCEbn1YuxHO3oSj3bGs
 tbcZnM2SR1rqrkl06cLZSFBTVNMCf75JBVDZfz2TxGU+d3lDrKrSsjiYjro4QvpnJ8pc
 FnsYlIkEuMm4xSP6zh+FMRKi5FejY6CnkZwialfj8g+ckoMWDXuVz40WPjQbjtcue/Zb
 JTXnu+grz/rp6pmhL3IpnX0I0IUaqGUrUj+nhrpPqQLb5RiO+EIH1S2iBIbbh8MEyAQX
 V3DA==
X-Gm-Message-State: AOAM530UjH+gi9bJhkwrEZw+JfRsAFHf7WmHQ0+QaRkMPU1EhRrdqSSV
 4mHUX3X0ZXqijIVCGXHbvMzsuj0yLsY=
X-Google-Smtp-Source: ABdhPJyrF6pAgxoNtP0yBQfPSqcgWC47QoIb4MS10jdnubzQPnX2L+7vcTMqPDYGZDSgPz3n31YxvQ==
X-Received: by 2002:a63:f408:: with SMTP id g8mr765757pgi.184.1592521764323;
 Thu, 18 Jun 2020 16:09:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z14sm3893997pfj.64.2020.06.18.16.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:09:23 -0700 (PDT)
Subject: Re: [PATCH v2] target/ppc: add vmsumudm vmsumcud instructions
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200613035546.22041-1-ljp@linux.ibm.com>
 <4f0e24af-5043-98d3-0f7b-e8d460bac617@linaro.org>
 <73404995-1D90-4E2B-A328-CA5C47C933D5@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13dac383-7d04-faf2-7a87-c4e92e693148@linaro.org>
Date: Thu, 18 Jun 2020 16:09:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <73404995-1D90-4E2B-A328-CA5C47C933D5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 1:53 PM, Lijun Pan wrote:
>>> +static inline void uint128_add(uint64_t ah, uint64_t al, uint64_t bh,
>>> +		uint64_t bl, uint64_t *rh, uint64_t *rl, uint64_t *ca)
>>> +{
>>> +	__uint128_t a = (__uint128_t)ah << 64 | (__uint128_t)al;
>>> +	__uint128_t b = (__uint128_t)bh << 64 | (__uint128_t)bl;
>>> +	__uint128_t r = a + b;
>>> +
>>> +	*rh = (uint64_t)(r >> 64);
>>> +	*rl = (uint64_t)r;
>>> +	*ca = (~a < b);
>>> +}
>>
>> This is *not* what I had in mind at all.
>>
>> int128.h should be operating on Int128, and *not* component uint64_t values.
> 
> Should uint128_add() be included in a new file called uint128.h? or still at host-utils.h?

If you want this sort of specific operation, you should leave it in target/ppc/.

I had been hoping that you could make use of Int128 as-is, or with minimal
adjustment in the same style.

> vmsumudm/vmsumcud operate as follows:
> 1. 128-bit prod1 = (high 64 bits of a) * (high 64 bits of b), // I reuse mulu64()
> 2. 128-bit prod2 = (high 64 bits of b) * (high 64 bits of b), // I reuse mulu64()
> 3. 128-bit result = prod1 + prod2 + c; // I added addu128() in v1, renamed it to uint128_add() in v2

Really?  That seems a very odd computation.  Your code,

> +	prod1 = (__uint128_t)ah * (__uint128_t)bh;
> +	prod2 = (__uint128_t)al * (__uint128_t)bl;
> +	r = prod1 + prod2 + c;

is slightly different, but still very odd.

Why would we be adding the intermediate 128th bit of the 256-bit product
(prod1, bit 0) with the 0th bit of the 256-bit product (prod2, bit 0).

Unfortunately, I can't find the v3.1 spec online yet, so I can't look at this
myself.  What is the instruction supposed to produce?

> To better understand your request, may I ask you several questions:
> 1. keep mulsum() in target/ppc/int_helper.c?

Probably.

> If so, it will inevitably have  #ifdef CONFIG_INT128 #else #endif in that function.  

No, you don't have to ifdef.  You can use uint64_t alone and not rely on
compiler support for __uint128_t at all.


r~

