Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F8922208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRf5qHtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F8922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGonL-00025D-4R
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGomb-0001RF-Mj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:32:29 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGoma-0000dj-7X
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:32:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id j7so1334502plk.11
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9Q7Y8X4tEBGZBhcUzxSkpKyUE7cjbzl0G3J6ilMIXKY=;
 b=rRf5qHtxWaUKe47odM3bVssDZIWg71GI7UvPZRYzozV94x5IJ2FHgz3E1gTbon+Eer
 BhBEwPNVglu9rBeADUM4mY4cau9NjofOlLTE0XKgjzYM8i1DV4fIQg1DFZyZO/fzbQ1K
 JZCDY9zEWm8v9XjqRcWjw6ALMKcKm0ch+qw9DpzB6LfoYnQ9Pz3Z8Ulu7zUqfg0niIbb
 nb2sgnill/2Y4SICk8Jyb5Wz/mskEBWRuxRdFfDGh2oBlBShpmLLgpzR5xK0hRNtWdh9
 x4VZYh1tJQI/IrIR2rM9Go5cqGQdpiycnbvKMMuVmqFPZ9GmgMqsTY5Jo3OIDDqL/qYj
 yCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Q7Y8X4tEBGZBhcUzxSkpKyUE7cjbzl0G3J6ilMIXKY=;
 b=P6HS2LtB6FY1J+8hndGRM+cjIwPkTN6DJkCOTreUN0vyDc/gzJ2wHyUbYfv6SjkTxI
 mQD4ZFGPrAjZoHxZGalQUmhxBpo88Fa7htKDyzBjgnpsdkh3vHb+znc20iKWIvKOBpUu
 L11egpn+Rj0Yo5oAumrwgEvYmKnMnDcDR4n59LwveiOt77THPG65knekfVL9psqi/96g
 Ydd4avvreGA42QROx7oWVFjy0iPAKscgQcN8bM5eVFoaYFkoGEe5wTN6LvG+foO22hEo
 JVUgmCW4KzU/Gw/FjWAoKaf95iw0yn35kk2PNVCa92Z1m6I9tAScgEHzcOV3tX5mLPeQ
 hOow==
X-Gm-Message-State: AOAM5315jy9AsVOd9W3fGlcNh8kFtagqUj+jzflwgJN5t5opiWmQB7ds
 dE0nN0unhUXohf481dkFkyUZgOZoknT+jQ==
X-Google-Smtp-Source: ABdhPJwlmO6UPKgd1+U/CCy/AJJq0JA6DoScAwtJrkvTT+Bla7Wk6/8UUxSP1t4rbk8ZkPpjkB3IxA==
X-Received: by 2002:a17:902:bb84:: with SMTP id
 m4mr3437829pls.90.1599852745706; 
 Fri, 11 Sep 2020 12:32:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k5sm3101343pfp.214.2020.09.11.12.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:32:24 -0700 (PDT)
Subject: Re: [PATCH 5/5] target/arm: Make isar_feature_aa32_fp16_arith()
 handle M-profile
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200910173855.4068-1-peter.maydell@linaro.org>
 <20200910173855.4068-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b490e9a-5cf0-0be5-fd6e-e3612674b3dc@linaro.org>
Date: Fri, 11 Sep 2020 12:32:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910173855.4068-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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

On 9/10/20 10:38 AM, Peter Maydell wrote:
> +static inline bool isar_feature_aa32_mprofile(const ARMISARegisters *id)
> +{
> +    return FIELD_EX32(id->id_pfr1, ID_PFR1, MPROGMOD) != 0;
> +}
> +
>  static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
>  {
> -    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
> +    /* Sadly this is encoded differently for A-profile and M-profile */
> +    if (isar_feature_aa32_mprofile(id)) {
> +        return FIELD_EX32(id->mvfr1, MVFR1, FP16) > 0;
> +    } else {
> +        return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
> +    }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


