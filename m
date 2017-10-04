Received: from eggs.gnu.org ([2001:4830:134:3::10]:51569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzY5Q-0001Y0-1D
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzY5O-0002Il-3e
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:02:56 -0400
Date: Wed, 4 Oct 2017 11:00:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004000022.GO3260@umbus.fritz.box>
References: <1507025644-5972-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V7BlxAaPrdhzdIM1"
Content-Disposition: inline
In-Reply-To: <1507025644-5972-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Remove unused PPC 460 and 460F
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--V7BlxAaPrdhzdIM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 12:14:04PM +0200, Thomas Huth wrote:
> We don't have any 460 or 460F CPUs in QEMU, so the init functions
> are just dead code. Let's simply remove them (translate_init.c
> is already big enough without them).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.11, thanks.

> ---
>  target/ppc/translate_init.c | 217 --------------------------------------=
------
>  1 file changed, 217 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c6399a3..0d6379f 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -4176,223 +4176,6 @@ POWERPC_FAMILY(440x5wDFPU)(ObjectClass *oc, void =
*data)
>                   POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
>  }
> =20
> -static void init_proc_460 (CPUPPCState *env)
> -{
> -    /* Time base */
> -    gen_tbl(env);
> -    gen_spr_BookE(env, 0x000000000000FFFFULL);
> -    gen_spr_440(env);
> -    gen_spr_usprgh(env);
> -    /* Processor identification */
> -    spr_register(env, SPR_BOOKE_PIR, "PIR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_pir,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_DVC1, "DVC1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_DVC2, "DVC2",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_MCSR, "MCSR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register(env, SPR_BOOKE_MCSRR1, "MCSRR1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_440_CCR1, "CCR1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_DCRIPR, "SPR_DCRIPR",
> -                 &spr_read_generic, &spr_write_generic,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* Memory management */
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->id_tlbs =3D 0;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> -    init_excp_BookE(env);
> -    env->dcache_line_size =3D 32;
> -    env->icache_line_size =3D 32;
> -    /* XXX: TODO: allocate internal IRQ controller */
> -
> -    SET_FIT_PERIOD(12, 16, 20, 24);
> -    SET_WDT_PERIOD(20, 24, 28, 32);
> -}
> -
> -POWERPC_FAMILY(460)(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> -
> -    dc->desc =3D "PowerPC 460 (guessed)";
> -    pcc->init_proc =3D init_proc_460;
> -    pcc->check_pow =3D check_pow_nocheck;
> -    pcc->insns_flags =3D PPC_INSNS_BASE | PPC_STRING |
> -                       PPC_DCR | PPC_DCRX  | PPC_DCRUX |
> -                       PPC_WRTEE | PPC_MFAPIDI | PPC_MFTB |
> -                       PPC_CACHE | PPC_CACHE_ICBI |
> -                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
> -                       PPC_MEM_TLBSYNC | PPC_TLBIVA |
> -                       PPC_BOOKE | PPC_4xx_COMMON | PPC_405_MAC |
> -                       PPC_440_SPEC;
> -    pcc->msr_mask =3D (1ull << MSR_POW) |
> -                    (1ull << MSR_CE) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_DWE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_FE1) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR);
> -    pcc->mmu_model =3D POWERPC_MMU_BOOKE;
> -    pcc->excp_model =3D POWERPC_EXCP_BOOKE;
> -    pcc->bus_model =3D PPC_FLAGS_INPUT_BookE;
> -    pcc->bfd_mach =3D bfd_mach_ppc_403;
> -    pcc->flags =3D POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
> -                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
> -}
> -
> -static void init_proc_460F(CPUPPCState *env)
> -{
> -    /* Time base */
> -    gen_tbl(env);
> -    gen_spr_BookE(env, 0x000000000000FFFFULL);
> -    gen_spr_440(env);
> -    gen_spr_usprgh(env);
> -    /* Processor identification */
> -    spr_register(env, SPR_BOOKE_PIR, "PIR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_pir,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_DVC1, "DVC1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_DVC2, "DVC2",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_BOOKE_MCSR, "MCSR",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register(env, SPR_BOOKE_MCSRR1, "MCSRR1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_440_CCR1, "CCR1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* XXX : not implemented */
> -    spr_register(env, SPR_DCRIPR, "SPR_DCRIPR",
> -                 &spr_read_generic, &spr_write_generic,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    /* Memory management */
> -#if !defined(CONFIG_USER_ONLY)
> -    env->nb_tlb =3D 64;
> -    env->nb_ways =3D 1;
> -    env->id_tlbs =3D 0;
> -    env->tlb_type =3D TLB_EMB;
> -#endif
> -    init_excp_BookE(env);
> -    env->dcache_line_size =3D 32;
> -    env->icache_line_size =3D 32;
> -    /* XXX: TODO: allocate internal IRQ controller */
> -
> -    SET_FIT_PERIOD(12, 16, 20, 24);
> -    SET_WDT_PERIOD(20, 24, 28, 32);
> -}
> -
> -POWERPC_FAMILY(460F)(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> -
> -    dc->desc =3D "PowerPC 460F (guessed)";
> -    pcc->init_proc =3D init_proc_460F;
> -    pcc->check_pow =3D check_pow_nocheck;
> -    pcc->insns_flags =3D PPC_INSNS_BASE | PPC_STRING |
> -                       PPC_FLOAT | PPC_FLOAT_FRES | PPC_FLOAT_FSEL |
> -                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> -                       PPC_FLOAT_STFIWX | PPC_MFTB |
> -                       PPC_DCR | PPC_DCRX | PPC_DCRUX |
> -                       PPC_WRTEE | PPC_MFAPIDI |
> -                       PPC_CACHE | PPC_CACHE_ICBI |
> -                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
> -                       PPC_MEM_TLBSYNC | PPC_TLBIVA |
> -                       PPC_BOOKE | PPC_4xx_COMMON | PPC_405_MAC |
> -                       PPC_440_SPEC;
> -    pcc->msr_mask =3D (1ull << MSR_POW) |
> -                    (1ull << MSR_CE) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_DWE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_FE1) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR);
> -    pcc->mmu_model =3D POWERPC_MMU_BOOKE;
> -    pcc->excp_model =3D POWERPC_EXCP_BOOKE;
> -    pcc->bus_model =3D PPC_FLAGS_INPUT_BookE;
> -    pcc->bfd_mach =3D bfd_mach_ppc_403;
> -    pcc->flags =3D POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
> -                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
> -}
> -
>  static void init_proc_MPC5xx(CPUPPCState *env)
>  {
>      /* Time base */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V7BlxAaPrdhzdIM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUJJYACgkQbDjKyiDZ
s5KxaxAAhWSTrNAl8l+k62tzZxgpWNN3ieibl0um31iSuAMhUEDnt3hqY2wxWNkR
ECO/0ngylG7C+4fyuq8aNUZ2fZExEVssH1tNDxFrzej4XH9mCpYB1W2dAK+MELJv
45C5guUQWihN2AP+vComv/wHiZIrrL7Ex00akwVPvM9d8WVAMIdIKM2y2BDGRLSs
hbvoXljTAE1A0UPTqjF3z/l5tOYAIFM1IjVLVEGQKoPOthBvzTCRYr+ZpBmnFRgk
rNHIABV9gmlFlKYpy0+Ns1+sZycepMU1+Y3G9XpgZ0OWhbdxchhnU9WlUvCkyZmF
luOfELrK97/1+28EKLXD7VsCdmRYjQAxD2OgRk0M+ZpEZ9pWrBBct0dOyOsKbDYS
RAtMQRTPw4xpwfh4hoSnjq2UyV84wzvYGk2F8bshBeKF4RkL/fFefLyzgbrS/nUG
10Go6lLO/R6cqpb1ybutcFUTj8EvvOCKBNzAs3ce68iOIuurdLVkaHniYBfNloZV
TEwsvTK70JuT45OSgCOnBqM+qzP8Mu0OqqDbMicduoPYS2AsReiHunrav1Bd06qN
ZN+EWVTZft11PyS4jZr/t9kvBcQlDnn8hysQIsKaz3n7IHN1QYlNovTztIB5vFZu
3QL3O7ZCpbIW4q/a3ygiX1UiiY3l4vfMljizER9H/rd3qhYpyFk=
=d7mD
-----END PGP SIGNATURE-----

--V7BlxAaPrdhzdIM1--
