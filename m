Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0CC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 23:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7507D2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 23:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j6We26hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7507D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir8p0-0001Pe-Jq
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 18:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ir8oC-0000Xa-E9
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 18:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ir8oA-0002Zf-7I
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 18:07:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46969 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ir8o9-0002Vf-Bk; Mon, 13 Jan 2020 18:07:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47xTks5KB7z9sNx; Tue, 14 Jan 2020 10:07:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578956853;
 bh=JcK5Bs0GcpE4DVjs9u4MvLkZBbNN69JWlfX40ombs20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j6We26hhzdmExrXnQ+MV6gcPA3kPAohoNty0SYapWOji4rfd53CYQYebu8MLX6ZVp
 IpsBmVqP/vNJ6Ziv+R1LdaJZZeqPPm8mgCjX+Hc+lhFXkkw+TMpWriQV6jos17WB0E
 JzPqvq7/H3sDmRSFZLGLROLySLj7OnwiufunzKlQ=
Date: Tue, 14 Jan 2020 09:07:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 6/7] target/ppc: add support for Hypervisor Facility
 Unavailable Exception
Message-ID: <20200113230722.GH19995@umbus>
References: <20191128134700.16091-1-clg@kaod.org>
 <20191128134700.16091-7-clg@kaod.org>
 <20191219051246.GF2321@umbus.fritz.box>
 <6673b3eb-9dad-5e55-2013-d5edfde718d9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <6673b3eb-9dad-5e55-2013-d5edfde718d9@kaod.org>
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


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Jan 08, 2020 at 04:36:50PM +0100, C=E9dric Le Goater wrote:
> On 12/19/19 6:12 AM, David Gibson wrote:
> > On Thu, Nov 28, 2019 at 02:46:59PM +0100, C=E9dric Le Goater wrote:
> >> The privileged message send and clear instructions (msgsndp & msgclrp)
> >> are privileged, but will generate a hypervisor facility unavailable
> >> exception if not enabled in the HFSCR and executed in privileged
> >> non-hypervisor state.
> >>
> >> Add checks when accessing the DPDES register and when using the
> >> msgsndp and msgclrp isntructions.
> >>
> >> Based on previous work from Suraj Jitindar Singh.
> >>
> >> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  target/ppc/cpu.h                |  6 ++++++
> >>  target/ppc/helper.h             |  1 +
> >>  target/ppc/excp_helper.c        |  9 +++++++++
> >>  target/ppc/misc_helper.c        | 24 ++++++++++++++++++++++++
> >>  target/ppc/translate.c          |  4 ++++
> >>  target/ppc/translate_init.inc.c | 18 ++++++++++++++++++
> >>  6 files changed, 62 insertions(+)
> >>
> >> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >> index 8ffcfa0ea162..52608dfe6ff4 100644
> >> --- a/target/ppc/cpu.h
> >> +++ b/target/ppc/cpu.h
> >> @@ -397,6 +397,10 @@ typedef struct ppc_v3_pate_t {
> >>  #define PSSCR_ESL         PPC_BIT(42) /* Enable State Loss */
> >>  #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
> >> =20
> >> +/* HFSCR bits */
> >> +#define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilit=
ies */
> >> +#define HFSCR_IC_MSGP  0xA
> >> +
> >>  #define msr_sf   ((env->msr >> MSR_SF)   & 1)
> >>  #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
> >>  #define msr_shv  ((env->msr >> MSR_SHV)  & 1)
> >> @@ -1333,6 +1337,8 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp);
> >>  #endif
> >> =20
> >>  void store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask);
> >> +void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, i=
nt bit,
> >> +                              int sprn, int cause);
> >> =20
> >>  static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
> >>  {
> >> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> >> index 76518a1df6f0..14c9a30a45c9 100644
> >> --- a/target/ppc/helper.h
> >> +++ b/target/ppc/helper.h
> >> @@ -643,6 +643,7 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
> >> =20
> >>  DEF_HELPER_2(load_dump_spr, void, env, i32)
> >>  DEF_HELPER_2(store_dump_spr, void, env, i32)
> >> +DEF_HELPER_4(hfscr_facility_check, void, env, i32, i32, i32)
> >>  DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
> >>  DEF_HELPER_4(msr_facility_check, void, env, i32, i32, i32)
> >>  DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
> >> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> >> index 5a247945e97f..17dad626b74e 100644
> >> --- a/target/ppc/excp_helper.c
> >> +++ b/target/ppc/excp_helper.c
> >> @@ -469,6 +469,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, =
int excp_model, int excp)
> >>      case POWERPC_EXCP_FU:         /* Facility unavailable exception  =
        */
> >>  #ifdef TARGET_PPC64
> >>          env->spr[SPR_FSCR] |=3D ((target_ulong)env->error_code << 56);
> >> +#endif
> >> +        break;
> >> +    case POWERPC_EXCP_HV_FU:     /* Hypervisor Facility Unavailable E=
xception */
> >> +#ifdef TARGET_PPC64
> >> +        env->spr[SPR_HFSCR] |=3D ((target_ulong)env->error_code << FS=
CR_IC_POS);
> >> +        srr0 =3D SPR_HSRR0;
> >> +        srr1 =3D SPR_HSRR1;
> >> +        new_msr |=3D (target_ulong)MSR_HVB;
> >> +        new_msr |=3D env->msr & ((target_ulong)1 << MSR_RI);
> >>  #endif
> >>          break;
> >>      case POWERPC_EXCP_PIT:       /* Programmable interval timer inter=
rupt    */
> >> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> >> index a0e7bd9c32d3..0cd44c6edd82 100644
> >> --- a/target/ppc/misc_helper.c
> >> +++ b/target/ppc/misc_helper.c
> >> @@ -41,6 +41,17 @@ void helper_store_dump_spr(CPUPPCState *env, uint32=
_t sprn)
> >>  }
> >> =20
> >>  #ifdef TARGET_PPC64
> >> +static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
> >> +                                  uint32_t sprn, uint32_t cause,
> >> +                                  uintptr_t raddr)
> >> +{
> >> +    qemu_log("Facility SPR %d is unavailable (SPR HFSCR:%d)\n", sprn,=
 bit);
> >=20
> > That looks overly verbose.  Leftover debugging?
>=20
> No. It's inherited from raise_fu_exception(). Should we remove them ?
> or use mask CPU_LOG_INT ?

Ah.  We sohuld definitely add a mask.  CPU_LOG_INT sounds like the
right one.

> >> +    env->spr[SPR_HFSCR] &=3D ~((target_ulong)FSCR_IC_MASK << FSCR_IC_=
POS);
> >> +
> >> +    raise_exception_err_ra(env, POWERPC_EXCP_HV_FU, cause, raddr);
> >> +}
> >> +
> >>  static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
> >>                                 uint32_t sprn, uint32_t cause,
> >>                                 uintptr_t raddr)
> >> @@ -55,6 +66,17 @@ static void raise_fu_exception(CPUPPCState *env, ui=
nt32_t bit,
> >>  }
> >>  #endif
> >> =20
> >> +void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
> >> +                                 uint32_t sprn, uint32_t cause)
> >> +{
> >> +#ifdef TARGET_PPC64
> >> +    if ((env->msr_mask & MSR_HVB) && !msr_hv &&
> >> +                                     !(env->spr[SPR_HFSCR] & (1UL << =
bit))) {
> >> +        raise_hv_fu_exception(env, bit, sprn, cause, GETPC());
> >> +    }
> >> +#endif
> >> +}
> >> +
> >>  void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
> >>                                  uint32_t sprn, uint32_t cause)
> >>  {
> >> @@ -108,6 +130,8 @@ void helper_store_pcr(CPUPPCState *env, target_ulo=
ng value)
> >> =20
> >>  target_ulong helper_load_dpdes(CPUPPCState *env)
> >>  {
> >> +    helper_hfscr_facility_check(env, HFSCR_MSGP, SPR_DPDES,
> >> +                                HFSCR_IC_MSGP);
> >>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
> >>          return 1;
> >>      }
> >> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> >> index ba759ab2bb0f..e9e70ca149fd 100644
> >> --- a/target/ppc/translate.c
> >> +++ b/target/ppc/translate.c
> >> @@ -6652,6 +6652,8 @@ static void gen_msgclrp(DisasContext *ctx)
> >>      GEN_PRIV;
> >>  #else
> >>      CHK_SV;
> >> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, 0,
> >> +                             HFSCR_IC_MSGP);
> >>      gen_helper_book3s_msgclrp(cpu_env, cpu_gpr[rB(ctx->opcode)]);
> >=20
> > Calling a helper for the facility check, then another helper for the
> > actual instruction is a bit yucky.  I'd prefer if you either call out
> > for the facility check within the instruction helper, or generate the
> > instructions necessary for the HFSCR check
>=20
> OK. I will take a look.=20
>=20
> C.
>=20
> >=20
> >>  #endif /* defined(CONFIG_USER_ONLY) */
> >>  }
> >> @@ -6662,6 +6664,8 @@ static void gen_msgsndp(DisasContext *ctx)
> >>      GEN_PRIV;
> >>  #else
> >>      CHK_SV;
> >> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, 0,
> >> +                             HFSCR_IC_MSGP);
> >>      gen_helper_book3s_msgsndp(cpu_gpr[rB(ctx->opcode)]);
> >>  #endif /* defined(CONFIG_USER_ONLY) */
> >>  }
> >> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_in=
it.inc.c
> >> index 7c74a763ba66..154e01451270 100644
> >> --- a/target/ppc/translate_init.inc.c
> >> +++ b/target/ppc/translate_init.inc.c
> >> @@ -468,11 +468,15 @@ static void spr_write_pcr(DisasContext *ctx, int=
 sprn, int gprn)
> >>  /* DPDES */
> >>  static void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
> >>  {
> >> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, sprn,
> >> +                             HFSCR_IC_MSGP);
> >>      gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
> >>  }
> >> =20
> >>  static void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
> >>  {
> >> +    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGP, sprn,
> >> +                             HFSCR_IC_MSGP);
> >>      gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
> >>  }
> >>  #endif
> >> @@ -7523,6 +7527,20 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *dat=
a)
> >>  #define POWERPC970_HID5_INIT 0x00000000
> >>  #endif
> >> =20
> >> +void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, i=
nt bit,
> >> +                              int sprn, int cause)
> >> +{
> >> +    TCGv_i32 t1 =3D tcg_const_i32(bit);
> >> +    TCGv_i32 t2 =3D tcg_const_i32(sprn);
> >> +    TCGv_i32 t3 =3D tcg_const_i32(cause);
> >> +
> >> +    gen_helper_hfscr_facility_check(cpu_env, t1, t2, t3);
> >> +
> >> +    tcg_temp_free_i32(t3);
> >> +    tcg_temp_free_i32(t2);
> >> +    tcg_temp_free_i32(t1);
> >> +}
> >> +
> >>  static void gen_fscr_facility_check(DisasContext *ctx, int facility_s=
prn,
> >>                                      int bit, int sprn, int cause)
> >>  {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4c+CYACgkQbDjKyiDZ
s5I9Aw//fTE6D5HqFnnF/RB8lOcsGqfDXO7tJhnRVbEgvbmJYM8xWPDtU97kZLPG
4oIdn+4SzVawCTl+HZ2ldsk+HUKLYvLyDbOvF5kZlbh2YPHrhFdWFg0lsEKnwnLQ
GyyR0C3+Y5BB8xo/RSu/pLlQASH9r9AZqDwHCi/joX3D8Xrt5yPprcgul8h1oC7c
qrO3AjyYnPgaQHXROmPau+NFWsxDai4tyvHw3rhKVJRDfBAlKU6v6QSq7QxHzTad
cUSt8Iau0NO1bU8cvAptGQiHj2ly3bnbnjQYK4BrdV+F26kEkE8tW5YXIqlyRKNC
7LL1d8lE4qCI4tlCVjQY1LRrwtniedrI4RIKTZmdrQlQXuq3gAirUhMKoECyUQZA
X5ZfZ2OWlbfRw4yJlgnlML/ohbn92Tl3nsjdjGeb9JQhQDSYIpuHf4u9tVDutQTa
d7eWFNBIs29w83SnEcrR1+utEPGMsduW2b+Iy6FshTM8/Rrq2X4d8auZfRGS1M5G
ReJsg+WOkvLs1SMfArb3pXkS36Pw/jbZUjdL2TyRL8+KlAkssQobJKN6DEBUFUYx
ScJlCusVELKaYwvpgc4e2LNRgh8u+Ak1h1w4d77eLkMPtum1vmkLjZiG2GGMyEGh
GtXQ0Bb5c5ZKeb+txF+EM3l/LT/7zrtegZD6JOHFpqEP+839mr8=
=oJiM
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

