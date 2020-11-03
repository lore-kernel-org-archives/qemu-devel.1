Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF4C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C2521D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C2521D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvJk-0001mN-RI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIL-0008MT-Vg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIH-00084o-1Z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:13 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQTPY48HJz15Kn5;
 Tue,  3 Nov 2020 20:20:01 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:56 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 3/8] acpi: Extract crs build form acpi_build.c
Date: Tue, 3 Nov 2020 20:01:52 +0800
Message-ID: <20201103120157.2286-4-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org,
 Jiahui Cen <cenjiahui@huawei.com>, berrange@redhat.com, mst@redhat.com,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yubo Miao <miaoyubo@huawei.com>

Extract crs build form acpi_build.c, the function could also be used
to build the crs for pxbs for arm. The resources are composed by two parts:
1. The bar space of pci-bridge/pcie-root-ports
2. The resources needed by devices behind PXBs.
The base and limit of memory/io are obtained from the config via two APIs:
pci_bridge_get_base and pci_bridge_get_limit

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 hw/acpi/aml-build.c         | 273 +++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 293 ------------------------------------
 include/hw/acpi/aml-build.h |  25 +++
 3 files changed, 298 insertions(+), 293 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 3792ba96ce..8b06d1315f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -27,6 +27,9 @@
 #include "sysemu/numa.h"
 #include "hw/boards.h"
 #include "hw/acpi/tpm.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -55,6 +58,125 @@ static void build_append_array(GArray *array, GArray *val)
 
 #define ACPI_NAMESEG_LEN 4
 
+void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
+{
+    CrsRangeEntry *entry;
+
+    entry = g_malloc(sizeof(*entry));
+    entry->base = base;
+    entry->limit = limit;
+
+    g_ptr_array_add(ranges, entry);
+}
+
+static void crs_range_free(gpointer data)
+{
+    CrsRangeEntry *entry = (CrsRangeEntry *)data;
+    g_free(entry);
+}
+
+void crs_range_set_init(CrsRangeSet *range_set)
+{
+    range_set->io_ranges = g_ptr_array_new_with_free_func(crs_range_free);
+    range_set->mem_ranges = g_ptr_array_new_with_free_func(crs_range_free);
+    range_set->mem_64bit_ranges =
+            g_ptr_array_new_with_free_func(crs_range_free);
+}
+
+void crs_range_set_free(CrsRangeSet *range_set)
+{
+    g_ptr_array_free(range_set->io_ranges, true);
+    g_ptr_array_free(range_set->mem_ranges, true);
+    g_ptr_array_free(range_set->mem_64bit_ranges, true);
+}
+
+static gint crs_range_compare(gconstpointer a, gconstpointer b)
+{
+    CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
+    CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
+
+    if (entry_a->base < entry_b->base) {
+        return -1;
+    } else if (entry_a->base > entry_b->base) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+/*
+ * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
+ * interval, computes the 'free' ranges from the same interval.
+ * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
+ * will return { [base - a1], [a2 - b1], [b2 - limit] }.
+ */
+void crs_replace_with_free_ranges(GPtrArray *ranges,
+                                         uint64_t start, uint64_t end)
+{
+    GPtrArray *free_ranges = g_ptr_array_new();
+    uint64_t free_base = start;
+    int i;
+
+    g_ptr_array_sort(ranges, crs_range_compare);
+    for (i = 0; i < ranges->len; i++) {
+        CrsRangeEntry *used = g_ptr_array_index(ranges, i);
+
+        if (free_base < used->base) {
+            crs_range_insert(free_ranges, free_base, used->base - 1);
+        }
+
+        free_base = used->limit + 1;
+    }
+
+    if (free_base < end) {
+        crs_range_insert(free_ranges, free_base, end);
+    }
+
+    g_ptr_array_set_size(ranges, 0);
+    for (i = 0; i < free_ranges->len; i++) {
+        g_ptr_array_add(ranges, g_ptr_array_index(free_ranges, i));
+    }
+
+    g_ptr_array_free(free_ranges, true);
+}
+
+static void crs_range_merge(GPtrArray *range)
+{
+    GPtrArray *tmp =  g_ptr_array_new_with_free_func(crs_range_free);
+    CrsRangeEntry *entry;
+    uint64_t range_base, range_limit;
+    int i;
+
+    if (!range->len) {
+        return;
+    }
+
+    g_ptr_array_sort(range, crs_range_compare);
+
+    entry = g_ptr_array_index(range, 0);
+    range_base = entry->base;
+    range_limit = entry->limit;
+    for (i = 1; i < range->len; i++) {
+        entry = g_ptr_array_index(range, i);
+        if (entry->base - 1 == range_limit) {
+            range_limit = entry->limit;
+        } else {
+            crs_range_insert(tmp, range_base, range_limit);
+            range_base = entry->base;
+            range_limit = entry->limit;
+        }
+    }
+    crs_range_insert(tmp, range_base, range_limit);
+
+    g_ptr_array_set_size(range, 0);
+    for (i = 0; i < tmp->len; i++) {
+        entry = g_ptr_array_index(tmp, i);
+        crs_range_insert(range, entry->base, entry->limit);
+    }
+    g_ptr_array_free(tmp, true);
+}
+
+
 static void
 build_append_nameseg(GArray *array, const char *seg)
 {
@@ -1951,6 +2073,157 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
                  tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
 }
 
+Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
+{
+    Aml *crs = aml_resource_template();
+    CrsRangeSet temp_range_set;
+    CrsRangeEntry *entry;
+    uint8_t max_bus = pci_bus_num(host->bus);
+    uint8_t type;
+    int devfn;
+    int i;
+
+    crs_range_set_init(&temp_range_set);
+    for (devfn = 0; devfn < ARRAY_SIZE(host->bus->devices); devfn++) {
+        uint64_t range_base, range_limit;
+        PCIDevice *dev = host->bus->devices[devfn];
+
+        if (!dev) {
+            continue;
+        }
+
+        for (i = 0; i < PCI_NUM_REGIONS; i++) {
+            PCIIORegion *r = &dev->io_regions[i];
+
+            range_base = r->addr;
+            range_limit = r->addr + r->size - 1;
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (!range_base || range_base > range_limit) {
+                continue;
+            }
+
+            if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+                crs_range_insert(temp_range_set.io_ranges,
+                                 range_base, range_limit);
+            } else { /* "memory" */
+                crs_range_insert(temp_range_set.mem_ranges,
+                                 range_base, range_limit);
+            }
+        }
+
+        type = dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+        if (type == PCI_HEADER_TYPE_BRIDGE) {
+            uint8_t subordinate = dev->config[PCI_SUBORDINATE_BUS];
+            if (subordinate > max_bus) {
+                max_bus = subordinate;
+            }
+
+            range_base = pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_IO);
+            range_limit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_IO);
+             /*
+              * Work-around for old bioses
+              * that do not support multiple root buses
+              */
+            if (range_base && range_base <= range_limit) {
+                crs_range_insert(temp_range_set.io_ranges,
+                                 range_base, range_limit);
+            }
+
+            range_base =
+                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
+            range_limit =
+                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <= range_limit) {
+                uint64_t length = range_limit - range_base + 1;
+                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
+                    crs_range_insert(temp_range_set.mem_ranges,
+                                     range_base, range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
+            }
+
+            range_base =
+                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+            range_limit =
+                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <= range_limit) {
+                uint64_t length = range_limit - range_base + 1;
+                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
+                    crs_range_insert(temp_range_set.mem_ranges,
+                                     range_base, range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
+            }
+        }
+    }
+
+    crs_range_merge(temp_range_set.io_ranges);
+    for (i = 0; i < temp_range_set.io_ranges->len; i++) {
+        entry = g_ptr_array_index(temp_range_set.io_ranges, i);
+        aml_append(crs,
+                   aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
+                               AML_POS_DECODE, AML_ENTIRE_RANGE,
+                               0, entry->base, entry->limit, 0,
+                               entry->limit - entry->base + 1));
+        crs_range_insert(range_set->io_ranges, entry->base, entry->limit);
+    }
+
+    crs_range_merge(temp_range_set.mem_ranges);
+    for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
+        entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
+        aml_append(crs,
+                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE,
+                                    0, entry->base, entry->limit, 0,
+                                    entry->limit - entry->base + 1));
+        crs_range_insert(range_set->mem_ranges, entry->base, entry->limit);
+    }
+
+    crs_range_merge(temp_range_set.mem_64bit_ranges);
+    for (i = 0; i < temp_range_set.mem_64bit_ranges->len; i++) {
+        entry = g_ptr_array_index(temp_range_set.mem_64bit_ranges, i);
+        aml_append(crs,
+                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE,
+                                    0, entry->base, entry->limit, 0,
+                                    entry->limit - entry->base + 1));
+        crs_range_insert(range_set->mem_64bit_ranges,
+                         entry->base, entry->limit);
+    }
+
+    crs_range_set_free(&temp_range_set);
+
+    aml_append(crs,
+        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                            0,
+                            pci_bus_num(host->bus),
+                            max_bus,
+                            0,
+                            max_bus - pci_bus_num(host->bus) + 1));
+
+    return crs;
+}
+
 /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
 static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags,
                                   uint16_t type_flags,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f66642d88..170e1f23d9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -616,299 +616,6 @@ static Aml *build_prt(bool is_pci0_prt)
     return method;
 }
 
-typedef struct CrsRangeEntry {
-    uint64_t base;
-    uint64_t limit;
-} CrsRangeEntry;
-
-static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
-{
-    CrsRangeEntry *entry;
-
-    entry = g_malloc(sizeof(*entry));
-    entry->base = base;
-    entry->limit = limit;
-
-    g_ptr_array_add(ranges, entry);
-}
-
-static void crs_range_free(gpointer data)
-{
-    CrsRangeEntry *entry = (CrsRangeEntry *)data;
-    g_free(entry);
-}
-
-typedef struct CrsRangeSet {
-    GPtrArray *io_ranges;
-    GPtrArray *mem_ranges;
-    GPtrArray *mem_64bit_ranges;
- } CrsRangeSet;
-
-static void crs_range_set_init(CrsRangeSet *range_set)
-{
-    range_set->io_ranges = g_ptr_array_new_with_free_func(crs_range_free);
-    range_set->mem_ranges = g_ptr_array_new_with_free_func(crs_range_free);
-    range_set->mem_64bit_ranges =
-            g_ptr_array_new_with_free_func(crs_range_free);
-}
-
-static void crs_range_set_free(CrsRangeSet *range_set)
-{
-    g_ptr_array_free(range_set->io_ranges, true);
-    g_ptr_array_free(range_set->mem_ranges, true);
-    g_ptr_array_free(range_set->mem_64bit_ranges, true);
-}
-
-static gint crs_range_compare(gconstpointer a, gconstpointer b)
-{
-    CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
-    CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
-
-    if (entry_a->base < entry_b->base) {
-        return -1;
-    } else if (entry_a->base > entry_b->base) {
-        return 1;
-    } else {
-        return 0;
-    }
-}
-
-/*
- * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
- * interval, computes the 'free' ranges from the same interval.
- * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
- * will return { [base - a1], [a2 - b1], [b2 - limit] }.
- */
-static void crs_replace_with_free_ranges(GPtrArray *ranges,
-                                         uint64_t start, uint64_t end)
-{
-    GPtrArray *free_ranges = g_ptr_array_new();
-    uint64_t free_base = start;
-    int i;
-
-    g_ptr_array_sort(ranges, crs_range_compare);
-    for (i = 0; i < ranges->len; i++) {
-        CrsRangeEntry *used = g_ptr_array_index(ranges, i);
-
-        if (free_base < used->base) {
-            crs_range_insert(free_ranges, free_base, used->base - 1);
-        }
-
-        free_base = used->limit + 1;
-    }
-
-    if (free_base < end) {
-        crs_range_insert(free_ranges, free_base, end);
-    }
-
-    g_ptr_array_set_size(ranges, 0);
-    for (i = 0; i < free_ranges->len; i++) {
-        g_ptr_array_add(ranges, g_ptr_array_index(free_ranges, i));
-    }
-
-    g_ptr_array_free(free_ranges, true);
-}
-
-/*
- * crs_range_merge - merges adjacent ranges in the given array.
- * Array elements are deleted and replaced with the merged ranges.
- */
-static void crs_range_merge(GPtrArray *range)
-{
-    GPtrArray *tmp =  g_ptr_array_new_with_free_func(crs_range_free);
-    CrsRangeEntry *entry;
-    uint64_t range_base, range_limit;
-    int i;
-
-    if (!range->len) {
-        return;
-    }
-
-    g_ptr_array_sort(range, crs_range_compare);
-
-    entry = g_ptr_array_index(range, 0);
-    range_base = entry->base;
-    range_limit = entry->limit;
-    for (i = 1; i < range->len; i++) {
-        entry = g_ptr_array_index(range, i);
-        if (entry->base - 1 == range_limit) {
-            range_limit = entry->limit;
-        } else {
-            crs_range_insert(tmp, range_base, range_limit);
-            range_base = entry->base;
-            range_limit = entry->limit;
-        }
-    }
-    crs_range_insert(tmp, range_base, range_limit);
-
-    g_ptr_array_set_size(range, 0);
-    for (i = 0; i < tmp->len; i++) {
-        entry = g_ptr_array_index(tmp, i);
-        crs_range_insert(range, entry->base, entry->limit);
-    }
-    g_ptr_array_free(tmp, true);
-}
-
-static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
-{
-    Aml *crs = aml_resource_template();
-    CrsRangeSet temp_range_set;
-    CrsRangeEntry *entry;
-    uint8_t max_bus = pci_bus_num(host->bus);
-    uint8_t type;
-    int devfn;
-    int i;
-
-    crs_range_set_init(&temp_range_set);
-    for (devfn = 0; devfn < ARRAY_SIZE(host->bus->devices); devfn++) {
-        uint64_t range_base, range_limit;
-        PCIDevice *dev = host->bus->devices[devfn];
-
-        if (!dev) {
-            continue;
-        }
-
-        for (i = 0; i < PCI_NUM_REGIONS; i++) {
-            PCIIORegion *r = &dev->io_regions[i];
-
-            range_base = r->addr;
-            range_limit = r->addr + r->size - 1;
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (!range_base || range_base > range_limit) {
-                continue;
-            }
-
-            if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
-                crs_range_insert(temp_range_set.io_ranges,
-                                 range_base, range_limit);
-            } else { /* "memory" */
-                uint64_t length = range_limit - range_base + 1;
-                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
-                    crs_range_insert(temp_range_set.mem_ranges, range_base,
-                                     range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-        }
-
-        type = dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
-        if (type == PCI_HEADER_TYPE_BRIDGE) {
-            uint8_t subordinate = dev->config[PCI_SUBORDINATE_BUS];
-            if (subordinate > max_bus) {
-                max_bus = subordinate;
-            }
-
-            range_base = pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_IO);
-            range_limit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_IO);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <= range_limit) {
-                crs_range_insert(temp_range_set.io_ranges,
-                                 range_base, range_limit);
-            }
-
-            range_base =
-                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
-            range_limit =
-                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <= range_limit) {
-                uint64_t length = range_limit - range_base + 1;
-                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
-                    crs_range_insert(temp_range_set.mem_ranges,
-                                     range_base, range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-
-            range_base =
-                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
-            range_limit =
-                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <= range_limit) {
-                uint64_t length = range_limit - range_base + 1;
-                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
-                    crs_range_insert(temp_range_set.mem_ranges,
-                                     range_base, range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-        }
-    }
-
-    crs_range_merge(temp_range_set.io_ranges);
-    for (i = 0; i < temp_range_set.io_ranges->len; i++) {
-        entry = g_ptr_array_index(temp_range_set.io_ranges, i);
-        aml_append(crs,
-                   aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
-                               AML_POS_DECODE, AML_ENTIRE_RANGE,
-                               0, entry->base, entry->limit, 0,
-                               entry->limit - entry->base + 1));
-        crs_range_insert(range_set->io_ranges, entry->base, entry->limit);
-    }
-
-    crs_range_merge(temp_range_set.mem_ranges);
-    for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
-        entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
-        assert(entry->limit <= UINT32_MAX &&
-               (entry->limit - entry->base + 1) <= UINT32_MAX);
-        aml_append(crs,
-                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
-                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
-                                    AML_READ_WRITE,
-                                    0, entry->base, entry->limit, 0,
-                                    entry->limit - entry->base + 1));
-        crs_range_insert(range_set->mem_ranges, entry->base, entry->limit);
-    }
-
-    crs_range_merge(temp_range_set.mem_64bit_ranges);
-    for (i = 0; i < temp_range_set.mem_64bit_ranges->len; i++) {
-        entry = g_ptr_array_index(temp_range_set.mem_64bit_ranges, i);
-        aml_append(crs,
-                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
-                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
-                                    AML_READ_WRITE,
-                                    0, entry->base, entry->limit, 0,
-                                    entry->limit - entry->base + 1));
-        crs_range_insert(range_set->mem_64bit_ranges,
-                         entry->base, entry->limit);
-    }
-
-    crs_range_set_free(&temp_range_set);
-
-    aml_append(crs,
-        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                            0,
-                            pci_bus_num(host->bus),
-                            max_bus,
-                            0,
-                            max_bus - pci_bus_num(host->bus) + 1));
-
-    return crs;
-}
-
 static void build_hpet_aml(Aml *table)
 {
     Aml *crs;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index fe0055fffb..2d3b2f2c6f 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -224,6 +224,20 @@ struct AcpiBuildTables {
     BIOSLinker *linker;
 } AcpiBuildTables;
 
+typedef
+struct CrsRangeEntry {
+    uint64_t base;
+    uint64_t limit;
+} CrsRangeEntry;
+
+typedef
+struct CrsRangeSet {
+    GPtrArray *io_ranges;
+    GPtrArray *mem_ranges;
+    GPtrArray *mem_64bit_ranges;
+} CrsRangeSet;
+
+
 /*
  * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
  * Serial Bus Type
@@ -432,6 +446,17 @@ build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
                      s->access_width, s->address);
 }
 
+Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set);
+
+void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit);
+
+void crs_replace_with_free_ranges(GPtrArray *ranges,
+                                         uint64_t start, uint64_t end);
+
+void crs_range_set_init(CrsRangeSet *range_set);
+
+void crs_range_set_free(CrsRangeSet *range_set);
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-- 
2.19.1


