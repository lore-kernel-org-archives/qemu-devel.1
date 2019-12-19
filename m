Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866AC2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Dus+SQrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866AC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iho8g-0007s4-Mj
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 00:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iho7w-0007GL-S4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iho7u-0005Sj-VW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:13:32 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:34085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iho7t-00055L-Ly; Thu, 19 Dec 2019 00:13:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47dg5064hZz9sPn; Thu, 19 Dec 2019 16:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576732404;
 bh=UhXCYKgw7/UveJokhep2YGNvAchLjshpN099Qqzw3Kg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dus+SQrktWxZMcDna7pLFhqH0+1UGAouu1s+5O1zVXF9/WJTnR4LpODvSYWIKS8GM
 C42gq9tz2EtwITbheq/yrgVcAbsMIbu2PLlk4WILHP8JsbOCfuzYNAQ8GKlp+SnEm6
 oirw3rLpWnNX+IvaNRjxP8giRcEZTq1Gy06j1Lkg=
Date: Thu, 19 Dec 2019 16:12:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 6/7] target/ppc: add support for Hypervisor Facility
 Unavailable Exception
Message-ID: <20191219051246.GF2321@umbus.fritz.box>
References: <20191128134700.16091-1-clg@kaod.org>
 <20191128134700.16091-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <20191128134700.16091-7-clg@kaod.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 02:46:59PM +0100, C=E9dric Le Goater wrote:
> The privileged message send and clear instructions (msgsndp & msgclrp)
> are privileged, but will generate a hypervisor facility unavailable
> exception if not enabled in the HFSCR and executed in privileged
> non-hypervisor state.
>=20
> Add checks when accessing the DPDES register and when using the
> msgsndp and msgclrp isntructions.
>=20
> Based on previous work from Suraj Jitindar Singh.
>=20
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/cpu.h                |  6 ++++++
>  target/ppc/helper.h             |  1 +
>  target/ppc/excp_helper.c        |  9 +++++++++
>  target/ppc/misc_helper.c        | 24 ++++++++++++++++++++++++
>  target/ppc/translate.c          |  4 ++++
>  target/ppc/translate_init.inc.c | 18 ++++++++++++++++++
>  6 files changed, 62 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8ffcfa0ea162..52608dfe6ff4 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -397,6 +397,10 @@ typedef struct ppc_v3_pate_t {
>  #define PSSCR_ESL         PPC_BIT(42) /* Enable State Loss */
>  #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
> =20
> +/* HFSCR bits */
> +#define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities=
 */
> +#define HFSCR_IC_MSGP  0xA
> +
>  #define msr_sf   ((env->msr >> MSR_SF)   & 1)
>  #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
>  #define msr_shv  ((env->msr >> MSR_SHV)  & 1)
> @@ -1333,6 +1337,8 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp);
>  #endif
> =20
>  void store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask);
> +void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, int =
bit,
> +                              int sprn, int cause);
> =20
>  static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
>  {
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 76518a1df6f0..14c9a30a45c9 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -643,6 +643,7 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
> =20
>  DEF_HELPER_2(load_dump_spr, void, env, i32)
>  DEF_HELPER_2(store_dump_spr, void, env, i32)
> +DEF_HELPER_4(hfscr_facility_check, void, env, i32, i32, i32)
>  DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
>  DEF_HELPER_4(msr_facility_check, void, env, i32, i32, i32)
>  DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 5a247945e97f..17dad626b74e 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -469,6 +469,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      case POWERPC_EXCP_FU:         /* Facility unavailable exception     =
     */
>  #ifdef TARGET_PPC64
>          env->spr[SPR_FSCR] |=3D ((target_ulong)env->error_code << 56);
> +#endif
> +        break;
> +    case POWERPC_EXCP_HV_FU:     /* Hypervisor Facility Unavailable Exce=
ption */
> +#ifdef TARGET_PPC64
> +        env->spr[SPR_HFSCR] |=3D ((target_ulong)env->error_code << FSCR_=
IC_POS);
> +        srr0 =3D SPR_HSRR0;
> +        srr1 =3D SPR_HSRR1;
> +        new_msr |=3D (target_ulong)MSR_HVB;
> +        new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
>  #endif
>          break;
>      case POWERPC_EXCP_PIT:       /* Programmable interval timer interrup=
t    */
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index a0e7bd9c32d3..0cd44c6edd82 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -41,6 +41,17 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t =
sprn)
>  }
> =20
>  #ifdef TARGET_PPC64
> +static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
> +                                  uint32_t sprn, uint32_t cause,
> +                                  uintptr_t raddr)
> +{
> +    qemu_log("Facility SPR %d is unavailable (SPR HFSCR:%d)\n", sprn, bi=
t);

That looks overly verbose.  Leftover debugging?

> +    env->spr[SPR_HFSCR] &=3D ~((target_ulong)FSCR_IC_MASK << FSCR_IC_POS=
);
> +
> +    raise_exception_err_ra(env, POWERPC_EXCP_HV_FU, cause, raddr);
> +}
> +
>  static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
>                                 uint32_t sprn, uint32_t cause,
>                                 uintptr_t raddr)
> @@ -55,6 +66,17 @@ static void raise_fu_exception(CPUPPCState *env, uint3=
2_t bit,
>  }
>  #endif
> =20
> +void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
> +                                 uint32_t sprn, uint32_t cause)
> +{
> +#ifdef TARGET_PPC64
> +    if ((env->msr_mask & MSR_HVB) && !msr_hv &&
> +                                     !(env->spr[SPR_HFSCR] & (1UL << bit=
))) {
> +        raise_hv_fu_exception(env, bit, sprn, cause, GETPC());
> +    }
> +#endif
> +}
> +
>  void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
>                                  uint32_t sprn, uint32_t cause)
>  {
> @@ -108,6 +130,8 @@ void helper_store_pcr(CPUPPCState *env, target_ulong =
value)
> =20
>  target_ulong helper_load_dpdes(CPUPPCState *env)
>  {
> +    helper_hfscr_facility_check(env, HFSCR_MSGP, SPR_DPDES,
> +                                HFSCR_IC_MSGP);
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
>          return 1;
>      }
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index ba759ab2bb0f..e9e70ca149fd 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6652,6 +6652,8 @@ static void gen_msgclrp(DisasContext *ctx)
>      GEN_PRIV;
>  #else
>      CHK_SV;
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, 0,
> +                             HFSCR_IC_MSGP);
>      gen_helper_book3s_msgclrp(cpu_env, cpu_gpr[rB(ctx->opcode)]);

Calling a helper for the facility check, then another helper for the
actual instruction is a bit yucky.  I'd prefer if you either call out
for the facility check within the instruction helper, or generate the
instructions necessary for the HFSCR check

>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> @@ -6662,6 +6664,8 @@ static void gen_msgsndp(DisasContext *ctx)
>      GEN_PRIV;
>  #else
>      CHK_SV;
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, 0,
> +                             HFSCR_IC_MSGP);
>      gen_helper_book3s_msgsndp(cpu_gpr[rB(ctx->opcode)]);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 7c74a763ba66..154e01451270 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -468,11 +468,15 @@ static void spr_write_pcr(DisasContext *ctx, int sp=
rn, int gprn)
>  /* DPDES */
>  static void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
>  {
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, sprn,
> +                             HFSCR_IC_MSGP);
>      gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
>  }
> =20
>  static void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
>  {
> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, sprn,
> +                             HFSCR_IC_MSGP);
>      gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
>  }
>  #endif
> @@ -7523,6 +7527,20 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
>  #define POWERPC970_HID5_INIT 0x00000000
>  #endif
> =20
> +void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, int =
bit,
> +                              int sprn, int cause)
> +{
> +    TCGv_i32 t1 =3D tcg_const_i32(bit);
> +    TCGv_i32 t2 =3D tcg_const_i32(sprn);
> +    TCGv_i32 t3 =3D tcg_const_i32(cause);
> +
> +    gen_helper_hfscr_facility_check(cpu_env, t1, t2, t3);
> +
> +    tcg_temp_free_i32(t3);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +}
> +
>  static void gen_fscr_facility_check(DisasContext *ctx, int facility_sprn,
>                                      int bit, int sprn, int cause)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl37BswACgkQbDjKyiDZ
s5LM0BAAu56MZvBonhUOqpQH268MovmQSQKc4MniJjp1nRP5S8KF4luVTl6kPfVf
GHromd5DZI+P8YtC8xfATm1+sKH9ZBR5gDZDN1/AXsS3DiJNKCx5aoedSrtx4uWa
nVsxJks97biixVgQjqx7YMB4EpfWYF04rEDKIYI8DL+qT2EAxCiaBHKUIRlo0cQj
qfXz2w1RACjz3h+8my/9wMm+IzZjagxut95CAO1NQZT7UEnnsMRlUA1I4JSc1hVb
Rs5S/vPkYpFYkHPnNXB0Tf0cKTVrPguE07BFNwY0HD446i2FQFyNCCYN9fAjSOmb
HfVzouS5M0KrRXgRug3gXAFJl7W9Oh/BXH3TleUMJC7YVz5ZSM2V0NKejqd0QDAw
Z2TPpWPEhwN84TdmDesWkjxkJ6ru5RFVTjTjCF203hupGrd64aJadE6/kdWN/JuT
s2GnY/V4tztBilYqEFo/CGA70ObNHSh0HGMJW0qmDuHrk1qQjEAyarvkwbZpsb1V
svQI8blXJgP9OM3yD+l2vPEUt5sxWcI1WQ0WsXg70AXbBP2iGr0WSqKOHwQ+fq+v
2ikfZrCA3AHWwusIE8Axhd7ZVCb9ETkezvfezkwMmcTOapOUM9zVWuq+0n4gqN+l
2QO2BVcoq8ZAhZAle80HgMaPKmx2F06lOqbUfDHdvJdyeMS4ImA=
=Sb5v
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--

