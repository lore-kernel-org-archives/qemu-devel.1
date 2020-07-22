Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCF620658
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQFzOTA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCF620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHiS-000175-Vh
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHhm-0000Ld-BN
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:34:54 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:37031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHhk-0007la-OW
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:34:54 -0400
Received: by mail-pg1-x52c.google.com with SMTP id d4so1563593pgk.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oabH2Z/oRLSIBk9EzJXgASRsXMWhHmXzr/gix3fmPZ8=;
 b=XQFzOTA3SyGwNM5xtm1S5zAmHb6SBwzpEkEQkI9mBJQasFe67NzszqZNOTqgDThScm
 O8q31dgtv0zumcK+McjoscNraCtPq05wmJunuZBAq/LTQ5dpmXnu3B/dEYrymBMpeW5i
 rmkNqmXxh4z9OeTdQrZhhXaYTqVORLd7qkTyi4ctxB4S7YpgIdmdiZTaHgndDQ0NtQSZ
 TOKSuHyOhC5UsvXWEoSnOOzNji2AR+zL2UF6qWwQbN9RMfZ9RSNCwrh8xWDLlsFcMasp
 zqwcp5EHNxJzei9Ehkrle8v3Fd8xzZU/QL8WN9WY9VT7ytV0ECNAfRUgIi/T0ceVcjCs
 QL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oabH2Z/oRLSIBk9EzJXgASRsXMWhHmXzr/gix3fmPZ8=;
 b=lzhPrU77ybijLplWbpt82AqFSrRedpSvxZ7NsjYDYt9XiBdzPfXY8z7AAOpZb8FINS
 I/1KfWQ3XVOQpfoWLRUBFvLK0ClYOr+fG3ew7E4a6dlZFnm30VonVOp+EHgaZUvvHWuT
 vyU5Z3m9PRGpzTFP1cM6u5wHBhQ9nnSwP4rww4AVseKpicq3UZhC0Z3qOF++u6Xe/K4M
 T1LoyX/Ha/WQeE0u5BEjRdHDK4s+cX80RgOzC6Q+nRGES4uZ/fQR17W5L5binO9ppNXq
 RnU1BT7Q/RnZDpwWyTIUt9iy6HD7bcI8fRJ5qhcrXAWVDL+NNY0pzTd6uk+J1rI/tShO
 77Pw==
X-Gm-Message-State: AOAM531LA1P7aXiVxOapvYLqxhwcv0AMTXnZZer2drTy+FPKAtd4s78l
 1n5D8v1ThZn97Tp+5P8Pptllaw==
X-Google-Smtp-Source: ABdhPJxLnrtLtDGGXgTNTgn4GqO1SXXZbcPvolKDS/poXDjLtcfPr5DhTfc899Lz2A9/GpELDQn2zA==
X-Received: by 2002:a63:7d08:: with SMTP id y8mr589578pgc.224.1595435691306;
 Wed, 22 Jul 2020 09:34:51 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 n18sm100628pfd.99.2020.07.22.09.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:34:50 -0700 (PDT)
Subject: Re: [RFC v2 09/76] target/riscv: rvv-0.9: add sstatus VS field
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-10-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6e02a1d-fabd-75ad-eca9-4a5236b81867@linaro.org>
Date: Wed, 22 Jul 2020 09:34:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-10-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


