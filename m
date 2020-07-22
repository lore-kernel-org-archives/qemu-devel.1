Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F404BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9D7207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBdPIRHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9D7207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI1Z-0004Uv-2S
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyI0i-0003fu-8o
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:54:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:37048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyI0f-0001r7-Pz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:54:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id p1so1288141pls.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+EumrwK7YBGBbZdkjnVM4S0JFvanV+cOWSYvSZBs/hQ=;
 b=WBdPIRHuiiGYt48BYgfTO/ZYa7ppJF2dBGZPcxt7RrPUWdnOEfPgEMp+2mb0xVkM1k
 mwi0usqCT4Xp/6j36r911PBgAZc8ZVaeinTQGQrhKPVc3ttg8bHWnhIX1wSHBDby7bT6
 MOhAfpmWahu9lxnFttbgS2cV6OZXMB8Wzb6uH3BK005kGQHoMmOFvdhpL56SnM/ILsgu
 hie6vVm9bvxP7c7D4dIle70duPiHQ1NPjyYDBzb2sXbo+D4DdPdsRuDztLNVx6BFx0TB
 utDNH8YXBtQjzlqE4GvDpQiKv5ODfXn/PdcixcVwyeCpfptuhF2JN5vN0h4t6BTuVYA7
 XHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+EumrwK7YBGBbZdkjnVM4S0JFvanV+cOWSYvSZBs/hQ=;
 b=LDd+fIwCXhk4+abVbN+9hcskMF9hZXmaOLKA0MuPJFHfyfTCa5Wc4yDh/R60PB0hq8
 eHZ/sZaS0N2DX0ZSAcV/xMEWLaTR8TGBHOxlfhzwyClK/VQMdiqIEne7EFj0QsdeZRk+
 aWFIilKOorB/FuEbBf8cV5H1pfY2LdUUzDkObIMU90DDmo/5ohkfA1L+aa7SORNRyA5P
 mJA1Azbq+JSsgcqx41KJ6ghxD32dTiDAPqtD0TvHfEC1fU1a6MlMJ6ktMljVq5nwUjYG
 aPAnYZv/hv7DKak1XPHqe+zZ+CA7Bsl0x6HkpwzHVdyEN0D5I6J4aC7/XJPap6QMDdLo
 s23g==
X-Gm-Message-State: AOAM531tnyGIKgtHeVn5skJZfreY8xDV+9KFH1/MikVWNjB9aUG3u+Tw
 mMkOK2Hr39qNu9pksYPl1KWRPA==
X-Google-Smtp-Source: ABdhPJxzOSgIjCSeGfsgHOyCtcCEwHKPwDBeLHQF7q/r8Acu+jJMFGOCGE1mxhNRaj/AQ3OiLTKTuQ==
X-Received: by 2002:a17:90a:e50c:: with SMTP id
 t12mr268081pjy.209.1595436864269; 
 Wed, 22 Jul 2020 09:54:24 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 v197sm149651pfc.35.2020.07.22.09.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:54:23 -0700 (PDT)
Subject: Re: [RFC v2 11/76] target/riscv: rvv-0.9: remove vxrm and vxsat
 fields from fcsr register
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-12-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2caadb83-0a78-e8f4-6363-67c7ebfa5bc1@linaro.org>
Date: Wed, 22 Jul 2020 09:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-12-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Remove VXRM and VXSAT fields from FCSR register
> as they are only presented in VCSR register.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/csr.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


