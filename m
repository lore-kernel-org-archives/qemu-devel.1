Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA112208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v44DF3uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA112208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvbN-0007t8-5j
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAvan-0007U0-PV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:35:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAval-0006aq-Sm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:35:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id k15so981276pfc.12
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RqcqMsk1Yml5Gfp17I6M1+ytObM8D1F+wZGdwfcwf0M=;
 b=v44DF3uWM7N0T7dGwVLQZDVHW/pmAE5H0T2807l5UBCcQjHefwwlvhx1sWTbbPM2DZ
 nccIFOcldrGka9N591TVdWtuEEknGzrjKIxxf+YX6uPxpTNRHPXy4N19x7Yxw8PCYq6W
 gUOrSBCgPr/cDTba75Qd84t4SI7XI6dxD/ZRKKtcsLvYDksJFvEtcmJLltNYf3hGBXnN
 EU22PueahE4DrX8KV5HLD10VAjDn7BCLGQQcAPlFXYUSE8Sf0/ftilpGlljJtLftkdUz
 o/CIl8lw5IAUUn7IrfZMULpBMi/0ZvUk9TAbqdeey5lEPULpxyZszzOMYFmv+c3T4doX
 0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RqcqMsk1Yml5Gfp17I6M1+ytObM8D1F+wZGdwfcwf0M=;
 b=sYK+jwhcC+6x0hlb4LFf749gYqfaHFNfWrz9UQddbeVskC2iSGurOqgOr9gKzu4Qu8
 aa1CCJcGow7LvvVmxqvqwtbDifQDmGppr/iamJjhrY535CFFR5EQWfxgeG2RduftrB7c
 b6jZzMCGFm/M7EnPYM6pOQ28ptME9hfj7wfk5s4+Q5nSySpIszsAzOogsGBjmGfOTdVk
 TZXfuL4hamyjxZ04QxLFLy+gxsXzqTlclf1hA0EaBrQGUi0H6s2Yfyb8nbQrc3th0nwK
 /ykB/HF+yuJPTe+O3wkuGfqcLSOih3o/osMyUhpfLWKl0zlKDARLyIldutjdgxmQEKP2
 ICVQ==
X-Gm-Message-State: AOAM533q5pFyt58FaXmDVOfi95+0Jv/CNl8+a3/NXFsMjRL7aaKuGtJi
 Rds0KtZvyBmgHjy1xQi4kUf4mQ==
X-Google-Smtp-Source: ABdhPJyQW7hTZcwKjukhM3lSCnlF4Q/pYGgM5h/G1phO3xz25ZEn+ExbTBMzeJ9zaeohyHncbZnB8Q==
X-Received: by 2002:a62:18a:: with SMTP id 132mr11205352pfb.46.1598448953898; 
 Wed, 26 Aug 2020 06:35:53 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id q201sm3270709pfq.80.2020.08.26.06.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 06:35:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v3 04/34] Hexagon (target/hexagon) scalar core
 definition
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-5-git-send-email-tsimpson@quicinc.com>
Message-ID: <929004a5-f633-376a-d8d2-6ad8e0368e13@linaro.org>
Date: Wed, 26 Aug 2020 06:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-5-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
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
> +#include <fenv.h>

This should not be in cpu.h.  What's up?


> +#define TARGET_PAGE_BITS 16     /* 64K pages */
> +#define TARGET_LONG_BITS 32

Belongs in cpu-param.h

> +#ifdef CONFIG_USER_ONLY
> +#define TOTAL_PER_THREAD_REGS 64
> +#else
...
> +    target_ulong gpr[TOTAL_PER_THREAD_REGS];

Do I not understand hexagon enough to know why the number of general registers
would vary with system mode?  Why is the define conditional on user-only?

> +/*
> + * Change HEX_DEBUG to 1 to turn on debugging output
> + */
> +#define HEX_DEBUG 0
> +#define HEX_DEBUG_LOG(...) \
> +    do { \
> +        if (HEX_DEBUG) { \
> +            rcu_read_lock(); \
> +            fprintf(stderr, __VA_ARGS__); \
> +            rcu_read_unlock(); \
> +        } \
> +    } while (0)
> +

No.  There are plenty of bad examples of this in qemu, let's not add another.

First, the lock doesn't do what you think.
Second, stderr is never right.
Third, just about any time you want this, there's a tracepoint that you could
add that would be better, correct, and toggleable from the command-line.

> +/*
> + * One of the main debugging techniques is to use "-d cpu" and compare against
> + * LLDB output when single stepping.  However, the target and qemu put the
> + * stacks at different locations.  This is used to compensate so the diff is
> + * cleaner.
> + */
> +static inline target_ulong hack_stack_ptrs(CPUHexagonState *env,
> +                                           target_ulong addr)
> +{
> +    static bool first = true;
> +    if (first) {
> +        first = false;
> +        env->stack_start = env->gpr[HEX_REG_SP];
> +        env->gpr[HEX_REG_USR] = 0x56000;
> +
> +#define ADJUST_STACK 0
> +#if ADJUST_STACK
> +        /*
> +         * Change the two numbers below to
> +         *     1    qemu stack location
> +         *     2    hardware stack location
> +         * Or set to zero for normal mode (no stack adjustment)
> +         */
> +        env->stack_adjust = 0xfffeeb80 - 0xbf89f980;
> +#else
> +        env->stack_adjust = 0;
> +#endif
> +    }
> +
> +    target_ulong stack_start = env->stack_start;
> +    target_ulong stack_size = 0x10000;
> +    target_ulong stack_adjust = env->stack_adjust;
> +
> +    if (stack_start + 0x1000 >= addr && addr >= (stack_start - stack_size)) {
> +        return addr - stack_adjust;
> +    }
> +    return addr;
> +}

I understand your desire for this sort of comparison.  What I don't understand
is the method.  Surely it would be preferable to actually change the stack
location in qemu, rather than constantly adjust for it.

Add a per-target hook to linux-user/hexagon/target_elf.h that controls the
allocation of the stack in elfload.c, setup_arg_pages().

> +static void hexagon_dump(CPUHexagonState *env, FILE *f)
> +{
> +    static target_ulong last_pc;
> +    int i;
> +
> +    /*
> +     * When comparing with LLDB, it doesn't step through single-cycle
> +     * hardware loops the same way.  So, we just skip them here
> +     */
> +    if (env->gpr[HEX_REG_PC] == last_pc) {
> +        return;
> +    }

Multi-threaded data race.  Might as well move last_pc to env->dump_last_pc or
something.

But I'd also suggest that all of this lldb compatibility stuff be optional,
switchable from the command-line with a cpu property.  Because there are going
to be real cases where *not* single-stepping will result in dumps from the same
PC, and you've just squashed all of those.

Call the property x-lldb-compat, or something, and default it to off.  You then
turn it on with "-cpu v67,x-lldb-compat=on".


r~

