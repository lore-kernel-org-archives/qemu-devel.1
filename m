Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A57BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4722063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="aSaFU05X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4722063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HMR-0000Fs-CF
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK9-0003sx-3I
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:49 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK7-0001Ya-GG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STFLwxSCC7jU4N6SxMTfiONR5VCGlkF8/vimXVVnhZ8/KuP29tqNOgwoL0PQf5z7bl3ffHHxQMJFtzlUz1C84U2O9UaRekGqF8HbLlMduhCijxQs52OmuJJt7CiyseeuVAfobJoI7Wbbvr1a3T7KzCxX+IrCy82W5fD+HYEaUwcuqy9n+70bKvLi3VZynmwxF1BL/UCtB3vpS+R5ton5rj55y+UydqGhO8/KO/SnkleR0m5C7PsTHUJvERukjO/z5bh1mKGAIVHyQxMpbrLbgrJU1IUzMxogR+MP+tXxFuunyt5GBWZ2SBvDp5tIalllyE+yxppxsMIlPccgtYzkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shbs9bBBvDEA9c2zzdAfxfgdSWSdqEYR0KGwIBv8/1I=;
 b=Vw9vBtw2n5yY8HBKdwRtREo/v8yRVmgDlles23wmuoywuMBxicbPXQoWgCG/8ZQwAGiPun1Zld905O9yR7g1zHDbIOPfdjL8Ap2Z+wfEPJvTV1/QKZjvuubgyDjM6F0QHj51fNSzAJuNpwsfmHWj6ZFgulCAYE54NhHkKEZIoWbK19r44Bk6XCOKNrJsdFcPhe5/PWYnmAsGqTfZYamXf07VjHgpM02sJf5bzJTy3O0apRDWsLm8xwtvtwh6rEKp0ToZQRJ8Dn73GH/c6MPlwNnilTnq3G/XyIGdbno/MOupSPZiKsuY6V+Gd86wZThsCsqO0LG360N1jlyd3LXoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shbs9bBBvDEA9c2zzdAfxfgdSWSdqEYR0KGwIBv8/1I=;
 b=aSaFU05XxxpJxIfV+Jo1TauzI7cvenXM9j6lRsqlKk4ABug+AgFWzMKVtSda6jn258zRnK4i6tUy0dIw0zWEuD+J9v2wvdHM/Awxq21K/N3fzC9L0MwJ3alwy240MvgXT4be+hLs97xpcP8eAXEazgFccNCh4Z2AromQiNwUojM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:43 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/15] fuzz: add a crossover function to generic-fuzzer
Date: Wed, 19 Aug 2020 02:11:04 -0400
Message-Id: <20200819061110.1320568-10-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:42 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61614652-3003-4ab9-5082-08d84406bea6
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB34865B31C60C7241A81ED15CBA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WqN0dvHh+9yktpTAtJEhAAZTAwZLG3RnWYxQZolYFz4P9iYMMPyIoUrxaHiDRgaBu/wSRTfA/WnjxaTMrCd7dxNlu2HKM2g0UzZEu7I5s/jTaGalgUFXxMAnrweQwQJq5Hv3Mh7gx3nZP2p0u6wNuRU6xhQ92Ga1W7MkeP+x5hce+vHIdErnNWOggudidp/Bmt7cgO7M5UGq+4DbS+CkYUek1f+6s70HUtx6Y8C+WFDLhFHsl/eRtG5L/a9VvThCLgB/DGmHQdnEWkqXH9DYS3gHP1xKu0EzWuuQ/nVU/ki8rc5HooUnyFXtjylrBEpL+y2C5Vpo6y4LbJ7oCMThllFJY1oYkt39omxCvtu0fbXHyfVtESbWi78tVXKRtFk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(83380400001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1IVb0uYgtty0xFuD47daUM0ZVPxVbIt5R4c0BsXm94y9yZMgVCPxrZTYsKu6UfFBuoNiDyRJNlpVdqFvYMm0GYZ7BIZ6Z7TvY5MlKrCfbozAs1LTDx1XlLx6dCRhNi6rLJsrcwg8RPB4KVN9V6cS8ja2A6b/vqw2WHmzpk0Oj+/zOly+j73Wofqe/sbANMwumwtuDvMfkEA6RhUmkxRFtaz/o9pzBpDALSRT96fO4e2sS9UeV9jef8+7m3AcaHa9oLJIPhjOhXvInRgvUHW2hjdel9x6S+iwJXjEy7e0QtZ6x1bJ1YqVRqdI3Eo7SvPIyMQ919mDUHECVN+VCCQijhkyvOKtQlp/YsH2PbEL08YAYJSCAGYTietYZaXWoNBeLQjLMe46DQo7Tc3DzE8ils3iSSGM7VOM4aZQKjpa4x8UOlK0+LKiJMkC9s1jCgw+PaqSrSsgAmFX/nmB0IEXJcpPX2KAZ4+kZ//dubQ1Ex+O0uxWAtQeHNB8MZIUwlLiFGxho3d5D2l+xBTpAxwa1OwjQXbH37JRihw6iICMDlhxMHwRmfkG0BUdLhqHylSBe+Cn4zIdvNiilUJ5Gx3tzv9U09ucvVtV/0elkmwC3puPpWhUqACMHjClmFPzedHYGeb+6h3B4JVdwOpgQn9Ynw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 61614652-3003-4ab9-5082-08d84406bea6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:43.4117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJpppulYxO1hNxAmQvFSTYqkf0A/gKHxw2xrqZ5Lu3XDY3kA89vqk7nLHtdSQdQv
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 81 ++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 26fcd69e45..2c3716f8cc 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -739,6 +739,83 @@ static void general_pre_fuzz(QTestState *s)
 
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
+    size_t copy = 0, size = 0;
+
+    // Copy in the first input
+    copy = MIN(size1, max_out_size);
+    memcpy(out+size, data1, copy);
+    size+= copy;
+    max_out_size-= copy;
+
+    // Append a separator
+    copy = MIN(strlen(SEPARATOR), max_out_size);
+    memcpy(out+size, SEPARATOR, copy);
+    size+= copy;
+    max_out_size-= copy;
+
+    // Clear out the
+    copy = MIN(1, max_out_size);
+    if (copy) {
+        out[size] = OP_CLEAR_DMA_PATTERNS;
+    }
+    size+= copy;
+    max_out_size-= copy;
+
+    copy = MIN(strlen(SEPARATOR), max_out_size);
+    memcpy(out+size, SEPARATOR, copy);
+    size+= copy;
+    max_out_size-= copy;
+
+    copy = MIN(1, max_out_size);
+    if (copy) {
+        out[size] = OP_DISABLE_PCI;
+    }
+    size+= copy;
+    max_out_size-= copy;
+
+    copy = MIN(strlen(SEPARATOR), max_out_size);
+    memcpy(out+size, SEPARATOR, copy);
+    size+= copy;
+    max_out_size-= copy;
+
+    copy = MIN(size2, max_out_size);
+    memcpy(out+size, data2, copy);
+    size+= copy;
+    max_out_size-= copy;
+
+    return  size;
+}
+
+
 static GString *general_fuzz_cmdline(FuzzTarget *t)
 {
     GString *cmd_line = g_string_new(TARGET_NAME);
@@ -758,7 +835,9 @@ static void register_general_fuzz_targets(void)
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
2.27.0


