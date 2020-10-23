Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA8C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7763E208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="iqTpdMK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7763E208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVylQ-0002jl-Bk
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfu-0003ek-Ke
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:14 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com
 ([40.107.243.109]:44513 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfr-00076m-R6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STyMuTm+KnLVvzsFtpw8X91YGyW18S46Jq7I/IybL7+V7OO0kpw4ZH2ra6BokefmwwTtBYS0F6DHRCDaakN7fyYS9HAWnDoIH+ps6w5J80QAYbfRus7vZylzzaSjEXWoTeDhw5Xuc+XL/O9fGamKdor7Ea6fdnle8avHGgJnH35ISAKxNGKWyrl5nwiPz7/1HmvHqOdBRa/rR01KlhKNL7aFbXJKu/OUcbj/z95x27sy16cfJPEWWT7FoJWZukeRX+7051fPuiH9DUFtpJeVa1p9iqFP8u6KnfzNe5nd39adbJASfFz9pkxs5qgxYzqFu6WiQMn+95uYQL+0O6KKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRz2odmRiiOKvlNw8+AcHFOASG7zRh/PtxYBlK7JyR8=;
 b=GMeQnZae/iKfSSIf12YRfx/EBSdI5A4h3MeRZOSbNLaZ/9JysK2iTqf7WLtiPcDf57NFG0WTuw5Vil9dG98Giti3SuM3Zb8IWOE0i+VWtH3syh7oAEyj1uIwHBhVsOAvT+Au2sM6+B3X0a05d4Q7u1JwVXCsC5ZRJcxYnD132HoPLf2Phn2ItaVVxI+7glorsfSh8XY7lx4WyvT3PaQwk5FTRF4Qgc3N64KP4qo3HFZF6f8TElHwrwVn3s/ZgkNqyC8AM/ms816gyraY4ixBzdsoJf3n7bPkVYh5tMhOeOo5cbCLwasyuD5npCGgnpB2rIPepzJea+P7uKSQZJmdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRz2odmRiiOKvlNw8+AcHFOASG7zRh/PtxYBlK7JyR8=;
 b=iqTpdMK9NNHex1+Ars3ZZJg7rTI+vUYk8lmJpo6JGNJUJhK+PCCGHrPCjiC0eEPhFF221cgZ91b756oFtYgZ6gbUnccoLRkahjvU9l6fcZBHZAqWI9zzIxNUupf1v1kbUBburL4S1yJDQLUEK1rsVaYuon4cTDli9SRJUkD9h+I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 15:08:00 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:00 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/17] fuzz: Add generic virtual-device fuzzer
Date: Fri, 23 Oct 2020 11:07:31 -0400
Message-Id: <20201023150746.107063-3-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:07:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026868ad-3a90-4907-802a-08d877656eb0
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4368370FA3C501C51632BFFEBA1A0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v51Dr+4vuunQzMKbzkj+NqW/D7x76p0iO8wKZUrsQfUkoMeCpF4b1k9hSL0oD0NxsJ0ZI890HIS/Wwt6hKXzpeKTOxZJKG9t5WqBOJc32aV/fPuNBD0tykmH6CKiou3QT73TLwrNOAxsmdjbNLwhBDy6TgcZd2X9kaBMkSBcAwTwHk99OFNUMKHGXoV77+98kcoCnIBERUCsJIqsxhl7B4/TaRvKlAdJ8lY4bp24JmLHLqTIH9PCg492PlhvondOqigaWl+yyA2bJiCarcpYkI4pSAAxZhoBdMsreITZcQQHDJcJ3F10e930+c8Piy/AilI3JHMw2DWN33rIwLS4BmuT6YY17Cs+zoeRpR8dCc5p/AkrAJaCx3Tie3F1EZZp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(478600001)(956004)(8676002)(1076003)(186003)(26005)(316002)(6486002)(16526019)(8936002)(83380400001)(75432002)(6506007)(786003)(6916009)(86362001)(66946007)(66556008)(66476007)(6666004)(30864003)(2616005)(36756003)(52116002)(5660300002)(54906003)(6512007)(4326008)(2906002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v2coaHzO2YLIHQIMXt5XtoN5uDIix9X9eG2EpMFOTXm4frqSLeWfJBCKP3fTd3gv91mdejvAETzpYi7Hq7H0uMyDUT51xKgZjWyWb+gLBcYmvxdP2uzl53VC1Re3PVSZvJ2/2eBEYVsHtreYjdZ7oMJH/zfgV1LdsHXZRT67EBX3ONUvVWYO/41nAQd1i8x43r/Gfkjd0hVbbuqlZU6W4tmYNJA/MyHZ6eAIhwyf4DJx+w+c+vPCf+XWIL03qKlwaAkbMNleN0q0uYKu4ABwygAhSlvQkqYhjdRDeXBE8BCxqFYI43aa57vk/fBtGlkdxsWOqawYMbC7gxoTageXIkT5B/bayqn0gN6qX3dRpy+UnB/JRyYSiQ9vGAYB/NwrweOiXrTVXWDcK7UqC2KHqEiG7R8gVZBd39FE3BLkon8dSthlWrXe4Lz8CVDXdgLwFqH5IQSlUXo4rZuCHP1pZdWlDwUfXR59wKKwHNfUgLb5T2YJrmS/RBmSE8ob0sKqS5EPOXWiiB8P0srki8liEqNsDLOgwjwhz1OApPeFA3RXWL0fT/i1zMW+cqkLxYwJsmkBRbx/ka6aztzcRQOioVvpNcHyklY0R8Fd/cdcJtFH2IWcvzD2HqacxPdJZTG+D41HhDjNNFcxrkQlG+GSig==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 026868ad-3a90-4907-802a-08d877656eb0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:00.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVaoZeRCrNN32V95Oe/Guowsfd4f302An3MpzcUIVYlqjn3MYuDXWJbqX/+B6w2u
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

This is a generic fuzzer designed to fuzz a virtual device's
MemoryRegions, as long as they exist within the Memory or Port IO (if it
exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
of qtest commands (outb, readw, etc). The interpreted commands are
separated by a magic seaparator, which should be easy for the fuzzer to
guess. Without ASan, the separator can be specified as a "dictionary
value" using the -dict argument (see libFuzzer documentation).

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 516 ++++++++++++++++++++++++++++++++
 tests/qtest/fuzz/meson.build    |   1 +
 2 files changed, 517 insertions(+)
 create mode 100644 tests/qtest/fuzz/generic_fuzz.c

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
new file mode 100644
index 0000000000..6e3faf4e92
--- /dev/null
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -0,0 +1,516 @@
+/*
+ * Generic Virtual-Device Fuzzing Target
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
+#include "hw/core/cpu.h"
+#include "tests/qtest/libqos/libqtest.h"
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
+enum cmds {
+    OP_IN,
+    OP_OUT,
+    OP_READ,
+    OP_WRITE,
+    OP_CLOCK_STEP,
+};
+
+#define DEFAULT_TIMEOUT_US 100000
+#define USEC_IN_SEC 1000000000
+
+typedef struct {
+    ram_addr_t addr;
+    ram_addr_t size; /* The number of bytes until the end of the I/O region */
+} address_range;
+
+static useconds_t timeout = DEFAULT_TIMEOUT_US;
+
+static bool qtest_log_enabled;
+
+/*
+ * List of memory regions that are children of QOM objects specified by the
+ * user for fuzzing.
+ */
+static GHashTable *fuzzable_memoryregions;
+
+struct get_io_cb_info {
+    int index;
+    int found;
+    address_range result;
+};
+
+static int get_io_address_cb(Int128 start, Int128 size,
+                          const MemoryRegion *mr, void *opaque) {
+    struct get_io_cb_info *info = opaque;
+    if (g_hash_table_lookup(fuzzable_memoryregions, mr)) {
+        if (info->index == 0) {
+            info->result.addr = (ram_addr_t)start;
+            info->result.size = (ram_addr_t)size;
+            info->found = 1;
+            return 1;
+        }
+        info->index--;
+    }
+    return 0;
+}
+
+/*
+ * Here we want to convert a fuzzer-provided [io-region-index, offset] to
+ * a physical address. To do this, we iterate over all of the matched
+ * MemoryRegions. Check whether each region exists within the particular io
+ * space. Return the absolute address of the offset within the index'th region
+ * that is a subregion of the io_space and the distance until the end of the
+ * memory region.
+ */
+static bool get_io_address(address_range *result, AddressSpace *as,
+                            uint8_t index,
+                            uint32_t offset) {
+    FlatView *view;
+    view = as->current_map;
+    g_assert(view);
+    struct get_io_cb_info cb_info = {};
+
+    cb_info.index = index;
+
+    /*
+     * Loop around the FlatView until we match "index" number of
+     * fuzzable_memoryregions, or until we know that there are no matching
+     * memory_regions.
+     */
+    do {
+        flatview_for_each_range(view, get_io_address_cb , &cb_info);
+    } while (cb_info.index != index && !cb_info.found);
+
+    *result = cb_info.result;
+    return cb_info.found;
+}
+
+static bool get_pio_address(address_range *result,
+                            uint8_t index, uint16_t offset)
+{
+    /*
+     * PIO BARs can be set past the maximum port address (0xFFFF). Thus, result
+     * can contain an addr that extends past the PIO space. When we pass this
+     * address to qtest_in/qtest_out, it is cast to a uint16_t, so we might end
+     * up fuzzing a completely different MemoryRegion/Device. Therefore, check
+     * that the address here is within the PIO space limits.
+     */
+    bool found = get_io_address(result, &address_space_io, index, offset);
+    return result->addr <= 0xFFFF ? found : false;
+}
+
+static bool get_mmio_address(address_range *result,
+                             uint8_t index, uint32_t offset)
+{
+    return get_io_address(result, &address_space_memory, index, offset);
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
+        if (abs.size >= 2) {
+            qtest_inw(s, abs.addr);
+        }
+        break;
+    case Long:
+        if (abs.size >= 4) {
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
+        if (abs.size >= 2) {
+            qtest_outw(s, abs.addr, a.value & 0xFFFF);
+        }
+        break;
+    case Long:
+        if (abs.size >= 4) {
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
+        if (abs.size >= 2) {
+            qtest_readw(s, abs.addr);
+        }
+        break;
+    case Long:
+        if (abs.size >= 4) {
+            qtest_readl(s, abs.addr);
+        }
+        break;
+    case Quad:
+        if (abs.size >= 8) {
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
+        if (abs.size >= 2) {
+            qtest_writew(s, abs.addr, a.value & 0xFFFF);
+        }
+        break;
+    case Long:
+        if (abs.size >= 4) {
+            qtest_writel(s, abs.addr, a.value & 0xFFFFFFFF);
+        }
+        break;
+    case Quad:
+        if (abs.size >= 8) {
+            qtest_writeq(s, abs.addr, a.value);
+        }
+        break;
+    }
+}
+
+static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
+{
+    qtest_clock_step_next(s);
+}
+
+static void handle_timeout(int sig)
+{
+    if (qtest_log_enabled) {
+        fprintf(stderr, "[Timeout]\n");
+        fflush(stderr);
+    }
+    _Exit(0);
+}
+
+/*
+ * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
+ * Some commands can be variable-width, so we use a separator, SEPARATOR, to
+ * specify the boundaries between commands. SEPARATOR is used to separate
+ * "operations" in the fuzz input. Why use a separator, instead of just using
+ * the operations' length to identify operation boundaries?
+ *   1. This is a simple way to support variable-length operations
+ *   2. This adds "stability" to the input.
+ *      For example take the input "AbBcgDefg", where there is no separator and
+ *      Opcodes are capitalized.
+ *      Simply, by removing the first byte, we end up with a very different
+ *      sequence:
+ *      BbcGdefg...
+ *      By adding a separator, we avoid this problem:
+ *      Ab SEP Bcg SEP Defg -> B SEP Bcg SEP Defg
+ *      Since B uses two additional bytes as operands, the first "B" will be
+ *      ignored. The fuzzer actively tries to reduce inputs, so such unused
+ *      bytes are likely to be pruned, eventually.
+ *
+ *  SEPARATOR is trivial for the fuzzer to discover when using ASan. Optionally,
+ *  SEPARATOR can be manually specified as a dictionary value (see libfuzzer's
+ *  -dict), though this should not be necessary.
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
+static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
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
+            memory_region_is_rom(mr)) == false) {
+            name = object_get_canonical_path_component(child);
+            /*
+             * We don't want duplicate pointers to the same MemoryRegion, so
+             * try to remove copies of the pointer, before adding it.
+             */
+            g_hash_table_insert(fuzzable_memoryregions, mr, (gpointer)true);
+        }
+    }
+    return 0;
+}
+
+static int locate_fuzz_objects(Object *child, void *opaque)
+{
+    char *pattern = opaque;
+    if (g_pattern_match_simple(pattern, object_get_typename(child))) {
+        /* Find and save ptrs to any child MemoryRegions */
+        object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
+
+    } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
+        if (g_pattern_match_simple(pattern,
+            object_get_canonical_path_component(child))) {
+            MemoryRegion *mr;
+            mr = MEMORY_REGION(child);
+            if ((memory_region_is_ram(mr) ||
+                 memory_region_is_ram_device(mr) ||
+                 memory_region_is_rom(mr)) == false) {
+                g_hash_table_insert(fuzzable_memoryregions, mr, (gpointer)true);
+            }
+        }
+    }
+    return 0;
+}
+
+static void generic_pre_fuzz(QTestState *s)
+{
+    GHashTableIter iter;
+    MemoryRegion *mr;
+    char **result;
+
+    if (!getenv("QEMU_FUZZ_OBJECTS")) {
+        usage();
+    }
+    if (getenv("QTEST_LOG")) {
+        qtest_log_enabled = 1;
+    }
+    if (getenv("QEMU_FUZZ_TIMEOUT")) {
+        timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
+    }
+
+    fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
+
+    result = g_strsplit(getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
+    for (int i = 0; result[i] != NULL; i++) {
+        printf("Matching objects by name %s\n", result[i]);
+        object_child_foreach_recursive(qdev_get_machine(),
+                                    locate_fuzz_objects,
+                                    result[i]);
+    }
+    g_strfreev(result);
+    printf("This process will try to fuzz the following MemoryRegions:\n");
+
+    g_hash_table_iter_init(&iter, fuzzable_memoryregions);
+    while (g_hash_table_iter_next(&iter, (gpointer)&mr, NULL)) {
+        printf("  * %s (size %lx)\n",
+               object_get_canonical_path_component(&(mr->parent_obj)),
+               (uint64_t)mr->size);
+    }
+
+    if (!g_hash_table_size(fuzzable_memoryregions)) {
+        printf("No fuzzable memory regions found...\n");
+        exit(1);
+    }
+
+    counter_shm_init();
+}
+
+static GString *generic_fuzz_cmdline(FuzzTarget *t)
+{
+    GString *cmd_line = g_string_new(TARGET_NAME);
+    if (!getenv("QEMU_FUZZ_ARGS")) {
+        usage();
+    }
+    g_string_append_printf(cmd_line, " -display none \
+                                      -machine accel=qtest, \
+                                      -m 512M %s ", getenv("QEMU_FUZZ_ARGS"));
+    return cmd_line;
+}
+
+static void register_generic_fuzz_targets(void)
+{
+    fuzz_add_target(&(FuzzTarget){
+            .name = "generic-fuzz",
+            .description = "Fuzz based on any qemu command-line args. ",
+            .get_init_cmdline = generic_fuzz_cmdline,
+            .pre_fuzz = generic_pre_fuzz,
+            .fuzz = generic_fuzz,
+    });
+}
+
+fuzz_target_init(register_generic_fuzz_targets);
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index b31ace7d5a..5162321f30 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -5,6 +5,7 @@ specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
 specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
+specific_fuzz_ss.add(files('generic_fuzz.c'))
 
 fork_fuzz = declare_dependency(
   link_args: config_host['FUZZ_EXE_LDFLAGS'].split() +
-- 
2.28.0


