Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E8C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E392076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3vkyIjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E392076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC6fT-0008HZ-Al
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 15:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6eq-0007nA-NU
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:37:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:38260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6ep-0002oP-3I
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:37:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t11so1193816plr.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1DZS1CKCCVu4mf26sz0wE+xra3IkdIj2/iwU10xcWog=;
 b=Y3vkyIjBLqHdF6LrYpzh27pKf5VcikSjXLOH3jvRBweb640yYTPjMlO3ZlWPnOHc/i
 awx1zQ+hxh+pD5S1Ovy6PXeN/iDh6kBgvv8acnNklo+mZ/WZyAWSMwdBROiJ3plLstmI
 rhMQZpGfBdSgmt2b/oL8lfUJNGc62CZbG3fdfzrYFNalC1t9DhI4mVz6si8A/qMiQH2h
 WjZZZtl/G2qGJCaMkCenF97QvXQYjmSVa8OSJEJ9X4b8r7kwS97u3LclqlKrIjcx+/xx
 c+0212QYIXZ0Oj9J5WCS8bO6+/9x2UDYk/7rEVmPFaQOevnyjZAIT+xjNqjs/dMU9LL+
 b9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1DZS1CKCCVu4mf26sz0wE+xra3IkdIj2/iwU10xcWog=;
 b=dnJQVOLDbYIhJWv600IJGu5EkRdKmHjTITGZdPCk1QEA60y3C2Bo/hzcwPIYWHhcH7
 /Oyi/Ohr3oIhlksrGFjOVfKAlUNz48Df2gfS925umYfUqhnHmu7au9oGAwvNnlQK2NZk
 BF/uc77YqXBohoe1CHctC8BHjR/3jTTnn/GRgOXHq8Gy0d5ppX4wG+F7G31hNtFhpbl6
 RFGLC3l2KMEM53W/zhs+ZASDNw5pThN1MniYvbQCC2lliocvkrEnOQvH/L2EzzFCVH7h
 F/8uCiF6Z0UmkpV/v6wQ0+v0KUYLk5XGP3nLVdE3iIiZ0Cb0/nJCi6lI8oEUPvJBW4XY
 hwzQ==
X-Gm-Message-State: AOAM530csMHzBj21KvTwXnEfpODElgZSsUN1UnSiXTj9ADaab/azmur4
 QhzQupKdiJoNdZSUEfpvddWz5Q==
X-Google-Smtp-Source: ABdhPJwCRfBYjVooiyOxKEZ3iiWB+DHMEK13tPQtklgBpEntSMHAaQR+d1wG6I8XjNyaLvw7iOJIXQ==
X-Received: by 2002:a17:902:ea8c:: with SMTP id
 x12mr3601018plb.60.1598729817556; 
 Sat, 29 Aug 2020 12:36:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm2699920pjz.33.2020.08.29.12.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 12:36:56 -0700 (PDT)
Subject: Re: [RFC v4 25/70] target/riscv: rvv-1.0: take fractional LMUL into
 vector max elements calculation
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-26-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6b10a16-a0e9-6229-7461-65ba6fda7e9e@linaro.org>
Date: Sat, 29 Aug 2020 12:36:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-26-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Update vext_get_vlmax() and MAXSZ() to take fractional LMUL into
> calculation for RVV 1.0.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.h                      | 43 ++++++++++++++++++-------
>  target/riscv/insn_trans/trans_rvv.inc.c | 12 ++++++-
>  2 files changed, 42 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

