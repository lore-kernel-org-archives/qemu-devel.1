Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23460C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829FE2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVL0yTO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829FE2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZpW-00031o-Hj
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 14:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUZoB-00027Q-Ml
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:23:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUZo8-0003gk-K8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:22:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id w11so188390pll.8
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OjzwwSGk6FpHnvMHgn5KZOH5vNctByltTRzz6zUdRYU=;
 b=ZVL0yTO0MZFdLvZ/PK2khml8IDg8XTHa5LOcjxfmEL1ao/4+febTf+N5w2xcL+E6OT
 2dgYJDIRZL0dWyuyPQd4+x6vuJhKg1U5xYUeXphXGYeyNwK+kXXUQRQcPdNqCQC+ypgo
 7T6zpi95SwVQQx8i+1vDtm6nAy1W85kBIywCSxnFmmRln9Z963Y9bndrW7FUAkhQBZOY
 qYcAeAxPrDvIQGMRE+EfiBGaxcbEPzD6CsNC4LV1t5YKAAb8ETJDwCC+gwm5CY2gZjsf
 vVFK216ubNT5H5QcYrBTlzv6P3joURmhJ4IBGeeH1z31P16X1e5SNHo02YMNdaOyWTRh
 vn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OjzwwSGk6FpHnvMHgn5KZOH5vNctByltTRzz6zUdRYU=;
 b=JgfyUXPKCeMQqwE+t9OlfmnuvSwKuyrnMZzmIDs6gsRGjBIkGIQNOzQXDt7B+JPalH
 T9Nu+rGncCN+n7edPNT+Zl/H4DjgLjFFF5LfpmvpOtRG0hKmSS3UjH9GH3AChBLBCdDF
 SM8ZoNvc9y4VE1qwAfiAJpavW8wFjkgZ5JqH9yWtgbTDgLv4+cq8MNRGvxz2W/BmJNaz
 NnGnKFdOFFekGerNPpgVa6+0duS5s/ivngo5Wcm4Ggf1KgEtbGyl4MECd0Wwh/L9f1Mv
 3mLHrbX4lr7Ot+dYW/KGERjWmsweBXlFk8CEGEQzRMZGdaOfyqFJrc0lZ/cGG7x9rmfR
 agqw==
X-Gm-Message-State: AOAM5329uEFXoPyT3EvMyeZRrcQqyq4LWjXypVVIXEBebynOe8Uspnns
 ahGAxY+7nE8Pj9ZLs7dHIToq7Q==
X-Google-Smtp-Source: ABdhPJw1lc61x6kp9apw0X08sDkVXfnwInU97BqxAarumxr6SnLyTQk29hEc6EulrWr/Hivi3He6tw==
X-Received: by 2002:a17:902:b28b:b029:d4:cb17:d2e4 with SMTP id
 u11-20020a170902b28bb02900d4cb17d2e4mr881619plr.73.1603131775081; 
 Mon, 19 Oct 2020 11:22:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 63sm497767pfv.25.2020.10.19.11.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 11:22:54 -0700 (PDT)
Subject: Re: [RFC] Don't lookup full CPU state in the indirect branch fast
 path on AArch64 when running in user mode.
To: Owen Anderson <oanderso@google.com>, qemu-devel@nongnu.org
References: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c416109-6431-076e-2284-0f8406931ab9@linaro.org>
Date: Mon, 19 Oct 2020 11:22:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 2:32 PM, Owen Anderson wrote:
> Hello,
> 
> I would like to request feedback on the following patch, which I do
> not believe should be applied to master as-is.  The idea here is to
> avoid gathering the full CPU state in the fast path of an indirect
> branch lookup when running in user mode on a platform where the flags
> can only be changed in privileged mode.  I believe this is true on the
> AArch64 scenario that I care about, but clearly not true in general.
> I'm particularly seeking feedback on how to clean this up into a
> version that checks the correct necessary and sufficient conditions to
> allow all users that can benefit from it to do so.
> 
> On the workload that I am targeting (aarch64 on x86), this patch
> reduces execution wall time by approximately 20%, and eliminates
> indirect branch lookups from the hot stack traces entirely.

(1) What qemu version are you looking at and,
(2) Do you have --enable-tcg-debug enabled?

Because you should not be seeing anything even close to 20% overhead.

In e979972a6a1 (included in qemu 4.2), the AArch64 path is

    uint32_t flags = env->hflags;
    *cs_base = 0;
    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
        *pc = env->pc;
        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
            flags = FIELD_DP32(flags, TBFLAG_A64,
               BTYPE, env->btype);
        }
        pstate_for_ss = env->pstate;
    }
    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE) &&
        (pstate_for_ss & PSTATE_SS)) {
        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
    }
    *pflags = flags;

With --enable-tcg-debug, there is an additional step wherein we validate that
env->hflags has the correct value.  Which has caught a number of bugs.

With a silly testcase like so:

    for (int x = 0; x < 10000000; ++x) {
        void *tmp;
        asm volatile("adr %0,1f; br %0; 1:" : "=r"(tmp));
    }

I see cpu_get_tb_cpu_state no higher than 10% of the total runtime.  Which, I
admit is higher than I expected, but still nothing like what you're reporting.
 And a "reasonable" test case should surely have a lower proportion of indirect
branches per dynamic instruction.


> +#if !defined(TARGET_ARM) || !defined(CONFIG_USER_ONLY)
>      cpu_get_tb_cpu_state(env, pc, cs_base, flags);
> +#else
> +    if (is_a64(env)) {
> +      *pc = env->pc;
> +    } else {
> +      *pc = env->regs[15];
> +    }
> +#endif
...
> +#if !defined(TARGET_ARM) || !defined(CONFIG_USER_ONLY)
>                 tb->cs_base == *cs_base &&
>                 tb->flags == *flags &&
> +#endif

This is assuming that all TB have the same flags, and thus the flags don't need
comparing.  Which is false, even for CONFIG_USER_ONLY.

I would guess that testing -cpu cortex-a57 does not use any of the bits that
might change, but post v8.2 will: SVE, BTI, MTE.  So, this change breaks stuff.


r~

