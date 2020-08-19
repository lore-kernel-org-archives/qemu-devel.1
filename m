Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393DEC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0B02063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bO5+K+rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0B02063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HMa-0000Uq-4b
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK7-0003q5-Qf
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:47 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com
 ([40.107.236.94]:24608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK6-0001Y3-1Y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItT9rcVQM+atQFXmuKQAz++8UAefcV2W4yTddcdK6tMn/0mr4sUa8PeWek7s4JkvTJdEJ7U4+OmWqh9cmuQxNlkFpbjmYNhxagulOy5323tTsF6kNDZ1xPJzC7QIA8KLlnPLMPAbMz1A3tmZzSdexoUWwj2j6a+YURIAMFjJ5BDqlk4+4H7r9z2WAGDU/YKbvUYljqJDpkTCRpUcrqrRGhm3KqXZLDducE7GyUvIBL3kKeCQNJSi9O/4CFbcl7MSKCjvz6sjnTVZYbRcBszZ4uLdVSVtvWh/cpbOgiImTldHG5YDjCPWxTorU9puOiHrHvB8W41EHGX4rTuNeFtWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc+tX5jZ0Br6pPcYnH1iQaIY5uk/eODZWK2u5mJvG10=;
 b=g4j1R7RCNWlhr0WhChkGkqQpsOk6SVSP6BjhlhW3IJYSBx+ItlAxpjm9YE21KC+1XRppb40snlNU+ofdF+SyKomSbUMMhZuDjvOO2KdVbrdteTdKI1Ivz6A+oSxFxinrRM5mBo0U4URNSRxI+6T+l2zaD8ArtiX5qxaar9S7BZIQ2V1BXlzfrP/BCWIhBLkLSbBScEXvbKX0LhXQ11TTNKaJJgxMLSWrwpoZ+5tuUk6CEEr6NYrjQNEpXdTr6oXhUfI5qfWZtNN7AhR2po1mRM10IeIKEX6pI6uvKjzXagVdc9234lkDGZ8ehj9zgRSPVCvEyErzEX8geEF/zPLb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc+tX5jZ0Br6pPcYnH1iQaIY5uk/eODZWK2u5mJvG10=;
 b=bO5+K+rBWsUukMe9vw44/OIwzY+WY1z+HQilGLP1XtlI3R723jSBF9ng/eU3GWr6hQxjsUal6jPVtPNAuZWAlD8JN/vQ6ThUy6EksFsXNouWHWF+qaRSkyaaQlOMZ9h3OQ5ZJuZQtbgQTELcQmntM0QZ3PL4irmu/Kyk5a0eNBo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:35 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:35 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/15] fuzz: Add PCI features to the general fuzzer
Date: Wed, 19 Aug 2020 02:10:58 -0400
Message-Id: <20200819061110.1320568-4-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 519a2f93-474d-4811-5006-08d84406b9b5
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3934FB68589A2B65A9FEDCCABA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8CjH3ImOWk3gmPWKGvGnmVT03q/U25d7oq1NX0Tsvyc2yYuCM96hZMLJNWv+1jUMblsqI3nIEEjYnQBSRlMhagyUb8+T9Nf2xgzgStTHddk2xRIb0ORswJ753jiBCs8Ke/FVSLdiPbezVBncmKg8y4L/16rpBSTY/QCxaeZlpsSzGqSPLuJM5+YP07pjEwvSdvVxcJ2Po8Za/WVsESGkKkgV+vPMdScccDqQ7D84FhuJmfeLtXFj9JPlZCd4xEmsmCHmJoQW1PL10VLN0yziQUBKBi40qK98K4Tehlurz/zPnLCvAWBfXRAbepKMz637zuJv/fYm763QGtroFv7ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(6666004)(2906002)(6512007)(8936002)(6916009)(83380400001)(6486002)(54906003)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: y+tk6c5+uMjQ5AOAu7NC7x2QQk9fhU8D/6wi9aeDTNqP0kyWgyZYkg9Sa9Fo6YeGqmDDwr0TBZpTpV6B3XHmEGjM+5H/FLyt6nxDNe5JkkLFj4HnHrQGlDp0dWMVGEPtlk/GzGjZ04Aj53fwBWKGXD4t6wo2LLCIqlHj+xvq7bRtMSyMGoZi7HxXsmNhXhamLcryKaxSjHzUHEy4uZuJZbatqwLwheOQ+pTsK9zHg/CDjxOkAJBs5ocdTx1i18g+yqVLEjmsBIf4Oc/jOkA4Idvm+Kq6lF2YnptcFpNhUsHit6UBG/7stKzw7v1dVdthi6N4Shv6oSdjp2ldr8VId9hrxari6a0xB08LuJGg+EPaypB+w2wmZrJWA0lj1s/uJsaPRfrt6en3lFsAAh6UxgoTNKpn4D2HqjazCxPeoWRJKXKgIzDXX9XkvCyvtUWvjMgqe3f3nTmClJT95arqcpllvarq/W8ot0RYn4JaFzl+tz1XpjZ3zkLp2uYlpMXswk1sCjOdeX/qmUdXsdeElPrImrSNX0tonyAZOvPzajoeiV7pJYA35TTIB78HlT882BrXzuuopG9vcCOIVyOKRIuXLDIXUxcILA1mvP7ymyjVV8ijYa8KVnPw0DwlrQ566itStquSnZht/pFUjsxRoQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 519a2f93-474d-4811-5006-08d84406b9b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:35.4472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVzgT6nH7Fr0MzZcx7Wwa8HOzOPog8AEh0PZ8xOg6V0BU6mXPXQkFoYkaoqep78H
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

This patch compares TYPE_PCI_DEVICE objects against the user-provided
matching pattern. If there is a match, we use some hacks and leverage
QOS to map each possible BAR for that device. Now fuzzed inputs might be
converted to pci_read/write commands which target specific. This means
that we can fuzz a particular device's PCI configuration space,

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 01bcb029b1..17b572a439 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -24,6 +24,7 @@
 #include "exec/ramblock.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
+#include "hw/pci/pci.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -35,12 +36,17 @@ enum cmds{
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
     size_t addr;
     size_t len; /* The number of bytes until the end of the I/O region */
@@ -52,6 +58,8 @@ static useconds_t timeout = 100000;
  * user for fuzzing.
  */
 static GPtrArray *fuzzable_memoryregions;
+static GPtrArray *fuzzable_pci_devices;
+
 /*
  * Here we want to convert a fuzzer-provided [io-region-index, offset] to
  * a physical address. To do this, we iterate over all of the matched
@@ -283,6 +291,65 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
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
@@ -327,6 +394,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_OUT]                = op_out,
         [OP_READ]               = op_read,
         [OP_WRITE]              = op_write,
+        [OP_PCI_READ]           = op_pci_read,
+        [OP_PCI_WRITE]          = op_pci_write,
         [OP_CLOCK_STEP]         = op_clock_step,
     };
     const unsigned char *cmd = Data;
@@ -418,6 +487,19 @@ static int locate_fuzz_objects(Object *child, void *opaque)
     if (g_pattern_match_simple(pattern, object_get_typename(child))) {
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
@@ -445,6 +527,7 @@ static void general_pre_fuzz(QTestState *s)
     }
 
     fuzzable_memoryregions = g_ptr_array_new();
+    fuzzable_pci_devices   = g_ptr_array_new();
     char **result = g_strsplit (getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
     for (int i = 0; result[i] != NULL; i++) {
         printf("Matching objects by name %s\n", result[i]);
-- 
2.27.0


