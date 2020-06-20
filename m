Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E868C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091D1229C6
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsPwg6Bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091D1229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmRGg-0000Yn-9p
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 20:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmRFt-00077M-Ge
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:21:09 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmRFr-0007xh-M3
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:21:09 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ne5so4781862pjb.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/0oDVXra3UOJhfTHeQ0tl7iPm0OReWXGWd+ERxzkKj0=;
 b=EsPwg6BtdMks85dO286cZg8yzCwtOhBINR5Uvd3aCCvkAqYtP5jXC5/rK86mN/ClH4
 FJ1DRSI2BBuCgfynKhFGIeOnpMCMyYmTxcs/F0CYsbcxDJKLQ3nY6AJsp78WUgtKRmvW
 W63rkpxKTLecJB4cjTvQMf5IjmWKduKLHYtdSxmFAaWULAGGHWS3EqWbNgV29kISJcb/
 6GkYLU43KYRjNhPwoE+6XUroSPjN7rXdT+ngUBs3sZUVs1/FV5s5IEV22np0XxSspGmy
 hgaZ4ztJaIeyQyImEijpz0XKo2a9HSKWHm3hfVaVr9tEmefHuBhJCiiFYOqBoUo/Xgji
 m5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/0oDVXra3UOJhfTHeQ0tl7iPm0OReWXGWd+ERxzkKj0=;
 b=TiiPPlA1NssBSt7wpnZmr5PI8MQznwhhOsY9/KvcDkdCP5lD4erj39IG4CU0VtpmRf
 GjJ1CqueLCf5wv7QW0Tx7rU0e+yYWK+dBpu2K/3HpFKVZSMND28Ff4HfUa9JInAh4myu
 a49fPfxwWYwI4VVb+qm0Wxva8g0UjvsDAIAplxNzMgm5LEpGwmN5zLcyGwPQg7JgbYNo
 wtvyEctkusVZobjjjLfcEmOPje2dQ7GbsxfXPV5c/nBNOWwyqfD2nNN1C4m/rJdxYZyR
 xl2D/Op3gwcEDkvfO6u+puvtbvutDqY1Y28iWiVb+ZrCpKxr0MifKMcmBz472DikwIYj
 HgUg==
X-Gm-Message-State: AOAM5315OUUnHGUcZ67anydllHBJU6xzbW8MD0FegO2rSQoO/v5TjYCV
 8dgT2baj1Wx5ilg8TE7lnraNu2d8d0A=
X-Google-Smtp-Source: ABdhPJx4NatPhUIv7pC+yY+zixUo0ZVltP7FiXEdS+EccIr1e7IG+bp8aNnyYjh4eFSKBlxoo+PUAA==
X-Received: by 2002:a17:90b:e05:: with SMTP id
 ge5mr6043807pjb.49.1592612466028; 
 Fri, 19 Jun 2020 17:21:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 127sm4650601pgf.5.2020.06.19.17.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 17:21:05 -0700 (PDT)
Subject: Re: [PATCH 21/21] target/arm: Move some functions used only in
 translate-neon.inc.c to that file
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07fa348b-dc59-37d3-072a-c71c867b33c0@linaro.org>
Date: Fri, 19 Jun 2020 17:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
> The functions neon_element_offset(), neon_load_element(),
> neon_load_element64(), neon_store_element() and
> neon_store_element64() are used only in the translate-neon.inc.c
> file, so move their definitions there.
> 
> Since the .inc.c file is #included in translate.c this doesn't make
> much difference currently, but it's a more logical place to put the
> functions and it might be helpful if we ever decide to try to make
> the .inc.c files genuinely separate compilation units.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 101 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 101 --------------------------------
>  2 files changed, 101 insertions(+), 101 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


