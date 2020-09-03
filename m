Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0FC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874D120775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlOWKZ1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874D120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsAL-0002bI-OM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDs9h-0001ry-RG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:32:09 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDs9g-0002uc-DJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:32:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id l191so2562200pgd.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=L831aU5ZmFVbPOJ34eXzeRbro0XWUt8QHQegjM49WvA=;
 b=YlOWKZ1viAlrSkec0I819gea3M5D+fD67zFaOJbLw4YJe8RbmYnZca0muBfW4AyoY7
 2wmHeVH2b0f4McsBPHKsSq3osPjsb91Z9ll48OTsOrDSkCCDW0RqxO+A3lrrOV5N6mbP
 Ke3uk8mvaL2puZLLS9TIAfUG6qBEoqPXjuwEBLl0hBqMuo0ZrRjAW2LSvK3Y8FK5Jy1W
 whN3kSasQEQCsIor7SgGPqDn4VeOwtO2dF4qy/f4nsrviLzfL8soYYElMc9wQpnD+ggJ
 cJZgdR/8ouAdkkDiSKVE6zgKpAM402EzeaUKbE419TwD0L7iQa0TR6UtR0LFO5zKS1aj
 fenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L831aU5ZmFVbPOJ34eXzeRbro0XWUt8QHQegjM49WvA=;
 b=E2LMiN3VThaj2RJ2UTN0mY5Ey5StFiO2hztfgorkJstrW8BWDDS34o5Laks//Za5w/
 BqS/BwrCNiRMsrlXx74qtjExA32zECAEdHItoaOAv+e/i7whpFSJT1bx8MPL80Ix1zsi
 1u6dy4EIvKLMOTv518QLU4SlD+qRlkCGWBDMlOBLKGye/DKUpWD6puZnOtkh04Blov/G
 qPnMyUR87LyTS5Y9Y49S4O7Yd2B+H0NClo7raChRoNzJ0DHLfWdC40RcRe8f5FuwZnnt
 blmSSuPY7Qteb7ZSUhqoeEUxv9iQ1wvPExCbppJpP+HnrfdNks1Bpn4OYXyRZ3kWE+bz
 sq3w==
X-Gm-Message-State: AOAM532WEKBzJ08pFUUP37EUS0PKdVdFO+FEVrjYvUbjy0GxetrqDoKi
 gNInwcP9j8HLxuNRd0thaBxjAUxx/nS8mg==
X-Google-Smtp-Source: ABdhPJzycKWPkRIJfYn9ylYRhuFxE4sV3NWV1BjRMOhlWA24pvx7/2/ZGmPCQdD9sVMHNut/cxTLOQ==
X-Received: by 2002:a17:902:7c8b:: with SMTP id
 y11mr2287353pll.10.1599150726529; 
 Thu, 03 Sep 2020 09:32:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i6sm3332916pgl.25.2020.09.03.09.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:32:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] target/arm: Convert VCMLA, VCADD size field to MO_*
 in decode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200903133209.5141-1-peter.maydell@linaro.org>
 <20200903133209.5141-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b544b983-8836-2741-7380-6a98ce4f4715@linaro.org>
Date: Thu, 3 Sep 2020 09:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903133209.5141-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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

On 9/3/20 6:32 AM, Peter Maydell wrote:
> The VCMLA and VCADD insns have a size field which is 0 for fp16
> and 1 for fp32 (note that this is the reverse of the Neon 3-same
> encoding!). Convert it to MO_* values in decode for consistency.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-shared.decode   | 18 ++++++++++++------
>  target/arm/translate-neon.c.inc | 22 ++++++++++++----------
>  2 files changed, 24 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

