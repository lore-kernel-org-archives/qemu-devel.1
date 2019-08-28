Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 18:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0FA22CF5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 18:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0FA22CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i32aA-0005dd-Lm
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 14:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i32Yz-0004qR-BY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i32Yv-0008NA-U3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:20:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39072
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i32Yv-0008MN-MP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:20:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7SICWRn133382
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 14:20:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2unv8d66s7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 14:20:50 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 28 Aug 2019 19:20:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 28 Aug 2019 19:20:46 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7SIKjQX49741864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 18:20:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D316A4062;
 Wed, 28 Aug 2019 18:20:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02F70A405C;
 Wed, 28 Aug 2019 18:20:45 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.62.210])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 28 Aug 2019 18:20:44 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 28 Aug 2019 20:20:44 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082818-0016-0000-0000-000002A3FBBD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082818-0017-0000-0000-000033044DB4
Message-Id: <156701644465.505236.2850655823182656869.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-28_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280178
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] spapr/pci: Convert types to QEMU coding style
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

The QEMU coding style requires:
- to typedef structured types (HACKING)
- to use CamelCase for types and structure names (CODING_STYLE)

Do that for PCI and Nvlink2 code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c          |   28 ++++++++++++++--------------
 hw/ppc/spapr_pci_nvlink2.c  |   40 +++++++++++++++++++++-------------------
 include/hw/pci-host/spapr.h |   24 ++++++++++++++----------
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9f176f463e76..a777fb3e7ff6 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -280,7 +280,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
     unsigned int irq, max_irqs = 0;
     SpaprPhbState *phb = NULL;
     PCIDevice *pdev = NULL;
-    spapr_pci_msi *msi;
+    SpaprPciMsi *msi;
     int *config_addr_key;
     Error *err = NULL;
     int i;
@@ -328,7 +328,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return;
     }
 
-    msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
+    msi = (SpaprPciMsi *) g_hash_table_lookup(phb->msi, &config_addr);
 
     /* Releasing MSIs */
     if (!req_num) {
@@ -415,7 +415,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
                      irq, req_num);
 
     /* Add MSI device to cache */
-    msi = g_new(spapr_pci_msi, 1);
+    msi = g_new(SpaprPciMsi, 1);
     msi->first_irq = irq;
     msi->num = req_num;
     config_addr_key = g_new(int, 1);
@@ -446,7 +446,7 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
     unsigned int intr_src_num = -1, ioa_intr_num = rtas_ld(args, 3);
     SpaprPhbState *phb = NULL;
     PCIDevice *pdev = NULL;
-    spapr_pci_msi *msi;
+    SpaprPciMsi *msi;
 
     /* Find SpaprPhbState */
     phb = spapr_pci_find_phb(spapr, buid);
@@ -459,7 +459,7 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
     }
 
     /* Find device descriptor and start IRQ */
-    msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
+    msi = (SpaprPciMsi *) g_hash_table_lookup(phb->msi, &config_addr);
     if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >= msi->num)) {
         trace_spapr_pci_msi("Failed to return vector", config_addr);
         rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -1806,7 +1806,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-    spapr_pci_msi *msi = opaque;
+    SpaprPciMsi *msi = opaque;
 
     if (!smc->legacy_irq_allocation) {
         spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
@@ -2120,7 +2120,7 @@ static const VMStateDescription vmstate_spapr_pci_lsi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
+        VMSTATE_UINT32_EQUAL(irq, SpaprPciLsi, NULL),
 
         VMSTATE_END_OF_LIST()
     },
@@ -2131,9 +2131,9 @@ static const VMStateDescription vmstate_spapr_pci_msi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField []) {
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
-    sphb->msi_devs = g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
+    sphb->msi_devs = g_new(SpaprPciMsiMig, sphb->msi_devs_num);
 
     g_hash_table_iter_init(&iter, sphb->msi);
     for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
         sphb->msi_devs[i].key = *(uint32_t *) key;
-        sphb->msi_devs[i].value = *(spapr_pci_msi *) value;
+        sphb->msi_devs[i].value = *(SpaprPciMsi *) value;
     }
 
     return 0;
@@ -2217,10 +2217,10 @@ static const VMStateDescription vmstate_spapr_pci = {
         VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migration),
         VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migration),
         VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
-                             vmstate_spapr_pci_lsi, struct spapr_pci_lsi),
+                             vmstate_spapr_pci_lsi, SpaprPciLsi),
         VMSTATE_INT32(msi_devs_num, SpaprPhbState),
         VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, SpaprPhbState, msi_devs_num, 0,
-                                    vmstate_spapr_pci_msi, spapr_pci_msi_mig),
+                                    vmstate_spapr_pci_msi, SpaprPciMsiMig),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index eda8c752aa22..4aa89ede23e6 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -39,11 +39,7 @@
 
 #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
 
-struct spapr_phb_pci_nvgpu_config {
-    uint64_t nv2_ram_current;
-    uint64_t nv2_atsd_current;
-    int num; /* number of non empty (i.e. tgt!=0) entries in slots[] */
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
+    int num; /* number of non empty (i.e. tgt!=0) entries in slots[] */
+    SpaprPhbPciNvGpuSlot slots[NVGPU_MAX_NUM];
     Error *errp;
 };
 
-static struct spapr_phb_pci_nvgpu_slot *
-spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus, uint64_t tgt)
+static SpaprPhbPciNvGpuSlot *
+spapr_nvgpu_get_slot(SpaprPhbPciNvGpuConfig *nvgpus, uint64_t tgt)
 {
     int i;
 
@@ -81,13 +83,13 @@ spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus, uint64_t tgt)
     return &nvgpus->slots[i];
 }
 
-static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *nvgpus,
+static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
                                     PCIDevice *pdev, uint64_t tgt,
                                     MemoryRegion *mr, Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
-    struct spapr_phb_pci_nvgpu_slot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
+    SpaprPhbPciNvGpuSlot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
 
     if (!nvslot) {
         error_setg(errp, "Found too many GPUs per vPHB");
@@ -102,11 +104,11 @@ static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *nvgpus,
     ++spapr->gpu_numa_id;
 }
 
-static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_config *nvgpus,
+static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
                                     PCIDevice *pdev, uint64_t tgt,
                                     MemoryRegion *mr, Error **errp)
 {
-    struct spapr_phb_pci_nvgpu_slot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
+    SpaprPhbPciNvGpuSlot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
     int j;
 
     if (!nvslot) {
@@ -138,7 +140,7 @@ static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
 
     if (tgt) {
         Error *local_err = NULL;
-        struct spapr_phb_pci_nvgpu_config *nvgpus = opaque;
+        SpaprPhbPciNvGpuConfig *nvgpus = opaque;
         Object *mr_gpu = object_property_get_link(po, "nvlink2-mr[0]", NULL);
         Object *mr_npu = object_property_get_link(po, "nvlink2-atsd-mr[0]",
                                                   NULL);
@@ -177,7 +179,7 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **errp)
         return;
     }
 
-    sphb->nvgpus = g_new0(struct spapr_phb_pci_nvgpu_config, 1);
+    sphb->nvgpus = g_new0(SpaprPhbPciNvGpuConfig, 1);
     sphb->nvgpus->nv2_ram_current = sphb->nv2_gpa_win_addr;
     sphb->nvgpus->nv2_atsd_current = sphb->nv2_atsd_win_addr;
 
@@ -194,7 +196,7 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **errp)
     /* Add found GPU RAM and ATSD MRs if found */
     for (i = 0, valid_gpu_num = 0; i < sphb->nvgpus->num; ++i) {
         Object *nvmrobj;
-        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
 
         if (!nvslot->gpdev) {
             continue;
@@ -242,7 +244,7 @@ void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
     }
 
     for (i = 0; i < sphb->nvgpus->num; ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
         Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
                                                     "nvlink2-mr[0]", NULL);
 
@@ -276,7 +278,7 @@ void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void *fdt, int bus_off,
     }
 
     for (i = 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)); ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
 
         if (!nvslot->gpdev) {
             continue;
@@ -354,7 +356,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
 
     /* Add memory nodes for GPU RAM and mark them unusable */
     for (i = 0; i < sphb->nvgpus->num; ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
         Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
                                                     "nvlink2-mr[0]", NULL);
         uint32_t associativity[] = {
@@ -398,7 +400,7 @@ void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,
     }
 
     for (i = 0; i < sphb->nvgpus->num; ++i) {
-        struct spapr_phb_pci_nvgpu_slot *nvslot = &sphb->nvgpus->slots[i];
+        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
 
         /* Skip "slot" without attached GPU */
         if (!nvslot->gpdev) {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 1b61162f918e..abd87605b270 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -34,15 +34,21 @@
 
 typedef struct SpaprPhbState SpaprPhbState;
 
-typedef struct spapr_pci_msi {
+typedef struct SpaprPciMsi {
     uint32_t first_irq;
     uint32_t num;
-} spapr_pci_msi;
+} SpaprPciMsi;
 
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
 
 struct SpaprPhbState {
     PCIHostState parent_obj;
@@ -63,14 +69,12 @@ struct SpaprPhbState {
     AddressSpace iommu_as;
     MemoryRegion iommu_root;
 
-    struct spapr_pci_lsi {
-        uint32_t irq;
-    } lsi_table[PCI_NUM_PINS];
+    SpaprPciLsi lsi_table[PCI_NUM_PINS];
 
     GHashTable *msi;
     /* Temporary cache for migration purposes */
     int32_t msi_devs_num;
-    spapr_pci_msi_mig *msi_devs;
+    SpaprPciMsiMig *msi_devs;
 
     QLIST_ENTRY(SpaprPhbState) list;
 
@@ -89,7 +93,7 @@ struct SpaprPhbState {
     hwaddr mig_io_win_addr, mig_io_win_size;
     hwaddr nv2_gpa_win_addr;
     hwaddr nv2_atsd_win_addr;
-    struct spapr_phb_pci_nvgpu_config *nvgpus;
+    SpaprPhbPciNvGpuConfig *nvgpus;
 };
 
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL


