Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C96C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507DE20678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="prBPLxJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507DE20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2U6V-00019U-1w
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 02:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k2U5p-0000Kb-Ov; Mon, 03 Aug 2020 02:37:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k2U5l-000839-Up; Mon, 03 Aug 2020 02:37:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BKp823xxxz9sTX; Mon,  3 Aug 2020 16:36:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596436610;
 bh=v59nwMwMwGPRkIhxWj5bw1tjXo1RZEkQ7PyTWj0OADQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=prBPLxJukYcdioCRleYWafItxfRjjIx4/ar64VLdtcgk0+lLCyBlmHWLUSy1uIb+L
 vTSPWWEP0y/Ky1uIQ9gj21es+KOEAU9qqcH5abOMb35GeKukKQurXrtT1b7pc6SLjh
 qJITXmNnmkxQTEj2qB47od6OpyTRyT/WJVH9/xWk=
Date: Mon, 3 Aug 2020 16:24:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
Subject: Re: [PATCH v2] target/ppc: Fix SPE unavailable exception triggering
Message-ID: <20200803062429.GA7553@yekko.fritz.box>
References: <20200727175553.32276-1-matthieu.bucchianeri@leostella.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20200727175553.32276-1-matthieu.bucchianeri@leostella.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 10:55:53AM -0700, Matthieu Bucchianeri wrote:
> When emulating certain floating point instructions or vector instructions=
 on
> PowerPC machines, QEMU did not properly generate the SPE/Embedded Floatin=
g-
> Point Unavailable interrupt. See the buglink further below for references=
 to
> the relevant NXP documentation.
>=20
> This patch fixes the behavior of some evfs* instructions that were
> incorrectly emitting the interrupt.
>=20
> More importantly, this patch fixes the behavior of several efd* and ev*
> instructions that were not generating the interrupt. Triggering the
> interrupt for these instructions fixes lazy FPU/vector context switching =
on
> some operating systems like Linux.
>=20
> Without this patch, the result of some double-precision arithmetic could =
be
> corrupted due to the lack of proper saving and restoring of the upper
> 32-bit part of the general-purpose registers.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1888918
> Buglink: https://bugs.launchpad.net/qemu/+bug/1611394
> Signed-off-by: Matthieu Bucchianeri
> <matthieu.bucchianeri@leostella.com>

Applied to ppc-for-5.2.

> ---
> v2:
>   Split out fix for TCG leak in gen_evmwsmiaa().
>=20
> Based-on: <20200727172114.31415-1-matthieu.bucchianeri@leostella.com>
> ([PATCH] target/ppc: Fix TCG leak with the evmwsmiaa instruction)
>=20
> target/ppc/translate/spe-impl.inc.c | 97 +++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 33 deletions(-)
>=20
> diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/s=
pe-impl.inc.c
> index 42a0d1cffb..2e6e799a25 100644
> --- a/target/ppc/translate/spe-impl.inc.c
> +++ b/target/ppc/translate/spe-impl.inc.c
> @@ -349,14 +349,24 @@ static inline void gen_evmergelohi(DisasContext *ct=
x)
>  }
>  static inline void gen_evsplati(DisasContext *ctx)
>  {
> -    uint64_t imm =3D ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
> +    uint64_t imm;
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +    imm =3D ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
>=20
>      tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
>      tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
>  }
>  static inline void gen_evsplatfi(DisasContext *ctx)
>  {
> -    uint64_t imm =3D rA(ctx->opcode) << 27;
> +    uint64_t imm;
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +    imm =3D rA(ctx->opcode) << 27;
>=20
>      tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
>      tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
> @@ -389,21 +399,37 @@ static inline void gen_evsel(DisasContext *ctx)
>=20
>  static void gen_evsel0(DisasContext *ctx)
>  {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>      gen_evsel(ctx);
>  }
>=20
>  static void gen_evsel1(DisasContext *ctx)
>  {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>      gen_evsel(ctx);
>  }
>=20
>  static void gen_evsel2(DisasContext *ctx)
>  {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>      gen_evsel(ctx);
>  }
>=20
>  static void gen_evsel3(DisasContext *ctx)
>  {
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
>      gen_evsel(ctx);
>  }
>=20
> @@ -518,6 +544,11 @@ static inline void gen_evmwsmia(DisasContext *ctx)
>  {
>      TCGv_i64 tmp;
>=20
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +
>      gen_evmwsmi(ctx);            /* rD :=3D rA * rB */
>=20
>      tmp =3D tcg_temp_new_i64();
> @@ -534,6 +565,11 @@ static inline void gen_evmwsmiaa(DisasContext *ctx)
>      TCGv_i64 acc;
>      TCGv_i64 tmp;
>=20
> +    if (unlikely(!ctx->spe_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> +        return;
> +    }
> +
>      gen_evmwsmi(ctx);           /* rD :=3D rA * rB */
>=20
>      acc =3D tcg_temp_new_i64();
> @@ -892,8 +928,14 @@ static inline void gen_##name(DisasContext *ctx)    =
                          \
>  #define GEN_SPEFPUOP_CONV_32_64(name)                                   =
      \
>  static inline void gen_##name(DisasContext *ctx)                        =
      \
>  {                                                                       =
      \
> -    TCGv_i64 t0 =3D tcg_temp_new_i64();                                 =
        \
> -    TCGv_i32 t1 =3D tcg_temp_new_i32();                                 =
        \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i32 t1;                                                        =
      \
> +    if (unlikely(!ctx->spe_enabled)) {                                  =
      \
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);                          =
      \
> +        return;                                                         =
      \
> +    }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i32();                                          =
        \
>      gen_load_gpr64(t0, rB(ctx->opcode));                                =
      \
>      gen_helper_##name(t1, cpu_env, t0);                                 =
      \
>      tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);                  =
      \
> @@ -903,8 +945,14 @@ static inline void gen_##name(DisasContext *ctx)    =
                          \
>  #define GEN_SPEFPUOP_CONV_64_32(name)                                   =
      \
>  static inline void gen_##name(DisasContext *ctx)                        =
      \
>  {                                                                       =
      \
> -    TCGv_i64 t0 =3D tcg_temp_new_i64();                                 =
        \
> -    TCGv_i32 t1 =3D tcg_temp_new_i32();                                 =
        \
> +    TCGv_i64 t0;                                                        =
      \
> +    TCGv_i32 t1;                                                        =
      \
> +    if (unlikely(!ctx->spe_enabled)) {                                  =
      \
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);                          =
      \
> +        return;                                                         =
      \
> +    }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
> +    t1 =3D tcg_temp_new_i32();                                          =
        \
>      tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                 =
      \
>      gen_helper_##name(t0, cpu_env, t1);                                 =
      \
>      gen_store_gpr64(rD(ctx->opcode), t0);                               =
      \
> @@ -914,7 +962,12 @@ static inline void gen_##name(DisasContext *ctx)    =
                          \
>  #define GEN_SPEFPUOP_CONV_64_64(name)                                   =
      \
>  static inline void gen_##name(DisasContext *ctx)                        =
      \
>  {                                                                       =
      \
> -    TCGv_i64 t0 =3D tcg_temp_new_i64();                                 =
        \
> +    TCGv_i64 t0;                                                        =
      \
> +    if (unlikely(!ctx->spe_enabled)) {                                  =
      \
> +        gen_exception(ctx, POWERPC_EXCP_SPEU);                          =
      \
> +        return;                                                         =
      \
> +    }                                                                   =
      \
> +    t0 =3D tcg_temp_new_i64();                                          =
        \
>      gen_load_gpr64(t0, rB(ctx->opcode));                                =
      \
>      gen_helper_##name(t0, cpu_env, t0);                                 =
      \
>      gen_store_gpr64(rD(ctx->opcode), t0);                               =
      \
> @@ -923,13 +976,8 @@ static inline void gen_##name(DisasContext *ctx)    =
                          \
>  #define GEN_SPEFPUOP_ARITH2_32_32(name)                                 =
      \
>  static inline void gen_##name(DisasContext *ctx)                        =
      \
>  {                                                                       =
      \
> -    TCGv_i32 t0, t1;                                                    =
      \
> -    if (unlikely(!ctx->spe_enabled)) {                                  =
      \
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);                          =
      \
> -        return;                                                         =
      \
> -    }                                                                   =
      \
> -    t0 =3D tcg_temp_new_i32();                                          =
        \
> -    t1 =3D tcg_temp_new_i32();                                          =
        \
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();                                 =
        \
> +    TCGv_i32 t1 =3D tcg_temp_new_i32();                                 =
        \
>      tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                 =
      \
>      tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                 =
      \
>      gen_helper_##name(t0, cpu_env, t0, t1);                             =
      \
> @@ -958,13 +1006,8 @@ static inline void gen_##name(DisasContext *ctx)   =
                           \
>  #define GEN_SPEFPUOP_COMP_32(name)                                      =
      \
>  static inline void gen_##name(DisasContext *ctx)                        =
      \
>  {                                                                       =
      \
> -    TCGv_i32 t0, t1;                                                    =
      \
> -    if (unlikely(!ctx->spe_enabled)) {                                  =
      \
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);                          =
      \
> -        return;                                                         =
      \
> -    }                                                                   =
      \
> -    t0 =3D tcg_temp_new_i32();                                          =
        \
> -    t1 =3D tcg_temp_new_i32();                                          =
        \
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();                                 =
        \
> +    TCGv_i32 t1 =3D tcg_temp_new_i32();                                 =
        \
>                                                                          =
      \
>      tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                 =
      \
>      tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                 =
      \
> @@ -1074,28 +1117,16 @@ GEN_SPEFPUOP_ARITH2_32_32(efsmul);
>  GEN_SPEFPUOP_ARITH2_32_32(efsdiv);
>  static inline void gen_efsabs(DisasContext *ctx)
>  {
> -    if (unlikely(!ctx->spe_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);
> -        return;
> -    }
>      tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
>                      (target_long)~0x80000000LL);
>  }
>  static inline void gen_efsnabs(DisasContext *ctx)
>  {
> -    if (unlikely(!ctx->spe_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);
> -        return;
> -    }
>      tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
>                     0x80000000);
>  }
>  static inline void gen_efsneg(DisasContext *ctx)
>  {
> -    if (unlikely(!ctx->spe_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_SPEU);
> -        return;
> -    }
>      tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
>                      0x80000000);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8nrZ0ACgkQbDjKyiDZ
s5LEPRAAgm1rFGIlAUjoaeLMZa84HK8SZLzQ32nl0UssB/H5KgIkRRDC1PQMy+ol
6MfajIVMlFuAw58WU4Z9RiHZqnX0XdMWEEmKZFOnD0mylmVMA8GdxwTj8F04psa5
MWBdRFTp483n+Uf43jjWyi2IEzzfqVA9CYGfaLvn1v6s9RoVNnqSAE7dHc/ot+iT
D6eIzLCTChFIhgTXgYRz+ufluZwx3l+zOG57JPSf2ZQZxV43YnmoWtX1Rw5O2psp
4eyZH+Y8IEPBo2WwNZPHEn3YTswUjhQbPyg+B0CblJeVxfG3R/ZZJ0f7HDIn7tz6
8ois8pgP6xrrZgCrNLz4JXy49nGMV+RYtq4AWJPO1wgfQDVi7Yg+B6ZX/6E84B/M
F7X667HBKYlVEPk+31/ya5YxR/KrGNsqGe/E4c8qW9aH0diWN3HLi1W2Z3GLJMay
JTni8qyPT1Y6z/phBe3Vy3L/2q4L3Siru+eS9iU+C38WtZSUIx/8Nh57Z9FZMpqm
rZ9uRkBDaUninpA3FDU8+JEVjbxbv9hyxIbhjM2RJDyoxtJ6dq2kIzFv2qg23yrh
HxcFe4HqLoXNY8wYTo531BeoBSVZZYuNxT5gDXKR5WyYkZrm0U27cA0Zd90t23iL
Ui3TtuIdT7LUPlAxIuOZA2WZs/MrgLXfVKAmkvcr+R5QWI3vMmU=
=XMfu
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

