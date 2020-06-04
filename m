Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEF82067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+jxCyqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEF82067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwHW-0001gl-4W
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwGo-000179-Ah
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:15:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwGn-0003XQ-CG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:15:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id h95so1712971pje.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EzVWYtTp9/kLezmxudd6UyLUAdlaUG23E721xpMSfLk=;
 b=P+jxCyqW3THOxDiBPxJkLGpHt8xSUO7oxg2fGk6Ij4o6smo8PeQeqMNPDeCFCfO9Mx
 1la2HyT2uAaH9b4ZwsuRmgsIJP1gz+/gjmRHNp2nAOra3mlELykXW/ZAhL4TrOEiDpUe
 DcgkBgXhJ9FH+JRxamJ06ixRmrBNq99PxD5MW8pYb1jLBzFYGWVjX2PGPQXJEgmJesNG
 uvsgDNfxBa1DIh8XA1ncJHxtbaQaYJgTrfxIJZTUII/Ynv3P1f/LfOyeB0AMANWklZ3L
 UIaMTyaAMxzxShuuTeUagpzwp6ATG1wVC8OcMU2LjUfj8jIkCy+XCWlTlfo3Q1nymBSj
 kq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EzVWYtTp9/kLezmxudd6UyLUAdlaUG23E721xpMSfLk=;
 b=f0ldoL1jXZScKUN+uqulIF6mCoWKe1uSmHwdNP1ukZJNWeIhRNtvaMLVX1FsoWYTdF
 Uqbmc6G+G/eaUOvCT9dc0C5q78pC4h/LoEYULJa2SV/afY1V1gfBhR4bPN40p/Qekj4m
 ORrBnqSLb046tfpxmluQ9gFLNHmFcoANDkn1KFNjvNhTwmVSngy8Bdj77MP0nHwox8Yn
 5z3t31ZQg7d78N/O+thzY9IrWPkWjrESlo1lB7dJnUJxEs2O87T3efnaM02cIaTQMo8h
 6P23eEFy7tYuOE6DQATG11YukS8t5T0mDWQXAsW+8wvQQ/PmGf7NM3HJ3KKpk/0pRksu
 +alA==
X-Gm-Message-State: AOAM530Jttq4PpE3xMtOvWgncIGq1uREWwEs2MC7VvzsW8Uqu3L2lFte
 MlTy0tRli6upr5GrHe27ls0oIw==
X-Google-Smtp-Source: ABdhPJwex7baaKudfm65MvuCl2P3LSdNpzZo61HBqCeIhBlgRCLZztOtNbFG1z9l9/77e6YH46M0sA==
X-Received: by 2002:a17:902:b78a:: with SMTP id
 e10mr6371924pls.201.1591301719607; 
 Thu, 04 Jun 2020 13:15:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l23sm4643875pgc.55.2020.06.04.13.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 13:15:18 -0700 (PDT)
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
 <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
 <ca1e71cd-c290-5fb9-e9bf-026c73e06560@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ec3d397-bf9a-07f5-3014-4acf47a4fd6e@linaro.org>
Date: Thu, 4 Jun 2020 13:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ca1e71cd-c290-5fb9-e9bf-026c73e06560@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

On 6/2/20 10:46 PM, LIU Zhiwei wrote:
> I think you are right.  Maybe I should transmit frm to ctx->frm, and check
> ctx->frm in vector fp ops.
> 
> We can set ctx->frm = env->frm instead of ctx->frm = -1 in
> riscv_tr_init_disas_context.
> And  remove the sentence ctx->frm = rm; from gen_set_rm.
> 
> Is it right?

If we record frm in tb_flags, then we also have to reset
env->fp_status.rounding_mode for scalar fp insns which encode a rm != 7.
Depending on the exact mix of fp insns, that could result in more changes to
rounding_mode than we do presently.  This is something that you'd want to look
at closely to make sure you're not making scalar code worse.

I think the easiest solution in the short term is to have the translation of
any fp vector insn call gen_set_rm(ctx, 7), so that we are certain to install
frm as rounding_mode.  This will happen at most once per translation block,
assuming no scalar insns that would also require changes to rounding_mode.

You can work with the risc-v folk to examine frm handling more generally
separate from this vector work.


r~

