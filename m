Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C7C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F3E206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMGJ3Cv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F3E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI24w-0001B3-O5
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI24L-0000hf-4e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI24K-0001kK-5j
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:23:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI24J-0001jm-OD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:23:32 -0400
Received: by mail-pl1-x644.google.com with SMTP id d24so390580pll.8
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 20:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xqS5xXKI/hCKceagn++9iVyTAvEWIV2FzcPrX6crXZo=;
 b=qMGJ3Cv4+l1ohNI0g+56NAffWvN+SZo7+8Jq3i2zmntS52fH80xXHD8gLY+OEdbwLi
 P6JwYNOyY+63C1yTJ/lhG0CLXaiilvpvkjkzqMEBS22Jwf9YIw1NAWpsNqPDspw/8ewA
 4lBLgcU0+bxFQEc5ZJ0Jd2NI77fFNjMfm4mDZCRTCsaPANaA8TlJUXFZfM4XsxZiaJWY
 /EVODTuVFNPBXpePJ1/S53nJkZ/9Ti+CLUvY9OB5tO5GAulwM4+kfaoHV1GhoMH0PGck
 uCOxtdh54TJ46omrAAiEPXSYDxDrLPYsETCW6fI/ugJxYe7w9oL1yk+47fYdJdmYpcdE
 NgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xqS5xXKI/hCKceagn++9iVyTAvEWIV2FzcPrX6crXZo=;
 b=E9jXRzxjInxTBLjpS3gISoen9eMrLAjHC3RXxk6xMZp31Iz9L2M/IQ5xLGONofob6c
 rng5jtp07x6ZZ8QSCbb89kRQuz/v2rrlnviT+XaG6HAbWUsveH35PzAU4pruSscbCs2e
 tvvA8GrKyE7vg8U9zkHC8wXAN1aPGggKI5hzoo74IITmGXe03XBVA2pQONGxLf2RBc9V
 EfWTjkVvygKf+QDqchPQRO60Jhe+grUjztP3mGWV5nKB31jYrF2I+OqsX5pPXT+jjtut
 y5Evd0h++hhW4nn7nIiOgy1kj6V7lLEqDZ/2CBZITiXyeXYY6bhRaNOKAx21LqOmNdMN
 wupw==
X-Gm-Message-State: ANhLgQ3MTVrIO94IXpXJAt+HlWTCTHDfwaaxV6glEul2719Zv34A7o8A
 QhsQ31Hg0YTqYu/yXSPjT/z+7A==
X-Google-Smtp-Source: ADFU+vsdIuiwW0hYzxehjnj8SEonUninEKuYDCkFn2VAMLAxJ/OcegFgWionZAu38qk44yrN2X0R4g==
X-Received: by 2002:a17:90a:5205:: with SMTP id v5mr2840210pjh.0.1585365810319; 
 Fri, 27 Mar 2020 20:23:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id d26sm5174511pfo.37.2020.03.27.20.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 20:23:29 -0700 (PDT)
Subject: Re: [PATCH v6 41/61] target/riscv: vector floating-point merge
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-42-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0d4678b-1a24-3e90-768a-efd0f0311b68@linaro.org>
Date: Fri, 27 Mar 2020 20:23:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-42-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +    for (i = 0; i < vl; i++) {                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
> +            ETYPE s2 = *((ETYPE *)vs2 + H(i));            \
> +            *((ETYPE *)vd + H1(i)) = s2;                  \

H1 should be H.

> +        } else {                                          \
> +            *((ETYPE *)vd + H(i)) = (ETYPE)s1;            \
> +        }                                                 \

You can also hoist the s2 dereference out of the IF, and let the assignment be
unconditional.

  *((ETYPE *)vd + H(i))
    = (!vm && !vext_elem_mask(v0, mlen, i) ? s2 : s1);


r~

