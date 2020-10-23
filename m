Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B34FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD3F208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Guvz706N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD3F208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVymN-0003xw-Lo
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfw-0003kX-Tq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:16 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com
 ([40.107.243.109]:44513 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfu-00076m-R5
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrFOCgSVAphNQxDD+4vbaO/Zec869mIIpzEJUaZ5w7odu23N/tNXe+qig6TP3pbnA2glo0Z/muOv30/QUJSkVUW4k9kQQb1tvpg3yf+9MFTASYBuhya30yKO4NkZN+KZd6vHQA3ttcOb8eVHBa/+5w5KmzCQU/ky6nHcIMRa1HnD+h6bxrgSC49MFVg46r0zAHvmT0kIj5x0FIykQux9s7kOuE++MtnfG/wkFWIqJsa3L5kqv/Qwkcwih6Uemi2dNvwGFI0/tH4vjHv9d7ZFInwnzEH33I8eBYUZEJ4W64oh/Gc9+oLyH74EamTaHX97XT/fFh/54EpRZUngZqfv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sMX1hNdvlHfr6f5HlrET37EfLP+rqpEgLKJ8/dMnIA=;
 b=AYXgPdWF4Y2F4Ppc5MHGxWpf9GiNiV/TK65I/WZ8W0PL7zoXdhDpkamCTG9NA8ulZpYqOojfts35Opk/IQQ4VUAJ2uB/OuKNBKhCu8NmlVk785i9SsbQPuI8bXxgGy0NtU4+jB1wD+f1RvzCwu3yaPLtieujK2QzSS+6kQZVe4yTQmPj1TZtDX3RIh9Q7AG2JAi5iyUArDJpVT7scd0bORCnPGGcQVOYyNs/VCiHX3FXCgjmqCLs70yhKkad8Ix87d67ay1MhAZRZ+iYMvxRllVg6hfUjv67F70P77t4aL5YHtDhjd2s/M+kPBmuDa/iqy+iB1Icqy4R6nUAzn5Jfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sMX1hNdvlHfr6f5HlrET37EfLP+rqpEgLKJ8/dMnIA=;
 b=Guvz706N1Osk4RCZjKNNur4UgIp4IDc1RHXAjr/YBhWPSzAstiJFqnp0S4bvm0bUdj+Gpe+Vj4bStRgh++ryEmPWYHo+zID1OH/IcjiFaRh7EiytW0aiCCRzwGEWS6FIDE000h2ZZb8gUN3PnTDlNp6B2sleUV8yuNB3Rf6NsHw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 15:08:02 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:02 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/17] fuzz: Add PCI features to the generic fuzzer
Date: Fri, 23 Oct 2020 11:07:32 -0400
Message-Id: <20201023150746.107063-4-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd87bc92-c8f3-4df6-3e92-08d877656f73
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB43683A46E631411BCE92E546BA1A0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RA04KZYdMJkDYlC186ZwDnj9WNJtuIE0SFLQ9KjZq2ZonR/m+FtmxrdGM/5V0CquTJ+dpXoHpDThqaZ8VoF4mr8uhOn3kPazAq/GVIAbQMF73K50pUmedLZ14v9DBHxV7/ok1PJoBcbnQPvEwOfMeko2piXtn22iq0BrNfq2Z9kR4cYdlr9t5mLyVUImE55+x+cIx3ZlbyQkfJJbeHx1ccYgnit6FEFCuJ9QAmapB6XYbGvywhJwrs9LNXRyJun9LDBXQLq/3jNCKdr3EeZ+x/97bRBjhvDcaS4oEZihHLDiW+znurahjRyubpLS/WiyuZGwW+TSW9o3v8+LiHfttvijQ1qZPmaHGnsGYdbP8+qElbevMVMDGKrbUR/Gasi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(478600001)(956004)(8676002)(1076003)(186003)(26005)(316002)(6486002)(16526019)(8936002)(83380400001)(75432002)(6506007)(786003)(6916009)(86362001)(66946007)(66556008)(66476007)(6666004)(2616005)(36756003)(52116002)(5660300002)(54906003)(6512007)(4326008)(2906002)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t2/GFKoWXjPARVXJeIWsO9fA4fiQwTVe6Q722/P0OeZMDZM6pvtbi0+kppZUVUqSUUh/UHp9APvLkiiEzV1RZgsUilfF2I1zLmEPsTijccfz/i6yLEaurdqfKQnbpCXej3loIE06bPFmWRLIn3cKezjeI9noGj6g4FD/Gn2TxR6s502/kovcjb9hq7jwtAJ3t4CFOCSMEEJA5KJjQAVk6bm1USrouallhrIvIfyD2hSw/orSKybJ4oQTBUBgWnjGKFTkxCYJZ17B5l3QpABXmBPgVt4wq7MR56u26Go5qpTtpPRi22dZpRo6y3KGSl2PW2lZbfEQk/I0br3OGqqaJ+wTDbEq4G1QPxe3Fbd3aqa2l757ARJmsUgt0CMoH6tNMxrIr4URPFiNaNkMr1mnHDV+ksZmZKhn1ZnY0XkX587LwiC8q4yuKHnyP1pZ9hRIoIFEUIlHB5DPaQxtzCciSZ6OoCDViV9eOrEcHgrddnan2qZI5h25zqFGFUkbKSRQGG4b/qwXplWT4LanghMyGhber7FehAjlf04fL4qMssNgvSZIKq53fp/qsRoTU8Wo55AES6mgV6heKr7CK3U66iRDYc1zuyUaucSDRxtaxuaLUQE+zEU/xRand0rh2fYfNKuqlTR5DalUPGUDvT7QwA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd87bc92-c8f3-4df6-3e92-08d877656f73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:01.9490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oj1fwYYBwY0eKk6Gm2mPh964PqUo+x2RfAblw4u1ZfJbNt8sgiaDnvdjvtdCgTG+
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
index 6e3faf4e92..483d41fb2c 100644
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
@@ -283,6 +290,65 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
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
@@ -341,6 +407,8 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_OUT]                = op_out,
         [OP_READ]               = op_read,
         [OP_WRITE]              = op_write,
+        [OP_PCI_READ]           = op_pci_read,
+        [OP_PCI_WRITE]          = op_pci_write,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -432,6 +500,18 @@ static int locate_fuzz_objects(Object *child, void *opaque)
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
@@ -464,6 +544,7 @@ static void generic_pre_fuzz(QTestState *s)
     }
 
     fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
+    fuzzable_pci_devices   = g_ptr_array_new();
 
     result = g_strsplit(getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
     for (int i = 0; result[i] != NULL; i++) {
-- 
2.28.0


