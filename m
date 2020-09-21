Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18834C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D012067D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="hrG1+P6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D012067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBbA-0008K6-0l
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWY-0003Du-0r
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:52 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWW-0000aa-Fe
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzeFbyi4AT7fn8UlOIODxbGG5rhBuN5UrcqvIXwRiz8HsGuOIMychrpdb3dHztSmPiS5u6jLUVYqvCy7U3e87YqGOLiCBO0T2fwLLbwSKQ0jDzuK00ZwEDn2jKntkY3Kg7ZgEN45Yl5L75KVGyormAYCDduZXpmjUqw++CSbuxecE4TERY4SpF2+Q58KKrGVpFs4A8gt5IkVNRzw0Q+JyLeyKy9oyJBij5ViP70vbdhQuhFG04/etYG8osYLzwHVMU8UhR/I/lhSDGosd+FTYWy0hY5qAbeltbfklnz29a0Og/jA/Lx0hAJvnj6YGmwcEzjmnrqwtjltSeNBboo2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM2SGcB6sbksJB4Rq/VsjMWKr5tR72Q/RHTWJfHdqfk=;
 b=ZuvJYrUc27YTPmuE7cmSgHonI7Alzz6mehdwinkEb283RJteGXR1DDDvwrILHTQ/nD56CCa9YDB68g2dk2nUjnogFXqgy3E9UXKMmcQRdr19r5MCHHONBOC978yCgh9UUgGmGzqiETTbqZwufIrLu6se7P1gE895MAfc6lCouh03ZeBZlm2zhsHLCdVDyMdF6ArASka8s0fCCEwd/HplM4JyvNrLZgGrggKkOvCN8MzRiQFXPT8pxAcPpYgKFzc6gjsUeiaPqYN80ZwDeyWKPpU4tFhEClqt5qJYCzxgow+/EIjI4eK+T8ICoomAuaZVNljq7p77IXZAEIw2AaWzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM2SGcB6sbksJB4Rq/VsjMWKr5tR72Q/RHTWJfHdqfk=;
 b=hrG1+P6SGMQNyLwDrEM4BeePkxRxgERBu48Um3rL2usOZxGsbF5Vf6UftfI7PbDnAPXK0vu4S5012x/sgHi56NEey2xMiXIMnnEmOF6q6ZWdE9a+tjkg2AEP+n3Ng5/lsJYQ7SwmiDzBROZ94yhHTXjOPRlnmmwR85kQWmadL6Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:35 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:35 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/16] fuzz: add a DISABLE_PCI op to general-fuzzer
Date: Sun, 20 Sep 2020 22:24:58 -0400
Message-Id: <20200921022506.873303-9-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c33e85-1c1b-4362-21f3-08d85dd59ef1
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22373695A8A6E6A97F16B38DBA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kub0vZBBtz7GlNYxoKA9UGjr9ZGvSZh8vSbuCctb5aYJtPmqC3u5b4ZjBxJ/CGSq6RQat48zPivDH7iWtCA5bTwQYDJX9Uq62f93BcFks5GxHvwFpNW/iSPpVJYICW9EPWabpjktqZfHrLozjgiK/04mkSgTObK1PxGUd0GvB41jSYL2JMqlnYr9bqm6mn/8teiwEpPsPCxCNqia3F7kvuwhiIce04m3ZH+Dt1qkeck94rUU3cfPwmuV4APPucTqQIjdcD80+OxTM1ltOqSSmejl+4JyR2YwjzZuuOI9FbNbey83dDmLf0Kr84ujn6TgoJq3mbYy5F8KbGgg1jNcWpHdzmrgS2pBB8Rc5jRbw+AwooNB9zM8lL1P6bcpjAYE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3Bq7cRsRSHgOMnksUiCsSFNBLnPEfZuURDS/EgOGo1Ttq7kVqkAreNkJPprypdBl7WGc89xH48v4/gwIwt3wjZyyjnM35EYC/cJrefDTz8pYBCTzvtnrnE++gqc3GemtTR5eYR4ImirKBnOekAYWY1SJU2kIcYKvMYMtyjUJZNQbrB/V8/4FE+S1qiiqk0Zo0DthPeqM/49E1jnokqRLc+wehMSWWfLYGISB9xZJoDIo5rfHSY1gggU3lrb9OJFxvGzrpHGhWnFUsb2Rn+e09OGWt0uYJgKBF1nWUjFp3bDbrRCxzfBf8SKelGte6+FDk1rsLo5Bv/kWc8HP6C+Z1wFH2lmS8XPOP91KgxqIgvNoqIJTv551bD1woZOZq+bNytB3k/DU7YtZajjaYpt6A4RGPB6kle7buomQyGpG1v2BY10c+7wBxodTb7omSdX5F/iBWLK/SDJodbsXHU+AhAvJvqpiCm5buum1niSC9YE/MtQWHbB2yHGo7C5QA+tfe30aS8XEF5yg4tCLu6jk7daPLcz3/WgJ35Lq8t6kgU5X2FhT2tCAsNOCAPxEGGupvyRB+iwh+RtI7KgskuGW1Uc0WGQGRv9uwIAT8zx2QJrPWRF77avNIsNGmWVuAUX0Hz4qFqR41VCRBvoPoHmX/A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c33e85-1c1b-4362-21f3-08d85dd59ef1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:35.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +F0bCZSG8KCzuPV8EtL/IyIF8j9CgLTD3f/cxX963ijfsdGR7UI5EDgYH6hOriOW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.93.102; envelope-from=alxndr@bu.edu;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new operation is used in the next commit, which concatenates two
fuzzer-generated inputs. With this operation, we can prevent the second
input from clobbering the PCI configuration performed by the first.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/general_fuzz.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 5e42504821..656ec7fd55 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
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
 
 void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
 
@@ -429,7 +431,7 @@ static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
         uint8_t base;
         uint8_t offset;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -459,7 +461,7 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
         uint8_t offset;
         uint32_t value;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -514,6 +516,11 @@ static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
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
@@ -555,6 +562,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_DISABLE_PCI]        = op_disable_pci,
         [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
         [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
@@ -587,6 +595,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         }
 
         op_clear_dma_patterns(s, NULL, 0);
+        pci_disabled = false;
 
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
-- 
2.28.0


