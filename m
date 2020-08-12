Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D550C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4853E20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCi1hw2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4853E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5sSP-0001tt-Ih
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5sRr-0001Tf-DG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:13:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5sRp-0001Aq-JN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:13:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id u10so1238846plr.7
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=18aOA1MNEE+Phk17HQBJnjlxX6VZcW+X0ASFM82g6e4=;
 b=QCi1hw2bYQ2acKaMI8Gc7YwlUubguadvnrJSIR1ShM2dqrvdWE06rrcU5iuqqZVCAW
 sdmN30eOBZ90OhXgs8m3WT2IelH+oP6vESfV7iNfOZjIhhQNOMlPdu7pNBhxCdw0Ftqg
 iJMLF04OBiVVL7ZmzF4zP9KYFcUkNj31RelWDB+F5fhiiomDEMyXE7cianlYP6Cvbp6Q
 MvJDjTl5ZsodkTsLeHRGj2UvxPEskL1oKWZ9BZE/xHFhg6Ha0BVuvt1saYftXsukGytG
 LWROnE5CjjZ7vg22EF3bL2BY4YFoP7PHjyrY52Lo4i8J1aTgEk/biY+UPPv9yzsWBcvs
 5UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=18aOA1MNEE+Phk17HQBJnjlxX6VZcW+X0ASFM82g6e4=;
 b=hqWU3bWwygSOxdYScKV9mrHZTwbtE12lpqrVmllyrh0YWvYd7PHvgcO8MwuxFxCgwf
 Z8l2wUaxZ7xy49PEe6sdYFUOyGj+aVgbOEF5ROSl2SKcBU29kk7mHnOAYfiSakuCtNyW
 9khN3526/tstuVyD//8muLBuaGQL3AImqCx/IoRgma+IBMT8TkuFpylzMXZ3ekTyXJmg
 g8XjTz86V1d7AYVWqmFdSyY5TB1ikM/1CqQXaz3lHM/lOH4hyhsJcTpe/LUP2QJp3odf
 Xjd3pT9jikkH/lFwRDZNDU8vTVhuHkRSk7yIu9ajc5PRn/qSJYAJcOhFlogtOgYyHeh9
 ZgMw==
X-Gm-Message-State: AOAM530aL/AqwjiY8bRsXDD1jlCFLcRVggwNw6wrnF0CNOakzLKQyIrL
 KLusPMJ3JBamfvMceiqEi5LXpg==
X-Google-Smtp-Source: ABdhPJxmhH/qjZUFwAI4GgAt+f9RaNw14SVRijb+d3e8gOkjMqfr13sZO5Tkx73NeycU27ggUVctdA==
X-Received: by 2002:a17:90a:cf95:: with SMTP id
 i21mr462257pju.135.1597245227874; 
 Wed, 12 Aug 2020 08:13:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t25sm2760712pfe.51.2020.08.12.08.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 08:13:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/arm: Implement an IMPDEF pauth algorithm
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200812065339.2030527-1-richard.henderson@linaro.org>
 <20200812065339.2030527-3-richard.henderson@linaro.org>
 <87k0y419dm.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cae494be-5077-4f31-fccb-892b0e7a7770@linaro.org>
Date: Wed, 12 Aug 2020 08:13:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0y419dm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 2:49 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Without hardware acceleration, a cryptographically strong
>> algorithm is too expensive for pauth_computepac.
>>
>> Even with hardware accel, we are not currently expecting
>> to link the linux-user binaries to any crypto libraries,
>> and doing so would generally make the --static build fail.
>>
>> So choose XXH64 as a reasonably quick and decent hash.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/pauth_helper.c | 75 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 70 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
>> index 6dbab03768..f1a4389465 100644
>> --- a/target/arm/pauth_helper.c
>> +++ b/target/arm/pauth_helper.c
>> @@ -207,8 +207,8 @@ static uint64_t tweak_inv_shuffle(uint64_t i)
>>      return o;
>>  }
>>  
>> -static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
>> -                                 ARMPACKey key)
>> +static uint64_t __attribute__((noinline))
>> +pauth_computepac_architected(uint64_t data, uint64_t modifier, ARMPACKey key)
>>  {
>>      static const uint64_t RC[5] = {
>>          0x0000000000000000ull,
>> @@ -272,6 +272,71 @@ static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
>>      return workingval;
>>  }
>>  
>> +/*
>> + * The XXH64 algorithm from
>> + * https://github.com/Cyan4973/xxHash/blob/v0.8.0/xxhash.h
>> + */
>> +#define PRIME64_1   0x9E3779B185EBCA87ULL
>> +#define PRIME64_2   0xC2B2AE3D27D4EB4FULL
>> +#define PRIME64_3   0x165667B19E3779F9ULL
>> +#define PRIME64_4   0x85EBCA77C2B2AE63ULL
>> +#define PRIME64_5   0x27D4EB2F165667C5ULL
>> +
>> +static inline uint64_t XXH64_round(uint64_t acc, uint64_t input)
>> +{
>> +    return rol64(acc + input * PRIME64_2, 31) * PRIME64_1;
>> +}
>> +
>> +static inline uint64_t XXH64_mergeround(uint64_t acc, uint64_t val)
>> +{
>> +    return (acc ^ XXH64_round(0, val)) * PRIME64_1 + PRIME64_4;
>> +}
>> +
>> +static inline uint64_t XXH64_avalanche(uint64_t h64)
>> +{
>> +    h64 ^= h64 >> 33;
>> +    h64 *= PRIME64_2;
>> +    h64 ^= h64 >> 29;
>> +    h64 *= PRIME64_3;
>> +    /* h64 ^= h64 >> 32; -- does not affect high 64 for pauth */
>> +    return h64;
>> +}
>> +
>> +static uint64_t __attribute__((noinline))
>> +pauth_computepac_impdef(uint64_t data, uint64_t modifier, ARMPACKey key)
>> +{
>> +    uint64_t v1 = 1 + PRIME64_1 + PRIME64_2;
>> +    uint64_t v2 = 1 + PRIME64_2;
>> +    uint64_t v3 = 1 + 0;
>> +    uint64_t v4 = 1 - PRIME64_1;
>> +    uint64_t h64;
>> +
>> +    v1 = XXH64_round(v1, data);
>> +    v2 = XXH64_round(v2, modifier);
>> +    v3 = XXH64_round(v3, key.lo);
>> +    v4 = XXH64_round(v4, key.hi);
>> +
>> +    h64 = rol64(v1, 1) + rol64(v2, 7) + rol64(v3, 12) + rol64(v4, 18);
>> +    h64 = XXH64_mergeround(h64, v1);
>> +    h64 = XXH64_mergeround(h64, v2);
>> +    h64 = XXH64_mergeround(h64, v3);
>> +    h64 = XXH64_mergeround(h64, v4);
>> +
>> +    return XXH64_avalanche(h64);
>> +}
> 
> You might find it easier to #include "qemu/xxhash.h" which we use for tb
> hashing amongst other things.  

First, that's the 32-bit version, XXH32.
Second, we define xxhash7 there; we would need xxhash8 here.


r~

