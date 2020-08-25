Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D41C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D20520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgCApJ4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D20520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAe1H-0007c0-HN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdzl-0006es-D3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:48:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdzi-0001gZ-VZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:48:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id u20so8049731pfn.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=isF5Woq5aSdLBbbtD2StJ3KXo+eex49HUq9vSAe/TM4=;
 b=pgCApJ4VXdPmQYkSb95qkUJAa3pHtD8fqLnV5jDScSUipH3hYhWb5Uhk5fFoqo2sG4
 m4/81qNJ3g9Vo4yzUme0lKFLqH7SIR4DpHFCh2R/5bnMtgrhPn/Y+iPuYdio5kYe4ATM
 tJ0BYluhyPVauN0zPrjmgs3+20A2YwWWIY+J3IklYg+EerOREms7nobUx031q0KQ/k2c
 eC30ps1y1DPdd9RtQgYXBHFlNn2qiFNnBTg9d1FEb3xfA+/KkHN2e0MiIucXF/IeOnS+
 yeirAQasQwYgU82qNzn+mvPSDSZyMjcyOFQ25phyeD1+CDZ4joHet3jflcmqlJiH/JKM
 d2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=isF5Woq5aSdLBbbtD2StJ3KXo+eex49HUq9vSAe/TM4=;
 b=gYsSSA6I3k+Td49tk9hFplA9hXC4klgMmtfbQQ/0Obp/MUYwscQhgOZGk1lX+eALnh
 lwD1R1MDyCyqwA3147UVj9/fo+MmDU37ifOE/ZGmTmF9rEdUSBt1aSQ6SAuIWbLDp9AP
 p6cPGjZqgip/MbCT9Pc4zhHGwpBOD43cjU26kHlovkPElPANnU9pCfbBPzk/MQifEfQ0
 9KPcnLceEbS1W54xjQYZ3yDfTOk3oenzdsGoKHm9YCoPIf92SAezmk7MJCMN28fzbdIB
 +wWhau/3eOZqlKbdraNn4EzVg1eLmncj6Zkz55ZCs8PHAK2+X3os1JDLaq8HD4fZBdDA
 seCQ==
X-Gm-Message-State: AOAM530c34lZNdAyYdGuNaSbOmvFlzoxBNCf373hdM1CRTctxeOPHDhS
 6T/jZaSc1WA6fpXKRnYUNqZa3I5uHHCS2g==
X-Google-Smtp-Source: ABdhPJyQBk//9DsfPOvfuzv/7fknlalCeCY24oYpj0S434z9AiwnaOCQbHkX6KZL9juJx9TSdtSFyw==
X-Received: by 2002:a05:6a00:7c2:: with SMTP id
 n2mr7173123pfu.28.1598381306203; 
 Tue, 25 Aug 2020 11:48:26 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id d124sm7977046pfa.40.2020.08.25.11.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:48:25 -0700 (PDT)
Subject: Re: [PATCH 14/22] target/arm: Use macros instead of open-coding fp16
 conversion helpers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d3a16e38-7464-f22b-f78c-361e4eece375@linaro.org>
Date: Tue, 25 Aug 2020 11:48:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Now the VFP_CONV_FIX macros can handle fp16's distinction between the
> width of the operation and the width of the type used to pass operands,
> use the macros rather than the open-coded functions.
> 
> This creates an extra six helper functions, all of which we are going
> to need for the AArch32 VFP fp16 instructions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h     |  6 +++
>  target/arm/vfp_helper.c | 86 +++--------------------------------------
>  2 files changed, 12 insertions(+), 80 deletions(-)

Same comments re the helper types.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

