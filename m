Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1826C2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB272076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dx86GYpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB272076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGYS-0005XC-Qz
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXK-0003lD-Gp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXJ-0002Gu-31
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:18 -0400
Received: from ozlabs.org ([203.11.71.1]:54943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXI-0002AS-1R; Wed, 25 Mar 2020 20:38:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL76mMmz9sSH; Thu, 26 Mar 2020 11:38:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183087;
 bh=ilbV9GRT83huIkl+WgcxEwyHha4OUY99OsNNhg4GV9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dx86GYpcZEvqha2U/7V7S9dtLxPa8SCWxm7tBDBmVj1bQfRstwG9UOpE0wAE3cH6P
 vq7pos8Jc9edmdjcxZspfh+pyGH1PMFmdAy08bIxLOmuRp6HRMlguSZs/GzhSjyMxc
 mcHXOnce11np01M4JXJk3zCgAjYpjCwgN8KNmb5U=
Date: Thu, 26 Mar 2020 11:04:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] ppc/spapr: tweak change system reset helper
Message-ID: <20200326000433.GI36889@umbus.fritz.box>
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline
In-Reply-To: <20200325144147.221875-2-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:41:43AM +1000, Nicholas Piggin wrote:
> Rather than have the helper take an optional vector address
> override, instead have its caller modify env->nip itself.
> This is more consistent when adding pnv nmi support, and also
> with mce injection added later.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.1.

> ---
>  hw/ppc/spapr.c           | 9 ++++++---
>  target/ppc/cpu.h         | 2 +-
>  target/ppc/excp_helper.c | 5 +----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9a2bd501aa..785c41d205 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3385,13 +3385,13 @@ static void spapr_machine_finalizefn(Object *obj)
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> =20
>      cpu_synchronize_state(cs);
>      /* If FWNMI is inactive, addr will be -1, which will deliver to 0x10=
0 */
>      if (spapr->fwnmi_system_reset_addr !=3D -1) {
>          uint64_t rtas_addr, addr;
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        CPUPPCState *env =3D &cpu->env;
> =20
>          /* get rtas addr from fdt */
>          rtas_addr =3D spapr_get_rtas_addr();
> @@ -3405,7 +3405,10 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, ru=
n_on_cpu_data arg)
>          stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
>          env->gpr[3] =3D addr;
>      }
> -    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
> +    ppc_cpu_do_system_reset(cs);
> +    if (spapr->fwnmi_system_reset_addr !=3D -1) {
> +        env->nip =3D spapr->fwnmi_system_reset_addr;
> +    }
>  }
> =20
>  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 88d9449555..f4a5304d43 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunctio=
n f, CPUState *cs,
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
> -void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
> +void ppc_cpu_do_system_reset(CPUState *cs);
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
>  extern const VMStateDescription vmstate_ppc_cpu;
>  #endif
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 08bc885ca6..7f2b5899d3 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -961,15 +961,12 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>      }
>  }
> =20
> -void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
> +void ppc_cpu_do_system_reset(CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
>      powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
> -    if (vector !=3D -1) {
> -        env->nip =3D vector;
> -    }
>  }
> =20
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl578ZEACgkQbDjKyiDZ
s5IINxAAxn5TPpdShzGdwnFObS47re/Unr3KOldeVLszZ63/pUXI1wUNNl/ABHCM
xUfJGg9NQwLlbl5nRRc1oacpcZE6QaUUSlAl6bvqHEMgc2N5hGoaXNPEK1s7BPe8
Nqhf5+vfXWcRFZ3o2I3DUmo2FGWLsCxUHo74JsVi8lfd5Uz21LESylMf0VuROJw2
AP5iEOygmIpM5UrbKwqwnLnODHbioGtAGQEYQjt9DgLJ+KS/X9NhGe5fEHUEAmUA
+7yzjuXzbJfXwBzBoq6RZeJbzyyg4TfG3hqDBgWkp8sJhBiWAM4YGwX+mHo+s+J+
tJOWWcxsdyIghKCBsXhpJwQy9VsVhzPcQSQ7V+L41JsIP0nf2lRVB/8CfLfmzPQO
otILA7eTgVvCkIywhmyAsNYf443/hbuuKP2yMje8EaLXtuwvP+00VAL7fhX/dVSF
02oloOPv6jXQwxU/0wMTVot98+UpCs9UNA01Xl8ji733W5F/k/szUBfU238boWwc
obXPMQvNQ3dOMi1gpILxROA8uFXMJ/MXj4GLr0j5ErxfpOxgI0jedUoBjuFjVEx0
FG0hhlASu72iVXWxo4CAq8tFhJF04IyUISTOyul8uDa1qZ4+EcuJc8QSQLTeFSNt
LCMD0/Q/3aW01i4m/W0Ypdjnca67pDr7cjWtm5I19Vyryshb9b4=
=MBDB
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--

