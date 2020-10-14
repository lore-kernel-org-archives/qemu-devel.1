Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50CC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF882078A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYhNRhdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF882078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmJh-00079s-6M
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSmIs-0006WM-DO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:19:14 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSmIl-0001PA-Ru
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:19:14 -0400
Received: by mail-pj1-x1043.google.com with SMTP id h4so328833pjk.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1/8Y7UfnxbL9mJgYyhoOMxfPLDUP9sw8YCbyebqnu4c=;
 b=sYhNRhdm6cV5OdnWVuH2Q0rJ8lWy7dIDUgW3oJzLwp+G1HRD4Bjxl3yjjqPhDPTgkC
 zIcQOyDIqq3C081g7OULRDaRbMR+E+nj161vb46ybJlrrS4RUSz0UGmjMN3R0XuOK05o
 ND++aXyK3q67KNcAwNGx+K6DAj0mxPkk6XlyrRXX8fm/dabyYKGdfslU09Xohd5N+eRz
 dzeP9WYy4RKByC8MIB7VkkQshNbOSIH7B+CumPuz1Xyr9Oz8HBC/pk31vqq99k/DgDC+
 tnqwZRTwKzzffovil4jDsszJf14sD9CYZclpGM5l+G7oWWChrRNeD3/vo9ZlqUfolxPY
 MPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1/8Y7UfnxbL9mJgYyhoOMxfPLDUP9sw8YCbyebqnu4c=;
 b=XTG1/WgrqbI2g2leWXGOtaREpVCe6uHIxDuJ9UfL0G5OS5m7u9ldfaGRl5DOxUz81Q
 9JvONFr05l5EVTM6phMBtxt+PqxGie4rvEEVv4Ls5+T5FqVjuuT7iAbeeMpU7cpOwDyB
 WKYSpw31U61FCCQFbGCw+I7EYgmaqAoBwWZD+vWCAy1PXvATNV5+Pu+Xx7oH068pu3gT
 HUbyYeVVpGtpG8ygYybPm8sH45jGaVlevZb8VxKneHydQnMZB3SICwtuyRTp9fiJXMnm
 0MV4sWolW34xlaiuUfrm7x1F4jm1VdC2E68PxetpMNjA7g5vlQit6WTZwCfAg/56Ahfy
 SmtA==
X-Gm-Message-State: AOAM530FMv6slUJ05EuckDpUkqv/X+fZJZmFdztWlwyk3WtSvhITOnN/
 UMW99GclDAUSkuE3AQMCykvZ0Q==
X-Google-Smtp-Source: ABdhPJwjP0sFm6z3GRXIP2s7a3wnJl3HVvh7h1whDym49AnvUEIoXSLTPPlmFtFWKHEZ/UKAzYAzUA==
X-Received: by 2002:a17:90a:318d:: with SMTP id
 j13mr657715pjb.209.1602703146204; 
 Wed, 14 Oct 2020 12:19:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h2sm303022pjv.4.2020.10.14.12.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:19:05 -0700 (PDT)
Subject: Re: [PATCH 4/5] [RISCV_PM] Add address masking functions required for
 RISC-V Pointer Masking extension
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
 <20201014170159.26932-5-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b13721d7-241a-3d81-fa8d-5d7cc0e780b7@linaro.org>
Date: Wed, 14 Oct 2020 12:19:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014170159.26932-5-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Anatoly Parshintsev <kupokupokupopo@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 10:01 AM, Alexey Baturo wrote:
> +static TCGv_i64 apply_pointer_masking(DisasContext *s, TCGv_i64 addr)
> +{
> +    gen_pm_adjust_address(s, addr, addr);
> +    return addr;
> +}

This function is unused in this patch, which means the series as a whole is
non-bisectable.

Rather than merge the two, I suggest adding a stub version of this function to
patch 5, and then swap patch 4 and patch 5.  So you will add uses of
apply_pointer_masking without actually implementing it yet.  Which should be fine.

> @@ -800,8 +836,36 @@ static void riscv_tr_init_disas_context
>      } else {
>          ctx->virt_enabled = false;
>      }
> +    if (riscv_has_ext(env, RVJ)) {
> +        switch (env->priv) {
> +        case PRV_U:
> +            ctx->pm_enabled = get_field(env->mmte, UMTE_U_PM_ENABLE);
> +            ctx->pm_mask = env->upmmask;
> +            ctx->pm_base = env->upmbase;
> +            break;
> +        case PRV_S:
> +            ctx->pm_enabled = get_field(env->mmte, SMTE_S_PM_ENABLE);
> +            ctx->pm_mask = env->spmmask;
> +            ctx->pm_base = env->spmbase;
> +            break;
> +        case PRV_M:
> +            ctx->pm_enabled = get_field(env->mmte, MMTE_M_PM_ENABLE);
> +            ctx->pm_mask = env->mpmmask;

You can't read env like this.

This bakes in values from ENV without adding any way to verify that those
values are still current.

The one thing that you must bake into the generated code is the state of
PM_ENABLE.  Anything else would penalize normal risc-v emulation.

You do that in cpu_get_tb_cpu_state().  Allocate one bit to hold
the current state of the flag.  E.g.

FIELD(TB_FLAGS, PM_ENABLED, 9, 1)

then fill it in from the correct mmte bit for priv (which itself is encoded by
cpu_mmu_index()).

Except for special cases, the mask and base variables cannot be placed into
TB_FLAGS.  For now, I think it's best to ignore the special cases and implement
them all as tcg globals.  Which means that we do *not* bake in a particular
value, but instead read the value from env at runtime.

So, in riscv_translate_init, you create new globals for each of the mask and
base.  In riscv_tr_init_disas_context you examine priv (via mmu_index) and
assign one pair of the globals to DisasContext, so that you don't have to keep
looking them up.

Then you have

static void gen_pm_adjust_address(DisasContext *s,
                                  TCGv_i64 dst,
                                  TCGv_i64 src)
{
    if (s->pm_enabled == 0) {
        /* Load unmodified address */
        tcg_gen_mov_i64(dst, src);
    } else {
        tcg_gen_andc_i64(dst, src, s->pm_mask);
        tcg_gen_or_i64(dst, dst, s->pm_base);
    }
}


r~

