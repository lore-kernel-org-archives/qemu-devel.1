Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0BC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BA02063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="OmjkTAti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BA02063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HL8-0005Un-8o
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK5-0003n4-SZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:45 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com
 ([40.107.236.94]:24608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK3-0001Y3-HC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXQ2ELnqCy7Pqf8PEyQ8faptxks75gv9wEBKSYNDDhsMZAn4StbdDt4eYHmcIr5T4fHM3nczPbGS5MhMKFSvMOFaqT+zg6RMDxrnBrz3yOfALp/MKgQJjYyX5q3GHjKFI39wjgjylqo+7u2/OkULASvclAtFQ3Y4lSytffthrusl6clMOXDtwvC4RReyu57JRaChw4AaDqgioLkYdunqNlGsI9WFXTCdsHfYfnXANE2oRfR29Jx7DZjJRyEoKXOuWVZP4AHMDOZBQQgXM1jOsbSwqMuVckKUD6P4cODjU/4ro8GmC56+uR9h/D+luPDbUUL1nGd/j8JinOZj/ykHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWEzcaWFdEVXODDUnm8nt4ca+HlarEt7G5Nj0Axorvo=;
 b=XT3IMe03N+1KGWNrfXJzarg6tWz+l8uTU2ReWqEEdJ+6qY6LE1mtnK/xQbB0RlFmM2LUSAG3bapds4fUaUFYq4RoFwn64XznytA50OvVLAgHvF+nKKwda175z3ULS0rigE+oVwNO5Sb79GgNMzmOI7LcYl6yaSqMUUiYtGZjnhQGC2FIXQSyn7wEYL/wNsz/GT6tetNkECRfaJtYYxUQ0OsgpnVkSNv4pfnMo2PCKSrKTfoWiyu9uGEXV/pJgfy25GsvcQHWJcGzz1YA+K6d8If2Rg35AE5EwRqxYwlof+NuzmHGMcqglD9llYBBc4bhCQW74yFG4CDrw+ux7GpTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWEzcaWFdEVXODDUnm8nt4ca+HlarEt7G5Nj0Axorvo=;
 b=OmjkTAti+739bX668v43ZpvXmB2mh3Ln7bqcRYM5Hm3co5u+MDCKDueN6EYEv1oMLczAcvGritGg6DYMcIX4fmh190JhDl1PtmwJXhDEuHqqbOE7T6SiS1Xtercjwy5rKRBlyMsB9+eVjIn0X1Y0bHHy54PqtvAqiKlbW4CButs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:34 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:33 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] fuzz: Add general virtual-device fuzzer
Date: Wed, 19 Aug 2020 02:10:57 -0400
Message-Id: <20200819061110.1320568-3-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:32 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deaebf47-2418-458a-1a37-08d84406b8d0
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39342B9A74E9EB43CB303D61BA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbzIXGty96IWOxdmw5xinCR3BqWy174sn6oWSJiHjG555DQ8TWNNtite6981ogLEN28QVIe5dsgqWzS8Yjpe7I9JpmXRKMQM0wtJgpDqWZakw7gNPS1waLsuKkyiq55YgmNuh4lcB5kXbY6pxSHXHWmCxFlxrA2m62a9zzpmVo4xmHteAfMfh3PjIziC5uTwEUlYDV/z6A3v/kPfB+f+/qi6xvJwY70VooKas3hsoUZM1lzhV8qCDCYqho6XUfwhjy3cjqYQkV6huwlofw5pvh5ok02cKmkKxAk/S22U3VKdnTBj4HVkA9Oea/awGFJgJWxXgY/CIbTLFILJb/XpUOAmGp7RuQ6dl4L3IiHUOInApCGqlcMQoTwtlPV3NUu7bvuDB3pvvmTrc0zwM2bl4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(30864003)(6666004)(2906002)(6512007)(8936002)(6916009)(83380400001)(6486002)(54906003)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(966005)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Jo8Azom4jPt2D3SN7qQ6JfdTUdX2ai/mWKE2l97CegUeMb2YVlg+U1R2qlzm0IuPeXxK8gxHzEj0xzXP7RCvnIhJghyLMoJYtVch+Q/fk6Ma7lct9Y0zflQ/RQVdmHSeYaHglCjp5Zz39BX1mpgeGZH1YIvwRVrCGy7eQSpok5r7GpSjPVAxhoQnAgGpDEDaD1zqUn+GDwZ1JR2fH6QzOyg0oge/ryW16T5Wkj54OhQEPgKuEncv+l9za9VnfRttjqFLVf/tFGXV7hKx6gjjRQ8imRf2NK4yLuFcAC73IFAocMaR8Y4e5IcvOGV6bIzvGBC+2mfPwUmoi7l4L0sxo/N03sbkWzpMLSOF+/hJ5Oougfd8VCyzMtA2xtK+AePUrvBXeZfXyq9NLRetKi+v4exszx+1x6K5xOO8bav4x0coklBFr4lk5U4ju6Ns/Dit/rG6dQiPgK0lc5AZx7ARu/v72wQ1KBlP2iO+JpNFU0Gv9N58zUE8yV8wCt3PaVe2nF08eCVsiQU9ebbrjb3SwsM/AkMiQ4jxMS9Z9IuIh0SGRPuU8tBFhAYS83lDaGsNZWAL03sp0v6syBasMHcgv6Rh03/e+yE7IJvq5XU37uClw04JA3AIqKObngP3MxEn+Nl9CqA9nxk3lht9RQE3/A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: deaebf47-2418-458a-1a37-08d84406b8d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:33.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzyqXn++HvQx/fZdOZOKdZ7W7MGUAWRiDlmq448yGd+gwTzQdBctCoN2I5hGtlGR
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a generic fuzzer designed to fuzz a virtual device's
MemoryRegions, as long as they exist within the Memory or Port IO (if it
exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
of qtest commands (outb, readw, etc). The interpreted commands are
separated by a magic seaparator, which should be easy for the fuzzer to
guess. Without ASan, the separator can be specified as a "dictionary
value" using the -dict argument (see libFuzzer documentation).

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/Makefile.include |   1 +
 tests/qtest/fuzz/general_fuzz.c   | 494 ++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)
 create mode 100644 tests/qtest/fuzz/general_fuzz.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
index 5bde793bf2..854322efb6 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -11,6 +11,7 @@ fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
 fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
 fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
 fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
+fuzz-obj-y += tests/qtest/fuzz/general_fuzz.o
 
 FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 
diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
new file mode 100644
index 0000000000..01bcb029b1
--- /dev/null
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -0,0 +1,494 @@
+/*
+ * General Virtual-Device Fuzzing Target
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
+#include <wordexp.h>
+
+#include "cpu.h"
+#include "tests/qtest/libqtest.h"
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "exec/address-spaces.h"
+#include "string.h"
+#include "exec/memory.h"
+#include "exec/ramblock.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-core.h"
+
+/*
+ * SEPARATOR is used to separate "operations" in the fuzz input
+ */
+#define SEPARATOR "FUZZ"
+
+enum cmds{
+    OP_IN,
+    OP_OUT,
+    OP_READ,
+    OP_WRITE,
+    OP_CLOCK_STEP,
+};
+
+#define DEFAULT_TIMEOUT_US 100000
+#define USEC_IN_SEC 100000000
+
+typedef struct {
+    size_t addr;
+    size_t len; /* The number of bytes until the end of the I/O region */
+} address_range;
+
+static useconds_t timeout = 100000;
+/*
+ * List of memory regions that are children of QOM objects specified by the
+ * user for fuzzing.
+ */
+static GPtrArray *fuzzable_memoryregions;
+/*
+ * Here we want to convert a fuzzer-provided [io-region-index, offset] to
+ * a physical address. To do this, we iterate over all of the matched
+ * MemoryRegions. Check whether each region exists within the particular io
+ * space. Return the absolute address of the offset within the index'th region
+ * that is a subregion of the io_space and the distance until the end of the
+ * memory region.
+ */
+static bool get_io_address(address_range *result,
+                                    MemoryRegion *io_space,
+                                    uint8_t index,
+                                    uint32_t offset) {
+    MemoryRegion *mr, *root;
+    index = index % fuzzable_memoryregions->len;
+    int candidate_regions = 0;
+    int i = 0;
+    int ind = index;
+    size_t abs_addr;
+    AddressSpace *as = (io_space == get_system_memory()) ? &address_space_memory : &address_space_io;
+
+    while (ind >= 0 && fuzzable_memoryregions->len) {
+        *result = (address_range){0, 0};
+        mr = g_ptr_array_index(fuzzable_memoryregions, i);
+        if (mr->enabled) {
+            abs_addr = mr->addr;
+            for (root = mr; root->container; ) {
+                root = root->container;
+                abs_addr += root->addr;
+            }
+            /*
+             * Only consider the region if it is rooted at the io_space we want
+             */
+            if (root == io_space) {
+                hwaddr xlat, len;
+                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
+                    ind--;
+                    candidate_regions++;
+                    result->addr = abs_addr;
+                    if(mr->size){
+                        result->addr += (offset % mr->size);
+                    }
+                    result->len = mr->size-(result->addr-abs_addr);
+                }
+            }
+        }
+        ++i;
+        /* Loop around */
+        if (i == fuzzable_memoryregions->len) {
+            /* No enabled regions in our io_space? */
+            if (candidate_regions == 0) {
+                break;
+            }
+            i = 0;
+        }
+    }
+    return candidate_regions != 0;
+}
+static bool get_pio_address(address_range *result,
+                                     uint8_t index, uint16_t offset)
+{
+    /*
+     * PIO BARs can be set past the maximum port address (0xFFFF). Thus, result
+     * can contain an addr that extends past the PIO space. When we pass this
+     * address to qtest_in/qtest_out, it is cast to a uint16_t, so we might end
+     * up fuzzing a completely different MemoryRegion/Device. Therefore, check
+     * that the address here is within the PIO space limits.
+     */
+
+    bool success = get_io_address(result, get_system_io(), index, offset);
+    return success && result->addr <= 0xFFFF;
+}
+static bool get_mmio_address(address_range *result,
+                                      uint8_t index, uint32_t offset)
+{
+    return get_io_address(result, get_system_memory(), index, offset);
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
+    address_range abs;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    if (get_pio_address(&abs, a.base, a.offset) == 0) {
+        return;
+    }
+
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_inb(s, abs.addr);
+        break;
+    case Word:
+        if (abs.len >= 2) {
+            qtest_inw(s, abs.addr);
+        }
+        break;
+    case Long:
+        if (abs.len >= 4) {
+            qtest_inl(s, abs.addr);
+        }
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
+    address_range abs;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+
+    if (get_pio_address(&abs, a.base, a.offset) == 0) {
+        return;
+    }
+
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_outb(s, abs.addr, a.value & 0xFF);
+        break;
+    case Word:
+        if (abs.len >= 2) {
+            qtest_outw(s, abs.addr, a.value & 0xFFFF);
+        }
+        break;
+    case Long:
+        if (abs.len >= 4) {
+            qtest_outl(s, abs.addr, a.value);
+        }
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
+        uint32_t offset;
+    } a;
+    address_range abs;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+
+    if (get_mmio_address(&abs, a.base, a.offset) == 0) {
+        return;
+    }
+
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_readb(s, abs.addr);
+        break;
+    case Word:
+        if (abs.len >= 2) {
+            qtest_readw(s, abs.addr);
+        }
+        break;
+    case Long:
+        if (abs.len >= 4) {
+            qtest_readl(s, abs.addr);
+        }
+        break;
+    case Quad:
+        if (abs.len >= 8) {
+            qtest_readq(s, abs.addr);
+        }
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
+        uint32_t offset;
+        uint64_t value;
+    } a;
+    address_range abs;
+
+    if (len < sizeof(a)) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+
+    if (get_mmio_address(&abs, a.base, a.offset) == 0) {
+        return;
+    }
+
+    switch (a.size %= end_sizes) {
+    case Byte:
+            qtest_writeb(s, abs.addr, a.value & 0xFF);
+        break;
+    case Word:
+        if (abs.len >= 2) {
+            qtest_writew(s, abs.addr, a.value & 0xFFFF);
+        }
+        break;
+    case Long:
+        if (abs.len >= 4) {
+            qtest_writel(s, abs.addr, a.value & 0xFFFFFFFF);
+        }
+        break;
+    case Quad:
+        if (abs.len >= 8) {
+            qtest_writeq(s, abs.addr, a.value);
+        }
+        break;
+    }
+}
+static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
+{
+    qtest_clock_step_next(s);
+}
+
+static void handle_timeout(int sig)
+{
+    if (getenv("QTEST_LOG")) {
+        fprintf(stderr, "[Timeout]\n");
+        fflush(stderr);
+    }
+    _Exit(0);
+}
+
+/*
+ * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
+ * Our commands are variable-width, so we use a separator, SEPARATOR, to specify
+ * the boundaries between commands. This is just a random 32-bit value, which
+ * is easily identified by libfuzzer+AddressSanitizer, as long as we use
+ * memmem. It can also be included in the fuzzer's dictionary. More details
+ * here:
+ * https://github.com/google/fuzzing/blob/master/docs/split-inputs.md
+ *
+ * As a result, the stream of bytes is converted into a sequence of commands.
+ * In a simplified example where SEPARATOR is 0xFF:
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
+    void (*ops[]) (QTestState *s, const unsigned char* , size_t) = {
+        [OP_IN]                 = op_in,
+        [OP_OUT]                = op_out,
+        [OP_READ]               = op_read,
+        [OP_WRITE]              = op_write,
+        [OP_CLOCK_STEP]         = op_clock_step,
+    };
+    const unsigned char *cmd = Data;
+    const unsigned char *nextcmd;
+    size_t cmd_len;
+    uint8_t op;
+
+    if (fork() == 0) {
+        /*
+         * Sometimes the fuzzer will find inputs that take quite a long time to
+         * process. Often times, these inputs do not result in new coverage.
+         * Even if these inputs might be interesting, they can slow down the
+         * fuzzer, overall. Set a timeout to avoid hurting performance, too much
+         */
+        if (timeout) {
+            struct sigaction sact;
+            struct itimerval timer;
+
+            sigemptyset(&sact.sa_mask);
+            sact.sa_flags   = SA_NODEFER;
+            sact.sa_handler = handle_timeout;
+            sigaction(SIGALRM, &sact, NULL);
+
+            memset(&timer, 0, sizeof(timer));
+            timer.it_value.tv_sec = timeout / USEC_IN_SEC;
+            timer.it_value.tv_usec = timeout % USEC_IN_SEC;
+            setitimer(ITIMER_VIRTUAL, &timer, NULL);
+        }
+
+        while (cmd && Size) {
+            /* Get the length until the next command or end of input */
+            nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
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
+            cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
+            Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
+        }
+        _Exit(0);
+    } else {
+        flush_events(s);
+        wait(0);
+    }
+}
+
+static void usage(void)
+{
+    printf("Please specify the following environment variables:\n");
+    printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
+    printf("QEMU_FUZZ_OBJECTS= "
+            "a space separated list of QOM type names for objects to fuzz\n");
+    printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
+            "0 to disable. %d by default\n", timeout);
+    exit(0);
+}
+
+static int locate_fuzz_memory_regions(Object *child, void *opaque)
+{
+    const char *name;
+    MemoryRegion *mr;
+    if (object_dynamic_cast(child, TYPE_MEMORY_REGION)) {
+        mr = MEMORY_REGION(child);
+        if ((memory_region_is_ram(mr) ||
+            memory_region_is_ram_device(mr) ||
+            memory_region_is_rom(mr) ||
+            memory_region_is_romd(mr)) == false) {
+            name = object_get_canonical_path_component(child);
+            /*
+             * We don't want duplicate pointers to the same MemoryRegion, so
+             * try to remove copies of the pointer, before adding it.
+             */
+            g_ptr_array_remove_fast(fuzzable_memoryregions, mr);
+            g_ptr_array_add(fuzzable_memoryregions, mr);
+        }
+    }
+    return 0;
+}
+static int locate_fuzz_objects(Object *child, void *opaque)
+{
+    char *pattern = opaque;
+    if (g_pattern_match_simple(pattern, object_get_typename(child))) {
+        /* Find and save ptrs to any child MemoryRegions */
+        object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
+    } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
+        if (g_pattern_match_simple(pattern,
+            object_get_canonical_path_component(child))) {
+            MemoryRegion *mr;
+            mr = MEMORY_REGION(child);
+            if ((memory_region_is_ram(mr) ||
+                 memory_region_is_ram_device(mr) ||
+                 memory_region_is_rom(mr) ||
+                 memory_region_is_romd(mr)) == false) {
+                g_ptr_array_remove_fast(fuzzable_memoryregions, mr);
+                g_ptr_array_add(fuzzable_memoryregions, mr);
+            }
+        }
+    }
+    return 0;
+}
+
+static void general_pre_fuzz(QTestState *s)
+{
+    if (!getenv("QEMU_FUZZ_OBJECTS")) {
+        usage();
+    }
+    if (getenv("QEMU_FUZZ_TIMEOUT")) {
+        timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
+    }
+
+    fuzzable_memoryregions = g_ptr_array_new();
+    char **result = g_strsplit (getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
+    for (int i = 0; result[i] != NULL; i++) {
+        printf("Matching objects by name %s\n", result[i]);
+        object_child_foreach_recursive(qdev_get_machine(),
+                                    locate_fuzz_objects,
+                                    result[i]);
+    }
+    g_strfreev(result);
+    printf("This process will try to fuzz the following MemoryRegions:\n");
+    for (int i = 0; i < fuzzable_memoryregions->len; i++) {
+        MemoryRegion *mr;
+        mr = g_ptr_array_index(fuzzable_memoryregions, i);
+        printf("  * %s (size %lx)\n",
+               object_get_canonical_path_component(&(mr->parent_obj)),
+               mr->addr);
+    }
+
+    if(!fuzzable_memoryregions->len){
+        printf("No fuzzable memory regions found...\n");
+        exit(0);
+    }
+
+    counter_shm_init();
+}
+static GString *general_fuzz_cmdline(FuzzTarget *t)
+{
+    GString *cmd_line = g_string_new(TARGET_NAME);
+    if (!getenv("QEMU_FUZZ_ARGS")) {
+        usage();
+    }
+    g_string_append_printf(cmd_line, " -display none \
+                                      -machine accel=qtest, \
+                                      -m 64 %s ", getenv("QEMU_FUZZ_ARGS"));
+    return cmd_line;
+}
+
+static void register_general_fuzz_targets(void)
+{
+    fuzz_add_target(&(FuzzTarget){
+            .name = "general-fuzz",
+            .description = "Fuzz based on any qemu command-line args. ",
+            .get_init_cmdline = general_fuzz_cmdline,
+            .pre_fuzz = general_pre_fuzz,
+            .fuzz = general_fuzz});
+}
+
+fuzz_target_init(register_general_fuzz_targets);
-- 
2.27.0


