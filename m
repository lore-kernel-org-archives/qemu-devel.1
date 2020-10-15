Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A811C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C31B2223F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="rb3ZGaYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C31B2223F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3iF-0005fi-7o
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WS-0007fG-F9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:25 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com
 ([40.107.220.103]:1568 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WP-0000mo-4o
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajxqsyb20VuApc1wK2G4WAS/WaUYW4zd49Smid+BpeIMCQzhyaWKEnTC0+XkN3bHfve4uEum7WCt0JrDT+x//j0pIRuZlfxs4SGL4V+BiALD0I/mSjeuyLHqUJE1ttPTXjZNxNSXyN87rlnEGYlwhEwf3dmK9P7JKGEcSWc5aaBjeV179kTh3TlXMzlj0wDg6DQWepFxZT5Bxr9Zm9d8qC7Ce7aqwel8oWFdRTG5c5wPfw8eNeF6WbkkRzjinc6i7Qx80Q/sGAe+xciueZddA8wHljRCg8vb6Pm78Pj23fMlNjMdgUNDdRMM+i9Tf73QfAvG2TqeamRlA0spKIDzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeziuHxjHP52juDKX0HNE8NWbHIDQemp1hX8ht7niK0=;
 b=EthJQEprNnEZEc3eaufaoYdglE9aiOClzMnHpcNBtMIlds3Go2uBTit2Wu/gYMGeAlbjETeThrvZAfS6etrCTV/TRAJcYj1QLmCjcJKc6gQ9l57/4WiM+SaeO+zyk6otsSOcjEOifVGXL/wqT0UPh15lfCcKePg7oK7txO36rS5VA7Rl0A5fJpxWLCLB40QIX5d9QYlBntYFOyG9pWqCpciy+Vt1JG9LZ+BVfS0qCHPbmQKLqz/spGyTAush6bBb6HDTDLfma6u3mbSZstq8s/eo4ubg/Sgb5bFEqHm/v/pY3Mjh2ewpIC9OaUEkUIujS2+dEq8a+nCWpkSbfywzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeziuHxjHP52juDKX0HNE8NWbHIDQemp1hX8ht7niK0=;
 b=rb3ZGaYs1H+DtcNNzOUXNng4xhuAIMQc6Vyun/SCdhCfr1Imln2zmLrUakdoMT0EpII8hrpoQdvRBt0w/tARAxrbk1K9ZdDqVC3+efb6178codkTxp+8Ljp1o3vOq78NdsLbSV6iGnKSvptJcnTpwFJbz/mZmjhDpoekvkpE2AI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA2PR03MB5721.namprd03.prod.outlook.com (2603:10b6:806:117::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Thu, 15 Oct
 2020 13:42:18 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:17 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/16] fuzz: register predefined general-fuzz configs
Date: Thu, 15 Oct 2020 09:41:35 -0400
Message-Id: <20201015134137.205958-16-alxndr@bu.edu>
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
 Transport; Thu, 15 Oct 2020 13:42:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed71fd46-5670-4830-f9b9-08d8711021c5
X-MS-TrafficTypeDiagnostic: SA2PR03MB5721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR03MB5721D90F002B77C0BAD57B16BA020@SA2PR03MB5721.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NTpWFmLF8Z78BhzeP9vAGmGWt/i3jCUFkaLNFnwsVZnc2akCp/dX0WEsFbLjFEyVCgvrnF57C3djMuXm3BOK7pX9syV22WEp6PhKI/lAtgFuD/dB7/x+ieSCYCMvq+D5VPBbIkBvz0sIOO5iVHwEd3ppzqXi8nMATXKPDN9gkIlwPm+ZbIw+gtnq9L2Qsu8ScKRQOhESeyUFx5P9AeKGKUWos57kr6u6cNVVoSqnoKLlKSHpcQ3iOj9XHqMF1S1fLrZZOUBwnUY9yJL+j6G+Tf6/qyXjHXCpXtV5FfvJlUu67zcHekldjJV9tSmMOQyYPi4OYFuWOg+fqQU+g+98b4t5oPG7wiyn1vvcODQ/39KhurN2NTaoK1QkuF4U8Ax
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(5660300002)(1076003)(34490700002)(26005)(6486002)(66556008)(6512007)(8676002)(86362001)(52116002)(6506007)(8936002)(66946007)(75432002)(4326008)(186003)(956004)(54906003)(16526019)(786003)(2906002)(478600001)(6666004)(36756003)(2616005)(66476007)(6916009)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0x/C65gGzTXjZwq799ErSJ/Yrgm2h6h9DptrQf9hjRIj3Rx5fSLnKd3uf9Biz220Lo193b0iTLPPyeewC2+72G6i0sXR9k4f/qFmc06iY4zzga+RGguBLiBQtH2xb+PziW+gfsLqfXPeujAulWUsP4baW6Yl5zW5tEy8hbVwKouMeL7aW2jACBdwwr7C4XlgJSVIWK/H53yOLhrjM3dLsTKlfmXEp6w35e0yj6aGHvPzP3VS42M6Mn9RqqJpc4BbI8tS1Fes9f9IaiLAY3yKaNb1rAHHYHP5hrydy5t8/IG9B05aWaxiN1i6q8nnV7zS6EZTr/pkLpsB0XdshjF2B+/1kbmHOi7XM7M7Zo31WUPNkENNRKUs8nUDitL4DE5Gms/Ea9D+J2e7IDvQ4GBmVWxIcoeLar9OUEWjvW3eZ4KMA7l9uZIFrVGfnuuJdImKu1FkEFL7FAektCmkXg4yheZrIwDQeODwM9AX+/RA9T5qDyNKRAV5tB21mQR21PBb1WY3n8ELRRbmledU9hxplG8orix1c8hTXDkl9n7ilvPojalrnVwEGWH8Em7h8zywezlAou5aX/pdcjBye9wjgpLL5G/6EUdZ4o081KhpuTu5ciAohMUbkHJAFdvkCiDqPYJ9PcwjT4Yon4pGEyO+lQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ed71fd46-5670-4830-f9b9-08d8711021c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:17.6891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKD3LIg49nlPc1D6pE/qF+80SUFpJ+Yy4/Bnp00YdYWJ21Pcv57NRLq8MGTc7wfQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5721
Received-SPF: pass client-ip=40.107.220.103; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:16
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

We call get_general_fuzz_configs, which fills an array with
predefined {name, args, objects} triples. For each of these, we add a
new FuzzTarget, that uses a small wrapper to set
QEMU_FUZZ_{ARGS,OBJECTS} to the corresponding predefined values.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 22884512a3..04c4550694 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
+#include "general_fuzz_configs.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -902,6 +903,17 @@ static GString *general_fuzz_cmdline(FuzzTarget *t)
     return cmd_line;
 }
 
+static GString *general_fuzz_predefined_config_cmdline(FuzzTarget *t)
+{
+    general_fuzz_config *config;
+    g_assert(t->opaque);
+
+    config = t->opaque;
+    setenv("QEMU_FUZZ_ARGS", config->args, 1);
+    setenv("QEMU_FUZZ_OBJECTS", config->objects, 1);
+    return general_fuzz_cmdline(t);
+}
+
 static void register_general_fuzz_targets(void)
 {
     fuzz_add_target(&(FuzzTarget){
@@ -912,6 +924,25 @@ static void register_general_fuzz_targets(void)
             .fuzz = general_fuzz,
             .crossover = general_fuzz_crossover
     });
+
+    GString *name;
+    general_fuzz_config *config;
+    GArray *predefined_configs = get_general_fuzz_configs();
+
+    for (int i = 0; i < predefined_configs->len; i++) {
+        config = &g_array_index(predefined_configs, general_fuzz_config, i);
+        name = g_string_new("general-fuzz");
+        g_string_append_printf(name, "-%s", config->name);
+        fuzz_add_target(&(FuzzTarget){
+                .name = name->str,
+                .description = "Predefined general-fuzz config.",
+                .get_init_cmdline = general_fuzz_predefined_config_cmdline,
+                .pre_fuzz = general_pre_fuzz,
+                .fuzz = general_fuzz,
+                .crossover = general_fuzz_crossover,
+                .opaque = config
+        });
+    }
 }
 
 fuzz_target_init(register_general_fuzz_targets);
-- 
2.28.0


