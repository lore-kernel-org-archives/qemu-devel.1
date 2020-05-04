Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46751C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7122053B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcFPk4+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7122053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeoa-0007rt-80
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVenL-0006sW-SH
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:22:20 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVenH-0004MU-Tw
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:22:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a31so187754pje.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pe/mA81uRo5jWWJVyxlWLLerp1EOutJhM9oBdr4f3dU=;
 b=QcFPk4+sZWK/c7MQIzTjyBgYU80dsOhTDahPnNDnLJsUK7WHKbJk6g+OIbOggy+tP0
 BYkJAN735GyLSC/ILTeJA9DdoDxf50T2GMXcN19DzEYXgc1GfJ5cPmUVYglg7U3vKqmc
 rrs3w915p1yrDO7/RXiISYgIEulD4R5Fzmp2hTG8IwWMM59ifrC2pBUlO+QUJyAghY9e
 UMYEWjzKdC9WEidZBAoTH2duu2SiLwZIWbT+w4HMtFWCYNiycCHqBv13crR0ZwgIG1nc
 pQmE0A0h7Kj+0miv8JNIefwDQWNmuqcOr9gsR0UND/3bmMcWAer+pnaCAkIVbYoazaCo
 +gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pe/mA81uRo5jWWJVyxlWLLerp1EOutJhM9oBdr4f3dU=;
 b=J2Rxj83kSsdELP7k5a/KGbnBAmGuNbCf6hHupX6V3iIzjWvnIihkGxPofW/E0c43rs
 /pYdYGd86pXfXaanPxEG7f5jq0mhSmGF1P2G6lstI6O7vr210u91oGT2gbAsOjIBMSSX
 4olOZ0EhIMJDqvuG8tfdwZwyA3/14A1/w5u82B5F90d6Ml5WUEJljP8GHsZsKkvNMIGa
 fMYCCmun00G/DhT1xMz8Ikqqmhd799q5GPAxbBTJ6J1GgDlzqiIobbb9ikn7vkpmbGBY
 HQUUFDWGDFg88CKbETsB7Na2JT66UWvf+MNARAI9t+CGP1/WssmNulXG55X6pd7fb0LZ
 nhcw==
X-Gm-Message-State: AGi0PuYoDqc06ML9CzQcTJfZjHPGAKlaqUMDfYGf9HUXf0iph69gOoIS
 Y8zbnXr0mn7wZcBWu0B3nq2trQ==
X-Google-Smtp-Source: APiQypIMoKmd492mhQ0cJ8J7ESmw2gqziV+k7MQRLaNtyuooEBpbSaaTjJNZr/KsIB2IfNKX3aBJig==
X-Received: by 2002:a17:90a:20ea:: with SMTP id
 f97mr280410pjg.157.1588612934462; 
 Mon, 04 May 2020 10:22:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o21sm47015pjr.37.2020.05.04.10.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:22:13 -0700 (PDT)
Subject: Re: [PATCH 2/3] hw/sh4: Extract timer definitions to
 'hw/timer/tmu012.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504081653.14841-1-f4bug@amsat.org>
 <20200504081653.14841-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6df75391-39d0-b1b1-4443-f132bdebd6d7@linaro.org>
Date: Mon, 4 May 2020 10:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504081653.14841-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:16 AM, Philippe Mathieu-Daudé wrote:
> Extract timer definitions to 'hw/timer/tmu012.h'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/sh4/sh.h       |  9 ---------
>  include/hw/timer/tmu012.h | 23 +++++++++++++++++++++++
>  hw/sh4/sh7750.c           |  1 +
>  hw/timer/sh_timer.c       |  2 ++
>  4 files changed, 26 insertions(+), 9 deletions(-)
>  create mode 100644 include/hw/timer/tmu012.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


