Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989DFC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4409320716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNunQ9kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4409320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxQ7-0002LC-G7
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNf-0006I5-TL; Thu, 03 Sep 2020 18:06:55 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:39748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNd-0007RC-GM; Thu, 03 Sep 2020 18:06:55 -0400
Received: by mail-qt1-x844.google.com with SMTP id 92so3194939qtb.6;
 Thu, 03 Sep 2020 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+upsevs/BTkj+6JCHslmbD/e7PT+189Qq4R2MNrZUc=;
 b=ZNunQ9kRH/B6XP2S6bovBw67NmMoai14BjWUD9iL8klsBFpfBhLJnQ2YF1Z0H34hp1
 /dfyH+ueLWRrEK7GPKy7dD0qCaixqajs2L4Q08tQcJ8RDGE2reRTKQp0DrxPpbvM2R/X
 uSqbN3ftDRvU1n+5HzNcxem/AQKmreDu6Hm5AjU/B2h2iMfiykIfjwfLmm5b/0hEKa4e
 6VpNbwuVkSoJ5SSJx0CfNRJu3w/cKmY/Pl5GjBdX98hgt0zOTtUcFdCF+petmpLtY0ZD
 zD6EpYoXsJo+9RUDmphrhHZMnOIoGfWcBdjRheH4hF9zpjL5yXz7+LSbTwfFkEI5mxIN
 L8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+upsevs/BTkj+6JCHslmbD/e7PT+189Qq4R2MNrZUc=;
 b=C/TgkjO7VW+ooBUJjogGTftCuaRaa/9VcIxJnxpqJGrn3N8sCyw8bo+7j9XpAbLOKG
 I7BksGhouO47kWxJybh9sfjSufBJmjEo4Tq2zWtk1m/OU7mUfosSc54P09ogZmrbsRXl
 PP99hqqqAMaWwAVPOCAZIsZLszZ5HBdbJWrILy/BDsUWG4jotQ0c7u1mtX9BRpcrekAi
 rY4mADAWleiyLjvdje43gsf3yZ1k/H35knVCHfAoGCodMQ/PAznwbCMWxPjzT9a8LLo0
 owkS2mGKoQCqzWt67nxG3VDM2P3Lt5JMCzzj2V2NxLSA9cxORtQv9iXHfmmbJAL7W4rN
 O/Dg==
X-Gm-Message-State: AOAM533WaH/6kDxzq8BZ1acUl3OSY0dZRWgk+urmucNyUV0MQhBObd3D
 pTlObnVqKI7o29ihlBU5xQOpyFlFmc4UDg==
X-Google-Smtp-Source: ABdhPJxLqIlAuzqTwC5ad/awWRrTPxtwjCDSuDmj+MvSosJKI2GnqWxZ6Kvq0sdpYvRLPx10Zknr5Q==
X-Received: by 2002:aed:2986:: with SMTP id o6mr5768245qtd.269.1599170811098; 
 Thu, 03 Sep 2020 15:06:51 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:50 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] spapr: introduce SpaprMachineState::numa_assoc_array
Date: Thu,  3 Sep 2020 19:06:33 -0300
Message-Id: <20200903220639.563090-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903220639.563090-1-danielhb413@gmail.com>
References: <20200903220639.563090-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x844.google.com
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

The next step to centralize all NUMA/associativity handling in
the spapr machine is to create a 'one stop place' for all
things ibm,associativity.

This patch introduces numa_assoc_array, a 2 dimensional array
that will store all ibm,associativity arrays of all NUMA nodes.
This array is initialized in a new spapr_numa_associativity_init()
function, called in spapr_machine_init(). It is being initialized
with the same values used in other ibm,associativity properties
around spapr files (i.e. all zeros, last value is node_id).
The idea is to remove all hardcoded definitions and FDT writes
of ibm,associativity arrays, doing instead a call to the new
helper spapr_numa_write_associativity_dt() helper, that will
be able to write the DT with the correct values.

We'll start small, handling the trivial cases first. The
remaining instances of ibm,associativity will be handled
next.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c                | 23 ++++++++++-------------
 hw/ppc/spapr_numa.c           | 30 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_nvdimm.c         | 19 +++++++------------
 hw/ppc/spapr_pci.c            |  9 ++-------
 include/hw/ppc/spapr.h        | 12 ++++++++++++
 include/hw/ppc/spapr_numa.h   | 11 +++++++++++
 include/hw/ppc/spapr_nvdimm.h |  2 +-
 7 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a45912acac..1ad6f59863 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -314,14 +314,9 @@ static void add_str(GString *s, const gchar *s1)
     g_string_append_len(s, s1, strlen(s1) + 1);
 }
 
-static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
-                                hwaddr size)
+static int spapr_dt_memory_node(SpaprMachineState *spapr, void *fdt, int nodeid,
+                                hwaddr start, hwaddr size)
 {
-    uint32_t associativity[] = {
-        cpu_to_be32(0x4), /* length */
-        cpu_to_be32(0x0), cpu_to_be32(0x0),
-        cpu_to_be32(0x0), cpu_to_be32(nodeid)
-    };
     char mem_name[32];
     uint64_t mem_reg_property[2];
     int off;
@@ -335,8 +330,7 @@ static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
     _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
     _FDT((fdt_setprop(fdt, off, "reg", mem_reg_property,
                       sizeof(mem_reg_property))));
-    _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
-                      sizeof(associativity))));
+    spapr_numa_write_associativity_dt(spapr, fdt, off, nodeid);
     return off;
 }
 
@@ -649,7 +643,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
         if (!mem_start) {
             /* spapr_machine_init() checks for rma_size <= node0_size
              * already */
-            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size);
+            spapr_dt_memory_node(spapr, fdt, i, 0, spapr->rma_size);
             mem_start += spapr->rma_size;
             node_size -= spapr->rma_size;
         }
@@ -661,7 +655,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
                 sizetmp = 1ULL << ctzl(mem_start);
             }
 
-            spapr_dt_memory_node(fdt, i, mem_start, sizetmp);
+            spapr_dt_memory_node(spapr, fdt, i, mem_start, sizetmp);
             node_size -= sizetmp;
             mem_start += sizetmp;
         }
@@ -1275,7 +1269,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 
     /* NVDIMM devices */
     if (mc->nvdimm_supported) {
-        spapr_dt_persistent_memory(fdt);
+        spapr_dt_persistent_memory(spapr, fdt);
     }
 
     return fdt;
@@ -2810,6 +2804,9 @@ static void spapr_machine_init(MachineState *machine)
      */
     spapr->gpu_numa_id = MAX(1, machine->numa_state->num_nodes);
 
+    /* Init numa_assoc_array */
+    spapr_numa_associativity_init(spapr, machine);
+
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
                               spapr->max_compat_pvr)) {
@@ -3394,7 +3391,7 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
     addr = spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;
     node = object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PROP,
                                     &error_abort);
-    *fdt_start_offset = spapr_dt_memory_node(fdt, node, addr,
+    *fdt_start_offset = spapr_dt_memory_node(spapr, fdt, node, addr,
                                              SPAPR_MEMORY_BLOCK_SIZE);
     return 0;
 }
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index cdf3288cbd..f6b6fe648f 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -15,6 +15,36 @@
 #include "hw/ppc/spapr_numa.h"
 #include "hw/ppc/fdt.h"
 
+
+void spapr_numa_associativity_init(SpaprMachineState *spapr,
+                                   MachineState *machine)
+{
+    int nb_numa_nodes = machine->numa_state->num_nodes;
+    int i;
+
+    /*
+     * For all associativity arrays: first position is the size,
+     * position MAX_DISTANCE_REF_POINTS is always the numa_id,
+     * represented by the index 'i'.
+     *
+     * This will break on sparse NUMA setups, when/if QEMU starts
+     * to support it, because there will be no more guarantee that
+     * 'i' will be a valid node_id set by the user.
+     */
+    for (i = 0; i < nb_numa_nodes; i++) {
+        spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
+        spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
+    }
+}
+
+void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
+                                       int offset, int nodeid)
+{
+    _FDT((fdt_setprop(fdt, offset, "ibm,associativity",
+                      spapr->numa_assoc_array[nodeid],
+                      sizeof(spapr->numa_assoc_array[nodeid]))));
+}
+
 /*
  * Helper that writes ibm,associativity-reference-points and
  * max-associativity-domains in the RTAS pointed by @rtas
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 5188e2f503..63872054f3 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -31,6 +31,7 @@
 #include "hw/ppc/fdt.h"
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
+#include "hw/ppc/spapr_numa.h"
 
 void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp)
@@ -117,8 +118,8 @@ void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
 }
 
 
-static int spapr_dt_nvdimm(void *fdt, int parent_offset,
-                           NVDIMMDevice *nvdimm)
+static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
+                           int parent_offset, NVDIMMDevice *nvdimm)
 {
     int child_offset;
     char *buf;
@@ -128,11 +129,6 @@ static int spapr_dt_nvdimm(void *fdt, int parent_offset,
                                              &error_abort);
     uint64_t slot = object_property_get_uint(OBJECT(nvdimm), PC_DIMM_SLOT_PROP,
                                              &error_abort);
-    uint32_t associativity[] = {
-        cpu_to_be32(0x4), /* length */
-        cpu_to_be32(0x0), cpu_to_be32(0x0),
-        cpu_to_be32(0x0), cpu_to_be32(node)
-    };
     uint64_t lsize = nvdimm->label_size;
     uint64_t size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
                                             NULL);
@@ -152,8 +148,7 @@ static int spapr_dt_nvdimm(void *fdt, int parent_offset,
     _FDT((fdt_setprop_string(fdt, child_offset, "compatible", "ibm,pmemory")));
     _FDT((fdt_setprop_string(fdt, child_offset, "device_type", "ibm,pmemory")));
 
-    _FDT((fdt_setprop(fdt, child_offset, "ibm,associativity", associativity,
-                      sizeof(associativity))));
+    spapr_numa_write_associativity_dt(spapr, fdt, child_offset, node);
 
     buf = qemu_uuid_unparse_strdup(&nvdimm->uuid);
     _FDT((fdt_setprop_string(fdt, child_offset, "ibm,unit-guid", buf)));
@@ -179,12 +174,12 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 {
     NVDIMMDevice *nvdimm = NVDIMM(drc->dev);
 
-    *fdt_start_offset = spapr_dt_nvdimm(fdt, 0, nvdimm);
+    *fdt_start_offset = spapr_dt_nvdimm(spapr, fdt, 0, nvdimm);
 
     return 0;
 }
 
-void spapr_dt_persistent_memory(void *fdt)
+void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt)
 {
     int offset = fdt_subnode_offset(fdt, 0, "persistent-memory");
     GSList *iter, *nvdimms = nvdimm_get_device_list();
@@ -202,7 +197,7 @@ void spapr_dt_persistent_memory(void *fdt)
     for (iter = nvdimms; iter; iter = iter->next) {
         NVDIMMDevice *nvdimm = iter->data;
 
-        spapr_dt_nvdimm(fdt, offset, nvdimm);
+        spapr_dt_nvdimm(spapr, fdt, offset, nvdimm);
     }
     g_slist_free(nvdimms);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0a418f1e67..4d97ff6c70 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -52,6 +52,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
+#include "hw/ppc/spapr_numa.h"
 
 /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
 #define RTAS_QUERY_FN           0
@@ -2321,11 +2322,6 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
         cpu_to_be32(1),
         cpu_to_be32(RTAS_IBM_RESET_PE_DMA_WINDOW)
     };
-    uint32_t associativity[] = {cpu_to_be32(0x4),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(phb->numa_node)};
     SpaprTceTable *tcet;
     SpaprDrc *drc;
     Error *err = NULL;
@@ -2358,8 +2354,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
 
     /* Advertise NUMA via ibm,associativity */
     if (phb->numa_node != -1) {
-        _FDT(fdt_setprop(fdt, bus_off, "ibm,associativity", associativity,
-                         sizeof(associativity)));
+        spapr_numa_write_associativity_dt(spapr, fdt, bus_off, phb->numa_node);
     }
 
     /* Build the interrupt-map, this must matches what is done
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a1e230ad39..9a63380801 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -105,6 +105,16 @@ typedef enum {
 
 #define FDT_MAX_SIZE                    0x100000
 
+/*
+ * NUMA related macros. MAX_DISTANCE_REF_POINTS was taken
+ * from Taken from Linux kernel arch/powerpc/mm/numa.h.
+ *
+ * NUMA_ASSOC_SIZE is the base array size of an ibm,associativity
+ * array for any non-CPU resource.
+ */
+#define MAX_DISTANCE_REF_POINTS    4
+#define NUMA_ASSOC_SIZE            (MAX_DISTANCE_REF_POINTS + 1)
+
 typedef struct SpaprCapabilities SpaprCapabilities;
 struct SpaprCapabilities {
     uint8_t caps[SPAPR_CAP_NUM];
@@ -231,6 +241,8 @@ struct SpaprMachineState {
     unsigned gpu_numa_id;
     SpaprTpmProxy *tpm_proxy;
 
+    uint32_t numa_assoc_array[MAX_NODES][NUMA_ASSOC_SIZE];
+
     Error *fwnmi_migration_blocker;
 };
 
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index 7a370a8768..a2a4df55f7 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -13,8 +13,19 @@
 #ifndef HW_SPAPR_NUMA_H
 #define HW_SPAPR_NUMA_H
 
+#include "hw/boards.h"
 #include "hw/ppc/spapr.h"
 
+/*
+ * Having both SpaprMachineState and MachineState as arguments
+ * feels odd, but it will spare a MACHINE() call inside the
+ * function. spapr_machine_init() is the only caller for it, and
+ * it has both pointers resolved already.
+ */
+void spapr_numa_associativity_init(SpaprMachineState *spapr,
+                                   MachineState *machine);
 void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
+void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
+                                       int offset, int nodeid);
 
 #endif /* HW_SPAPR_NUMA_H */
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index 10a6d9dbbc..3eb344e8e9 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -27,7 +27,7 @@ QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_MEMORY_BLOCK_SIZE);
 
 int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
-void spapr_dt_persistent_memory(void *fdt);
+void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
 void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
-- 
2.26.2


