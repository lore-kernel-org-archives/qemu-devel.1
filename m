Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F9C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37CD21841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37CD21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpB4-0001vD-2u
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hbobo-0001Bv-3g
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hbobm-0005up-3J
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:59:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:2019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hbobl-0005LS-Lm
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:59:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jun 2019 08:59:08 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by orsmga008.jf.intel.com with ESMTP; 14 Jun 2019 08:59:06 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Fri, 14 Jun 2019 23:56:21 +0800
Message-Id: <20190614155626.27932-4-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614155626.27932-1-tao3.xu@intel.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [PATCH v5 3/8] numa: move numa global variable
 have_numa_distance into MachineState
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move existing numa global have_numa_distance into NumaState.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v5 -> v4:
    - Simplify commit message (Igor)
---
 hw/arm/virt-acpi-build.c | 2 +-
 hw/arm/virt.c            | 2 +-
 hw/i386/acpi-build.c     | 2 +-
 include/sysemu/numa.h    | 4 ++--
 numa.c                   | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9a22ce679c..9d2edd8023 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -800,7 +800,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, ms);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 025ad484c5..d147cceab6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -229,7 +229,7 @@ static void create_fdt(VirtMachineState *vms)
                                 "clk24mhz");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
 
-    if (have_numa_distance) {
+    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
         uint32_t *matrix = g_malloc0(size);
         int idx, i, j;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0d58335560..055e677c30 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2667,7 +2667,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (pcms->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
-        if (have_numa_distance) {
+        if (machine->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, machine);
         }
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 3c4b2d2909..08a86080c4 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -6,8 +6,6 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 
-extern bool have_numa_distance;
-
 struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
@@ -26,6 +24,8 @@ struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
 
+    /* Allow setting NUMA distance for different NUMA nodes */
+    bool have_numa_distance;
 };
 typedef struct NumaState NumaState;
 
diff --git a/numa.c b/numa.c
index d678b71607..9432d42ad0 100644
--- a/numa.c
+++ b/numa.c
@@ -171,7 +171,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
     }
 
     numa_info[src].distance[dst] = val;
-    have_numa_distance = true;
+    ms->numa_state->have_numa_distance = true;
 }
 
 static
@@ -443,7 +443,7 @@ void numa_complete_configuration(MachineState *ms)
          * asymmetric. In this case, the distances for both directions
          * of all node pairs are required.
          */
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             /* Validate enough NUMA distance information was provided. */
             validate_numa_distance(ms);
 
-- 
2.20.1


