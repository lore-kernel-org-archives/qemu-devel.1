Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89197C2D0F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 02:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4688620721
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 02:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fOjj41QZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4688620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJpbg-0002zu-Dh
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 22:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJpZl-0002PU-IW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 22:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJpZj-00073I-DF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 22:27:25 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJpZi-0006bh-2F; Wed, 01 Apr 2020 22:27:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48t6Qq3Kymz9sRR; Thu,  2 Apr 2020 13:27:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585794435;
 bh=WX9YOyFr9zEjaxjMYCHMRzY69/Byw8FGDvPJq8xkvLU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fOjj41QZgcmKXjQoWQQxj9qiT/iJuKpoi16Y5u6dDAz1TP2+Rch9iPEVga/hQRgSR
 wJsZh6GNs7Xh8/msVs2/vm6JepwWaHdeeZ45WtG1do7FqBxx3tOjTw8ARPmQfdJTds
 DejPJAse7t9G8JfdGJ/IFds4lD3TcdJ1KN4SXJDk=
Date: Thu, 2 Apr 2020 12:59:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 1/4] target/ppc: Introduce ppc_radix64_xlate() for
 Radix tree translation
Message-ID: <20200402015908.GL47772@umbus.fritz.box>
References: <20200401162810.16254-1-clg@kaod.org>
 <20200401162810.16254-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
In-Reply-To: <20200401162810.16254-2-clg@kaod.org>
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


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 06:28:07PM +0200, C=E9dric Le Goater wrote:
> This is moving code under a new ppc_radix64_xlate() routine shared by
> the MMU Radix page fault handler and the 'get_phys_page_debug' PPC
> callback. The difference being that 'get_phys_page_debug' does not
> generate exceptions.
>=20
> The specific part of process-scoped Radix translation is moved under
> ppc_radix64_process_scoped_xlate() in preparation of the future support
> for partition-scoped Radix translation. Routines raising the exceptions
> now take a 'cause_excp' bool to cover the 'get_phys_page_debug' case.
>=20
> It should be functionally equivalent.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/mmu-radix64.c | 223 ++++++++++++++++++++++-----------------
>  1 file changed, 125 insertions(+), 98 deletions(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index d2422d1c54c9..410376fbeb65 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -69,11 +69,16 @@ static bool ppc_radix64_get_fully_qualified_addr(CPUP=
PCState *env, vaddr eaddr,
>      return true;
>  }
> =20
> -static void ppc_radix64_raise_segi(PowerPCCPU *cpu, int rwx, vaddr eaddr)
> +static void ppc_radix64_raise_segi(PowerPCCPU *cpu, int rwx, vaddr eaddr,
> +                                   bool cause_excp)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    if (!cause_excp) {
> +        return;
> +    }

Hrm... adding a parameter which makes this function a no-op seems an
odd choice, rather than putting an if in the caller.

> +
>      if (rwx =3D=3D 2) { /* Instruction Segment Interrupt */
>          cs->exception_index =3D POWERPC_EXCP_ISEG;
>      } else { /* Data Segment Interrupt */
> @@ -84,11 +89,15 @@ static void ppc_radix64_raise_segi(PowerPCCPU *cpu, i=
nt rwx, vaddr eaddr)
>  }
> =20
>  static void ppc_radix64_raise_si(PowerPCCPU *cpu, int rwx, vaddr eaddr,
> -                                uint32_t cause)
> +                                 uint32_t cause, bool cause_excp)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    if (!cause_excp) {
> +        return;
> +    }
> +
>      if (rwx =3D=3D 2) { /* Instruction Storage Interrupt */
>          cs->exception_index =3D POWERPC_EXCP_ISI;
>          env->error_code =3D cause;
> @@ -219,17 +228,118 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_=
t lpid, ppc_v3_pate_t *pate)
>      return true;
>  }
> =20
> +static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
> +                                            vaddr eaddr, uint64_t pid,
> +                                            ppc_v3_pate_t pate, hwaddr *=
g_raddr,
> +                                            int *g_prot, int *g_page_siz=
e,
> +                                            bool cause_excp)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    uint64_t offset, size, prtbe_addr, prtbe0, pte;
> +    int fault_cause =3D 0;
> +    hwaddr pte_addr;
> +
> +    /* Index Process Table by PID to Find Corresponding Process Table En=
try */
> +    offset =3D pid * sizeof(struct prtb_entry);
> +    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> +    if (offset >=3D size) {
> +        /* offset exceeds size of the process table */
> +        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE, cause_excp);
> +        return 1;
> +    }
> +    prtbe_addr =3D (pate.dw1 & PATE1_R_PRTB) + offset;
> +    prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
> +
> +    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> +    *g_page_size =3D PRTBE_R_GET_RTS(prtbe0);
> +    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> +                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
> +                                g_raddr, g_page_size, &fault_cause, &pte=
_addr);
> +
> +    if (!(pte & R_PTE_VALID) ||
> +        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot)) {
> +        /* No valid pte or access denied due to protection */
> +        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause, cause_excp);
> +        return 1;
> +    }
> +
> +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> +
> +    return 0;
> +}
> +
> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> +                             bool relocation,
> +                             hwaddr *raddr, int *psizep, int *protp,
> +                             bool cause_excp)
> +{
> +    uint64_t lpid =3D 0, pid =3D 0;
> +    ppc_v3_pate_t pate;
> +    int psize, prot;
> +    hwaddr g_raddr;
> +
> +    /* Virtual Mode Access - get the fully qualified address */
> +    if (!ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr, &lpid, &=
pid)) {
> +        ppc_radix64_raise_segi(cpu, rwx, eaddr, cause_excp);
> +        return 1;
> +    }
> +
> +    /* Get Process Table */
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc;
> +        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->get_pate(cpu->vhyp, &pate);
> +    } else {
> +        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> +            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE, cause_exc=
p);
> +            return 1;
> +        }
> +        if (!validate_pate(cpu, lpid, &pate)) {
> +            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG,
> +                                 cause_excp);
> +            return 1;
> +        }
> +        /* We don't support guest mode yet */
> +        if (lpid !=3D 0) {
> +            error_report("PowerNV guest support Unimplemented");
> +            exit(1);
> +        }
> +    }
> +
> +    *psizep =3D INT_MAX;
> +    *protp =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +
> +    /*
> +     * Perform process-scoped translation if relocation enabled.
> +     *
> +     * - Translates an effective address to a host real address in
> +     *   quadrants 0 and 3 when HV=3D1.
> +     */
> +    if (relocation) {
> +        int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pi=
d,
> +                                                   pate, &g_raddr, &prot,
> +                                                   &psize, cause_excp);
> +        if (ret) {
> +            return ret;
> +        }
> +        *psizep =3D MIN(*psizep, psize);
> +        *protp &=3D prot;
> +    } else {
> +        g_raddr =3D eaddr & R_EADDR_MASK;
> +    }
> +
> +    *raddr =3D g_raddr;
> +    return 0;
> +}
> +
>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                   int mmu_idx)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    PPCVirtualHypervisorClass *vhc;
> -    hwaddr raddr, pte_addr;
> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> -    int page_size, prot, fault_cause =3D 0;
> -    ppc_v3_pate_t pate;
> +    int page_size, prot;
>      bool relocation;
> +    hwaddr raddr;
> =20
>      assert(!(msr_hv && cpu->vhyp));
>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> @@ -262,55 +372,12 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
>                        TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
>      }
> =20
> -    /* Virtual Mode Access - get the fully qualified address */
> -    if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
> -        ppc_radix64_raise_segi(cpu, rwx, eaddr);
> -        return 1;
> -    }
> -
> -    /* Get Process Table */
> -    if (cpu->vhyp) {
> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->get_pate(cpu->vhyp, &pate);
> -    } else {
> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> -            return 1;
> -        }
> -        if (!validate_pate(cpu, lpid, &pate)) {
> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
> -        }
> -        /* We don't support guest mode yet */
> -        if (lpid !=3D 0) {
> -            error_report("PowerNV guest support Unimplemented");
> -            exit(1);
> -       }
> -    }
> -
> -    /* Index Process Table by PID to Find Corresponding Process Table En=
try */
> -    offset =3D pid * sizeof(struct prtb_entry);
> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> -    if (offset >=3D size) {
> -        /* offset exceeds size of the process table */
> -        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> -        return 1;
> -    }
> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> -
> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
> -                                &raddr, &page_size, &fault_cause, &pte_a=
ddr);
> -    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &pro=
t)) {
> -        /* Couldn't get pte or access denied due to protection */
> -        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> +    /* Translate eaddr to raddr (where raddr is addr qemu needs for acce=
ss) */
> +    if (ppc_radix64_xlate(cpu, eaddr, rwx, relocation, &raddr,
> +                          &page_size, &prot, 1)) {
>          return 1;
>      }
> =20
> -    /* Update Reference and Change Bits */
> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
> -
>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
>                   prot, mmu_idx, 1UL << page_size);
>      return 0;
> @@ -318,58 +385,18 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
> =20
>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong ead=
dr)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    PPCVirtualHypervisorClass *vhc;
> -    hwaddr raddr, pte_addr;
> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> -    int page_size, fault_cause =3D 0;
> -    ppc_v3_pate_t pate;
> +    int psize, prot;
> +    hwaddr raddr;
> =20
>      /* Handle Real Mode */
> -    if (msr_dr =3D=3D 0) {
> +    if ((msr_dr =3D=3D 0) && (msr_hv || cpu->vhyp)) {
>          /* In real mode top 4 effective addr bits (mostly) ignored */
>          return eaddr & 0x0FFFFFFFFFFFFFFFULL;
>      }
> =20
> -    /* Virtual Mode Access - get the fully qualified address */
> -    if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
> -        return -1;
> -    }
> -
> -    /* Get Process Table */
> -    if (cpu->vhyp) {
> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->get_pate(cpu->vhyp, &pate);
> -    } else {
> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> -            return -1;
> -        }
> -        if (!validate_pate(cpu, lpid, &pate)) {
> -            return -1;
> -        }
> -        /* We don't support guest mode yet */
> -        if (lpid !=3D 0) {
> -            error_report("PowerNV guest support Unimplemented");
> -            exit(1);
> -       }
> -    }
> -
> -    /* Index Process Table by PID to Find Corresponding Process Table En=
try */
> -    offset =3D pid * sizeof(struct prtb_entry);
> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> -    if (offset >=3D size) {
> -        /* offset exceeds size of the process table */
> -        return -1;
> -    }
> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> -
> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
> -                                &raddr, &page_size, &fault_cause, &pte_a=
ddr);
> -    if (!pte) {
> +    if (ppc_radix64_xlate(cpu, eaddr, 0, msr_dr, &raddr, &psize,
> +                          &prot, 0)) {
>          return -1;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6FRucACgkQbDjKyiDZ
s5Kp4BAAuB/276Zgj6c1bPCYrgMV8Vf+rUxbbjYS5iiTbYjqwgFlCnRQultMn2xW
uiFVWKeoqpHHeDHTdGnZiR46KeWPLoYOSC1KMZlJ/10IlJeiCoULzsU6qwcoiXLN
YfnZn8UkwlXRP/1NZ1czMqwulNrWrmKjnE33TB4DgACNocjSmEra0XEbOXaSyRSc
EgkhwXokGEVjy/Qf8j6bY3m7xnkUbgc+3ZoHCvVc9JfIlWYckg/GxauBwA/u3ARn
nwScf6brFrlHqkj7zNPaYa8zE7KjiHLGLBrcWWayNeDvCGW3RWSOTZNQ4q2jIla2
5gTgMfM2l+qwKOLIkiXZmu2w9+rh1qZ8kx11ads5M0OuFCfsx/h2FvUtdr88VJYB
b5i0+6s9RyjgM+VCr1qqXQhprPre2dd77GwI4zvjwyR82/zLLj9yGHWNMJAZ9is2
tXx6B+d4E/Z68FunJZuHHItisMTXowLiKs3a4ICVQTgYQ17PWh8pKUE/Cqans7YU
j8qYnfDQnhL8RHGqquO3fK525rs/G2XT4EUb88rU9UMM+2vYWGxIvO9SJtTL53+j
LPczu2Or/phUvvr5rPqWB9pwmgEYis8lIVDTClkhFNMrXD/zV9qeIb5qGxdIJqwk
PaOIRKDeeTPgRWoqxCE6mnsG6Ha4QIgBCVclOtdCShH+v9FItYI=
=HoCD
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--

