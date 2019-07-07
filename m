Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE4C48BE1
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778472082E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk8FZ-0001ZM-QI
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 10:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hk8E1-0008Ff-AH
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hk8Dy-0003Qo-Un
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:31571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hk8Dx-00038w-SY
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jul 2019 07:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,462,1557212400"; d="scan'208";a="185497842"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2019 07:32:53 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  7 Jul 2019 22:29:51 +0800
Message-Id: <20190707142958.31316-8-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190707142958.31316-1-tao3.xu@intel.com>
References: <20190707142958.31316-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v6 07/14] hmat acpi: Build System Locality
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

Changes in v6:
    - Update the describes in ACPI 6.3
    - remove num target and target_pxm, because all numa node can be
      target(no matter it can be reached or not, The Entry Base Unit for
      latency 0xFFFF means the initiator and target domains are
      unreachable from each other)
---
 hw/acpi/hmat.c          | 94 ++++++++++++++++++++++++++++++++++++++++-
 hw/acpi/hmat.h          | 39 +++++++++++++++++
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  3 ++
 include/sysemu/sysemu.h | 22 ++++++++++
 5 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index abf99b1adc..6dd39b0c85 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -67,11 +67,80 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
     build_append_int_noprefix(table_data, 0, 8);
 }
 
+/*
+ * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+ * Structure: Table 5-142
+ */
+static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *numa_hmat_lb,
+                          uint32_t num_initiator, uint32_t num_target,
+                          uint32_t *initiator_pxm, int type)
+{
+    uint32_t s = num_initiator;
+    uint32_t t = num_target;
+    uint8_t m, n;
+    int i;
+
+    /* Type */
+    build_append_int_noprefix(table_data, 1, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 32 + 4 * s + 4 * t + 2 * s * t, 4);
+    /* Flags */
+    build_append_int_noprefix(table_data, numa_hmat_lb->hierarchy, 1);
+    /* Data Type */
+    build_append_int_noprefix(table_data, numa_hmat_lb->data_type, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Number of Initiator Proximity Domains (s) */
+    build_append_int_noprefix(table_data, s, 4);
+    /* Number of Target Proximity Domains (t) */
+    build_append_int_noprefix(table_data, t, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    /* Entry Base Unit */
+    if (type <= HMAT_LB_DATA_WRITE_LATENCY) {
+        build_append_int_noprefix(table_data, numa_hmat_lb->base_lat, 8);
+    } else {
+        build_append_int_noprefix(table_data, numa_hmat_lb->base_bw, 8);
+    }
+
+    /* Initiator Proximity Domain List */
+    for (i = 0; i < s; i++) {
+        build_append_int_noprefix(table_data, initiator_pxm[i], 4);
+    }
+
+    /* Target Proximity Domain List */
+    for (i = 0; i < t; i++) {
+        build_append_int_noprefix(table_data, i, 4);
+    }
+
+    /* Latency or Bandwidth Entries */
+    for (i = 0; i < s; i++) {
+        m = initiator_pxm[i];
+        for (n = 0; n < t; n++) {
+            uint16_t entry;
+
+            if (type <= HMAT_LB_DATA_WRITE_LATENCY) {
+                entry = numa_hmat_lb->latency[m][n];
+            } else {
+                entry = numa_hmat_lb->bandwidth[m][n];
+            }
+
+            build_append_int_noprefix(table_data, entry, 2);
+        }
+    }
+}
+
 /* Build HMAT sub table structures */
 static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 {
     uint16_t flags;
-    int i;
+    uint32_t num_initiator = 0;
+    uint32_t initiator_pxm[MAX_NODES];
+    int i, hrchy, type;
+    HMAT_LB_Info *numa_hmat_lb;
 
     for (i = 0; i < nstat->num_nodes; i++) {
         flags = 0;
@@ -82,6 +151,29 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 
         build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator, i);
     }
+
+    for (i = 0; i < nstat->num_nodes; i++) {
+        if (nstat->nodes[i].has_cpu) {
+            initiator_pxm[num_initiator++] = i;
+        }
+    }
+
+    /*
+     * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+     * Structure: Table 5-142
+     */
+    for (hrchy = HMAT_LB_MEM_MEMORY;
+         hrchy <= HMAT_LB_MEM_CACHE_3RD_LEVEL; hrchy++) {
+        for (type = HMAT_LB_DATA_ACCESS_LATENCY;
+             type <= HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
+            numa_hmat_lb = nstat->hmat_lb[hrchy][type];
+
+            if (numa_hmat_lb) {
+                build_hmat_lb(table_data, numa_hmat_lb, num_initiator,
+                              nstat->num_nodes, initiator_pxm, type);
+            }
+        }
+    }
 }
 
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 574cfba60a..9d5f407b8a 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -40,6 +40,45 @@
  */
 #define HMAT_PROX_INIT_VALID 0x1
 
+struct HMAT_LB_Info {
+    /*
+     * Indicates total number of Proximity Domains
+     * that can initiate memory access requests.
+     */
+    uint32_t    num_initiator;
+    /*
+     * Indicates total number of Proximity Domains
+     * that can act as target.
+     */
+    uint32_t    num_target;
+    /*
+     * Indicates it's memory or
+     * the specified level memory side cache.
+     */
+    uint8_t     hierarchy;
+    /*
+     * Present the type of data,
+     * access/read/write latency or bandwidth.
+     */
+    uint8_t     data_type;
+    /* The base unit for latency in nanoseconds. */
+    uint64_t    base_lat;
+    /* The base unit for bandwidth in megabytes per second(MB/s). */
+    uint64_t    base_bw;
+    /*
+     * latency[i][j]:
+     * Indicates the latency based on base_lat
+     * from Initiator Proximity Domain i to Target Proximity Domain j.
+     */
+    uint16_t    latency[MAX_NODES][MAX_NODES];
+    /*
+     * bandwidth[i][j]:
+     * Indicates the bandwidth based on base_bw
+     * from Initiator Proximity Domain i to Target Proximity Domain j.
+     */
+    uint16_t    bandwidth[MAX_NODES][MAX_NODES];
+};
+
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat);
 
 #endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index fcdaae58c4..c0257e936b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
 typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
+typedef struct HMAT_LB_Info HMAT_LB_Info;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 357aaeda80..0b80bc2fa2 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -32,6 +32,9 @@ struct NumaState {
 
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
+
+    /* NUMA modes HMAT Locality Latency and Bandwidth Information */
+    HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
 };
 typedef struct NumaState NumaState;
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 61579ae71e..3f83fc0d58 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -124,6 +124,28 @@ extern int mem_prealloc;
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255
 
+/* the value of AcpiHmatLBInfo flags */
+enum {
+    HMAT_LB_MEM_MEMORY           = 0,
+    HMAT_LB_MEM_CACHE_LAST_LEVEL = 1,
+    HMAT_LB_MEM_CACHE_1ST_LEVEL  = 2,
+    HMAT_LB_MEM_CACHE_2ND_LEVEL  = 3,
+    HMAT_LB_MEM_CACHE_3RD_LEVEL  = 4,
+};
+
+/* the value of AcpiHmatLBInfo data type */
+enum {
+    HMAT_LB_DATA_ACCESS_LATENCY   = 0,
+    HMAT_LB_DATA_READ_LATENCY     = 1,
+    HMAT_LB_DATA_WRITE_LATENCY    = 2,
+    HMAT_LB_DATA_ACCESS_BANDWIDTH = 3,
+    HMAT_LB_DATA_READ_BANDWIDTH   = 4,
+    HMAT_LB_DATA_WRITE_BANDWIDTH  = 5,
+};
+
+#define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
+#define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
+
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
-- 
2.20.1


