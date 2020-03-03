Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6118C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826962073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qttP9Saw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826962073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9COq-0006dI-OK
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 13:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CNy-0005pF-HD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CNx-0000uL-FX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:35:18 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9CNx-0000tL-A8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:35:17 -0500
Received: by mail-pl1-x644.google.com with SMTP id t14so1703876plr.8
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 10:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=tjdhg21vP0vgGCqLpfWkn2K2kwGuzk68EyvAYxecz5c=;
 b=qttP9Saw2f/EQwUEyblduccLGXhoyLSvHrdJrHjsrdqge81uxzWgSIfHBLwmXraAFC
 uw+ndnAB64ChK76pj5dm7TfeJnSfUh4uWOtHk3md4Nx4LcQuAdH/DjJSZ5i6xldkwWbq
 Am5Elr8EAO+C4oip3vP8+RgDh+PlMcHNudPZwL9Bx95bpPZX/D6o5AqUorxV0GoE1l0J
 WtztSjUaiBenZ5wjCK04vmA2QiFe8VqhwsX/R6SHdOjb3sqBDKv+tGPbXS2Z4i5Xgwsb
 BIn3WO2NAhRMqQVfiQuUZvfgoHJyxbDOoQq7FcNOPUJtvHnZqEtsCdBf6LC3I9Qi3Min
 7WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tjdhg21vP0vgGCqLpfWkn2K2kwGuzk68EyvAYxecz5c=;
 b=ZzJUd27mFYEpnJpIYD/6WNMB7aN2HN457dqCAu047txLJttxlpMLUYlh9Q8M8YZEN2
 k2otJhbomucsnIngJkeuuDZpGqbE9IZ5afqWE6SOdHSm2XBGzPPY+yEMSEZVvwTimgdq
 VsnDp26uQbCiAxqMj4N3Ab3C4GJVUJOnMg6vuDTDpAB7q2ZoqRzie8Jmn4/p6ltp6j2U
 Gj/tk5xJgS84J7xDpn9J4eC1I4tfC+nCkrN8JOnx1tI42UP2gswTxCmH3nLRz0aNbPfr
 8vhabVPuH7BEk1HkptdjUwYHEk+cNFb4CYj4eAujMRSGhnzwwcbgXslm5ADZiqOqL+Ku
 bBnw==
X-Gm-Message-State: ANhLgQ3pbWB+JX5jNA3SGsO8Nd9AxB5uQNi+cs7bzp5DctG6ji8By2vl
 fWjQKNH20rq+u/++a3ofse7pdDdZwi0=
X-Google-Smtp-Source: ADFU+vue1s/Vx1HMlCcalIqUup93Nl3zuvqfJH7W7G5gTXKlXr/aBU1X/Y1k7T3qea02+7du2S3c2w==
X-Received: by 2002:a17:90a:ec0f:: with SMTP id
 l15mr5313538pjy.133.1583260515569; 
 Tue, 03 Mar 2020 10:35:15 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a5sm3378671pjh.7.2020.03.03.10.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 10:35:14 -0800 (PST)
Subject: Re: [PATCH 1/4] hw/intc/armv7m_nvic: Rebuild hflags on reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200303174950.3298-1-peter.maydell@linaro.org>
 <20200303174950.3298-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <026d835d-1c87-f479-1bf2-c606d7d47df6@linaro.org>
Date: Tue, 3 Mar 2020 10:35:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174950.3298-2-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 9:49 AM, Peter Maydell wrote:
> Some of an M-profile CPU's cached hflags state depends on state that's
> in our NVIC object. We already do an hflags rebuild when the NVIC
> registers are written, but we also need to do this on NVIC reset,
> because there's no guarantee that this will happen before the
> CPU reset.
> 
> This fixes an assertion due to mismatched hflags which happens if
> the CPU is reset from inside a HardFault handler.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

