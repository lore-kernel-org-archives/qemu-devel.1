Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE574C3A5A6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE66A204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EdK/g3Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE66A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37ny-0005PQ-Sy
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i37mh-0004GK-DX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i37me-0004tT-Pa
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:55:26 -0400
Received: from ozlabs.org ([203.11.71.1]:49035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i37md-0004sh-Tb; Wed, 28 Aug 2019 19:55:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JjKf0CrSz9sNx; Thu, 29 Aug 2019 09:55:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567036518;
 bh=JXR+O5SPrLydjTVymXVQCDVD1x4rB0/B3f6Wfw8tsec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EdK/g3Qwo+a4hmDuG8O/Hj5GMKFyQVDwpSNZIkNyPNqINA7A92QNB/tzOVt5Fgr7H
 5QKh8H/kAMW7J9dm/tGX1i0fLqw9deO9S3n/nP1V1oy1PJkTeJzLFWZwzQm58IxMxk
 aZejaar4Bpg6RnJ54/D0ygM92j6ZkoSjkmjCOYu8=
Date: Thu, 29 Aug 2019 09:29:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190828232920.GB16342@umbus.fritz.box>
References: <156701644465.505236.2850655823182656869.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <156701644465.505236.2850655823182656869.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr/pci: Convert types to QEMU coding
 style
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 08:20:44PM +0200, Greg Kurz wrote:
> The QEMU coding style requires:
> - to typedef structured types (HACKING)
> - to use CamelCase for types and structure names (CODING_STYLE)
>=20
> Do that for PCI and Nvlink2 code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_pci.c          |   28 ++++++++++++++--------------
>  hw/ppc/spapr_pci_nvlink2.c  |   40 +++++++++++++++++++++----------------=
---
>  include/hw/pci-host/spapr.h |   24 ++++++++++++++----------
>  3 files changed, 49 insertions(+), 43 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 9f176f463e76..a777fb3e7ff6 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -280,7 +280,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>      unsigned int irq, max_irqs =3D 0;
>      SpaprPhbState *phb =3D NULL;
>      PCIDevice *pdev =3D NULL;
> -    spapr_pci_msi *msi;
> +    SpaprPciMsi *msi;
>      int *config_addr_key;
>      Error *err =3D NULL;
>      int i;
> @@ -328,7 +328,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>          return;
>      }
> =20
> -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr=
);
> +    msi =3D (SpaprPciMsi *) g_hash_table_lookup(phb->msi, &config_addr);
> =20
>      /* Releasing MSIs */
>      if (!req_num) {
> @@ -415,7 +415,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>                       irq, req_num);
> =20
>      /* Add MSI device to cache */
> -    msi =3D g_new(spapr_pci_msi, 1);
> +    msi =3D g_new(SpaprPciMsi, 1);
>      msi->first_irq =3D irq;
>      msi->num =3D req_num;
>      config_addr_key =3D g_new(int, 1);
> @@ -446,7 +446,7 @@ static void rtas_ibm_query_interrupt_source_number(Po=
werPCCPU *cpu,
>      unsigned int intr_src_num =3D -1, ioa_intr_num =3D rtas_ld(args, 3);
>      SpaprPhbState *phb =3D NULL;
>      PCIDevice *pdev =3D NULL;
> -    spapr_pci_msi *msi;
> +    SpaprPciMsi *msi;
> =20
>      /* Find SpaprPhbState */
>      phb =3D spapr_pci_find_phb(spapr, buid);
> @@ -459,7 +459,7 @@ static void rtas_ibm_query_interrupt_source_number(Po=
werPCCPU *cpu,
>      }
> =20
>      /* Find device descriptor and start IRQ */
> -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr=
);
> +    msi =3D (SpaprPciMsi *) g_hash_table_lookup(phb->msi, &config_addr);
>      if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >=3D msi->=
num)) {
>          trace_spapr_pci_msi("Failed to return vector", config_addr);
>          rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> @@ -1806,7 +1806,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> -    spapr_pci_msi *msi =3D opaque;
> +    SpaprPciMsi *msi =3D opaque;
> =20
>      if (!smc->legacy_irq_allocation) {
>          spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
> @@ -2120,7 +2120,7 @@ static const VMStateDescription vmstate_spapr_pci_l=
si =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
> +        VMSTATE_UINT32_EQUAL(irq, SpaprPciLsi, NULL),
> =20
>          VMSTATE_END_OF_LIST()
>      },
> @@ -2131,9 +2131,9 @@ static const VMStateDescription vmstate_spapr_pci_m=
si =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField []) {
> -        VMSTATE_UINT32(key, spapr_pci_msi_mig),
> -        VMSTATE_UINT32(value.first_irq, spapr_pci_msi_mig),
> -        VMSTATE_UINT32(value.num, spapr_pci_msi_mig),
> +        VMSTATE_UINT32(key, SpaprPciMsiMig),
> +        VMSTATE_UINT32(value.first_irq, SpaprPciMsiMig),
> +        VMSTATE_UINT32(value.num, SpaprPciMsiMig),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -2165,12 +2165,12 @@ static int spapr_pci_pre_save(void *opaque)
>      if (!sphb->msi_devs_num) {
>          return 0;
>      }
> -    sphb->msi_devs =3D g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
> +    sphb->msi_devs =3D g_new(SpaprPciMsiMig, sphb->msi_devs_num);
> =20
>      g_hash_table_iter_init(&iter, sphb->msi);
>      for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
>          sphb->msi_devs[i].key =3D *(uint32_t *) key;
> -        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
> +        sphb->msi_devs[i].value =3D *(SpaprPciMsi *) value;
>      }
> =20
>      return 0;
> @@ -2217,10 +2217,10 @@ static const VMStateDescription vmstate_spapr_pci=
 =3D {
>          VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migr=
ation),
>          VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migr=
ation),
>          VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
> -                             vmstate_spapr_pci_lsi, struct spapr_pci_lsi=
),
> +                             vmstate_spapr_pci_lsi, SpaprPciLsi),
>          VMSTATE_INT32(msi_devs_num, SpaprPhbState),
>          VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, SpaprPhbState, msi_devs_nu=
m, 0,
> -                                    vmstate_spapr_pci_msi, spapr_pci_msi=
_mig),
> +                                    vmstate_spapr_pci_msi, SpaprPciMsiMi=
g),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index eda8c752aa22..4aa89ede23e6 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -39,11 +39,7 @@
> =20
>  #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
> =20
> -struct spapr_phb_pci_nvgpu_config {
> -    uint64_t nv2_ram_current;
> -    uint64_t nv2_atsd_current;
> -    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] */
> -    struct spapr_phb_pci_nvgpu_slot {
> +typedef struct SpaprPhbPciNvGpuSlot {
>          uint64_t tgt;
>          uint64_t gpa;
>          unsigned numa_id;
> @@ -54,12 +50,18 @@ struct spapr_phb_pci_nvgpu_config {
>              PCIDevice *npdev;
>              uint32_t link_speed;
>          } links[NVGPU_MAX_LINKS];
> -    } slots[NVGPU_MAX_NUM];
> +} SpaprPhbPciNvGpuSlot;
> +
> +struct SpaprPhbPciNvGpuConfig {
> +    uint64_t nv2_ram_current;
> +    uint64_t nv2_atsd_current;
> +    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] */
> +    SpaprPhbPciNvGpuSlot slots[NVGPU_MAX_NUM];
>      Error *errp;
>  };
> =20
> -static struct spapr_phb_pci_nvgpu_slot *
> -spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus, uint64_t=
 tgt)
> +static SpaprPhbPciNvGpuSlot *
> +spapr_nvgpu_get_slot(SpaprPhbPciNvGpuConfig *nvgpus, uint64_t tgt)
>  {
>      int i;
> =20
> @@ -81,13 +83,13 @@ spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_confi=
g *nvgpus, uint64_t tgt)
>      return &nvgpus->slots[i];
>  }
> =20
> -static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
> +static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
>                                      PCIDevice *pdev, uint64_t tgt,
>                                      MemoryRegion *mr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
> -    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
> +    SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
> =20
>      if (!nvslot) {
>          error_setg(errp, "Found too many GPUs per vPHB");
> @@ -102,11 +104,11 @@ static void spapr_pci_collect_nvgpu(struct spapr_ph=
b_pci_nvgpu_config *nvgpus,
>      ++spapr->gpu_numa_id;
>  }
> =20
> -static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
> +static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
>                                      PCIDevice *pdev, uint64_t tgt,
>                                      MemoryRegion *mr, Error **errp)
>  {
> -    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
> +    SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
>      int j;
> =20
>      if (!nvslot) {
> @@ -138,7 +140,7 @@ static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, =
PCIDevice *pdev,
> =20
>      if (tgt) {
>          Error *local_err =3D NULL;
> -        struct spapr_phb_pci_nvgpu_config *nvgpus =3D opaque;
> +        SpaprPhbPciNvGpuConfig *nvgpus =3D opaque;
>          Object *mr_gpu =3D object_property_get_link(po, "nvlink2-mr[0]",=
 NULL);
>          Object *mr_npu =3D object_property_get_link(po, "nvlink2-atsd-mr=
[0]",
>                                                    NULL);
> @@ -177,7 +179,7 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error=
 **errp)
>          return;
>      }
> =20
> -    sphb->nvgpus =3D g_new0(struct spapr_phb_pci_nvgpu_config, 1);
> +    sphb->nvgpus =3D g_new0(SpaprPhbPciNvGpuConfig, 1);
>      sphb->nvgpus->nv2_ram_current =3D sphb->nv2_gpa_win_addr;
>      sphb->nvgpus->nv2_atsd_current =3D sphb->nv2_atsd_win_addr;
> =20
> @@ -194,7 +196,7 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error=
 **errp)
>      /* Add found GPU RAM and ATSD MRs if found */
>      for (i =3D 0, valid_gpu_num =3D 0; i < sphb->nvgpus->num; ++i) {
>          Object *nvmrobj;
> -        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> =20
>          if (!nvslot->gpdev) {
>              continue;
> @@ -242,7 +244,7 @@ void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
>      }
> =20
>      for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> -        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
>          Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
>                                                      "nvlink2-mr[0]", NUL=
L);
> =20
> @@ -276,7 +278,7 @@ void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb,=
 void *fdt, int bus_off,
>      }
> =20
>      for (i =3D 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)=
); ++i) {
> -        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> =20
>          if (!nvslot->gpdev) {
>              continue;
> @@ -354,7 +356,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *s=
phb, void *fdt)
> =20
>      /* Add memory nodes for GPU RAM and mark them unusable */
>      for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> -        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
>          Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
>                                                      "nvlink2-mr[0]", NUL=
L);
>          uint32_t associativity[] =3D {
> @@ -398,7 +400,7 @@ void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *de=
v, void *fdt, int offset,
>      }
> =20
>      for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> -        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> =20
>          /* Skip "slot" without attached GPU */
>          if (!nvslot->gpdev) {
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 1b61162f918e..abd87605b270 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -34,15 +34,21 @@
> =20
>  typedef struct SpaprPhbState SpaprPhbState;
> =20
> -typedef struct spapr_pci_msi {
> +typedef struct SpaprPciMsi {
>      uint32_t first_irq;
>      uint32_t num;
> -} spapr_pci_msi;
> +} SpaprPciMsi;
> =20
> -typedef struct spapr_pci_msi_mig {
> +typedef struct SpaprPciMsiMig {
>      uint32_t key;
> -    spapr_pci_msi value;
> -} spapr_pci_msi_mig;
> +    SpaprPciMsi value;
> +} SpaprPciMsiMig;
> +
> +typedef struct SpaprPciLsi {
> +    uint32_t irq;
> +} SpaprPciLsi;
> +
> +typedef struct SpaprPhbPciNvGpuConfig SpaprPhbPciNvGpuConfig;
> =20
>  struct SpaprPhbState {
>      PCIHostState parent_obj;
> @@ -63,14 +69,12 @@ struct SpaprPhbState {
>      AddressSpace iommu_as;
>      MemoryRegion iommu_root;
> =20
> -    struct spapr_pci_lsi {
> -        uint32_t irq;
> -    } lsi_table[PCI_NUM_PINS];
> +    SpaprPciLsi lsi_table[PCI_NUM_PINS];
> =20
>      GHashTable *msi;
>      /* Temporary cache for migration purposes */
>      int32_t msi_devs_num;
> -    spapr_pci_msi_mig *msi_devs;
> +    SpaprPciMsiMig *msi_devs;
> =20
>      QLIST_ENTRY(SpaprPhbState) list;
> =20
> @@ -89,7 +93,7 @@ struct SpaprPhbState {
>      hwaddr mig_io_win_addr, mig_io_win_size;
>      hwaddr nv2_gpa_win_addr;
>      hwaddr nv2_atsd_win_addr;
> -    struct spapr_phb_pci_nvgpu_config *nvgpus;
> +    SpaprPhbPciNvGpuConfig *nvgpus;
>  };
> =20
>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1nDk8ACgkQbDjKyiDZ
s5KrvhAAsHMppqpEPyXQ8LdDZ4mdDk2LJuH8fj5WSDJbiMT5+cIsJjfHwY3hgssN
kZO7XnH/w55mSizyv6fPhC8JEc1eelRxMLNJnLRwhYQI2pbnR455t3wZInCPDT0S
7sca3T4JEOAnXYYKB1VAiJrNDGUVem8o6R8O2PjpXg1LmO1aDD0G3pUdWxSJdG/Z
tSeJj6Q3FcL18q/2XLMs9SILldX317pgfGR4I4s3Gv/MUaHcOuzWIJxzdznYAqLi
K8b2nUnwS6ceg2UUp+AEsZaqknnO/Jdr4Qc/C/eTL3sz2/KpixM6f3mUsFYqDNDr
qaOPrtABQCKhJE6zV2AKn/rU6C/VEJcGNGyoZwGrtgqONlKLrns1Xy2hjHCVOyE7
UO1d/Asi+RDbC80GH3Iey3Sr+8BjpOIPQepeOUtBQ5CWhowLAWWclQ0QgZv/Sb6B
wrVPrtc1dOCTvY2dE8MPPYhzYctWlpVs6b8jp5ioIFG/qoj9pxsRjgdBg+gnFRrX
ZDi9kACiYbXd+V11/f+RF/xvTDvGsdU0Cw8e80NL/QY/rKKqT9H+T8xxDghsjssG
HUrEmmSp88aoU22WNoaSzkZU7OvCNKtkU345Ud+05EuZwnFUzswR9QYsQqceaabq
WWHA7BuhdXqIuYU6lHO0S3bD3bVcCM5wvvJ/NnNV26hG+27fdQQ=
=LOt6
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

