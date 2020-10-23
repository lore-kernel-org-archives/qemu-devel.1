Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AE6C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8B921D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="gkDOgPjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8B921D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVysP-0002Pp-4p
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfz-0003qf-Am
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:19 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com
 ([40.107.243.109]:44513 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfx-00076m-3z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y10dImeJdrh9HP4wlw6DANMBafhrYmSOAcLjtXK13OZx93nQv59olrS2CEvuR66vw9p7pNHNQQ5vKPWief6zeYK+0CsoBNLQFRwhzxf/O3BpnGUG1uLwtYYTH8sjxTQd8vSBQ4Geo+6gGtCbdbv4ti3IUZ1IW7MKScgkPs5TLXqhTahotg+Hk8oTvtwJGXD317PYuzlE6Htqb1MiLNAosk7TSAo+bH/fzzDvnG6h0mDyQ+MxFOLD8yub9cYhSHKmeBw2nxoWu5raq+kvqAr1sHCRc4bLCB1HhqH1ceg1W779FtCvTbJ2vdn0kZLQOw31+qyjU9dZpW49CplZMRukBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNh0+4rDCiqh7oDMKxCGZ7eJ7MLrqJKBZnpYJUufLzU=;
 b=KM0IQgGbcsUJztlWam8+U4HIwxuG8vFK9DooZdhggr6nAixHj3entsPUMG3aFg7j/9XPpSpD9Ph6SrFA4OpoNlRE25xYtng6csdv2515QGJTTOInv9EBpkCHlzwbUC6zdQRu0AO4u+JrbT3F9YoiGeU/5qBvDSvnLkRzCYQjoeXLCUljkg4NQhQcwjtG5QDIcNLIbOZA6P9zs/tUw1c++BsOHkVMvhxEv1GBhOPF3EsQd5iXW2jrMVhfsJC9t4OGtU/juEyBSrgIBFLbDitN8dqGOZGlHR36W/5eda4IEOuEWtYwPZwzblArxJrdRFVI0RPVexMFbPMaqbkjJq4OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNh0+4rDCiqh7oDMKxCGZ7eJ7MLrqJKBZnpYJUufLzU=;
 b=gkDOgPjAcxsn2aBtgCPS4Kx0IHhgJ6K6u4Dh9p/XKiQ1/RGlncHbJr4FaenBZHBUpsZUj5PCPnNHq+LeEBs5HZiq/ZjLpdWWrUqNnMvmkAPU28lLYbOvlfma5xJQlECwG1uiqb2O+XJGwdmtLQsSGAQvd6Xo83PYHFTOAw5cndo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 15:08:03 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:03 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/17] fuzz: Add DMA support to the generic-fuzzer
Date: Fri, 23 Oct 2020 11:07:33 -0400
Message-Id: <20201023150746.107063-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b15ac8-fd44-4d28-7175-08d87765703f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4368683231AB5C14B8844085BA1A0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:34;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QMDUEuCrSJ52T8xoxURQGmr/G7PvGp5ZFGsSrOypd0FbafozxaqCsaD5bzbJJ2nSG0Avels822V2VYfRPghm46NCuHDae1qbC9FD15xRuurRJk0b6VugpUMAcpq9uyFc4kgn6tiGdATZJBq/pikaEz3XH6Iinm2WNrYOH5BD8Q3kU4668NzQDeLCT4mcWwx52aWu1hAiPtGIbrQ8cfCKFLdliJEyonWmSCjrjqxu1KEUuQXaiPwI7ojdU/4wZPdFcWiMXWjKFECPrhg67U+8ynsr4McoHb+QVw+jf7PFn7EhUc21H/lv5gpzovdG/FMqo8yDIJ9a2NFA0KY+1ZS+h91PHw+hGjNIWmRQC8SwhBNUihw0tNAgQuqErnHLSZx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(478600001)(956004)(8676002)(1076003)(186003)(26005)(316002)(6486002)(16526019)(8936002)(83380400001)(75432002)(6506007)(786003)(6916009)(86362001)(66946007)(66556008)(66476007)(6666004)(30864003)(2616005)(36756003)(52116002)(5660300002)(54906003)(6512007)(4326008)(2906002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vuRu1f3TfWO51K+HjGV6VZXZPgHnjzrX0nNG+gApv4Ymm88q4bPUphSXl5pX9BA9lOb9GdS+i3hIBqZ4KABIk+tIpiIwyB/LxDyC9efY+Zf7BjyQP7QpmJAFE5uAEhdl2baONz0Fu0Ls4jWmwk7tZ1FRocK9Y23MWCCWAv1LntT/pu12f44WUFrTlA/Pv25uNizyy8+CEtI2unTJEjx2vekZ98KK4DZ7MGIAs3E/9Tw2IG4x2/TRVT3sBLpixtJDKdss2TPVgbc6XE9RPMe6wyMMDD6V+HYdY801oG27G3mjtVoESeV7yeoYoBtZcVsTAAI6UoAugQpO/CVpNKAnoHSBeBQGIFqZnDc+5Si1qR/GiCXq7XcU4TsxmhzFCTBoxHi8i6FNrkPRLaRkB27q3acjlvoRaSYgsL8C0PFhOCy5j7dL+apu9P0kTjwYiRv74i+AWqW7Vl8zZRKqd/MJ9tIum4vFJtAp42b0NAoEApq9q3pomBMZVItcFb7C9pmEHLerCcpRP8oxnVPGuElmYQa0ximHG2kJPwZj/FzxFzFT+HwbghMX2l1s1nynO7FPHJKpElAQishBi3flyFwoyxjidOVFBTnM2Y5GQq8CedEB9/QdbsVYwb1JgYFWax++BsuMqKa/Pk6o2P7ewlK/hA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b15ac8-fd44-4d28-7175-08d87765703f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:03.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U7MekaCtquTeiQC+CGWzwcR8ehYQSlyBEkjfNmhLEOyW2lwMqmjvJcRU8h9ujcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4368
Received-SPF: pass client-ip=40.107.243.109; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a virtual-device tries to access some buffer in memory over DMA, we
add call-backs into the fuzzer(next commit). The fuzzer checks verifies
that the DMA request maps to a physical RAM address and fills the memory
with fuzzer-provided data. The patterns that we use to fill this memory
are specified using add_dma_pattern and clear_dma_patterns operations.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 include/exec/memory.h           |   7 +
 tests/qtest/fuzz/generic_fuzz.c | 228 ++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 042918dd16..93d27bff26 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -42,6 +42,13 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
 DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
                      IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
 
+#ifdef CONFIG_FUZZ
+void fuzz_dma_read_cb(size_t addr,
+                      size_t len,
+                      MemoryRegion *mr,
+                      bool is_write);
+#endif
+
 extern bool global_dirty_log;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 483d41fb2c..e6b18e4276 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
+#include "hw/boards.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -38,12 +39,16 @@ enum cmds {
     OP_WRITE,
     OP_PCI_READ,
     OP_PCI_WRITE,
+    OP_ADD_DMA_PATTERN,
+    OP_CLEAR_DMA_PATTERNS,
     OP_CLOCK_STEP,
 };
 
 #define DEFAULT_TIMEOUT_US 100000
 #define USEC_IN_SEC 1000000000
 
+#define MAX_DMA_FILL_SIZE 0x10000
+
 #define PCI_HOST_BRIDGE_CFG 0xcf8
 #define PCI_HOST_BRIDGE_DATA 0xcfc
 
@@ -56,6 +61,24 @@ static useconds_t timeout = DEFAULT_TIMEOUT_US;
 
 static bool qtest_log_enabled;
 
+/*
+ * A pattern used to populate a DMA region or perform a memwrite. This is
+ * useful for e.g. populating tables of unique addresses.
+ * Example {.index = 1; .stride = 2; .len = 3; .data = "\x00\x01\x02"}
+ * Renders as: 00 01 02   00 03 02   00 05 02   00 07 02 ...
+ */
+typedef struct {
+    uint8_t index;      /* Index of a byte to increment by stride */
+    uint8_t stride;     /* Increment each index'th byte by this amount */
+    size_t len;
+    const uint8_t *data;
+} pattern;
+
+/* Avoid filling the same DMA region between MMIO/PIO commands ? */
+static bool avoid_double_fetches;
+
+static QTestState *qts_global; /* Need a global for the DMA callback */
+
 /*
  * List of memory regions that are children of QOM objects specified by the
  * user for fuzzing.
@@ -84,6 +107,167 @@ static int get_io_address_cb(Int128 start, Int128 size,
     return 0;
 }
 
+/*
+ * List of dma regions populated since the last fuzzing command. Used to ensure
+ * that we only write to each DMA address once, to avoid race conditions when
+ * building reproducers.
+ */
+static GArray *dma_regions;
+
+static GArray *dma_patterns;
+static int dma_pattern_index;
+
+/*
+ * Allocate a block of memory and populate it with a pattern.
+ */
+static void *pattern_alloc(pattern p, size_t len)
+{
+    int i;
+    uint8_t *buf = g_malloc(len);
+    uint8_t sum = 0;
+
+    for (i = 0; i < len; ++i) {
+        buf[i] = p.data[i % p.len];
+        if ((i % p.len) == p.index) {
+            buf[i] += sum;
+            sum += p.stride;
+        }
+    }
+    return buf;
+}
+
+static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
+{
+    unsigned access_size_max = mr->ops->valid.max_access_size;
+
+    /* Regions are assumed to support 1-4 byte accesses unless
+       otherwise specified.  */
+    if (access_size_max == 0) {
+        access_size_max = 4;
+    }
+
+    /* Bound the maximum access by the alignment of the address.  */
+    if (!mr->ops->impl.unaligned) {
+        unsigned align_size_max = addr & -addr;
+        if (align_size_max != 0 && align_size_max < access_size_max) {
+            access_size_max = align_size_max;
+        }
+    }
+
+    /* Don't attempt accesses larger than the maximum.  */
+    if (l > access_size_max) {
+        l = access_size_max;
+    }
+    l = pow2floor(l);
+
+    return l;
+}
+
+/*
+ * Call-back for functions that perform DMA reads from guest memory. Confirm
+ * that the region has not already been populated since the last loop in
+ * generic_fuzz(), avoiding potential race-conditions, which we don't have
+ * a good way for reproducing right now.
+ */
+void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
+{
+    /* Are we in the generic-fuzzer or are we using another fuzz-target? */
+    if (!qts_global) {
+        return;
+    }
+
+    /*
+     * Return immediately if:
+     * - We have no DMA patterns defined
+     * - The length of the DMA read request is zero
+     * - The DMA read is hitting an MR other than the machine's main RAM
+     * - The DMA request is not a read (what happens for a address_space_map
+     *   with is_write=True? Can the device use the same pointer to do reads?)
+     * - The DMA request hits past the bounds of our RAM
+     */
+    if (dma_patterns->len == 0
+        || len == 0
+        /* || mr != MACHINE(qdev_get_machine())->ram */
+        || is_write
+        || addr > current_machine->ram_size) {
+        return;
+    }
+
+    /*
+     * If we overlap with any existing dma_regions, split the range and only
+     * populate the non-overlapping parts.
+     */
+    address_range region;
+    bool double_fetch = false;
+    for (int i = 0;
+         i < dma_regions->len && (avoid_double_fetches || qtest_log_enabled);
+         ++i) {
+        region = g_array_index(dma_regions, address_range, i);
+        if (addr < region.addr + region.size && addr + len > region.addr) {
+            double_fetch = true;
+            if (addr < region.addr
+                && avoid_double_fetches) {
+                fuzz_dma_read_cb(addr, region.addr - addr, mr, is_write);
+            }
+            if (addr + len > region.addr + region.size
+                && avoid_double_fetches) {
+                fuzz_dma_read_cb(region.addr + region.size,
+                        addr + len - (region.addr + region.size), mr, is_write);
+            }
+            return;
+        }
+    }
+
+    /* Cap the length of the DMA access to something reasonable */
+    len = MIN(len, MAX_DMA_FILL_SIZE);
+
+    address_range ar = {addr, len};
+    g_array_append_val(dma_regions, ar);
+    pattern p = g_array_index(dma_patterns, pattern, dma_pattern_index);
+    void *buf = pattern_alloc(p, ar.size);
+    hwaddr l, addr1;
+    MemoryRegion *mr1;
+    uint8_t *ram_ptr;
+    while (len > 0) {
+        l = len;
+        mr1 = address_space_translate(first_cpu->as,
+                                      addr, &addr1, &l, true,
+                                      MEMTXATTRS_UNSPECIFIED);
+
+        if (!(memory_region_is_ram(mr1) ||
+              memory_region_is_romd(mr1))) {
+            l = memory_access_size(mr1, l, addr1);
+        } else {
+            /* ROM/RAM case */
+            ram_ptr = qemu_map_ram_ptr(mr1->ram_block, addr1);
+            memcpy(ram_ptr, buf, l);
+            break;
+        }
+        len -= l;
+        buf += l;
+        addr += l;
+
+    }
+    if (qtest_log_enabled) {
+        /*
+         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
+         * that will be written by qtest.c with a DMA tag, so we can reorder
+         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
+         * command.
+         */
+        fprintf(stderr, "[DMA] ");
+        if (double_fetch) {
+            fprintf(stderr, "[DOUBLE-FETCH] ");
+        }
+        fflush(stderr);
+    }
+    qtest_memwrite(qts_global, ar.addr, buf, ar.size);
+    g_free(buf);
+
+    /* Increment the index of the pattern for the next DMA access */
+    dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
+}
+
 /*
  * Here we want to convert a fuzzer-provided [io-region-index, offset] to
  * a physical address. To do this, we iterate over all of the matched
@@ -349,6 +533,35 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
     }
 }
 
+static void op_add_dma_pattern(QTestState *s,
+                               const unsigned char *data, size_t len)
+{
+    struct {
+        /*
+         * index and stride can be used to increment the index-th byte of the
+         * pattern by the value stride, for each loop of the pattern.
+         */
+        uint8_t index;
+        uint8_t stride;
+    } a;
+
+    if (len < sizeof(a) + 1) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    pattern p = {a.index, a.stride, len - sizeof(a), data + sizeof(a)};
+    p.index = a.index % p.len;
+    g_array_append_val(dma_patterns, p);
+    return;
+}
+
+static void op_clear_dma_patterns(QTestState *s,
+                                  const unsigned char *data, size_t len)
+{
+    g_array_set_size(dma_patterns, 0);
+    dma_pattern_index = 0;
+}
+
 static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
 {
     qtest_clock_step_next(s);
@@ -409,6 +622,8 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
+        [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -438,6 +653,8 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
             setitimer(ITIMER_VIRTUAL, &timer, NULL);
         }
 
+        op_clear_dma_patterns(s, NULL, 0);
+
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
             nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
@@ -454,6 +671,7 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
             /* Advance to the next command */
             cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
             Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
+            g_array_set_size(dma_regions, 0);
         }
         _Exit(0);
     } else {
@@ -468,6 +686,9 @@ static void usage(void)
     printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
     printf("QEMU_FUZZ_OBJECTS= "
             "a space separated list of QOM type names for objects to fuzz\n");
+    printf("Optionally: QEMU_AVOID_DOUBLE_FETCH= "
+            "Try to avoid racy DMA double fetch bugs? %d by default\n",
+            avoid_double_fetches);
     printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
             "0 to disable. %d by default\n", timeout);
     exit(0);
@@ -539,9 +760,16 @@ static void generic_pre_fuzz(QTestState *s)
     if (getenv("QTEST_LOG")) {
         qtest_log_enabled = 1;
     }
+    if (getenv("QEMU_AVOID_DOUBLE_FETCH")) {
+        avoid_double_fetches = 1;
+    }
     if (getenv("QEMU_FUZZ_TIMEOUT")) {
         timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
     }
+    qts_global = s;
+
+    dma_regions = g_array_new(false, false, sizeof(address_range));
+    dma_patterns = g_array_new(false, false, sizeof(pattern));
 
     fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
     fuzzable_pci_devices   = g_ptr_array_new();
-- 
2.28.0


