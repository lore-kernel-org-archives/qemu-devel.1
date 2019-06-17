Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E9C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985142084B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDRI/JmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985142084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxUR-0004aL-Lc
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxTr-0003wN-Dg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxTq-0004uN-GV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:39:51 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcxTq-0004sX-9O
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:39:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id v11so6355555pgl.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M4FL6kafN/86dFFJvgvoteto8jq15yU12gnoNcxruBU=;
 b=eDRI/JmH39DEkDY3BmeUANLpR18GRVKoa+AScxu7RNgsDzpBvleZHnUJwBXqucwLMp
 NV336fh68dtJG+mlt+jf6C9wu5xYuFaNm0VQesqVEOhVlCv0m1ZFGxRiNQE1Qz085e3D
 v6pRuMGKUIQ5q2XYtXuiKwyJZ3A2QLA0QV9FhOYYWhv0Q7DDjgRtOb4tTBUHjAD+/vU9
 ZJdqB4Kr3mZmIDy5wh77ouSpCzaenxCfNB1z6ILo5HjdG1snm/ie4F3Ecn8I3OK9HxSo
 milw77jbepGQ0YQ5IJA5pXrt//ls7tTgbz7ixZwyKI+oJtvqDhrIYojslATdx8JdcVJX
 0Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M4FL6kafN/86dFFJvgvoteto8jq15yU12gnoNcxruBU=;
 b=IVpmNvtL483Q0YebOfIiboBqXn4285ZrKfb5Bhc1WRyhVQhW2+q6NVUP3hcwrUfVTE
 +oYjrbuAlJPvwjMb37n/uJoRnRCO4TXxAllZfdfqv5BD6yN6aRzgZSoKgcwDb5m2EuIa
 MxCA111naAFgvuyb0z/KXRE6ow+UKgsS4E0P7NnD6nNvK72CCNJTxiyrKu+QsD5vSALE
 hi8eDCOBBUJXGyD0Lw3NVczkgFAvczzC/atVx9Ox+zcf+VGr8wJ/mKkIrRluh69N+Z3E
 V2Jn8/HqONiywzEcH/h9CdYKJFWKIuGia/HRUEsCMUQ58KtN1+c0x1mFH32rmHQVU1Cq
 JACQ==
X-Gm-Message-State: APjAAAWV5QRG81BxMdUai9LZrW8KUZUFti3mmtEycfV0T+qTMEQIdNDG
 dTaaoAb2jj24v++WmuC4LCoWYj28T+E=
X-Google-Smtp-Source: APXvYqza9cyoC1PbA97X8nLSqJ/wEKFiczJ0O9PE9Twz20KLJNeWkGjHST0FVX7gDxYi+OU5TWnl3Q==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id
 n11mr590677pjp.98.1560800388793; 
 Mon, 17 Jun 2019 12:39:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id y133sm14085891pfb.28.2019.06.17.12.39.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 12:39:48 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8d83d410-5db7-69d8-ac55-f6a9773b3cc1@linaro.org>
Date: Mon, 17 Jun 2019 12:39:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175317.27557-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 2/6] arm v8M: Forcibly clear
 negative-priority exceptions on deactivate
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

On 6/17/19 10:53 AM, Peter Maydell wrote:
> To prevent execution priority remaining negative if the guest
> returns from an NMI or HardFault with a corrupted IPSR, the
> v8M interrupt deactivation process forces the HardFault and NMI
> to inactive based on the current raw execution priority,
> even if the interrupt the guest is trying to deactivate
> is something else. In the pseudocode this is done in the
> Deactivate() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

