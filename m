Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316842133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KivxYA5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316842133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXHz-0004gB-E0
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXEi-0001EP-Mm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXEg-0007cs-RZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:26:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXEe-0007Vy-PO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:26:18 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so59826pfl.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ad4WNeY0HSI5+M+iNU0OvhIPwrXcpFOdXco/n89yCcA=;
 b=KivxYA5wnhEK6RdaGM1XxZ+raIxJo383KCqzYPSwma4CY5uATz3EUKN1PwCg/U05Nm
 S2VbIt6XEmOa/MvRRl2YFjaQG3ClFD/6AhoPdPrz64IDIrAoh4nYnODmbPGTMIh5H9AM
 XR6MRJLGzCajAu4RqgyT5lnUGrS4NxVyrBfXFebUqTVVJmHzz4MgiDduWUAyifCbfKBX
 /KpkHqCvHxT5vvDcIp/pOaH3HPzlvRGNYwKiSMgXgE5Uf7v9epYffwu8ekj8Gwb1VfyF
 8WfVpui+xk+292q+bDYFlXaLEDUdujEJXBr6UJAg89H0jXTIqEZrpoSVHOItUt/33pL6
 nI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ad4WNeY0HSI5+M+iNU0OvhIPwrXcpFOdXco/n89yCcA=;
 b=sHo4Yn1dmlEfK85dBZQ0s3CPohfJ8vR8aPJdNRP0Yb62xCGrA3YJyqDdtoaCO9Qr6n
 RYe4XM6cF/4u0I4MlRSomp8/t5q4hqHhszxPLg9nSUQV597slXi5w5xcPNAejT6dicle
 wkND7/5YjlVzVmu6D8kEvgmgvEhLuLgaLIYSCr21QX0ahoVQksdMCDLLdo2bx5eQDrGX
 pZGYjqLiwKwPtaJhiUWSXG1W8itty526wW6T09nuh02Mc1ZWkVItANbW8PEFBeWy5Z4G
 UWb6ZAHOMlKmRbmoM3j2nXdqPPtLS+jWAFZUlBPJvpgD4S9hApkXLM4IIgpCnvcPOrOo
 zFaQ==
X-Gm-Message-State: APjAAAWZd9B6NyZLSe1Vs+NSw7TVajB9oHpajdCDvZr7uTq6D21qNYvx
 AgIRDapq6b0zVq/2BETcAcjVoXnVPKI=
X-Google-Smtp-Source: APXvYqzZ5t/J7rU4CkMVyBM4eAbgz4H4zwlNxvspw+j1VzMqf1FlCJh6VS8tXkkzqRkSrMcwbibhow==
X-Received: by 2002:a63:5023:: with SMTP id e35mr31487085pgb.194.1560461161069; 
 Thu, 13 Jun 2019 14:26:01 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id u21sm653963pfl.33.2019.06.13.14.25.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:25:59 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bc3da2bd-cdf5-b9b2-37a3-0d6bb46d4657@linaro.org>
Date: Thu, 13 Jun 2019 14:25:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 04/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VNEG_F
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Switch NEON_2RM_VABS_F away from using cpu_F0s.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


