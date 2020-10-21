Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E13C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51232098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="VgK9fv9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51232098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2s2-0007Fm-1l
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cm-00025V-1O
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:09:08 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2ck-0004s9-Bx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXOnZ8hh69Ivvgy11dMOFMnAGCW87nv4Xe5b46ITcJ6sKcOoz54sKKMEoUWtasRmFvre+skJec6+0eFj5j8d98Tz+jIiHrytdXwozNYnjvXuJspGi/HiXAsLsMjVrsL/1ZeOC2sDmY+yZIobyq5gs0vU+C7dS7DAQcZzbbajDOrOI+YD4H72VnCHreJgeXa/7mu+4put+R8SEuHmQSSVlicrl3bKdrQas/C1NaOIKskb8e/Q6v1BU8NcvzeaDLcqy8jZvgFScUAVfZJ9I9h+T3LyOpG5Llj6QQZb1fNKVG7dCFDXwx3a85hrV3s3iz8zOXbfCXZ2c+wWqaPgxRFavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI7IdsneBURJqy0L2kkLiK29fqZpK9/o2tf77wJ0uvM=;
 b=B6pSdDm7Kb5TiMdcMRj+gatgr8EIVPWYaoRzmk9rLGCYO7p/6i/3lKxP564qeR+Zam/0VQVRcmATT0CL8n/EojZkbUqR1oSi57qKaXxOTvjVHCL1KSKhm5NcWxjXf5II5pcxuxKC5jLIi6kZT8ciSoF89dEmWc/dYPwXxnoY7fP4Ghdyf7YSHynd9vNLbZxophjfXWD6jMqB2n48wJwROOH9y1mXzvMetEYncrOnB931TeSSlzwBQ7zghL9oIv2El3g8z8VhgVx2Cvit1pWOd1kYQ0y0jr2uXI3gmWnlhj5grO68Z6UntQP0Fh6TrYknQT3HfRya/8uCZb3jCa5PXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI7IdsneBURJqy0L2kkLiK29fqZpK9/o2tf77wJ0uvM=;
 b=VgK9fv9iKiIXjQoRod8acXoaAHfFOd+lfYCPbBumtcDYqCGTrUR1jeiZ0qDQLfZw6KtnqG+LHdt6EDQOKbWMGcsnQZurKYf7Mwqj69P6eJf1e7czlBExaoOIHkfHCTErRVENUnE+Fe74p27Z+oATHhIpwdR4YG1UVJmkzrl/3Hc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:27 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:27 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/16] fuzz: register predefined general-fuzz configs
Date: Tue, 20 Oct 2020 21:07:51 -0400
Message-Id: <20201021010752.973230-16-alxndr@bu.edu>
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
 Transport; Wed, 21 Oct 2020 01:08:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a433a283-84e4-47e9-4420-08d8755dd0bb
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2333791E2B4284CAAD0427D5BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipC1GX47xNiCSWpq6OrqdCQWVqvMHLv1BpiTsmkp7zrhy0LrXEKxm5dPZ8i8BMsWM4UUv7Wk5mqo484yh74EyhnOxl5+TyKxnkFPJh3dzqmC8LkEHptrckMl4ygN6UtEeA0P0wLatsD/K0Sll1bQqUMK06MpUlRzQIDcoUz3Y5FRi6+D8cMEt+zfILVkSfzP919MERTan+1SP0SG1Nw0aEL6ApCcani3IdsRrBbJB0HJeVA6WS28szPbcvesp713OGh8Awu5HmwFKbMIiqgVQ+sFBfDZ8Ox3JETUSZe3A9XCvtuoysRlmE90aPvAfYX9uPNi95lj+EjB083XN0rUUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8ff+x66lPEmLZuf1t8+T4x4jRh4K9I2db/Lz1K/FCrgqvGnSQPm8/0TtjbaXS3W96wWumPcyOxmOvfSEBo0rIXiTR7yX6l9GsG8RNs3dQOqMZTdp6qwcZ+s2kGnErwiLW999VvCN6KW4YRMrv7kg6cy6/lu4Jp+EJ9JVvTa4U6qsiyZ1lddLkF/kgG2ZAaWnR7edM8HnXWr5qiAelzOIiwu2bgprpRHPFhntC7vrcaJCvzhQ2bIPatobWXKEfoVEzGTEmrzd+ld0hkiQLyCOawzwbNMlDMTd/Nqlejk849GiUdBuOvEs9yzXzbUfN9txenteQ09OVUosjxPOYn4uOB/q0nMgfOkEx58G0EqAohq7RMk5gjnn/BVjW9UxrVjm5BcUiTia4nCACiL3a95EXBV2HdIc+5DbOJ5LEP8cDFPBDuK1xvYkSDFyAdZf/VpLH0U/zBweeRSkBa+f+QB8X5K3ECW7GPNCuK55nEbajXJFqa8z5/pycR6ydXBI9tdejWyMMp24TGD+yM1ZLyhHiFuLmovZtZKHiVgFet2jqu08972+Rmu5KfbLnpCNkifafw7FSTdc/7yNF7ZUml90Rk84OeEAdZlaq/r+vtd5LSmXnjQTuniekkbRS/JNBL+EOXvctiDbb17MW47rLf6XJg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a433a283-84e4-47e9-4420-08d8755dd0bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:27.1774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM1m9ZsEt9PMWkiVDfnx/LLzuVbE4OkNK771SdUPP3VPAJ7zzIl3C82l6sZfvCXO
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

We call get_general_fuzz_configs, which fills an array with
predefined {name, args, objects} triples. For each of these, we add a
new FuzzTarget, that uses a small wrapper to set
QEMU_FUZZ_{ARGS,OBJECTS} to the corresponding predefined values.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 356d171c65..d159d64d8b 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
+#include "generic_fuzz_configs.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -901,6 +902,17 @@ static GString *generic_fuzz_cmdline(FuzzTarget *t)
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
@@ -911,6 +923,26 @@ static void register_generic_fuzz_targets(void)
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


