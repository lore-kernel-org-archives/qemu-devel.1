Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16506C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 05:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E443320856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 05:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E443320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Hs0-0000Oa-Ou
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 01:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i8Hmy-0003Zs-U3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i8Hmx-00030I-9P
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:37:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:18624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1i8Hmx-0002zn-07
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:37:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 22:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,495,1559545200"; d="scan'208";a="186030806"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2019 22:37:00 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Thu, 12 Sep 2019 13:36:36 +0800
Message-Id: <20190912053638.4858-10-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912053638.4858-1-tao3.xu@intel.com>
References: <20190912053638.4858-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v11 09/11] hmat acpi: Build System Locality
 Latency and Bandwidth Information Structure(s)
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

From: Liu Jingqi <jingqi.liu@intel.com>

This structure describes the memory access latency and bandwidth
information from various memory access initiator proximity domains.
The latency and bandwidth numbers represented in this structure
correspond to rated latency and bandwidth for the platform.
The software could use this information as hint for optimization.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v11:
    - Calculate base in build_hmat_lb().
---
 hw/acpi/hmat.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/acpi/hmat.h |   2 +
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 1368fce7ee..2d76dd0cd1 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/numa.h"
 #include "hw/acpi/hmat.h"
+#include "qemu/error-report.h"
 
 /*
  * ACPI 6.3:
@@ -67,11 +68,105 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
     build_append_int_noprefix(table_data, 0, 8);
 }
 
+static bool entry_overflow(uint64_t *lb_data, uint64_t base, int len)
+{
+    int i;
+
+    for (i = 0; i < len; i++) {
+        if (lb_data[i] / base >= UINT16_MAX) {
+            return true;
+        }
+    }
+
+    return false;
+}
+/*
+ * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+ * Structure: Table 5-146
+ */
+static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
+                          uint32_t num_initiator, uint32_t num_target,
+                          uint32_t *initiator_list, int type)
+{
+    uint8_t mask = 0x0f;
+    uint32_t s = num_initiator;
+    uint32_t t = num_target;
+    uint64_t base = 1;
+    uint64_t *lb_data;
+    int i, unit;
+
+    /* Type */
+    build_append_int_noprefix(table_data, 1, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 32 + 4 * s + 4 * t + 2 * s * t, 4);
+    /* Flags: Bits [3:0] Memory Hierarchy, Bits[7:4] Reserved */
+    build_append_int_noprefix(table_data, hmat_lb->hierarchy & mask, 1);
+    /* Data Type */
+    build_append_int_noprefix(table_data, hmat_lb->data_type, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Number of Initiator Proximity Domains (s) */
+    build_append_int_noprefix(table_data, s, 4);
+    /* Number of Target Proximity Domains (t) */
+    build_append_int_noprefix(table_data, t, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    if (HMAT_IS_LATENCY(type)) {
+        unit = 1000;
+        lb_data = hmat_lb->latency;
+    } else {
+        unit = 1024;
+        lb_data = hmat_lb->bandwidth;
+    }
+
+    while (entry_overflow(lb_data, base, s * t)) {
+        for (i = 0; i < s * t; i++) {
+            if (!QEMU_IS_ALIGNED(lb_data[i], unit * base)) {
+                error_report("Invalid latency/bandwidth input, all "
+                "latencies/bandwidths should be specified in the same units.");
+                exit(1);
+            }
+        }
+        base *= unit;
+    }
+
+    /* Entry Base Unit */
+    build_append_int_noprefix(table_data, base, 8);
+
+    /* Initiator Proximity Domain List */
+    for (i = 0; i < s; i++) {
+        build_append_int_noprefix(table_data, initiator_list[i], 4);
+    }
+
+    /* Target Proximity Domain List */
+    for (i = 0; i < t; i++) {
+        build_append_int_noprefix(table_data, i, 4);
+    }
+
+    /* Latency or Bandwidth Entries */
+    for (i = 0; i < s * t; i++) {
+        uint16_t entry;
+
+        if (HMAT_IS_LATENCY(type)) {
+            entry = hmat_lb->latency[i] / base;
+        } else {
+            entry = hmat_lb->bandwidth[i] / base;
+        }
+
+        build_append_int_noprefix(table_data, entry, 2);
+    }
+}
+
 /* Build HMAT sub table structures */
 static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 {
     uint16_t flags;
-    int i;
+    uint32_t *initiator_list;
+    int i, j, hrchy, type;
+    HMAT_LB_Info *numa_hmat_lb;
 
     for (i = 0; i < nstat->num_nodes; i++) {
         flags = 0;
@@ -82,6 +177,32 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 
         build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator, i);
     }
+
+    initiator_list = g_malloc0(nstat->num_initiator * sizeof(uint32_t));
+    for (i = 0, j = 0; i < nstat->num_nodes; i++) {
+        if (nstat->nodes[i].has_cpu) {
+            initiator_list[j] = i;
+            j++;
+        }
+    }
+
+    /*
+     * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+     * Structure: Table 5-146
+     */
+    for (hrchy = HMAT_LB_MEM_MEMORY;
+         hrchy <= HMAT_LB_MEM_CACHE_3RD_LEVEL; hrchy++) {
+        for (type = HMAT_LB_DATA_ACCESS_LATENCY;
+             type <= HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
+            numa_hmat_lb = nstat->hmat_lb[hrchy][type];
+
+            if (numa_hmat_lb) {
+                build_hmat_lb(table_data, numa_hmat_lb, nstat->num_initiator,
+                              nstat->num_nodes, initiator_list, type);
+            }
+        }
+    }
+    g_free(initiator_list);
 }
 
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 0c1839cf6f..1154dfb48e 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -40,6 +40,8 @@
  */
 #define HMAT_PROX_INIT_VALID 0x1
 
+#define HMAT_IS_LATENCY(type) (type <= HMAT_LB_DATA_WRITE_LATENCY)
+
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat);
 
 #endif
-- 
2.20.1


