Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B770C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055D320797
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="sfjaWuaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055D320797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2ds-0002Zz-SB
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2c2-0000tT-Cf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:22 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2c0-0004s9-Ps
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA8oNqAOPoAEvwL6PNkK03zKyPbvCMBUBCypRbX8W+SvGIZmnLYEkK68x0fvzyL7tpd3tXd33xjSM7Pzqcwz97miPhc7/ecObRfs+iwKM2Oy6QzGzBzBuLJ4BcohtfJmcZRRkCSpt12N13bN/ZSKJusIL2oS2ugpSkgH8BrpJD0HQvlpWDZ+H+1pl/PsonXDBYAE5C0jdCNzXqjhKKt2IXTndOaPQVEyYKYD1NfIkt5XeXRtaVFVtZxekS9r+EZ8HQPVu2dsHAqArnoszg6VmosI2Z8VLfi/7Hx5SXKyvrLK+cXG+sPr6H1MV4+fBrkW5d+CmY2wAe0d/hG9mY0aMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0oLyi3kpXguVgquDNXEHfgQwNaQJLCT6XK0weT4Oy0=;
 b=TBpBNJmulM9h1al2RiC6uv08cvo41L+k9agCaunpGU97bw7knaHRmJRaxwy4EUjtC/5NYiMgtP5OAeVIFUHsoew28hdSUfWiXZTf41l2HO/Qtl4ELG+f26IBoAMCeH5AW7vraz9EvesU0E2h9JGLapsNoVohaortnWDKNOXTkSEGSae/ZP5g5ykL0Ov9wWvWhm8cUznXLORNgbfYI+D6BVrVtgKDq0K2OKhn/6yv9OYfsZ0M8O3JhaRKfW6zArUrHKbvJBUtSTrGpnpLe3duP9HAKSDcfMSAUdBbRrpBryd0ZNGnKI4S4iPp5YHRyBNOSmcbt6N7hDufa2ZJzwahCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0oLyi3kpXguVgquDNXEHfgQwNaQJLCT6XK0weT4Oy0=;
 b=sfjaWuaaJ/hxq7klHiEVs6A6JWy+IfEbTQSIEUW/LKmvDA7J2LEyVF3fgFRBoPsAoSDrGmEzCxMaXDbUwvZ8Cqq2V2X960MwMlREu2Ia6LtsrbIwwxIPym7+AU0dZ43R+8OQns/iPfqs7m/Uv+KAN1Ry6KjqVLMhZmsTrz6caIc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:08 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:08 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/16] fuzz: Add PCI features to the general fuzzer
Date: Tue, 20 Oct 2020 21:07:39 -0400
Message-Id: <20201021010752.973230-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ba5e3c2-82de-4ce7-1c70-08d8755dc550
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB23335AAE6D2BA930DFF57E67BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SqEuf2LPhozvg5dKDmizn7zNFatojUuCSsp82Q8K1yzteYT2gdupWHrIoyVHLMn6sBlpiAqf51ZuY5KaAuaD1Ecn6A4k01ue/mPQWiQQrpfAfaUDNPGWfK23rzb5WRhnf1oEGbsG0iMuuHB9kx6fRkYw0SuZHmRAu46ScxH9HntfPsv4xrUg88Esm7M/9TM/ia08TVsfSB/TziN5mI7XIUaftWy2mq344fBeAufWINvSejUsIjlZZjQNxpIJMW1iWvkFcRBnhdzQR0ud4qZzhU9rlJ2GDBkjScda8G22QR4NvXOJAFSjjRbxesP7M/h8dNEzUQoYE9PXQyTIVZtwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(83380400001)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yeMEfbM04uBm4p8IBGLGINL9n9618EE+S9dy5jHL40t94cWe5SK3vZfUaFSEd20a3+MrDjICFPbsuY7K7/PCJAhfx5gvzONZfwqUKyXPrvvAyMPAb198z6vzZda8tOWHAiktPtFQahSEKgJO1HZFhCh3LxVtGUrrxtJ1mH6YZJFHq1NLc2JrNmrVw/LMCPd2XqXsd16DD9SKKAoJuQyIpilqwgp+B3JIsBnH6VV4HUwajN+Zcj+zq2+BPlaqrhKzYZ8K41x/vRE552DIDsHpUuc3c0Vtq8uK9AS/YKTk2bpI8Ebh+9wTPWDqJRvgIscmDzCtEMA4iqZke0rHw9n4MxLIoz/hvRqcuk9x18JosYuSa1dWJXg3ZPLAin/C3ekBzyquZJkl/Hw5SgP+A+KhgBu9xOWtYqLGpe+IEHj1yQZEwCskTbYFfLD7jqynqVasK3XsdFAj7ZqAHEKIj1QHhi8QAarEg949BtRWsgdPtk4h5LtFUlgLFz2QmDu02vlx8wGE7P/palXfuM5zxn79mhx6y0VQZk8+UyPebA0LurID1QFbegIQhsVQtU+MBIvD0XWAvBBjSx5o3Q39ASkV9e6mgmyAJOdKGODlCbNduibZ+JsOsy42YwZyFkvDM3JwU39uCGanMkVHX0rAG1H1wQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba5e3c2-82de-4ce7-1c70-08d8755dc550
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:08.0182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0ZW41NQeJPRwSBzVNMkWibRKbDKB49kgPoTg3dgtFo9n/tMVKMQqqcRTRebeQf8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.220.130; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:08:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
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

This patch compares TYPE_PCI_DEVICE objects against the user-provided
matching pattern. If there is a match, we use some hacks and leverage
QOS to map each possible BAR for that device. Now fuzzed inputs might be
converted to pci_read/write commands which target specific. This means
that we can fuzz a particular device's PCI configuration space,

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/generic_fuzz.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 50e5022d4a..2ba975aaae 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -24,6 +24,7 @@
 #include "exec/ramblock.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
+#include "hw/pci/pci.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -35,12 +36,17 @@ enum cmds {
     OP_OUT,
     OP_READ,
     OP_WRITE,
+    OP_PCI_READ,
+    OP_PCI_WRITE,
     OP_CLOCK_STEP,
 };
 
 #define DEFAULT_TIMEOUT_US 100000
 #define USEC_IN_SEC 1000000000
 
+#define PCI_HOST_BRIDGE_CFG 0xcf8
+#define PCI_HOST_BRIDGE_DATA 0xcfc
+
 typedef struct {
     ram_addr_t addr;
     ram_addr_t size; /* The number of bytes until the end of the I/O region */
@@ -55,6 +61,7 @@ static bool qtest_log_enabled;
  * user for fuzzing.
  */
 static GHashTable *fuzzable_memoryregions;
+static GPtrArray *fuzzable_pci_devices;
 
 struct get_io_cb_info {
     int index;
@@ -280,6 +287,65 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
         break;
     }
 }
+static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint8_t offset;
+    } a;
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    PCIDevice *dev = g_ptr_array_index(fuzzable_pci_devices,
+                                  a.base % fuzzable_pci_devices->len);
+    int devfn = dev->devfn;
+    qtest_outl(s, PCI_HOST_BRIDGE_CFG, (1U << 31) | (devfn << 8) | a.offset);
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_inb(s, PCI_HOST_BRIDGE_DATA);
+        break;
+    case Word:
+        qtest_inw(s, PCI_HOST_BRIDGE_DATA);
+        break;
+    case Long:
+        qtest_inl(s, PCI_HOST_BRIDGE_DATA);
+        break;
+    }
+}
+
+static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
+{
+    enum Sizes {Byte, Word, Long, end_sizes};
+    struct {
+        uint8_t size;
+        uint8_t base;
+        uint8_t offset;
+        uint32_t value;
+    } a;
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    PCIDevice *dev = g_ptr_array_index(fuzzable_pci_devices,
+                                  a.base % fuzzable_pci_devices->len);
+    int devfn = dev->devfn;
+    qtest_outl(s, PCI_HOST_BRIDGE_CFG, (1U << 31) | (devfn << 8) | a.offset);
+    switch (a.size %= end_sizes) {
+    case Byte:
+        qtest_outb(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFF);
+        break;
+    case Word:
+        qtest_outw(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFFFF);
+        break;
+    case Long:
+        qtest_outl(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFFFFFFFF);
+        break;
+    }
+}
+
 static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
 {
     qtest_clock_step_next(s);
@@ -338,6 +404,8 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_OUT]                = op_out,
         [OP_READ]               = op_read,
         [OP_WRITE]              = op_write,
+        [OP_PCI_READ]           = op_pci_read,
+        [OP_PCI_WRITE]          = op_pci_write,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -428,6 +496,18 @@ static int locate_fuzz_objects(Object *child, void *opaque)
         /* Find and save ptrs to any child MemoryRegions */
         object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
 
+        /*
+         * We matched an object. If its a PCI device, store a pointer to it so
+         * we can map BARs and fuzz its config space.
+         */
+        if (object_dynamic_cast(OBJECT(child), TYPE_PCI_DEVICE)) {
+            /*
+             * Don't want duplicate pointers to the same PCIDevice, so remove
+             * copies of the pointer, before adding it.
+             */
+            g_ptr_array_remove_fast(fuzzable_pci_devices, PCI_DEVICE(child));
+            g_ptr_array_add(fuzzable_pci_devices, PCI_DEVICE(child));
+        }
     } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
         if (g_pattern_match_simple(pattern,
             object_get_canonical_path_component(child))) {
@@ -460,6 +540,7 @@ static void generic_pre_fuzz(QTestState *s)
     }
 
     fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
+    fuzzable_pci_devices   = g_ptr_array_new();
 
     result = g_strsplit(getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
     for (int i = 0; result[i] != NULL; i++) {
-- 
2.28.0


