Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D557C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454F32076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XluN9wa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454F32076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7QO-0003vN-Fp
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7Pg-0003F5-QN
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:25:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:44783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7Pf-00007O-AL
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:25:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id m34so2128589pgl.11
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g4xV3+UtU/EN3nIAWY0AUY+wJqcl4FqCGvroZVQR66s=;
 b=XluN9wa8FbCIynh4GdWrhX7dxzZ8fflXerrV/bC6iszymKW5VEkLF3ur4/qXHStCsn
 a/B4j9he8ECkxgT8ZeBoEHjg34Xox8OzaoSQxpdxQnCpcvXh8Y+WpOYl9zgHYgxS2oYz
 xcdsQG3AYAS6y7sTLwICQMCPsQ78RtBuQrLMKiv75Kjd+cBbifrEUmS8TsG0wiVXfrrA
 ADVCTeoRMR/Rp7cR9Y1ZMHSkC/xsCz8BMX2fbphAO0yF8h60NlHR/shzrTguWG7SKA4O
 gUpfCcWo/gv43qYI2n2Wa3SSFXmzt3YrTUSFvqsdVTLzeuezQMqMHiZohS0skaxAFGt3
 24oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g4xV3+UtU/EN3nIAWY0AUY+wJqcl4FqCGvroZVQR66s=;
 b=L2UPnhS2aC9lSX/InpKB85yOylWrNP6vDhESEQsITTvQg64rkvrrvsVqGzVfs6eh0l
 qdZ5MX2WpqbL2gS7SkcD/Wt3cZTHOB6+uq7NLiHF5WWj+t2zCAKkI3nfp/pNrFjOq1GW
 cGTlfFgSdFlGfpEgL+4tbNn4fbFPq750lS3dbm8a1v3Zrb4Q946eth95hcDW7Z6j+WYT
 F6WKlw1HpXmbIr6dydZSMKmTWhqKwNk6xr5ydK9RPSIETNyJ2AUi43BgHNDT53Map9pS
 2knReBPMc/HHcJxQgrrKYeUq4OvP/cQ32SajEPUFnT2te6PAIVZjx8shi7uD9/EayZY1
 y26g==
X-Gm-Message-State: AOAM531f+hG9LDL3XUdjR9UBmMOmxrbnGuCXyDxe876+qGFDxL/YjrN2
 skLx6jAD5J+7WHi0RbOS5zvzFg==
X-Google-Smtp-Source: ABdhPJy6yHYq/mSLg2i2q9xLMHODCavCwOBqacRJFVBN14In1kUg63gGt0WvQnXiRVpaBILRjrh5jQ==
X-Received: by 2002:a62:80c1:: with SMTP id j184mr4102784pfd.290.1598732721922; 
 Sat, 29 Aug 2020 13:25:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q2sm3378994pgs.90.2020.08.29.13.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:25:21 -0700 (PDT)
Subject: Re: [RFC v4 50/70] target/riscv: rvv-1.0: floating-point compare
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-51-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2dabec5-e3d7-5e0a-dd98-148009f6acc4@linaro.org>
Date: Sat, 29 Aug 2020 13:25:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-51-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/vector_helper.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

