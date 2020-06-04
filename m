Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8E5C433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09490207ED
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkBt+yzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09490207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwvr-0000or-4I
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwvG-0000NB-E1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:57:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwvF-0003nT-5a
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:57:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id d10so4072405pgn.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xaRytzTuAUe2NTVglXQORrGF77j+wdUxqEvCHUy8FPQ=;
 b=GkBt+yzv/XGjwqFz3mi2rXXdahdg1Q45E5lLI+yw2X1McBcdnk/jDVWJuPtSqNOQEq
 Qq8E0OnR76+Nd2qIBadQVnh9FMXqic2y+a4T2tcB7k3S3BtrjYMVeUuOo2f3F500pV4h
 sov5rRGlvzDEIcNsLWF39DeD289kYY34kQ4UwRY1D2RK8XGsm69Yyp0FuHfxDqxJ5Ckb
 HyHXlHdCHp5r//qf+Ins9ZkijbBKcfmvMGIg4AYm2yT9DL4cszG1sHdt1rY7hXIW4nck
 BU1cokagV3bApNcQobvoXEFZ8Cw6KGF29Jdur/V/qyR5sCArRtLgI8Jlw3KYRM+Z7fdZ
 51PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xaRytzTuAUe2NTVglXQORrGF77j+wdUxqEvCHUy8FPQ=;
 b=j+aU8BCRaWZzGbwak9zD8eA4UuQo0clf3lX4bgcGVGcVxMRIOin9Wje3DkZPKG7TRs
 GY9FrafKeko/IQBZml23QWaYkNKkQdF2oW/g6EuIanU67J6xWirTLC7eem0/chqxHUi5
 pZ5xdvT/JxKTtb5bL8hVOoPp2JQh9m07QoPOiME4Isvqkb2M/JVVCZbMvSRvc0lmiaoq
 fKRSFqgC1vquX8mNJ35vQSHvC1fOHrrn7LHmQS1PutE3Wt5XjyfQwW1phLD7l+tdJzBr
 vALqOR+k+Att5IJVF1ybW613YkrPI+yp27WUz9MKe/XsVQr05ATuwhjbCyVTrpCTjN6w
 6BIg==
X-Gm-Message-State: AOAM530sRqPAYgIczKd8Mk0EqKm+oCxlsTY8uSBVZC1yvn0lfNEqcj41
 abGGI8LLlMgcdqoXdUqgWtYmXw==
X-Google-Smtp-Source: ABdhPJxpkF9M4ixtQAFQVrxCvxW3DzjtRxb34CZpIm6rKyoxQ8BZFuNGDoeJ5lVJLOm/AW2bUEPZ+w==
X-Received: by 2002:a63:5245:: with SMTP id s5mr5971116pgl.394.1591304227456; 
 Thu, 04 Jun 2020 13:57:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f3sm7392153pjw.57.2020.06.04.13.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 13:57:06 -0700 (PDT)
Subject: Re: [PATCH v8 42/62] target/riscv: vector floating-point merge
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-43-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a5fa9607-3c3a-0b9e-be3d-53e024f8b923@linaro.org>
Date: Thu, 4 Jun 2020 13:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094413.10425-43-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 2:43 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  4 +++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 38 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 24 ++++++++++++++++
>  4 files changed, 68 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


