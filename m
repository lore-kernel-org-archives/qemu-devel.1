Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E27C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B342189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="irZwQ0fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B342189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Dt6-0003wN-6d
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dc7-0004Mn-CM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dc1-0003kc-Je
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:55 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34427)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dc0-0003hb-M3; Thu, 29 Aug 2019 02:08:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscP3Bxpz9sPw; Thu, 29 Aug 2019 16:08:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058917;
 bh=U74OssPZxtKJvjYKFLFjJPW2i3L0ZrZlk8ui9Yo/180=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=irZwQ0fUTaLToVo/+KDNetUPPM80zdOCtm06Exi4a1TczgOWl5mOVW+ovqyuBOx3h
 SptEYXGtQy6MXhoazRwV8wLVFBlSHX1SA72YKm+02+RkP2N00hECLy8m3zWNcslZ6y
 z9nGeALXnPR93tUa/fhEipfpLFeqE2jOj9SJHZXk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:26 +1000
Message-Id: <20190829060827.25731-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 18/19] spapr/pci: Convert types to QEMU coding
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The QEMU coding style requires:
- to typedef structured types (HACKING)
- to use CamelCase for types and structure names (CODING_STYLE)

Do that for PCI and Nvlink2 code.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156701644465.505236.2850655823182656869.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c          | 28 +++++++++++++-------------
 hw/ppc/spapr_pci_nvlink2.c  | 40 +++++++++++++++++++------------------
 include/hw/pci-host/spapr.h | 24 ++++++++++++----------
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9f176f463e..a777fb3e7f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -280,7 +280,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
     unsigned int irq, max_irqs =3D 0;
     SpaprPhbState *phb =3D NULL;
     PCIDevice *pdev =3D NULL;
-    spapr_pci_msi *msi;
+    SpaprPciMsi *msi;
     int *config_addr_key;
     Error *err =3D NULL;
     int i;
@@ -328,7 +328,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
         return;
     }
=20
-    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr=
);
+    msi =3D (SpaprPciMsi *) g_hash_table_lookup(phb->msi, &config_addr);
=20
     /* Releasing MSIs */
     if (!req_num) {
@@ -415,7 +415,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
                      irq, req_num);
=20
     /* Add MSI device to cache */
-    msi =3D g_new(spapr_pci_msi, 1);
+    msi =3D g_new(SpaprPciMsi, 1);
     msi->first_irq =3D irq;
     msi->num =3D req_num;
     config_addr_key =3D g_new(int, 1);
@@ -446,7 +446,7 @@ static void rtas_ibm_query_interrupt_source_number(Po=
werPCCPU *cpu,
     unsigned int intr_src_num =3D -1, ioa_intr_num =3D rtas_ld(args, 3);
     SpaprPhbState *phb =3D NULL;
     PCIDevice *pdev =3D NULL;
-    spapr_pci_msi *msi;
+    SpaprPciMsi *msi;
=20
     /* Find SpaprPhbState */
     phb =3D spapr_pci_find_phb(spapr, buid);
@@ -459,7 +459,7 @@ static void rtas_ibm_query_interrupt_source_number(Po=
werPCCPU *cpu,
     }
=20
     /* Find device descriptor and start IRQ */
-    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr=
);
+    msi =3D (SpaprPciMsi *) g_hash_table_lookup(phb->msi, &config_addr);
     if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >=3D msi->=
num)) {
         trace_spapr_pci_msi("Failed to return vector", config_addr);
         rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -1806,7 +1806,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
     SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-    spapr_pci_msi *msi =3D opaque;
+    SpaprPciMsi *msi =3D opaque;
=20
     if (!smc->legacy_irq_allocation) {
         spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
@@ -2120,7 +2120,7 @@ static const VMStateDescription vmstate_spapr_pci_l=
si =3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
+        VMSTATE_UINT32_EQUAL(irq, SpaprPciLsi, NULL),
=20
         VMSTATE_END_OF_LIST()
     },
@@ -2131,9 +2131,9 @@ static const VMStateDescription vmstate_spapr_pci_m=
si =3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField []) {
-        VMSTATE_UINT32(key, spapr_pci_msi_mig),
-        VMSTATE_UINT32(value.first_irq, spapr_pci_msi_mig),
-        VMSTATE_UINT32(value.num, spapr_pci_msi_mig),
+        VMSTATE_UINT32(key, SpaprPciMsiMig),
+        VMSTATE_UINT32(value.first_irq, SpaprPciMsiMig),
+        VMSTATE_UINT32(value.num, SpaprPciMsiMig),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -2165,12 +2165,12 @@ static int spapr_pci_pre_save(void *opaque)
     if (!sphb->msi_devs_num) {
         return 0;
     }
-    sphb->msi_devs =3D g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
+    sphb->msi_devs =3D g_new(SpaprPciMsiMig, sphb->msi_devs_num);
=20
     g_hash_table_iter_init(&iter, sphb->msi);
     for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
         sphb->msi_devs[i].key =3D *(uint32_t *) key;
-        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
+        sphb->msi_devs[i].value =3D *(SpaprPciMsi *) value;
     }
=20
     return 0;
@@ -2217,10 +2217,10 @@ static const VMStateDescription vmstate_spapr_pci=
 =3D {
         VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migr=
ation),
         VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migr=
ation),
         VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
-                             vmstate_spapr_pci_lsi, struct spapr_pci_lsi=
),
+                             vmstate_spapr_pci_lsi, SpaprPciLsi),
         VMSTATE_INT32(msi_devs_num, SpaprPhbState),
         VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, SpaprPhbState, msi_devs_nu=
m, 0,
-                                    vmstate_spapr_pci_msi, spapr_pci_msi=
_mig),
+                                    vmstate_spapr_pci_msi, SpaprPciMsiMi=
g),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index eda8c752aa..4aa89ede23 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -39,11 +39,7 @@
=20
 #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
=20
-struct spapr_phb_pci_nvgpu_config {
-    uint64_t nv2_ram_current;
-    uint64_t nv2_atsd_current;
-    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] *=
/
-    struct spapr_phb_pci_nvgpu_slot {
+typedef struct SpaprPhbPciNvGpuSlot {
         uint64_t tgt;
         uint64_t gpa;
         unsigned numa_id;
@@ -54,12 +50,18 @@ struct spapr_phb_pci_nvgpu_config {
             PCIDevice *npdev;
             uint32_t link_speed;
         } links[NVGPU_MAX_LINKS];
-    } slots[NVGPU_MAX_NUM];
+} SpaprPhbPciNvGpuSlot;
+
+struct SpaprPhbPciNvGpuConfig {
+    uint64_t nv2_ram_current;
+    uint64_t nv2_atsd_current;
+    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] *=
/
+    SpaprPhbPciNvGpuSlot slots[NVGPU_MAX_NUM];
     Error *errp;
 };
=20
-static struct spapr_phb_pci_nvgpu_slot *
-spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus, uint64_t=
 tgt)
+static SpaprPhbPciNvGpuSlot *
+spapr_nvgpu_get_slot(SpaprPhbPciNvGpuConfig *nvgpus, uint64_t tgt)
 {
     int i;
=20
@@ -81,13 +83,13 @@ spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_confi=
g *nvgpus, uint64_t tgt)
     return &nvgpus->slots[i];
 }
=20
-static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
+static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
                                     PCIDevice *pdev, uint64_t tgt,
                                     MemoryRegion *mr, Error **errp)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
     SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
-    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
+    SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
=20
     if (!nvslot) {
         error_setg(errp, "Found too many GPUs per vPHB");
@@ -102,11 +104,11 @@ static void spapr_pci_collect_nvgpu(struct spapr_ph=
b_pci_nvgpu_config *nvgpus,
     ++spapr->gpu_numa_id;
 }
=20
-static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
+static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
                                     PCIDevice *pdev, uint64_t tgt,
                                     MemoryRegion *mr, Error **errp)
 {
-    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
+    SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
     int j;
=20
     if (!nvslot) {
@@ -138,7 +140,7 @@ static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, =
PCIDevice *pdev,
=20
     if (tgt) {
         Error *local_err =3D NULL;
-        struct spapr_phb_pci_nvgpu_config *nvgpus =3D opaque;
+        SpaprPhbPciNvGpuConfig *nvgpus =3D opaque;
         Object *mr_gpu =3D object_property_get_link(po, "nvlink2-mr[0]",=
 NULL);
         Object *mr_npu =3D object_property_get_link(po, "nvlink2-atsd-mr=
[0]",
                                                   NULL);
@@ -177,7 +179,7 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error=
 **errp)
         return;
     }
=20
-    sphb->nvgpus =3D g_new0(struct spapr_phb_pci_nvgpu_config, 1);
+    sphb->nvgpus =3D g_new0(SpaprPhbPciNvGpuConfig, 1);
     sphb->nvgpus->nv2_ram_current =3D sphb->nv2_gpa_win_addr;
     sphb->nvgpus->nv2_atsd_current =3D sphb->nv2_atsd_win_addr;
=20
@@ -194,7 +196,7 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error=
 **errp)
     /* Add found GPU RAM and ATSD MRs if found */
     for (i =3D 0, valid_gpu_num =3D 0; i < sphb->nvgpus->num; ++i) {
         Object *nvmrobj;
-        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
=20
         if (!nvslot->gpdev) {
             continue;
@@ -242,7 +244,7 @@ void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
     }
=20
     for (i =3D 0; i < sphb->nvgpus->num; ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
         Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
                                                     "nvlink2-mr[0]", NUL=
L);
=20
@@ -276,7 +278,7 @@ void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb,=
 void *fdt, int bus_off,
     }
=20
     for (i =3D 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)=
); ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
=20
         if (!nvslot->gpdev) {
             continue;
@@ -354,7 +356,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *s=
phb, void *fdt)
=20
     /* Add memory nodes for GPU RAM and mark them unusable */
     for (i =3D 0; i < sphb->nvgpus->num; ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
         Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
                                                     "nvlink2-mr[0]", NUL=
L);
         uint32_t associativity[] =3D {
@@ -398,7 +400,7 @@ void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *de=
v, void *fdt, int offset,
     }
=20
     for (i =3D 0; i < sphb->nvgpus->num; ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
+        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
=20
         /* Skip "slot" without attached GPU */
         if (!nvslot->gpdev) {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 1b61162f91..abd87605b2 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -34,15 +34,21 @@
=20
 typedef struct SpaprPhbState SpaprPhbState;
=20
-typedef struct spapr_pci_msi {
+typedef struct SpaprPciMsi {
     uint32_t first_irq;
     uint32_t num;
-} spapr_pci_msi;
+} SpaprPciMsi;
=20
-typedef struct spapr_pci_msi_mig {
+typedef struct SpaprPciMsiMig {
     uint32_t key;
-    spapr_pci_msi value;
-} spapr_pci_msi_mig;
+    SpaprPciMsi value;
+} SpaprPciMsiMig;
+
+typedef struct SpaprPciLsi {
+    uint32_t irq;
+} SpaprPciLsi;
+
+typedef struct SpaprPhbPciNvGpuConfig SpaprPhbPciNvGpuConfig;
=20
 struct SpaprPhbState {
     PCIHostState parent_obj;
@@ -63,14 +69,12 @@ struct SpaprPhbState {
     AddressSpace iommu_as;
     MemoryRegion iommu_root;
=20
-    struct spapr_pci_lsi {
-        uint32_t irq;
-    } lsi_table[PCI_NUM_PINS];
+    SpaprPciLsi lsi_table[PCI_NUM_PINS];
=20
     GHashTable *msi;
     /* Temporary cache for migration purposes */
     int32_t msi_devs_num;
-    spapr_pci_msi_mig *msi_devs;
+    SpaprPciMsiMig *msi_devs;
=20
     QLIST_ENTRY(SpaprPhbState) list;
=20
@@ -89,7 +93,7 @@ struct SpaprPhbState {
     hwaddr mig_io_win_addr, mig_io_win_size;
     hwaddr nv2_gpa_win_addr;
     hwaddr nv2_atsd_win_addr;
-    struct spapr_phb_pci_nvgpu_config *nvgpus;
+    SpaprPhbPciNvGpuConfig *nvgpus;
 };
=20
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
--=20
2.21.0


