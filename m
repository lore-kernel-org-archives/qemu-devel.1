Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7712C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6605E20575
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cye6oNN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1s7-0003st-Ei
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1m8-0006vQ-IM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:49:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1m6-00072X-Np
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:49:48 -0400
Received: by mail-oi1-x243.google.com with SMTP id 26so6286708ois.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uvSNf3LD757ms7HgUnW5hl391h8DLb7H6BEnkQSAW4E=;
 b=Cye6oNN+o3btq1+3r7BCSHmIuFhtZ0keKiDjgf8rR88A/w22A70VaS4d3dhdiQswj/
 /9n3K89XhSi52Wd3N3JmbX26LIH0RAhQfjfeZEB7xpIJUFgAaHRgu+YqAeXdfFL6legE
 gLgdVQsMUX538NIaNrYmwV83wr3eEehlQKxoHz+ZB41onX4k0pQkAYQp32x+yXV0VQg7
 YXN/Nt9BolFwXo7aqqVwrJi7vuZsJzofVOwaSvM4gbUEntRc0/2dUmbgaRWg6pOz6jkO
 FZdGhIyK+MSbAxP7l9lxeLeT/GDf+NKk5HkYrwY2QEu/KeWFRSakZunhL0HpdmgFTB3A
 Hjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uvSNf3LD757ms7HgUnW5hl391h8DLb7H6BEnkQSAW4E=;
 b=il4z1cudkogpD98AwYF7u4hQI0Gaclx7TtYV2ErYupHcQgfpUDctHDBmHBSxGTlzQ2
 PEeSFS8LSXgtsXd/qI8ud+xTXdNdkoJBU1ZNV5BeXXeExC/SuX5x74OGnETsrRbuuo/3
 Yl7gopd/YYLUQ3JCXagsZBH580Lp1wrhhCx4OYfsv9JFnL9FtP51KjqtnyyWtdVWIXfE
 +URm7ynf7plcDdzY9WbFaO0rvLua/iHRj6XQi91MeFqK5CEmzy6z7H5HaDVMW6Z11R0+
 hu2Pep1IE0gpcgBFTUGo6SMXF6Tfvs1BWG2pqPZA+85+wKOcpQIbbO6sz7pzp5gZZB5n
 Rskw==
X-Gm-Message-State: AOAM530Bre6M5X2PHZYmWyGPTflaMTBpU9GcMdZCyQ8B6Chyv4La/Wbs
 Ln0oMGqTYJHd+/aKHu8lGqV0nA==
X-Google-Smtp-Source: ABdhPJxO8R9CYMDLPFssZq401l6EfAIQoLfHTEX5tiPNq1Y4DGkVN8gtQBrnYQHDT3C8964pgbIuxw==
X-Received: by 2002:aca:db42:: with SMTP id s63mr540866oig.4.1601570983843;
 Thu, 01 Oct 2020 09:49:43 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id h204sm217801oib.52.2020.10.01.09.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:49:43 -0700 (PDT)
Subject: Re: [PATCH v1 18/20] s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a8050a4c-e613-7d80-f243-43098b0fb9b6@linaro.org>
Date: Thu, 1 Oct 2020 11:49:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> +typedef enum S390MinMaxType {
> +    s390_minmax_java_math_min,
> +    s390_minmax_java_math_max,
> +    s390_minmax_c_macro_min,
> +    s390_minmax_c_macro_max,
> +    s390_minmax_fmin,
> +    s390_minmax_fmax,
> +    s390_minmax_cpp_alg_min,
> +    s390_minmax_cpp_alg_max,
> +} S390MinMaxType;

I think you'd do just as well making this enum match M6, so that no translation
is necessary.

> +
> +#define S390_MINMAX(BITS, TYPE)                                                \
> +static float##BITS TYPE##BITS(float##BITS a, float##BITS b, float_status *s)   \
> +{                                                                              \
> +    const bool zero_a = float##BITS##_is_infinity(a);                          \
> +    const bool zero_b = float##BITS##_is_infinity(b);                          \
> +    const bool inf_a = float##BITS##_is_infinity(a);                           \
> +    const bool inf_b = float##BITS##_is_infinity(b);                           \
> +    const bool nan_a = float##BITS##_is_infinity(a);                           \
> +    const bool nan_b = float##BITS##_is_infinity(b);                           \

Wrong lookups.

Note that you've already got float*_dcmask which you could use to help out
here.  You just need some named constants to help with the 12 different bits.

> +        switch (TYPE) {                                                        \
> +        case s390_minmax_java_math_min:                                        \
> +        case s390_minmax_java_math_max:                                        \

I think you should make TYPE a function parameter, and not replicate this
function N times, and so you also don't need

> +static vop32_3_fn const vfmax_fns32[16] = {
> +    [0] = float32_maxnum,
> +    [1] = s390_minmax_java_math_max32,
> +    [2] = s390_minmax_c_macro_max32,
> +    [3] = s390_minmax_cpp_alg_max32,
> +    [4] = s390_minmax_fmax32,
> +    [8] = float32_maxnummag,
> +    [9] = s390_minmax_java_math_max_abs32,
> +    [10] = s390_minmax_c_macro_max_abs32,
> +    [11] = s390_minmax_cpp_alg_max_abs32,
> +    [12] = s390_minmax_fmax_abs32,
> +};
> +
> +static vop64_3_fn const vfmax_fns64[16] = {
> +    [0] = float64_maxnum,
> +    [1] = s390_minmax_java_math_max64,
> +    [2] = s390_minmax_c_macro_max64,
> +    [3] = s390_minmax_cpp_alg_max64,
> +    [4] = s390_minmax_fmax64,
> +    [8] = float64_maxnummag,
> +    [9] = s390_minmax_java_math_max_abs64,
> +    [10] = s390_minmax_c_macro_max_abs64,
> +    [11] = s390_minmax_cpp_alg_max_abs64,
> +    [12] = s390_minmax_fmax_abs64,
> +};
> +
> +static vop128_3_fn const vfmax_fns128[16] = {
> +    [0] = float128_maxnum,
> +    [1] = s390_minmax_java_math_max128,
> +    [2] = s390_minmax_c_macro_max128,
> +    [3] = s390_minmax_cpp_alg_max128,
> +    [4] = s390_minmax_fmax128,
> +    [8] = float128_maxnummag,
> +    [9] = s390_minmax_java_math_max_abs128,
> +    [10] = s390_minmax_c_macro_max_abs128,
> +    [11] = s390_minmax_cpp_alg_max_abs128,
> +    [12] = s390_minmax_fmax_abs128,
> +};

these tables.

I think that the bulk of your minmax could be done exclusively with dcmask, so
there could be a common non-macroized function that returns an indication of
whether A or B (possibly silenced) should be the result, or if we should use
one of your two compare cases.

BTW, for your two "simple comparison" cases, have we eliminated all of the
special cases?  Could we in fact be calling floatN_min/max instead of
floatN_le_quiet?


r~

