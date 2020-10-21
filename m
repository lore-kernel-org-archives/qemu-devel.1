Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F2C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96873221F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="TdQIE7UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96873221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLeu-0003ik-7j
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN5-00040a-UY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:11 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:59894 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN4-000854-7i
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdjdiU38kWGXZ6cHReiR68KH/ApW4UKRz5bQlueRN02/JRidbcV+KQtd++YqimU7ZRdQ9gA9dLKtOTg+Q5XPdmlaGhxj/hDhVfVFTheKJxhxfahlefn6M6/nU1/F6h1axIpe4exrxGPenfnkfmu/4omspxL7MDh6SN9n9p6eFUCXBk8jYS7/aJyk5Gc8KrIiexILi9Rq8Kz00n+0d8vu8s3i92OTMuuGAa12Rq1Lf6RNknlYy8M+RPwLtbDWbG7AR0a7WLd7X7rcIRqisAwJJMH7cKO4hQIXI9wk9RX0nmS4zAaHpGS4AvhtPeYH8orQqFMyhahzZxjmn8GNuL+3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIOJz3HarIqvZwwJqA4Sgru8RgMfbE2D1j371/pyyBM=;
 b=bI0m7mJvqXnoTprLuglLfM0Fr0ek5XRu9M7xH4n4klk1i+uXmR5PegBHtmzN0GydFl0X3OU5TFKfNwYjdV4zlQ3tIhEAzkYLqn58pd6lYjP82uHHwB8DdE1rk8Aa6ViJQT8S5/ZYiNoogY+0F3YiglvNK2agOfdAoCGPImppcyZPnbwrGCcp8pErsiUs1KHoAf/Bu+uqS8SSIkd5Mkl8ui3zTkM9FHh+QTs3NjZT6djx0lpHfMsgtAZNcIUHHwUa34jfqhUvxOywCVTQ+76CCMfaMiKqbHwED3+w7ur9dGt6kcXFs5O3/0opXbg8Ssi/ICEopgmzTvSBVC0g7OAGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIOJz3HarIqvZwwJqA4Sgru8RgMfbE2D1j371/pyyBM=;
 b=TdQIE7UY47B8oRLBon0QYUgVZBd6014kJo4kk81sqNi0k954ngMHcHpisITH3Y9zLFpMAHHT8wg7OYTdsRNnKWS10rOR4MaQ9H2Yqzgy6bdYsOYu1NttUhoLSTLxCA5I7gmo4Idx6lIkZQ0RfjEIC9FtTIctkZ3F7zpXkURIRqQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:58 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:58 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/16] fuzz: register predefined generic-fuzz configs
Date: Wed, 21 Oct 2020 17:09:21 -0400
Message-Id: <20201021210922.572955-16-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a24ca16a-a575-4fcf-56e8-08d87605aa24
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB40456F9A93C9C25130994188BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YSgx9nLZB5sgeffZNimVnfDHO99mV2IV6PvU9MX2i/O/ZTB2aFOWl7PE05UtgOzrXcGKzmIWwDzWkD48dKonZqZ1Ewf2SRBjLdinBK0PJxDmzoTA72EaIT0+rxVuQhe2ga50W6065peLlbBa/KGwxZgxClirU1nBSwiSIB2dIPdkCrZ7HUetm7uOkUEV15lOC6gLFVNl/GyiIf40ECf55opQuAaJNFcVVlIjiQwUav5EiXY/4tPah10qhjbLQBpOIeQ7ce/9Nius0waZjWWkuwryFxG1cKHYJ1jYmB32C8sCEeh3+yhLICyOfu+7HMgFu2siEjFrPe04QfqWybpPk3YsE1noiXtT8r2jYEQAFU7aM05gPLJ86CNOWLp5dfk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9lVa21Y6eDANSFwBZyzwgc17kEkDtU1XoYjlBqo7KKx2JofvOhwboR6o5y8wZ1FiUMpV9xO2HCr52pHIxvM4RKvUsW1evBqYCe1m3BAkmwqYkV4Igrd7dkzinYNxVR/UyYBFLjUL5ZKqsYG5WWRRXnr3f9gHxRdBHnzvotP4ML4Qpc3LnccwAwpER0E4z55BxYuhvzeqBnxNG+HUq8576V6V7OR/ngMzRONNqcyCXqKI2tpOysVePQsJCxS66FyBbL3hljz6UzGX3YqXaLT3R1MtK96w36/Lb8jNQGUgfiuKutlzHqZ+ezjFfiOD29lP9gmnZvcnTc8/pkpF4d8sBUSMOMY0bsEGQnyIbeHEZgINIEg3YSiRxMwupQ6dOM/uYqFe/I41F0ik4qiOcUY12z/HrpD4REjhnsAN5cgzgATnefZbb5qjT4HcHfMcK6r8Hm6jeIGQv4jh7ZHDrT6z13wK/gq7ftK/FglXTn+iEnqrmD4rDG3i/0xvSNqY3uI6I/jouBGC6RTmP1F1+2wEtVJEnBretU18mzqfltG3yaz2Y7d7sNPjI7CVnBfQNG0v5Ei29C2MUxqOlRfZXaOx9xIPYInRRTEnLHnXUskjkYBXr+WNztqqLXzl8Ru2HRaFUt2h0Y9jYYPeja8CwnpKpQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ca16a-a575-4fcf-56e8-08d87605aa24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:58.0943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQttEETCt2VP+xNDNaUxQiR111GXQVFYktBI0Vl29jKLWBvCLcTo/NwKuj4BFwvW
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

We call get_generic_fuzz_configs, which fills an array with
predefined {name, args, objects} triples. For each of these, we add a
new FuzzTarget, that uses a small wrapper to set
QEMU_FUZZ_{ARGS,OBJECTS} to the corresponding predefined values.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index f739937827..bff98fe3c8 100644
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


