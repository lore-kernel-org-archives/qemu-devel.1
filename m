Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39390C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E418C2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="b/VJCvAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E418C2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HLB-0005cW-5U
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKA-0003vA-15
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:50 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com
 ([40.107.236.94]:24608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK7-0001Y3-Vu
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctWiDwctOI1DSsZqoA7vvOSu5Pc/LnKO3BWXu+vqfIutQcDf5/DQmWmPtcG3fslvPhkPhC29d+Yl1xkNTrWFPqpFarS9C2y1t/DNVqfna6lnEdEWSqLEcMP/Prb80VdGfJHvJWdP6Ynvr+Y+zEr4jdtdSlO78dxvSIz+8woJMJzstgsZx/Da6iXTEVFdGYLY/1Xq/6ZIhh1c4DVnIF3OzHJ7Rkz5F72QPKAW/XX1bwLKbu265+mC7pvyXdmDYdwvYnE73coT4/NZJB6n9kdfTMWyLp++C5YC4ARK5GpGC97ks6VFtGjd+v+a1uVvoKcRNwjne7RMaGJBPdRs6D6A3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCggRrhPh/AAJe2zJp4UEjc0k4DnsBalDqzad0fhcMs=;
 b=EHyjv9jDThk9rMTOz5cWZUxw1avhVzhFOwENfpf+0bK3poLKwwXGIiW0r94h7JSGOLSy5GIrEaTMnLviPBDzuZH5/pCVGJKW6I04Z2rBELu1IwpuTXgzuNq5yL7BjJMm1EMObke0VRZG0pvNrgBoj1XHTNUkW+9Sjmb3mRHvj4iugQChDFLW8AZx1/YLR03N9kyfGnfeVRu95ejfQ0OvHRnG7YVbm97/4jZ87uHeD877830csnZrVk49zdNMYEIgIA86oY3af25J5ff3Za3KtNT7iQkD3UM4LYr6Oy7f9XT0Nj1gs8z6YGarubetLeYokHVpNNSos6E9n7II6OLAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCggRrhPh/AAJe2zJp4UEjc0k4DnsBalDqzad0fhcMs=;
 b=b/VJCvAzeztyqu0MfgKEH9sJwr/S3s8sv5E5p+R0Qr2cPNONg2QOO2wKhGaMRUXsO16HnPiu9AvC09/hPtTV4On4kMk8m4NKYaaMzEBgGt/MBetIqMjiKAVLVxHSHOwxeKfizEhyBuHFfxpiZGsD+3F2Z+51X85fiD+2qysoXWc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:37 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:37 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/15] fuzz: Add DMA support to the generic-fuzzer
Date: Wed, 19 Aug 2020 02:10:59 -0400
Message-Id: <20200819061110.1320568-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:35 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc379912-4cd3-48c7-c7b5-08d84406ba8e
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3934208E75E4677AB1BD7CEABA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/UfrigJxnsBELpJ1VRkc2wR5k6ksN2ZKRffmPvscow55fRoHgrl+0pXHpH91I5iXWWmBHgFJN5slyaV23Ze3G8YI2E0mefno0+QBID27WavJ1pGUGD0qnBKcJbQKMhUS2u2XM/u7qMo9OSaBXzerCniO13xR9NUTWSC3p9YLBlF2UfzGOy6aIe5D3Fy9iujXYVayYn+gcbhyCvYBTzRfWef62HrFtNSoSXwTyPI2wn+MH5vQk4tWtH7wLnaLKgMjD4+1dRy0HuV3LePK3E5adgOvKjYxIikdU/P+zk8IqlteFoyKkjYe5cl1l/i8FPlqfZC2mYYBgATOrAj/pp7fO3RE4qjeKA0cKXpwSXX/Br/XN2/VGImWzmjMJahvf4t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(6666004)(2906002)(6512007)(8936002)(6916009)(83380400001)(6486002)(54906003)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +1Zk0ZODLb2XwGggO2nFcYhTLrCEUcb6sKp0L7Vbmsr1LtJ14CwDsumvDUGJNbbTK5jDrHosYEeJ0azMbu08ko/N2n++Tp/hZLJLID7NGEGEtsVjhnbbTnSED5guUYaIX92JZ9++/tdHj+s1b1LgX3WKB03B2rlWGNVXmheG/dcHHnZBWjv1dvfDSzi24IS7u/Se8MWWMgbNj+mnRMrlmKKyzUFU/KFlk3OS8RQI3WMT9a6/ZVE2fh/2OpaQHDirvBNMZz45iZdo0qRo/Oc/Im0SD8NoM/WFuXkK0sJdfEe10SPTqXW7wxiizObmDenf6rQD83fbpipWRmUBuJLCEC3OJ4Knu0u3jMEKPpf1xjk/UDKE1AwmE2n0TRM6bqzvCwvzSWoyxRmlzKmmQyxKFzFx035yPlLeNF+sNNQdn+UxFhkM3w2anGzYfboTXdsoqxNpXGoL09YdTRK1FlvxLsXBT6Rd8i61AP4KwctyKcH/dwT2d8Xw9NwPzvssiXBeoUbBEpVFpGoTGdjIuI5nKw0sU3n753/2ZtNN0Tzy5IGUH8lQ+ej1SqnDCGHn7fhLYB09zru6/P4a1ICHRhkg2qR+bQDbbtEuA9wN7FztmQlHLiXB7Jjzyn17OXKL6kg3F3jwotdOcA4llsLnxfYj2w==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc379912-4cd3-48c7-c7b5-08d84406ba8e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:37.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX+32amdRqkVzkyPVXLec5qetESaqd+9GuB33KBR7NRCN32a9YcqeWaSp12wpVZs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3934
Received-SPF: pass client-ip=40.107.236.94; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a virtual-device tries to access some buffer in memory over DMA, we
add call-backs into the fuzzer(next commit). The fuzzer checks verifies
that the DMA request maps to a physical RAM address and fills the memory
with fuzzer-provided data. The patterns that we use to fill this memory
are specified using add_dma_pattern and clear_dma_patterns operations.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 178 ++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 17b572a439..36d41acea0 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -25,6 +25,8 @@
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
+#include "hw/boards.h"
+#include "exec/memory-internal.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -38,12 +40,16 @@ enum cmds{
     OP_WRITE,
     OP_PCI_READ,
     OP_PCI_WRITE,
+    OP_ADD_DMA_PATTERN,
+    OP_CLEAR_DMA_PATTERNS,
     OP_CLOCK_STEP,
 };
 
 #define DEFAULT_TIMEOUT_US 100000
 #define USEC_IN_SEC 100000000
 
+#define MAX_DMA_FILL_SIZE 0x10000
+
 #define PCI_HOST_BRIDGE_CFG 0xcf8
 #define PCI_HOST_BRIDGE_DATA 0xcfc
 
@@ -53,6 +59,24 @@ typedef struct {
 } address_range;
 
 static useconds_t timeout = 100000;
+/*
+ * A pattern used to populate a DMA region or perform a memwrite. This is
+ * useful for e.g. populating tables of unique addresses.
+ * Example {.index = 1; .stride = 2; .len = 3; .data = "\x00\x01\x02"}
+ * Renders as: 00 01 02   00 03 03   00 05 03   00 07 03 ...
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
@@ -60,6 +84,116 @@ static useconds_t timeout = 100000;
 static GPtrArray *fuzzable_memoryregions;
 static GPtrArray *fuzzable_pci_devices;
 
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
+void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
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
+/*
+ * Call-back for functions that perform DMA reads from guest memory. Confirm
+ * that the region has not already been populated since the last loop in
+ * general_fuzz(), avoiding potential race-conditions, which we don't have
+ * a good way for reproducing right now.
+ */
+void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
+{
+    /* Are we in the general-fuzzer or are we using another fuzz-target? */
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
+        || (mr != MACHINE(qdev_get_machine())->ram && !(mr->ops == &unassigned_mem_ops))
+        || is_write
+        || addr > current_machine->ram_size) {
+        return;
+    }
+
+    /*
+     * If we overlap with any existing dma_regions, split the range and only
+     * populate the non-overlapping parts.
+     */
+    for (int i = 0; i < dma_regions->len && avoid_double_fetches; ++i) {
+        address_range region = g_array_index(dma_regions, address_range, i);
+        if (addr < region.addr + region.len && addr + len > region.addr) {
+            if (addr < region.addr) {
+                fuzz_dma_read_cb(addr, region.addr - addr, mr, is_write);
+            }
+            if (addr + len > region.addr + region.len) {
+                fuzz_dma_read_cb(region.addr + region.len,
+                        addr + len - (region.addr + region.len), mr, is_write);
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
+    void *buf = pattern_alloc(p, ar.len);
+    if (getenv("QTEST_LOG")) {
+        /*
+         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
+         * that will be written by qtest.c with a DMA tag, so we can reorder
+         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
+         * command.
+         */
+        fprintf(stderr, "[DMA] ");
+        fflush(stderr);
+        qtest_memwrite(qts_global, ar.addr, buf, ar.len);
+    } else {
+       /*
+        * Populate the region using address_space_write_rom to avoid writing to
+        * any IO MemoryRegions
+        */
+        address_space_write_rom(first_cpu->as, ar.addr, MEMTXATTRS_UNSPECIFIED,
+                buf, ar.len);
+    }
+    free(buf);
+
+    /* Increment the index of the pattern for the next DMA access */
+    dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
+}
+
 /*
  * Here we want to convert a fuzzer-provided [io-region-index, offset] to
  * a physical address. To do this, we iterate over all of the matched
@@ -350,6 +484,35 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
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
@@ -396,6 +559,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
+        [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -425,6 +590,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
             setitimer(ITIMER_VIRTUAL, &timer, NULL);
         }
 
+        op_clear_dma_patterns(s, NULL, 0);
+
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
             nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
@@ -441,6 +608,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
             /* Advance to the next command */
             cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
             Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
+            g_array_set_size(dma_regions, 0);
         }
         _Exit(0);
     } else {
@@ -455,6 +623,9 @@ static void usage(void)
     printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
     printf("QEMU_FUZZ_OBJECTS= "
             "a space separated list of QOM type names for objects to fuzz\n");
+    printf("Optionally: QEMU_AVOID_DOUBLE_FETCH= "
+            "Try to avoid racy DMA double fetch bugs? %d by default\n",
+            avoid_double_fetches);
     printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
             "0 to disable. %d by default\n", timeout);
     exit(0);
@@ -522,9 +693,16 @@ static void general_pre_fuzz(QTestState *s)
     if (!getenv("QEMU_FUZZ_OBJECTS")) {
         usage();
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
 
     fuzzable_memoryregions = g_ptr_array_new();
     fuzzable_pci_devices   = g_ptr_array_new();
-- 
2.27.0


