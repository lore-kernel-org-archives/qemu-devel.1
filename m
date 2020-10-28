Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB51C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F5E247C3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7O0G0RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F5E247C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnLB-0001vY-K8
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnHZ-0005RD-Mn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:22:39 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnHX-0006of-F2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:22:37 -0400
Received: by mail-pj1-x1041.google.com with SMTP id az3so2711653pjb.4
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tRIDLUSNGtzNRczBIMOLPFujWfWDdVx3YveTpcJNWtM=;
 b=k7O0G0RA7AqV94Hsj0RGZLrOkr4At7CjF9r+g92yXDlTNkZluUfKrfF4vWRldNlQi3
 sxmUEko6X5/RmhnTIisgswF1j0ipRPg7KRt+2DFeTxytUJX/8c1T0X+i2vMFaYcJ/yvE
 Wz76NwcHMse+23GTsnaQk13iprrN/9wBmvtoQaFd8JBN+VFbeUnfVCyw/XKxMvagFPY2
 jsR+RzjPIspsvN4ULsDJOEMX3V0MPCxbRfewvlkqBR8xMCMbXV7EPLzXLVQ2/dtWNsvU
 Z8P7eO4v/77KU5VHHxanWkv8Rvinjk8Dw2FzNm3eF7kB4R9UqPxEIiogx6Zr85w73btB
 58Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tRIDLUSNGtzNRczBIMOLPFujWfWDdVx3YveTpcJNWtM=;
 b=DBHxPNnE3HAjkmZ6FnUCCQehNTGGXg/xq9dpuyoLvMsPEIEmQ4ysg7lLRQt84Ty7/D
 X0flyZqfQxcog9gMUGLOAFdcsqcHERMEc2RxNstSGuFNyR1e/0WkQ3ZpdtSpS6bEphcS
 q4SzHIAqnzKJmAIiM24hm/FTTl5pUdTWnuz7y2iuwx/tBQaFeTYFqaGUh/OJmZlJaqCX
 3Z3Hk/zqQ7ughkQRn1jQr8Jc7InjUwEseFry7AoeA4j2z1eiRUD5bKbDIGyvQYSCyvJh
 Q+PCjvXGiS5z5Ra8ELIG3zXDc2PjjUj+T9AUNJRrSPiMSzFLfRHJOp6IAEOAe0JyVoQc
 qRVw==
X-Gm-Message-State: AOAM533mfibGYjiXnSy2+rqgGBdDYFYiiFOi2VBMZYnddbSB3KHpQ1lD
 puianQ3IYnSWQv9oXom6O6vgjQ==
X-Google-Smtp-Source: ABdhPJyO5/l8nv6NTA272Ev3cLxUsAufqrjF4MeoWRLMNOYgOaaQ3xxwcA2UDEPGzlhtKajVNXCbKw==
X-Received: by 2002:a17:90a:4684:: with SMTP id
 z4mr7132020pjf.97.1603898552258; 
 Wed, 28 Oct 2020 08:22:32 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm6263037pfc.63.2020.10.28.08.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:22:31 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] target/riscv: Split the Hypervisor execute load
 helpers
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1603896075.git.alistair.francis@wdc.com>
 <a88d9bdcebe49ada0d0a69b37ac532124971c91c.1603896076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66b758d2-395f-142c-aa66-ba197c926364@linaro.org>
Date: Wed, 28 Oct 2020 08:22:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a88d9bdcebe49ada0d0a69b37ac532124971c91c.1603896076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 7:42 AM, Alistair Francis wrote:
> +target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong address)
>  {
>      if (env->priv == PRV_M ||
>          (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
>          (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
>              get_field(env->hstatus, HSTATUS_HU))) {
> +        int mmu_idx = cpu_mmu_index(env, true) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
> +
> +        return cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
> +    }
> +
> +    if (riscv_cpu_virt_enabled(env)) {
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
> +    } else {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +    return 0;
> +}
> +
> +target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong address)
> +{
> +    if (env->priv == PRV_M ||
> +        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
> +        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
> +            get_field(env->hstatus, HSTATUS_HU))) {
> +        int mmu_idx = cpu_mmu_index(env, true) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
>  
> +        return cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
>      }

Do not replicate the PRV tests.

My first suggestion is to compute this into TBFLAGS and test it at translate
time, so that these functions just become the one cpu_ld* call.

But failing that, at least split out the test + exception into a common helper
function.

r~

