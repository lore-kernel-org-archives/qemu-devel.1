Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C0C20770
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="scRYE2Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C0C20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyrL-00016S-Uc
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg6-00042Q-1e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:26 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com
 ([40.107.92.131]:42497 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg3-0007Ao-13
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXBZ/cCcApQGW0G25fCV+FA6obCW1fs+AYU68EdyWJ595TGSDCsyKprPy97bimMOHRvZnZ4siiRjNb+O4bnb1B5MUjxtYU4GN202WJfzb0PIJcfo1TTyT/M031sfWej8mIkOVXS8h6ELSekekGRLquVeReqwUp5tfNz9cgw11a8OvKQ2iluuRM/PhVXjjIt9AN+8yF8WvSjnOBP140PmfEJyeb7WRF+oq2nJRofgYBwxrwZSYq+mOog8KqEjig2wJiMA6r9KdE1tAhaEyC5E1R/4zfyNtC7cXyWEwyprswAppNTeb+OOeQ4C34n4fpzDCdg9Ysy6nflIEiMxL5d2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tINxldT4C0l9E8W7lCTauA7MwQ6SKdH6F6ASy+HY2BM=;
 b=b3wvMedxT0Vn9f7rtmcNZRQk83+CIjDlcjtqB8aTZFItCx7yAlLegd2LogtHTNwtQqN5Xv3rZLYdRmrRpIsHxUnpAj0+yVKkDqef+rkBbmunwQQAMnH8OkyGX7sbAJNMycnXaaPDO1mZEcX8/FHzimZiLi7eEGA+jWv1MjaVfF0Clxkr9vMfPzw0gph/hF48GmTH3/ZpfnfcUizLEJTXKQr6eGKO895f2deiUYCeuySVJQEJKzfp6ixWZ+ZJBJ1uB66chttQGfLZBqcZN7SMvqvz1q1SnnudyDTnIXV0p7yM4kmwU65Dv7dsaunvK4wqyw7ILG3iaOCxRiUkyWq17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tINxldT4C0l9E8W7lCTauA7MwQ6SKdH6F6ASy+HY2BM=;
 b=scRYE2Xm0u0oriYWmKLKslN8+SkZ7Yhb9xzhBNRcr5V/naRpZyrcP1lsTjXRR5QnLOEXb7RofHsNhfcoWfiQ7lOu6iL6VpH9wEQj6n57BEc3Jv0mkCiTy1U6mxDOtbt1Rul58NERKyf5oPLvVlP5MscRnGLoq7FbIltwtabbOXA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:17 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:17 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/17] fuzz: register predefined generic-fuzz configs
Date: Fri, 23 Oct 2020 11:07:44 -0400
Message-Id: <20201023150746.107063-16-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ddf5275-fb4f-456c-3a61-08d8776578b9
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5516E8D90F5B3658DA463620BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ELhuNHd7qDSmpeS3FJbDUSvIkXCLX6JSHsMlKoTPDap/FtvjghsIwdaJexi1KsPAOcp27S0wC21sspEi7HHrOUKu1MoTSlbwpp4IPRKl+v2Paww3MgAVucOeBWe6vyLHQ+s3gtMoPqp2T2IYt0Yk1e4xJ0Pe0yhTwKeANBZakYvykKdEhFg+X6/vD9fuuKEKDu7JCMMZu8O4iU2NamGatazaMe6LlJ1yjKaYradTqkmoPJvibi1jgBm3wrTZqktxf76VgVt6U4JSZlYb8VursyOHONtrIkHNATM5ivuBndXi1hOAOkTroyDlToePL6a7KgDeCkeVB5NOpbAazRUMzs8+07MzAbweg4hbLK/HQ+r5igY+OanFVvMAiHhemtl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(54906003)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GIKKG61hSvRpq/LIckinDmPf4x9wuKCbzRrI6VUIrBFg9pF9pg2Va1kBsNaAYHV/wi7OeyYE70UcmOzP+gvA0gxU8bVIlY3bOmlNnx7JmZX8gGtko6VSz4ZlNiT1l6KoleQjE2wX/lDR31h4fCM7bl9804d006GdeHee4E5/7wUU8iMyZh+OEL8J78/ZOI41dCbgo1mCg/Ac1tWwV0NBLfkmNLEBi7FmrU5NJ6Avt5Q1rnXsOQ/PJN4bb33kOsuP91Tuokb4F278ejbXkngv9DRhr0piJTuBOMwYWxwVLWBqJqFW//HJAL58dFqRyI8p/rIQthPB2cabhl5BpGbQslKRNQyeiGYQSh6XMhBQo8tEN+HnI3wZXXU4X/CrPzRTD7rMC5nj7e955K9uQOBklaX64EmutZE332EzcSx1sdukbDEozUD9uiFQtzf066mGLB6xIm+5c8BjQRuOHfAYC0+5r+DIevEPcBOwJMl/5MYXk68oupdGAL8xwWDqJiJ+yqmNZ2fKzwfNlUQGq2smqzr3/9fgLnFKpSxMjDVLspS5KxMiTdG1o2XI5Y7nG6P4k+ejHWDy8M/lD81MkaSrNghoumFFP+V+IX6g81k4+R+v/Y47655zReEPkPRBf+2C9M4l+uYeqgfZa5tz5CVRPg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddf5275-fb4f-456c-3a61-08d8776578b9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:17.5261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVKTQl6yOdlTc9s1y7qnQH4WsASY8qiGMbyMaLrtb/nNhblK+aaRtK7udS6xF1Jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.131; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:19
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

We call get_generic_fuzz_configs, which fills an array with
predefined {name, args, objects} triples. For each of these, we add a
new FuzzTarget, that uses a small wrapper to set
QEMU_FUZZ_{ARGS,OBJECTS} to the corresponding predefined values.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 1a1bb7b9db..96d78fa5c6 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
+#include "generic_fuzz_configs.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -905,6 +906,17 @@ static GString *generic_fuzz_cmdline(FuzzTarget *t)
     return cmd_line;
 }
 
+static GString *generic_fuzz_predefined_config_cmdline(FuzzTarget *t)
+{
+    const generic_fuzz_config *config;
+    g_assert(t->opaque);
+
+    config = t->opaque;
+    setenv("QEMU_FUZZ_ARGS", config->args, 1);
+    setenv("QEMU_FUZZ_OBJECTS", config->objects, 1);
+    return generic_fuzz_cmdline(t);
+}
+
 static void register_generic_fuzz_targets(void)
 {
     fuzz_add_target(&(FuzzTarget){
@@ -915,6 +927,26 @@ static void register_generic_fuzz_targets(void)
             .fuzz = generic_fuzz,
             .crossover = generic_fuzz_crossover
     });
+
+    GString *name;
+    const generic_fuzz_config *config;
+
+    for (int i = 0;
+         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
+         i++) {
+        config = predefined_configs + i;
+        name = g_string_new("generic-fuzz");
+        g_string_append_printf(name, "-%s", config->name);
+        fuzz_add_target(&(FuzzTarget){
+                .name = name->str,
+                .description = "Predefined generic-fuzz config.",
+                .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
+                .pre_fuzz = generic_pre_fuzz,
+                .fuzz = generic_fuzz,
+                .crossover = generic_fuzz_crossover,
+                .opaque = (void *)config
+        });
+    }
 }
 
 fuzz_target_init(register_generic_fuzz_targets);
-- 
2.28.0


