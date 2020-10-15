Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C5FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0342078A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="O/ZlX3QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0342078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3Yk-0001vJ-PB
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WN-0007Zu-Qe
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:19 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com
 ([40.107.75.103]:37594 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WL-0000mT-Kb
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+/08XjLx/4qvIIEt4Yrb5J6qQOkSoPQ7gq0Q6C5CbbuhuJhhEK7re6Sf9Ix7GlA5wrJwdW1sqc71Dspf7j/dlc1816Kbhgn4eUfRLRoFHR2GgzhPb+D4T2Mq7H+cSeTOH7mlPDhlZLD2EbJR9ADFLOs1uRid2VsgHOCiMzWPb7VyOX4VJz09vjPI+ipy7/Uha5g38dS6HcKusVecebR5UvGFgwF05zSBnEZjCVhqmOEwIbIyAsUjtSbxP2JjI+DGfE6GL93meo7qBQN1I3w8gnz+bVUxbToWwVauaKNU8d01pGr9BKHXxfPQB1C88UD4MSz4hOFp0xSe7NE/pmnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBF/BVG5rDNEcd2X3pagRCpq29Gcig777jMSLHfO/2o=;
 b=X2+WtvxibY9j2eDTK1Ks3KAu86vv2ZcEvULSDl6hv6jq15xo+D7mkypAs+pwiCuVh217mjIpJft4LxuPxHzc4qqze34hkMExmPYxbq9Dje/Rlwtc5UWIXgUXWOTaa7reR3ouV3yZXybk6LMybydHixzSsBHwaLRlmKo0IXwECP+UV3B6y0bDDNcKk7iUU8Qy6lNG01ZKOL7gniAUgiglB3P/CHc4E7gUNLyD0tagaMsaZbU92qrB0LccRZN080uOy/hgW4hgbKGUsKRjkYKucNCITcEMIP9GSc5qgkK6axntznxQmr+ZOMZ67gYB/uc4zqnREP+OSEVWYMJeOyePOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBF/BVG5rDNEcd2X3pagRCpq29Gcig777jMSLHfO/2o=;
 b=O/ZlX3QJO+jq61dTXB6NIgZsuso6XYCM/ZIyxaMzooWyS8puSEXnKulCiOFgs8CsVSyVPtlFyojU5PpcJT4ilgiRUBR7TOWJQO/1ibZaTOBH8I1G2Qcd+ssGP/4t6DXKE9ZZyDwHArGOrmsl479e/2AQK3jkuhfsBnFd8dbsZk4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:41:56 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:41:56 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/16] fuzz: Add DMA support to the generic-fuzzer
Date: Thu, 15 Oct 2020 09:41:24 -0400
Message-Id: <20201015134137.205958-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015134137.205958-1-alxndr@bu.edu>
References: <20201015134137.205958-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:208:257::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0055.namprd13.prod.outlook.com (2603:10b6:208:257::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 13:41:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5def9273-3d4b-4732-a36a-08d8711014d5
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB54653D0681D3E03B032F2413BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOVer//jGNJGjJPLI4rVAcksah1CQZ+egor0Z6BsjFqSDP0gnH9xUeSii8FIyQlXWf8ISgp+KFc/DIWK1fbNiGJOQN7fLF+aYR8tPUJD8uudsO5FbYGbgCt+ejgCfTY/tz8yF1+TZrDu2NYAwRouE7iqzxJQVtxcmBXPokmzOJEAIZpP89hg5ZG68EX0E051CoLyoO5o08Fk7Ll0lmxlj2ClF0mEiRnzwHrZdT4nHJJ25UMWfKDOckEefNPlq3TR00O5wKJGUAsUATC0EDmOnpT+xa+2sXJNUqQnw0skzbkYAdXcF4PMH9YIg9fB6arWtWpT12HsZVPuUUP6c7iVHqfE4+EYDsGNdLxwvYtaVHKfIL/qK/3Jqa7eZgpVkkuR3c+3BydplLpyrPSFB54tgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: imSMLpG6alMQdIgZYlBLrRqnu9tyImSHAJR76F8HwMRA+ib/dtkzgYjeTAjYXIbhjz+Tuqp3J0jL5pXmONLStLJqP5KrvYqogpJbph+bWpY9nCXcPNCMAsnV4XMClNFDBLaan0gFULV/BPzyOrpQNJPISM2z7BjbSJfAmILe4lvJRvE2wYdGaz9Nu9OjlYUGffxhyRiokzRUD3ifvgyNBGpy26kN8ruCezrxuhHVGOpd0aquNMvtWj52AQsNCLi16uZkp3TtvWapqOWsSa9vaRXvGsdvlU7pXWUDTOMcawIerSXyBZz9YtdkPkKz0COh4stg9l6lDTy8lcsKgllS8jhbKHaB04frMg3wx5N15z9As6dDS/bBhFjkCkGMp3E7Z3LG3fjQnJKlDring3j/D0YLI/X70J7OfqzelQvFjySouh60HKkbc/WJ1t+TKb6YaHDMdNHW2lXc5wvQPaDngCyy757HGkTwkgiidBqF65Bks7LVNBgM0HOmHU63WhxcslkWzH1A4Uf912m3AXWbF0s1O+gcYKt/SdJY03A/KZkWRiLGnRpQ79ph5yqDuLELURjSTunMT7akcLqJ/qF/StnWHTz5rEqvz8CgtJOPDsZAgKxGdjFxaNa+j0bxsEpkKae72UlyJAb1ycu8sJhNqw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5def9273-3d4b-4732-a36a-08d8711014d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:41:55.7604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0JsSgMKqmzLwm+SwCOthl8vc3U8K0mvYkoXgs9RkD7Q/i+vkMtYlSCm/J505lWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.103; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
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
 tests/qtest/fuzz/general_fuzz.c | 230 ++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index ef754843ed..0fd42a16da 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
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
 #define USEC_IN_SEC 100000000
 
+#define MAX_DMA_FILL_SIZE 0x10000
+
 #define PCI_HOST_BRIDGE_CFG 0xcf8
 #define PCI_HOST_BRIDGE_DATA 0xcfc
 
@@ -56,6 +61,24 @@ static useconds_t timeout = 100000;
 
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
@@ -84,6 +107,169 @@ static int get_io_address_cb(ram_addr_t start, ram_addr_t size,
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
+        qtest_memwrite(qts_global, ar.addr, buf, ar.size);
+    }
+    g_free(buf);
+
+    /* Increment the index of the pattern for the next DMA access */
+    dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
+}
+
 /*
  * Here we want to convert a fuzzer-provided [io-region-index, offset] to
  * a physical address. To do this, we iterate over all of the matched
@@ -346,6 +532,35 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
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
@@ -405,6 +620,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
+        [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -434,6 +651,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
             setitimer(ITIMER_VIRTUAL, &timer, NULL);
         }
 
+        op_clear_dma_patterns(s, NULL, 0);
+
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
             nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
@@ -450,6 +669,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
             /* Advance to the next command */
             cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
             Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
+            g_array_set_size(dma_regions, 0);
         }
         _Exit(0);
     } else {
@@ -464,6 +684,9 @@ static void usage(void)
     printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
     printf("QEMU_FUZZ_OBJECTS= "
             "a space separated list of QOM type names for objects to fuzz\n");
+    printf("Optionally: QEMU_AVOID_DOUBLE_FETCH= "
+            "Try to avoid racy DMA double fetch bugs? %d by default\n",
+            avoid_double_fetches);
     printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
             "0 to disable. %d by default\n", timeout);
     exit(0);
@@ -534,9 +757,16 @@ static void general_pre_fuzz(QTestState *s)
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


