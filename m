Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5EC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F630223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="CVVdag/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F630223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLl7-0001Xy-UR
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMu-0003l3-IR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:00 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com
 ([40.107.69.122]:45277 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMs-00083h-UG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpEY+n3e4uZMayXN6vTaqiOAXUIRPWc2rCC51VPVW3Xyz5ODiV+U+9WzXagBxu6q+VMQgk/19/u76r5yncHe4JXiU/6dt5mlmMytbkj3kLICT/7R75dq7qWIO/veSP1GMr+KU+0V5aAKCBxZEjctupscKm4dXBMJlDBTLc2U8dMojeIGT73bAwrr50X35UKIz7fnfmeqcXprZ55Q7dLXOm4bxfYIl6CtN3JH/zGuyy9Clhhsb68ZIWP1m6xDL9ZCHKWK1EocyKyW6puYa/N9Uc+WAL8q4t0YPCXBh45euwvbUZCvV2HoAy/LVnK1h4UxetQKS6cNQQ1cGx+5+wHvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prR2VcJPy11g1lYvJvOtXdyDVCI7aeQhomYO0r2COKg=;
 b=jaHOGs0IvpRVOhnsonX4/stfTmn3fWWwtYNmh5o4SgaZVgT2+zeb3x/hjjGgPvep2yMlADN7Hm+wmxyJpmKz5EERC+KD0kdTkzK4asOzxl9BrR+JWZPyNl7NzIUne/1pXiZWmk5seHYgrRJ4dhukcFhg+UAKuiUKXVU4WbNWUVkkEnT3gj5ngObYNSKJOQhTbtmPQUvZ/mPE1pfWIEKwLZHA6abLuJrR20s9ZpGLgIvOcpLbJFmd1oV6PiQisR8GgMfD7ajCQPYod6gwM0APbaskW7RqaME/ryfFsrcyRnsWaNNEKmlIC1cE0IFJ4+nde1HPZEf6e42tjw9DoL4BgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prR2VcJPy11g1lYvJvOtXdyDVCI7aeQhomYO0r2COKg=;
 b=CVVdag/3j/JPE4Jz6uI3xrO8Nx+OKTpl5z1ukDEjJ9Uya3aym5pFXoUJevFbqxeY+6hjsBG7L22Q7RM4BrCh+h80F2YKlhsO9IUx5Rw4+zVi17SHQXi6kR9d2YprSnhjgVt2iT5xuQtE0pIF/4moWhOEtmFE/AgczYbNh76OMd8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:47 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:47 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/16] fuzz: add a DISABLE_PCI op to generic-fuzzer
Date: Wed, 21 Oct 2020 17:09:14 -0400
Message-Id: <20201021210922.572955-9-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021210922.572955-1-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c75b4bb-ade2-43e6-52a8-08d87605a39a
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045983FFFE1F329C9230E29BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7wqPmi75V6yDXEEUfVK7MgpMrO+XLiBG5ALhnIk2i+JZaE+G+Uj+BtoQ9r/qkb57mDbKitZhVu3Q+88kFQdquiam6GcHUq3kudEojWX2Qt9dI9J4NkKTyw0qfdnLPjY0o3X8Jir/l1voDFcH5gk0iDXy5msECBBHE+pOgqSkA47TAGj1R9DaOgEiVyMAwMHlAVki7MDKXwCjLgTd0/kQG+fFODF3RBD36DCO2ig17v46dhMbzvhH0cgke9C+Tnt2m065MbfA3kt5ytJAAaZC41tTqMurZ1dFxGHkRC1iSREssa4ogwaXvZgmLJP8RsU+Pj6MRXzu0fD2LrPNhizczR9qo+SAg43OE2AwItwd6Mt3yZQQGgB/f6PZ9QJ8yY3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fT5wo5Iu3fPBfZg3CGKqmNS79BqcXPd2VqfkjusnhduEeAt4rGkcstUxAjnQZAyE7zkt/J6/nBkGvy59RzBfM4rt5MUwDgQDWPHguUJHnNIrZnuXwo7FVH9U37ytfCOT+MGmHX5Eg3zGVt+0ZyhuMWdIteuww35LTVauQPQW9AcTPTu8qURmvmkd+R0TGgEliBEJFrYfZvblLojhmNz+z56rHcngomgz0r7NOFjY5+ynmxYMaIMEp1vTDs2qbydk2iUeNEN0zKWkaWpRGQXFnPEHSmUZ6T4GiVpw2rVZCiAOwsAPAWpFEkHsf7S3ICKjcOBjITvHg8+ni/bF+Q5Wn/pRI6OMP5MC5sQ3W0cftii4LlIp69J9lcRQl6V4mjb5AEgAhU2Zqag9fV8fVrbvEXuXDdjuhJoBDShoAbRs2CqXk7+iWKEBERyU+3VRtBYUMd1kYSjqiKorUTgivRteDEO4aWjRwxLVwq5o3TIZm7w9yDHsGXE0tGZTCyCO6153qQWob6qB8RzIY8rAgmo2ZTPCh5NHXB5fx/iS1ULiRv7n4BSvBa7fRW/dR2l+OTAcwXyfEWhTz1z7pK0h9XR+fF8MyQ8Uyg1eahNt6t0m1stojQfblhuJJNiwO9Rj+QrsVM6/LzyhwOWcCff/0Qis5g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c75b4bb-ade2-43e6-52a8-08d87605a39a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:46.7057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DncB3zMIy1QjscC4l433gkH0n6uV24no+M4vs5xMI88pNWedqAAuIOoNiRFOEF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.122; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
index e356873ae0..fb8bf4a112 100644
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


