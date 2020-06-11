Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 05:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A4D2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 05:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="aqpZw6F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4D2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGEq-0003KY-Q9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 01:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGDg-00026v-KW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:57:44 -0400
Received: from mail-dm6nam11on2121.outbound.protection.outlook.com
 ([40.107.223.121]:54785 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGDe-0002UZ-Rk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:57:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5bK5v2Bkd/bdxo9aBJWTMh66nnkcy7BR95a0mopJGRSwdNhbcLUs0j1YTvwlEb3p8Bk/bY0I98l80NQiN8fjEFH8bBb3+eCCKrYuf67qYe/Kk6IJeJCkI0RnhHbBWKRbhOR6TcsUsx5oIfhVzv1vGjq0kZBeGT2Jqao7AoSsH8uCqolMCaF1XpziD4tzWGzP+MxRyV4LcZaYTwNvcuBebA4EC3NVmfHEykhF7c/eEpFAu0ey5ovGLOi4/WCeUYWL+8/ge+UrrZbgYeOY/QrqsiJng0f6xapGWzLsbLYoG9oLa/aMVv4fCZxgzjd/dVIFcFq12gCZJm+Lhq4jMOL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MdCF+/P8HlJidxBy2y6Um9kkoMt6zi83vi43YiJnXo=;
 b=XrzKj5d1lGCuvxjKKSvFkP/+QOpNaH0j/W3Af7pPPfPVje6Heci5pBZfDNl2YEK8X/WV8wVt9rM9aJoNB3pm9lBvPDTTAAOpWc/vW0vFTjGN8QKT4Wib6mixlRI5BFqmYv1g57KmGSFrccsHq6VFAh9kUZzsiDHObhzkqNMu/O8t5uZuHYrb9X5nbLDeYobqhfInomjS7SPqL6BqkeL9o2RHGJrrkQR9e9fu2FfUhqAxuNTVFuH4AYDzG1wk9UtjaDvRPwOwJNWrGtUaxhJdDAo0w1JgjprYVuWFkCJFpvFPv3r4zjIdWOTMOt56EiY2/ZUrmyeP+iqopMrjUW46/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MdCF+/P8HlJidxBy2y6Um9kkoMt6zi83vi43YiJnXo=;
 b=aqpZw6F90Ax/7j44yGDXC04njv2cJogZMKR5tY//b9RF8d2n/viz4OOA5ktyFLyrObdAvmhaWrha5+if/aCnVzzxZs218UGvDR0P1FtBIVd6CVjzmaEoPUKFTEMNx3XTwCAoozjBrfyTy21RaKHRknRN9dezoqgm+RWKdXMXB4M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4173.namprd03.prod.outlook.com (2603:10b6:805:c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 05:57:07 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 05:57:07 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] fuzz: add a general fuzzer for any qemu arguments
Date: Thu, 11 Jun 2020 01:56:49 -0400
Message-Id: <20200611055651.13784-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611055651.13784-1-alxndr@bu.edu>
References: <20200611055651.13784-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 05:57:06 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c10b736d-7e03-4058-6dd0-08d80dcc4609
X-MS-TrafficTypeDiagnostic: SN6PR03MB4173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB41732F22D58B306CE264A83CBA800@SN6PR03MB4173.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5l4erzmarANYM0lzCYQkYbFAG/5RM3/qg5VNMHJ90zZTemXoZYDrFGj0/1IJ8WS26S/lR/n6m18/J0HgaAhllyOuI9fB4dYNZ97LmHIIYYBaku/qAeUkylE5n4Fwm9dnDTxfAQSkQdd9dFnAqT1EA0cvudoXwfpB2daNjpMBcVEjwSS6nMy2dc55h8INMARHJBipnNjdj8/vLuTWy2kPElB5tcI2ozmt11yCvu7JbrPKiVyZ7XwN9PL2a00MlRw2fFthqTBFkinBBn2g8NHBgJbinlV+WTG48s99lZ4ClxJoDkAq1/KKTBi0TWiBrt9socShuXcOnLkLPafWbDK2yyvc10pekOdz2RULcvG0gUOIMjv0O7wNA7LsmTQ+gUcoi3d7qTRBSXCPEFzZfxwUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(786003)(478600001)(966005)(26005)(316002)(6916009)(186003)(66476007)(7696005)(4326008)(16526019)(8936002)(66946007)(66556008)(8676002)(5660300002)(52116002)(36756003)(54906003)(2906002)(86362001)(83380400001)(6666004)(2616005)(956004)(6486002)(75432002)(1076003)(30864003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Am/CZQTrDdUa1fWAXX2YNzfge15Ke71v+tGV6/6r9C+q9idUDxdZKbOfg9+k3ub13dh279qyh4bFwJzFJyG6M2fmDkmckPTxUe1ixG/5AMvnVQBSXB3BsYUMcjTY8PEUfKuFLhs5RGD1SevuRyQq50Ag8tFkOtheW5ECvCvWAfx5klHe79k8htBFs+qMXUZu4M72eHVQ4FBTOkzPAgAwgSC5flDisxc9u6UvugC1zr+tSnIhsRegrofuSwNGXroxCH94XyRIoX5NLxFSzgPPqj/BMmv9IXLmdn2q3GIlJiH+LLbYTx2BWcYh57rt3Vh1y279A1aZwoCyhdZeRCaJG/a/Tn5897Uaml9bHItUCKUMRJenflTWD6bjjdKXuIJd4wTb15NcY31QLt+dVM7/TOsregEMtTA4jqisR9kb9Y5dBMwS0FpKIaMhm/HzNdfSiwUwwK2FRq/HqL5rzxhCw47PgOOj9AAD9e9iHhOemgo=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b736d-7e03-4058-6dd0-08d80dcc4609
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 05:57:07.4346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTVIxB0QcQ9uowH9ApPEaEyDT2sLTFk/3YY/PPbIx2HLX0zS5OcScajiuE8O/nEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4173
Received-SPF: pass client-ip=40.107.223.121; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 01:57:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/Makefile.include |   1 +
 tests/qtest/fuzz/general_fuzz.c   | 454 ++++++++++++++++++++++++++++++
 2 files changed, 455 insertions(+)
 create mode 100644 tests/qtest/fuzz/general_fuzz.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
index f259d866c9..60f1a448ea 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -10,6 +10,7 @@ fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
 fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
 fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
 fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
+fuzz-obj-y += tests/qtest/fuzz/general_fuzz.o
 
 FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 
diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
new file mode 100644
index 0000000000..5c29306bb6
--- /dev/null
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -0,0 +1,454 @@
+/*
+ * General Fuzzing Target
+ *
+ * Copyright Red Hat Inc., 2020
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/virtio-net.h"
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+#include "libqos/pci-pc.h"
+#include "string.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-core.h"
+#include "hw/pci/pci_regs.h"
+#include "hw/boards.h"
+
+/*
+ * CMD_SEP is a random 32-bit value used to separate "commands" in the fuzz
+ * input
+ */
+#define CMD_SEP "\x84\x05\x5C\x5E"
+
+typedef struct {
+    size_t addr;
+    size_t len; /* The number of bytes until the end of the I/O region */
+} address_range;
+
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
+/*
+ * Only fuzz an IO region if its name contains a word in region_whitelist.
+ * Lazy way to limit the fuzzer to a particular device.
+ */
+char **region_whitelist;
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
+
+/*
+ * Here we want to convert a fuzzer-provided [io-region-index, offset] to
+ * a physical address.
+ */
+static address_range get_io_address(MemoryRegion *io,  uint8_t index,
+                                    uint16_t offset, bool root) {
+    /* The index of the candidate MemoryRegions iterated in preorder */
+    static int i;
+    MemoryRegion *child, *mr = NULL;
+    /*
+     * This loop should run at most twice:
+     * 1.) if index > num regions, to calculate num regions to calculate index
+     * % num_regions.
+     * 2.) to actually select the mr.
+     */
+    while (!mr) {
+        /* If we are recursing over a subregion, don't reset i */
+        if (root) {
+            i = 0;
+        }
+        QTAILQ_FOREACH(child, &io->subregions, subregions_link) {
+            int found = *region_whitelist ? 0 : 1;
+            char **wl_ptr = region_whitelist;
+            while (*wl_ptr != NULL) {
+                if (strstr(child->name, *wl_ptr) != NULL) {
+                    found = 1;
+                    break;
+                }
+                wl_ptr++;
+            }
+            if (found) {
+                if (index == i++) {
+                    mr = child;
+                    break;
+                }
+            }
+            address_range addr = get_io_address(child, index, offset, false);
+            if (addr.addr != -1) {
+                return (address_range){child->addr + addr.addr, addr.len};
+            }
+        }
+        if (!mr) {
+            if (i == 0 || !root) {
+                return (address_range){-1, 0};
+            }
+            index = index % i;
+        }
+    }
+    if (mr->size == 0) {
+        return (address_range){mr->addr, 0};
+    } else {
+        return (address_range){mr->addr + (offset % mr->size),
+                               mr->size - (offset % mr->size)};
+    }
+}
+
+static address_range get_pio_address(uint8_t index, uint16_t offset)
+{
+    return get_io_address(get_system_io(), index, offset, true);
+}
+static address_range get_mmio_address(uint8_t index, uint16_t offset)
+{
+    return get_io_address(get_system_memory(), index, offset, true);
+}
+
+static void op_in(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint16_t offset;
+    } a;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+
+    size_t addr = get_pio_address(a.base, a.offset).addr;
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_inb(s, addr);
+        break;
+    case Word:
+        qtest_inw(s, addr);
+        break;
+    case Long:
+        qtest_inl(s, addr);
+        break;
+    }
+}
+
+static void op_out(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint16_t offset;
+        uint32_t value;
+    } a;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+
+    size_t addr = get_pio_address(a.base, a.offset).addr;
+    if (addr == -1) {
+        return;
+    }
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_outb(s, addr, a.value & 0xFF);
+        break;
+    case Word:
+        qtest_outw(s, addr, a.value & 0xFFFF);
+        break;
+    case Long:
+        qtest_outl(s, addr, a.value);
+        break;
+    }
+}
+
+static void op_read(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, Quad, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint16_t offset;
+    } a;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+
+    size_t addr = get_mmio_address(a.base, a.offset).addr;
+    if (addr == -1) {
+        return;
+    }
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_readb(s, addr);
+        break;
+    case Word:
+        qtest_readw(s, addr);
+        break;
+    case Long:
+        qtest_readl(s, addr);
+        break;
+    case Quad:
+        qtest_readq(s, addr);
+        break;
+    }
+}
+
+static void op_write(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, Quad, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint16_t offset;
+        uint64_t value;
+    } a;
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    size_t addr = get_mmio_address(a.base, a.offset).addr;
+    if (addr == -1) {
+        return;
+    }
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_writeb(s, addr, a.value & 0xFF);
+        break;
+    case Word:
+        qtest_writew(s, addr, a.value & 0xFFFF);
+        break;
+    case Long:
+        qtest_writel(s, addr, a.value & 0xFFFFFFFF);
+        break;
+    case Quad:
+        qtest_writeq(s, addr, a.value);
+        break;
+    }
+}
+
+
+static void op_write_pattern(QTestState *s, const unsigned char * data,
+                             size_t len)
+{
+    struct {
+        uint8_t base;
+        uint32_t offset;
+        uint16_t length;
+        uint8_t index;
+        uint8_t stride;
+    } a;
+
+    /*  Need at least one byte for the actual pattern */
+    if (len < sizeof(a) + 1) {
+        return;
+    }
+
+    memcpy(&a, data, sizeof(a));
+    pattern p = {
+        .data = data + sizeof(a),
+        .len = len - sizeof(a),
+        .index = a.index,
+        .stride = a.stride
+    };
+
+    address_range addr = get_mmio_address(a.base, a.offset);
+    if (addr.addr == -1) {
+        return;
+    }
+    /* Cap the length and make sure it doesn't extend past the IO region. */
+    size_t write_length = MIN(MIN(0x1000, a.length), addr.len);
+
+    void *buf = pattern_alloc(p, write_length);
+    qtest_memwrite(s, addr.addr, buf, write_length);
+    free(buf);
+}
+
+static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
+{
+    qtest_clock_step_next(s);
+}
+
+/*
+ * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
+ * Our commands are variable-width, so we use a separator, CMD_SEP, to specify
+ * the boundaries between commands. This is just a random 32-bit value, which
+ * is easily identified by libfuzzer+AddressSanitizer, as long as we use
+ * memmem. It can also be included in the fuzzer's dictionary. More details
+ * here:
+ * https://github.com/google/fuzzing/blob/master/docs/split-inputs.md
+ *
+ * As a result, the stream of bytes is converted into a sequence of commands.
+ * In a simplified example where CMD_SEP is 0xFF:
+ * 00 01 02 FF 03 04 05 06 FF 01 FF ...
+ * becomes this sequence of commands:
+ * 00 01 02    -> op00 (0102)   -> in (0102, 2)
+ * 03 04 05 06 -> op03 (040506) -> write (040506, 3)
+ * 01          -> op01 (-,0)    -> out (-,0)
+ * ...
+ *
+ * Note here that it is the job of the individual opcode functions to check
+ * that enough data was provided. I.e. in the last command out (,0), out needs
+ * to check that there is not enough data provided to select an address/value
+ * for the operation.
+ */
+static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
+{
+    void (*ops[]) (QTestState* s, const unsigned char* , size_t) = {
+        op_in,
+        op_out,
+        op_read,
+        op_write,
+        op_write_pattern,
+        op_clock_step
+    };
+    const unsigned char *cmd = Data;
+    const unsigned char *nextcmd;
+    size_t cmd_len;
+    uint8_t op;
+
+    if (fork() == 0) {
+        while (cmd && Size) {
+            /* Get the length until the next command or end of input */
+            nextcmd = memmem(cmd, Size, CMD_SEP, strlen(CMD_SEP));
+            cmd_len = nextcmd ? nextcmd - cmd : Size;
+
+            if (cmd_len > 0) {
+                /* Interpret the first byte of the command as an opcode */
+                op = *cmd % (sizeof(ops) / sizeof((ops)[0]));
+                ops[op](s, cmd + 1, cmd_len - 1);
+
+                /* Run the main loop */
+                flush_events(s);
+            }
+            /* Advance to the next command */
+            cmd = nextcmd ? nextcmd + sizeof(CMD_SEP) - 1 : nextcmd;
+            Size = Size - (cmd_len + sizeof(CMD_SEP) - 1);
+        }
+        flush_events(s);
+        _Exit(0);
+    } else {
+        flush_events(s);
+        wait(NULL);
+    }
+}
+
+/*
+ * Adapted from tests/qtest/libqos/pci.c
+ */
+static void pcidev_foreach_callback(QPCIDevice *dev, int devfn, void *data)
+{
+    static const int bar_reg_map[] = {
+        PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
+        PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
+    };
+    int bar_reg;
+    uint32_t addr;
+    uint32_t io_type;
+
+    for (int i = 0; i < 6; i++) {
+        bar_reg = bar_reg_map[i];
+        qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
+        addr = qpci_config_readl(dev, bar_reg);
+
+        io_type = addr & PCI_BASE_ADDRESS_SPACE;
+        if (io_type == PCI_BASE_ADDRESS_SPACE_IO) {
+            addr &= PCI_BASE_ADDRESS_IO_MASK;
+        } else {
+            addr &= PCI_BASE_ADDRESS_MEM_MASK;
+        }
+        if (addr) {
+            qpci_iomap(dev, i, NULL);
+        }
+    }
+
+    qpci_device_enable(dev);
+    if (qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0)) {
+        qpci_msix_enable(dev);
+    }
+}
+
+
+static void general_pre_qos_fuzz(QTestState *s)
+{
+    if (getenv("FUZZ_REGION_WHITELIST")) {
+        region_whitelist = g_strsplit(getenv("FUZZ_REGION_WHITELIST"), " ", 0);
+    }
+    counter_shm_init();
+
+
+    qos_init_path(s);
+
+    /* Enumerate PCI devices and map BARs */
+    qpci_device_foreach(fuzz_qos_obj, -1, -1, pcidev_foreach_callback, NULL);
+}
+
+
+static void *qos_general_cmdline(GString *cmd_line, void *arg)
+{
+    if (!getenv("QEMU_FUZZ_ARGS")) {
+        printf("Please specify qemu args for fuzzing with the QEMU_FUZZ_ARGS"
+               " environment variable. "
+               " (e.g. QEMU_FUZZ_ARGS='-device virtio-net')\n");
+        exit(0);
+    }
+    g_string_append_printf(cmd_line, " %s ", getenv("QEMU_FUZZ_ARGS"));
+    return arg;
+}
+
+static void register_general_fuzz_targets(void)
+{
+    fuzz_add_qos_target(&(FuzzTarget){
+            .name = "general-pci-enum-fuzz",
+            .description = "Fuzz based on any qemu command-line args. "
+                           "Try to map all PCI Device BARs. prior to fuzzing",
+            .pre_fuzz = &general_pre_qos_fuzz,
+            .fuzz = general_fuzz},
+            "pci-bus",
+            &(QOSGraphTestOptions){.before = qos_general_cmdline}
+            );
+}
+
+fuzz_target_init(register_general_fuzz_targets);
-- 
2.26.2


