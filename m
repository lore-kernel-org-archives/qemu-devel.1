Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FDC28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DACD208E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyvGs13R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DACD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhQc-00046k-Dm
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh2S-0008Fx-U1
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh2Q-00087g-Uq
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:04 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh2Q-00085r-PI
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:30:02 -0400
Received: by mail-oi1-x243.google.com with SMTP id m202so3708462oig.6
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rj2E36ngY6AnNq+UCpUAKpS4p6Z0dG7frbklF6/2p9o=;
 b=qyvGs13Rht1Pttbmv2WlNqmWxc7d3o4b9WedsavwXoNuIoExzxTAR9HxNNkfhG19Ub
 xBbz/xWC2Twl4fIq7UcrCZyDzo/ULvPcLptQo81Qmutwn0Lp5DcIkoDXsLudhcEX+YmU
 PNQuyMEm2pbIbP6IchkFWblUvDNzLEcm6WRV1+22t24/9U0CgaZMYL4ikYkKq5+xz4b4
 dHP0fj3b1wO9Wli74Hzk7Kbg1IK9BTWpVIOsrcxZal5KwU+rxk8A55vATAIluY0toK+X
 RVjzjnc9YeqscidDQqAfvLYEH/T4Q+m4iGyI6mojmr1C6Fnuzytcuy5xDVb0G504ZB90
 Q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rj2E36ngY6AnNq+UCpUAKpS4p6Z0dG7frbklF6/2p9o=;
 b=t+x0yTRjtFFX8fqKKCc37NJmBAemkY6pGy+NoYGliPaQu4i7QQ4uWfENg3Yt9oN+3l
 NEEVWSaqQ/bFh0snKksQYiD4FkSoN6msh1gNAwi1dNEiW8B3nIMu8H4ZiDpDtCH6nu/S
 hw7yBP45NFS5YdaT3eFzxvjg9wFGI+tVWzQ1yb2aenbEKMFrVWnayUeUcRgS237y8mxw
 PqJjPE1f/kBlQXLnyV9FqjJTd2BUImayVKwl5z9dy+o9wZESCRKwZehDX0I+1hasbScz
 hAaLEeDAiLSJm1dmOiCa6ENzSfRxuA3JqJVuh0FGx49yXx3CtfdwxDonf9kksqrCQyPN
 3rRA==
X-Gm-Message-State: APjAAAWAulUQmXmuG4PnfbWimUwDIsBOz9pesP63p5CgjRE0qTYqupwJ
 4sjEsKEajgAF1/Le2oRinVZOhybzOIS8iQ==
X-Google-Smtp-Source: APXvYqy9fk6TuDWT1al8GwGgNU4m5+xlzE8oBe7UVBB2NkcoReht/5BQJltLEd8H319DUaLFV5c/2w==
X-Received: by 2002:aca:efd5:: with SMTP id n204mr7834806oih.60.1560022201514; 
 Sat, 08 Jun 2019 12:30:01 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id g16sm2016260otl.40.2019.06.08.12.29.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:30:00 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-35-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f80c49ec-6075-d27a-56ba-a0ddb501d7f0@linaro.org>
Date: Sat, 8 Jun 2019 14:08:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-35-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 34/42] target/arm: Convert the
 VCVT-from-f16 insns to decodetree
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
> Convert the VCVTT, VCVTB instructions that deal with conversion
> from half-precision floats to f32 or 64 to decodetree.
> 
> Since we're no longer constrained to the old decoder's style
> using cpu_F0s and cpu_F0d we can perform a direct 16 bit
> load of the right half of the input single-precision register
> rather than loading the full 32 bits and then doing a
> separate shift or sign-extension.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 82 ++++++++++++++++++++++++++++++++++
>  target/arm/translate.c         | 56 +----------------------
>  target/arm/vfp.decode          |  6 +++
>  3 files changed, 89 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

