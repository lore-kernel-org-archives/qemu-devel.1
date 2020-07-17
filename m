Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970FC206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ojqgAuX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970FC206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwDwM-0002Wr-S5
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 20:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwDvR-0001S2-Hz; Thu, 16 Jul 2020 20:08:29 -0400
Received: from ozlabs.org ([203.11.71.1]:35817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwDvO-0001j2-Dg; Thu, 16 Jul 2020 20:08:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B7BKd2Qvdz9sRk; Fri, 17 Jul 2020 10:08:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594944501;
 bh=VlHeZa+eb7mTldyXGIivdcmEqJfugQQFglev0jHyAuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ojqgAuX4tDdMwrvQ+EMhlStBPROrMSKbP186+1G6wwtqcn8pCIQiKgw6jXWD8sK+4
 U2EAiMbWpbW2QLJELytQvXyHPzGGqdSd0YRQc9YWc9zXUfYm3AWBzQl8G3j3IcW/Ut
 84iJKqlyTsB4nyoXWsohLWAKO2X0XG7JcxxqY844=
Date: Fri, 17 Jul 2020 10:07:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH v4] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200717000759.GE5607@umbus.fritz.box>
References: <20200716225655.24289-1-arbab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20200716225655.24289-1-arbab@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 20:08:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 05:56:55PM -0500, Reza Arbab wrote:
> NUMA nodes corresponding to GPU memory currently have the same
> affinity/distance as normal memory nodes. Add a third NUMA associativity
> reference point enabling us to give GPU nodes more distance.
>=20
> This is guest visible information, which shouldn't change under a
> running guest across migration between different qemu versions, so make
> the change effective only in new (pseries > 5.0) machine types.
>=20
> Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):
>=20
> node distances:
> node   0   1   2   3   4   5
>   0:  10  40  40  40  40  40
>   1:  40  10  40  40  40  40
>   2:  40  40  10  40  40  40
>   3:  40  40  40  10  40  40
>   4:  40  40  40  40  10  40
>   5:  40  40  40  40  40  10
>=20
> After:
>=20
> node distances:
> node   0   1   2   3   4   5
>   0:  10  40  80  80  80  80
>   1:  40  10  80  80  80  80
>   2:  80  80  10  80  80  80
>   3:  80  80  80  10  80  80
>   4:  80  80  80  80  10  80
>   5:  80  80  80  80  80  10
>=20
> These are the same distances as on the host, mirroring the change made
> to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
> Add a new level of NUMA for GPU's").

Applied to ppc-for-5.1.

>=20
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
> v4:
> * Use nvslot->numa_id for distinction at all levels of ibm,associativity
> * Use ARRAY_SIZE(refpoints)
> * Rebase
>=20
> v3:
> * Squash into one patch
> * Add PHB compat property
> ---
>  hw/ppc/spapr.c              | 21 +++++++++++++++++++--
>  hw/ppc/spapr_pci.c          |  2 ++
>  hw/ppc/spapr_pci_nvlink2.c  | 13 ++++++++++---
>  include/hw/pci-host/spapr.h |  1 +
>  include/hw/ppc/spapr.h      |  1 +
>  5 files changed, 33 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 299908cc7396..0ae293ec9431 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -890,10 +890,16 @@ static int spapr_dt_rng(void *fdt)
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *ms =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>      int rtas;
>      GString *hypertas =3D g_string_sized_new(256);
>      GString *qemu_hypertas =3D g_string_sized_new(256);
> -    uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> +    uint32_t refpoints[] =3D {
> +        cpu_to_be32(0x4),
> +        cpu_to_be32(0x4),
> +        cpu_to_be32(0x2),
> +    };
> +    uint32_t nr_refpoints =3D ARRAY_SIZE(refpoints);
>      uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base +
>          memory_region_size(&MACHINE(spapr)->device_memory->mr);
>      uint32_t lrdr_capacity[] =3D {
> @@ -945,8 +951,12 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, =
void *fdt)
>                       qemu_hypertas->str, qemu_hypertas->len));
>      g_string_free(qemu_hypertas, TRUE);
> =20
> +    if (smc->pre_5_1_assoc_refpoints) {
> +        nr_refpoints =3D 2;
> +    }
> +
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
> -                     refpoints, sizeof(refpoints)));
> +                     refpoints, nr_refpoints * sizeof(refpoints[0])));
> =20
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
> @@ -4584,9 +4594,16 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
>   */
>  static void spapr_machine_5_0_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-5.1-associativity", "on" },
> +    };
> +
>      spapr_machine_5_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>      mc->numa_mem_supported =3D true;
> +    smc->pre_5_1_assoc_refpoints =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2a6a48744aaa..16739334e35f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2035,6 +2035,8 @@ static Property spapr_phb_properties[] =3D {
>                       pcie_ecs, true),
>      DEFINE_PROP_UINT64("gpa", SpaprPhbState, nv2_gpa_win_addr, 0),
>      DEFINE_PROP_UINT64("atsd", SpaprPhbState, nv2_atsd_win_addr, 0),
> +    DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
> +                     pre_5_1_assoc, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index dd8cd6db9654..76ae77ebc851 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -362,9 +362,9 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *s=
phb, void *fdt)
>                                                      &error_abort);
>          uint32_t associativity[] =3D {
>              cpu_to_be32(0x4),
> -            SPAPR_GPU_NUMA_ID,
> -            SPAPR_GPU_NUMA_ID,
> -            SPAPR_GPU_NUMA_ID,
> +            cpu_to_be32(nvslot->numa_id),
> +            cpu_to_be32(nvslot->numa_id),
> +            cpu_to_be32(nvslot->numa_id),
>              cpu_to_be32(nvslot->numa_id)
>          };
>          uint64_t size =3D object_property_get_uint(nv_mrobj, "size", NUL=
L);
> @@ -375,6 +375,13 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *=
sphb, void *fdt)
>          _FDT(off);
>          _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
>          _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
> +
> +        if (sphb->pre_5_1_assoc) {
> +            associativity[1] =3D SPAPR_GPU_NUMA_ID;
> +            associativity[2] =3D SPAPR_GPU_NUMA_ID;
> +            associativity[3] =3D SPAPR_GPU_NUMA_ID;
> +        }
> +
>          _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
>                            sizeof(associativity))));
> =20
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 8877ff51fbf7..600eb55c3488 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -94,6 +94,7 @@ struct SpaprPhbState {
>      hwaddr nv2_gpa_win_addr;
>      hwaddr nv2_atsd_win_addr;
>      SpaprPhbPciNvGpuConfig *nvgpus;
> +    bool pre_5_1_assoc;
>  };
> =20
>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c421410e3fb8..3134d339e8fe 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -129,6 +129,7 @@ struct SpaprMachineClass {
>      bool linux_pci_probe;
>      bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
>      hwaddr rma_limit;          /* clamp the RMA to this size */
> +    bool pre_5_1_assoc_refpoints;
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Q690ACgkQbDjKyiDZ
s5IfQRAAxBIzSxK5Z9TaFTr45bnbnkmid4hpn/GguY5poke++0+ZH1wrsrzUCuqV
QE3b09XlzqApsjDGV09qNle+lL3598alhF5yfup0Qhq8YrZyCXqG8Z5ys0wOQpeN
bxOaZaV9dgEjU4rRIFuWBr+LXFPBW5HegonT7B5+jQzGqqU3UJFAvPA6S3uJkrfo
g/oi3Wc7g4uA3F2L1tnqONec4WQae/xjJ2J9tnKgfa5VxQB+jZvp4Ev4XsZWHunL
wr0SERS91Z+76psJkBMwaMv+awGpWsPsUuWOJNCZV2TuEHO4o9lltLS0+PhIGUUs
qDmURNJEj2/Xg9HITwPGmj7t1yc4pPW//eIiJq8xS3Z7kww9IS/Dd4G8c/VJTdSn
i2f3posTj8XHl6HU5qhm+zHtZeW25ET4uaVhK/LgGUAeCcdqgEPQktQjR1CxL904
hAXZRA+/x6xIUAGOSnrEyRV9XjuF9dRw5fyqapjQszUAZawk2YWYs/ew325fiQzJ
y378m3WMsdDrov2XSodDE/BfKJT5JGLZQ8a6mjLa+bl0pOpKWDPPnBMpjN4ouj0V
M/VRhjautpm632+dT6NmEIbTiUaLbbb71Hi74S7ultYSUuyCLzeqd0R0KAVAobss
j97EvqF1k1ZseiiR5qNQVg+ggfIouHJJ0nAgW0Y7WNVVRc8vP5k=
=Q9yw
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--

