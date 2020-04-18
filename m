Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CC9C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 00:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B30214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 00:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtvTCTre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B30214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPb0G-0004DY-Ec
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 20:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPazY-0003ly-AV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 20:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPazW-0007gB-Ty
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 20:05:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPazW-0007cC-MY
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 20:05:50 -0400
Received: by mail-pl1-x642.google.com with SMTP id g2so1553600plo.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=31mgFiyReglRSgIgRtKbIKPOlR3s0rnh0pMfrDMTsIw=;
 b=ZtvTCTreChXYjfqe4wXNRQ5jvJ8fMbV/hUaVZd1D/Q08sgjvlMRvg3mRA8uTu4H7BN
 nx+O6UDzqsx0itjzRZIm7TeH0cS2HS3/tMJAMXi53YOeibMH9PLMgRSXhsA5/BKa/FPt
 rAlRL4UDcPjWgNb8RmQokheSTjA3xgfcrQJ67pCy9sTq8W5eif2m2f0sD782hLT6t491
 8hJGmrG43gKlsTm6kZ0cUDwm+gDpNMnuE33pEv2loAPydIL0UCuO3kduphRqjvR4OJoi
 ztTRSn/PIRDdYAiandat6jkr9rkB1kJtsBXTJmVfT8YykhT9/apIS75PczNH9UzikdSK
 vZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=31mgFiyReglRSgIgRtKbIKPOlR3s0rnh0pMfrDMTsIw=;
 b=kZJKKrqimarh5zMXfjotGRPlGUe4MRhdCUUpKM7qwHo/c0COL1fVMcbGu16cAgHp+8
 wd4h3/aA4j4sso6zqYN4EgeCeTHfhK/LIqop8bpSfx5uVyUwEk+8P1LduLc3gTIqCkRp
 tv8MYub8nVlnexTWub+khB+bhJVdYF6kUjp2/5h05BN/jQj4ARgXS/ZfQwwHuTjnKMU2
 mDvOL7D5lgnsXQepBf1tmy1FYFPASweciRFWiW4lOrSArU+FkJABiC2C/WxYihdr5B2H
 Fp93BhKR1JH9yMb/ozIzB2lSwJfiIbr6Zvz55tu6v4TaUSU0Fz1MTp4/XHyyVtqf6nSJ
 IxKg==
X-Gm-Message-State: AGi0PuZQs6zz33aPzYBa/ueXb9JZ4oRIlxGgc+f6fQYsu4SUz0KpZKba
 HJmGyqKHs9opgiS+qlFweiNACQ==
X-Google-Smtp-Source: APiQypIex5fGqpVNizZMU8Hz4MYRQls+RqbGv57AoRN4WBBEfcz2zTc74itb+ZWtakNF4DBD6k8HjA==
X-Received: by 2002:a17:902:7c94:: with SMTP id
 y20mr6106052pll.129.1587168349295; 
 Fri, 17 Apr 2020 17:05:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b189sm12089217pfb.163.2020.04.17.17.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 17:05:48 -0700 (PDT)
Subject: Re: [PATCH v2 02/16] accel/tcg: Add probe_access_flags
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200311064420.30606-3-richard.henderson@linaro.org>
 <20200312043353.28913-1-richard.henderson@linaro.org>
 <CAFEAcA9VQyq0jZGWOJ-kTpM7QfF8Uqg7_tVUDpvjsc=Kv9nSjQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15117d04-55d4-9e7f-c601-04dc3b1b17c4@linaro.org>
Date: Fri, 17 Apr 2020 17:05:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9VQyq0jZGWOJ-kTpM7QfF8Uqg7_tVUDpvjsc=Kv9nSjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemuarm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 4:54 AM, Peter Maydell wrote:
>> -    target_ulong tlb_addr;
>> -    size_t elt_ofs;
>> -    int wp_access;
>> -
>> -    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
>> -
>> -    switch (access_type) {
>> -    case MMU_DATA_LOAD:
>> -        elt_ofs = offsetof(CPUTLBEntry, addr_read);
>> -        wp_access = BP_MEM_READ;
>> -        break;
>> -    case MMU_DATA_STORE:
>> -        elt_ofs = offsetof(CPUTLBEntry, addr_write);
>> -        wp_access = BP_MEM_WRITE;
>> -        break;
>> -    case MMU_INST_FETCH:
>> -        elt_ofs = offsetof(CPUTLBEntry, addr_code);
>> -        wp_access = BP_MEM_READ;
>> -        break;
>> -    default:
>> -        g_assert_not_reached();
>> -    }
>> -    tlb_addr = tlb_read_ofs(entry, elt_ofs);
>> -
>> -    if (unlikely(!tlb_hit(tlb_addr, addr))) {
>> -        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs,
>> -                            addr & TARGET_PAGE_MASK)) {
>> -            tlb_fill(env_cpu(env), addr, size, access_type, mmu_idx, retaddr);
>> -            /* TLB resize via tlb_fill may have moved the entry. */
>> -            index = tlb_index(env, mmu_idx, addr);
>> -            entry = tlb_entry(env, mmu_idx, addr);
>> -        }
>> -        tlb_addr = tlb_read_ofs(entry, elt_ofs);
>> -    }
> 
> All of the code above seems to have disappeared in this
> refactoring -- it's not in probe_access_internal()
> but it hasn't moved to the new probe_access().

It's certainly still there.  I think this is diff being a bit daft.  There were
2 copies of this code before -- in probe_access and tlb_vaddr_to_host.


>> +void *probe_access(CPUArchState *env, target_ulong addr, int size,
>> +                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>> +{
>> +    void *host;
>> +
>> +    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
>> +    probe_access_flags(env, addr, access_type, mmu_idx, false, &host, retaddr);
>> +    return host;
>>  }
> 
> probe_access() used to pass the 'size' argument through to
> page_check_range() and cc->tlb_fill(); after this refactoring
> it no longer does that.

Seems I've fixed this in my tree since posting v2 -- probe_access now uses
probe_access_internal directly.  Anyway, definitely fixed for the next round.


r~

