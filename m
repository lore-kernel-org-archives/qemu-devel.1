Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5417FC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 17:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE6A2071B
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dx6genw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE6A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC50J-0001j8-7U
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 13:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC4zh-0001Hm-Tk
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 13:50:25 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:34120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC4zf-0007cV-N8
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 13:50:25 -0400
Received: by mail-pg1-x52e.google.com with SMTP id i10so2028476pgk.1
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PdYrnXe1+8LDoG72dOpYZIwWCnbKltrMyhQ8WwPyKsA=;
 b=dx6genw/nRGsxAMj8Pw2Lcljjdag0YRJgpx6KYeL5ngkvzy63GN5AkBikmPYE3DKa8
 EePietyA9pKWmHIsfqZqLWHrtfzyK9BuBm9Wi16r6gGZrHjUv3QVUBBApL2caD8cMvXr
 7ZRmSi/y+9rDK5Ge23dBoJKBJAkkCHmXr4tiO2yvBc6TogOD+Qlu9pAC7NOOtq0ktbwH
 dDlA5roK7E3zLIbi8GdmedERCfgnucy5htZaLgewF6xXQDqrrYxkMLPRqnSIcTUb7Oqk
 GORHwS/VZ7nTeaepcMECh9soqcIeQwAQ6x7nzc8pvCQMctmaG5jRZWDOAqed54Nq4qjZ
 m5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PdYrnXe1+8LDoG72dOpYZIwWCnbKltrMyhQ8WwPyKsA=;
 b=j27SQWk+bkRLCfQleF+uzi82HQWWA6ZRXja3Ca8qwmMCpy8O6tT/a3qiQCHksKc6vc
 AuwYCWK861zdl2f1O+mpMMRPZw7omJxmHL06SHXDJJea99hJMfPTiMAls71VbTOwlLg9
 xunzDM4+kq2ZTZv1JTV5baBQv7X/hD2Nq+OcV1nCmZ7M+vNpQ9uenx9g1imeoOlMSrYU
 J7PLnpdKjSEgVLsIQR3EdNZ5jWtExu+o2Gn6VL+UmDKyQd0tfBSNEug6d6CMBVde/im+
 L0NTp2l+49pewTUA7XTlaNllZugzWPk2K0R97IN/VM74Is/U/N0DecYy5wIphLdnnZfm
 HQug==
X-Gm-Message-State: AOAM530ORoY2VXUXz+2a8UWpSwbBWCO/eX0swSnBmZpOdqweG8xFvPN9
 iGbMzykQ69SatSZ8FXn5PBJztQ==
X-Google-Smtp-Source: ABdhPJymynG8BTMkXYMoA2EttKHfbUD/bwIZjclgjUumfxsrPq/7Q4lU6lUGe4kEq1G17YZiWQWzdw==
X-Received: by 2002:a62:33c2:: with SMTP id z185mr3722432pfz.242.1598723421852; 
 Sat, 29 Aug 2020 10:50:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gm3sm2545920pjb.31.2020.08.29.10.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 10:50:20 -0700 (PDT)
Subject: Re: [RFC v4 14/70] target/riscv: rvv-1.0: update check functions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-15-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0ae63fe-cd92-5048-f74e-3a155001e00d@linaro.org>
Date: Sat, 29 Aug 2020 10:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-15-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:48 AM, frank.chang@sifive.com wrote:
> +static inline bool is_aligned(const uint8_t val, const uint8_t pos)
> +{
> +    return pos ? (val & (pos - 1)) == 0 : true;
> +}

The truncation to uint8_t from int is odd.  Can we drop all of that and just
use int?

Looking at the uses, I think that you should pass lmul directly instead of
requiring the callers to all compute 1 << lmul, and also verify that lmul is
positive.

That change makes this function look like

    return lmul <= 0 || extract32(val, 0, lmul) == 0;


> +static inline bool is_overlapped(const uint8_t astart, uint8_t asize,
> +                                 const uint8_t bstart, uint8_t bsize)
> +{
> +    asize = asize == 0 ? 1 : asize;
> +    bsize = bsize == 0 ? 1 : bsize;

This looks odd.  Again, I think passing in lmul would be better than size.
Then compute size here locally:

    int asize = amul <= 0 ? 1 : 1 << amul;

> +
> +    const int aend = astart + asize;
> +    const int bend = bstart + bsize;
> +
> +    return MAX(aend, bend) - MIN(astart, bstart) < asize + bsize;
> +}
> +
> +static inline bool is_overlapped_widen(const uint8_t astart, uint8_t asize,
> +                                       const uint8_t bstart, uint8_t bsize)

This needs more comments, I think.  It's not obvious why this is (or needs to
be) different from is_overlapped.

I think you're trying to implement the

  * destination eew smaller than source eew,
    and overlap is allowed at the beginning.
  * destination eew larger than source eew,
    and overlap is allowed at the end.

rule from section 5.2.  But since you're not comparing asize vs bsize, that's
not what you're doing.

Anyway, I think all of these rules can be put into require_noover, and there
need not be a separate require_noover_widen.

> +static bool require_rvv(DisasContext *s)
> +{
> +    if (s->mstatus_vs == 0) {
> +        return false;
> +    }
> +    return true;

    return s->mstatus_vs != 0;

> +static bool vext_check_sss(DisasContext *s, int vd, int vs1,
> +                           int vs2, int vm, bool is_vs1)
> +{
> +    bool ret = require_vm(vm, vd);
> +    if (s->lmul > 0) {
> +        ret &= require_align(vd, 1 << s->lmul) &&
> +               require_align(vs2, 1 << s->lmul);
> +        if (is_vs1) {
> +            ret &= require_align(vs1, 1 << s->lmul);
> +        }
> +    }
> +    return ret;
> +}

I think this (and similar function taking is_vs1) should be split.  All callers
pass a constant value, and thus can just as easily call a different function.

Perhaps

static bool vext_check_ss(DisasContext *s, int vd,
                          int vs2, int vm)
{
    return (require_vm(vm, vd) &&
            require_align(vd, s->lmul) &&
            require_align(vs2, s->lmul));
}

static bool vext_check_sss(DisasContext *s, int vd, int vs1,
                           int vs2, int vm)
{
    return (vext_check_ss(s, vd, vs2, vm) &&
            require_align(vs1, s->lmul));
}

> +/*
> + * Check function for maskable vector instruction with format:
> + * single-width result and single-width sources (SEW = SEW op SEW)
> + *
> + * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
> + *
> + * Rules to be checked here:
> + *   1. Source (vs2, vs1) vector register number are multiples of LMUL.
> + *      (Section 3.3.2)
> + *   2. Destination vector register cannot overlap a source vector
> + *      register (vs2, vs1) group.
> + *      (Section 5.2)
> + */
> +static bool vext_check_mss(DisasContext *s, int vd, int vs1,
> +                           int vs2, bool is_vs1)
>  {
> +    bool ret = require_align(vs2, 1 << s->lmul);
> +    if (vd != vs2) {
> +        ret &= require_noover(vd, 1, vs2, 1 << s->lmul);
> +    }
> +    if (is_vs1) {
> +        if (vd != vs1) {
> +            ret &= require_noover(vd, 1, vs1, 1 << s->lmul);
> +        }
> +        ret &= require_align(vs1, 1 << s->lmul);
> +    }
> +    return ret;
> +}

If require_noover implements all of the overlap rules, as suggested, this
simplifies to

static bool vext_check_ms(DisasContext *s, int vd, int vs2)
{
    return (require_align(vs2, s->lmul) &&
            require_noover(vd, 0, vs2, s->lmul);
}

static bool vext_check_mss(DisasContext *s, int vd,
                           int vs1, int vs2)
{
    return (vext_check_ms(s, vd, vs2) &&
            require_align(vs1, s->lmul) &&
            require_noover(vd, 0, vs1, s->lmul));
}

> +/*
> + * Common check function for vector widening instructions
> + * of double-width result (2*SEW).
> + *
> + * Rules to be checked here:
> + *   1. The largest vector register group used by an instruction
> + *      can not be greater than 8 vector registers (Section 5.2):
> + *      => LMUL < 8.
> + *      => SEW < 64.
> + *   2. Destination vector register number is multiples of 2 * LMUL.
> + *      (Section 3.3.2, 11.2)
> + *   3. Destination vector register group for a masked vector
> + *      instruction cannot overlap the source mask register (v0).
> + *      (Section 5.3)
> + */
> +static bool vext_wide_check_common(DisasContext *s, int vd, int vm)
> +{
> +    return (s->lmul <= 2) &&
> +           (s->sew < 3) &&

Use MO_64 here for clarity.

> +static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
> +                                     int vm)
> +{
> +    return (s->lmul <= 2) &&
> +           (s->sew < 3) &&

Likewise.

> +/*
> + * Check function for vector instruction with format:
> + * double-width result and single-width sources (2*SEW = SEW op SEW)
>   *
> + * is_vs1: indicates whether insn[19:15] is a vs1 field or not.
>   *
> + * Rules to be checked here:
> + *   1. All rules in defined in widen common rules are applied.
> + *   2. Source (vs2, vs1) vector register number are multiples of LMUL.
> + *      (Section 3.3.2)
> + *   3. Destination vector register cannot overlap a source vector
> + *      register (vs2, vs1) group.
> + *      (Section 5.2)
>   */
> +static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2,
> +                           int vm, bool is_vs1)
>  {
> +    bool ret = (vext_wide_check_common(s, vd, vm) &&
> +                require_align(vs2, 1 << s->lmul));
> +    if (s->lmul < 0) {
> +        ret &= require_noover(vd, 1 << (s->lmul + 1), vs2, 1 << s->lmul);
> +    } else {
> +        ret &= require_noover_widen(vd, 1 << (s->lmul + 1), vs2, 1 << s->lmul);
> +    }

This is buggy, with (1 << negative_number), and is exactly why I think
require_noover needs to be passed the emul of each operand and implement all of
the rules.

This should just be

static bool vext_check_ds(DisasContext *s, int vd, int vs2)
{
    return (vext_wide_check_common(s, vd, vm) &&
            require_align(vs2, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs2, s->lmul));
}

static bool vext_check_dss(DisasContext *s, int vd,
                           int vs1, int vs2)
{
    return (vext_check_ds(s, vd, vs2) &&
            require_align(vs1, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs1, s->lmul));
}

static bool vext_check_dds(DisasContext *s, int vd,
                           int vs1, int vs2)
{
    return (vext_check_ds(s, vd, vs1) &&
            require_align(vs2, s->lmul + 1) &&
            require_noover(vd, s->lmul + 1, vs1, s->lmul + 1));
}

>  /*
> + * Check function for vector reduction instructions.
> + *
> + * Rules to be checked here:
> + *   1. Source 1 (vs2) vector register number is multiples of LMUL.
> + *      (Section 3.3.2)
> + *   2. For widening reduction instructions, SEW < 64.
> + *
> + * TODO: Check vstart == 0
>   */
> +static bool vext_check_reduction(DisasContext *s, int vs2, bool is_wide)
>  {
> +    bool ret = require_align(vs2, 1 << s->lmul);
> +    if (is_wide) {
> +        ret &= s->sew < 3;
> +    }
> +    return ret;
>  }

Again, should be split.  But in this case probably into the only callers...

> +static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           vext_check_reduction(s, a->rs2, true);
> +}

This could simplify to

    return reduction_check(s, a) && s->sew < MO_64;


r~

