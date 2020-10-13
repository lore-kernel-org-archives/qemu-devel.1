Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04515252AF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPz03JUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04515252AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNJJ-0004J9-PX
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNIh-0003lm-Jo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:37:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNIg-00047N-2L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:37:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id p11so117743pld.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=JQ7DH8oeAFUbxMcXm7EPbswgxLfwRP//ja5d57fDX0c=;
 b=aPz03JUYya9QC8pK0Yt8AeMmUzowxGLV/KCiMF34Vx8V/qUmaay6ipEeLeComo74Mi
 fcjq9vOIfwwO6gRNQxeJkxuHzsYokrgLKI+wYLceTr1gmage2HrQzIQnRY/w6O9pVhSA
 PnDSIdOfC0Kcur+1AGviXx55weZUnrW2Po4zFHRRkdmmGgk6nHDa8nwOdW/V8dYPJ/G+
 9yr8vL32fRgCHvdPTYcC6awFS9qlXgkARBSeqd0kGpcPFezYpzngawox+DuFmMoISxJm
 OJjD9Gu5QpPS7dDvIoojYG4gursTaFN6RrLtFaijuLIjB/jVjxcRF9Ttl5QgfwNR5s+O
 zuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JQ7DH8oeAFUbxMcXm7EPbswgxLfwRP//ja5d57fDX0c=;
 b=b/U7M0/jS41nRhAsaqeh2zrYYq4yUzc606RBMvbSreHuMYRQEeTdvUlxuU29XlvQbp
 OV+r5s3o8RRMJvJV2t4pKuy1KrDrKbiV6QHisD5c+CuuTZ+wdYi9IjKBc8icLIft7PyD
 +K4K96jEt9Caq1FXQlJXlsgR63J9D8maOn9E2o1fNhNHljbOTJf66LcT7P6RRTZL6TRY
 CPG+HoSnt/wy9jX6HAXhrcMioGHXb8B8fr6jDkU1OIV6+vsM2n2M1IkCQcFgZOMJ00wR
 Vtsfzf/XtNjsnNCcdU4OdmJi/SLRNiDXWntfWd+jWuNfsTg145c3er+5nk1xFloc5/bu
 91gg==
X-Gm-Message-State: AOAM5321m9oLM91YF4Ok0YFunxlHErRiTlB100olVCVuYe/iNf0uq2Pb
 fROd/bILQI04VjILtU0vjGH8R1K+f4sCPpie
X-Google-Smtp-Source: ABdhPJweswXyeWucI8jy2/PuW4DcYHcmH4AOW1NaZMvF4Dr7u+0DAKyqLIdyJIee2hRDAOC9eyLVsQ==
X-Received: by 2002:a17:90a:de98:: with SMTP id
 n24mr605889pjv.100.1602607039877; 
 Tue, 13 Oct 2020 09:37:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s67sm157934pfb.35.2020.10.13.09.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 09:37:18 -0700 (PDT)
Subject: Re: [PATCH 03/10] target/arm: Implement v8.1M conditional-select insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01657b8c-6c4c-deba-a852-88560eb63583@linaro.org>
Date: Tue, 13 Oct 2020 09:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 8:37 AM, Peter Maydell wrote:
> v8.1M brings four new insns to M-profile:
>  * CSEL  : Rd = cond ? Rn : Rm
>  * CSINC : Rd = cond ? Rn : Rm+1
>  * CSINV : Rd = cond ? Rn : ~Rm
>  * CSNEG : Rd = cond ? Rn : -Rm
> 
> Implement these.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/t32.decode  |  3 +++
>  target/arm/translate.c | 55 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index 7069d821fde..d8454bd814e 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -90,6 +90,9 @@ SBC_rrri         1110101 1011 . .... 0 ... .... .... ....     @s_rrr_shi
>  }
>  RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
>  
> +# v8.1M CSEL and friends
> +CSEL             1110101 0010 1 rn:4 10 op:2 rd:4 fcond:4 rm:4
> +
>  # Data-processing (register-shifted register)
>  
>  MOV_rxrr         1111 1010 0 shty:2 s:1 rm:4 1111 rd:4 0000 rs:4 \
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d34c1d351a6..a7923a31b56 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8224,6 +8224,61 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
>      return true;
>  }
>  
> +/* v8.1M CSEL/CSINC/CSNEG/CSINV */
> +static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
> +{
> +    TCGv_i32 rn, rm, zero;
> +    DisasCompare c;
> +
> +    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
> +        return false;
> +    }
> +
> +    if (a->rd == 13 || a->rd == 15 || a->rn == 13 || a->fcond >= 14) {
> +        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
> +        return false;
> +    }

Missing check for rm != 13, which if I read the table properly would be an MVE
shift instruction.  (Irritatingly, there's a note for "See related encodings",
but there's no related encodings section.)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

