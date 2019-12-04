Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A475620674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TT9aPidD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A475620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTdW-0000o7-OZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icSS3-0001kX-0M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icSRQ-0001mi-E5
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:03:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icSRP-0001LW-4U
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:03:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so8057731wru.4
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pwc3QMobccDwdNm8xCmy/wMKZrPphMnVyG5+uR8q5Jw=;
 b=TT9aPidDnyFYVSqv2jDd/SKTXruJfQgXtALd3MvvyRDhc9Ih9XivOxodp4/PfFRpyI
 oiyQK+mHATcFAuwjC9Xgaz+TCNb1TVfD4j5oVFn1MhI+SolLfZs/3UFemTD9MpY9O4/m
 y2FgYvULvHZ8IgRu80jNR2lmMeetYLbsakpYFdgyqyyCRHsnmpBJXunvLLFoImx8Bj3Y
 AZHqlI2Ej4bbAScWRrHCDWw9NHltP5RSoKR4+DEJBR0VdUrMUk+V6EoO2NGiebIOWjNb
 6qwAlIDqD4d/eC+U3YpNeWiifMxC9ntdIe4kA6t3GGVLuirqPb269FweQ04q1aQNQu1m
 klsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pwc3QMobccDwdNm8xCmy/wMKZrPphMnVyG5+uR8q5Jw=;
 b=TATjm3KBC8cmzHDHM654q3O/K1W9bm/wX5ttt4p7Pj69clwvhgzS5wx9xK5a6iK1tg
 ktscBeZW/gluAV7SEBozR1YYYr55G2YfGUusmqNe6KkeMJkYQfNzMggEOWg+3Jr8X89G
 ntwKC0fSWL/Dvyo1Oe5ruGklOoX8bYSmPP5FclwOxyTz5cPKUo86BUGJna67D4O08oIP
 u39bxgil0VDRpDc58eeUCLTF2xERCB/BdzYprjaokIJLr1evIOmZc6MWrL+DzfehjSQv
 Rx3vToFtftNdAHsCYJUNtE8OvV8BERi++g+LoioykWWfzi1GM2QOewe3rJWBQhmxH9Je
 PXsw==
X-Gm-Message-State: APjAAAUn7K4/kQRcyA47+WDVpgVdT3V/uoerUZ98idnfCw/nud3GEnMR
 OydbGNyJD6zcAI6djMemfJjGmJ0/trk=
X-Google-Smtp-Source: APXvYqwapuMptwW7ac/qcmQ31FZUfCP0AJlIuoBA8Kd2kRPcrU+31uWCV5KyyRaEBMrclr4VEiqdCg==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr3515718wrp.171.1575457406850; 
 Wed, 04 Dec 2019 03:03:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w8sm6810994wmm.0.2019.12.04.03.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:03:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 814F61FF87;
 Wed,  4 Dec 2019 11:03:23 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-14-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 13/40] target/arm: Rename ARMMMUIdx_S1E2 to ARMMMUIdx_E2
In-reply-to: <20191203022937.1474-14-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:03:23 +0000
Message-ID: <871rtk9wuc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is part of a reorganization to the set of mmu_idx.
> The non-secure EL2 regime only has a single stage translation;
> there is no point in pointing out that the idx is for stage1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h       |  4 ++--
>  target/arm/internals.h |  2 +-
>  target/arm/helper.c    | 22 +++++++++++-----------
>  target/arm/translate.c |  2 +-
>  4 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f307de561a..28259be733 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2866,7 +2866,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, =
unsigned int excp_idx,
>  typedef enum ARMMMUIdx {
>      ARMMMUIdx_EL10_0 =3D 0 | ARM_MMU_IDX_A,
>      ARMMMUIdx_EL10_1 =3D 1 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_S1E2 =3D 2 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_E2 =3D 2 | ARM_MMU_IDX_A,
>      ARMMMUIdx_SE3 =3D 3 | ARM_MMU_IDX_A,
>      ARMMMUIdx_SE0 =3D 4 | ARM_MMU_IDX_A,
>      ARMMMUIdx_SE1 =3D 5 | ARM_MMU_IDX_A,
> @@ -2892,7 +2892,7 @@ typedef enum ARMMMUIdx {
>  typedef enum ARMMMUIdxBit {
>      ARMMMUIdxBit_EL10_0 =3D 1 << 0,
>      ARMMMUIdxBit_EL10_1 =3D 1 << 1,
> -    ARMMMUIdxBit_S1E2 =3D 1 << 2,
> +    ARMMMUIdxBit_E2 =3D 1 << 2,
>      ARMMMUIdxBit_SE3 =3D 1 << 3,
>      ARMMMUIdxBit_SE0 =3D 1 << 4,
>      ARMMMUIdxBit_SE1 =3D 1 << 5,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 50d258b0e1..aee54dc105 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -812,7 +812,7 @@ static inline bool regime_is_secure(CPUARMState *env,=
 ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_EL10_1:
>      case ARMMMUIdx_Stage1_E0:
>      case ARMMMUIdx_Stage1_E1:
> -    case ARMMMUIdx_S1E2:
> +    case ARMMMUIdx_E2:
>      case ARMMMUIdx_Stage2:
>      case ARMMMUIdx_MPrivNegPri:
>      case ARMMMUIdx_MUserNegPri:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 98d00b4549..5172843667 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -728,7 +728,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>  {
>      CPUState *cs =3D env_cpu(env);
>=20=20
> -    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
> +    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *r=
i,
> @@ -736,7 +736,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, co=
nst ARMCPRegInfo *ri,
>  {
>      CPUState *cs =3D env_cpu(env);
>=20=20
> -    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -745,7 +745,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>      CPUState *cs =3D env_cpu(env);
>      uint64_t pageaddr =3D value & ~MAKE_64BIT_MASK(0, 12);
>=20=20
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *r=
i,
> @@ -755,7 +755,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, co=
nst ARMCPRegInfo *ri,
>      uint64_t pageaddr =3D value & ~MAKE_64BIT_MASK(0, 12);
>=20=20
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             ARMMMUIdxBit_S1E2);
> +                                             ARMMMUIdxBit_E2);
>  }
>=20=20
>  static const ARMCPRegInfo cp_reginfo[] =3D {
> @@ -3189,7 +3189,7 @@ static void ats1h_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      MMUAccessType access_type =3D ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DA=
TA_LOAD;
>      uint64_t par64;
>=20=20
> -    par64 =3D do_ats_write(env, value, access_type, ARMMMUIdx_S1E2);
> +    par64 =3D do_ats_write(env, value, access_type, ARMMMUIdx_E2);
>=20=20
>      A32_BANKED_CURRENT_REG_SET(env, par, par64);
>  }
> @@ -3217,7 +3217,7 @@ static void ats_write64(CPUARMState *env, const ARM=
CPRegInfo *ri,
>              mmu_idx =3D secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
>              break;
>          case 4: /* AT S1E2R, AT S1E2W */
> -            mmu_idx =3D ARMMMUIdx_S1E2;
> +            mmu_idx =3D ARMMMUIdx_E2;
>              break;
>          case 6: /* AT S1E3R, AT S1E3W */
>              mmu_idx =3D ARMMMUIdx_SE3;
> @@ -3954,7 +3954,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env,=
 const ARMCPRegInfo *ri,
>      ARMCPU *cpu =3D env_archcpu(env);
>      CPUState *cs =3D CPU(cpu);
>=20=20
> -    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
> +    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> @@ -3980,7 +3980,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>  {
>      CPUState *cs =3D env_cpu(env);
>=20=20
> -    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
> @@ -4002,7 +4002,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, =
const ARMCPRegInfo *ri,
>      CPUState *cs =3D CPU(cpu);
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>=20=20
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *r=
i,
> @@ -4055,7 +4055,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
>      uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>=20=20
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             ARMMMUIdxBit_S1E2);
> +                                             ARMMMUIdxBit_E2);
>  }
>=20=20
>  static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> @@ -8565,7 +8565,7 @@ static inline uint32_t regime_el(CPUARMState *env, =
ARMMMUIdx mmu_idx)
>  {
>      switch (mmu_idx) {
>      case ARMMMUIdx_Stage2:
> -    case ARMMMUIdx_S1E2:
> +    case ARMMMUIdx_E2:
>          return 2;
>      case ARMMMUIdx_SE3:
>          return 3;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 6cf2fe2806..51ea99e6f9 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -152,7 +152,7 @@ static inline int get_a32_user_mem_index(DisasContext=
 *s)
>       *  otherwise, access as if at PL0.
>       */
>      switch (s->mmu_idx) {
> -    case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
> +    case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
>      case ARMMMUIdx_EL10_0:
>      case ARMMMUIdx_EL10_1:
>          return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);


--=20
Alex Benn=C3=A9e

