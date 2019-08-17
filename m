Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43308C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 11:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02ADC20880
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 11:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="egceOakf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ADC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hywSm-0006fp-U3
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 07:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hywRI-0005es-7V
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 07:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hywRG-0007x3-BM
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 07:00:03 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49141 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hywRF-0007tY-1x; Sat, 17 Aug 2019 07:00:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 469cf32nzJz9sDB; Sat, 17 Aug 2019 20:59:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566039595;
 bh=69hrP6yX5sOOc4JCxdlF5QOqVIswKdzVCKK+2xOOzMo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=egceOakfwy6VZ6zp2/iR3rRtci6lODnwTn4icTMeo6O3QIinPrMGQVQvdWw5B0Uwe
 94gbFz3jYDI0rCaZLsVAk6v71SIAjMS0/mnnkstZqzswRYmqP5wCEGU7ImomwiNQL9
 UfXqprK4a/jPSvRWnAL0DjI8BO3DfbL3WAMpXUtE=
Date: Sat, 17 Aug 2019 18:18:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190817081811.GE2259@umbus.fritz.box>
References: <1565982203-11048-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <1565982203-11048-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4] ppc: Add support for 'mffsl' instruction
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 02:03:23PM -0500, Paul A. Clarke wrote:
65;5603;1c> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> This patch adds support for 'mffsl'.
>=20
> 'mffsl' is identical to 'mffs', except it only returns mode, status, and =
enable
> bits from the FPSCR.
>=20
> On CPUs without support for 'mffsl' (below ISA 3.0), the 'mffsl' instruct=
ion
> will execute identically to 'mffs'.
>=20
> Note: I renamed FPSCR_RN to FPSCR_RN0 so I could create an FPSCR_RN mask =
which
> is both bits of the FPSCR rounding mode, as defined in the ISA.
>=20
> I also fixed a typo in the definition of FPSCR_FR.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Applied to ppc-for-4.2, thanks.

>=20
> v4:
> - nit: added some braces to resolve a checkpatch complaint.
>=20
> v3:
> - Changed tcg_gen_and_i64 to tcg_gen_andi_i64, eliminating the need for a
>   temporary, per review from Richard Henderson.
>=20
> v2:
> - I found that I copied too much of the 'mffs' implementation.
>   The 'Rc' condition code bits are not needed for 'mffsl'.  Removed.
> - I now free the (renamed) 'tmask' temporary.
> - I now bail early for older ISA to the original 'mffs' implementation.
>=20
> ---
>  disas/ppc.c                        |  5 +++++
>  target/ppc/cpu.h                   | 15 ++++++++++-----
>  target/ppc/fpu_helper.c            |  4 ++--
>  target/ppc/translate/fp-impl.inc.c | 22 ++++++++++++++++++++++
>  target/ppc/translate/fp-ops.inc.c  |  4 +++-
>  5 files changed, 42 insertions(+), 8 deletions(-)
>=20
> diff --git a/disas/ppc.c b/disas/ppc.c
> index a545437..63e97cf 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -1765,6 +1765,9 @@ extract_tbr (unsigned long insn,
>  /* An X_MASK with the RA and RB fields fixed.  */
>  #define XRARB_MASK (X_MASK | RA_MASK | RB_MASK)
> =20
> +/* An X form instruction with the RA field fixed.  */
> +#define XRA(op, xop, ra) (X((op), (xop)) | (((ra) << 16) & XRA_MASK))
> +
>  /* An XRARB_MASK, but with the L bit clear.  */
>  #define XRLARB_MASK (XRARB_MASK & ~((unsigned long) 1 << 16))
> =20
> @@ -4998,6 +5001,8 @@ const struct powerpc_opcode powerpc_opcodes[] =3D {
>  { "ddivq",   XRC(63,546,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
>  { "ddivq.",  XRC(63,546,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
> =20
> +{ "mffsl",   XRA(63,583,12), XRARB_MASK,	POWER9,	{ FRT } },
> +
>  { "mffs",    XRC(63,583,0), XRARB_MASK,	COM,		{ FRT } },
>  { "mffs.",   XRC(63,583,1), XRARB_MASK,	COM,		{ FRT } },
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2..74e8da4 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -591,7 +591,7 @@ enum {
>  #define FPSCR_XE     3  /* Floating-point inexact exception enable      =
     */
>  #define FPSCR_NI     2  /* Floating-point non-IEEE mode                 =
     */
>  #define FPSCR_RN1    1
> -#define FPSCR_RN     0  /* Floating-point rounding control              =
     */
> +#define FPSCR_RN0    0  /* Floating-point rounding control              =
     */
>  #define fpscr_fex    (((env->fpscr) >> FPSCR_FEX)    & 0x1)
>  #define fpscr_vx     (((env->fpscr) >> FPSCR_VX)     & 0x1)
>  #define fpscr_ox     (((env->fpscr) >> FPSCR_OX)     & 0x1)
> @@ -614,7 +614,7 @@ enum {
>  #define fpscr_ze     (((env->fpscr) >> FPSCR_ZE)     & 0x1)
>  #define fpscr_xe     (((env->fpscr) >> FPSCR_XE)     & 0x1)
>  #define fpscr_ni     (((env->fpscr) >> FPSCR_NI)     & 0x1)
> -#define fpscr_rn     (((env->fpscr) >> FPSCR_RN)     & 0x3)
> +#define fpscr_rn     (((env->fpscr) >> FPSCR_RN0)    & 0x3)
>  /* Invalid operation exception summary */
>  #define fpscr_ix ((env->fpscr) & ((1 << FPSCR_VXSNAN) | (1 << FPSCR_VXIS=
I)  | \
>                                    (1 << FPSCR_VXIDI)  | (1 << FPSCR_VXZD=
Z)  | \
> @@ -640,7 +640,7 @@ enum {
>  #define FP_VXZDZ        (1ull << FPSCR_VXZDZ)
>  #define FP_VXIMZ        (1ull << FPSCR_VXIMZ)
>  #define FP_VXVC         (1ull << FPSCR_VXVC)
> -#define FP_FR           (1ull << FSPCR_FR)
> +#define FP_FR           (1ull << FPSCR_FR)
>  #define FP_FI           (1ull << FPSCR_FI)
>  #define FP_C            (1ull << FPSCR_C)
>  #define FP_FL           (1ull << FPSCR_FL)
> @@ -648,7 +648,7 @@ enum {
>  #define FP_FE           (1ull << FPSCR_FE)
>  #define FP_FU           (1ull << FPSCR_FU)
>  #define FP_FPCC         (FP_FL | FP_FG | FP_FE | FP_FU)
> -#define FP_FPRF         (FP_C  | FP_FL | FP_FG | FP_FE | FP_FU)
> +#define FP_FPRF         (FP_C | FP_FPCC)
>  #define FP_VXSOFT       (1ull << FPSCR_VXSOFT)
>  #define FP_VXSQRT       (1ull << FPSCR_VXSQRT)
>  #define FP_VXCVI        (1ull << FPSCR_VXCVI)
> @@ -659,7 +659,12 @@ enum {
>  #define FP_XE           (1ull << FPSCR_XE)
>  #define FP_NI           (1ull << FPSCR_NI)
>  #define FP_RN1          (1ull << FPSCR_RN1)
> -#define FP_RN           (1ull << FPSCR_RN)
> +#define FP_RN0          (1ull << FPSCR_RN0)
> +#define FP_RN           (FP_RN1 | FP_RN0)
> +
> +#define FP_MODE         FP_RN
> +#define FP_ENABLES      (FP_VE | FP_OE | FP_UE | FP_ZE | FP_XE)
> +#define FP_STATUS       (FP_FR | FP_FI | FP_FPRF)
> =20
>  /* the exception bits which can be cleared by mcrfs - includes FX */
>  #define FP_EX_CLEAR_BITS (FP_FX     | FP_OX     | FP_UX     | FP_ZX     =
| \
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index f437c88..5611cf0 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -403,7 +403,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t b=
it)
>      if (prev =3D=3D 1) {
>          switch (bit) {
>          case FPSCR_RN1:
> -        case FPSCR_RN:
> +        case FPSCR_RN0:
>              fpscr_set_rounding_mode(env);
>              break;
>          case FPSCR_VXSNAN:
> @@ -557,7 +557,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t b=
it)
>              }
>              break;
>          case FPSCR_RN1:
> -        case FPSCR_RN:
> +        case FPSCR_RN0:
>              fpscr_set_rounding_mode(env);
>              break;
>          default:
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index 9dcff94..7cd9d8d 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -617,6 +617,28 @@ static void gen_mffs(DisasContext *ctx)
>      tcg_temp_free_i64(t0);
>  }
> =20
> +/* mffsl */
> +static void gen_mffsl(DisasContext *ctx)
> +{
> +    TCGv_i64 t0;
> +
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> +        return gen_mffs(ctx);
> +    }
> +
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +    t0 =3D tcg_temp_new_i64();
> +    gen_reset_fpstatus();
> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> +    /* Mask everything except mode, status, and enables.  */
> +    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_STATUS | FP_ENABLES);
> +    set_fpr(rD(ctx->opcode), t0);
> +    tcg_temp_free_i64(t0);
> +}
> +
>  /* mtfsb0 */
>  static void gen_mtfsb0(DisasContext *ctx)
>  {
> diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-=
ops.inc.c
> index 621f6bf..88ebc25 100644
> --- a/target/ppc/translate/fp-ops.inc.c
> +++ b/target/ppc/translate/fp-ops.inc.c
> @@ -104,7 +104,9 @@ GEN_HANDLER_E(fcpsgn, 0x3F, 0x08, 0x00, 0x00000000, P=
PC_NONE, PPC2_ISA205),
>  GEN_HANDLER_E(fmrgew, 0x3F, 0x06, 0x1E, 0x00000001, PPC_NONE, PPC2_VSX20=
7),
>  GEN_HANDLER_E(fmrgow, 0x3F, 0x06, 0x1A, 0x00000001, PPC_NONE, PPC2_VSX20=
7),
>  GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
> -GEN_HANDLER(mffs, 0x3F, 0x07, 0x12, 0x001FF800, PPC_FLOAT),
> +GEN_HANDLER_E_2(mffs, 0x3F, 0x07, 0x12, 0x00, 0x00000000, PPC_FLOAT, PPC=
_NONE),
> +GEN_HANDLER_E_2(mffsl, 0x3F, 0x07, 0x12, 0x18, 0x00000000, PPC_FLOAT,
> +    PPC2_ISA300),
>  GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
>  GEN_HANDLER(mtfsb1, 0x3F, 0x06, 0x01, 0x001FF800, PPC_FLOAT),
>  GEN_HANDLER(mtfsf, 0x3F, 0x07, 0x16, 0x00000000, PPC_FLOAT),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1XuEEACgkQbDjKyiDZ
s5Lf5g//QkhGlJV4GryRmyVHjyJcy/BNcvYlHMiqcpWrqDIqh6tJeytWzluMP1AX
I06w/ZbOpEV+XZ3SwdDU9uaNLUuQz8XkHLcn6Jk87Me2tRE1+NIuYvRhXLal3iPo
ait6BdkxG5D+M7kg7OFULVkGc6f6EGTkcbErIMlJ8hfDgk3QOafZ6im6ZFxe7/F0
DnmzbkD5H3vYSdL71di6DVPumq6pNWgeL3yDRXz/gVqtLpDhmb9I9a1xVqET9UHU
EGvQ4ylwzru444T2/nyejSQKQ3bYD2lP8/Jv6JdKNzLuibV4eIfi8MxpSmqgvffV
q7EPA1I32rjnS2xfU5pPoG2r/HA73LYVKIhYr06vaZqORuTa2P4XW+IUdCdKqYDG
5Pwb3c0pH1XgLqVzQdQkc64fsSon/gYs7FHbks2aBycUM1y0cnzYjjNgFtGBNpKr
3gqCHgPRl+IZct+Gze1CI1oAoGSvoF8QccuDO1PcU4N035GeNs3IRHwvjNJWJVt4
sSO4MXH4lG5q+bLBDO6KLzvRJoHH360/eStGTW9dHCZtaGoXHhxjhI/DAx9LfQ6G
eaJ+TeGxzJlK4F3BW7jBOzETNwygaop2TgtiOmygZoOHoXGTvlqeGbyane+8cz+7
r86Wu8VgSPCNqbbBbm1SO2KK/BI632smtAb9hOhkxmpTELAYjFg=
=+Drf
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

