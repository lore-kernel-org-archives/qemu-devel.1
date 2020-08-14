Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB356C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B8523A75
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqVa/H6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B8523A75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yCR-0002OE-SH
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yBX-00016R-A9; Sat, 15 Aug 2020 11:33:31 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:35173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yBV-0004xZ-1K; Sat, 15 Aug 2020 11:33:30 -0400
Received: by mail-qt1-x82d.google.com with SMTP id f19so4720871qtp.2;
 Sat, 15 Aug 2020 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f42z7yJKbICMlp0GorR8LWKXjVDSLal1ldANVqdFcOw=;
 b=oqVa/H6HBzIOyp3VvcSLAYcAbeHhwJGISXFT6+5m3WbVlPjp/IxsMmAgaDRO1x7vjD
 0IYPO7fQYiCY/ByxM+4cRvXUxw4WI2bZsbcx3L82687NUcFAJ9I/QlOdQg6UGnWXCjz4
 1MhppO1zKB5YizA4tpb4HIuWrpoFH8LFQ0mhuaMvAhaej6KrRmsKCQOd2sQli//ux3zF
 EUYeRGivDlaMnwnVCDcP7i0m2lRkG3F+AHP6LpE6qvMWzr0h4srAJPVBYmssfPTq8QL0
 mCLYSFNhuJKft7idTht/eaxtmu1ll4nOSYhP8I6mTLSZchrR3cU+ZhNCq67xXJafCn/p
 nz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f42z7yJKbICMlp0GorR8LWKXjVDSLal1ldANVqdFcOw=;
 b=R5N8QKN7n+c29ACcHaLsyhjh+vBoekQPCfcYSmi3kVc9XFDmtL+9189q4r+mQknK56
 FygLKr9QYm5qcp9ZZieMThk4Jlluvos6u66vLinfeYbeDJmNarfjzRi9IiHMuqBFYULR
 fM5oQKQHSg2K93Fsk9U+PvpVOFtSPLrM3tAuOTmfiqq5vKwAJuijJAnc6Yg6g/4XUiBZ
 /y84AupWQXlvtLiyzfMkOekY/nNo5mGFm5PMc3HEodCcrXhbyjpdxJFMbVZxg0b2s2e2
 iH1E+yLMr4SWHcTMtKm+7wNhkWKWbUdofQIfC3j9aV0OiosEyC6884keKrtTuunbdqD8
 rt9A==
X-Gm-Message-State: AOAM530K4SZiA9ge3ySsaidJmOabm1Abudg+3gRA+2mgwN4Zg97IV4dV
 5M2jC2veS2OvHZwfL1yfulokymnrVdXftg==
X-Google-Smtp-Source: ABdhPJzKerYa+S7J4ziQb9VytAnbLvKoPyteCtonJAkPtLWNtOdqTgd3/Hcbs2XKGp8MYgyWewglHA==
X-Received: by 2002:ac8:1bb7:: with SMTP id z52mr3859469qtj.221.1597438491264; 
 Fri, 14 Aug 2020 13:54:51 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:50 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] spapr: introduce SpaprMachineClass::numa_assoc_domains
Date: Fri, 14 Aug 2020 17:54:22 -0300
Message-Id: <20200814205424.543857-9-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x82d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can't use the input from machine->numa_state->nodes directly
in the pSeries machine because PAPR does not work with raw distance
values, like ACPI SLIT does. We need to determine common
associativity domains, based on similar performance/distance of the
resources, and set these domains in the associativy array that goes
to the FDT of each resource.

To ease the translation between regular ACPI NUMA distance info
to our PAPR dialect, let's create a matrix called numa_assoc_domains
in the SpaprMachineClass. This matrix will be initiated during
machine init, where  we will read NUMA information from user input,
apply a heuristic to determine the associativity domains for each node,
then populate numa_assoc_domains accordingly.

The changes are mostly centered in the spapr_set_associativity()
helper that will use the values of numa_assoc_domains instead of
using 0x0, with spapr_dt_dynamic_reconfiguration_memory() and
h_home_node_associativity() being the exceptions.

To keep the changes under control, we'll plug in the matrix usage
in the existing code first. The actual heuristic to determine
the associativity domains for each NUMA node will come in a follow-up
patch.

Note that the matrix is initiated with zeros, meaning that there is
no guest changes implemented in this patch. We'll keep these
changes from legacy NUMA guests by not initiating the matrix
in these cases.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c                | 46 +++++++++++++++++++++++------------
 hw/ppc/spapr_hcall.c          | 13 ++++++++--
 hw/ppc/spapr_nvdimm.c         | 13 +++++-----
 hw/ppc/spapr_pci.c            |  3 ++-
 include/hw/ppc/spapr.h        |  7 +++++-
 include/hw/ppc/spapr_nvdimm.h |  5 ++--
 6 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b80a6f6936..4f50ab21ee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -201,8 +201,13 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     return ret;
 }
 
-void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index)
+void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index,
+                             MachineState *machine)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    uint8_t assoc_domain1 = smc->numa_assoc_domains[node_id][0];
+    uint8_t assoc_domain2 = smc->numa_assoc_domains[node_id][1];
+    uint8_t assoc_domain3 = smc->numa_assoc_domains[node_id][2];
     uint8_t assoc_size = 0x4;
 
     if (cpu_index >= 0) {
@@ -211,17 +216,18 @@ void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index)
     }
 
     assoc[0] = cpu_to_be32(assoc_size);
-    assoc[1] = cpu_to_be32(0x0);
-    assoc[2] = cpu_to_be32(0x0);
-    assoc[3] = cpu_to_be32(0x0);
+    assoc[1] = cpu_to_be32(assoc_domain1);
+    assoc[2] = cpu_to_be32(assoc_domain2);
+    assoc[3] = cpu_to_be32(assoc_domain3);
     assoc[4] = cpu_to_be32(node_id);
 }
 
-static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
+static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu,
+                                   MachineState *machine)
 {
     int index = spapr_get_vcpu_id(cpu);
     uint32_t associativity[6];
-    spapr_set_associativity(associativity, cpu->node_id, index);
+    spapr_set_associativity(associativity, cpu->node_id, index, machine);
 
     /* Advertise NUMA via ibm,associativity */
     return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
@@ -335,14 +341,14 @@ static void add_str(GString *s, const gchar *s1)
 }
 
 static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
-                                hwaddr size)
+                                hwaddr size, MachineState *machine)
 {
     uint32_t associativity[5];
     char mem_name[32];
     uint64_t mem_reg_property[2];
     int off;
 
-    spapr_set_associativity(associativity, nodeid, -1);
+    spapr_set_associativity(associativity, nodeid, -1, machine);
 
     mem_reg_property[0] = cpu_to_be64(start);
     mem_reg_property[1] = cpu_to_be64(size);
@@ -574,6 +580,7 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
                                                    void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     int ret, i, offset;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
@@ -628,12 +635,17 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
     int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
     cur_index += 2;
     for (i = 0; i < nr_nodes; i++) {
+        uint8_t assoc_domain1 = smc->numa_assoc_domains[i][0];
+        uint8_t assoc_domain2 = smc->numa_assoc_domains[i][1];
+        uint8_t assoc_domain3 = smc->numa_assoc_domains[i][2];
+
         uint32_t associativity[] = {
-            cpu_to_be32(0x0),
-            cpu_to_be32(0x0),
-            cpu_to_be32(0x0),
+            cpu_to_be32(assoc_domain1),
+            cpu_to_be32(assoc_domain2),
+            cpu_to_be32(assoc_domain3),
             cpu_to_be32(i)
         };
+
         memcpy(cur_index, associativity, sizeof(associativity));
         cur_index += 4;
     }
@@ -667,7 +679,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
         if (!mem_start) {
             /* spapr_machine_init() checks for rma_size <= node0_size
              * already */
-            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size);
+            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size, machine);
             mem_start += spapr->rma_size;
             node_size -= spapr->rma_size;
         }
@@ -679,7 +691,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
                 sizetmp = 1ULL << ctzl(mem_start);
             }
 
-            spapr_dt_memory_node(fdt, i, mem_start, sizetmp);
+            spapr_dt_memory_node(fdt, i, mem_start, sizetmp, machine);
             node_size -= sizetmp;
             mem_start += sizetmp;
         }
@@ -809,7 +821,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
                       pft_size_prop, sizeof(pft_size_prop))));
 
     if (ms->numa_state->num_nodes > 1) {
-        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
+        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu, ms));
     }
 
     _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
@@ -1335,7 +1347,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 
     /* NVDIMM devices */
     if (mc->nvdimm_supported) {
-        spapr_dt_persistent_memory(fdt);
+        spapr_dt_persistent_memory(fdt, machine);
     }
 
     return fdt;
@@ -3453,6 +3465,7 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
+    MachineState *machine = MACHINE(spapr);
     uint64_t addr;
     uint32_t node;
 
@@ -3460,7 +3473,8 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
     node = object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PROP,
                                     &error_abort);
     *fdt_start_offset = spapr_dt_memory_node(fdt, node, addr,
-                                             SPAPR_MEMORY_BLOCK_SIZE);
+                                             SPAPR_MEMORY_BLOCK_SIZE,
+                                             machine);
     return 0;
 }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c1d01228c6..6e94e513cf 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1878,10 +1878,15 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
+    MachineState *machine = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     target_ulong flags = args[0];
     target_ulong procno = args[1];
     PowerPCCPU *tcpu;
     int idx;
+    uint8_t assoc_domain1;
+    uint8_t assoc_domain2;
+    uint8_t assoc_domain3;
 
     /* only support procno from H_REGISTER_VPA */
     if (flags != 0x1) {
@@ -1893,13 +1898,17 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
         return H_P2;
     }
 
+    assoc_domain1 = smc->numa_assoc_domains[tcpu->node_id][0];
+    assoc_domain2 = smc->numa_assoc_domains[tcpu->node_id][1];
+    assoc_domain3 = smc->numa_assoc_domains[tcpu->node_id][2];
+
     /* sequence is the same as in the "ibm,associativity" property */
 
     idx = 0;
 #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
                              ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
+    args[idx++] = ASSOCIATIVITY(assoc_domain1, assoc_domain2);
+    args[idx++] = ASSOCIATIVITY(assoc_domain3, tcpu->node_id);
     args[idx++] = ASSOCIATIVITY(procno, -1);
     for ( ; idx < 6; idx++) {
         args[idx] = -1;
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index bd109bfc00..7f1f088c39 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -87,8 +87,9 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(drc->dev);
+    MachineState *machine = MACHINE(spapr);
 
-    *fdt_start_offset = spapr_dt_nvdimm(fdt, 0, nvdimm);
+    *fdt_start_offset = spapr_dt_nvdimm(fdt, 0, nvdimm, machine);
 
     return 0;
 }
@@ -104,8 +105,8 @@ void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
 }
 
 
-int spapr_dt_nvdimm(void *fdt, int parent_offset,
-                           NVDIMMDevice *nvdimm)
+int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm,
+                    MachineState *machine)
 {
     int child_offset;
     char *buf;
@@ -120,7 +121,7 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
     uint64_t size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
                                             NULL);
 
-    spapr_set_associativity(associativity, node, -1);
+    spapr_set_associativity(associativity, node, -1, machine);
 
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
     g_assert(drc);
@@ -159,7 +160,7 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
     return child_offset;
 }
 
-void spapr_dt_persistent_memory(void *fdt)
+void spapr_dt_persistent_memory(void *fdt, MachineState *machine)
 {
     int offset = fdt_subnode_offset(fdt, 0, "persistent-memory");
     GSList *iter, *nvdimms = nvdimm_get_device_list();
@@ -177,7 +178,7 @@ void spapr_dt_persistent_memory(void *fdt)
     for (iter = nvdimms; iter; iter = iter->next) {
         NVDIMMDevice *nvdimm = iter->data;
 
-        spapr_dt_nvdimm(fdt, offset, nvdimm);
+        spapr_dt_nvdimm(fdt, offset, nvdimm, machine);
     }
     g_slist_free(nvdimms);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c02ace226c..4d9ef63f3e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2355,7 +2355,8 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
 
     /* Advertise NUMA via ibm,associativity */
     if (phb->numa_node != -1) {
-        spapr_set_associativity(associativity, phb->numa_node, -1);
+        MachineState *machine = MACHINE(spapr);
+        spapr_set_associativity(associativity, phb->numa_node, -1, machine);
         _FDT(fdt_setprop(fdt, bus_off, "ibm,associativity", associativity,
                          sizeof(associativity)));
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cd158bf95a..1f9700ac19 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -104,6 +104,9 @@ typedef enum {
 
 #define FDT_MAX_SIZE                    0x100000
 
+/* Taken from Linux kernel arch/powerpc/mm/numa.h */
+#define MAX_DISTANCE_REF_POINTS         4
+
 typedef struct SpaprCapabilities SpaprCapabilities;
 struct SpaprCapabilities {
     uint8_t caps[SPAPR_CAP_NUM];
@@ -131,6 +134,7 @@ struct SpaprMachineClass {
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
+    uint8_t numa_assoc_domains[MAX_NODES][MAX_DISTANCE_REF_POINTS-1];
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
@@ -863,7 +867,8 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 
 void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
-void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index);
+void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index,
+                             MachineState *machine);
 
 #define TYPE_SPAPR_RNG "spapr-rng"
 
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index b3330cc485..be30773c7d 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -27,8 +27,9 @@ QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_MEMORY_BLOCK_SIZE);
 
 int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
-int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm);
-void spapr_dt_persistent_memory(void *fdt);
+int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm,
+                    MachineState *machine);
+void spapr_dt_persistent_memory(void *fdt, MachineState *machine);
 void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
                                 Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
-- 
2.26.2


