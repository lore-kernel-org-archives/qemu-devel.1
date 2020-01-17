Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F6C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673452072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p+GrWfHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673452072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQme-0004v1-Gu
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1isQiM-0007oz-7o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1isQiI-0005tE-Oc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:27:02 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46239 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1isQiI-0005pk-Bf; Fri, 17 Jan 2020 07:26:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47zgKh6Czbz9sSG; Fri, 17 Jan 2020 23:26:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579264008;
 bh=AV/XFHAKzlcjBi0YeDugcEbtRP+e4Z2KTqWK0MgpuPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p+GrWfHALeRqo6p71eHm2hxCmOPpVOL5Cm4pd5Kx+QFYzDtVtM+cI4J9pPIsyWR0X
 a2CtMjXWa1JpOrtgs4aeVPquZXjrcCzcHNDdjc9kQusvztceyyQdbZCT0S9eEgIAZ5
 eu0S22U40ruemR1l8mrtGgwkCV7cEe46OACGKhDI=
Date: Fri, 17 Jan 2020 19:49:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/2] target/ppc: add support for Hypervisor Facility
 Unavailable Exception
Message-ID: <20200117094943.GB54439@umbus>
References: <20200109163346.23062-1-clg@kaod.org>
 <20200109163346.23062-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vgqGEEhIUeLzQgKp"
Content-Disposition: inline
In-Reply-To: <20200109163346.23062-3-clg@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--vgqGEEhIUeLzQgKp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 05:33:46PM +0100, C=E9dric Le Goater wrote:
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
>  target/ppc/cpu.h         |  6 ++++++
>  target/ppc/excp_helper.c | 13 +++++++++++++
>  target/ppc/misc_helper.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d175ec9a641d..1ff6afbccdb2 100644
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
> @@ -1332,6 +1336,8 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp);
>  #endif
> =20
>  void store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask);
> +void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
> +                                 const char *caller, uint32_t cause);
> =20
>  static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
>  {
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 343f3a6b30c4..3887f8888c6c 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -471,6 +471,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
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
> @@ -1287,6 +1296,8 @@ void helper_book3s_msgclrp(CPUPPCState *env, target=
_ulong rb)
>  {
>      int irq =3D book3s_dbell2irq(rb, false);
> =20
> +    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSG=
P);
> +
>      if (irq < 0) {
>          return;
>      }
> @@ -1303,6 +1314,8 @@ void helper_book3s_msgsndp(CPUPPCState *env, target=
_ulong rb)
>      int irq =3D book3s_dbell2irq(rb, false);
>      int pir =3D env->spr_cb[SPR_PIR].default_value;
> =20
> +    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSG=
P);
> +
>      if (irq < 0) {
>          return;
>      }
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 66b5b0824208..2ff6bed10228 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -41,6 +41,18 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t =
sprn)
>  }
> =20
>  #ifdef TARGET_PPC64
> +static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
> +                                  const char *caller, uint32_t cause,
> +                                  uintptr_t raddr)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "HV Facility %d is unavailable (%s)\n=
",
> +                  bit, caller);

If we're using pnv and the emulated hypervisor is using HFSCR for
trap-and-emulate or lazy loading or something, then an HV_FU trap
doesn't necessarily indicate an error in the guest, so I'm not sure
that's the right log mask.  Maybe just a trace event here?

> +    env->spr[SPR_HFSCR] &=3D ~((target_ulong)FSCR_IC_MASK << FSCR_IC_POS=
);
> +
> +    raise_exception_err_ra(env, POWERPC_EXCP_HV_FU, cause, raddr);
> +}
> +
>  static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
>                                 uint32_t sprn, uint32_t cause,
>                                 uintptr_t raddr)
> @@ -55,6 +67,17 @@ static void raise_fu_exception(CPUPPCState *env, uint3=
2_t bit,
>  }
>  #endif
> =20
> +void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
> +                                 const char *caller, uint32_t cause)
> +{
> +#ifdef TARGET_PPC64
> +    if ((env->msr_mask & MSR_HVB) && !msr_hv &&
> +                                     !(env->spr[SPR_HFSCR] & (1UL << bit=
))) {
> +        raise_hv_fu_exception(env, bit, caller, cause, GETPC());
> +    }
> +#endif
> +}
> +
>  void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
>                                  uint32_t sprn, uint32_t cause)
>  {
> @@ -114,6 +137,8 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
>  {
>      target_ulong dpdes =3D 0;
> =20
> +    helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_=
MSGP);
> +
>      /* TODO: TCG supports only one thread */
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
>          dpdes |=3D (env->spr_cb[SPR_PIR].default_value & DBELL_TIRTAG_MA=
SK);
> @@ -127,6 +152,8 @@ void helper_store_dpdes(CPUPPCState *env, target_ulon=
g val)
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      CPUState *cs =3D CPU(cpu);
> =20
> +    helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC=
_MSGP);
> +
>      /* TODO: TCG supports only one thread */
>      if (val & ~0x1) {
>          qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vgqGEEhIUeLzQgKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4hgzYACgkQbDjKyiDZ
s5IMnhAAuqRmJH5OCnORISuiQhOV3ni5uGcKXriEEoGEw5FN+cR7mtD5PzS+xvbZ
m9P6FeqhvNWLlkaWCNtXLzETwlhQzZnXXIi7QCUSNSrT4xXiPK51HwJ6EPP+pkSN
U7BrU2Gtd67CHyblpZBejMoBGqU4DAUqVRh1OZRir2VyT7JZLUAY1NqCqIdDaakS
a5KbnL96BfX0NLlSmfbPvShjuRaARrm5q5YO9R4MgkXkqhVAmrMTO12h1WyTdKqt
I8FbzJuUBpeLI0qjP6rS79aYOyxAt2Iapis+MrOL7G7fobzHrRuORq3goO//1nn0
WiN2B6bwrqHwFRa9TKWV2qf9IfcOJTI8Qs2ol4J3OasEKTeZUqVSQi+0yP5Joerr
E4iozHa2F1NdiCWfgBxgpX0p0D/5LaY5gBFbzwTBqpsFn6qnvsZBslvfokOOAuuo
bvlG2Q5OLICq6NDFnF5OSbBwa3hUDoArI/aQExSo6J/ChabMexa9wq7c2kDo/KEY
1S05WnSM+ne7zwJzXCtXkC7mVnyMjafHutOpankPiahQgDaXh+9LoIboaZ+dDYa2
YZ4DdibiKv9mXd6WyC1EDM4hfwCTEWq3b0n8rss+mAPQAtjBJqBTXq0JJ4p/EQVC
iNvtEqOuxq4x7iFDWzqXR6l1q49tPzD/oqFACAEfjGiJQ1qVv4U=
=7iUS
-----END PGP SIGNATURE-----

--vgqGEEhIUeLzQgKp--

