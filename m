Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64330C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF3F21556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSfrmpyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF3F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7J8q-0006my-CX
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7J88-0006KM-9D
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7J87-00079M-7B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:23:07 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7J86-00077j-W3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:23:07 -0500
Received: by mail-pl1-x643.google.com with SMTP id p7so1149075pli.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QB7LKDKMLixce1CKgGUJpUu6MTCR78GRVzNWyM/Vu7s=;
 b=OSfrmpyO+jAxd5ccJGuz8/pAoUEDQL3esyyF6K6m3Slm6LvivKogvzR3hTlq6J0/ne
 awY19IVi2da2B7iPtKajHbBC72HVRR8Dh7XMtZoULt1O1Xxl4e+T02ipHa9nNJF2/B36
 PJt2jex1GUNBhr46z1xG+aaw+lI3wdM6Eup0XcmCwDapxQ/ShAOGRFqvQ4BzGlyONxQk
 HDUwrY9yXSsFgEwv0R87rs19jQWJx6Q/kicVXxjwCRv8/LYFxYz3km2bEnnSHrIcDNfO
 KzkeSxnPCIhDkktC740xqUhAudcbFdXE2Hir6euZLP1fW6mkJVzMjn47VNXuw+yCaiFz
 tJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QB7LKDKMLixce1CKgGUJpUu6MTCR78GRVzNWyM/Vu7s=;
 b=YMZjTOpEo4ipbdUDeHpuS0a9bX9smxixPzdA1QJwn9g/LF+G0cbWZb8cvPUT57eFUy
 e3/V45AMdB/QCwso1uY1uYOw4jZ+HoCO908nsD31J0Nq1UN7zwjK9atx3a/F4QN+BquL
 vEGq6BS/F+O1ngQQCfQevkJHzzWboK99TIi4qfN19lLIDfwb0WNnfWzyI/J4ot1x73L7
 MtPM7pOidF4YF3Aph9FvB3jxJsKpl4FwpO682ITu6YAU/RjJ3L7pr/Qqv29OeZ57YKL8
 G7zpO7voRcqdlInd5OMgEsxTd1hPQW++cd7j25kCdJxNtD5G2RqyKG8RpZUCbzfewWzb
 aljg==
X-Gm-Message-State: APjAAAUFoaJu7iPxQ5t7yvbYsddFW52pgLcctc+Kh1qypx+Knq8BP6Hr
 YbIKNb8bRV+gf2oiwYh4ddWIxQ==
X-Google-Smtp-Source: APXvYqy6CcGOZQK3Fts+NwV3cY5lSl6KDIMEVrPdEn8xW2lddIfkZv5IE0SMenfDQVc+m4+dR/BDEQ==
X-Received: by 2002:a17:90b:14e:: with SMTP id
 em14mr4648511pjb.112.1582809785649; 
 Thu, 27 Feb 2020 05:23:05 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y18sm6837943pfe.19.2020.02.27.05.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:23:05 -0800 (PST)
Subject: Re: [PATCH v2 2/2] util: add util function buffer_zero_avx512()
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
References: <1582688142-113997-1-git-send-email-robert.hu@linux.intel.com>
 <1582688142-113997-3-git-send-email-robert.hu@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a027778f-08a9-a7f9-68b6-a6dab19e7e3d@linaro.org>
Date: Thu, 27 Feb 2020 05:23:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582688142-113997-3-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: robert.hu@intel.com, chao.p.peng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 7:35 PM, Robert Hoo wrote:
> @@ -226,10 +263,16 @@ static void init_accel(unsigned cache)
>          fn = buffer_zero_avx2;
>      }
>  #endif
> +#ifdef CONFIG_AVX512F_OPT
> +    if (cache & CACHE_AVX512F) {
> +        fn = buffer_zero_avx512;
> +        length_to_accel = 256;
> +    }
> +#endif
>      buffer_accel = fn;
>  }

The other cases within init_accel should also set the length.  Otherwise, when
unit testing, sse2 will also see 256.

Recall that unit testing is done in order of

> +#define CACHE_AVX512F 1
> +#define CACHE_AVX2    2
> +#define CACHE_SSE4    4
> +#define CACHE_SSE2    8

Otherwise this looks ok.


r~

