Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F9EC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 01:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659EB20838
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5BXPbSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659EB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBpUo-0006CP-JX
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 21:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBpUI-0005nX-49
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 21:16:58 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBpUG-0000se-7d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 21:16:57 -0400
Received: by mail-pg1-x544.google.com with SMTP id i10so1246770pgk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 18:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mJelE04zQMnrsdScp6VCMI7HWbQWxXwCyxPBTKJQSVo=;
 b=v5BXPbSjE9oOLASUSuWOS+iI3GxdWIt6VNY1/maY3ITAG+Grto7axry69iDpnJ0fCK
 7IICuMSOZ1ixvBHdyPyCzfN0ENbNNM2ijG25st3iRwZezvksGitepZF9RMO4TgT86Uhq
 /UnGA+2kri7MDKQ81QTkwDPpN5vkc46ZND8UHr/VvqmQS+vxDC/2vv4DrkFa7+m5nvmp
 mzBpjWgM5EDdSsTHXmukSEDri6NWu8hBHthmagNahW+rHRDcncod3/cyHxXP0r7pwnpF
 K1n3zTkliVyCfmT2HN6DObdCepvPF1EocBuH+mPnxNaWvbCXxzzSzspIipoRmacyhMog
 VjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mJelE04zQMnrsdScp6VCMI7HWbQWxXwCyxPBTKJQSVo=;
 b=j1HYBfzujDuxObmVVqpTXrq7nWm8B2ccivvkgrvQhf2muOOnI331jeOYQO7SkZf6MT
 iwMBJ2GyvAdJWgzTgYH5qf8w/GWN4QlC9Hr4uLebyTxqMJ/npgaJGXfbAxfIeuhbnJdx
 JyZlMixnMPne0hmQ941uJGw668QExjxtEf3zI+yZK7wULz7gembS+tIKdr0UnuflyMQq
 /4arkxaFOYRmlGN+doaleMZFeE29xMSab3aTRdIuZ+V7sJvbgvNStLHzDWC5SuYkeMhj
 ntW8wbsAPhPhKjSU9lniteZH4EXx7nq7NzHo9G4MND+F/XghIWXsq54Pan+ZKnz10e+o
 yUrQ==
X-Gm-Message-State: AOAM530OlJsUZjQ4/cj6+4WaeznTI8WBflyd5vpIWM8RULHj4s+/JkVT
 FbJsVE73sFPO5D6f6e4ndQa/HQ==
X-Google-Smtp-Source: ABdhPJxy6pzt7wrsgJ5WQQg6tlnlAnKuO66PTzeS8kSx9LpjymGPNJ8jC+OMf8jOmFuEKsbzquEsfA==
X-Received: by 2002:a63:9c1:: with SMTP id 184mr976323pgj.265.1598663814318;
 Fri, 28 Aug 2020 18:16:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 9sm676458pfv.22.2020.08.28.18.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 18:16:53 -0700 (PDT)
Subject: Re: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
Date: Fri, 28 Aug 2020 18:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +/*
> + * Section 5.5 of the Hexagon V67 Programmer's Reference Manual
> + *
> + * Slot 1 store with slot 0 load
> + * A slot 1 store operation with a slot 0 load operation can appear in a packet.
> + * The packet attribute :mem_noshuf inhibits the instruction reordering that
> + * would otherwise be done by the assembler. For example:
> + *     {
> + *         memw(R5) = R2 // slot 1 store
> + *         R3 = memh(R6) // slot 0 load
> + *     }:mem_noshuf
> + * Unlike most packetized operations, these memory operations are not executed
> + * in parallel (Section 3.3.1). Instead, the store instruction in Slot 1
> + * effectively executes first, followed by the load instruction in Slot 0. If
> + * the addresses of the two operations are overlapping, the load will receive
> + * the newly stored data. This feature is supported in processor versions
> + * V65 or greater.
> + *
> + *
> + * For qemu, we look for a load in slot 0 when there is  a store in slot 1
> + * in the same packet.  When we see this, we call a helper that merges the
> + * bytes from the store buffer with the value loaded from memory.
> + */
> +#define CHECK_NOSHUF(DST, VA, SZ, SIGN) \
> +    do { \
> +        if (insn->slot == 0 && pkt->pkt_has_store_s1) { \
> +            gen_helper_merge_inflight_store##SZ##SIGN(DST, cpu_env, VA, DST); \
> +        } \
> +    } while (0)

Ah, so I see what you're trying to do with the merge thing, which had the
host-endian problems.

I think the merge stuff is a mistake.  I think you can get the semantics that
you want with

	probe_read(ld_addr, ld_len)
	qemu_st(st_value, st_addr)
	qemu_ld(ld_value, ld_addr)

In this way, all exceptions are recognized before the store is complete, the
normal memory operations handle any possible overlap.

> +#define fINSERT_BITS(REG, WIDTH, OFFSET, INVAL) \
> +    do { \
> +        REG = ((REG) & ~(((fCONSTLL(1) << (WIDTH)) - 1) << (OFFSET))) | \
> +           (((INVAL) & ((fCONSTLL(1) << (WIDTH)) - 1)) << (OFFSET)); \
> +    } while (0)

reg = deposit32(reg, offset, width, inval)

> +#define fEXTRACTU_BITS(INREG, WIDTH, OFFSET) \
> +    (fZXTN(WIDTH, 32, (INREG >> OFFSET)))
> +#define fEXTRACTU_BIDIR(INREG, WIDTH, OFFSET) \
> +    (fZXTN(WIDTH, 32, fBIDIR_LSHIFTR((INREG), (OFFSET), 4_8)))
> +#define fEXTRACTU_RANGE(INREG, HIBIT, LOWBIT) \
> +    (fZXTN((HIBIT - LOWBIT + 1), 32, (INREG >> LOWBIT)))

extract32(inreg, offset, width)

> +#define fZXTN(N, M, VAL) ((VAL) & ((1LL << (N)) - 1))

extract32(VAL, 0, n)

> +#define fSXTN(N, M, VAL) \
> +    ((fZXTN(N, M, VAL) ^ (1LL << ((N) - 1))) - (1LL << ((N) - 1)))

sextract32(val, 0, n)

> +#define fRND(A) (((A) + 1) >> 1)

Does A have a type that won't overflow?
For Arm we write this as

    (A >> 1) + (A & 1)

> +#define fDCFETCH(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
> +#define fICINVA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
> +#define fL2FETCH(ADDR, HEIGHT, WIDTH, STRIDE, FLAGS)
> +#define fDCCLEANA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
> +#define fDCCLEANINVA(REG) \
> +    do { REG = REG; } while (0) /* Nothing to do in qemu */

Is this "R=R" thing trying to avoid a compiler warning?
Perhaps "(void)R" would be sufficient to avoid that?

> -static inline void log_store32(CPUHexagonState *env, target_ulong addr,
> -                               target_ulong val, int width, int slot)
> -{
> -    HEX_DEBUG_LOG("log_store%d(0x" TARGET_FMT_lx ", " TARGET_FMT_ld
> -                  " [0x" TARGET_FMT_lx "])\n",
> -                  width, addr, val, val);
> -    env->mem_log_stores[slot].va = addr;
> -    env->mem_log_stores[slot].width = width;
> -    env->mem_log_stores[slot].data32 = val;
> -}
> -
> -static inline void log_store64(CPUHexagonState *env, target_ulong addr,
> -                               int64_t val, int width, int slot)
> -{
> -    HEX_DEBUG_LOG("log_store%d(0x" TARGET_FMT_lx ", %ld [0x%lx])\n",
> -                   width, addr, val, val);
> -    env->mem_log_stores[slot].va = addr;
> -    env->mem_log_stores[slot].width = width;
> -    env->mem_log_stores[slot].data64 = val;
> -}
> -

Fold this back to wherever it came from.  Clearly no need to introduce it in
the first place.


r~

