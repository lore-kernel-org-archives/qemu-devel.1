Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8E8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB83220663
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjiQJ0xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB83220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhTJ5-0006tf-Bv
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 03:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jhTIN-00068R-8v
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 03:31:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jhTIL-0001Zo-OA
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 03:31:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id u26so10536888wmn.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bIfvt7FkW1I4uzy+oe01w9BHsI4oUCzEITR5GRGSZKk=;
 b=pjiQJ0xGQlt8g62PIxruL6quS/dF0vJs5MvrqLapG8AAqE3dPsRpJd/3tTpkkCPdFd
 /fm9U8qtOsmuEkjgpq7LOzk61LURdkKFyP5nDA10cNl+fZ91VDti6a7i04LxAHfuOyDU
 yYdlY9UU1VOJf/IKVmVNm82uBc8c/Cpq+86HCdAGP/FRD+SWFevjnSKWcnwsl9xpxzSU
 Q5Q4HvSjO/4YvzBp2/Y7mhD7BQzzjNvE+Buv3YDpvy0CFJykb/Udb/sXsXYl7P3RLPoC
 QZ/yMWA4MJjLIB5runtI/kSV/hYsB2F9/Geh5q/mo42zp8ydCgykCHtODJqZuwwIWDpx
 ichw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bIfvt7FkW1I4uzy+oe01w9BHsI4oUCzEITR5GRGSZKk=;
 b=Sl5KAJj2CwhXxQS1hN8BzonWkhwAoVi+lBJIpXiDeM3Ma0mit1dgO7g09+Ptnwf7Ad
 w4zGlSbZzC9jizrvhV5T/OZz48YhNndOp8nnrn0zn8WTy2grBE21IRbaDzUk18O8H3o9
 owwJ9f6cyRdscv6uc3oauZHsr8YWILgdXpXIpE4M2ton55UA3YI38d1zI20UVRqXHCLM
 lhrU6c0vpxh7zlZ1dLPsWDX71EeMMVYZyXbJ5yD1KxVta3vIeGE7JEfeap6o2VRjnZBk
 Z/fVq5Ma+KyAJF3bDRAFRwBYKMpnFe/bX3XUAXQCOgR24qRsTUN1ac1UK+i3uLOCcADT
 0T6w==
X-Gm-Message-State: AOAM530igT/8YkF3K3RnLrTAoICxQKOLJ/DWiWUqla64XRxUP5uCx1Ni
 Q1haWW3VGIh2aRWQYiCXujfkQnv7Y+tIlJLsCeU=
X-Google-Smtp-Source: ABdhPJwY0b+01HPoju+6ZDhuQDQA8JDzsfTej9STauh0sNNCnawy1zLa8+p/iIbQXOsVQgfKZkqLxeBvec7VxM0CKRI=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr6060913wmf.129.1591428668140; 
 Sat, 06 Jun 2020 00:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1591065557-9174-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 6 Jun 2020 09:30:55 +0200
Message-ID: <CAHiYmc5X_v_j9wJoqMUmjNuSRTE338rY3i1SvpjTXzAec2uEhA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 2/4] target/mips: Add Loongson-3 CPU definition
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:39 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, we just define two CPU types:
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
>
> Loongson-3A has CONFIG6 and CONFIG7, so add their bit-fields as well.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

In yesterday's discussion we discussed Loongson-3A R1/R2/R3/R4 and
Loongson-3B R1/R2 base instruction set and extensions. They all should
have their place in insn_flags. However, this is not crucial for KVM
functionality covered in this series, and could be done later on,
independently.

In other words, this should not stop this series from integrating to upstre=
am.

So:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

>  target/mips/cpu.h                | 28 +++++++++++++
>  target/mips/internal.h           |  2 +
>  target/mips/mips-defs.h          |  7 +++-
>  target/mips/translate.c          |  2 +
>  target/mips/translate_init.inc.c | 86 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 123 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 94d01ea..0b3c987 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -940,7 +940,35 @@ struct CPUMIPSState {
>  #define CP0C5_UFR          2
>  #define CP0C5_NFExists     0
>      int32_t CP0_Config6;
> +    int32_t CP0_Config6_rw_bitmask;
> +#define CP0C6_BPPASS          31
> +#define CP0C6_KPOS            24
> +#define CP0C6_KE              23
> +#define CP0C6_VTLBONLY        22
> +#define CP0C6_LASX            21
> +#define CP0C6_SSEN            20
> +#define CP0C6_DISDRTIME       19
> +#define CP0C6_PIXNUEN         18
> +#define CP0C6_SCRAND          17
> +#define CP0C6_LLEXCEN         16
> +#define CP0C6_DISVC           15
> +#define CP0C6_VCLRU           14
> +#define CP0C6_DCLRU           13
> +#define CP0C6_PIXUEN          12
> +#define CP0C6_DISBLKLYEN      11
> +#define CP0C6_UMEMUALEN       10
> +#define CP0C6_SFBEN           8
> +#define CP0C6_FLTINT          7
> +#define CP0C6_VLTINT          6
> +#define CP0C6_DISBTB          5
> +#define CP0C6_STPREFCTL       2
> +#define CP0C6_INSTPREF        1
> +#define CP0C6_DATAPREF        0
>      int32_t CP0_Config7;
> +    int64_t CP0_Config7_rw_bitmask;
> +#define CP0C7_NAPCGEN       2
> +#define CP0C7_UNIMUEN       1
> +#define CP0C7_VFPUCGEN      0
>      uint64_t CP0_LLAddr;
>      uint64_t CP0_MAAR[MIPS_MAAR_MAX];
>      int32_t CP0_MAARI;
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 1bf274b..7853cb1 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -36,7 +36,9 @@ struct mips_def_t {
>      int32_t CP0_Config5;
>      int32_t CP0_Config5_rw_bitmask;
>      int32_t CP0_Config6;
> +    int32_t CP0_Config6_rw_bitmask;
>      int32_t CP0_Config7;
> +    int32_t CP0_Config7_rw_bitmask;
>      target_ulong CP0_LLAddr_rw_bitmask;
>      int CP0_LLAddr_shift;
>      int32_t SYNCI_Step;
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index a831bb4..c2c96db 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -51,8 +51,9 @@
>   */
>  #define INSN_LOONGSON2E   0x0001000000000000ULL
>  #define INSN_LOONGSON2F   0x0002000000000000ULL
> -#define INSN_VR54XX       0x0004000000000000ULL
> -#define INSN_R5900        0x0008000000000000ULL
> +#define INSN_LOONGSON3A   0x0004000000000000ULL
> +#define INSN_VR54XX       0x0008000000000000ULL
> +#define INSN_R5900        0x0010000000000000ULL
>  /*
>   *   bits 56-63: vendor-specific ASEs
>   */
> @@ -94,6 +95,8 @@
>  /* Wave Computing: "nanoMIPS" */
>  #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
>
> +#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
> +
>  /*
>   * Strictly follow the architecture standard:
>   * - Disallow "special" instruction handling for PMON/SPIM.
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 25b595a..2caf4cb 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
>      env->CP0_Config5 =3D env->cpu_model->CP0_Config5;
>      env->CP0_Config5_rw_bitmask =3D env->cpu_model->CP0_Config5_rw_bitma=
sk;
>      env->CP0_Config6 =3D env->cpu_model->CP0_Config6;
> +    env->CP0_Config6_rw_bitmask =3D env->cpu_model->CP0_Config6_rw_bitma=
sk;
>      env->CP0_Config7 =3D env->cpu_model->CP0_Config7;
> +    env->CP0_Config7_rw_bitmask =3D env->cpu_model->CP0_Config7_rw_bitma=
sk;
>      env->CP0_LLAddr_rw_bitmask =3D env->cpu_model->CP0_LLAddr_rw_bitmask
>                                   << env->cpu_model->CP0_LLAddr_shift;
>      env->CP0_LLAddr_shift =3D env->cpu_model->CP0_LLAddr_shift;
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_ini=
t.inc.c
> index 6d145a9..a31f229 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -802,6 +802,92 @@ const mips_def_t mips_defs[] =3D
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
>      {
> +        .name =3D "Loongson-3A1000",
> +        .CP0_PRid =3D 0x6305,
> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size. =
 */
> +        .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C=
0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_M=
MU) |
> +                       (3 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_I=
A) |
> +                       (3 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_D=
A) |
> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_E=
P),
> +        .CP0_Config2 =3D MIPS_CONFIG2 | (7 << CP0C2_SS) | (4 << CP0C2_SL=
) |
> +                       (3 << CP0C2_SA),
> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_LPA),
> +        .CP0_LLAddr_rw_bitmask =3D 0,
> +        .SYNCI_Step =3D 32,
> +        .CCRes =3D 2,
> +        .CP0_Status_rw_bitmask =3D 0x74D8FFFF,
> +        .CP0_PageGrain =3D (1 << CP0PG_ELPA),
> +        .CP0_PageGrain_rw_bitmask =3D (1 << CP0PG_ELPA),
> +        .CP1_fcr0 =3D (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << F=
CR0_F64) |
> +                    (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W)=
 |
> +                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
> +        .CP1_fcr31 =3D 0,
> +        .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
> +        .SEGBITS =3D 42,
> +        .PABITS =3D 48,
> +        .insn_flags =3D CPU_LOONGSON3A,
> +        .mmu_type =3D MMU_TYPE_R4000,
> +    },
> +    {
> +        .name =3D "Loongson-3A4000",
> +        .CP0_PRid =3D 0x14C000,
> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size. =
 */
> +        .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C=
0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_M=
MU) |
> +                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << CP0C1_I=
A) |
> +                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << CP0C1_D=
A) |
> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_E=
P),
> +        .CP0_Config2 =3D MIPS_CONFIG2 | (5 << CP0C2_SS) | (5 << CP0C2_SL=
) |
> +                       (15 << CP0C2_SA),
> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MS=
AP) |
> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_U=
LRI) |
> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3=
_VInt),
> +        .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE=
) |
> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
> +        .CP0_Config4_rw_bitmask =3D 0,
> +        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_=
NFExists),
> +        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_K) | (1 << CP0C5_CV) |
> +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) =
|
> +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
> +        .CP0_Config6 =3D (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
> +                       (1 << CP0C6_SFBEN) | (1 << CP0C6_VLTINT) |
> +                       (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
> +        .CP0_Config6_rw_bitmask =3D (1 << CP0C6_BPPASS) | (0x3f << CP0C6=
_KPOS) |
> +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY=
) |
> +                                  (1 << CP0C6_LASX) | (1 << CP0C6_SSEN) =
|
> +                                  (1 << CP0C6_DISDRTIME) | (1 << CP0C6_P=
IXNUEN) |
> +                                  (1 << CP0C6_SCRAND) | (1 << CP0C6_LLEX=
CEN) |
> +                                  (1 << CP0C6_DISVC) | (1 << CP0C6_VCLRU=
) |
> +                                  (1 << CP0C6_DCLRU) | (1 << CP0C6_PIXUE=
N) |
> +                                  (1 << CP0C6_DISBLKLYEN) | (1 << CP0C6_=
UMEMUALEN) |
> +                                  (1 << CP0C6_SFBEN) | (1 << CP0C6_FLTIN=
T) |
> +                                  (1 << CP0C6_VLTINT) | (1 << CP0C6_DISB=
TB) |
> +                                  (3 << CP0C6_STPREFCTL) | (1 << CP0C6_I=
NSTPREF) |
> +                                  (1 << CP0C6_DATAPREF),
> +        .CP0_Config7 =3D 0,
> +        .CP0_Config7_rw_bitmask =3D (1 << CP0C7_NAPCGEN) | (1 << CP0C7_U=
NIMUEN) |
> +                                  (1 << CP0C7_VFPUCGEN),
> +        .CP0_LLAddr_rw_bitmask =3D 1,
> +        .SYNCI_Step =3D 16,
> +        .CCRes =3D 2,
> +        .CP0_Status_rw_bitmask =3D 0x7DDBFFFF,
> +        .CP0_PageGrain =3D (1 << CP0PG_ELPA),
> +        .CP0_PageGrain_rw_bitmask =3D (1U << CP0PG_RIE) | (1 << CP0PG_XI=
E) |
> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
> +        .CP1_fcr0 =3D (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << F=
CR0_F64) |
> +                    (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W)=
 |
> +                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
> +        .CP1_fcr31 =3D 0,
> +        .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
> +        .SEGBITS =3D 48,
> +        .PABITS =3D 48,
> +        .insn_flags =3D CPU_LOONGSON3A,
> +        .mmu_type =3D MMU_TYPE_R4000,
> +    },
> +    {
>          /* A generic CPU providing MIPS64 DSP R2 ASE features.
>             FIXME: Eventually this should be replaced by a real CPU model=
. */
>          .name =3D "mips64dspr2",
> --
> 2.7.0
>

