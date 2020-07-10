Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA2C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C3F20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKHEBi8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C3F20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyIi-0005yT-H0
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtyI3-0005Xi-Px
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:02:32 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtyI2-0001bP-1R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:02:31 -0400
Received: by mail-pl1-x643.google.com with SMTP id m16so1425423pls.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ktWIQInNj/5S7RZ9q76LgYOzEPpiWRK08cub9PThHLY=;
 b=lKHEBi8X+edLOqI5ZMItYkttfVUNaL8xjx3882XqOrbwsXL9IWd/1iNrxdiclSZ7EL
 nm6lbGjyTiJS/pYzvW/mYB5jyWeoKRGQC4uMf23s63G9TH/JQu7sw9r5o0ZXIrzDb8j4
 pLABbIIAgfmPjwaYA+BLfdVf0XUUuYwLMqNh0/OYgdWw2Ca1o0ZFh2+wOOWxKfG+XH5/
 C3cifZ4Oqoe6nJaP21Or17H1VYaAa8bDVAuPRab/bywtKrbZQU94WsRQxCutRXJrXzEf
 1I+UH/mAWxoawaDxrdolU2ANjp4vFxpPFZU5ycm+vFQUY4sEzHKcE5x6g/ef3s8Z1fpp
 1/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ktWIQInNj/5S7RZ9q76LgYOzEPpiWRK08cub9PThHLY=;
 b=dTbqodof7Q0INn4N1XUd/aMO+yGclcOCcObSYVNGYVbfxbbCGPZzFhoHYD3NaYYgGI
 CJCvRY0bAEBrrgZtAMT2q2PixPLUDLhmP+qj8iAa0wy/TK50KKhP2BQGk7A05a0PWtGX
 ANJsti7cd2lq/ac6SFiQDp987OP/YPCTJmHCABstRJFUx2rPfdClCmpNiOa/BayhHnZ0
 h91M7yQZqIaU4FAFZ2w9BCLWLG7wojCGRlU8Py8tftaWzJwVdyOKMsf5zR/qTJRbc9PH
 bMQfUN9ri/NNTUb5cxDqABiPPjqpeRrpgDKkcPRie71VlGWbkm1ix16sjfsZF+7KYW2/
 RpmQ==
X-Gm-Message-State: AOAM532e+jyiVP5Bl7fVa7JOxxBH3JPuWvThrLjpRrq6jVk04nQbJsDn
 j49MiZv2cfi3AMcFLuwWPLYO63cE8O8=
X-Google-Smtp-Source: ABdhPJzEvLrnVXE+tU5/RkREg+CUBABhzWpzrohkXToC1xgSYBcbbERX8VXof4+ICMd/Mx/hI/ZrEQ==
X-Received: by 2002:a17:90a:c28c:: with SMTP id
 f12mr7041471pjt.214.1594407747905; 
 Fri, 10 Jul 2020 12:02:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b4sm5939127pjo.57.2020.07.10.12.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 12:02:27 -0700 (PDT)
Subject: Re: [PATCH v1] configure: fix malloc check
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
References: <20200707171326.16422-1-olaf@aepfle.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f673d66c-e139-0fac-1219-f1ab90a7f66e@linaro.org>
Date: Fri, 10 Jul 2020 12:02:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707171326.16422-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/7/20 10:13 AM, Olaf Hering wrote:
> Avoid random return value.
> 
> Fixes commit f2dfe54c74f768a5bf78c9e5918918727f9d9459
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

