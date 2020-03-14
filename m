Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E492C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EF62074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/GdATK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EF62074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCzyS-0006Db-Ee
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCzxs-0005mU-P1
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCzxr-0002pN-P9
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:08:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCzxr-0002oV-II
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:08:03 -0400
Received: by mail-pf1-x444.google.com with SMTP id u68so6594845pfb.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XBPD79Vw364ME8EB/w2lJqCQeqw00cVsro7Pyhzav04=;
 b=F/GdATK5cQxP/zsEwdVmbSxw1b8g17JZbJ0CCjXBqpHV7BHrrSuT/DnQWgfRXCri59
 T218iTCxVK88cwjQZSDkjh6NQe9xqr9Gpb04fqdZHhPqQtrF+ny/qWK/jWVlZeTcSf5T
 J2k3PJTXXGPM9mUGFoDayHu5IsXnY++zyAN4Bbuoujp5Wh2nTNyLw0/tGEdZHdbxFetR
 joIRQF/LFXZFYgb7TAvx4s2ccbmOhlBOV1HB+B3Q3Acz1lXPOUIL/zIwZPUiqQbu19TH
 qV0BQRsJ9d9lM3YS2IP28liEpz+U1q1+gpFmwv6b4WM9KB2Xp3Oaxlvv38EutrWdp3tr
 Go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XBPD79Vw364ME8EB/w2lJqCQeqw00cVsro7Pyhzav04=;
 b=V6ZY0saRJdzHtHdzpZpZQX/DGMT/5TWcPc5LDpTjcxgGPTCdttdeo1EP8G3JwQFInB
 u40vsSlZLFcx9D5i/y30Usd0QJpSmbh8TzyZCSPRN06EQhuuncf5UR6RFVnTZsl4owjm
 W6avkKZZaC4IRZKHXcaaHyjYvho6JBPpCjT3nMn5KYHwNiw+nQXkBootxtCx2/kn0kSU
 z9Yzl7PR4mtfTFT+UffHYvIUW7LLGm6mT1wamPWPEJPjpbx3cJcq31b5v9mnCxu2k2EM
 Hp2cFgv242oWj6pxGKX1CO2B28AAbU8XinrkfQGlq+ArbMAhEqY9SYS2ZSF0xCaG+xP2
 0aIw==
X-Gm-Message-State: ANhLgQ2NbjvX7Mwibx4YPpUmGJ6OVSy6tF1HEsYd4EwN0ltGPUEqp9rb
 Abed9aMxTFkQszSDK4oALDbcMg==
X-Google-Smtp-Source: ADFU+vvp+YBIYqoMWNRHHFlCI4QYYkTV/R4XIrHvIoJx5RqoIliGzRuCnkhtp7vz1/JTxAjH8KETpA==
X-Received: by 2002:a63:1744:: with SMTP id 4mr17460556pgx.238.1584166082431; 
 Fri, 13 Mar 2020 23:08:02 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k2sm17686304pgj.16.2020.03.13.23.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:08:01 -0700 (PDT)
Subject: Re: [PATCH v5 13/60] target/riscv: vector single-width bit shift
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-14-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b531b581-6920-3195-dc67-4c74cf7c0cab@linaro.org>
Date: Fri, 13 Mar 2020 23:07:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-14-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
> +#define GEN_OPIVX_GVEC_SHIFT_TRANS(NAME, GVSUF)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                        \
> +{                                                                             \
> +    if (!opivx_check(s, a)) {                                                 \
> +        return false;                                                         \
> +    }                                                                         \
> +                                                                              \
> +    if (a->vm && s->vl_eq_vlmax) {                                            \
> +        TCGv_i32 src1 = tcg_temp_new_i32();                                   \
> +        TCGv tmp = tcg_temp_new();                                            \
> +        gen_get_gpr(tmp, a->rs1);                                             \
> +        tcg_gen_trunc_tl_i32(src1, tmp);                                      \
> +        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),                 \
> +            vreg_ofs(s, a->rs2), src1, MAXSZ(s), MAXSZ(s));                   \

Incorrect first argument.
Prefer an inline funtion helper.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

