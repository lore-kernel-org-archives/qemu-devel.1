Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49098C606D8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D5E216FD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D5E216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkWQ-0006c9-9h
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43417)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hkkOJ-0006jA-HU
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hkkOE-0007XA-K1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:58442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hkkOE-0007Ul-51
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jul 2019 00:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; d="scan'208";a="165681657"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2019 00:18:12 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Tue,  9 Jul 2019 15:15:10 +0800
Message-Id: <20190709071520.8745-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709071520.8745-1-tao3.xu@intel.com>
References: <20190709071520.8745-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [PATCH RESEND v6 04/14] numa: move numa global
 variable numa_info into MachineState
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move existing numa global numa_info (renamed as "nodes") into NumaState.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v6:
    - Rebase to upstream, move globals in arm/sbsa-ref
    - Correct some mistake(Igor)
    - Use ms->numa_state->nodes directly, when use it once or twice(Igor)
---
 exec.c                   |  2 +-
 hw/acpi/aml-build.c      |  6 ++++--
 hw/arm/boot.c            |  2 +-
 hw/arm/sbsa-ref.c        |  3 ++-
 hw/arm/virt-acpi-build.c |  7 ++++---
 hw/arm/virt.c            |  3 ++-
 hw/core/numa.c           | 15 +++++++++------
 hw/i386/pc.c             |  4 ++--
 hw/ppc/spapr.c           | 10 +++++-----
 hw/ppc/spapr_pci.c       |  4 +++-
 include/sysemu/numa.h    |  3 +++
 11 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/exec.c b/exec.c
index b6b75d2ad5..26dd7676c0 100644
--- a/exec.c
+++ b/exec.c
@@ -1766,7 +1766,7 @@ long qemu_minrampagesize(void)
     if (hpsize > mainrampagesize &&
         (ms->numa_state == NULL ||
          ms->numa_state->num_nodes == 0 ||
-         numa_info[0].node_memdev == NULL)) {
+         ms->numa_state->nodes[0].node_memdev == NULL)) {
         static bool warned;
         if (!warned) {
             error_report("Huge page support disabled (n/a for main memory).");
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 63c1cae8c9..26ccc1a3e2 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1737,8 +1737,10 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
     build_append_int_noprefix(table_data, nb_numa_nodes, 8);
     for (i = 0; i < nb_numa_nodes; i++) {
         for (j = 0; j < nb_numa_nodes; j++) {
-            assert(numa_info[i].distance[j]);
-            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
+            assert(ms->numa_state->nodes[i].distance[j]);
+            build_append_int_noprefix(table_data,
+                                      ms->numa_state->nodes[i].distance[j],
+                                      1);
         }
     }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e28daa5278..da228919dc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -601,7 +601,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     if (ms->numa_state != NULL && ms->numa_state->num_nodes > 0) {
         mem_base = binfo->loader_start;
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
-            mem_len = numa_info[i].node_mem;
+            mem_len = ms->numa_state->nodes[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
                                      scells, mem_len, i);
             if (rc < 0) {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 7e4c471717..3a243e6a53 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -168,7 +168,8 @@ static void create_fdt(SBSAMachineState *sms)
                 idx = (i * nb_numa_nodes + j) * 3;
                 matrix[idx + 0] = cpu_to_be32(i);
                 matrix[idx + 1] = cpu_to_be32(j);
-                matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
+                matrix[idx + 2] =
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
             }
         }
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 461a44b5b0..89899ec4c1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -534,11 +534,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     mem_base = vms->memmap[VIRT_MEM].base;
     for (i = 0; i < ms->numa_state->num_nodes; ++i) {
-        if (numa_info[i].node_mem > 0) {
+        if (ms->numa_state->nodes[i].node_mem > 0) {
             numamem = acpi_data_push(table_data, sizeof(*numamem));
-            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
+            build_srat_memory(numamem, mem_base,
+                              ms->numa_state->nodes[i].node_mem, i,
                               MEM_AFFINITY_ENABLED);
-            mem_base += numa_info[i].node_mem;
+            mem_base += ms->numa_state->nodes[i].node_mem;
         }
     }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 984f162531..174e81a3de 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -242,7 +242,8 @@ static void create_fdt(VirtMachineState *vms)
                 idx = (i * nb_numa_nodes + j) * 3;
                 matrix[idx + 0] = cpu_to_be32(i);
                 matrix[idx + 1] = cpu_to_be32(j);
-                matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
+                matrix[idx + 2] =
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
             }
         }
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 2142ec29e8..8fcbba05d6 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -50,8 +50,6 @@ static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-NodeInfo numa_info[MAX_NODES];
-
 
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
@@ -61,6 +59,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     uint16List *cpus = NULL;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     unsigned int max_cpus = ms->smp.max_cpus;
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     if (node->has_nodeid) {
         nodenr = node->nodeid;
@@ -140,6 +139,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
     uint16_t src = dist->src;
     uint16_t dst = dist->dst;
     uint8_t val = dist->val;
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
         error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
@@ -198,7 +198,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             error_setg(&err, "Missing mandatory node-id property");
             goto end;
         }
-        if (!numa_info[object->u.cpu.node_id].present) {
+        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
             error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
                 "defined with -numa node,nodeid=ID before it's used with "
                 "-numa cpu,node-id=ID", object->u.cpu.node_id);
@@ -258,6 +258,7 @@ static void validate_numa_distance(MachineState *ms)
     int src, dst;
     bool is_asymmetrical = false;
     int nb_numa_nodes = ms->numa_state->num_nodes;
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     for (src = 0; src < nb_numa_nodes; src++) {
         for (dst = src; dst < nb_numa_nodes; dst++) {
@@ -298,6 +299,7 @@ static void validate_numa_distance(MachineState *ms)
 static void complete_init_numa_distance(MachineState *ms)
 {
     int src, dst;
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     /* Fixup NUMA distance by symmetric policy because if it is an
      * asymmetric distance table, it should be a complete table and
@@ -357,6 +359,7 @@ void numa_complete_configuration(MachineState *ms)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
@@ -522,8 +525,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 
     memory_region_init(mr, owner, name, ram_size);
     for (i = 0; i < ms->numa_state->num_nodes; i++) {
-        uint64_t size = numa_info[i].node_mem;
-        HostMemoryBackend *backend = numa_info[i].node_memdev;
+        uint64_t size = ms->numa_state->nodes[i].node_mem;
+        HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
         if (!backend) {
             continue;
         }
@@ -589,7 +592,7 @@ void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
 
     numa_stat_memory_devices(node_mem);
     for (i = 0; i < ms->numa_state->num_nodes; i++) {
-        node_mem[i].node_mem += numa_info[i].node_mem;
+        node_mem[i].node_mem += ms->numa_state->nodes[i].node_mem;
     }
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6d87fad739..5122f49973 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1039,7 +1039,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     }
     for (i = 0; i < nb_numa_nodes; i++) {
         numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
-            cpu_to_le64(numa_info[i].node_mem);
+            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
     }
     fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
                      (1 + pcms->apic_id_limit + nb_numa_nodes) *
@@ -1767,7 +1767,7 @@ void pc_guest_info_init(PCMachineState *pcms)
     pcms->node_mem = g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
     for (i = 0; i < ms->numa_state->num_nodes; i++) {
-        pcms->node_mem[i] = numa_info[i].node_mem;
+        pcms->node_mem[i] = ms->numa_state->nodes[i].node_mem;
     }
 
     pcms->machine_done.notify = pc_machine_done;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2aec966616..5a9128f07e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -354,8 +354,8 @@ static hwaddr spapr_node0_size(MachineState *machine)
     if (machine->numa_state->num_nodes) {
         int i;
         for (i = 0; i < machine->numa_state->num_nodes; ++i) {
-            if (numa_info[i].node_mem) {
-                return MIN(pow2floor(numa_info[i].node_mem),
+            if (machine->numa_state->nodes[i].node_mem) {
+                return MIN(pow2floor(machine->numa_state->nodes[i].node_mem),
                            machine->ram_size);
             }
         }
@@ -399,7 +399,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
     MachineState *machine = MACHINE(spapr);
     hwaddr mem_start, node_size;
     int i;
-    NodeInfo *nodes = numa_info;
+    NodeInfo *nodes = machine->numa_state->nodes;
     NodeInfo ramnode;
 
     /* No NUMA nodes, assume there is just one node with whole RAM */
@@ -2539,11 +2539,11 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
     }
 
     for (i = 0; i < machine->numa_state->num_nodes; i++) {
-        if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
+        if (machine->numa_state->nodes[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
             error_setg(errp,
                        "Node %d memory size 0x%" PRIx64
                        " is not aligned to %" PRIu64 " MiB",
-                       i, numa_info[i].node_mem,
+                       i, machine->numa_state->nodes[i].node_mem,
                        SPAPR_MEMORY_BLOCK_SIZE / MiB);
             return;
         }
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9003fe9010..f05d82eee7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1818,6 +1818,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    MachineState *ms = MACHINE(spapr);
     char *namebuf;
     int i;
     PCIBus *bus;
@@ -1870,7 +1871,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 
     if (sphb->numa_node != -1 &&
-        (sphb->numa_node >= MAX_NODES || !numa_info[sphb->numa_node].present)) {
+        (sphb->numa_node >= MAX_NODES ||
+         !ms->numa_state->nodes[sphb->numa_node].present)) {
         error_setg(errp, "Invalid NUMA node ID for PCI host bridge");
         return;
     }
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 2e5e998adb..186ea0eb5e 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -26,6 +26,9 @@ struct NumaState {
 
     /* Allow setting NUMA distance for different NUMA nodes */
     bool have_numa_distance;
+
+    /* NUMA nodes information */
+    NodeInfo nodes[MAX_NODES];
 };
 typedef struct NumaState NumaState;
 
-- 
2.20.1


