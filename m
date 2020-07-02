Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E2D21582
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJJjcHBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E2D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2p5-0000Jm-3Z
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr2mU-0005XN-8J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:13:50 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr2mQ-0001vQ-Q2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:13:49 -0400
Received: by mail-pj1-x1041.google.com with SMTP id u8so12408772pje.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=07nJVMkiG7AtfkY5LtU7B6xMAKxLM2cvT3Tmdjs4RXM=;
 b=RJJjcHBYvCzvsQDc2YI4iY8QIMd6CEP3rn1W/fXUIGHcRmVVHSYXW8w1lQ8uoAl/4I
 L99Qo4/DQYoerRiuk6K27NX96R1/o2lgI7gwrsha3s52hQA4B/xoZLc+qrg3ZDlrlHOn
 kPBkn/GQdGbtHML8fkS1oOXTNZ57KjOO8ahWt1oDWVl02B/ysDIDbyIBfgvyoEjGqvUV
 3OOTEXtxlwbH4S6Ru3WCzmamCmUyn8+G9IT4UW03wHEQDXqqX7GiWbo0jZO+x4nHrz82
 InH4Re6MpmWhlfn27tuONdx1t74SnVGAzgiGrayLwIKcz3uMDGuuQ1VH9tXXFIODFaJ0
 Y55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=07nJVMkiG7AtfkY5LtU7B6xMAKxLM2cvT3Tmdjs4RXM=;
 b=bmZ5lAtBWjwbOODXp+qI7b/ijG3FR9N0NQX0XOifewcTfyStBqTpUtNOdddwCvrzr5
 dXVMHzg3058t9/nPvqeQYaKCU7ODv5TKWBdWb1xDHYCa6c1hKHeDCbcFPY5TZPQcxpfd
 iImsjcdwNCc8wxepYgfYeT0up/odgWJ8v9yLyRPMsZqLxOUKlIeuzjdMt21WQ/xIeRBp
 uFefrW3+GdS9V8C1PNBXGv7asOdFTO/GG+fK2woe4O16FcmjhWg+zgucsbdjpTNFUpNd
 FwPqTiJjfnFIwOUn/+SR4UFAG77+9JQk1kI4PHZ+wQcogQNw1td0576tkFvS40//DVJS
 zGXA==
X-Gm-Message-State: AOAM530+kCpeD1FVGI45ZiwLMzOyoiM/vfMPaPf955r58Q3eu8JRtTLO
 MF0T/ij9CfRDLy+Rnk54dpT9kg==
X-Google-Smtp-Source: ABdhPJzmMZrhv4LAOKmBF9xqMwGkfJArhZOZk+1dHDVbMcY/tV2I5mNn/VVi9tFtz9FTgDIxiLT36A==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id
 na11mr33788479pjb.176.1593710025493; 
 Thu, 02 Jul 2020 10:13:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t137sm9745346pgc.32.2020.07.02.10.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 10:13:44 -0700 (PDT)
Subject: Re: [PATCH 4/6] target/riscv: check before allocating TCG temps
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f28923c9-937e-37fb-1402-86736177aa52@linaro.org>
Date: Thu, 2 Jul 2020 10:13:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626205917.4545-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/insn_trans/trans_rvd.inc.c | 8 ++++----
>  target/riscv/insn_trans/trans_rvf.inc.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


