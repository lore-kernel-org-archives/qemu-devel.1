Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A352071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMblEuVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A352071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdam-0007we-QF
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdZy-0007Bg-J4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:21:54 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdZw-0006rT-EW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:21:54 -0400
Received: by mail-pf1-x443.google.com with SMTP id u128so7991033pfb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ZHMwKmfJfUTpjoT48OQ71F+G5/tJtqS+sLxmIICgYIw=;
 b=WMblEuVV8vOg3UfxusOyIs2pyYitzlvG9Hs2kqsXyO9x8k22X5Q3oNihTXYwzQ/BUR
 bB+Z8oWZMHJGDAt/5TtetT6ERjCZuXNrYCheWjK7DdFQ4x7J4eq46MHyCet7bELr6DNk
 Jpbbq63Ij3WPOpRO9UunZBEn5nmzMbEgMKhykmZYoeioQuaRjloclPJ1xJesGvEfIGf/
 Jz3m8j2WUc8k5C+92FzJuCF2XBbcsRl18V92I9TMs38A/qmvt/Lt6YO07rnNtFXb5pEP
 4wnhfgZk6X0c4o/q13Z+r4a+EzomakxwkUFQB12hv4Z34n8hXzBjdKgf6jB7WG0krZ40
 AsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZHMwKmfJfUTpjoT48OQ71F+G5/tJtqS+sLxmIICgYIw=;
 b=pHFidboCgahQ522DbQxYRIWUG/L9HHZOocFo7A6zeY1xu5AVrlLVSS5vJNzvBjIKdD
 vbZemltkNwu9dOHn41yq22ZeTS1M19UAY5/RLY6VOifjGS4ISkOz1iGTl03LXmtkCurp
 c/Iyk91y97r8q0O3RcWRAubiYVo6mESN6n9t/tWRHNPLMhlLgI0H7xuuYEDp4ZTzVUD+
 3IMVkZ2Gbvwhtk8kghZmdOX3EcWxEhJE3BA33v4zTD7qqJcHSdYEtDgullIsESRzRdug
 9bWn1FOgw3B2Hv53XJ41Dg49VivVTBL5WDdCw6ws7fQkI0l91v3lFwczf+EWhXkloFls
 pXBw==
X-Gm-Message-State: AOAM530mYJ57Wf/DT8zPjEAMQy2jDmnsgpF5LCLkWg5kDSxSCQU5cRdb
 Smuo9KJ8pvKrRIEZ2M1bg+YUNOyQWgJ3gw==
X-Google-Smtp-Source: ABdhPJz7QZZ+lA1s/5QclTaZZcSHEiJmiQ+621q7ptIqA+euUODBMMQDcleWaJP5BVwhCzFeNHajvQ==
X-Received: by 2002:aa7:9571:: with SMTP id x17mr354951pfq.90.1598379710287;
 Tue, 25 Aug 2020 11:21:50 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id h14sm15819083pfk.195.2020.08.25.11.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:21:49 -0700 (PDT)
Subject: Re: [PATCH 06/22] target/arm: Implement VFP fp16 for
 fused-multiply-add
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f98bfae2-f89c-af9a-e614-a4b7ff42a6a0@linaro.org>
Date: Tue, 25 Aug 2020 11:21:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement VFP fp16 support for fused multiply-add insns
> VFNMA, VFNMS, VFMA, VFMS.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h            |  1 +
>  target/arm/vfp.decode          |  5 +++
>  target/arm/vfp_helper.c        |  6 ++++
>  target/arm/translate-vfp.c.inc | 64 ++++++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+)

Same comments re the helper types.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

