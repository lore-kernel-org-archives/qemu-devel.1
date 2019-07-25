Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5714C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82521217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2UacVA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82521217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeKZ-0003WG-Og
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqeKO-00035X-0V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqeKM-0000Zt-MX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:02:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqeKM-0000Yx-F1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:02:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so50882748wrt.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xSDgG0s7XnWZGyacS82hd548+Kl0PWqfw0mCiRLZT4Y=;
 b=s2UacVA4plzlCOi/okmf2SlUFv/vDyOosEU8TdZjVTYQ5FubFHmxS3xxjJOFfmJ5uy
 JPFisc49YnDnauXVGBqHRMkOMpUSA91FUWbbPEQM95Id3X6G+QmsfFXJDr82DiWxhrst
 FcQXZK4YaO0vDJsue2JHOYkUpO8nLem8RmUfICqxZo2vEQjK37VCPo7AJgz1Am8nOuGh
 oqOZM60UgnFV/tyH7g+bvEJ0OYfhC+K1KQIV5XSVia0pTq1t7X/wK1CbCtXxrc4xKLwl
 KmJJfqn46XOIuwMTsPINuK69TLG0wAAAALCqbgBP/+TMmbv0RjQHF0Jn3j1yxrdAHKnc
 LbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xSDgG0s7XnWZGyacS82hd548+Kl0PWqfw0mCiRLZT4Y=;
 b=Qhwpbtxs/8WaTt7t1MDLd7PdFlumDwhEfJHMVLWoccBWuGWw6nfNAAhJV0whIAAw6V
 QhXx5tDLrMulXVPYfgNk4FOS1vlzW7+i4J03yzYCGyiriVV4uwdAlVWlaPWaP9eouBMe
 hm3t4Mo+8EscTV7bwOycHkppLOmDYnHd8fdhokke9dPnGiQT71tEWl2/j8xKYfh6b583
 uyt/1113Nx/MdF6TwHy8Dfegbs8z3VhoJoFMUkFq2Po7CPKpzRaQWmi9C0Z0MQHq6LNV
 hImnqJJhqj3BipSbODioFFYjje4YilRQiN0i0iMS3yNuD664u1oXpcLCblCmUaXG0lwm
 aCUw==
X-Gm-Message-State: APjAAAW8jergX2xEc26GYpBXqvW5E8qkeLb/40SyhRkin2J+VbaxGXzx
 Upo1PbeMbp2VM9mIKksG0VpI74QJmVk=
X-Google-Smtp-Source: APXvYqyv/wV2kUSF2A75nsMrqKtTsqkQB1XW+6yDF8A7oxJnkQ69zS0WH0hDR2YJtKyj2pdWB7+Lnw==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr13323783wrj.118.1564063357268; 
 Thu, 25 Jul 2019 07:02:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x129sm47661040wmg.44.2019.07.25.07.02.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:02:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5AE601FF87;
 Thu, 25 Jul 2019 15:02:36 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-14-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-14-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 15:02:36 +0100
Message-ID: <87zhl2yzyb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.2 13/24] target/arm: Split out
 vae1_tlbmask, vmalle1_tlbmask
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> No functional change, but unify code sequences.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 118 ++++++++++++++------------------------------
>  1 file changed, 37 insertions(+), 81 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9a9809ff4f..7adbf51479 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3901,70 +3901,61 @@ static CPAccessResult aa64_cacheop_access(CPUARMS=
tate *env,
>   * Page D4-1736 (DDI0487A.b)
>   */
>
> +static int vae1_tlbmask(CPUARMState *env)
> +{
> +    if (arm_is_secure_below_el3(env)) {
> +        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +    } else {
> +        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +    }
> +}
> +
>  static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegIn=
fo *ri,
>                                        uint64_t value)
>  {
>      CPUState *cs =3D env_cpu(env);
> -    bool sec =3D arm_is_secure_below_el3(env);
> +    int mask =3D vae1_tlbmask(env);
>
> -    if (sec) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S1SE1 |
> -                                            ARMMMUIdxBit_S1SE0);
> -    } else {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S12NSE1 |
> -                                            ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
>  }
>
>  static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
>                                      uint64_t value)
>  {
>      CPUState *cs =3D env_cpu(env);
> +    int mask =3D vae1_tlbmask(env);
>
>      if (tlb_force_broadcast(env)) {
>          tlbi_aa64_vmalle1is_write(env, NULL, value);
>          return;
>      }
>
> +    tlb_flush_by_mmuidx(cs, mask);
> +}
> +
> +static int vmalle1_tlbmask(CPUARMState *env)
> +{
> +    /*
> +     * Note that the 'ALL' scope must invalidate both stage 1 and
> +     * stage 2 translations, whereas most other scopes only invalidate
> +     * stage 1 translations.
> +     */
>      if (arm_is_secure_below_el3(env)) {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S1SE1 |
> -                            ARMMMUIdxBit_S1SE0);
> +        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +    } else if (arm_feature(env, ARM_FEATURE_EL2)) {
> +        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBi=
t_S2NS;
>      } else {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S12NSE1 |
> -                            ARMMMUIdxBit_S12NSE0);
> +        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
>      }
>  }
>
>  static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
>                                    uint64_t value)
>  {
> -    /* Note that the 'ALL' scope must invalidate both stage 1 and
> -     * stage 2 translations, whereas most other scopes only invalidate
> -     * stage 1 translations.
> -     */
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +    int mask =3D vmalle1_tlbmask(env);
>
> -    if (arm_is_secure_below_el3(env)) {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S1SE1 |
> -                            ARMMMUIdxBit_S1SE0);
> -    } else {
> -        if (arm_feature(env, ARM_FEATURE_EL2)) {
> -            tlb_flush_by_mmuidx(cs,
> -                                ARMMMUIdxBit_S12NSE1 |
> -                                ARMMMUIdxBit_S12NSE0 |
> -                                ARMMMUIdxBit_S2NS);
> -        } else {
> -            tlb_flush_by_mmuidx(cs,
> -                                ARMMMUIdxBit_S12NSE1 |
> -                                ARMMMUIdxBit_S12NSE0);
> -        }
> -    }
> +    tlb_flush_by_mmuidx(cs, mask);
>  }
>
>  static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> @@ -3988,28 +3979,10 @@ static void tlbi_aa64_alle3_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
>                                      uint64_t value)
>  {
> -    /* Note that the 'ALL' scope must invalidate both stage 1 and
> -     * stage 2 translations, whereas most other scopes only invalidate
> -     * stage 1 translations.
> -     */
>      CPUState *cs =3D env_cpu(env);
> -    bool sec =3D arm_is_secure_below_el3(env);
> -    bool has_el2 =3D arm_feature(env, ARM_FEATURE_EL2);
> +    int mask =3D vmalle1_tlbmask(env);
>
> -    if (sec) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S1SE1 |
> -                                            ARMMMUIdxBit_S1SE0);
> -    } else if (has_el2) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S12NSE1 |
> -                                            ARMMMUIdxBit_S12NSE0 |
> -                                            ARMMMUIdxBit_S2NS);
> -    } else {
> -          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                              ARMMMUIdxBit_S12NSE1 |
> -                                              ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
>  }
>
>  static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> @@ -4059,20 +4032,11 @@ static void tlbi_aa64_vae3_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
>                                     uint64_t value)
>  {
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> -    bool sec =3D arm_is_secure_below_el3(env);
> +    CPUState *cs =3D env_cpu(env);
> +    int mask =3D vae1_tlbmask(env);
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>
> -    if (sec) {
> -        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                 ARMMMUIdxBit_S1SE1 |
> -                                                 ARMMMUIdxBit_S1SE0);
> -    } else {
> -        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                 ARMMMUIdxBit_S12NSE1 |
> -                                                 ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
>  }
>
>  static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *r=
i,
> @@ -4083,8 +4047,8 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, =
const ARMCPRegInfo *ri,
>       * since we don't support flush-for-specific-ASID-only or
>       * flush-last-level-only.
>       */
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +    int mask =3D vae1_tlbmask(env);
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>
>      if (tlb_force_broadcast(env)) {
> @@ -4092,15 +4056,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env,=
 const ARMCPRegInfo *ri,
>          return;
>      }
>
> -    if (arm_is_secure_below_el3(env)) {
> -        tlb_flush_page_by_mmuidx(cs, pageaddr,
> -                                 ARMMMUIdxBit_S1SE1 |
> -                                 ARMMMUIdxBit_S1SE0);
> -    } else {
> -        tlb_flush_page_by_mmuidx(cs, pageaddr,
> -                                 ARMMMUIdxBit_S12NSE1 |
> -                                 ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
>  }
>
>  static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo =
*ri,


--
Alex Benn=C3=A9e

