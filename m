Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B1BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB9A2075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ondBgnxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB9A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwq3-00073d-OJ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwpT-0006UG-11
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:51:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwpO-0002kL-Sh
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:51:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id 64so3809987pfg.8
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Jv2e+9OR5TwDYOCjqWEzvy2SpW3+u9+2WGfvD4KNFU=;
 b=ondBgnxeWcgKdT9dv8Ly8SZFjLGa57UvU302nMihV2hBAmDm+jr/46wk6mknxbFFTU
 43/4FGLhWwm7f/V0Qt43RkH5BEMlVySUuZ/NPfmX8p9WjFLFphMs1xMAebVuuMbeJCB7
 hNGhHAfMeYJPFD5teH1vR+1kI22q6Vpr0FmvLxuMzJZ0ZwW17PJ8hjMHpOlhLXctIKx5
 FLnjOGLysCiz/4V04mSKdPy5ulaGei7ULilrpfAbrYvCbGUN3xIqdd17HznR9w+EvnAd
 8bVtCLCJ6dAAh0zBm0te6jvGizBy51iLXvcH0babavyvm2pOr64mv0goNirZpEaerer3
 +IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Jv2e+9OR5TwDYOCjqWEzvy2SpW3+u9+2WGfvD4KNFU=;
 b=PDM6Jzx/HQ9ZE6r+Shd0kGK9F5Vc6rGmGAqJ6G/AKPxhOtHnjrg2xdvrzbvIxN0d9P
 dPKd3WXE2Dy+T5SIVZflu1h+2PXamHxGJrEZVbsRE6ayrPYAT5BcS6YetWGGZS4srXa4
 2+zJGoAt/F6xEK03EKFD6srqea6JIYfLz24S+JWidSBqQdRJathHPLUo1oGe+LRfF103
 63GeOWkT0itt9lkCizbaods8Xwu6WrqBDdSU3eTLXSf5N4OtmRcEqmvv0TldoNaUyh7g
 11GD61Rre/yfKWvP5+U/kEbHgJH6Cmqsi5E6qUQi2SpbqyILjjSHE5UNehOQFxIHFnBQ
 TtKg==
X-Gm-Message-State: AOAM531GStUkzILhwEFT+Gx4s+FVrP4mY0U+E1iUds1TbbyHM5DqF0gY
 tcODSNyDXOvtpuiVh+fM7zVJ1A==
X-Google-Smtp-Source: ABdhPJyXIeQHblxak5vXVqAsgfu4ChRutjKKbhLoOO2nr7TvS5257Ci/aup1Dc9LaHB5KEKTPDvIGA==
X-Received: by 2002:a63:9558:: with SMTP id t24mr6372829pgn.48.1591303864983; 
 Thu, 04 Jun 2020 13:51:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d22sm4603909pgh.64.2020.06.04.13.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 13:51:04 -0700 (PDT)
Subject: Re: [PATCH v8 40/62] target/riscv: vector floating-point compare
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-41-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae22d15e-9899-e2e7-ee91-9ea445e7a40f@linaro.org>
Date: Thu, 4 Jun 2020 13:51:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094413.10425-41-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 2:43 AM, LIU Zhiwei wrote:
> +static uint8_t float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)

Return bool, better than uint8_t.

> +{
> +    int compare = float16_compare_quiet(a, b, s);

New since your last revision is that compare should be type FloatRelation.

And similarly for the other 13 comparison helpers.

> +        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, (ETYPE)s1,        \
> +                           &env->fp_status));                       \

Indentation is off.  env->fp_status should align with DO_OP.

With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

