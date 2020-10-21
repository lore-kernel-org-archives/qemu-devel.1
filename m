Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE66C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B43221F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="eQhtttzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B43221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLfI-00049c-MZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMx-0003pI-3x
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:03 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:59894 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMu-000854-8e
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Yx/slHYmxJjh/E92w+Hs3DXjCQ9fbD4aypOZUdxE1Ag7UEvJc1IgBOSCB2/GD57w8dsyxB9rZ9oSWYQh+VcAWFpJC1dsP6Wp4waZVVmsYKdQIN1hBc3EXWENd3NIQ4luuZXmGGDstxxA8ilXxDIms6GreHEyB6UzALkweSsvfxZHXfoJbrt6BrSilXyne3jC6fqeLhoT3Uanfsl3wGutWh2LjMR4tlTpe8xQG6cY2I3/n9F98JDMyeNrUBAY4vmQy9XNsNBdS2qQlZm3qbFUTq5YYtmIb4AdZQlmdpmVyvrI+31yzeMb7Ztkns35t1vf3LXbNssyGPVpJ7KGdaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxNMWGYIFb0Nkl764JduutpjvICbdzPu7mim2ONy+NA=;
 b=DGpha6KM4U9yvxZu5ohhXA0MKdF60Mf2pGWohgRwZBd1tDCVs0FyCX1oG1y1/yBnSLCf6u+dQ4aSRHiBAM3FTUOrJP90GEHMSpzmIO4F5I7nRj1maOIWLnywLhsys0txf+oSzvbb2kSthNNn6iGLbvNz86jdXm8mauwFlAq1sTZ/yLU25g9vAPl9ioAj85cn/81BxUhC9c8S5iUFiue2wb7jw/3Ko2TdOWGfIqVV1j6a8w5MhEr7NP32zobEFEHKITPR9PH87cY6ACtRXKUAnWnN7kUpaQdJNoiBGFtWo4HcVQn6ls8L9a6JMm7OAszv7c3MuqFtE0g3E50MIf3peA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxNMWGYIFb0Nkl764JduutpjvICbdzPu7mim2ONy+NA=;
 b=eQhtttzxhuKy3QsgOgOa9CzfkB5KYR8UuxwKqCx8U68bCmuwc308f6BQl1Z8UPSEQPyUvT2M9UCaqeRWSLUGs+BYVp3ZCu4RyY8dpiSDsIyp7GdKWgQdv3w4G9Y/zAYQqJmiI6vpn2TYsmtQiyq/81eU5WhzIPSnE/RnqMC9VKw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:48 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:48 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/16] fuzz: add a crossover function to generic-fuzzer
Date: Wed, 21 Oct 2020 17:09:15 -0400
Message-Id: <20201021210922.572955-10-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e73c19-5741-4296-8f8d-08d87605a459
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045CFD416190F6B69E56C47BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAs9+5bXW0e8u+9QDDGMBwboX4a6oACTmEMtE5q/5ORi7XYyAlwmzO3/cTnOvW24CffFKC5SDH/BGe781RRWtg8U9FJ5IkjiPTxHuVwZuiaFheZYrWAqCIzFNkDZFgFsAMmZATj7/sK8qeKa7YPtSm6U1QNRVO6ALj7GR2oj+ox5Y+/A7G834hTOPwbYFXAkbAQD+7yWbvFh3crcga42sC35a5i3vG6wcxbn5HeATU7437i5CX2BPlwMUAcdEHJtYLxStCzoHfFxTkB2op4qLctuCiFfMEuZjrjYo/RggiIRK2K1P4wIcY+NiCx/DeplZo1ZhD8tsepcwoxzq2hAkxzGGORv6l0o61XNSxUWOr7KDc1MVfDzdg224IRb4I/8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Km1xa3pjfHPIBP+ndJhpvSD79qNTrlz55y1/CSDmk2NeUAhEIYOr1U7R8Q4Cx8u3KHTU90bQavUV9xtV+ygI9f8Dy1NMvR7AGk3AZAawCh7GXLZM191Dkhjac+g9ej2SqnJNSCw8KmE/Id4mz56KeMo/V+7uBRGYz2E8rVTkjkP+/4yltrXvI6h1Q8xjlXsszuZ4j+jo+x85VwNVq/xd+BM8ED9yKtUzMsK/D2PJ2dK93aTQvXhvQdjd1G/mJT3T7WEZfizPc3RH82gLKpqtAuI+badJ3WBu47dgE8nuA8bkXxCFqZrNjkrlOKRR1cGuqOTvjAnMtdfurK3DnFCd6WcT9nbPRuBsVjew1z1/826mClT7crCGlmLGzJOgqRcmBY8vxjyHO7mdJ9yxwfJan+5BKtU11+orM4Tdba875SjWkBY5O6Yp6VRlQkNkbPIvRZQeknxLiK/y/CRFGROswBqeyDEHlkh+uk82XLI1zFkT8Kml3K6NsqXbPbJUW4C77Tde4gVKua5P+nMmT2HRTBYNaS5lX+n2WhgagBGKy0s1HKU7azuSq1FSWsz/WhgM1spKtLlyMKDvnIt6+Bna7W7qQrUodwCXb/pN7PwBdrsvtINds8lEOQtKmCD2h/ldSHdGm4ZZ0stiejZ+0FMTVQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e73c19-5741-4296-8f8d-08d87605a459
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:47.9150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 906lw8pPGDIwb4QGGiVE6Lyq7aKpYiMi/VEv7+LWjyNjy/iUgcApzWxsDPJCVWSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.121; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
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
 tests/qtest/fuzz/generic_fuzz.c | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index fb8bf4a112..f739937827 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -804,6 +804,91 @@ static void generic_pre_fuzz(QTestState *s)
     counter_shm_init();
 }
 
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
+static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
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
 static GString *generic_fuzz_cmdline(FuzzTarget *t)
 {
     GString *cmd_line = g_string_new(TARGET_NAME);
@@ -824,6 +909,7 @@ static void register_generic_fuzz_targets(void)
             .get_init_cmdline = generic_fuzz_cmdline,
             .pre_fuzz = generic_pre_fuzz,
             .fuzz = generic_fuzz,
+            .crossover = generic_fuzz_crossover
     });
 }
 
-- 
2.28.0


