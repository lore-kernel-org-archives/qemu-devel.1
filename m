Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A97BC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C862098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeVxOSE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C862098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS56V-00074U-Rf
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 16:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS55b-0006M2-2V
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS55a-00063e-7D
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:38:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS55Z-0005yM-PI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:38:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id d17so5192943pgo.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ctTuxbQQm+/XRBg9BCNL+uchEbto7jd0sQyXDe89vGA=;
 b=aeVxOSE2H33L/VvEDD0YPHLvpL3O1EDTmqYdORpWEZfHJDo4Jc/1dLfS2LPEij172A
 o4DHqoiGlPY00TcABHLDuJIyA0qNjndYPE/GPoasotTXKxLY3MPtK5RwOIZPwKAnoaaZ
 uEn7J6JrdfQfLgX/hltsz99JzLt34JodDKzvnN+U+FDVYthVvbQTiPoYlzzNkgvV18KH
 1mY+uGEabnIsErT/93K2maxtgtokALNbout146eXHeZs4E7qxvTceqkivftSKlUKCl4+
 XCBtS3r6ZjsP/HixvcJUbIptuWSTAe7Ur9AXae3cTFrPi+wNC7xEzCSTFodkl8huhwrM
 nnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ctTuxbQQm+/XRBg9BCNL+uchEbto7jd0sQyXDe89vGA=;
 b=ac/EIUcsul3bVbpM8PVgZp3eWt5LkVTKI8ToML5C/opTCdkeftndrpZp/3xqTY7xU6
 fqXUQoBEy+9E+BBYj4hcff/BAQG5LA1AU8i+t9JSg26CQ4YKZUEbluT+EkFmsieflLCN
 W9Ow67UQ9LMDGSTuOT9DuKCFmCDfYeR51ZLTPJ9xROSiVAkMZ5ZHAvAmQz48VE6IdI1T
 xFlM71RAy40zFDX9mmce/EDIlbT+dmjfWBRr4UDfW8MJNu3I6orXLhFupHS7bcVsG28C
 GQC9Y3ARbdF1fD4VTlNjE1aZLHwoEJELJbVZyn5nJKGpf/wggOaMPp9dtBS7Y/kPZEmq
 Vz1g==
X-Gm-Message-State: AGi0PubmgvhRQomj2zf4fhq+jA6aR9807MWbpgDbear1gPfLxzG4+Wwe
 XUGVcMkYuoCY8PE4W2+Bn49eOg==
X-Google-Smtp-Source: APiQypIBpqOXcRrBCMCAuqEd/Z+nsZ9ptjAMl3G+pln7vtX0HvmpleDq/c/GfuwgRatPKtkTYJZ+nw==
X-Received: by 2002:a63:cf0f:: with SMTP id j15mr11166072pgg.225.1587760700028; 
 Fri, 24 Apr 2020 13:38:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b24sm6543424pfd.175.2020.04.24.13.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 13:38:19 -0700 (PDT)
Subject: Re: [PATCH v3] target/arm: Implement SVE2 FMMLA
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200422165503.13511-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <caeb437f-f21d-652a-3721-44a9265785cf@linaro.org>
Date: Fri, 24 Apr 2020 13:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422165503.13511-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 9:55 AM, Stephen Long wrote:
> +    intptr_t opr_sz = simd_oprsz(desc) / (sizeof(TYPE) >> 2);               \
> +                                                                            \
> +    for (s = 0; s < opr_sz; ++s) {                                          \
> +        TYPE *n = vn + s * (sizeof(TYPE) >> 2);                             \
> +        TYPE *m = vm + s * (sizeof(TYPE) >> 2);                             \
> +        TYPE *a = va + s * (sizeof(TYPE) >> 2);                             \
> +        TYPE *d = vd + s * (sizeof(TYPE) >> 2);                             \

Shifting the wrong way.  Need to multiply by 4 not divide.

I've fixed this up, and also expanded the macro to two functions; I think it's
clearer that way in this case.

Applied to my SVE2 branch.  Thanks,


r~

