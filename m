Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FC5206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="UD8z0W6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FC5206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejOs-0007Iq-IU
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jejKz-00046v-5e
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:02:33 -0400
Received: from mail-bn7nam10on2095.outbound.protection.outlook.com
 ([40.107.92.95]:24416 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jejKy-0006Az-FC
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:02:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5M38ndzVripPhZ2Bx4SbbFn5GnTril2R4ps8JqpeXUgpriO+LoCTjQ7w8RXQe7m1KHzwTUu0qyd91lteLGD+zGKiAxEFm06o+osJvCFv8VvZrne0zrI8nmyLdDYCIIyhS1Bsq7b2w/OxfakDfSgwGaLuOli7FukKDsyJ8VpQdKGoggFh0MJ72+j6ZE/4pn1tK7H6p/whMnijZfl3dyS8JyStpC4J6XfHHmCkt8ONpDDNtBvZEo6Q1Px4d+zxefX3SckuKGGPKkrl9iTPX7Ildq2uA4Doj/k59U+ZRmuLQfKIqy0f9o1MLeW1cO3IfKSdjGAlzCbGJlOpnjFIg6W+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEIVHMfsAQ3/Yc80bZVjSfe8YMIrVvsORQ3H4LXrpN0=;
 b=Ts9QnT/OtUMSwcCgfs6jmVp7zhrz9dRKJLUu8PnywGZ7mlHzHaHycFnbQz2uofxn1xIvGO81VUcqr5ds/ZBG0yjwXGFZnKU0YLng4we0buu1cHE0qyVGxJfaf/LLNYxYfPEJS2Gc5Tjud9byv3XBRu7aqbdUt8BcMtT0qtgyFqNlO57uExzmtMbGN9vS5Tu3RjlcyoO1xLVn6wCVHCyUTX5tQxLHeRhICNkHymmvM9BZokIdWSxBDncFwNw4hVwWc0eaOXBhVwcZTWaLRlOaQZ0eQ7GFt3keHzGL4ec/2B9/g9D5T7HLLpn7cf0QAtYGj2/3dkouhg07u51OQPcvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEIVHMfsAQ3/Yc80bZVjSfe8YMIrVvsORQ3H4LXrpN0=;
 b=UD8z0W6R3gb7zH8dG17jqchl9qlLkfQJd2h1fl8F4zRMok2vh4vkxqnW1BCEiTNLGzn9O+pHA9TdPu7rY4X+cjHftVoQXN2rABxRRlFy9H2AjJDpDQvJ1tXFgtHLAgh8+n775bzXGrc0mUJcxcwlFGSW90tYrnv//RX92hK2BfA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4096.namprd03.prod.outlook.com (2603:10b6:805:ba::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Fri, 29 May
 2020 18:02:28 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 18:02:28 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] fuzz: Add support for logging QTest commands
Date: Fri, 29 May 2020 14:02:10 -0400
Message-Id: <20200529180210.28120-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529180210.28120-1-alxndr@bu.edu>
References: <20200529180210.28120-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend
 Transport; Fri, 29 May 2020 18:02:27 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650c0237-82c0-4c34-4214-08d803fa730c
X-MS-TrafficTypeDiagnostic: SN6PR03MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4096F7B4A4297FEFD7D13A3FBA8F0@SN6PR03MB4096.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qq6IshiTCkdG0m/d2lWP0uLe+NOa6n4EJBXF5PaAwZIwfcuQMOXyLkrzBfEfr4fbfv5KrfhXk26w17FHut+/4tBBoIxCD0ug0v4bAIOevuNZdx3aSJZkCEVibnrjFjsHmz+gf0lni1/weCybHLeG2ZXhFULTOLHui7Ksrbr6MeFw/zK9GSlzxDpItPac335V0ehcO8uyYfUGq5VcWJb0yrxYsf7qlTswqDdH0W1tITPMpTCvf5nV71xM+egLeVsWg7avSiPavjHJ3xOxnYRTta1cyjqfbhCOUm8q0Nz7EMT1n35X8NsmJpkbpSKnZ9Dz3QUw9m/sSLd/zIJHgRiwXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(8676002)(4326008)(6486002)(786003)(956004)(8936002)(6916009)(7696005)(186003)(54906003)(26005)(52116002)(478600001)(16526019)(316002)(2616005)(66946007)(36756003)(66556008)(1076003)(66476007)(6666004)(86362001)(5660300002)(2906002)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ozffp/sx/e3+QpybawIYdlqL606ulhH+vAj02ZEEcrB/370+fdHwbb82uGsStjNqDFKsUuipXTGjg2+e380wV9ZbqTJ2xjePJdRyM+XJV8Osk6pw3+Kcn70mW2S3WZP4bOIYSKa7vcYxGiK/QUQgSOEY9n2kkZGwRgpumla7LoL9Omt033Bpt+9OTWy0Zmtb8JT2xzmkDrKJeU9yrCTlTdTq3ow5ZTWWnX9La0IydYqd/duKU/2WRFLHnTPQjzP5pEqYnSDgw8K5OekTrVs/Uu4sV9BlndKsvYUD5Sa8IqjmeTyCI2i6IuYnziubAUgoUgedYgK4wehxqcUHKVut5xixNcotIC/aNlCvvfihVH5Q9kljTu6ViznGKrErM71XbvD146Z5Mp2MqP1fb7FU6aOi6r7z6hK2Co3H8lAHzG9pDhJ7BWVgm5slKlmbsmrjTIEdEyRgdyYY8AqNbrtyGL73QZPOqPde5LL4tgC4Is0=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 650c0237-82c0-4c34-4214-08d803fa730c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 18:02:28.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsiaGBZkiKAuMyPon2E2TnSRWAUsvZmdGMF/3g0Xvboe0p4oGywfQ6CnEbBtvszE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4096
Received-SPF: pass client-ip=40.107.92.95; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 14:02:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 tests/qtest/fuzz/fuzz.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index cf76a6636f..4842fbe7c7 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -95,6 +95,9 @@ static void usage(char *path)
            "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
            "QTest commands into an ASCII protocol. Useful for building crash\n"
            "reproducers, but slows down execution.\n");
+           "reproducers, but slows down execution.\n\n"
+           "Set the environment variable QTEST_LOG=1 to log all qtest commands"
+           "\n");
     exit(0);
 }
 
@@ -183,6 +186,11 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
     const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
+    init_cmdline = g_strdup_printf("%s -qtest /dev/null -qtest-log %s",
+                                   init_cmdline,
+                                   getenv("QTEST_LOG") ? "/dev/fd/2"
+                                                       : "/dev/null");
+
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
-- 
2.26.2


