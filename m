Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D79CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E14B2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UjUj1sg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E14B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2o3S-0006xs-Ug
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 22:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1i-0005D0-9U
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1g-00073p-TO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41331 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2o1f-0006zv-OX; Tue, 27 Aug 2019 22:49:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46J9F44XzPz9sBp; Wed, 28 Aug 2019 12:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566960568;
 bh=xpgSvcOIDkGTfDo+00WDn/TOlXQYtIofgm0w6Qc4Ijk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UjUj1sg8Er5ux7HHD1pWbiSB1j6XWDJGinSHXOkFukTNr7X1w1RvScvOR5c82c20C
 EtzlJniebCJ87WuZmvK3Dr5zN96bCcbfNGSqS8YdiyOjITYspGo3TgE+PUoX2o5V4T
 +gURtJbohrb9zWJ9vnz/RbS+Fujpd2LxbG9jGho4=
Date: Wed, 28 Aug 2019 11:00:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190828010032.GC16825@umbus.fritz.box>
References: <20190827045751.22123-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20190827045751.22123-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V4] powerpc/spapr: Add host
 threads parameter to ibm, get_system_parameter
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


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 02:57:51PM +1000, Suraj Jitindar Singh wrote:
> The ibm,get_system_parameter rtas call is used by the guest to retrieve
> data relating to certain parameters of the system. The SPLPAR
> characteristics option (token 20) is used to determine characteristics of
> the environment in which the lpar will run.
>=20
> It may be useful for a guest to know the number of physical host threads
> present on the underlying system where it is being run. Add the
> characteristic "HostThrs" to the SPLPAR Characteristics
> ibm,get_system_parameter rtas call to expose this information to a
> guest. Add a n_host_threads property to the processor class which is
> then used to retrieve this information and define it for POWER8 and
> POWER9. Other processors will default to 0 and the charateristic won't
> be added.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied, thanks.

>=20
> ---
>=20
> V1 -> V2:
> - Take into account that the core may be operating in split core mode
>   meaning a single core may be split into multiple subcores.
> V2 -> V3:
> - Add curly braces for single line if statements
> V3 -> V4;
> - Add a host threads property to the processor class and use this to
>   derive the information rather than the device tree.
> ---
>  hw/ppc/spapr_rtas.c             | 15 +++++++++++++++
>  target/ppc/cpu-qom.h            |  1 +
>  target/ppc/translate_init.inc.c |  2 ++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 526b489297..bee3835214 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -266,6 +266,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
>                                            target_ulong args,
>                                            uint32_t nret, target_ulong re=
ts)
>  {
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      unsigned int max_cpus =3D ms->smp.max_cpus;
>      target_ulong parameter =3D rtas_ld(args, 0);
> @@ -283,6 +284,20 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU=
 *cpu,
>                                            current_machine->ram_size / Mi=
B,
>                                            ms->smp.cpus,
>                                            max_cpus);
> +        if (pcc->n_host_threads > 0) {
> +            char *hostthr_val, *old =3D param_val;
> +
> +            /*
> +             * Add HostThrs property. This property is not present in PA=
PR but
> +             * is expected by some guests to communicate the number of p=
hysical
> +             * host threads per core on the system so that they can scale
> +             * information which varies based on the thread configuratio=
n.
> +             */
> +            hostthr_val =3D g_strdup_printf(",HostThrs=3D%d", pcc->n_hos=
t_threads);
> +            param_val =3D g_strconcat(param_val, hostthr_val, NULL);
> +            g_free(hostthr_val);
> +            g_free(old);
> +        }
>          ret =3D sysparm_st(buffer, length, param_val, strlen(param_val) =
+ 1);
>          g_free(param_val);
>          break;
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 7ffdb0a706..e499575dc8 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -191,6 +191,7 @@ typedef struct PowerPCCPUClass {
>      const PPCHash64Options *hash64_opts;
>      struct ppc_radix_page_info *radix_page_info;
>      uint32_t lrg_decr_bits;
> +    int n_host_threads;
>      void (*init_proc)(CPUPPCState *env);
>      int  (*check_pow)(CPUPPCState *env);
>      int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int m=
mu_idx);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 4a21ed7289..41f77b7ef8 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8770,6 +8770,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
>      pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
>      pcc->lrg_decr_bits =3D 32;
> +    pcc->n_host_threads =3D 8;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_POWER8;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
> @@ -8981,6 +8982,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
>      pcc->radix_page_info =3D &POWER9_radix_page_info;
>      pcc->lrg_decr_bits =3D 56;
> +    pcc->n_host_threads =3D 4;
>  #endif
>      pcc->excp_model =3D POWERPC_EXCP_POWER9;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1l0i0ACgkQbDjKyiDZ
s5LebhAAsSzSkdad5/49Th7KTiqHSqbhpA12+GF3LjUCkKMTjDBeWKEbcpu6iDdZ
tpRJ+1sbuKva36hMdk57BFx7gQH3uK0RObR6knzKsYzHJxfRH+6rgAV2teiEnwNf
rjFJzZKtlYVPI/Tjf8nKYPqh1/pgL8zCajLpN6AY79iPPen2X6kiiLaU3qG2wx/r
abW454gcOwsmecBbCAV8si3rhlqDQMcYn+JbxaT2DSLobueq5PCodOEYIIUDYmVW
K1MXehqjDtClGeEXIl1R9S37vD1IFQWWaa2rejWCRorV8ezhP/yDUD8dZoMBPGTp
X+5Ke8XUtsWQl/+E0qFQ8ro5Bb9l0wOAKPiobyQ8T020abkrevPlMt3oTklsqYiG
SMoAwF3vw6iLMoLwm46HwLte1KmoxLLm/uOPpaLi7kN1NXoEJaSE4WSfy0SxEz6N
gaUKCXGJFn8bDvkGXZbyLZbpz1l0MrPRQh3LeN529OLzLxEQmkNLGVCW8jlK3Vdz
iSbPgeNtNk8lrQ+uJbbXJwPTo3/FfnTT7d4R88LtvpuWiOfqfy2hHCRkYaIJZiH8
v1CJDz8g60rAmOoiyyaYf/pci6R+SvIcws/ZzGraqQugce7pIW3VCwq2ANw4SUyX
/djqXgDz1fVGvsa927gWqO+0KfkkyiQtCAuoo0x3X34taxBavgM=
=b0Cg
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--

