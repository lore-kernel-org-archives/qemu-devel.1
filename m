Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8493D2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVvo+Edn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8493D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FTd-0004Mo-Rh
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1FST-00030G-Nk
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:47:21 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:35131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1FSQ-00070u-6E
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:47:21 -0400
Received: by mail-pj1-x102b.google.com with SMTP id t6so1825820pjr.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RcGUfUAjddfUBHOuKQ5pN2qzHSThkFPpWgJf8aJoMoA=;
 b=mVvo+EdnweQQ0owvecVAbpCC9S82jrPwmEHyb6ndiCCmrYlT7XqlqWBBbbI9+cVDw8
 yONrU0dOVNRKJd6wKzGB4lrBWEWeYfArcVSiQDc57nfhFxr1RlphMNQz12YneqjtX16K
 u0RRkNhFwRVrCqW27bBPyKxs3x2cdUjAoeNDOP1UC3xxteAVNiVpYs512GOWJruPkBj6
 r0QneH1x97RsBOPVbH4OqVjmTPAZ745spIJhc8ApU6OcRwh2uaCb/b9MQibRC0RLn4wN
 //QG7R8hZajsTKXRXGWB1m5Hr90pkSWSjMB6QV0LAV7DFRhBVuqGM73D8LmrUPIE2j2b
 UK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RcGUfUAjddfUBHOuKQ5pN2qzHSThkFPpWgJf8aJoMoA=;
 b=XOIAKSbyMckjVEa6c2GddRjuKnYBTlORcSawq4pYoxVV9IEedxiJxMCtKqT+dEvrPT
 GJQUaT/mcS8YoPQGdoyXUBj3d4N2MSJYJpUz2d17qScGC7LTAJ5YGxDz7YHxBZ578PCm
 gmUKwhOLSGQZrji728anZVrOB2NvSyNjp9/pM81DQ2hH9jfduY76bMRkttYWmi2bKpmt
 LRKTS9yU6hr3VJWOZgSmS1sxcVCnwpIz5yTiejkO5endVWxbXTKKPYOqAkRdN+3AVJFS
 GHoPdjfeLoeXF7Vpre+nzeSJUqlElMP9EIj2fwN60jPsqnMTiNP03zqrixE5PG6z7dE8
 GCPg==
X-Gm-Message-State: AOAM5300yNFDRxm7OddqjUmWS9LcnMaoxoJFq0iky3ONmLGntGKPsngX
 vuWCfG1WvExrEgifBDIDx6H/Eg==
X-Google-Smtp-Source: ABdhPJykdA/f5sQf8LJIrWRuKboV7p24vpJXHrnmAYx4lQAxDrGaTr1SImSF5ckvLkG688apB0cyOw==
X-Received: by 2002:a62:3382:: with SMTP id z124mr669971pfz.309.1596142036102; 
 Thu, 30 Jul 2020 13:47:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b20sm265922pfo.88.2020.07.30.13.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 13:47:15 -0700 (PDT)
Subject: Re: [RFC v2 45/76] target/riscv: rvv-0.9: single-width bit shift
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-46-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2498a5e8-4026-69e4-f402-8d1e85ef6dd1@linaro.org>
Date: Thu, 30 Jul 2020 13:47:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-46-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Truncate vsll.vi, vsrl.vi, vsra.vi's immediate values to lg2(SEW) bits.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

