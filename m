Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E718FC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2689422253
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="D9vnR3wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2689422253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2lb-0000qc-5k
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cD-00014F-Ds
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:33 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cB-0004s9-RK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7s2NogHI8sfmBg7p45vh3PYkCrxnXi/Ng5lJeG/mHq6ptuN25+ioXUiMi2SwfsQuAAy+nvQUlFfwGw2pi8Eq8dB92vLpf7jlWKH9mqamNYmUZiBL9mxjBPCOqsathMX2JHQRxC+oIys13EXfEcVvv8OvJmhjAYnZCyELVAfQ3h4v9YYLvv4+5mJNDBqQBtF6QlQaf1+IbNWXP4Ef2RZejReKwo1nj13iR2HZWq7f2OHSynS5gWveQK9FmdbhhX+N7iHFAoInJFccaAQSymRAO1lLU3beY5RjwCgAYQ2z+JhzGZ+A5EUP9De4sTM+ByQo9BAwJT9wzzcv24Q/OyI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp/v1rzkEfnbsG5EE1P7tBu/Sf4LGkGkjKSHQaOsf7w=;
 b=JTrRxNWbK1IMUhULqW3eeMGh80CR1BWsU8hbpxo92xySQiFjQs9SvCqBTv0DX7su2dgeAo0ZgIviH1+nanGMfZIP9dK47cEHJs/nC2HanDivvrmhEiAhkgnei6hZpI23tbuXz8TS+3RCexQGXoTHYYdAkgBecYSqwx4rUll+NSri1TGMljD7J1D7Iu6h/Z6mZ5asx10zeL87DEQC6L+iA4xoZsIP6o5aRlmNyaKyngjVi6BsmJ+gCtT9avaAlCZEvWLpgiXh1M2jiU+cdM8FD8z3dT+MavELvlDJ3ZRpx/Zn34pnKRBRKnpPXtuuYmcYmCwhMBLWHl/enR6zxahMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp/v1rzkEfnbsG5EE1P7tBu/Sf4LGkGkjKSHQaOsf7w=;
 b=D9vnR3wAA+E7RQ5f5letyNC5VmNxOZKSzYGPJM8o5xTSE/zSJk3yFvMvZbRa6waj7sEHa4fnd2NZPQaIZtbX2k9Bud2wwtJR09V14DtpjKC2Geri3lKtkFlXuIaL87zT29eZ58bg8aEgvhhGbIUq+Mv9sCzkE7U/wrD2KDwWJ8c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/16] fuzz: add a DISABLE_PCI op to general-fuzzer
Date: Tue, 20 Oct 2020 21:07:44 -0400
Message-Id: <20201021010752.973230-9-alxndr@bu.edu>
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
 Transport; Wed, 21 Oct 2020 01:08:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4588b0c2-ba7a-431a-5857-08d8755dc9d8
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2333F7E3507FA220622BCB91BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvK60AzPjJVBz3IPEcZUR0ZjusT2SIMPLVhYXMCM6mn+W6xa9SUKxz9R0eWZaI/m2zxDk9ma80StQKKQV278bYd8HvpHwsxvmVmeA7dDQbzTGDdmxn6Qt8hmKDqFuurp6VY33qi8ShvNMw/8z3Nh8xjJaNTsJQLb54oHx4en01772d8ne8M5A3ML/31+C/iNmgrFIufbawbdyTvGxnj9iJH+sRwum4fw+gQSE9tx3LXqJMCEKpD3cHGsbW4FBxVGcDNhXzQRuGZudwkLQwBGqyhpY0cZ6GOdzRful95p0+3l6GXA3RFSDDiksVF72vDzZFTp1KV+h7qeZTVa8OV1Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(83380400001)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JQ4tu+TvkqjbMhlrpG2jUGjMA1poQbsqdB9xj+g8uY8otYzmJ9lUQXkNlUqf/uMc+Y/Ex8k+dU5S0vvEVjeebyCrP8QRMlJddV7E+z0TbI/9EJxZyKNNKTAaAiFsglbS2yaKI93NuIk4NjI7Aak+QiisLUGZ4WzStspYljS7DLPqJj6KccX9HQ+8z7G1Ow4Aa7B/rUf+gDVkU+9CiYmMUK5xaEXMaXad2epKw3QuB1u4pHKoFG3+pou+wTqbmXDa8vioZueK9A5Uq+on6zKIdYSEl0sILjnyk+2xetfa/IQsYLo6c6IZL5+Y6i/Zumimwrk+uHm3FQ2RLm4IRk/EuKYgCeguIEC5bTdrIbVhWxAgoM5vByOfcpVuL4NsUi+tXx6MBJwSfLc7oq7KHeyhIHw4mK/5gAVbib5xtQ8V5vhOHVghsMdZgCaJMqJUZNsWlns9jqCQpcvQT0Ff30QR49YvZYmN4TIU0adyRYdLGhz7wgQNy0wGLkmoCbdo8uGqNdfRwXckEmVAhEubp94fORGZGvAKICLPXpoaFwt3ZaDS3oUWgsgMeb5rsYdLBAQhtOOBT4/4Sr5JxzlaXZ5CAqZdZPo9Q+cSIjZCf67N01pNspgB+bLnHd73aQY5I40+ZeKy/ua8Vgx3QjIjaSvEkg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4588b0c2-ba7a-431a-5857-08d8755dc9d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:15.3471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CszKNA2KrTQPeP9JzYOlSsYgQvU3eskEhIttX2GAZGjIONoHSxAiEEkueYyciSy
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

This new operation is used in the next commit, which concatenates two
fuzzer-generated inputs. With this operation, we can prevent the second
input from clobbering the PCI configuration performed by the first.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/generic_fuzz.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index a12dc634b3..b1254f4e63 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -39,6 +39,7 @@ enum cmds {
     OP_WRITE,
     OP_PCI_READ,
     OP_PCI_WRITE,
+    OP_DISABLE_PCI,
     OP_ADD_DMA_PATTERN,
     OP_CLEAR_DMA_PATTERNS,
     OP_CLOCK_STEP,
@@ -116,6 +117,7 @@ static GArray *dma_regions;
 
 static GArray *dma_patterns;
 static int dma_pattern_index;
+static bool pci_disabled;
 
 /*
  * Allocate a block of memory and populate it with a pattern.
@@ -479,7 +481,7 @@ static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
         uint8_t base;
         uint8_t offset;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -509,7 +511,7 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
         uint8_t offset;
         uint32_t value;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -564,6 +566,11 @@ static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
     qtest_clock_step_next(s);
 }
 
+static void op_disable_pci(QTestState *s, const unsigned char *data, size_t len)
+{
+    pci_disabled = true;
+}
+
 static void handle_timeout(int sig)
 {
     if (qtest_log_enabled) {
@@ -619,6 +626,7 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_DISABLE_PCI]        = op_disable_pci,
         [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
         [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
@@ -651,6 +659,7 @@ static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         }
 
         op_clear_dma_patterns(s, NULL, 0);
+        pci_disabled = false;
 
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
-- 
2.28.0


