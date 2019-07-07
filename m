Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4228CC48BE1
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A50C20830
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk8LS-0000Kv-B9
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 10:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hk8E5-0008Gr-8y
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hk8Dz-0003S0-TX
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:31569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hk8Dy-00037I-KJ
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jul 2019 07:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,462,1557212400"; d="scan'208";a="185497845"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2019 07:32:54 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  7 Jul 2019 22:29:52 +0800
Message-Id: <20190707142958.31316-9-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190707142958.31316-1-tao3.xu@intel.com>
References: <20190707142958.31316-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v6 08/14] hmat acpi: Build Memory Side Cache
 Information Structure(s)
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

This structure describes memory side cache information for memory
proximity domains if the memory side cache is present and the
physical device forms the memory side cache.
The software could use this information to effectively place
the data in memory to maximize the performance of the system
memory that use the memory side cache.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v6:
    - Add descriptions from ACPI 6.3 spec
---
 hw/acpi/hmat.c          | 64 ++++++++++++++++++++++++++++++++++++++++-
 hw/acpi/hmat.h          | 20 +++++++++++++
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  3 ++
 include/sysemu/sysemu.h |  2 ++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 6dd39b0c85..a207581f11 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -133,14 +133,63 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *numa_hmat_lb,
     }
 }
 
+/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-143 */
+static void build_hmat_cache(GArray *table_data, HMAT_Cache_Info *hmat_cache)
+{
+    /*
+     * Cache Attributes: Bits [3:0] – Total Cache Levels
+     * for this Memory Proximity Domain
+     */
+    uint32_t cache_attr = hmat_cache->total_levels & 0xF;
+
+    /* Bits [7:4] : Cache Level described in this structure */
+    cache_attr |= (hmat_cache->level & 0xF) << 4;
+
+    /* Bits [11:8] - Cache Associativity */
+    cache_attr |= (hmat_cache->associativity & 0xF) << 8;
+
+    /* Bits [15:12] - Write Policy */
+    cache_attr |= (hmat_cache->write_policy & 0xF) << 12;
+
+    /* Bits [31:16] - Cache Line size in bytes */
+    cache_attr |= (hmat_cache->line_size & 0xFFFF) << 16;
+
+    cache_attr = cpu_to_le32(cache_attr);
+
+    /* Type */
+    build_append_int_noprefix(table_data, 2, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 4);
+    /* Proximity Domain for the Memory */
+    build_append_int_noprefix(table_data, hmat_cache->mem_proximity, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Memory Side Cache Size */
+    build_append_int_noprefix(table_data, hmat_cache->size, 8);
+    /* Cache Attributes */
+    build_append_int_noprefix(table_data, cache_attr, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /*
+     * Number of SMBIOS handles (n)
+     * Linux kernel uses Memory Side Cache Information Structure
+     * without SMBIOS entries for now, so set Number of SMBIOS handles
+     * as 0.
+     */
+    build_append_int_noprefix(table_data, 0, 2);
+}
+
 /* Build HMAT sub table structures */
 static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 {
     uint16_t flags;
     uint32_t num_initiator = 0;
     uint32_t initiator_pxm[MAX_NODES];
-    int i, hrchy, type;
+    int i, hrchy, type, level;
     HMAT_LB_Info *numa_hmat_lb;
+    HMAT_Cache_Info *numa_hmat_cache;
 
     for (i = 0; i < nstat->num_nodes; i++) {
         flags = 0;
@@ -174,6 +223,19 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
             }
         }
     }
+
+    /*
+     * ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure:
+     * Table 5-143
+     */
+    for (i = 0; i < nstat->num_nodes; i++) {
+        for (level = 0; level <= MAX_HMAT_CACHE_LEVEL; level++) {
+            numa_hmat_cache = nstat->hmat_cache[i][level];
+            if (numa_hmat_cache) {
+                build_hmat_cache(table_data, numa_hmat_cache);
+            }
+        }
+    }
 }
 
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 9d5f407b8a..ba655281cc 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -79,6 +79,26 @@ struct HMAT_LB_Info {
     uint16_t    bandwidth[MAX_NODES][MAX_NODES];
 };
 
+struct HMAT_Cache_Info {
+    /* The memory proximity domain to which the memory belongs. */
+    uint32_t    mem_proximity;
+    /* Size of memory side cache in bytes. */
+    uint64_t    size;
+    /*
+     * Total cache levels for this memory
+     * pr#include "hw/acpi/aml-build.h"oximity domain.
+     */
+    uint8_t     total_levels;
+    /* Cache level described in this structure. */
+    uint8_t     level;
+    /* Cache Associativity: None/Direct Mapped/Comple Cache Indexing */
+    uint8_t     associativity;
+    /* Write Policy: None/Write Back(WB)/Write Through(WT) */
+    uint8_t     write_policy;
+    /* Cache Line size in bytes. */
+    uint16_t    line_size;
+};
+
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat);
 
 #endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index c0257e936b..d971f5109e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
 typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
+typedef struct HMAT_Cache_Info HMAT_Cache_Info;
 typedef struct HMAT_LB_Info HMAT_LB_Info;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 0b80bc2fa2..2e5bdcbd19 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -35,6 +35,9 @@ struct NumaState {
 
     /* NUMA modes HMAT Locality Latency and Bandwidth Information */
     HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
+
+    /* Memory Side Cache Information Structure */
+    HMAT_Cache_Info *hmat_cache[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
 };
 typedef struct NumaState NumaState;
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 3f83fc0d58..85c584c531 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -143,6 +143,8 @@ enum {
     HMAT_LB_DATA_WRITE_BANDWIDTH  = 5,
 };
 
+#define MAX_HMAT_CACHE_LEVEL        3
+
 #define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
 #define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
 
-- 
2.20.1


