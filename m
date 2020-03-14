Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB3BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445162073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKQyDXv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445162073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2pa-0000JG-Hk
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 05:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2ot-0008Iu-V4
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2os-0004NV-Up
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:10:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2os-0004Jt-OG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:10:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id u68so6779756pfb.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a7KfBC8ECRSrk4nYo9S26LD6D0mhts9PhwxaOQQobv8=;
 b=zKQyDXv6bnJxXUDcwfG32GUNck1aTbjjxxEcvPo8ZmNr2FXM3RDijgr5K967k/ss/L
 09Q+lIP2yHUEgRMM6XL6+XVeMXL9OKdHgt2V/XcN8hWbA5ACHarl1EFIggKlpHWJe+oS
 X4DJ1CG0LMAS3stuxCgeD9Z1oAplld83upVLoVcONtX+yah5k06lLWLMBygKI8Y+dMPy
 tVRgVJvyFGpdQsAB6IZgsuj5Ky6sN4XuqjcIE0jvT8qGA6E6B6MEmBG+drvOXaSEZ141
 a0qYYy4alalcLPamjar6Exd02uupHDDa5J3m5fE+m3dccDVUNI+ctuJvAma6tim1sjij
 9qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a7KfBC8ECRSrk4nYo9S26LD6D0mhts9PhwxaOQQobv8=;
 b=NcDp5dHUCG1X7JkBVuDKrp9e1etAvoRhmVNRQDpOPGN38S21owbJhhC9SOwKvT5eSQ
 Mkz0WALYEToehzCLFt3P1jAHeGB9aoDTEVwR5g7ikxKB+PZiG2aVSvfCjgV435+svEBI
 jCtEGXWKJtipU4fE72xKAsWxYiPZ8ETGikPZj6RRBSvSO5GnEnHR+sTqRTG9yMpKgjeY
 z42RkKjRviq08Hh5KISGe9ASG09VnVLTjSUN1IY/VbuO6iXAuCVxgzOujjeMslQOPyvT
 rqwfEptDsdFJQ9hntJEFaidGnvANU1qaKfteUV816+l89l3d/DQ8JFKe5mcTdGwIIdzw
 +VPQ==
X-Gm-Message-State: ANhLgQ2LkEM4nYdK46BVnJMbce7ERf8agbcQsT+vkhYHh0OScCceUZzO
 /lq45Q3qeVG1SCIXsE9Fl6SdKg==
X-Google-Smtp-Source: ADFU+vs0Z9vt7MgYtkDeiRRPa1Svo3LB4LHzMBfh2reJdNLxs3NsGVBINO35nTMnrWJ+FWwd26vo/A==
X-Received: by 2002:a63:8e44:: with SMTP id k65mr16583843pge.452.1584177057672; 
 Sat, 14 Mar 2020 02:10:57 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i124sm13657559pfg.14.2020.03.14.02.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 02:10:57 -0700 (PDT)
Subject: Re: [PATCH v5 39/60] target/riscv: vector floating-point classify
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-40-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6710853a-3354-1064-a7f8-4c2378bd680d@linaro.org>
Date: Sat, 14 Mar 2020 02:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-40-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
> +/* Vector Floating-Point Classify Instruction */
> +static uint16_t fclass_f16(uint16_t frs1, float_status *s)
> +{
> +    float16 f = frs1;
> +    bool sign = float16_is_neg(f);
> +
> +    if (float16_is_infinity(f)) {
> +        return sign ? 1 << 0 : 1 << 7;
> +    } else if (float16_is_zero(f)) {
> +        return sign ? 1 << 3 : 1 << 4;
> +    } else if (float16_is_zero_or_denormal(f)) {
> +        return sign ? 1 << 2 : 1 << 5;
> +    } else if (float16_is_any_nan(f)) {
> +        float_status s = { }; /* for snan_bit_is_one */
> +        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +    } else {
> +        return sign ? 1 << 1 : 1 << 6;
> +    }
> +}
> +static uint32_t fclass_s(uint32_t frs1, float_status *s)
> +{
> +    float32 f = frs1;
> +    bool sign = float32_is_neg(f);
> +
> +    if (float32_is_infinity(f)) {
> +        return sign ? 1 << 0 : 1 << 7;
> +    } else if (float32_is_zero(f)) {
> +        return sign ? 1 << 3 : 1 << 4;
> +    } else if (float32_is_zero_or_denormal(f)) {
> +        return sign ? 1 << 2 : 1 << 5;
> +    } else if (float32_is_any_nan(f)) {
> +        float_status s = { }; /* for snan_bit_is_one */
> +        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +    } else {
> +        return sign ? 1 << 1 : 1 << 6;
> +    }
> +}
> +static uint64_t fclass_d(uint64_t frs1, float_status *s)
> +{
> +    float64 f = frs1;
> +    bool sign = float64_is_neg(f);
> +
> +    if (float64_is_infinity(f)) {
> +        return sign ? 1 << 0 : 1 << 7;
> +    } else if (float64_is_zero(f)) {
> +        return sign ? 1 << 3 : 1 << 4;
> +    } else if (float64_is_zero_or_denormal(f)) {
> +        return sign ? 1 << 2 : 1 << 5;
> +    } else if (float64_is_any_nan(f)) {
> +        float_status s = { }; /* for snan_bit_is_one */
> +        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +    } else {
> +        return sign ? 1 << 1 : 1 << 6;
> +    }
> +}

These need to be moved out of fpu_helper.c so they can be shared.

r~

