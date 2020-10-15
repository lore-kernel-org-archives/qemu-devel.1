Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8118CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E342223F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="23IkHOz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E342223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3bg-0005Ew-Op
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WJ-0007V2-T7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:16 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com
 ([40.107.75.112]:30180 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WI-0000kr-4o
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzKpr4CaxqRXCs7gWHp/YrNe1XmBP+HKBv7SbN6GfLDDsIcgGhN6Kc1Rd6LJ3Uk5L790QFXCQhtPQwkrJf8EHl4BIlQSEK9aHkhe8YBsCdGK/5X6dt/CdiyU6FwbfXDpTVlwLxxrQl1eL2Nw9RxRDp3t1fMuEilhjHCmRNd+ga0ihYujyIcC4D+NrWWT5WALml4PSsR7qHcaZ4wiu19ZtRyTg9X6y+61PD/TWShgapQnc6Ow3Uqer5mNqw/W24lD+hrGcoe6qLy+l6OXDqACBunU5KhkMmI74WfuGylcJqsseL508UuWU+GaZqucnvVJHG966yNqCctuBcXOJv800w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ2vk3EK3gZBly59m6sfF1WwI+U0NOLarCT9Z3fuauQ=;
 b=X+syqWo+2lLImqQa2D0SvAUO/wQgSDrBU49RjzTH/PgK4N2vwXtQ5kodAtrM37QbhZ15jBfTMM3WExZKaJgGKwePWyZMQpukBUVdX0JQWy9XZIVG4/umC/ZSwOaf9FizI3JjKrEy7QHUfRboq+MsZc70a+J9jSyXsJRxhvDPpXuuSKxPzQs9nunkmIQ7Qv2rxWm4KB/M4lpJnN2eFgPtCA2S87b57hmFLzvspS4FxtQDpZA2P2o+w9S3tKjofR6tRLpOEgshPY/fZA5PFl6hhlX6zmcA+fZmyMMnd0lRyZhiP9NMvAUOvj/A7N2a09tfxxuhiNbyOed0PTUiFWgRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ2vk3EK3gZBly59m6sfF1WwI+U0NOLarCT9Z3fuauQ=;
 b=23IkHOz1KWnmrLGBNz2z40HoMK0tZutLA7H2S/U16B0rnw0C7l79TsyWVAwyTN8LImi33LK7Tb6tX1al1bvpC0cUY25Es42Y1L53T/IfCWxVRfpdclRGJy+tC1KocYfR5IPdL1gHB1OjsTG3KQmocWbNYb7lDTDXcmJZf4vMb+Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:41:54 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:41:54 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/16] fuzz: Add PCI features to the general fuzzer
Date: Thu, 15 Oct 2020 09:41:23 -0400
Message-Id: <20201015134137.205958-4-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:41:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba7b55d-94d0-4e6f-edbd-08d87110140e
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5465B6297788DB461FDD8E73BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iET7ut4rVSCDwBIld/CSQOxvlm8LyxD2DOTOlj/GBi/W9CtCc2p1psaSL/ketNJxxuyj3R9lSe2LyyZzFTj5LQIdt2+O/UfmZkZu9o3aE/GUO/IkOOGrdXzxHDzoDPteLbBM/DtSDR+RxIlVLW8H2zYuJgUGKSAkGtw7R/8iahSixcLd6eZ6ihnzjaCcuO2FDGAFAMR3lk9vGu91BeujKsBh52pGviTjhcZqwn6xtgDcjeX2gSZUB1yHgDKORNcSbZGku5C3g4421S/K4aZPEuTIXsYKIFy3zvPKfkCxKNu4lz5cNkfp7Uih0AAPTEaMggUD0F2HBUodlY8B53t7dsZZ+XQ3uIJdqDv5vvWRouzIcHDVsUl18L7hIKvw/r0U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: J1QDG/sm3j9KYqzTCJ2/u94xQOAwReLO7oouMWTDkGy0XYdOEdO3ip6aP1To+TCHrJJ+pDnWrdeK3pT6rU0Ez5HOTIiVyly8ZE6W9kavt1xuG6NmRRPM3uMppBt9Zb4sSDqUyCljtjgX8M+mT9nLc2BZ46vDl0A0rgf0V3FBcwdV/GyWGWe1W9UewpkDHMXU0HAFwv8zraLvNfVE7VwXntbij52Pr2l2p+EIszC/CZ+LOz/tN5RMPjekPZhnh2rRBGjmhDWb6KA+KJEvXf+0QAPQmIj4BEfebgJxEA50VojP72lHfbBIKB+MeFdmMlJxEMLCTqqAD/fks6ue8d1nmRr9JPdO5Evk52k4z4UrCwe8KODWXFUSaixr7Aqq+tQtt37i9b4QprwNlSsztC08Ulp1GBkeX8MeeL9qEmHJgJWlaKmxRoNjii7ATdt3zYFkx+eyReRgGdBudWGGw3W8cZ+5IvQAlNWseQg/W2dGk4YdIC3UKBACgm0mya8/r6uxwR7xAj+DjsHIZzlBIoFLCuTrIcjemzlu/SlLfwWVyFlsXYeJHg+CaQB4QNyFO9el544EgyaVwCzM89hbXUiv8wdbqoWIYk2fgFkVrZ9TlnEM9AH6jJoaoidlKL6qr57EKo5MOFJOKPlcfOrKeEvaUg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba7b55d-94d0-4e6f-edbd-08d87110140e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:41:54.5981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxul7OtuPDyS6YN2sEGLGlyh8GKg0l3w/fBITpID1u1ZoGfKsL29ICpj7A8njjVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.112; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:04
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

This patch compares TYPE_PCI_DEVICE objects against the user-provided
matching pattern. If there is a match, we use some hacks and leverage
QOS to map each possible BAR for that device. Now fuzzed inputs might be
converted to pci_read/write commands which target specific. This means
that we can fuzz a particular device's PCI configuration space,

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/general_fuzz.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index c1c6dd3ba6..ef754843ed 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
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
 #define USEC_IN_SEC 100000000
 
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
@@ -337,6 +403,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_OUT]                = op_out,
         [OP_READ]               = op_read,
         [OP_WRITE]              = op_write,
+        [OP_PCI_READ]           = op_pci_read,
+        [OP_PCI_WRITE]          = op_pci_write,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -427,6 +495,18 @@ static int locate_fuzz_objects(Object *child, void *opaque)
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
@@ -459,6 +539,7 @@ static void general_pre_fuzz(QTestState *s)
     }
 
     fuzzable_memoryregions = g_hash_table_new(NULL, NULL);
+    fuzzable_pci_devices   = g_ptr_array_new();
 
     result = g_strsplit(getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
     for (int i = 0; result[i] != NULL; i++) {
-- 
2.28.0


