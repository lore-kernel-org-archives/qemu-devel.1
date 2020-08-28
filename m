Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F78C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F152086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjAXh/tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnS0-0008IP-EC
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnQv-0007LM-2l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:05:21 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnQt-0004DD-4e
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:05:20 -0400
Received: by mail-pg1-x544.google.com with SMTP id w186so1119131pgb.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=65HSA4NvUoLzX9D+wRRBDPsFW095WmkNdu8aJBd8NJI=;
 b=AjAXh/tbk3c+x2A0A9jbPV7jZvKzBdusT2mJHQY4coHJSwIOt3qG3mYqh8aUAIUTLV
 4kkJDfouA8VeXC5kePjRCasEd4+dcoTE3T8nshJik1YALrpCE0XqNTBI+ffS5TbusGAE
 a7WEe+H/OyvbKHTwr5UfdQwQ2y0t8C1L9f1zKKZ+pBPQas2MHLCdyy/1vdVowwbRslWi
 Em/y2hNf4ErNRJKnNDd540AlR8g4rmwm4Zjoursu/gsDXc0BCRs7w4PlOzRvrX83Xc2r
 CRKNKdqhukR9IoHPKTt2ai/rxdH8qdr8t13EehMOqByLeP9Ed+jn7ntAeymTs57ri8eI
 YEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65HSA4NvUoLzX9D+wRRBDPsFW095WmkNdu8aJBd8NJI=;
 b=XvsOsFIefR2zFqyDr9qZprKl2zMBtjoYisZdmRmVxk4n71k5jalemdZO4zFJce3fjq
 EJVxSmyD3FXHDjSQ5fl46eWXy8MRhQi4vCVLmtFgukEwW1OJK6/Uqt22pTgQKStazXMe
 z23X5SYWtpPuiZBPAiSXt0xRb4DTUqYTJlo4/SSf7lOABrJAR0J2980wFR0bahoLeI1m
 SJNO04mhVYR1wlWq0ECs8hzcNbVZgjIEbugF8HHgkYb/u1i3yeGxf0j80WB5mwwnhRUG
 UMD9T+t4OzUPUBLvgRB5kS7tEZkRDeav09aRoZXsjHPc984Yoc4qlrR9eG/4WO5y1I2j
 iFUQ==
X-Gm-Message-State: AOAM531XVhjwPxgrOhwOA6zsrzvdcRrmv3cs71XjzLPch0el4ZUJdooF
 71WVUgib+XOo2x2vzP7pPHwk31TBqas6ww==
X-Google-Smtp-Source: ABdhPJyEluBvTyR1J9brIgsr9a64eI+jiwXpVHJ8m3VelE5pbLbbXalvDC6q8fP+bMizDcb68aQ2aA==
X-Received: by 2002:a63:500e:: with SMTP id e14mr749584pgb.36.1598655917325;
 Fri, 28 Aug 2020 16:05:17 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g25sm482297pfk.37.2020.08.28.16.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:05:16 -0700 (PDT)
Subject: Re: [PATCH v2 35/45] target/arm: Implement fp16 for Neon pairwise fp
 ops
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-36-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94dee46b-3ee6-d1dc-c0e6-e5d83acac363@linaro.org>
Date: Fri, 28 Aug 2020 16:05:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon pairwise fp ops to use a single gvic-style
> helper to do the full operation instead of one helper call
> for each 32-bit part. This allows us to use the same
> framework to implement the fp16.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  7 +++++
>  target/arm/vec_helper.c         | 45 +++++++++++++++++++++++++++++++++
>  target/arm/translate-neon.c.inc | 42 ++++++++++++------------------
>  3 files changed, 68 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


