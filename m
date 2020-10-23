Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED7AC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DC8208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="dvb0P9K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC8208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyih-0006pq-GQ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfv-0003hj-Qh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:15 -0400
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com
 ([40.107.92.90]:50400 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyft-000767-W0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsCV2zx/xZglNVWyhrxuxwP/2OVue+VUfvzTSb20zKzEVpttlLSPpSMi/LuEz1dnWAc8e50vNQ4wg2LSpxdpk7o/u/YRpNKWL3jwsuMXGWNxRSiRVbxnIpO52gFCcs02S9Rs9ZcvsXyENZFjTsTXOlBTP4numOA90mmjP+JnOMP80+DoOTqplKB27Ez7QYdbLYuAPB50NicnrcTU0WJzizWphKZstu/PJcJHQHEifTcsbBdXaw40t/+QYFB3XaAlKvx9yXNuMnE0sSKIAZOyyk8g3tchNjQgDGPKq4VsH/0BDCqqATW/L6qui2XLxdGVulCae1fkGrDj//TdhbPR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijboq53E0ffl27ylMXmPDv3YcQtx1rxw+6EHMhfq77o=;
 b=l6ZQeBPXavvCz4OQcO4v7AeV861FpnVoD6ClxJpJJZzMTodkJ9XaUpFFuO82d2z8c+anINsPctJX9050sQOVSaoMGZajBuqlxgmoCsufdxjrU2N3icsuxJbsZLM9ebWGho9qgN2oxpQg/mrG+6u9UK27O8LvUJJOKvn+xeber5hT8rEM7+nEzQ+zUchtfB2bqQL/FBp3XMQ4h/V0Yxd2lNI3Iu8bMKdd4RXqrdzZtfzJ/fH2EflRx3Xq+y2iXH09tY/WZw4XiC3Qa8EkSduDln05iumFDEPpk8tUhDVXxBMUzotIVMCW1Q98vhd2EyUk8KfbGZ+ZQkvQVey+C1Rcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijboq53E0ffl27ylMXmPDv3YcQtx1rxw+6EHMhfq77o=;
 b=dvb0P9K1dcfQl5gksmOOZa9vPuMAvWapkTynT4qiUKXqP/A51eQ++LcBaVeL0zy6BVauHRF84josoASCjxmf1xPkh+xIXk0crC6PYwMJQZmMvS5MII5oV9RFhkjQoMhMJyreY4ndXxxJGT34YJaq/59qS+e77rTnF1NHswmUkyw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:09 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:09 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/17] fuzz: add a crossover function to generic-fuzzer
Date: Fri, 23 Oct 2020 11:07:38 -0400
Message-Id: <20201023150746.107063-10-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d6d8ebb-49e4-4507-af3b-08d8776573da
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5516420B6B9DE89CC5CCF92ABA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roIVUzaBXAoZYTdNH5sV6PCe30Bj/sFx0KGGeKMrILI+5gTFCrej3CIxW91mekl4EX/0vJGiUmfSXf7FuHKgfF9amxGi2AMD/CRYP914Suzyzrjsyucq6EsKwWc6NKfcy/K6NLoyaBbF7AIDDVyLKNg9a6FHsBFR6OIxIJeVdgDActOE611/TS40oQTE8NeRVMz9a0j2DcspYoyHOsM+mTawSgM/5iIMNDz0tfp0+jpgFww+pBl3eHt/PXgyAQt+eoLe7R5Asqjyv3b+o7uhPx//8pqCYzYfnVdnvCNvLZNZjH7R/f9BQJT1/ucwRwRo9MP8ZgOfpoRuLAadDOr2OU6H4qWuGtzIrPS5feM3lbizYJdgv2RsvNhE5TzgjVWH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(54906003)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2InbQFbC0Wn85E3cd9BbSDEMFe6ATJgbXI0gOAyhqyEHnRWSJiwYeNXOvHHkgHK/e1gTPAif4dZgON50hTSaa1I5RVsM0EVqhG3GOHIkFWyVGR5C0kJjOiPDfW+8uhdJKYGuhyGi1uqiC7EB0gngRVrV2qjF5+WIo8TxoYQet8WXzD3tmvTXSFvyJjHqxM/WVMne3dxAYK6MPMcG6fJZgjIMvJKh6jpqa+W8KG/yoExTTTWYbBGpgDj5jWy9PQCiaJobO8fo9WEHsDbg6ddVa3UysS+jIRSmpjhuMozgA1RB5/vSQxwdo5xhIkA+E8e8NR5LwvZ1aW7rZ4eEQH0B9RZhSmawYOzYEC2C6wQL7rB0F4uJhdY5/FZ8Qwh6wWwgV6SI4ClaveOgj6uNcWEfkOHig/xskGx9OMduIHUnkmhUXrjsUU8TLdhIc16a1QPQvJckoBejj5Dub543w6jPOAwxbZzmcCJaZSivTS9aRTqDM9zuCAqVqVa38fnyptxXWKnbSUyG6lhSDhxyLrnE+Plt9cp1t7r0KC30q0m1PZpOA9nZiNuZhDOjN1kK3sDonTzIFWfds9t5EUT4V6dNIXtCpvlbnExw9GbD9zt0KEiW2jWki9X7Tbh4Ksz1xC4//PODCklGqtlBGP2AHnhPbw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6d8ebb-49e4-4507-af3b-08d8776573da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:09.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we8PWyPqNLpO5YQlua91lJbRB+dYWOiu9hbAUfZOsAmjojGliBo2qw/HOwyymWPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.90; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
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
index d8fb78d13b..1a1bb7b9db 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -808,6 +808,91 @@ static void generic_pre_fuzz(QTestState *s)
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
@@ -828,6 +913,7 @@ static void register_generic_fuzz_targets(void)
             .get_init_cmdline = generic_fuzz_cmdline,
             .pre_fuzz = generic_pre_fuzz,
             .fuzz = generic_fuzz,
+            .crossover = generic_fuzz_crossover
     });
 }
 
-- 
2.28.0


