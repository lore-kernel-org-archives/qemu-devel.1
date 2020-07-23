Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0662BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ACD2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="kpHeeZc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ACD2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS6t-00060A-Tu
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5m-0004GF-Cg
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:22 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5j-0002Ew-Mr
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx32hdXoG7hiPYcof8ecJc4gFHmMGW3lGFi5fKHVPgN/IHgsGaay2lmDCgZzJnAQYAvS3q6QxLu1WxOCgqLYOCvc9Y9YJLB9gadTsJjnHTHjWgKO/cspP+/WqNbi8iPuG6hieDjilgoizvmN0bBVbJLLdDFu3VWc0aO+GlQPiNrqoQ9BBxNgaCSQvlsTfpiCPryf5JDt/5toEbFd6OecJgn8VkhjslNhCAy1upN/ouqENt8q5g5tb4506NUd6Tc9J+XbDN7i9VPGuYtIkUiz+wZUXmbXkKRrbYAUsWkn5uyjr2KCN9xaPQCTCEtg2fxURFIorxJYcjUN4CM5J9TKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXakizW+sornLNmB+bBTn1Y7ufLIn3vnOfH2Ryip1Ts=;
 b=Dj/ku37e5Zp/DDn52cP0LgK243ZynLCU8JlNr0HvL1jHKR7h04bfY6A12swMpOMO336s4T9YqD+T2cg3TrSEX7wS9u5o47QszXdDiQZqDbdY27SPjRJ0RmuX+7OBy61cysmoSwKi5uY/WFktIQmbCB2wiEJYOS3vOEyh51W72efi/xU87atEBW7zWyXLiA6WMN4q1b1b4lzrwHkRcCPauuOtXi05Ij0wYRX1t/XzFClpNx7qcbdTTJc97XKYdg01++aUE41bdnCX3YeBQLgWrTtZTvhFjM8JK0lmbKAUcA7l/XYoJtK/7Bce4pYl4Kba5LmtABc5mW/pEhBBhX/eKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXakizW+sornLNmB+bBTn1Y7ufLIn3vnOfH2Ryip1Ts=;
 b=kpHeeZc7ImmjnHHfeQXQtAQPkmQsB0CWF4dQ2T4dY8na+VUhkkFjlIXZmQzp1Rs9VHGLAVT2HkNgTLjIPACc5Fr9PiH8DfZp/NiTtZs2/WGUx1K+GBAbw7G2w6eW2+BgBplNGYHs8beUnJe4IZmKhRWM8yZ3X+OpdWoPxjQtvWM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:07 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:07 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] fuzz: Add general virtual-device fuzzer
Date: Wed, 22 Jul 2020 23:39:23 -0400
Message-Id: <20200723033933.21883-3-alxndr@bu.edu>
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
 Transport; Thu, 23 Jul 2020 03:40:06 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59240827-dcd6-46c2-74e8-08d82eba17ca
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3982C63BC602DC46A28A5896BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCE2y/pRL1gWoYqz4fXf+ZOK5IuJWdo5EFbeFZcLWPWHGy7PG3dtJAIwOKq9/Pdt4jnwLpC9TUk2OnydQTnuMIrvAIFXXBDPmANiXsqytsHUkHuD89kCoL6or/PBdVpjkC1QtnW467aNmJuEvH1fmcpMUZsld6zJi47rwhTLneWwctQLPoGPqsF3xLUMTwYwx8kzbBhRf0snPT9jACnLfXmB9VUQ5m/gI+INlmId6imQkoj8knoUq6fx6eSHeBkbLAmek+pcEQMkzyL2xLDTaFMpKAdfkFVGvhxa3o078inh/+MhRx6DWTBV2Y+ivwxtxYJ5Xjz9/1yXOHOSWuSLmZ7OO9gt+BmBmhunDyWV5alHP4tJf1LC/kxVRGMsiov37Vf52DozHx15d5RAexAu/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(7416002)(5660300002)(966005)(2616005)(956004)(6666004)(30864003)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t7JdRizLYn4eYnJ4RDoQ0Mb8JfDAsXjrZ9lutwYhd5XPXmgXUuqp7165d4u2rXhL2+lhUcOVfLnnbl5g52hmr6vCm0senrTUt+xAN4yl2sJiMqcvNOQ9m04OPEJJsSpHHwfcRq8tSrCa3zqohR3h3TkEjLY248ryPk3+gzJ9/D3P2IzsugxIoY2rmhjcMXT4WXm/Kdwy/wj1G7k2FKQdVxC6Mrqw4Szn/q6XdrAXYnhqzR0VOItfJGklZiKy19F+MykGPntVmRwK8J+eyAZu1r0znxN02jtx3akEeun7nYMka6UKO4Bep8UxKBB4umnx6ygQbf3aZp0pW4ymTU6gngA3nrk5JfZtGqcyM0cz4sqfE+DYXXUOnrr2du78eYVBiBil1ONw8daGdSoBOyWopgOUa3iyWm5SeMIinMYr8xCbrM1PrrKNICKqPDuUXEshWHzOOmht9H64Yw+nSqF9gjZVRuHNtbPLiZlSe/SZGnA=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 59240827-dcd6-46c2-74e8-08d82eba17ca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:07.4362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut38AmW049PgEIGM2qVRJmX8bIHpxsPED4mLyEw8kwMuebiM5plcuqTXFQnjR3Um
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, dstepanov.src@gmail.com, stefanha@redhat.com,
 andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
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
 tests/qtest/fuzz/general_fuzz.c   | 467 ++++++++++++++++++++++++++++++
 2 files changed, 468 insertions(+)
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
index 0000000000..fd92cc5bdf
--- /dev/null
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -0,0 +1,467 @@
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
+ * CMD_SEP is a random 32-bit value used to separate "commands" in the fuzz
+ * input
+ */
+#define CMD_SEP "\x84\x05\x5C\x5E"
+#define DEFAULT_TIMEOUT_US 100000
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
+                ind--;
+                candidate_regions++;
+                result->addr = abs_addr + (offset % mr->size);
+                result->len = mr->size - (offset % mr->size);
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
+    void (*ops[]) (QTestState *s, const unsigned char* , size_t) = {
+        op_in,
+        op_out,
+        op_read,
+        op_write,
+        op_clock_step,
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
+            sigemptyset(&sact.sa_mask);
+            sact.sa_flags = 0;
+            sact.sa_handler = handle_timeout;
+            sigaction(SIGALRM, &sact, NULL);
+            ualarm(timeout, 0);
+        }
+
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
+        _Exit(0);
+    } else {
+        flush_events(s);
+        wait(NULL);
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
+        printf("Matched Object by Type: %s\n", object_get_typename(child));
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
+    wordexp_t result;
+    wordexp(getenv("QEMU_FUZZ_OBJECTS"), &result, 0);
+    for (int i = 0; i < result.we_wordc; i++) {
+        object_child_foreach_recursive(qdev_get_machine(),
+                                    locate_fuzz_objects,
+                                    result.we_wordv[i]);
+    }
+
+    printf("This process will try to fuzz the following MemoryRegions:\n");
+    for (int i = 0; i < fuzzable_memoryregions->len; i++) {
+        MemoryRegion *mr;
+        mr = g_ptr_array_index(fuzzable_memoryregions, i);
+        printf("  * %s (size %lx)\n",
+               object_get_canonical_path_component(&(mr->parent_obj)),
+               mr->addr);
+    }
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


