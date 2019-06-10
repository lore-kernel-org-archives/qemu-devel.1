Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB20FC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49652206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwoiI/Bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49652206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haR5t-0005pQ-EI
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 16:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1haR0a-0001tC-33
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1haR0X-0000Rn-Vy
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:35:11 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1haR0X-0000Q6-BN
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:35:09 -0400
Received: by mail-pl1-x643.google.com with SMTP id a93so4106131pla.7
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VwNntbsP0aicKl20AbDr9ZbYDXLGig+ER/OFUrnHEy4=;
 b=OwoiI/BofcwTfj+CAAPsSvyJ7NUxAPckW7rllg8+STZatd6LB1VL6FxUpzrlh9bzJc
 kzf4KYC7u2uzKPqwhDGyzdq8FX6yqmuSdK1LJX+cFdORIxbmAaSi0is0NcATGuPb/nRV
 gx8I4jV4URQFv4j732BOG8B3tIv5FC77XEU0+IFsId68gpLEd7h40PEIIuNyyJONcYaQ
 uQxIhGit9GMBk06OpR9fg52KPtspSZEDG3o4NadYN20yI4IG4OQzMLu8w6ohz38FOmU2
 Io0R8U0d8Rn7ul5f3na4REKZGMtj0aOUpT89P/Bc55a1eBEq6AvEv+GcRFmbb4LnEwML
 u8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VwNntbsP0aicKl20AbDr9ZbYDXLGig+ER/OFUrnHEy4=;
 b=G6xh8GF8mSw27HFCoXU/BV4A64YrHW9TiZ0zwCDT1+K4kr0qrt2HkquicOoLv/HIOt
 ACKOvdl0graC4ZhdhhXtys0xQ9X5KklyB/mw8DslDKHTlqwNh6bE0QJSlJxaAYRUgGh8
 OqUoJQfY4PoaJBSQyMWnHzJYo4XqorC7VVitw7DYfxCPA6KRovEnWno6lr6RLrc/cQ1i
 b7Ip35NAcmW1dfK0lvkW5hagmNX9jNEFqvyhLtAmHICC7Kw1V3+nDeFylQRUy7d6eWkN
 b/8skqTCHGwI27WrasKR2C+TjEY9OwxoU+UpqI4zHOQ2+98qvsLOOGQcuPv4Gl+ax8Xx
 8kKQ==
X-Gm-Message-State: APjAAAVTJJK0xuZVQISw0xGK0Wdutb0MB2gzbg/ap6pUC+r7R3c7W2vV
 F+30r8s26UMycKG17QnJA2+fhg==
X-Google-Smtp-Source: APXvYqxycxFwPTMGggrJdN6dOkAizuBA30aa0G5P65m+SACYqU+40khjITwbYYbjnzS7VeQTezDXAQ==
X-Received: by 2002:a17:902:31a4:: with SMTP id
 x33mr43554479plb.331.1560198903984; 
 Mon, 10 Jun 2019 13:35:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 x6sm11364089pgr.36.2019.06.10.13.35.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 13:35:03 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <854ef7a5-e8df-4e0c-18b8-bfee6b83fc60@linaro.org>
Date: Mon, 10 Jun 2019 13:35:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606193012.37715-5-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:30 PM, Michael Rolnik wrote:
> +enum {
> +    BS_NONE = 0, /* Nothing special (none of the below) */
> +    BS_STOP = 1, /* We want to stop translation for any reason */
> +    BS_BRANCH = 2, /* A branch condition is reached */
> +    BS_EXCP = 3, /* An exception condition is reached */
> +};

This set of exit conditions is confused and incomplete.

(1) BS_BRANCH and BS_EXCP do the same thing, namely they
    equate exactly to DISAS_NORETURN.

(2) BS_NONE equates exactly to DISAS_NEXT.

(3) BS_STOP is probably better named DISAS_EXIT, just so
    it matches the other naming above, and that it will
    result in a call to tcg_gen_exit_tb.

(4) You're missing a case that applies to indirect branches
    which should use tcg_gen_lookup_and_goto_tb().
    I suggest this be called DISAS_LOOKUP.

> +static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +{
> +    TranslationBlock *tb = ctx->tb;
> +
> +    if (ctx->singlestep == 0) {
> +        tcg_gen_goto_tb(n);
> +        tcg_gen_movi_i32(cpu_pc, dest);
> +        tcg_gen_exit_tb(tb, n);
> +    } else {
> +        tcg_gen_movi_i32(cpu_pc, dest);
> +        gen_helper_debug(cpu_env);
> +        tcg_gen_exit_tb(NULL, 0);
> +    }
> +}

Should set ctx->bstate = DISAS_NORETURN here, and not to BS_BRANCH in the callers.

> +    if (avr_feature(ctx->env, AVR_FEATURE_ADIW_SBIW) == false) {
> +        gen_helper_unsupported(cpu_env);
> +
> +        ctx->bstate = BS_EXCP;
> +        return true;
> +    }

It would be good to define a helper function

static bool have_feature(DisasContext *ctx, int feature)
{
    if (!avr_feature(ctx->env, feature)) {
        gen_helper_unsupported(cpu_env);
        ctx->bstate = DISAS_NORETURN;
        return false;
    }
    return true;
}

so that this pattern becomes

    if (!have_feature(ctx, AVR_FEATURE_FOO)) {
        return true;
    }
    // Lots of code
    return true;

or

    if (have_feature(ctx, AVR_FEATURE_FOO)) {
        // Just a few lines
    }
    return true;

> +/*
> + *  Returns from subroutine. The return address is loaded from the STACK.
> + *  The Stack Pointer uses a preincrement scheme during RET.
> + */
> +static bool trans_RET(DisasContext *ctx, arg_RET *a)
> +{
> +    gen_pop_ret(ctx, cpu_pc);
> +
> +    tcg_gen_exit_tb(NULL, 0);
> +
> +    ctx->bstate = BS_BRANCH;
> +    return true;
> +}

With very few exceptions, the lone use of tcg_gen_exit_tb is a bug, because you
have failed to take ctx->singlestep into account.

In this case, this is one of the indirect branch places which you should be
using DISAS_LOOKUP.

> +static bool trans_RETI(DisasContext *ctx, arg_RETI *a)
> +{
> +    gen_pop_ret(ctx, cpu_pc);
> +
> +    tcg_gen_movi_tl(cpu_If, 1);
> +
> +    tcg_gen_exit_tb(NULL, 0);
> +
> +    ctx->bstate = BS_BRANCH;
> +    return true;
> +}

Here you need to use DISAS_EXIT, because instructions that enable interrupts
also need to exit to the main loop so that we re-evaluate whether interrupts
need to be delivered.

> +    if (ctx.singlestep) {
> +        if (ctx.bstate == BS_STOP || ctx.bstate == BS_NONE) {
> +            tcg_gen_movi_tl(cpu_pc, ctx.npc);
> +        }
> +        gen_helper_debug(cpu_env);
> +        tcg_gen_exit_tb(NULL, 0);
> +    } else {
> +        switch (ctx.bstate) {
> +        case BS_STOP:
> +        case BS_NONE:
> +            gen_goto_tb(&ctx, 0, ctx.npc);
> +            break;
> +        case BS_EXCP:
> +        case BS_BRANCH:
> +            tcg_gen_exit_tb(NULL, 0);
> +            break;
> +        default:
> +            break;
> +        }
> +    }

Better written as

    switch (ctx.bstate) {
    case DISAS_NORETURN:
        break;
    case DISAS_NEXT:
    case DISAS_CHAIN:
        /* Note gen_goto_tb checks singlestep. */
        gen_goto_tb(&ctx, 0, ctx.npc);
        break;
    case DISAS_LOOKUP:
        if (!ctx.singlestep) {
            tcg_gen_lookup_and_goto_ptr();
            break;
        }
        /* fall through */
    case DISAS_EXIT:
        if (ctx.singlestep) {
            gen_helper_debug(cpu_env);
        } else {
            tcg_gen_exit_tb(NULL, 0);
        }
        break;
    default:
        g_assert_not_reached();
    }


r~

