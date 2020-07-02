Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5959220760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kw3x6yD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5959220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr30M-0007Cc-Ip
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr2m4-0004lq-0I
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:13:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr2m2-0001rx-54
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:13:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id e18so13764977pgn.7
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vC0Rst6l0gRSvlXEnfoi0RT+AdeMCVLvWZ4rDaU0gkA=;
 b=Kw3x6yD7n86BecEqz6XDOrq5Anqwv5mn+jV7XI2tssMwywz1GD3Gi6KOqgt1Z1478i
 +Ae+T/LVt0ULVKfBusisW4KPQ5b9sWg9EWo0oC77MRr9A42bQCY7jIF6hV4l4JaYSdaC
 WQFqqJ7avfbSLKxQUU11sS113mSPnWVZsup4p2gLc58ikAroeqPNQQI57GkZjF3LUvXQ
 XtNMeI9Rf2EI3d2SwCHU+LjiNa5L1bz/ZVOGxTECWhp3rB3H8w38xnswLvMktz0CbcXR
 gLu3xAqh18T6inCLLvADqw2XZ51O72CcBJBFOjm4q1gPgqGXFSwhyg/l10AyCsMxvGre
 sPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vC0Rst6l0gRSvlXEnfoi0RT+AdeMCVLvWZ4rDaU0gkA=;
 b=ro2tdemKkwb51tnYdWpe1vZsANOHCrNm7kVEp6iWS0ZWvJu7gbN4aU2HGtipbTg9D9
 xoZKFkyTF4hiGek/sQzALT5V6Rl3gkR22MOFeIFoCAelyesJ8R545wTfpRgh6bYjOhkv
 7maZ35wxDyOvJ/LxvTFTfTTJuNq5bWpi0Cx9x3qngfyoA8n5mwNkn6fzSBwaJxfts9m+
 AER1zupbApOQtv6SYOwL75VRrmJGdzEF9ZdtggFAtSFwUE5qf6SqajNlUgC0y3K1+/ZD
 QbtP0jRrGQ9AIEkcSiHfjhCJepM/yU5JaxAxpOjFWoDEcX4B0beT9J9NBubVOMxOVlD/
 alpQ==
X-Gm-Message-State: AOAM5331Kl6Kkh5jMWHmyHsFuPHcZFXQGVMxjoi5lo+7paLCZhVwNT9D
 qRcnGestg8zrZ1pDIM4CLWM7xA==
X-Google-Smtp-Source: ABdhPJy2nlVqWAl3IVyAGf2VhUgyWCoDiMdOjfDiDrlnaCDu4PtZ39OFSCxhYF4GLPi8jWC0QReGkg==
X-Received: by 2002:a63:7a57:: with SMTP id j23mr10125777pgn.408.1593709999908; 
 Thu, 02 Jul 2020 10:13:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s22sm9093803pfm.164.2020.07.02.10.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 10:13:19 -0700 (PDT)
Subject: Re: [PATCH 1/6] target/riscv: move gen_nanbox_fpr to translate.c
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dd8d7b9-446b-264a-9ac6-4cdee4bd53c7@linaro.org>
Date: Thu, 2 Jul 2020 10:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626205917.4545-2-zhiwei_liu@c-sky.com>
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 ianjiang.ict@gmail.com, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 1:59 PM, LIU Zhiwei wrote:
> As this function will be used by fcvt.d.s in trans_rvd.inc.c,
> make it a visible function for RVF and RVD.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 14 --------------
>  target/riscv/translate.c                | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

