Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A142DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E92E22277
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E92E22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsRA-0003p4-E3
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincenzo.frascino@arm.com>)
 id 1kQqFw-00038B-5Z; Fri, 09 Oct 2020 07:08:12 -0400
Received: from foss.arm.com ([217.140.110.172]:40800)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vincenzo.frascino@arm.com>)
 id 1kQqFu-0007ym-AK; Fri, 09 Oct 2020 07:08:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9411D6E;
 Fri,  9 Oct 2020 04:08:06 -0700 (PDT)
Received: from [10.37.12.22] (unknown [10.37.12.22])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50373F66B;
 Fri,  9 Oct 2020 04:08:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201008162155.161886-1-richard.henderson@linaro.org>
 <20201008162155.161886-4-richard.henderson@linaro.org>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d6829822-3e96-af18-1648-35ac25bd8287@arm.com>
Date: Fri, 9 Oct 2020 12:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008162155.161886-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=vincenzo.frascino@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 07:07:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Oct 2020 09:26:13 -0400
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/8/20 5:21 PM, Richard Henderson wrote:
> Unlike many other bits in HCR_EL2, the description for this
> bit does not contain the phrase "if ... this field behaves
> as 0 for all purposes other than", so do not squash the bit
> in arm_hcr_el2_eff.
> 
> Instead, replicate the E2H+TGE test in the two places that
> require it.
> 
> Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  target/arm/internals.h | 9 +++++----
>  target/arm/helper.c    | 9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index ae99725d2b..5460678756 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1252,10 +1252,11 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
>          && !(env->cp15.scr_el3 & SCR_ATA)) {
>          return false;
>      }
> -    if (el < 2
> -        && arm_feature(env, ARM_FEATURE_EL2)
> -        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
> -        return false;
> +    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
> +        uint64_t hcr = arm_hcr_el2_eff(env);
> +        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
> +            return false;
> +        }
>      }
>      sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
>      return sctlr != 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index cd0779ff5f..0620572e44 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6874,10 +6874,11 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      int el = arm_current_el(env);
>  
> -    if (el < 2 &&
> -        arm_feature(env, ARM_FEATURE_EL2) &&
> -        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
> -        return CP_ACCESS_TRAP_EL2;
> +    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
> +        uint64_t hcr = arm_hcr_el2_eff(env);
> +        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
>      }
>      if (el < 3 &&
>          arm_feature(env, ARM_FEATURE_EL3) &&
> 

-- 
Regards,
Vincenzo

