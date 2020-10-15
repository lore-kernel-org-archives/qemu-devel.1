Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA762078A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="prM3D4Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA762078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3bC-0004cu-SO
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WS-0007fH-Eo
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:24 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com
 ([40.107.75.112]:30180 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WQ-0000kr-1z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4YrytuCzukf9C1hnzm/P5tNY2suEgzsnyPB0TTtE2ADsIvYFtu/+APZD0/rlLghHVPLsPjItSWOCgb4QO0peiQwgwVY110Ue4T9WvGSTofif/C1it6PKZFq5wKTrYa0hJTSgAwbGnqR5Kv1brfZ1CynoAsAiW3RXxCRFug7I90VUUs4rOH4+hdVi8+j44tHjMxvL8xkezo4C1exNOHegglGkE+LiRmtHddokWbuF591dh011YwRaen4Mqp3pUycqjAWCEjXUg9Q1ellHctlhjyLItpQndCSY9FQVveQRVznentRiKm8EiKv2KJtLxsv+13B4mReD1MRFK/BnhXV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmYdT4Pze5RzdGyA4ExlEwpp2pJSoOzy7DjI+JLqg0c=;
 b=VQRMNNSxAym6ETe+p/BGTdJnaEkxLzBbJMQW9kDWTJB1rsrrR4ACWs0f+OJULWTKB80SykE5OyAfTJ6KK9cqU9UYj8O5nQEPR4BTw9CvP7lR5YuowfKHcnfbO6Wc1DWyAZS2bsh7m7XSvp/DLGLSQ6QREf16VPJrA5fWCbDH2eO0D+WOUMd0kZQTbmsJC0zNMajahBonX32m+fJaWP0eIsPm9etJ1lVBHKK4TC6u3WXCIUdxzFDrEv9DSAD48kl8Jd0FUof4OU5orknkrRe6VvWH6HVXPwuSRA2RHZQL/pEq5ZuRpGumFG0A/AHztYz7JgGaxxvYNnK/VDegpW0XMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmYdT4Pze5RzdGyA4ExlEwpp2pJSoOzy7DjI+JLqg0c=;
 b=prM3D4McglLH+UH9lAjbEw+t1yvN474N8tuOOjIdR+UX64/APOnD3nE2dEl43KYvR6kZnedNEqHjXfLEJ11JgZEE/+sawOslHdCxGNrjCDEDD+cjG3+h98Lr6xt9clw7fVXaOIr3gDG/1nQ7BGbHr3U4nAarHTmze8kT6i8QGUA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:42:06 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:06 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/16] fuzz: add a crossover function to generic-fuzzer
Date: Thu, 15 Oct 2020 09:41:29 -0400
Message-Id: <20201015134137.205958-10-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb30387-4ac6-4361-cc86-08d871101b2b
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5465E0FFD4B9032BB2498661BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcJb0Y9MsBFsw7B+4ysSHIZlPot1F8RmYhR38NCCd1xp8JxnjP7xhYAtFfHECOo9507u0X1MJpNeHaxTssGCEzbL+95FXZqpl6LaIPJ+AvXI3S9xFUsWq0Bncr42KLiVoSeIDp33dWmJIzw2+weJ8KYjfKp3est3yRxINGBqweAEf/iW/hm6esZpeJFvH9bFAZ0yGn56zCSkI9NqKNGA/fvtrMk2ssesEvHzHNeXy2LwmAXxV6RXZwzrkDLKO91vMqpm4BEF2mLJnMXPOfGNf369ZVtNZhIGIi1c7t4IYmWOI1O1yRae5OfX4awZ5SRO4iDrmrwpKkfLNsGYye0GZ9RbVbr9RXSFpsAV3YDJ0cHyKitzULuIuk5FD3vIniHYXj47QI4AO/eoBxmdUHRRxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fCqH4GlmJDzd+ABCPnjMPBGFI913UtTN18agiKHyP+hspnR1PY9mLTPGecEmE8h9o4mel8kShA55Z6t7GRK9+EBrCzXsm70LER+2lXJ15gj4DIayGDR5wsrxv54Fgl0FxrR1xLMKS43LXirKLSBM7zME6ifkaDyxysYUKgNrmSWX2KgGFrOMD1M5J0+ksMtJIqwzA84D3kNUAnUMt8D3XKBVfOsYUspq4uVG68KVfsu0P9sdCgqsYggD5jILLTUlYWcPr/y8MCKz/rg1pAVwW68zfalQSuU0G8NpyghV00d9NVB2IeFE4Z9nXoj4luP+SfTe4b7pKhnM3vt9nNyMSVEfw/Ws3bzJ0v//8OZFdGaRFEXrsbvPppe4OnhacfLcBo4qfL2nWcA8gzPKBquPLiYWpTZFlvLTNJ9NfUoufntinmowHJtMuXGuz91/szUmQPbdDJHtl/R/9DGSjMorBIM+XoTA+5qrlTf7je57ERD0jPsrbEFqh2PuRTnBNFLplmn+buT778+0giMU98Y/ISOgaMOfj+DKaiH/F65VuocvbwbHJBNcEeyeZlOVl9AzvrxxzB0JfM+tVUIIP4Enu2aOVHx2i32EoJvzboZe/+866el0Ps7JK9ZAgXP5x2K7DoVAUb1de7BJLNxynzv90Q==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb30387-4ac6-4361-cc86-08d871101b2b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:06.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1U7x99sxWMuEf7vKvtN37hE7N5fMV6z97gjXGWzjbKav23SouuIpNP/m+bpDgez
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

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 90 ++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 11346e229a..22884512a3 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -804,6 +804,92 @@ static void general_pre_fuzz(QTestState *s)
 
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
+    if (max_out_size <= size1 + strlen(SEPARATOR) * 3 + 2) {
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
@@ -823,7 +909,9 @@ static void register_general_fuzz_targets(void)
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


