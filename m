Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF09C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FB4221E9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB8mhBSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FB4221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDFox-00037H-93
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDFoM-0002f6-4g
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDFoK-0006i9-U7
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:03:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDFoK-0006fu-Mj
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:03:16 -0400
Received: by mail-pg1-x543.google.com with SMTP id y30so7233468pga.13
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EYcotxQ3d9BZDFs6JiK6yD8PfS1/vt8pL2o8EJkQVuw=;
 b=FB8mhBSG4GPTQSXdAxGqC+FCidOu0I9sZ72T6AAjz4M7Dv/dWey3k30F86pQ3taU27
 affNg0KhzaDK4IJ6QQUXUfhKGFHl+KMmzWzZTadDEK3NkbIvHTcClXO/O2h27pnqp3/b
 9H/gcizLMYyXabf2WUz21QY5sZNgjVxNo+lrpyESxPFSz5wDeUMCUDY0eWBbNDoCQkwR
 A4lP1/QnL7SbXYvNx9VvQxxrh+ACv8M+mq3bzMynpIQirFusbvb6IYkQAPW0MyEXag/C
 2Oki0WDbbv8n39z0QeKLe+6PSL4+1RxGn8y4MCCD2XlDIY6zePcJwsmMk+MbLKMfgfpt
 zKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EYcotxQ3d9BZDFs6JiK6yD8PfS1/vt8pL2o8EJkQVuw=;
 b=ttcZrafLI5SNYseYqfM/PxQCo0BY3OWEJar4IvBMZyQ0mYFxnAtCev5dFcLh0s/NpX
 VwV4bkQJ+5M6xxkxjj3/XHeQY7XhQsEYjQ/Y1qQOaBw7Tnm2S7YYdub/Hlo64VDUFM/8
 dHbfdx3EZSbMENRi0AClMLlU0xrTOTq5pT6n+ckpleadBlfoL7Vwpcmnjca7eM3h+SXh
 nNxBWFXg7nOrrhcOftxpjTMVgrfs1Go6s6Ax2Qhp2W/GSk/PE2Y2WNI1lBXpuZaj6kc1
 19BaXMEkdKVLxBfiwKDorg3i5QQs428Xb5xCMDnuSMQN+66XvKTGKBCypJHPy5/5tdcE
 OyTA==
X-Gm-Message-State: ANhLgQ0tKtdvZD7zzd0KWdHUhjcTCAx6J+YSDzGSLrBlDqXMIVREwCBC
 MVVurDbb6zXYK4C+00zTqlUvvw==
X-Google-Smtp-Source: ADFU+vs9gownYDcscT1+s8dlmQjkUHNAXO+E52gGnHu1HnQ14OFY+oxdYljT733JkqMtWP2EIBb7iA==
X-Received: by 2002:a63:798a:: with SMTP id
 u132mr20793820pgc.203.1584226995549; 
 Sat, 14 Mar 2020 16:03:15 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b24sm25081064pfi.52.2020.03.14.16.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 16:03:14 -0700 (PDT)
Subject: Re: [PATCH v5 42/60] target/riscv: widening floating-point/integer
 type-convert instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-43-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04c08bf0-5f1d-58de-0c2c-4f72da9af963@linaro.org>
Date: Sat, 14 Mar 2020 16:03:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-43-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +/*
> + * vfwcvt.f.f.v vd, vs2, vm #
> + * Convert single-width float to double-width float.
> + */
> +static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
> +{
> +    return float16_to_float32(a, true, s);
> +}
> +static uint64_t vfwcvtffv32(uint32_t a, float_status *s)
> +{
> +    return float32_to_float64(a, s);
> +}

Do you actually need this second one, as opposed to using float32_to_float64
directly?

> +RVVCALL(OPFVV1, vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
> +RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, vfwcvtffv32)
> +GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 2, 4, clearl)
> +GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
> 

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

