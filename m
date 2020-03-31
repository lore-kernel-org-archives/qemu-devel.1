Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234D620714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H9KKCJWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234D620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ5Un-0006C2-9i
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 21:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5U2-0005cD-KD
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5U0-00062M-Of
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:14:26 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57677 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ5Tz-0005yE-Si; Mon, 30 Mar 2020 21:14:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rrvc48Z9z9sSJ; Tue, 31 Mar 2020 12:14:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585617260;
 bh=DbgmLcfAbO+WoRMI0RhsTyjPz8IMV9J1m7DI9O7gUuc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H9KKCJWgyXZJEkgcoX+KZ192uJoF7fjz9/OIMDDvWWPZecBW85fPeiiZ7pjBXWcMR
 NloMH0onqgMQk57riS/+IZ/t+AbsNoCta4YfaaedBWfHICDUYk15I7Hw1+CrcSR/v2
 ZKP8Oh4yA+2Om4DXmcsLTKx54plWXisjSZiJyPME=
Date: Tue, 31 Mar 2020 12:13:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/7] target/ppc: Introduce ppc_radix64_xlate() for Radix
 tree translation
Message-ID: <20200331011310.GG47772@umbus.fritz.box>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-5-clg@kaod.org>
 <20200330161848.27226542@bahia.lan>
 <99dd89d6-f385-7cc1-d688-c104708092c2@kaod.org>
 <88580970-a739-b32f-528f-26c6aa81b598@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <88580970-a739-b32f-528f-26c6aa81b598@kaod.org>
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 05:34:40PM +0200, C=E9dric Le Goater wrote:
> >>> +        /* No valid pte or access denied due to protection */
> >>> +        if (cause_excp) {
> >>> +            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> >>> +        }
> >>> +        return 1;
> >>> +    }
> >>> +
> >>> +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >>> +                             uint64_t lpid, uint64_t pid, bool reloc=
ation,
> >>> +                             hwaddr *raddr, int *psizep, int *protp,
> >>> +                             bool cause_excp)
> >>> +{
> >>> +    ppc_v3_pate_t pate;
> >>> +    int psize, prot;
> >>> +    hwaddr g_raddr;
> >>> +
> >>> +    *psizep =3D INT_MAX;
> >>> +    *protp =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>> +
> >>> +    /* Get Process Table */
> >>> +    if (cpu->vhyp && lpid =3D=3D 0) {
> >>
> >> Current code doesn't check lpid =3D=3D 0. Not sure to see what it's fo=
r...
> >=20
> > cpu->vhyp means a pseries machine, lpid =3D=3D 0 means accessing quadra=
nt3,=20
> > so it's the kernel.
>=20
> Sorry. I misread that. It would pid =3D=3D 0 for the kernel.=20
>=20
> So yes, the test cpu->vhyp && lpid =3D=3D 0 might be a bit overkill, give=
n=20
> that lpid is always 0 when running under a QEMU pseries machine.

Overkill and conceptually incorrect.  When in vhyp mode we're not
modelling the hypervisor part of the CPU, which means that really the
LPID doesn't exist, so we shouldn't be looking at it (though it will
always be 0 in practice).

>=20
>=20
> C.
>=20
> >=20
> >> especially env->spr[SPR_LPIDR] is always 0 with pseries machine types
> >> AFAICT... is it even possible to have lpid !=3D 0 here ?
> >=20
> > When under PowerNV, SPR_LPIDR can be set, but not under pseries.
> >=20
> > C.
> >=20
> >>
> >>
> >> Rest LGTM.
> >>
> >>> +        PPCVirtualHypervisorClass *vhc;
> >>> +        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >>> +        vhc->get_pate(cpu->vhyp, &pate);
> >>> +    } else {
> >>> +        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> >>> +            if (cause_excp) {
> >>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> >>> +            }
> >>> +            return 1;
> >>> +        }
> >>> +        if (!validate_pate(cpu, lpid, &pate)) {
> >>> +            if (cause_excp) {
> >>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCON=
FIG);
> >>> +            }
> >>> +            return 1;
> >>> +        }
> >>> +        /* We don't support guest mode yet */
> >>> +        if (lpid !=3D 0) {
> >>> +            error_report("PowerNV guest support Unimplemented");
> >>> +            exit(1);
> >>> +        }
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * Perform process-scoped translation if relocation enabled.
> >>> +     *
> >>> +     * - Translates an effective address to a host real address in
> >>> +     *   quadrants 0 and 3 when HV=3D1.
> >>> +     */
> >>> +    if (relocation) {
> >>> +        int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr=
, lpid, pid,
> >>> +                                                   pate, &g_raddr, &=
prot,
> >>> +                                                   &psize, cause_exc=
p);
> >>> +        if (ret) {
> >>> +            return ret;
> >>> +        }
> >>> +        *psizep =3D MIN(*psizep, psize);
> >>> +        *protp &=3D prot;
> >>> +    } else {
> >>> +        g_raddr =3D eaddr & R_EADDR_MASK;
> >>> +    }
> >>> +
> >>> +    *raddr =3D g_raddr;
> >>> +    return 0;
> >>> +}
> >>> +
> >>>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int r=
wx,
> >>>                                   int mmu_idx)
> >>>  {
> >>>      CPUState *cs =3D CPU(cpu);
> >>>      CPUPPCState *env =3D &cpu->env;
> >>> -    PPCVirtualHypervisorClass *vhc;
> >>> -    hwaddr raddr, pte_addr;
> >>> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> >>> -    int page_size, prot, fault_cause =3D 0;
> >>> -    ppc_v3_pate_t pate;
> >>> +    uint64_t lpid =3D 0, pid =3D 0;
> >>> +    int page_size, prot;
> >>>      bool relocation;
> >>> +    hwaddr raddr;
> >>> =20
> >>>      assert(!(msr_hv && cpu->vhyp));
> >>>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> >>> @@ -268,48 +370,11 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cp=
u, vaddr eaddr, int rwx,
> >>>          return 1;
> >>>      }
> >>> =20
> >>> -    /* Get Process Table */
> >>> -    if (cpu->vhyp) {
> >>> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >>> -        vhc->get_pate(cpu->vhyp, &pate);
> >>> -    } else {
> >>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> >>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> >>> -            return 1;
> >>> -        }
> >>> -        if (!validate_pate(cpu, lpid, &pate)) {
> >>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
> >>> -        }
> >>> -        /* We don't support guest mode yet */
> >>> -        if (lpid !=3D 0) {
> >>> -            error_report("PowerNV guest support Unimplemented");
> >>> -            exit(1);
> >>> -       }
> >>> -    }
> >>> -
> >>> -    /* Index Process Table by PID to Find Corresponding Process Tabl=
e Entry */
> >>> -    offset =3D pid * sizeof(struct prtb_entry);
> >>> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> >>> -    if (offset >=3D size) {
> >>> -        /* offset exceeds size of the process table */
> >>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> >>> +    /* Translate eaddr to raddr (where raddr is addr qemu needs for =
access) */
> >>> +    if (ppc_radix64_xlate(cpu, eaddr, rwx, lpid, pid, relocation, &r=
addr,
> >>> +                          &page_size, &prot, 1)) {
> >>>          return 1;
> >>>      }
> >>> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> >>> -
> >>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA =
*/
> >>> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> >>> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> >>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTB=
E_R_RPDS,
> >>> -                                &raddr, &page_size, &fault_cause, &p=
te_addr);
> >>> -    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, =
&prot)) {
> >>> -        /* Couldn't get pte or access denied due to protection */
> >>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> >>> -        return 1;
> >>> -    }
> >>> -
> >>> -    /* Update Reference and Change Bits */
> >>> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
> >>> =20
> >>>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_M=
ASK,
> >>>                   prot, mmu_idx, 1UL << page_size);
> >>> @@ -318,16 +383,13 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cp=
u, vaddr eaddr, int rwx,
> >>> =20
> >>>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong=
 eaddr)
> >>>  {
> >>> -    CPUState *cs =3D CPU(cpu);
> >>>      CPUPPCState *env =3D &cpu->env;
> >>> -    PPCVirtualHypervisorClass *vhc;
> >>> -    hwaddr raddr, pte_addr;
> >>> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> >>> -    int page_size, fault_cause =3D 0;
> >>> -    ppc_v3_pate_t pate;
> >>> +    uint64_t lpid =3D 0, pid =3D 0;
> >>> +    int psize, prot;
> >>> +    hwaddr raddr;
> >>> =20
> >>>      /* Handle Real Mode */
> >>> -    if (msr_dr =3D=3D 0) {
> >>> +    if ((msr_dr =3D=3D 0) && (msr_hv || (cpu->vhyp && lpid =3D=3D 0)=
)) {
> >>>          /* In real mode top 4 effective addr bits (mostly) ignored */
> >>>          return eaddr & 0x0FFFFFFFFFFFFFFFULL;
> >>>      }
> >>> @@ -337,39 +399,8 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCP=
U *cpu, target_ulong eaddr)
> >>>          return -1;
> >>>      }
> >>> =20
> >>> -    /* Get Process Table */
> >>> -    if (cpu->vhyp) {
> >>> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >>> -        vhc->get_pate(cpu->vhyp, &pate);
> >>> -    } else {
> >>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> >>> -            return -1;
> >>> -        }
> >>> -        if (!validate_pate(cpu, lpid, &pate)) {
> >>> -            return -1;
> >>> -        }
> >>> -        /* We don't support guest mode yet */
> >>> -        if (lpid !=3D 0) {
> >>> -            error_report("PowerNV guest support Unimplemented");
> >>> -            exit(1);
> >>> -       }
> >>> -    }
> >>> -
> >>> -    /* Index Process Table by PID to Find Corresponding Process Tabl=
e Entry */
> >>> -    offset =3D pid * sizeof(struct prtb_entry);
> >>> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> >>> -    if (offset >=3D size) {
> >>> -        /* offset exceeds size of the process table */
> >>> -        return -1;
> >>> -    }
> >>> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> >>> -
> >>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA =
*/
> >>> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> >>> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> >>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTB=
E_R_RPDS,
> >>> -                                &raddr, &page_size, &fault_cause, &p=
te_addr);
> >>> -    if (!pte) {
> >>> +    if (ppc_radix64_xlate(cpu, eaddr, 0, lpid, pid, msr_dr, &raddr, =
&psize,
> >>> +                          &prot, 0)) {
> >>>          return -1;
> >>>      }
> >>> =20
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6CmSQACgkQbDjKyiDZ
s5JFIw//TSWqlyKqZaOjRM88StdF8OvI45u7ufEJcZ2thXAXiQuJkcx1iBoy6La9
Lh0AkDYYFc6hv9mJpWDZg6X8V/Opy7S4982+23ln8oDh3vxuwcK2napPZw/aHDcd
MusZTps4HHvA24BA80dWogMAGFtuVOrtAOiWUlQYY5mSgAFuEmanNaj6y+77ZjRI
miu7bn1w2DNkYmIzeXuqmlYhOrEOOIO+mvnFmiCjvwRKVJRhknOHm/iTLG4zIhN3
W61/eIlkpbeSJx79eh4IjehSENeOOc/cE7saCT63RpDOaIRR3T7xBRIwefeG8+pD
Rl/ATdZ8plKhAz+bV0kPj8TMuwCiIMvc4pUetDK6aOleNlfpvalfVFZCgytvEhFZ
bja6a4Q/2DY+SnITf29LDrVflJ9eBBblgVVvGqXMQL+PLNORJm59ErMqmIvnmKfF
Quf6zAIM8RG73oA50PaWGsNEJ3XjVI9aJ+cGbR6MgGVbz6jEuM/jmADWzAHCKzez
ejsJoNURufBEt6pPqhu99eKANqy7+5+4AfpaumenUFXGffoKsnqO98Bic2eppjoQ
Q24TPQduMazWZ/fq9PWxQtBqcjBpcgKZ7jFkEraxuDj8IeOM/gHAgsDTx3Iy+enq
IVkLVv/pA9c1c4R3CZ+mbYQbwQzVmWIY/eDUMW3a0cL+9VzmpAg=
=+E84
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--

