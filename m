Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE7C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB17922208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3ZPRVVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB17922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGoiD-00065A-14
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGohV-0005W0-WE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:27:14 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGohT-0008E6-9C
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:27:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id k13so1328464plk.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=bMm4zXvxwVQiSgLRoli6zcYFZ83KsUkk9g1uD5Z/NeI=;
 b=n3ZPRVVW9P2F8SxpaUkuGkj3o7iluO9Iaxfy7rKtJdXAdWqY0O4UGWyqBa7pZkshAN
 1R9c3QVuUUOekg1n2tr/qNPEOPTPMEOmLZJm/FFMXppR3eLIh29ztrZo+TSyKc7Amy4E
 ckCR6DxXCmGLBtzXoSAuyVC5eCDdmFwU23S+NOgHKXN1CjYOEVKJtge3/aFnHwlw/Kjf
 dZ5xujAV1kxs7b4PKO592SgjLkhocmH8k84QaHhv7XlaTT2rBp1qtfjfiaeKjnZyn9IL
 xAQ43FqrtIDxKW93uvi3HP82orhTeN9mGcJ4p6ZU4hORXqATBCzX18/3rj3owR38jdBP
 DREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bMm4zXvxwVQiSgLRoli6zcYFZ83KsUkk9g1uD5Z/NeI=;
 b=aMcIbv1yB2y7g9Ff4LMLWDGuZDyMm/CTIivCF8ThANJ4kQQmozzRHLcm7yzhINGTcW
 v6wamjfg7eR0LxasZbren7gMmWsCAvZoE0jIdf79J1AERTYY/m+CeUVmO6wKgyLva8hb
 /m3LadXcioJ9PSqMfKfhd2HsBrpKchLHHGksy6rb0w6yWOdB1KbDtcLhdGHg36bZGTx6
 86U3oz67IdO+YRF68Wt5GVAAlgZxtGP3rJ7oOJO5vO66VlkwypgyWDRWBPLQr3JnY/wn
 c2Z7QOLWEoI/AxZbrrfDZNYU2R993caOBH4xRCxzOUqzX0HZ8Gre1tEpH5m9obDjp0eL
 ceUg==
X-Gm-Message-State: AOAM531KMjf2Hx3RQr+0kvfhTjJn/rtSp5fn7LHy+QmVZcGwN2NdTfwn
 2IvOzBwU8eIEg2C6NLK9czwIj+EHff9+Yw==
X-Google-Smtp-Source: ABdhPJxUkTSaYWhh8g8EGNlSe8Xck1YeuEhqxQllkD1g/sv1R+kY+Yzn9341m2Gt5zhDZpIFtvQIsQ==
X-Received: by 2002:a17:902:aa02:b029:d0:cbe1:e7b4 with SMTP id
 be2-20020a170902aa02b02900d0cbe1e7b4mr3692465plb.37.1599852429267; 
 Fri, 11 Sep 2020 12:27:09 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n2sm2982335pfa.182.2020.09.11.12.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:27:08 -0700 (PDT)
Subject: Re: [PATCH 1/5] target/arm: Replace ARM_FEATURE_PXN with
 ID_MMFR0.VMSA check
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200910173855.4068-1-peter.maydell@linaro.org>
 <20200910173855.4068-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <072e80c8-6cd7-8b30-6866-b22969be17e5@linaro.org>
Date: Fri, 11 Sep 2020 12:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910173855.4068-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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

On 9/10/20 10:38 AM, Peter Maydell wrote:
> The ARM_FEATURE_PXN bit indicates whether the CPU supports the PXN
> bit in short-descriptor translation table format descriptors.  This
> is indicated by ID_MMFR0.VMSA being at least 0b0100.  Replace the
> feature bit with an ID register check, in line with our preference
> for ID register checks over feature bits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 15 ++++++++++++++-
>  target/arm/cpu.c    |  1 -
>  target/arm/helper.c |  5 +++--
>  3 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

