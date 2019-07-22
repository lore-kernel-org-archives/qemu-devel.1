Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A2C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0A4214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykDWpK7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0A4214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaF2-00034M-Dm
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpaEl-0002Kn-OI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpaEk-0000lE-9x
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:28:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpaEk-0000kr-28
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:28:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id y4so39905841wrm.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LrmUOHDKKSOh9oFYZU6EKSBnawPm0ki4mwkVcYgHjSA=;
 b=ykDWpK7WudMTnUeuI7BI51pDqCc2QRy9iwck60IwJC0JXmBkmbGPpmZR/2v0cCZ2bB
 /Ei4N8+fXcFNR4DndP+sG/x14qo2+s4rQUgVMbKMYirYcoQUYRyP64JXywTOqQKg8K6I
 4gpRovv3Ew8ulzTdjkKlv5qF9RTsb47KY6T0oRXyUBpTXH+/p6N+Fybq9K6Srf8ieNt4
 CGYrSPyEeFK+0fGb05gzCqp8uQvkwWaSjkcLFIvsMl3esT6uWyavb3oQc2K9cgaFLBvB
 HdmJKcUr+QOZh82Nm3bT5pMaM+OlkfQ10s1s8cdtu503DyObkPhyKw5yEljwQDVTTc0p
 Gu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LrmUOHDKKSOh9oFYZU6EKSBnawPm0ki4mwkVcYgHjSA=;
 b=I7SyHkqfgX86qmkKoNT1yPWSibWLhxNU352sNoNYFognSwqk+6eM5aUBjp2x+gMUPl
 40h9aRNIbpIO9lnlKDOj6nZxKAgEeS5eg3y+5kFAcZA32590ZaF98xgurIw9QlOZQ55R
 sEM4ensMSIcxEpzL9X9A7Bwa/cCVmcTnkSD69FdiGNR2uWM+DibFuw+/ZhCeNzFepU4M
 i5pzs7Gd004ZrmLQjffKzeFUFsJctq7XnHQdctZ/04yMOcIWs5HxFv+Fa5GOZ7Qto8LT
 GqPnfs3xjHhQqqRt0G15Te0rs/BK5HEtDmTbbD6H/tqD4BI/qg6S7Vz4FeckJIxNLFj2
 xwHA==
X-Gm-Message-State: APjAAAXyNLeYwpptv2kcbsTEaZOYErtzLtIeaRlr/olkqG2ck4FdDG4j
 AmkWwheotv9xxErSpj9xCyw3Zg==
X-Google-Smtp-Source: APXvYqyyQwJY6Jjq/FviB/rlZwqmG6h9woOlUfMgQ2QYFIsjCgLv5gMYtVuaiFayNGQzN0cxjC17VQ==
X-Received: by 2002:adf:f08f:: with SMTP id n15mr36487478wro.213.1563809304275; 
 Mon, 22 Jul 2019 08:28:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u1sm37949682wml.14.2019.07.22.08.28.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 08:28:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 034101FF87;
 Mon, 22 Jul 2019 16:28:23 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-4-richard.henderson@linaro.org>
Date: Mon, 22 Jul 2019 16:28:22 +0100
Message-ID: <87o91mjdgp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.2 03/24] target/arm: Install ASIDs
 for long-form from EL1
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

> In addition to providing the core with the current ASID, this minimizes
> both the number of flushes due to non-changing ASID as well as the set
> of mmu_idx that are affected by each flush.
>
> In particular, updates to the secure mode registers flushes only the
> relevant secure mode mmu_idx's, and similarly non-secure updates only
> affect non-secure mmu_idx's.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 73 +++++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 20f8728be1..0f21a077de 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3327,6 +3327,36 @@ static const ARMCPRegInfo pmsav5_cp_reginfo[] =3D {
>      REGINFO_SENTINEL
>  };
>
> +/* Called after a change to any of TTBR*_EL1 or TTBCR_EL1.  */
> +static void update_lpae_el1_asid(CPUARMState *env, int secure)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    uint64_t ttbr0, ttbr1, ttcr;
> +    int asid, idxmask;
> +
> +    switch (secure) {
> +    case ARM_CP_SECSTATE_S:
> +        ttbr0 =3D env->cp15.ttbr0_s;
> +        ttbr1 =3D env->cp15.ttbr1_s;
> +        ttcr =3D env->cp15.tcr_el[3].raw_tcr;
> +        /* Note that cp15.ttbr0_s =3D=3D cp15.ttbr0_el[3], so S1E3 is af=
fected.  */
> +        /* ??? Secure EL3 really using the ASID field?  Doesn't make sen=
se.  */
> +        idxmask =3D ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0 | ARMMMUIdxB=
it_S1E3;
> +        break;
> +    case ARM_CP_SECSTATE_NS:
> +        ttbr0 =3D env->cp15.ttbr0_ns;
> +        ttbr1 =3D env->cp15.ttbr1_ns;
> +        ttcr =3D env->cp15.tcr_el[1].raw_tcr;
> +        idxmask =3D ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    asid =3D extract64(ttcr & TTBCR_A1 ? ttbr1 : ttbr0, 48, 16);
> +
> +    tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
> +}
> +
>  static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *r=
i,
>                                   uint64_t value)
>  {
> @@ -3363,18 +3393,16 @@ static void vmsa_ttbcr_raw_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
>  static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    ARMCPU *cpu =3D env_archcpu(env);
>      TCR *tcr =3D raw_ptr(env, ri);
>
> -    if (arm_feature(env, ARM_FEATURE_LPAE)) {
> -        /* With LPAE the TTBCR could result in a change of ASID
> -         * via the TTBCR.A1 bit, so do a TLB flush.
> -         */
> -        tlb_flush(CPU(cpu));
> -    }
>      /* Preserve the high half of TCR_EL1, set via TTBCR2.  */
>      value =3D deposit64(tcr->raw_tcr, 0, 32, value);
>      vmsa_ttbcr_raw_write(env, ri, value);
> +
> +    if (arm_feature(env, ARM_FEATURE_LPAE)) {
> +        /* The A1 bit controls which ASID is active.  */
> +        update_lpae_el1_asid(env, ri->secure);
> +    }
>  }
>
>  static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> @@ -3392,24 +3420,19 @@ static void vmsa_ttbcr_reset(CPUARMState *env, co=
nst ARMCPRegInfo *ri)
>  static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                 uint64_t value)
>  {
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    TCR *tcr =3D raw_ptr(env, ri);
> -
> -    /* For AArch64 the A1 bit could result in a change of ASID, so TLB f=
lush. */
> -    tlb_flush(CPU(cpu));
> -    tcr->raw_tcr =3D value;
> +    raw_write(env, ri, value);
> +    /* The A1 bit controls which ASID is active.  */
> +    update_lpae_el1_asid(env, ri->secure);
>  }
>
> -static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> -                            uint64_t value)
> +static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                uint64_t value)

Why the rename here? It would make sense if it was only EL1 writes but
the lpae_cp_reginfo doesn't seem to use that nomclature (unless we
should fix .name for those as well?).

>  {
> -    /* If the ASID changes (with a 64-bit write), we must flush the TLB.=
  */
> -    if (cpreg_field_is_64bit(ri) &&
> -        extract64(raw_read(env, ri) ^ value, 48, 16) !=3D 0) {
> -        ARMCPU *cpu =3D env_archcpu(env);
> -        tlb_flush(CPU(cpu));
> -    }
>      raw_write(env, ri, value);
> +    if (cpreg_field_is_64bit(ri)) {
> +        /* The LPAE format (64-bit write) contains an ASID field.  */
> +        update_lpae_el1_asid(env, ri->secure);
> +    }
>  }
>
>  static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3455,12 +3478,12 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] =3D {
>        .fieldoffset =3D offsetof(CPUARMState, cp15.esr_el[1]), .resetvalu=
e =3D 0, },
>      { .name =3D "TTBR0_EL1", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 0, .crn =3D 2, .crm =3D 0, .opc2 =3D 0,
> -      .access =3D PL1_RW, .writefn =3D vmsa_ttbr_write, .resetvalue =3D =
0,
> +      .access =3D PL1_RW, .writefn =3D vmsa_ttbr_el1_write, .resetvalue =
=3D 0,
>        .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.ttbr0_s),
>                               offsetof(CPUARMState, cp15.ttbr0_ns) } },
>      { .name =3D "TTBR1_EL1", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 0, .crn =3D 2, .crm =3D 0, .opc2 =3D 1,
> -      .access =3D PL1_RW, .writefn =3D vmsa_ttbr_write, .resetvalue =3D =
0,
> +      .access =3D PL1_RW, .writefn =3D vmsa_ttbr_el1_write, .resetvalue =
=3D 0,
>        .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.ttbr1_s),
>                               offsetof(CPUARMState, cp15.ttbr1_ns) } },
>      { .name =3D "TCR_EL1", .state =3D ARM_CP_STATE_AA64,
> @@ -3715,12 +3738,12 @@ static const ARMCPRegInfo lpae_cp_reginfo[] =3D {
>        .access =3D PL1_RW, .type =3D ARM_CP_64BIT | ARM_CP_ALIAS,
>        .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.ttbr0_s),
>                               offsetof(CPUARMState, cp15.ttbr0_ns) },
> -      .writefn =3D vmsa_ttbr_write, },
> +      .writefn =3D vmsa_ttbr_el1_write, },
>      { .name =3D "TTBR1", .cp =3D 15, .crm =3D 2, .opc1 =3D 1,
>        .access =3D PL1_RW, .type =3D ARM_CP_64BIT | ARM_CP_ALIAS,
>        .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.ttbr1_s),
>                               offsetof(CPUARMState, cp15.ttbr1_ns) },
> -      .writefn =3D vmsa_ttbr_write, },
> +      .writefn =3D vmsa_ttbr_el1_write, },
>      REGINFO_SENTINEL
>  };

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

