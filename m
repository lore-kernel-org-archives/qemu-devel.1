Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54126C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D04B206FA
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odbh+MTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D04B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCUK8-0000cV-7W
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 16:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCUJL-00008t-Tj
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:52:23 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCUJJ-0005RJ-E1
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:52:23 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ds1so2057622pjb.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DOQayVlxaH6hSMDSLex6Oz9lq1PlmN0dhwD+eA5mffU=;
 b=Odbh+MTWLkSqA5oirgEbkXh7MkG3CmyIgQ7I+i8AFS5/kz5U8JwdaiKE1ghWDveZH2
 3wyDTc4zAMhO+0B1QXPLEid1Q/ecNDjZeWqNdVYjaHPrau+WilA7ZUgM39d+E5RjGBEb
 OGB4WkbAdHgR6GfFWMNJDiV7RqQCAFjynND7C8jxZzNNWpZ/AOrk6+sv1I7IfW03I10/
 rthOljVAAMX3j828O50PayvWByG81DOurARS2MyZBlrdXhe8qqDNEXerwtQi1Dhl1iMa
 TnSYj+ESmTxVYI1pioE5ShRQZFWmiTYWEjzLxAbl4LSKzky7NRMw/npVYWeKOgeHv3SW
 3Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DOQayVlxaH6hSMDSLex6Oz9lq1PlmN0dhwD+eA5mffU=;
 b=LPtez5sGmzM70r3vQXZQuUlHMc3Ir79t6VJZ7FirKBA+zViFjEY5t9pjvrjLW264XZ
 6EgGgadEUtqQLpTr49qi1HDXJZdyBrQgjVR1FLBckPWS5WBUNJ8zryKKjytyMpLQUhgs
 BMsRmbiAoyQobMKRXT8CDn6kap7Po5Qq4rH2OnH4gSgx8i93a2MPdfA3iMHy1PO3xMYp
 L4PF9fZcVneJHntfLej7qyIzkRaHCWBG8+VD+zasJtT6u6SsHOr+CadvxLRra6stzM4+
 x4kscpSiRbvuT3qlu7ud2Q0QufdQClWKsg9Wbwb/N530r1wfMwRQ9NBOH3g5zd7yqRNP
 x40g==
X-Gm-Message-State: AOAM533XDHmU2KNnJfiOy+/6Bhxh3Qkxa4wXl7hXXdtczM7QO2zAjq9o
 U8fc+0Hit3+bSRAj61JCbfeSKQ==
X-Google-Smtp-Source: ABdhPJwDGtrmizRMICH/Cqgb1PV1YG/JchmKG4lwSWvZlQKcQ+7+W6Z+yvFbiyE2EoswlnIBK95Dsg==
X-Received: by 2002:a17:90a:f2c1:: with SMTP id
 gt1mr8181016pjb.70.1598820739795; 
 Sun, 30 Aug 2020 13:52:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cv3sm5157863pjb.45.2020.08.30.13.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 13:52:18 -0700 (PDT)
Subject: Re: [RFC PATCH v3 28/34] Hexagon (target/hexagon) TCG generation
 helpers
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-29-git-send-email-tsimpson@quicinc.com>
 <4c1cefd2-5e45-db8c-ec0f-917fcbbd3376@linaro.org>
 <BYAPR02MB488611B00AC7D19989B57FB4DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad500dbe-51fe-3c16-ed1d-3e0022ce12b3@linaro.org>
Date: Sun, 30 Aug 2020 13:52:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488611B00AC7D19989B57FB4DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 12:53 PM, Taylor Simpson wrote:
>>> +++ b/target/hexagon/genptr_helpers.h
>>> @@ -0,0 +1,244 @@
>>> +
>>> +static inline void gen_log_reg_write(int rnum, TCGv val, int slot,
>>> +                                     int is_predicated)
>>
>> These are quite large.  Why are they marked inline?
> 
> Since this is a header file, it prevents the compiler from complaining when they aren't used.

Ok, why are they in a header file?
Why would they be unused, come to that?

The header file is used exactly once, by genptr.c.  Seems to me they could just
as well be *in* genptr.c.

If the functions are not used, just remove them?


>>> +static inline void log_store32(CPUHexagonState *env, target_ulong addr,
>>> +                               int32_t val, int width, int slot)
>>> +{
>>> +    HEX_DEBUG_LOG("log_store%d(0x%x, %d [0x%x])\n", width, addr, val,
>> val);
>>> +    env->mem_log_stores[slot].va = addr;
>>> +    env->mem_log_stores[slot].width = width;
>>> +    env->mem_log_stores[slot].data32 = val;
>>> +}
>>> +
>>> +static inline void log_store64(CPUHexagonState *env, target_ulong addr,
>>> +                               int64_t val, int width, int slot)
>>> +{
>>> +    HEX_DEBUG_LOG("log_store%d(0x%x, %ld [0x%lx])\n", width, addr,
>> val, val);
>>> +    env->mem_log_stores[slot].va = addr;
>>> +    env->mem_log_stores[slot].width = width;
>>> +    env->mem_log_stores[slot].data64 = val;
>>> +}
>>
>> ... or fold this re-addition back into where it was accidentally removed.  ;-)
> 
> Could you elaborate?

You added this code in one patch (didn't check which), removed it in patch 26,
and re-added it here in patch 28.


r~

