Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C284C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D712238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmJ9jhMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D712238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgC2-0007zq-1H
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56023)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqgBn-0007aA-Mx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqgBm-0007tv-0C
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:01:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqgBl-0007it-Mx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:01:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so45474921wms.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/f5ZiVDdRQrgBwucRwJ+jDvhabFW06uhqBgW8Et8/sw=;
 b=hmJ9jhMGIM4PXVNAVrUVy215dmM8uvBfd6wnUz6epx5cY4gBbiaPffmDMviaE+iRtq
 UhjU3h+kPz3iJd0Z5Jv1kBYoEihnopi4G2gds1X3M6FIr2Beu1VW/U8lepKKUg9BGHs9
 Zjnj/5+FKuslBKNEaJHBuidlK/B4+b3zq4NQnpwpX2VWLdT2MNQsHAybohuilG5Ervjz
 Oaz8baeNDpvWxb/VneCPPIEyNaJFA+t+Ah0GOnwKkAuTE97VXgG7tjMgaUScfzgenWlW
 tmg1z71DkZhpsmSYMIaCcj2CJX5PbfzLrl2I2LK1I3Kcm6oMw5nWkllDQNaDyotzFWsf
 Gneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/f5ZiVDdRQrgBwucRwJ+jDvhabFW06uhqBgW8Et8/sw=;
 b=W7PwWySWb6aqFZ3CMZD6pf2/zLkDxIltUG43lO4nk8F4QLfFlazVRYbf6rnz2UMMFD
 r/9MnNuWvbFhLPNx1kjsSEWaS2jg6KA5bIjqFGtU6KT9tVw34JyIDNhgeQFC0KazknO3
 N5wFWv1MNKsRpGW1gD/oW9Kcx45m1orMG/r+5gmejOOkcTGREMcVw7zK3F7GeqObtXe2
 JBNJ/bErEDTSGYaHEAKvQOie4WIitFJ50zpDmTEe8K8ML2aUDkrdauIEC+IdrMFP39nO
 p4wjWC2HF54/dV/M3KoQeI2uj7XwimptdzUYPAHLDlMrWg+vLZgorkEujNXX+qMDZsI3
 4dvA==
X-Gm-Message-State: APjAAAUBTQvQlwem4iCYuleANQJE7X9kUT3N8GDCXabcDZgeVa9oP3fA
 7cMLwFio2ZAOEtGYMib5Vlhk4Q==
X-Google-Smtp-Source: APXvYqzfRS4ZEGG16mTzjGyeYadaMxCukb0JE9tkxwi//FPEgKpNY2K3k+5SC1eIDFlhpAB3zvCamg==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr2018884wmf.54.1564070489460; 
 Thu, 25 Jul 2019 09:01:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a6sm37303519wmj.15.2019.07.25.09.01.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 09:01:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 393921FF87;
 Thu, 25 Jul 2019 17:01:28 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-18-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-18-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 17:01:28 +0100
Message-ID: <87tvbayug7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.2 17/24] target/arm: Update
 arm_mmu_idx for VHE
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

> This covers initial generation in arm_mmu_idx, and reconstruction
> in core_to_arm_mmu_idx.  As a conseqeuence, we also need a bit in
> TBFLAGS in order to make the latter reliable.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h    |  2 ++
>  target/arm/helper.c | 42 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4b537c4613..7310adfd9b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3158,6 +3158,8 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
>  /* Target EL if we take a floating-point-disabled exception */
>  FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
>  FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
> +/* For A profile only, if EL2 is AA64 and HCR_EL2.E2H is set.  */
> +FIELD(TBFLAG_ANY, E2H, 22, 1)
>
>  /* Bit usage when in AArch32 state: */
>  FIELD(TBFLAG_A32, THUMB, 0, 1)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2d5658f9e3..54c328b844 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11250,21 +11250,29 @@ int fp_exception_el(CPUARMState *env, int cur_e=
l)
>
>  ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
>  {
> +    bool e2h;
> +
>      if (arm_feature(env, ARM_FEATURE_M)) {
>          return mmu_idx | ARM_MMU_IDX_M;
>      }
>
>      mmu_idx |=3D ARM_MMU_IDX_A;
> +    if (mmu_idx & ARM_MMU_IDX_S) {
> +        return mmu_idx;
> +    }
> +
> +    e2h =3D (env->cp15.hcr_el2 & HCR_E2H) !=3D 0;
> +    if (!arm_el_is_aa64(env, 2)) {
> +        e2h =3D false;
> +    }
> +
>      switch (mmu_idx) {
>      case ARMMMUIdx_E0:
> -        return ARMMMUIdx_EL10_0;
> +        return e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
>      case ARMMMUIdx_E1:
>          return ARMMMUIdx_EL10_1;
>      case ARMMMUIdx_E2:
> -    case ARMMMUIdx_SE0:
> -    case ARMMMUIdx_SE1:
> -    case ARMMMUIdx_SE3:
> -        return mmu_idx;
> +        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
>      default:
>          g_assert_not_reached();
>      }
> @@ -11292,24 +11300,28 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMSt=
ate *env, bool secstate)
>
>  ARMMMUIdx arm_mmu_idx(CPUARMState *env)
>  {
> +    bool e2h, sec;
>      int el;
>
>      if (arm_feature(env, ARM_FEATURE_M)) {
>          return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
>      }
>
> +    sec =3D arm_is_secure_below_el3(env);
> +    e2h =3D (env->cp15.hcr_el2 & HCR_E2H) !=3D 0;
> +    if (!arm_el_is_aa64(env, 2)) {
> +        e2h =3D false;
> +    }
> +
>      el =3D arm_current_el(env);
>      switch (el) {
>      case 0:
> -        /* TODO: ARMv8.1-VHE */
> +        return sec ? ARMMMUIdx_SE0 : e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_=
EL10_0;
>      case 1:
> -        return (arm_is_secure_below_el3(env)
> -                ? ARMMMUIdx_SE0 + el
> -                : ARMMMUIdx_EL10_0 + el);
> +        return sec ? ARMMMUIdx_SE1 : ARMMMUIdx_EL10_1;
>      case 2:
> -        /* TODO: ARMv8.1-VHE */
>          /* TODO: ARMv8.4-SecEL2 */
> -        return ARMMMUIdx_E2;
> +        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
>      case 3:
>          return ARMMMUIdx_SE3;
>      default:
> @@ -11421,6 +11433,14 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>
>      flags =3D FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(=
mmu_idx));
>
> +    /*
> +     * Include E2H in TBFLAGS so that core_to_arm_mmu_idx can
> +     * reliably determine E1&0 vs E2&0 regimes.
> +     */
> +    if (arm_el_is_aa64(env, 2) && (env->cp15.hcr_el2 & HCR_E2H)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, E2H, 1);
> +    }
> +
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:
>       *  SS_ACTIVE   PSTATE.SS   State


--
Alex Benn=C3=A9e

