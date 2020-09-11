Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B7D21D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVUJDjbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B7D21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGowh-0002Ai-Vs
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGouF-0006ay-2P
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:40:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGouD-0001ak-EP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:40:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id y1so1042264pgk.8
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=fzsN2kmp759BPhrivZCf0ftkqqjeCNXbrECqPg8QK3A=;
 b=nVUJDjbYmKKhvCJuBkUTEPJbTeWY9Sp9fSkEhU30G87x92A9Dpb+hURHjdAqqAsq+e
 cLdnz5RwrTIaX7mDrftfaibNYeWB37PJHlODHUyp+GbgmHF4R64pLJVr8PMT/TL9/7WO
 QfgScagcR5FswXXijnBOsgeRBVN0trbURZaxuAdpULJfOAAuTGDVzsKF0ZUT0+71y1gK
 8A/b8TUhjmIM2avIksEl8CHjGa1DCA+wEnanULYNSrHC9ktnDNqsMWR4oWJUeqBJPwjd
 nJr0VkrDeLjrScYmUXrSUHuKu1daUyFosLK2p36hreAS13Lry0diNjsn9Gr5hZxKAd9B
 ivQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fzsN2kmp759BPhrivZCf0ftkqqjeCNXbrECqPg8QK3A=;
 b=gut0brP8i4jkR4/TZhTFaKo1kg4Iim0i09k9OyPyBHKzjp+ItNi88uXkHuBDr+Jljn
 9gHw0p3XQVmqdtYzMtyU8M3wRzZc+31Let6Y4fOagbmoKd9KyVQPTlxnXfEA3x2E/tqF
 ggjT4++gyLbx5fzZIXQecj/Cxefe2DZhRSKkq7q5neE+AnVDCb/ZThIH4AQt7l0uXYnT
 q1sgDDQkZupp/laUI4VDv5U+uT4o07ci7XFTo87ZOqd/pUVhfvDcrZNHTbr2uTN1F0BD
 tlNuEwC7AQsjwfjjmPbgcAjW1DUb0tWG9qr0Ukkx3jmmfCyMyGzexYxUGZQvMuAIZJtD
 zf5Q==
X-Gm-Message-State: AOAM530/wdFsf+idh/F+5WT9fuyNRNbdZCPiGHYpLYhImZfvMgV2JhSC
 sHjnlOkUWov6zB5ecBTC8aNPJnS/LvVB2Q==
X-Google-Smtp-Source: ABdhPJzyB0pDHanPZre0eYqbgqwCb9XTFMw7j33lS3U4YomYviV+RdbQvb/KJgm0YSTwnbphBXPtXA==
X-Received: by 2002:a62:8f4a:: with SMTP id n71mr3605478pfd.141.1599853219124; 
 Fri, 11 Sep 2020 12:40:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gi20sm2611596pjb.28.2020.09.11.12.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:40:18 -0700 (PDT)
Subject: Re: [PATCH 0/5] handle M-profile in fp16_arith isar_feature test
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200910173855.4068-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df87b4ec-2091-6d1f-9f5e-3f3617f7cf92@linaro.org>
Date: Fri, 11 Sep 2020 12:40:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910173855.4068-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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

On 9/10/20 10:38 AM, Peter Maydell wrote:
> This series leaves us with two different ways to check for "is this
> M-profile?" -- the old ARM_FEATURE_M bit, and also the new
> isar_feature_aa32_mprofile() test.  We could in theory convert the
> users of ARM_FEATURE_M, but I haven't, because there are a lot of
> callsites, and it can't be done automatically:
> 
>  * arm_feature() takes the CPUARMState* whereas cpu_isar_feature()
>    takes the ARMCPU*, so each callsite needs manual attention to
>    identify whether it already has a 'cpu' local variable and
>    add one if it doesn't
>  * awkwardly, the KVM-on-AArch64-only host case does not zero
>    out these ID register fields (see the comment in kvm64.c
>    kvm_arm_get_host_cpu_features()), so calling the
>    isar_feature function is only valid if we already know that
>    this CPU is AArch32 -- this would need manually checking
>    at all callsites. (Unless we wanted to change our minds about
>    leaving UNKNOWN values in the ID register fields.)

That is why I had suggested moving env->features to cpu->isar.features, so that
it would be nearby.

Which would give us

static inline bool isar_feature(const ARMISARegisters *id,
                                int feature)
{
    return extract64(id->features, feature, 1);
}

static inline bool arm_feature(CPUARMState *env, int feature)
{
    return isar_feature(&env_archcpu(env)->isar, feature);
}

But what you have at present solves the current problem, where we know we're in
aa32 mode in translate.c.


r~

