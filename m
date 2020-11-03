Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60987C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32782076E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcQyb3iF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32782076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka17R-0001En-Rz
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 13:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka16c-0000gg-6d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:32:30 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka16Z-0007HP-QB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 13:32:29 -0500
Received: by mail-pf1-x443.google.com with SMTP id x13so14988967pfa.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WyI+wdpZSvkibXURhsE4UtunQSLgk/mfEDbq38QxQDk=;
 b=KcQyb3iFTdQ05J0LDLh3583K+jexl8NrWpv6TrYdDb9+cQhIh5ONglbtjQSXG9Spsa
 m9i5N2FoSWxVFxIbnUOoOGlnQPkuEfMWpIReIG2cmkdIDnDz5IQcTKD7xHf8ZwCSOQnf
 0/Xo9xLKSs5pWzBw8sWjXHgPBfENyh1hpx+9uCKocOg4ZNHUcXe6inPLNlEa0Cp4giCq
 Y5dBdSc1m1Y1tFTlEuQuoHEFpr2GswAhuSmJ2jAHU8j0STrJPUurGntavlZ2LFly/aAk
 /K/Lto2vqErLQJvpPltclFEINbeYJWGTfOraaTe9h0nCc/znoq4DYxCeNruXF8NSaI1U
 C4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WyI+wdpZSvkibXURhsE4UtunQSLgk/mfEDbq38QxQDk=;
 b=Q3d7C8HpPXBSUOyXrTfll/qyP0xNicOwdHV3QHrjhTWGHJKCpbSBl8sYyaKGbqZGtS
 +MKi1kWY4fJsiyIfM2TyiGWwsq/GpCFeSzI76zegaQVEvS1TJIHcNs9Mwx8JNZU+iVUq
 TYyHDHJB1coWAVZY7dr7COm4dEBDof8oCPDe5C33ZD5qeFl1Qnljqp4P6geDDqQ/FRNu
 b9YPY1crsZhpoQ0JvpAYgw+P/0SLreeuJs8y7ZAOMHmdleT/vJC+xr50oAyYL49teEHJ
 F92tGddtU2eDX2SBNm7VJJJ2wlFa2BYSKWw3HSsTptVMKHvb5z+LWBJl+WDwQszqebJo
 Wv9w==
X-Gm-Message-State: AOAM530iFNpO72kMTUxThNWi8hG5rFrNeEp2c+CCGnpI3iY/xx/sJ2LB
 zA2oz+Quoh7rz/cJuWuq0KK4nDtxLV34gA==
X-Google-Smtp-Source: ABdhPJzj0rKZxImQjPfRd+1EgbDxAytTGYFXfy1W3O4I0m7gVvyZiXgaOW5C93OKLhpint40P4X7GQ==
X-Received: by 2002:a17:90a:468b:: with SMTP id
 z11mr468720pjf.157.1604428345363; 
 Tue, 03 Nov 2020 10:32:25 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id v24sm15882848pgi.91.2020.11.03.10.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 10:32:24 -0800 (PST)
Subject: Re: [PATCH 08/14] target/arm: add MMU stage 1 for Secure EL2
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-8-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1bca2e0-d926-02cb-c462-5e9d64a51999@linaro.org>
Date: Tue, 3 Nov 2020 10:32:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-8-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This adds the MMU indices for EL2 stage 1 in secure mode.
> 
> To keep code contained, which is largelly identical between secure and
> non-secure modes, this patch introduces a secure bit for all new and
> existing stage 1 translation regimes.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu-param.h     |   2 +-
>  target/arm/cpu.h           |  22 ++++--
>  target/arm/helper.c        | 143 ++++++++++++++++++++++++-------------
>  target/arm/internals.h     |  12 ++++
>  target/arm/translate-a64.c |   4 ++
>  5 files changed, 127 insertions(+), 56 deletions(-)
> 
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index 6321385b46..0db5e37c17 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -29,6 +29,6 @@
>  # define TARGET_PAGE_BITS_MIN  10
>  #endif
>  
> -#define NB_MMU_MODES 11
> +#define NB_MMU_MODES 16
>  
>  #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 724b11ee57..3fbb70e273 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2944,6 +2944,9 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
>  #define ARM_MMU_IDX_NOTLB 0x20  /* does not have a TLB */
>  #define ARM_MMU_IDX_M     0x40  /* M profile */
>  
> +/* Meanings of the bits for A profile mmu idx values */
> +#define ARM_MMU_IDX_A_S      0x8
> +
>  /* Meanings of the bits for M profile mmu idx values */
>  #define ARM_MMU_IDX_M_PRIV   0x1
>  #define ARM_MMU_IDX_M_NEGPRI 0x2
> @@ -2967,10 +2970,17 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_E20_2      =  5 | ARM_MMU_IDX_A,
>      ARMMMUIdx_E20_2_PAN  =  6 | ARM_MMU_IDX_A,
>  
> -    ARMMMUIdx_SE10_0     = 7 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE10_1     = 8 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE10_1_PAN = 9 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_SE3        = 10 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_SE10_0     = ARMMMUIdx_E10_0 | ARM_MMU_IDX_A_S,
> +    ARMMMUIdx_SE20_0     = ARMMMUIdx_E20_0 | ARM_MMU_IDX_A_S,
> +
> +    ARMMMUIdx_SE10_1     = ARMMMUIdx_E10_1 | ARM_MMU_IDX_A_S,
> +    ARMMMUIdx_SE10_1_PAN = ARMMMUIdx_E10_1_PAN | ARM_MMU_IDX_A_S,
> +
> +    ARMMMUIdx_SE2        = ARMMMUIdx_E2 | ARM_MMU_IDX_A_S,
> +    ARMMMUIdx_SE20_2     = ARMMMUIdx_E20_2 | ARM_MMU_IDX_A_S,
> +    ARMMMUIdx_SE20_2_PAN = ARMMMUIdx_E20_2_PAN | ARM_MMU_IDX_A_S,
> +
> +    ARMMMUIdx_SE3        = 15 | ARM_MMU_IDX_A,

Hum.  So, we're adding 4 new mmu_idx, and increasing the mmu_idx count by 5.
The unused index would be 7 -- no non-secure el3.

Is it worth reversing the S bit to NS, so that index 15 becomes the one that is
unused, and so we don't actually have to add it to NB_MMU_MODES?

> @@ -3649,7 +3655,7 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
>                                       bool isread)
>  {
> -    if (arm_current_el(env) == 3 && !(env->cp15.scr_el3 & SCR_NS)) {
> +    if (arm_current_el(env) == 3 && !(env->cp15.scr_el3 & (SCR_NS|SCR_EEL2))) {

This seems to belong to a different patch?

> +        if (arm_is_secure_below_el3(env))
> +            mask <<= ARM_MMU_IDX_A_S;

Braces.

>      if (raw_read(env, ri) != value) {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_E10_1 |
> -                            ARMMMUIdxBit_E10_1_PAN |
> -                            ARMMMUIdxBit_E10_0);
> +        uint16_t mask = ARMMMUIdxBit_E10_1 |
> +                        ARMMMUIdxBit_E10_1_PAN |
> +                        ARMMMUIdxBit_E10_0;
> +
> +        if (arm_is_secure_below_el3(env))
> +            mask <<= ARM_MMU_IDX_A_S;

Again.  This appears to be an existing bug with SEL1?  Perhaps it should be
split to a separate patch.

>      if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
> -        return ARMMMUIdxBit_E20_2 |
> +        mask = ARMMMUIdxBit_E20_2 |
>                 ARMMMUIdxBit_E20_2_PAN |
>                 ARMMMUIdxBit_E20_0;
> -    } else if (arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdxBit_SE10_1 |
> -               ARMMMUIdxBit_SE10_1_PAN |
> -               ARMMMUIdxBit_SE10_0;
>      } else {
> -        return ARMMMUIdxBit_E10_1 |
> +        mask = ARMMMUIdxBit_E10_1 |
>                 ARMMMUIdxBit_E10_1_PAN |
>                 ARMMMUIdxBit_E10_0;
>      }
> +
> +    if (arm_is_secure_below_el3(env)) {
> +        mask <<= ARM_MMU_IDX_A_S;
> +    }

Likewise.

The rest of the patch looks mechanically correct.


r~

