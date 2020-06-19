Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFAFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAD722454
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZpBvkBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAD722454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQHP-0005ai-4M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQGf-00056G-7o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:17:53 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQGd-0006uk-CJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:17:52 -0400
Received: by mail-pj1-x1043.google.com with SMTP id jz3so4732443pjb.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ahhG1FnjioLPCTBDjYtRyRFQ60LY39Fy7Xj6EuCXF98=;
 b=DZpBvkBhFmrwQQFnMq7YShsvEyojUnqzUO8QwaBQn3FbUmBBwlvkqRhdJY9dlw0hun
 p39rVe99Y7df3Q3UE/fVETReUnUbtBkPLWIWYnsCIkCaN/tLKP+6HIbbHrRO3i+Xe1Ud
 j6EM1BuUFscMaYLQckU5qkww60t3TZon2JagLFQFn6UJtFTYnVa5VTrgB3AAB92nWpbl
 Rn0qgYK5qt6MPDEQ5NwApZlorcQLqPP+JDlGJyrW9YltMLFDMXWwSnZkJ79uIjJz5gUA
 LNhvh7dggn9dMhZ5r4UZE007cqQEP0HVcXxlKh3k2Sj/pui0Z3uj3qVsnkDrq6kc1kLI
 Hziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ahhG1FnjioLPCTBDjYtRyRFQ60LY39Fy7Xj6EuCXF98=;
 b=dwIhccZuL8gTdo8IQVLjN88uZ03zSyO3Y0EQRcV1M9cX3DZeKY83VXt190wKtCabqN
 gqCuBvolUZ9PtPXAD12cI7EIPgFrUcL5mC1cS7LTEhLfaAVe+LzTo7fCXQvyQU03vC3y
 aSPNyYt+Ux5Bd/mG6HLNaKGGtcWTiX8k4CA2PKt1KTKloutLvzpscd18xFlv9c3xIm8f
 DQNgSS+JBDeoMzzUFeSH+Dqe2Oz1PxstPxll08RV/raBqSXY9sBEWHKY4LpS2Waek4Hk
 R3+eUHje7Q2Bi7jYOUJ9ZSUIzgh3tLIbKpRs1eBV0L/0STf2B8E56sf+dBi8HIFZvu29
 L23w==
X-Gm-Message-State: AOAM5319/imfgbb5e/laaDqvQVj7BIkLWP5cs5nsf5/dwhDnF+wL4V4E
 sC9LidgezPYI+DE/HWOK9XBetqVXTWI=
X-Google-Smtp-Source: ABdhPJzJW5DnpsDeRRhuKwRBdxUbX5z0fyY+JzhAp6MdPb20SdI8J6camsyL2HraHD8G8lOnVh9z0g==
X-Received: by 2002:a17:90a:ce01:: with SMTP id
 f1mr6138649pju.69.1592608669836; 
 Fri, 19 Jun 2020 16:17:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h20sm6697247pfo.105.2020.06.19.16.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:17:49 -0700 (PDT)
Subject: Re: [PATCH 07/21] target/arm: Convert vectorised 2-reg-misc Neon ops
 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8be2e04e-3a8e-51ec-20ec-2e8f4ef9feab@linaro.org>
Date: Fri, 19 Jun 2020 16:17:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert to decodetree the insns in the Neon 2-reg-misc grouping which
> we implement using gvec.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 11 +++++++
>  target/arm/translate-neon.inc.c | 55 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 35 +++++----------------
>  3 files changed, 74 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


