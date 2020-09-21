Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C37C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C952067D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QfUeK4ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C952067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBbu-0001Qv-2p
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWc-0003J3-M5
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:55 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWa-0000aa-UB
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXfcZH8mFhDHXUla/WZTD4N86HE5by/uVuGiNqonTVFKIdgC+RbclyYPFmzrMtWo+icI35wZHclAcYFd6WzIV+q9Y9pfzNn/aUXkDuJTUxhhfyi5dB3kytJg7XfU45/FVK50fAtirDsMJmJYuUJUivcwzX+gjdn1djCCzltJUKx4E0USvSRo1BBwNijN2pHxdFeHpjYKiYlXeKJ8uLAGLlU8oD+ylUPZz08o2TeKTId/nVEjDpC5q+0UFyQI0Yka2vJb7F4XwBRsLnTs77QinEk2BGmBvrh/Cs9E3AZjzX1HfC1EDFq2m/1+97WYwHQTjUoplvVh/nqhFDAPwdpjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt9C8PEHB/8DeEt2kjCOdyqp+2g+cWj62na1L4iBthQ=;
 b=HpGP1E7vF99hN2QxtOqHY6Coi6SRBFC5fNZUSkO15iZYjchr7zto0+7Q9t9h3YZx1j0ZNRecAB73hqEoDuSx8Ct1zo/d7Nq8IndaJExrajlpPOWFlE73K3R7gC4m8/4TU99JIEO1X+c7RU4C7e1DQh4GeTNx+JkToN6Qf8xmTZajHO22BVJjpy6pTKrBYNncPALsyxpesSdcmwiP1pjIlWVXSKFpKqXRW4GZnmVWiHxhTD3Lz7qlyBUJZYT69E5ldrjSGSgHrAbhSr0SZCt8f3ewGVypR+1fbIOfIurRTUUISUnUihRVBqEc9BVaAN0cmbih9k4CncK7qahngT9yHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt9C8PEHB/8DeEt2kjCOdyqp+2g+cWj62na1L4iBthQ=;
 b=QfUeK4ma/ix+L+6DdXMB08F/nmqwwFjNfgESBkElccpA/9J4X3EkBzR4KjPaVVaiTYCQZwhKUxaFgfFkhPrbkhwgCDt28utlR7NktfWULBitgo+z7D3/usEQBzR+uZb1D/GydZwltA1TgVLB1pgF7pw8ShHu/O+J+RyYKnbhcpw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:37 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:37 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/16] fuzz: add a crossover function to generic-fuzzer
Date: Sun, 20 Sep 2020 22:24:59 -0400
Message-Id: <20200921022506.873303-10-alxndr@bu.edu>
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
 Transport; Mon, 21 Sep 2020 02:25:36 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96b129b1-8eb4-4515-3039-08d85dd5a01c
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237A46245F1BFED6F983C53BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMplwE1zZnS8Ab+u0HcuWHb2SZKf8jFatycyHPmcIgzyGXziE4wWKhk5B6rLOTx3VJyRuWUeCJF9+3B4F+eAZeMZbcxw5Y35Vnfy14O5JlrTz1S0/JTFDCamdcRcdcGCN8P9kwrfOqrBFUbIuhBk1gzDqc+JLtTQdnDAAXJO7/UyLXIPudcZCkOPtEJBND4v+0pVYYyf0bXd7cH/c8q1hz3IsMuu05iz5lBQap6wTXthLnFS6fEcTHWs8Shh81Z7z0Q/hVRj48v/Z+cPi9sgm+4U0ErqTKRehNDFQLXI6PN0ah0dqUSlK13fBb6AC1+ZEIopwRDgCa0zYYYBEWc36b6FiyseG2eGV0ovsJCasbkInmsntZu/sEIQ31tfOW9Kasv+I6Ezx3u7ErxJfdHBgs1lXfBCBl6FrGOGTMwebGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RmU6RggU3T3opnZ0c04CFMGyVMQvp7mW5glNbVGKLhpKKnmIerl677AEOY/p32gy3QFB54bE+W1OHETsNYgkHXTixxhOynrG0Cngi4hjkKrXDE1bUS2QqAKhsJe3oisGQID7adhk1Ga28P9UTBtFyptiZbWRybZpi8XG8we/S8bWe9eiisEH4m3GuW6TAyfiebS0j9ZI+Fo/ZPXSB/bt2jgr8fVCK/7eSJ92UeWvjViQiMXFqb93ogmnMSbQdA5WWIyVunTrExRptEGG7k9wgKC4tI3hyWIoSijGjxu/S+Quz4ff94ylqoo/LyAdpcePg7CJhoQMc8ZiSNr04d6wsRUCik4Sgf9t89bki+BZsf93mNo2MLH3MCXV0TYlmJGIcQEPELhnkg/Ah570tJNaTgeg7lQRtkJu7sofFGJfrrnIdLkkfBUWiaEwGOUJx5W55oz0KVhaF2gCNrG2088cWS6k/3Ya9Qo5F1/CPymHahVpAwfAjNrpRruhpoKt7Z6D8DTIvlQt2+BVzkj82wg+YMtFX1xkOq//LsKwpl31HZ10VWZ1F+f1auRerlCccDitiUwls9g3qZE5wY/NgM95O0EqR4gpo5ZKU/KZkS5ZJgBn832OoRIiEwLij23R1TLLeX7pywe6zpfh7yBBgykXjg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b129b1-8eb4-4515-3039-08d85dd5a01c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:37.0583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QugGZkojhe/QCf1j+ji8TNw8ME5h9AD1ypc06Ai3s0U2a7XMh2a679g1D9eyxSCx
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 90 ++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 656ec7fd55..3833b505c8 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -741,6 +741,92 @@ static void general_pre_fuzz(QTestState *s)
 
     counter_shm_init();
 }
+
+/*
+ * When libfuzzer gives us two inputs to combine, return a new input with the
+ * following structure:
+ *
+ * Input 1 (data1)
+ * SEPARATOR
+ * Clear out the DMA Patterns
+ * SEPARATOR
+ * Disable the pci_read/write instructions
+ * SEPARATOR
+ * Input 2 (data2)
+ *
+ * The idea is to collate the core behaviors of the two inputs.
+ * For example:
+ * Input 1: maps a device's BARs, sets up three DMA patterns, and triggers
+ *          device functionality A
+ * Input 2: maps a device's BARs, sets up one DMA pattern, and triggers device
+ *          functionality B
+ *
+ * This function attempts to produce an input that:
+ * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
+ *          functionality A device, replaces the DMA patterns with a single
+ *          patten, and triggers device functionality B.
+ */
+static size_t general_fuzz_crossover(const uint8_t *data1, size_t size1, const
+                                     uint8_t *data2, size_t size2, uint8_t *out,
+                                     size_t max_out_size, unsigned int seed)
+{
+    size_t copy_len = 0, size = 0;
+
+    /* Check that we have enough space for data1 and at least part of data2 */
+    if (max_out_size <= size + strlen(SEPARATOR) * 3 + 2) {
+        return 0;
+    }
+
+    /* Copy_Len in the first input */
+    copy_len = size1;
+    memcpy(out + size, data1, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Clear out the DMA Patterns */
+    copy_len = 1;
+    if (copy_len) {
+        out[size] = OP_CLEAR_DMA_PATTERNS;
+    }
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Disable PCI ops. Assume data1 took care of setting up PCI */
+    copy_len = 1;
+    if (copy_len) {
+        out[size] = OP_DISABLE_PCI;
+    }
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Copy_Len over the second input */
+    copy_len = MIN(size2, max_out_size);
+    memcpy(out + size, data2, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    return  size;
+}
+
+
 static GString *general_fuzz_cmdline(FuzzTarget *t)
 {
     GString *cmd_line = g_string_new(TARGET_NAME);
@@ -760,7 +846,9 @@ static void register_general_fuzz_targets(void)
             .description = "Fuzz based on any qemu command-line args. ",
             .get_init_cmdline = general_fuzz_cmdline,
             .pre_fuzz = general_pre_fuzz,
-            .fuzz = general_fuzz});
+            .fuzz = general_fuzz,
+            .crossover = general_fuzz_crossover
+    });
 }
 
 fuzz_target_init(register_general_fuzz_targets);
-- 
2.28.0


