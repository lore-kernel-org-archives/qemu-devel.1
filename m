Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D649BC28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71E5214AE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvF/nMyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71E5214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60156 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhHd-00059V-Sp
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh3I-0000qq-B3
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh3A-0000SI-Do
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh2w-00008H-RY
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id v186so3710782oie.5
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A1K3P8+lwQg9GnL4poFXfzJhb6UKj7dyfAgmEsm8cNw=;
 b=xvF/nMyz9xxJWcpPKcBi5Z9eZ//qSwq6gySK7WZuoQIjrHd+g6MYgsXlqRldetOrVI
 vtvRD9bG5FzvJKtbKwqP66LZ/GnRs3Tfvq9aip1fNzkD8ON0oJ5kODzyGDSLGl2OHcxU
 d1Md9rEdo7CtX8QEBzIVF8q1SMdItdG5dWPTgRSJWoPLBdiYbAYq/Tn3/+t/s2sgloHy
 P3cgiyZe3qybSEhPoApf7KdDCr47LYmlGBBDLqYSFA3+K5vtMCyR8ZDF+/lTqoGS6xmU
 hVvusG0iaapq2WzJuycxoffWZ5ZktZHZiNxsMySyJltX9GaoNqwxS8s/dVp/do0zzsge
 sxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A1K3P8+lwQg9GnL4poFXfzJhb6UKj7dyfAgmEsm8cNw=;
 b=ZzPAauRIuaKVKa3Ujd0v7A8UWTy8xznLtRCuraUSmaa3ZRgvTMlkXmM2pF4h7Ek9t7
 V/ER+bc9YWUiloKxyO8gxi0oxUhOkQc9pUYCVsVFF/UbIjLY4G7RNLRV/HUtPvqgqH7u
 SQql6xoKB8QgqlbIiT6OJMJgEftIv7IKThC8CVuSbO8Eg372p/cLI2HM0aDW6tW+6mQ5
 X5xMA2I2tj1CsmygPxJ2zB8ZkzlLQgsM9FAGDKiHFYQOBdlGZHerboKGBiw/Cx2geW5r
 uCHB96/Q0nwRbMsd1PsBdlQwvF4/eGwwwm8w5YxPT4y3r+T3aSWnZ0hwAirk9yx0E2D5
 8/Wg==
X-Gm-Message-State: APjAAAWDhkrAhR46VN5RU9dppshgaCMpLB4VBbOaTj79M0ohCaAeTCx4
 rVkuEwWV6KX4wLC1fl3F110jMT2p86oHTg==
X-Google-Smtp-Source: APXvYqz7VgVr6SIYvInSJAW9/9pKmZZFHTrgCv+eN/joHjePBAyZNR4/W47y0a2t8hp7aUF9DfdtbQ==
X-Received: by 2002:aca:4b96:: with SMTP id y144mr7741107oia.34.1560022222462; 
 Sat, 08 Jun 2019 12:30:22 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id t30sm905786otb.50.2019.06.08.12.30.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:30:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-37-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c4468fe2-061b-35a6-b425-d37b22dcb18b@linaro.org>
Date: Sat, 8 Jun 2019 14:11:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-37-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 36/42] target/arm: Convert VFP round insns
 to decodetree
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

On 6/6/19 12:46 PM, Peter Maydell wrote:
> Convert the VFP round-to-integer instructions VRINTR, VRINTZ and
> VRINTX to decodetree.
> 
> These instructions were only introduced as part of the "VFP misc"
> additions in v8A, so we check this. The old decoder's implementation
> was incorrectly providing them even for v7A CPUs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 163 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c         |  45 +--------
>  target/arm/vfp.decode          |  15 +++
>  3 files changed, 179 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

