Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF52C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8E72063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="yATVM20c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8E72063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HL7-0005UH-Ja
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK7-0003p1-9i
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:47 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK5-0001Ya-Du
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAwrhRSMSN8gPQv9rsc1SYUr6gh4V71Grjlf04HjO5Qm54qfdlEUtOR/bjM4suEGThV3OvyyXHnLa9XyDh5jxjyJ4fYAkroQdp1Hp3EGAwUqyye1sUUPLUJeZElmZBzIPvHyS0VsjsQzqfdetckwNp1rhtafv3nqfmSC3BMN6ZZ5RriXhL/UDBL9GoRQ8OiPPafi1KyYTzecRNlpUkKSGm3O/sOt6QiWRUb42brJKoKRNafC3tqZs2MuExoHgQbeUWCB/nam5fDfzVtNnK1j5G7uP+3qKFGUSyqfgcM85zaqVOtnELCpJvh8Unlnm6W524Ok/IRZs+lmVtMyrUXl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jEEW4n2UfTBJrvMDdGccCjGVukwQQAPAZDCU6cSZao=;
 b=VbTIDG4uazim9f7LKrysKrQyscH2scAeig8Hb9T6tVNP4EQq4m5cG8fWY6Aad0lOWvBbo9KeImIZsEAFz7oZDa4f8p4tRBkrZ4t80le5rhjXO1o+d/dliogQi4l3A2N8QFMNhVdznnXMj18ey1F+y3wCumIR3+9NqW2jABcHp6C3tyu/9OHWH5YldRw5sHZrH6yO/qPfBmawn4FTd1hXjaMuZVQOJLPMEDQ//CbB0GHGMU67AqKG3cg9rOflEk388YKEy/MgANN+2Fsz0n35QhBXDvioVim0C6rNiodvSrsyFggb0LWqEMmwFJpS9uNxgscDFzrKRAWMzHexpYv6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jEEW4n2UfTBJrvMDdGccCjGVukwQQAPAZDCU6cSZao=;
 b=yATVM20c4PjH5wsqEnjvcXah2lcEH3ocqTMgp3voDhNuMvqTZX252gOttYdQAUhuYQFgQO2VBKcYmgcKsUjBqW7KVUT84/u8e2bZ9xWkWr8cYQTKnj8ClHOIexZ2eJPYC6CCDru9SUVs3iiLZkmegJdDWq8lOMdcesrrZDu2H94=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:42 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:42 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/15] fuzz: add a DISABLE_PCI op to general-fuzzer
Date: Wed, 19 Aug 2020 02:11:03 -0400
Message-Id: <20200819061110.1320568-9-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:41 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17defa43-83d0-4012-8294-08d84406be04
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3486E077048A510610EDC403BA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IqRJUjQVF0c62fikvroKARp/RBk2OsqIgH8HJ4G2J125iarRgyUSeNkkOdAp/otJnMfkk35J/FUl4qbIBoBrCnI/AL4Tun4odz+PT4xgERu5MS5MajhpzfXic/qYaMr+DSLQy2qYEjuZBpU+OOXKVLNLJDGA2memG5cL+PNkQWBVJ1yaKaEKI2ynyxnONM8aI8xTPFNJV2NmIJdwx6fjATG3fuRW/bjU8I4ijhAeGBnIqOm/mZVafJ6K+gSvnEYNCowD8eyMVlB+Nw5Vv3ewBMXOiuaRnccYK4yiW70bG1GGUiPln7qbOfu5eJwJVob9SFiNPxfOzulk3wUu3ZQMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(83380400001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: klmv5zGCLlum6WCT5l7+UfnsERz6Dt8c99qkxJgS4V7DngU20ueVWHE9hnTt68Y3Z3yz0FLkhhSTaTRECLHCQqzUyGDGteWQI0RlJhqtv8wgwkFC3GX7wc6hY/ayV193maCqX/nKZNltcqdQ6BqCpiwoAh4LevLIUyXfsHxZsFdNEhkE4vKczgZmaGH2BgRerv43xIFfQNVZkY02EIg8EUylYmlOPL/DgEBUDgRLYrqZQ1D/g25q+lEdC/d1rUeunYF/6d4PW57XHoyjkUS8YCdfWW0CgTkEQrES8FW5/COxmgZez7HA4SsJ7nzzzHoCYqGlBQNhZhlein/d2F7Yqr6tmkRTQp3jTfed5qlPsWuaJbexYr3ps16b96CvRPTLFPp8FRpA51TKwcQHLH5FsfTFdcoXky+a5GVxuGy01nqkvjc4iLWaTxrdpsgQoAcMUtvlcsRYL6nLmxGjWehjddBh8P8Ie/+QZsdfSZ/qm4C3OESgMolSIKoDVXqEOocsSQ7ulAl+csv0GkufvAmJ0RMEUoGfTCoYAFn8JJ7dT4kBEPHy55TMNvEXM+ktHoHJIFY+QWMraiMrvFHdjVOmOrvCKNfnlyKSD6+TyPISWm47Fmrm19tKk9Q+U7kx5mB/3uM3LKQBXzVr4IzRYy9kHA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 17defa43-83d0-4012-8294-08d84406be04
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:42.3263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbvM6orp3XYWdJOxIfQ0HLt+6pe5KBrqZne26PcSIY1qfCTv61m5/2C5hASCGsGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3486
Received-SPF: pass client-ip=40.107.102.119; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new operation is used in the next commit, which concatenates two
fuzzer-generated inputs. With this operation, we can prevent the second
input from clobbering the PCI configuration performed by the first.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 36d41acea0..26fcd69e45 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -40,6 +40,7 @@ enum cmds{
     OP_WRITE,
     OP_PCI_READ,
     OP_PCI_WRITE,
+    OP_DISABLE_PCI,
     OP_ADD_DMA_PATTERN,
     OP_CLEAR_DMA_PATTERNS,
     OP_CLOCK_STEP,
@@ -93,6 +94,7 @@ static GArray *dma_regions;
 
 static GArray *dma_patterns;
 static int dma_pattern_index;
+static bool pci_disabled = false;
 
 void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
 
@@ -433,7 +435,7 @@ static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
         uint8_t base;
         uint8_t offset;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -463,7 +465,7 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
         uint8_t offset;
         uint32_t value;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -518,6 +520,11 @@ static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
     qtest_clock_step_next(s);
 }
 
+static void op_disable_pci(QTestState *s, const unsigned char *data, size_t len)
+{
+    pci_disabled = true;
+}
+
 static void handle_timeout(int sig)
 {
     if (getenv("QTEST_LOG")) {
@@ -559,6 +566,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_DISABLE_PCI]        = op_disable_pci,
         [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
         [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
@@ -591,6 +599,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         }
 
         op_clear_dma_patterns(s, NULL, 0);
+        pci_disabled = false;
 
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
-- 
2.27.0


