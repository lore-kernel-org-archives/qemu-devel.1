Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CFC2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrOlbpJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CFC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeWR-0007v0-7g
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeVN-0005yK-86
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:13 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeVL-000609-Mr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:12 -0400
Received: by mail-pg1-x544.google.com with SMTP id h12so7506370pgm.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ZcOtDISNju5VANZIDXq3Afvny9xaiP4LvHS7gNWmCK8=;
 b=jrOlbpJBoH84haagiXAR1X5LpDriUG9l2ako7Ga3gL8K+GcaHmbGipee2mwdxTIEkP
 yzSEN6OJj/CjkSOZxC5OM9PsQZgU+k41L5K/DvokO70UAm+AsxYVYv4cb+AX1V5sRbti
 +F202gC0kGM6/cWYe/8KmKOM/hIeKiPaF0UDnmGvF3GCpmyrqRu0vXY2FI17d/ioGl55
 FLasSXprJ5IEtXDkTV9oRfaF39+ZLo0/61IsmeonTzfeldafTduDgbqN07FnwEjgIRdu
 oubm8td3hFyeOkrzMaHAmx4nTk/g1mSbys7Vk9S4cRYEpVrc9iOcY6ryjGF/TPrgKuSF
 Gc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZcOtDISNju5VANZIDXq3Afvny9xaiP4LvHS7gNWmCK8=;
 b=fYH7hN5ihpIL2VLt88uxeg/vXx6Rck3vznIcaWaIac4xDCrOBtKEb7MHa6DKcTSsQ8
 lILOvW5USjYUNPYxZefGDi5pIFUvVIxo41oTFthdYNv+PUab5IbrSWOtd++YIfwEg4us
 PxbcoB2/CuOsABcKXSG/Xv5V7j+DyqhnIRaJxbBpZSA2CBYFQ4xoX8kek+BCXu3BF//v
 dlAql6VtPaLkR4cEts7PaIHDRzuGmBEuH6H+VaKNcBpknQcqYzUAzyoSzuFXnXYllCmb
 EHYnwr20uskIZ7s8DOHNwIf0iTU2TSXReW0MOKxCSEtW7Ey5mX11EbsZWh3z0jxvi7uk
 A35A==
X-Gm-Message-State: AOAM532Q3bNzdWwBca+QS6vBxzuIaNOgeUwVJ67KNYX7ysy276jiwx9O
 aa1mblratPM3vTv3SMyJK6YayAtZbAzZVA==
X-Google-Smtp-Source: ABdhPJzBXooN/icF+lpnpq4hE8/NTI+e2o5BkYG8lJwbYv3gkXZ8EoZ+d+5tRHL0w+pQC8XoN/zmjg==
X-Received: by 2002:a17:902:121:: with SMTP id
 30mr9062086plb.205.1598383270104; 
 Tue, 25 Aug 2020 12:21:10 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id r28sm15303418pfg.158.2020.08.25.12.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 12:21:09 -0700 (PDT)
Subject: Re: [PATCH 18/22] target/arm: Implement VFP fp16 VRINT*
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b909d0b5-003f-dc41-9c15-3fead63b684f@linaro.org>
Date: Tue, 25 Aug 2020 12:21:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
> Implement the fp16 version of the VFP VRINT* insns.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h            |  2 +
>  target/arm/vfp-uncond.decode   |  6 ++-
>  target/arm/vfp.decode          |  3 ++
>  target/arm/vfp_helper.c        | 21 ++++++++
>  target/arm/translate-vfp.c.inc | 98 +++++++++++++++++++++++++++++++---
>  5 files changed, 122 insertions(+), 8 deletions(-)

Same comments re the helper types.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

