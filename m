Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B576CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D7021556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXdZ9vqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D7021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2tY-0005to-Uj
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2sz-0005QW-IC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:26:33 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2sx-0005aC-Sv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:26:33 -0500
Received: by mail-pg1-x544.google.com with SMTP id i26so14584978pgl.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U/Uei+qPLVAylKTCp4I39SRQJ7A4ay1htT2bpasu1HU=;
 b=IXdZ9vqLynEuub7SxC1BkQ65XxYSWZL3tr7N+XsHYRXjYhida8USYEV5j+PU8di0RE
 aiwo2saPFHUC5Mx9UL63mc3WT5Ueq+KZ0CwxMztoIPaOyb5LFmXK4+gbjgICYKwMSFMa
 Oms6UznQ8mobirYxWF1Yi8eWaVpvtD9/+uGK3CUKRduLKbx/it2WQ6yvlNBzkeC11FNb
 Q94XNryyWQVA0y8S1V7IvEIQQQLs4nNZHSu+KQkt+mQmOijFBnaD5MkLDYBF3j6fQz5e
 hgGHo3yrvhkHXrLRwWNB/Me4pR52L8L86TJ6GFI7ZHnMAUfHYxANxTKkTC3gPz+mS22a
 F+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U/Uei+qPLVAylKTCp4I39SRQJ7A4ay1htT2bpasu1HU=;
 b=RtRO6IlCU/MG1gr+MaMi3tkzRlo8CDA1KVXmagQ5wWNiqeO5N9CmKf6CFf+5hvkByB
 u2dCUD7EgTXq/wUfWTcByqXD0jiM9rPrc9oLVK3nUWdiiphftGqGQFllXu3+hj07wO15
 s5x5sgdXBVewdr9grZM9LvQv5ugCWKmvzoW6QJHudqNwdpHw5tDd+aH39JK1f/2NUP3X
 8yWjPchC5c/pfMdOrZroOfNrtzDr6hFsmEoUgXWoxbY2k2i/oBbm6QPAhHrkbd2Hy/xt
 8LO+2txG9A2CGGtvXjQ31LmbuRnUBDBVMt53POVzbyVLLVobcoylCMRAS2EPEl/NfuaQ
 DSQA==
X-Gm-Message-State: AOAM532BdbYtoYTrXsVRfjnuIcQVi7uD+c/uY+U1rYK62nnWsZFPlsAM
 8eacrvosWKgcBKfyaHhqdnhDkw==
X-Google-Smtp-Source: ABdhPJxBZE8V0G0tTtQGRYe4jttP7vvbZLcwU6qkLX66UCkZb9ijVQKhJGUbkHPypi5LX1UiayAl2Q==
X-Received: by 2002:a63:5804:: with SMTP id m4mr17980628pgb.31.1604435190335; 
 Tue, 03 Nov 2020 12:26:30 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id k5sm13385pjs.14.2020.11.03.12.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:26:29 -0800 (PST)
Subject: Re: [PATCH v3 6/7] target/riscv: Remove the Hypervisor access check
 function
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1604432950.git.alistair.francis@wdc.com>
 <b379985cf25b2e46fac1377aa0c37e6a16c864d2.1604432950.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b627323-6361-6ed9-dd8f-63bd054bf551@linaro.org>
Date: Tue, 3 Nov 2020 12:26:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b379985cf25b2e46fac1377aa0c37e6a16c864d2.1604432950.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 11:51 AM, Alistair Francis wrote:
> @@ -199,7 +271,16 @@ static bool trans_hlv_wu(DisasContext *ctx, arg_hlv_wu *a)
>      TCGv t0 = tcg_temp_new();
>      TCGv t1 = tcg_temp_new();
>  
> -    gen_helper_hyp_access_check(cpu_env);
> +    if (!ctx->hlsx) {
> +        if (ctx->virt_enabled) {
> +            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
> +        } else {
> +            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
> +        }
> +        exit_tb(ctx); /* no chaining */
> +        ctx->base.is_jmp = DISAS_NORETURN;
> +        return false;
> +    }
>  
>      gen_get_gpr(t0, a->rs1);
>  
> @@ -221,7 +302,16 @@ static bool trans_hlv_d(DisasContext *ctx, arg_hlv_d *a)
>      TCGv t0 = tcg_temp_new();
>      TCGv t1 = tcg_temp_new();
>  
> -    gen_helper_hyp_access_check(cpu_env);
> +    if (!ctx->hlsx) {
> +        if (ctx->virt_enabled) {
> +            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
> +        } else {
> +            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
> +        }
> +        exit_tb(ctx); /* no chaining */
> +        ctx->base.is_jmp = DISAS_NORETURN;

generate_exception already is noreturn.  The exit_tb is unreachable.  You
should extract this to a helper function anyway, instead of 6 copies.

I would squash this with the previous, so that you don't add
helper_hyp_access_check and then remove it in the next patch.


r~

