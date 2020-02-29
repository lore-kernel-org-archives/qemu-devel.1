Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E0C3F2C6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 17:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE9424672
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 17:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdzU+d30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9424672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j85w7-0005GI-SM
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 12:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j85vX-0004m9-TG
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 12:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j85vW-00077j-Sq
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 12:29:23 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j85vW-00076K-M4
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 12:29:22 -0500
Received: by mail-pf1-x444.google.com with SMTP id p14so3403510pfn.4
 for <qemu-devel@nongnu.org>; Sat, 29 Feb 2020 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5l+E/8Phjfu3q+sEYzRPqkNccE+4sBRmLdxRG9ARy64=;
 b=KdzU+d30f5oa9+fM0uyCVuqM3gzRZ86Fougwfx8Y7RT5lCKcIbHUFVa1xa531KFhpx
 fXj2IFMCyEpisMtl3HhLm9/u2tB0XW152Oh7K0E7yd7koz0rc0Ui0ogr18x0LlD1ISOC
 zZcFc7uSAv7gRgBWaGfZFs2Bvzu3N9EuyjV4KR6sbfj985PNL26nnf7A7yIp2XWAo+Ko
 uULaD4OM/4qTUe/RozW/EEnQEdVOK+oJFjWvaBrq77fElzSNwpeSjLEW2YSCdI+kOq9Y
 Ob/5H08TisvbCz9OngKBZIbtk2ecJRzta/o5j5N+N2A0xSY3WdiTqu1Osmwtju7omZQw
 dc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5l+E/8Phjfu3q+sEYzRPqkNccE+4sBRmLdxRG9ARy64=;
 b=pEIiHw6Ht5v09hsff4IgsA9XB4xDWNymjHbKPlpYwwe+3Vwba/htiVIlaIVQw5Vtyn
 7UsiMHssD92zhNqOCBYrfRVvYdg9auiNOx6as1JMjFYGxfPQ5WF+X+65qXG2kQU5w1YQ
 X1kkdNcMuAfCJC/FyxvqflfPvyz/2Yc9c0VIHwk9Mq27wPxy9yEkSzmpN0ZD/FS9fMfR
 AmEmXnBLNFm1A39+CFBWgQO/r0smNRWFb2wWumzis0oc+ENmdKP5U27arBa+zvrOTQL3
 /ni+TDOCgoD2flKFh2C5NZ1dR+S8CUgNeyYR/E6DL76DtTYAbc63NVm33hOPiOlhdR4U
 zszg==
X-Gm-Message-State: APjAAAWvhpE63K3DtzbBpFp2jnBnGrUBlXQviMsjpKIKmjIJtvOtKjVz
 Ud7PFwxp5GowU9M3LN1NTbtuxA==
X-Google-Smtp-Source: APXvYqy8nr6IeeiOaznkr6luODuQ0rU3vFiY7cWVWW8ety9ZQgJJLGgPvaBa6pbsA1sb6GDSIW0KPw==
X-Received: by 2002:aa7:864f:: with SMTP id a15mr10393314pfo.184.1582997361411; 
 Sat, 29 Feb 2020 09:29:21 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b25sm15740699pfo.38.2020.02.29.09.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Feb 2020 09:29:20 -0800 (PST)
Subject: Re: [PATCH v4 2/2] util: add util function buffer_zero_avx512()
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
References: <1582979675-22550-1-git-send-email-robert.hu@linux.intel.com>
 <1582979675-22550-3-git-send-email-robert.hu@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <02ca161b-7a73-300a-ee9b-ad72d6c5b8e0@linaro.org>
Date: Sat, 29 Feb 2020 09:29:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582979675-22550-3-git-send-email-robert.hu@linux.intel.com>
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
Cc: robert.hu@intel.com, chao.p.peng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/29/20 4:34 AM, Robert Hoo wrote:
> And intialize buffer_is_zero() with it, when Intel AVX512F is
> available on host.
> 
> This function utilizes Intel AVX512 fundamental instructions which
> is faster than its implementation with AVX2 (in my unit test, with
> 4K buffer, on CascadeLake SP, ~36% faster, buffer_zero_avx512() V.S.
> buffer_zero_avx2()).
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  include/qemu/cpuid.h |  3 +++
>  util/bufferiszero.c  | 74 +++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 67 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

