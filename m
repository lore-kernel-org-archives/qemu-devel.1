Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B10C22248
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fnIdjTmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B10C22248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3gP-0003JS-9d
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WS-0007fI-Fu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:24 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com
 ([40.107.75.103]:37594 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WP-0000mT-Qz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htdh9hdCfoA0/HNfwbjcR8hzPbdbwGE6jesfSr6GKVOvEAGsN61BHj1YT5lFXTvrKndA+zipihUON5/azG1fKXg1FWB1gE+uwsBtEGcaYU+bD9I/0e6Ptr/w8YAevbanQtMuo4eYU0ZS1Pz+Tn4fuixkT60UFfPYpKasH1ZdfnuXHWXR9xfK31b8ctHZ3UMPJf/ID8pgwHliycL/laa589K+mm5mJo8hx/asaOKuIebT9tvQEAB2idWZO3yxv2V/4Md68Iv0i/3Mp+RMnev6pEEbf/4u6hAyBXPsUu47Pwc0hWusd+yp1nnGlIc+3WRb+9RArX3M1+z/CK+z6OqCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oq3f7e7uOrwatNI1t5E8DKlQvhKHtRG10y754C+dYs=;
 b=ANjYamRCxbcM14oXXHyTnrBMWbYAeLcmKYtoVZ+uJh0DYifMWuXWi8cAlT3Tfi+4nRhxLAIdCrERzOk4uDxj4ql/GmCYqJ8y1kAIlnL8JrQYAPY1yWjWSpWzcDY6zUZVkdRRzkdC0qqFpv4duBXFrtUFKjU7S922AWdJNXkNVLBSsCldFczkzWrKMfHyW7FBPHQJ6qsHWp6scJUJSLnLfV8vwDpIji8EiWctzBjSk4dxxRxxJX2ABpRxa1F1U7jgSSYDiLpeTdUIZ1SzxJVAsD/Ji88KOLgTT3zcEWil2qlSVFpL+lKNxkJZo6Npnx9TwkljEbhg85I6J5iSTY0YwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oq3f7e7uOrwatNI1t5E8DKlQvhKHtRG10y754C+dYs=;
 b=fnIdjTmEjXD6+HvWHzU+6txzgIxDFfhwBFUeNUmLw5dz2JqJaz5eLo+PSCw8CaE8XmbU9lcRbTuvhRLPL60OzLzOBYt1DJ+eJW6rhV0O4PaxE7z3ugxKLnj/OBvxo8+nAe1BO7cWHoWnEUtUE4lJ4kRDAEb4EJdvAor0rxjRrYU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:42:05 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:04 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/16] fuzz: add a DISABLE_PCI op to general-fuzzer
Date: Thu, 15 Oct 2020 09:41:28 -0400
Message-Id: <20201015134137.205958-9-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bd423aa-7062-4237-b235-08d871101a31
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB54654538E6AF46B33B015668BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rj+UN48/3Kilwf9/mMvoo86AMw3DfJYMhGnhjgWS1M+Rkq8LhiH8aqhA/89R8gkAJfjCqxRti3owKeVHfwIcnKdYk0Y1Vl8zg00R3Ql7e93luaXtsOe1N/i+4FEX3l2HRbAolkN1grzfpiWnlS/qVjwG7fQdf6qeksbpy4P0wKMnznwa87Pvdugzp5nn3BpgE2gU9MF/hKQk06ZhC4XatMpNOx6kHaH6aeF4EM3Itgxa6GnmZKV22WqrCDtc6qgNsVp8tPmkeueShxqvDNUpu5zOYPpDUU+9yRb2TOl83NFZqHTJEKPhMW6dn9ORG1+I2/x9RyAsKfAogKM+siHIl/VMvfhAZv7/Gz9B6eDkD7CrAYEScs8IUnlWF6INbcO3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(54906003)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(83380400001)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WZAcZwZTCax/1LSQ1Xfo1ez9fcISFtba4oGN76WDWLaT/ohsLZmnm1ul7Ezwtw21cf+jDAPHXqHUUjcKvXpOJiHmj9F85eaFdHUCLHqaRTux5n3qIkfU7M637a6zWiywrAnRiELvNrwa+NKoTZR5oN/cXcOTCWBRRCEal16ehz2AYQsV4ATTOnEWbpYQUwhDO59k9zKGCM4YxFMAHomrTnEaP2mTxbR5FNf7630YIqeAp0EUR/pSAjSNxRePY9scSIoSBF+CULGFjdSpuXmK4I3zi95Yv67tpeS/3kSsLfpvcqcz5fPZ0s09Ywn3gmJrjOlwBvQBKB0VqPNbawsgs0bDUGeZDnJuUZWXzNV1RwTranGfzB7XUX/Ofdaa77PXURzLgCMBpC08yNOSda7ekmWyFFXi5T2DgeG2s+IWI/O/gnJNzHrBZrwaFTtuNNc1i1x77QAONN8ofL2VfRRjwwtaO0VENu8znp5RJZIFFbl3Fbq2ackD9U5qJCUwulvAmFBi+uka8QoBAdAZLNvNwf6nUyFStdFi8h5aoSIrD9kP/d8PDk9eEwM/Rx1N/l+YdgtVBauVo9ZOPEw60+slykATaivJQtznIM8VpgToOn8rASaO3uRGQhERc2huQKNkySjfD4iE0VPGb4P5KrmgtA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd423aa-7062-4237-b235-08d871101a31
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:04.7724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJISex3jgLi8QEa1NpALLUYMU6SjAANZSMo9l4obqoo1r5NYUE9ko6HFq9WuKXTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.103; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:14
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

This new operation is used in the next commit, which concatenates two
fuzzer-generated inputs. With this operation, we can prevent the second
input from clobbering the PCI configuration performed by the first.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/general_fuzz.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 0fd42a16da..11346e229a 100644
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
 
@@ -481,7 +483,7 @@ static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
         uint8_t base;
         uint8_t offset;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -511,7 +513,7 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
         uint8_t offset;
         uint32_t value;
     } a;
-    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
+    if (len < sizeof(a) || fuzzable_pci_devices->len == 0 || pci_disabled) {
         return;
     }
     memcpy(&a, data, sizeof(a));
@@ -566,6 +568,11 @@ static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
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
@@ -620,6 +627,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         [OP_WRITE]              = op_write,
         [OP_PCI_READ]           = op_pci_read,
         [OP_PCI_WRITE]          = op_pci_write,
+        [OP_DISABLE_PCI]        = op_disable_pci,
         [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
         [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
         [OP_CLOCK_STEP]         = op_clock_step,
@@ -652,6 +660,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         }
 
         op_clear_dma_patterns(s, NULL, 0);
+        pci_disabled = false;
 
         while (cmd && Size) {
             /* Get the length until the next command or end of input */
-- 
2.28.0


