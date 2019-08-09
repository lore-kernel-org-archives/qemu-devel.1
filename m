Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA73C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1184B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1184B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvywQ-0006Yg-9j
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hvyqZ-0003lF-3S
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hvyqX-00085T-7n
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:57:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:16871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hvyqW-0007xE-Vj
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:57:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 23:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; d="scan'208";a="326549040"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.37])
 by orsmga004.jf.intel.com with ESMTP; 08 Aug 2019 23:57:50 -0700
From: Tao <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Fri,  9 Aug 2019 14:57:27 +0800
Message-Id: <20190809065731.9097-8-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809065731.9097-1-tao3.xu@intel.com>
References: <20190809065731.9097-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v9 07/11] hmat acpi: Build System Locality
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
 qemu-devel@nongnu.org, daniel@linux.ibm.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

This structure describes the memory access latency and bandwidth
information from various memory access initiator proximity domains.
The latency and bandwidth numbers represented in this structure
correspond to rated latency and bandwidth for the platform.
The software could use this information as hint for optimization.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v9.
---
 hw/acpi/hmat.c          | 95 ++++++++++++++++++++++++++++++++++++++++-
 hw/acpi/hmat.h          | 41 ++++++++++++++++++
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  3 ++
 include/sysemu/sysemu.h | 21 +++++++++
 5 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index abf99b1adc..431818dc82 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -67,11 +67,81 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
     build_append_int_noprefix(table_data, 0, 8);
 }
 
+/*
+ * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+ * Structure: Table 5-142
+ */
+static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
+                          uint32_t num_initiator, uint32_t num_target,
+                          uint32_t *initiator_pxm, int type)
+{
+    uint32_t s = num_initiator;
+    uint32_t t = num_target;
+    uint8_t m, n;
+    uint8_t mask = 0x0f;
+    int i;
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
+    /* Entry Base Unit */
+    if (HMAT_IS_LATENCY(type)) {
+        build_append_int_noprefix(table_data, hmat_lb->base_lat, 8);
+    } else {
+        build_append_int_noprefix(table_data, hmat_lb->base_bw, 8);
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
+            if (HMAT_IS_LATENCY(type)) {
+                entry = hmat_lb->latency[m][n];
+            } else {
+                entry = hmat_lb->bandwidth[m][n];
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
@@ -82,6 +152,29 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 
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
index 574cfba60a..5f050781e6 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -40,6 +40,47 @@
  */
 #define HMAT_PROX_INIT_VALID 0x1
 
+#define HMAT_IS_LATENCY(type) (type <= HMAT_LB_DATA_WRITE_LATENCY)
+
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
index 46ad06e000..85ddad99b4 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -30,6 +30,9 @@ struct NumaState {
 
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
+
+    /* NUMA modes HMAT Locality Latency and Bandwidth Information */
+    HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
 };
 typedef struct NumaState NumaState;
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 984c439ac9..fc638f06cd 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -126,6 +126,27 @@ extern int mem_prealloc;
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255
 
+/* the value of AcpiHmatLBInfo flags */
+enum {
+    HMAT_LB_MEM_MEMORY           = 0,
+    HMAT_LB_MEM_CACHE_1ST_LEVEL  = 1,
+    HMAT_LB_MEM_CACHE_2ND_LEVEL  = 2,
+    HMAT_LB_MEM_CACHE_3RD_LEVEL  = 3,
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


