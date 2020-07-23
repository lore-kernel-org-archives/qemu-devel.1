Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC84C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0D820825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ywHwIwbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0D820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySA7-0004Rp-OC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5q-0004MM-Nv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:26 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5o-0002Ew-Rx
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnHvthmy9AouOsXSI9sj8g0CBWMjJ/3Y7Xauj28psOUTQQDdq9JE9uwLofdcGM9q8AmK0oO8l1TqwG++8zhy479BSZ+SEvBS5ezkaG6TmT3EDqOOiHGesI8v8cGwhpgLVO5wXLfw++6f5wvIL/JatLIGhhg0VO6g/uqrEvD9yXaXoNGZAl+AAEZHb2MBTF1dfZyHRXBSbrgcN6KY4bmmfZbZPhXICIdH4ynEXcGm3yzzblSkexlfH8MNd+hX/0ocauFdbxvs0vfzj4OgdL6KLVy5k4lPp0mn1IYaUpGLyW2gRjF9owF37NrNRDb/31uv9VmRARXwUJLb+uqE+JDMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmiix8EvCr9JdwhgaWGuVjYKqk1iZSF+8+6ho/q3ttA=;
 b=d631svDiEUfV4QMXZk1P59FXyEJbtJOVjzARyO97hz5tcYokBQSUa3JvOYl8L6Lqt8hkjCmKlfBxD2MIHVJpglw8BUpFMuH4SVzgMdNSuMWIqmfKkgPO+kP8+qyZDmb2kzLwzA2mCaBb5c+zXJtskaSs2pLcid2DAVwLGLJNk6+JdbGMcxGEQ0Yy7ALVYxJY9BMdca5PBuRGfjPZwqss7mFqbbLhworVf8R2ElfgR7mKpXA6JtOsTCsr+XMbnLQd7drfKAWIPxuXaG5h7nIE71hupz8w2E/OModKBl+Xo4FVlfChqI/W0mTT67P5AWds5TpZreS8Njbp0fvpbPSPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmiix8EvCr9JdwhgaWGuVjYKqk1iZSF+8+6ho/q3ttA=;
 b=ywHwIwbv6CnivLcuSu7PYvQ4M03vzQIDmLFS/f+ICaAy9Q5YztHwYnbJJ89zXSv0PlpQPyOF1hX1ac9KBjayA0+AP3cq5okaWwKXynH72qCNwfWB8JPr3PYT0G+ORLi60W0NWWYvH3n1QxS2zgPizVCiykafeDxNYoastJ0V1Fw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:11 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:11 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] fuzz: Add DMA support to the generic-fuzzer
Date: Wed, 22 Jul 2020 23:39:25 -0400
Message-Id: <20200723033933.21883-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:09 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff7054e-1ae4-4cdf-1053-08d82eba19d7
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB398284DE8E68AC13ADB74309BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEWJP4x9op2eXp1WL3IZZODImfbDrQJqiM/q/itxAA/oz8gvN3AKDojAJkQ2zKOb40gzDPybg5NO62eaa3wn3mxGUJefkag5EpZvFAZ4Jx0QqM+JlFU+MaGy0VDubLqs86PjK42QWw1+sk9OOtvh+CX+G2fc1KqntRBMgH2dewGRLW0corJjXT6KPH5qXBWAg/AVnva6HVYO4C8xMQWBoqFeaiqLgz07EQUKSWq85sgtbvWeSIf2Sj6FVG/s+PfE4prZJg9KIDFxS3CfNYeIOYlyAHuEUusdqQOpqPKJQ2ZPy+PUijSQxhswfGurqA4NvXrVR2BPJg3y3IGYByHXW70K5R3qseH3gxL0GepZgJiteslENytU9uXfqsyEyRNn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(7416002)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qdi8NyNRfWiTgb9Bjq3TFyAtpOMiQVT5aQxLkClX/8RwdCGCRc2cj9QEyRuaMOt9mfiYvuwHfH0gxZ3i3067pE9N8OOinGz6JN+B5//4/xmDQwkrwTH61owfIWm2++gvSQe7O6I2uf3vPP1Sh3GfZOLmQnHPKGSeL7zXt8r6M9dzr3tSH0s3Lky/pAcewAePHb5oW/WhAQnMb+pz9D6LzFtH7PYh0F7aOgy1czCzgKue8VxaaqmXUto6uxRvH8APB+gOiVMz22cQI9VF34OO3QRUdc2fA/hWKd5Pm7BhNIm4YktY6leizXlZEPI8XHafEirJfiImoEGAYbloKFxqFaeLWUrCfIP7wWom6ggqR99lqpRNy2hsEQS/Pb9T/39pfn6nCDQ40Z/WELgSAq3mhei745mCfN8euL35IXD8WxIcXYM7kCdgjVGST7NQLyMAPcVborgAUHDlXPhiyWxnGbkVSYPcgJ+LGRn9qPV82xQ=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff7054e-1ae4-4cdf-1053-08d82eba19d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:11.4999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML/K1PbsB1BADjKKSLJ/Fhd4HKWAA1aQV15hbqZ0W9dMGxjVXyUimM0iKbGdJhsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, dstepanov.src@gmail.com, stefanha@redhat.com,
 andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
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
 tests/qtest/fuzz/general_fuzz.c | 177 ++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index e715b77d59..4b6967c5d2 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -27,6 +27,7 @@
 #include "tests/qtest/libqos/pci.h"
 #include "tests/qtest/libqos/pci-pc.h"
 #include "hw/pci/pci.h"
+#include "hw/boards.h"
 
 /*
  * CMD_SEP is a random 32-bit value used to separate "commands" in the fuzz
@@ -34,6 +35,7 @@
  */
 #define CMD_SEP "\x84\x05\x5C\x5E"
 #define DEFAULT_TIMEOUT_US 100000
+#define MAX_DMA_FILL_SIZE 0x10000
 
 #define PCI_HOST_BRIDGE_CFG 0xcf8
 #define PCI_HOST_BRIDGE_DATA 0xcfc
@@ -44,6 +46,24 @@ typedef struct {
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
@@ -51,6 +71,122 @@ static useconds_t timeout = 100000;
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
+int dma_pattern_index;
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
+     * If the device is trying to read from a ROM, exit early. We do not want
+     * to fuzz devices using data that we have no control over.
+     */
+    if (mr->readonly) {
+        _Exit(0);
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
+        || mr != MACHINE(qdev_get_machine())->ram
+        || is_write
+        || addr > current_machine->ram_size) {
+        return;
+    }
+
+    /*
+     * If we overlap with any existing dma_regions, split the range and only
+     * populate the non-overlapping parts.
+     */
+    for (int i = 0; i < dma_regions->len && !avoid_double_fetches; ++i) {
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
@@ -334,6 +470,35 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
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
@@ -380,6 +545,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         op_write,
         op_pci_read,
         op_pci_write,
+        op_add_dma_pattern,
+        op_clear_dma_patterns,
         op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -433,6 +600,9 @@ static void usage(void)
     printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
     printf("QEMU_FUZZ_OBJECTS= "
             "a space separated list of QOM type names for objects to fuzz\n");
+    printf("Optionally: QEMU_AVOID_DOUBLE_FETCH= "
+            "Try to avoid racy DMA double fetch bugs? %d by default\n",
+            avoid_double_fetches);
     printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
             "0 to disable. %d by default\n", timeout);
     exit(0);
@@ -502,9 +672,16 @@ static void general_pre_fuzz(QTestState *s)
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
     fuzzable_pci_devices = g_ptr_array_new();
-- 
2.27.0


