Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F8C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B932082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MaRU1wfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B932082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHym-0001wv-8W
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izHy3-0001Tg-DM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izHy2-0006BH-6q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:31:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izHy1-00063V-UP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:31:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so1850060wmc.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XrYYoJ0YNH0RES5X+5Zg+7/ilEs8AkyoABDgcdOywTU=;
 b=MaRU1wfjnXvSySXtGu3glZtRO3rzbMkcDGwCYPrbHHHXhOcUL2+BUoTa6vWYiIUDbv
 Iqopy98ysxJmwLWV+A27gMcHWMN29TmSDxgHo70HcZGiVW67MtS73tF/Nnr6NI+VqJ81
 u4Bm26xd7Rv8qD6RUXKdk8c+Cs+hpukf62n9EfCchNj0aNMaKEdAXSl2t8/o4aRlnaWk
 sd7HRZUNdolcgw2lQpenvrgkBx8rqU0vcJb4RgoULwnTpjA3x9wqRj03ThHWBId4ZsHZ
 8eK22SdzEFItVRKUOHU7Bst71AyRpopB7wrpMKs4TpIzThAuN+VPIhu8ccebL8zCsNBp
 8C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XrYYoJ0YNH0RES5X+5Zg+7/ilEs8AkyoABDgcdOywTU=;
 b=hjU1A8gLD74kfWytjfp8YbhS+a5yea12qEAlkrB/Jmd9VeL00dT4T7avizMtAymqru
 92rhmpo2KCv8d2yEZCkeoMEsxIcDBGldfj8Y40B7ImqrsE6BDVTW6fpB0cNpXfdt2gZL
 xJmEYh3MuHMBmLl1SUTCoagjy6YV/MvWD7T0HqwNg8DZO6fdknCWxJArqar9QU97a0l4
 Q3EcgmoNQvzR77SIQmgf8oPYhIAvLHJ4abT7xxa1/zSweWB3pNCmZsCDSF1URWCaKWrd
 NcEF8my0BN9PCBjGx+01ztjmkcfmaEux/HxqVveBeZcGPZByU0G7JO7NEdkzQnrR69qp
 OHLQ==
X-Gm-Message-State: APjAAAWysWsi3qtp5McHr0quisVBsqvgMtR7azO4b83QQfSXoHozp5H6
 Tavki+p0jjBiaS4MOvMnWnEmTA==
X-Google-Smtp-Source: APXvYqzTMfaTPQlIhWpRQycl8dOpWJ6bFeDjvE8qyr8lFCNciwT7GfQ10zhDe1Hz9vncKPBtmUNFgQ==
X-Received: by 2002:a1c:3906:: with SMTP id g6mr5231029wma.49.1580898692824;
 Wed, 05 Feb 2020 02:31:32 -0800 (PST)
Received: from [172.27.246.193] ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id a13sm34619622wrp.93.2020.02.05.02.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 02:31:32 -0800 (PST)
Subject: Re: [PATCH] memory: Use QEMU_ALWAYS_INLINE to silence compile-time
 warning
From: Richard Henderson <richard.henderson@linaro.org>
To: Zenghui Yu <yuzenghui@huawei.com>, pbonzini@redhat.com, tony.nguyen@bt.com
References: <20200205081703.631-1-yuzenghui@huawei.com>
 <9fe8ac60-52ec-6828-5ee3-5cd1141a8376@linaro.org>
Message-ID: <d4c5fcd1-480e-d763-4a23-a4b145ace793@linaro.org>
Date: Wed, 5 Feb 2020 10:31:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9fe8ac60-52ec-6828-5ee3-5cd1141a8376@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: wanghaibin.wang@huawei.com, qemu-devel@nongnu.org,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 10:01 AM, Richard Henderson wrote:
> On 2/5/20 8:17 AM, Zenghui Yu wrote:
>> Our robot reported the following compile-time warning while compiling
>> Qemu with -fno-inline cflags:
> 
> Why are you doing this?
> 
>>
>> In function 'load_memop',
>>     inlined from 'load_helper' at /qemu/accel/tcg/cputlb.c:1578:20,
>>     inlined from 'full_ldub_mmu' at /qemu/accel/tcg/cputlb.c:1624:12:
>> /qemu/accel/tcg/cputlb.c:1502:9: error: call to 'qemu_build_not_reached' declared with attribute error: code path is reachable
>>          qemu_build_not_reached();
>>          ^~~~~~~~~~~~~~~~~~~~~~~~
>>     [...]
> 
> Of course, the assert is compiled out when optimization is off, which is the
> only time we expect inlining to be off.
> 
> The patch isn't wrong, exactly, but I question whether we want to support
> completely arbitrary combinations of compile flags.

To follow up: if you *really* need to support -fno-inline, then perhaps the
correct patch is to change

- #ifdef __OPTIMIZE__
+ #if defined(__OPTIMIZE__) && !defined(__NO_INLINE__)
  extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
      qemu_build_not_reached(void);
  #else
  #define qemu_build_not_reached()  g_assert_not_reached()
  #endif

within include/qemu/compiler.h.


r~

