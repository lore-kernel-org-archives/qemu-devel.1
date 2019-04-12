Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC1FC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4378521872
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gwVGO7yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4378521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEpnM-0006nV-DB
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 02:36:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplY-0005Jo-2y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplU-0000nS-Jm
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:23 -0400
Received: from ozlabs.org ([203.11.71.1]:51473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hEplQ-0000l7-JQ; Fri, 12 Apr 2019 02:34:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44gSm5131Jz9sBp; Fri, 12 Apr 2019 16:34:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555050853;
	bh=h0hjEoMGAekxFtx1vWII/HT2uxaqA44ppRNAj72tC/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwVGO7yDZd0/FTdT9yrtncrvLF56AoSLflS0Lq1n7YSekMsqiiUDMbmwh8ugnp9gm
	FA0dwRjwZm00dCO/IFLFzIEDcLA0WYc1AboYgFu+/Ib9f46C+ehTj0XqDsNqdgXZJP
	Fmjgm7eb0boMIK3YRk3YOz4pco0KmyWAF9aCIyzU=
Date: Fri, 12 Apr 2019 16:20:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190412062007.GE8005@umbus.fritz.box>
References: <20190411080004.8690-1-clg@kaod.org>
	<20190411080004.8690-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20190411080004.8690-4-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 3/6] ppc/hash64: Rework R and C bit updates
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412062007.cFwEMrmStPXHlzoDiH6VNb_1aWHAn1MQ3QTljFCOtgU@z>


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:00:01AM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> With MT-TCG, we are now running translation in a racy way, thus
> we need to mimic hardware when it comes to updating the R and
> C bits, by doing byte stores.
>=20
> The current "store_hpte" abstraction is ill suited for this, we
> replace it with two separate callbacks for setting R and C.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.


> ---
>  include/hw/ppc/spapr.h  |  2 ++
>  target/ppc/cpu.h        |  4 +--
>  target/ppc/mmu-hash64.h |  2 --
>  hw/ppc/spapr.c          | 41 +++++++++++++++++++---
>  hw/ppc/spapr_hcall.c    | 13 +++----
>  target/ppc/mmu-hash64.c | 76 ++++++++++++++++++++++++-----------------
>  6 files changed, 93 insertions(+), 45 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9331f5e0b955..7e32f309c2be 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -784,6 +784,8 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, i=
nt shift,
>                            Error **errp);
>  void spapr_clear_pending_events(SpaprMachineState *spapr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
> +void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> +                      uint64_t pte0, uint64_t pte1);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 07cea7268c0c..a4420636dde0 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1268,8 +1268,8 @@ struct PPCVirtualHypervisorClass {
>      void (*unmap_hptes)(PPCVirtualHypervisor *vhyp,
>                          const ppc_hash_pte64_t *hptes,
>                          hwaddr ptex, int n);
> -    void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
> -                       uint64_t pte0, uint64_t pte1);
> +    void (*hpte_set_c)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
> +    void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
>      void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
>      target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
>  };
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 6b555b72200f..bc362964122d 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -10,8 +10,6 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
>  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr=
);
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr address, int rw,
>                                  int mmu_idx);
> -void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> -                           uint64_t pte0, uint64_t pte1);
>  void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
>                                 target_ulong pte_index,
>                                 target_ulong pte0, target_ulong pte1);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b81e237635cd..c56939a43b64 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1520,10 +1520,10 @@ static void spapr_unmap_hptes(PPCVirtualHyperviso=
r *vhyp,
>      /* Nothing to do for qemu managed HPT */
>  }
> =20
> -static void spapr_store_hpte(PPCVirtualHypervisor *vhyp, hwaddr ptex,
> -                             uint64_t pte0, uint64_t pte1)
> +void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> +                      uint64_t pte0, uint64_t pte1)
>  {
> -    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(cpu->vhyp);
>      hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
> =20
>      if (!spapr->htab) {
> @@ -1551,6 +1551,38 @@ static void spapr_store_hpte(PPCVirtualHypervisor =
*vhyp, hwaddr ptex,
>      }
>  }
> =20
> +static void spapr_hpte_set_c(PPCVirtualHypervisor *vhyp, hwaddr ptex,
> +                             uint64_t pte1)
> +{
> +    hwaddr offset =3D ptex * HASH_PTE_SIZE_64 + 15;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +
> +    if (!spapr->htab) {
> +        /* There should always be a hash table when this is called */
> +        error_report("spapr_hpte_set_c called with no hash table !");
> +        return;
> +    }
> +
> +    /* The HW performs a non-atomic byte update */
> +    stb_p(spapr->htab + offset, (pte1 & 0xff) | 0x80);
> +}
> +
> +static void spapr_hpte_set_r(PPCVirtualHypervisor *vhyp, hwaddr ptex,
> +                             uint64_t pte1)
> +{
> +    hwaddr offset =3D ptex * HASH_PTE_SIZE_64 + 14;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +
> +    if (!spapr->htab) {
> +        /* There should always be a hash table when this is called */
> +        error_report("spapr_hpte_set_r called with no hash table !");
> +        return;
> +    }
> +
> +    /* The HW performs a non-atomic byte update */
> +    stb_p(spapr->htab + offset, ((pte1 >> 8) & 0xff) | 0x01);
> +}
> +
>  int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
>  {
>      int shift;
> @@ -4291,7 +4323,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      vhc->hpt_mask =3D spapr_hpt_mask;
>      vhc->map_hptes =3D spapr_map_hptes;
>      vhc->unmap_hptes =3D spapr_unmap_hptes;
> -    vhc->store_hpte =3D spapr_store_hpte;
> +    vhc->hpte_set_c =3D spapr_hpte_set_c;
> +    vhc->hpte_set_r =3D spapr_hpte_set_r;
>      vhc->get_pate =3D spapr_get_pate;
>      vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
>      xic->ics_get =3D spapr_ics_get;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 7761d4a841af..a27c9a01aa97 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -118,7 +118,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>          ppc_hash64_unmap_hptes(cpu, hptes, ptex, 1);
>      }
> =20
> -    ppc_hash64_store_hpte(cpu, ptex + slot, pteh | HPTE64_V_HPTE_DIRTY, =
ptel);
> +    spapr_store_hpte(cpu, ptex + slot, pteh | HPTE64_V_HPTE_DIRTY, ptel);
> =20
>      args[0] =3D ptex + slot;
>      return H_SUCCESS;
> @@ -131,7 +131,8 @@ typedef enum {
>      REMOVE_HW =3D 3,
>  } RemoveResult;
> =20
> -static RemoveResult remove_hpte(PowerPCCPU *cpu, target_ulong ptex,
> +static RemoveResult remove_hpte(PowerPCCPU *cpu
> +                                , target_ulong ptex,
>                                  target_ulong avpn,
>                                  target_ulong flags,
>                                  target_ulong *vp, target_ulong *rp)
> @@ -155,7 +156,7 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, targ=
et_ulong ptex,
>      }
>      *vp =3D v;
>      *rp =3D r;
> -    ppc_hash64_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY, 0);
> +    spapr_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY, 0);
>      ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
>      return REMOVE_SUCCESS;
>  }
> @@ -289,13 +290,13 @@ static target_ulong h_protect(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>      r |=3D (flags << 55) & HPTE64_R_PP0;
>      r |=3D (flags << 48) & HPTE64_R_KEY_HI;
>      r |=3D flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
> -    ppc_hash64_store_hpte(cpu, ptex,
> -                          (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0=
);
> +    spapr_store_hpte(cpu, ptex,
> +                     (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0);
>      ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
>      /* Flush the tlb */
>      check_tlb_flush(env, true);
>      /* Don't need a memory barrier, due to qemu's global lock */
> -    ppc_hash64_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r);
> +    spapr_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r);
>      return H_SUCCESS;
>  }
> =20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 8956ad55d96f..b4a27d46e382 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -724,6 +724,39 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
>  }
> =20
> =20
> +static void ppc_hash64_set_r(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
> +{
> +    hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + 16;
> +
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
> +        return;
> +    }
> +    base =3D ppc_hash64_hpt_base(cpu);
> +
> +
> +    /* The HW performs a non-atomic byte update */
> +    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
> +}
> +
> +static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
> +{
> +    hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + 15;
> +
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
> +        return;
> +    }
> +    base =3D ppc_hash64_hpt_base(cpu);
> +
> +    /* The HW performs a non-atomic byte update */
> +    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
> +}
> +
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                  int rwx, int mmu_idx)
>  {
> @@ -734,7 +767,6 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>      hwaddr ptex;
>      ppc_hash_pte64_t pte;
>      int exec_prot, pp_prot, amr_prot, prot;
> -    uint64_t new_pte1;
>      const int need_prot[] =3D {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
>      hwaddr raddr;
> =20
> @@ -882,19 +914,19 @@ skip_slb_search:
> =20
>      /* 6. Update PTE referenced and changed bits if necessary */
> =20
> -    new_pte1 =3D pte.pte1 | HPTE64_R_R; /* set referenced bit */
> -    if (rwx =3D=3D 1) {
> -        new_pte1 |=3D HPTE64_R_C; /* set changed (dirty) bit */
> -    } else {
> -        /*
> -         * Treat the page as read-only for now, so that a later write
> -         * will pass through this function again to set the C bit
> -         */
> -        prot &=3D ~PAGE_WRITE;
> +    if (!(pte.pte1 & HPTE64_R_R)) {
> +        ppc_hash64_set_r(cpu, ptex, pte.pte1);
>      }
> -
> -    if (new_pte1 !=3D pte.pte1) {
> -        ppc_hash64_store_hpte(cpu, ptex, pte.pte0, new_pte1);
> +    if (!(pte.pte1 & HPTE64_R_C)) {
> +        if (rwx =3D=3D 1) {
> +            ppc_hash64_set_c(cpu, ptex, pte.pte1);
> +        } else {
> +            /*
> +             * Treat the page as read-only for now, so that a later write
> +             * will pass through this function again to set the C bit
> +             */
> +            prot &=3D ~PAGE_WRITE;
> +        }
>      }
> =20
>      /* 7. Determine the real address from the PTE */
> @@ -953,24 +985,6 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong addr)
>          & TARGET_PAGE_MASK;
>  }
> =20
> -void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> -                           uint64_t pte0, uint64_t pte1)
> -{
> -    hwaddr base;
> -    hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
> -
> -    if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
> -        return;
> -    }
> -    base =3D ppc_hash64_hpt_base(cpu);
> -
> -    stq_phys(CPU(cpu)->as, base + offset, pte0);
> -    stq_phys(CPU(cpu)->as, base + offset + HASH_PTE_SIZE_64 / 2, pte1);
> -}
> -
>  void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
>                                 target_ulong pte0, target_ulong pte1)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywLhcACgkQbDjKyiDZ
s5IQdQ//dmhiWfVXyZ0KECfQnQEHBZ3zFNuyyTDwyWuDufjjiCYT/fMvQc0tjbcZ
Deo4Dim4sqSlBLcfwrKm2xH4p3fqQ0pngHCDNFLvq0FmNfvQVdgZx44WroaWlKCZ
thy7qXAVf1U2W6Hg6gdjwKG9IGjz2IJwBXpSOHg7QmzrL/GOGPiKnFoJKbukOLu/
r3rMHbPC9rAgdmE0QyDKwVJAuYLXJMXDeYhGqBYfRq9Ni2DX+1ylp7SDK/hJj0ap
pXWFIyEnSano1PXszqsLDheXIlwLuNc7x7703JrLAf71pcX/q0u+ZTfgJ0CVW9sp
jaSMI3uzMroRbfudogZS6bBlCg6pZ8oaAPdL6QYrT5/8Iv1IhTiics/utCUdcift
laBGEtzJHF+zL30QzgM5OfE+aLCjqWDpBI2dzTdsEn0xQYN//SR0nXqRzpP37n51
tFX2zYsD+JggnfmPpPcNvzgRJ0OliftV7W5T1uolX1N8T3N4GD1v79WKQpj/8qo8
4Zoy+79k/TIYF+vaTqF0kMpyVmIwp9rNkYuOzELnbis4eBYhntiBh/U8w9f14iTL
E3IMkvrJetO5tKM8VRY1o4askFWjVppi7lfK4Kp5LqHtNcLgDoEJ4sGNeISD3jaP
r+52t59o9oC0Ff81MXryFxjzqCnZkJzZmEN/dvf4aebku8w/V8A=
=jR5K
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--

