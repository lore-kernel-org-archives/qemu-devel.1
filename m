Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E5C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5D720825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fq8Wx194"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5D720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS8d-00010o-9Y
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5o-0004Ii-G7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:24 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5m-0002Ew-Ns
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtgxkIZBM/Hz3YP1hAYBW4lirpU3TXSJJxI3dFj/EfYzEjIThvKUDE2eq0+Qhu89FZwkwDA0V1nnTHHmdEaCe+a/OlkfHiVB2kynQRMrOdM59MrcRmHLBpEa7DsrwOWVt4UKrDOv1aF36BwslGeci0ue73raCk/Y5Gw9gljcuD0znXRR2uq52RuM3Y78ybHaqORYAyzlnORakCD9V8falliJagZI06A0chU8GI53vfXz2WWu+DLQ6cLH6178FJ1Z8fJ6iP0K1j4y9j5aSPqojOmyPGFVR+QPimDwYR4SURDWwfc6BPUidpeXai6csmWhwaF83U3sS13YUBEUjlDeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZOTz3AAf3FLj5AlwlbwdTpcY8aZhcGZSfE6XqSu3bw=;
 b=BxHya4V/46AD2wFv/ZM3iXlakT8GgZ62/+9FLc11S0XKpbTqAP0QAQH8hkCHBbJkIdqt2LIZuXs9LpP6sz+ZiWimMTR/hRoOuXHcrT/oCx/nHbygurVttCYFI+viGgIPgVPV15htaMll2FbO/yVNN5jQZrUzDcAhk8+s0aHfQdHJX3KQQF0c4i3J4jUuwXgPBzlDweznd0bJKyjzVHoPdcmzaplpRWt4A+vnPuhJd2jI3N1tDUsu51nSwQnBLosdG+WJM8fCOCUo/w3IV6ei8ZWW+gKHA2HnRLByGJWOva27c4adRqEYzvaUtixkraAPDry4iqC8SZaxkA0U27H3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZOTz3AAf3FLj5AlwlbwdTpcY8aZhcGZSfE6XqSu3bw=;
 b=fq8Wx1947OQwV6hIc1iJK/cA6OKcIEF3Rt2/Xppz2dYWjR7QLv0strMzroCQ121pTeIjWp8I7kkzwQe1ArSNrVtlzQ+s6/y6aNs3BYXTl6nJ5zJYQNWW2AgmctzgIZXoLQjtYOUQ5Iri2B1v2JHN+z41O/Fvk47m7lblJ8DykEM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:09 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:09 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/12] fuzz: Add PCI features to the general fuzzer
Date: Wed, 22 Jul 2020 23:39:24 -0400
Message-Id: <20200723033933.21883-4-alxndr@bu.edu>
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
 Transport; Thu, 23 Jul 2020 03:40:08 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae99cc70-a8b3-49b1-8d91-08d82eba18df
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB398242AE13D90FCD0B0E6CACBA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGjZBHRWgFXO1EJ5JuyRvEqTIwjxpLhh0EWT3aqHyoCaWFu4BqfPvW7DnC0Ixie/LtXqjGbln4sirEXDpd5/1P+v6PcmF91MQeDujvV4VIOjeKebDeUbtdt1DeAzb+f+W8IEhMYw2pO2h0/2NhMTE6ACukiw/tINk+c1guQgYXIWfCMh5mNJCcQsrlL6MTxrEFEVQaK1ltyLk3C2LF8oVlAdd3sWH9XV972OVrXghn13Sxwo0yJzDaUjtbIRXy+f8KeLvLUW7j4RVvAtXJPc6DtvQ1tTGzkqkO4WizkoaITmH54PofjShf8xAFHWQQ2VXvLhas4UzefXsu/uxYVs3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(7416002)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ft2i+3Zfjk5THIbfeY2ZYOou62Yoxz5nhUbnUu0ZN+d//XiJ5ESD68CcXjdty++H3ejbmiIjjQKBqtyWpGxHjTRMqW3cAovCPLPBXdjnC8mBEsvHa0ax3/BZADvf/Yj65Pdn2/Eb7ur7jkFaL3qpTwnUKU6kbafraPDr1t+GKITcYZfq/JwfmqHZdntfH3K/fHzAlWo5OKb+5f1/lDax0Ztg5rd8et7FIy+rUExEEcNy/YXh7qFvAXSyMSXnpKNyg0cEslcbvqD8Rrd2sEPyY3hyIj2qP625M/OVRsPGL99eAPeg2DMZOrQ5nm/OYPe/y/6yllfXVmdHuD4uIYEm/QFDnd/0IFUXL/8Q0y7vATW2KtUkTkUWIVayekb8uAM8FGFV0tbOCl///+TNjnVdnCCYSlvdwRiCiGHF3Z1II/F91eVYSIFHDNedxO6zW2L5BfKE37uPXTolzFA6JAWb1JcWAQDoQRg8HiYZSQNl6qM=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae99cc70-a8b3-49b1-8d91-08d82eba18df
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:09.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnN5xKbtnF2Hxz3r5LyU97XYnEJPGVs8wHQz0D/MAW7wsVxGGRimvdxIlcTCcJr+
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

This patch compares TYPE_PCI_DEVICE objects against the user-provided
matching pattern. If there is a match, we use some hacks and leverage
QOS to map each possible BAR for that device. Now fuzzed inputs might be
converted to pci_read/write commands which target specific. This means
that we can fuzz a particular device's PCI configuration space,

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 114 ++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index fd92cc5bdf..e715b77d59 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -24,6 +24,9 @@
 #include "exec/ramblock.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
+#include "tests/qtest/libqos/pci.h"
+#include "tests/qtest/libqos/pci-pc.h"
+#include "hw/pci/pci.h"
 
 /*
  * CMD_SEP is a random 32-bit value used to separate "commands" in the fuzz
@@ -32,6 +35,9 @@
 #define CMD_SEP "\x84\x05\x5C\x5E"
 #define DEFAULT_TIMEOUT_US 100000
 
+#define PCI_HOST_BRIDGE_CFG 0xcf8
+#define PCI_HOST_BRIDGE_DATA 0xcfc
+
 typedef struct {
     size_t addr;
     size_t len; /* The number of bytes until the end of the I/O region */
@@ -43,6 +49,8 @@ static useconds_t timeout = 100000;
  * user for fuzzing.
  */
 static GPtrArray *fuzzable_memoryregions;
+static GPtrArray *fuzzable_pci_devices;
+
 /*
  * Here we want to convert a fuzzer-provided [io-region-index, offset] to
  * a physical address. To do this, we iterate over all of the matched
@@ -267,6 +275,65 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
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
@@ -311,6 +378,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         op_out,
         op_read,
         op_write,
+        op_pci_read,
+        op_pci_write,
         op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -397,6 +466,19 @@ static int locate_fuzz_objects(Object *child, void *opaque)
         printf("Matched Object by Type: %s\n", object_get_typename(child));
         /* Find and save ptrs to any child MemoryRegions */
         object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
+
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
@@ -416,6 +498,7 @@ static int locate_fuzz_objects(Object *child, void *opaque)
 
 static void general_pre_fuzz(QTestState *s)
 {
+    QPCIBus *qpci_bus;
     if (!getenv("QEMU_FUZZ_OBJECTS")) {
         usage();
     }
@@ -424,6 +507,7 @@ static void general_pre_fuzz(QTestState *s)
     }
 
     fuzzable_memoryregions = g_ptr_array_new();
+    fuzzable_pci_devices = g_ptr_array_new();
     wordexp_t result;
     wordexp(getenv("QEMU_FUZZ_OBJECTS"), &result, 0);
     for (int i = 0; i < result.we_wordc; i++) {
@@ -440,6 +524,36 @@ static void general_pre_fuzz(QTestState *s)
                object_get_canonical_path_component(&(mr->parent_obj)),
                mr->addr);
     }
+
+#ifdef TARGET_I386
+    printf("\n.. and the following Devices in the PCI Configuration Space:\n");
+    if (fuzzable_pci_devices->len) {
+        /*
+         * qpci_new_pc can't be used for non x86... What else can we do? Map
+         * BARs, without QOS?
+         */
+        qpci_bus = qpci_new_pc(s, NULL);
+        for (int i = 0; i < fuzzable_pci_devices->len; i++) {
+            PCIDevice *dev;
+            QPCIDevice *qdev;
+            dev = g_ptr_array_index(fuzzable_pci_devices, i);
+            qdev = qpci_device_find(qpci_bus, dev->devfn);
+            for (int j = 0; j < 5; j++) {
+                if (dev->io_regions[j].size) {
+                    qpci_iomap(qdev, j, NULL);
+                }
+            }
+            qpci_device_enable(qdev);
+            g_free(qdev);
+            printf("  * %x:%x device: %x function: %x)\n",
+                    pci_get_word(dev->config + PCI_VENDOR_ID),
+                    pci_get_word(dev->config + PCI_DEVICE_ID),
+                    PCI_SLOT(dev->devfn),
+                    PCI_FUNC(dev->devfn));
+        }
+        qpci_free_pc(qpci_bus);
+    }
+#endif
     counter_shm_init();
 }
 static GString *general_fuzz_cmdline(FuzzTarget *t)
-- 
2.27.0


