Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA929C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 18:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F393206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Jick/49l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F393206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQxnu-0003rk-Ge
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 14:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jQxmJ-0002aD-Uj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 14:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jQxmI-0001as-Gk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 14:37:51 -0400
Received: from mail-dm6nam12on2104.outbound.protection.outlook.com
 ([40.107.243.104]:9184 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jQxmH-0001Zx-7v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 14:37:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKDCjHTheBgManGCvw6PsjHHRybj/dfmreoMixUBMSfSO7CMrax31PCTFXo/jNoq1OHLthZaLYTIjmCiuTyGZkEP1wwCdMP5NEik7A5KRdNdKvW2GYRi2FEsPe8GMqrGO8edUxXAcwpcKwJ9VcuyV9iipsyXPEh5xI4CZ/tB6yYGZOxq+ZfZMd+C9hc3g9MtZ+ga3+V4rabhoxwRXJJdmCHaNsAF1ZmvCJgvavWseBsVxy+p1vWkFqUSwwccUXc/BBXrocu/O3gdeZzzBLLf3gBMFN8uAJ4cQwFKfOCc+zGP8O560s2TUNjkudhcWVcqzBo6wxOlh5cAAiN5HPImIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJh7POinFxOKrlCb+sVefUd8xHNMZS69SJYrcAgJZ3Q=;
 b=OmurEXXC7N0Wh24YZuTV4SkDJjFv0lL7qYkb+if95xo1QYRQ+5xGjF6zwtL+R5SXBTuUtDkKL3qaleH0ycfn4kqoiycnnu6gTZcOxeENG1O/252GCvHXLJNtfTp/qj4QwsJc0YYHLDZLOlYmc8f+ewTsEHfL9KQFX4o3CRzZGkFa0NQaqwNA1iiLGJZMojcGhTDO2yen4ADjTvPjoPg+tWWQFSI/4JRX9hlrJmQOknWVdEI6jEFz+1fiatAh24RHPfvUmboNs41JgjOM2MMwQz9J6QufB1PhUcnnQn9z2Ei9GJNbRtcuxdIyQruaMUTbGwTChVzSOco1+nfz5oleBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJh7POinFxOKrlCb+sVefUd8xHNMZS69SJYrcAgJZ3Q=;
 b=Jick/49llloJgU7CSsv8znjHY0EIrMo8tiFDr4f/awRPgp4dv0dBesweedfwRmYzGE00uhYC2c9F0SzniqBFcJ8QCAG+RrT/hp0cFnKCYsKOPToPE4n5a8FwW7ri59TiLA6xg0D09ZosFQvc3nbLXnv85uMpKHwq8kI7fEnLcYc=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3999.namprd03.prod.outlook.com (2603:10b6:805:c2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 18:22:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 18:22:43 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: select fuzz target using executable name
Date: Tue, 21 Apr 2020 14:22:30 -0400
Message-Id: <20200421182230.6313-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:d4::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Tue, 21 Apr 2020 18:22:42 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7672f39f-0447-4fcb-ebcd-08d7e620fba3
X-MS-TrafficTypeDiagnostic: SN6PR03MB3999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB399966811BDDD337D827454CBAD50@SN6PR03MB3999.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(6666004)(54906003)(66476007)(6916009)(75432002)(4326008)(316002)(7696005)(786003)(26005)(6486002)(956004)(2616005)(52116002)(186003)(16526019)(86362001)(8936002)(66556008)(36756003)(81156014)(478600001)(8676002)(5660300002)(66946007)(1076003)(2906002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPukrlC3Og0ADD3BEpV91WErGQHuqy5yMZQDn7gdlMD4zArOWS3/mP3dED/gTTjHJykfQp1EjGFu5Tlwqz9V9D9hbBL0rzCND4trQcd1fflHD5vNcIuyUSwektvxC7OkpBNbCW0dSsRu0r+5nuE+XlDW1KuPZEvcINFvIL5eEE4jQk42nprgXeqGWRI+8UacgZxmyHHAvdG5SVOfbax74UWtZFO6aN30fNak7KsYsRHXQpF/RYGCrQeY15EhGvB3VjF8IwqdfytYp/Z7VTfruoPHXwZlAwkKyUWw9d0I+9AhqWo8MxMf4VjH9RNY8av5dWO2J+VlpsK+PnxtaZIPGpNEJm7Nyy0hgCZxsqT7GPodFChD+Tv3ZOhS4oiSMWJrUz90ZSdJx4HJIulqtQB5QuDDyPQ/5SmoLmZ9/JFC5RA0ZbuyZXqFxaIGma7k9mva
X-MS-Exchange-AntiSpam-MessageData: Jx/nGtwsAB4wPshOkss8KDZ+3PNE3//rLdllW0t5VH+ltqqXPd80ghOhCxRCDXvJHiBDsv1MeG1jiQGSrMma9JTH/tpHJndRDc7z2RgIHHMM9m0UI/4hMbUz4vd0fsvtRtRp8jOwKFRijkfaj/6ssQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7672f39f-0447-4fcb-ebcd-08d7e620fba3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 18:22:43.5288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0zyIGe5J66BtO5/wZY8oI4tX6wBSv3GGIDTlpi+bsMQ/RboSTDIVOAWIK0iq3y9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3999
Received-SPF: pass client-ip=40.107.243.104; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 14:37:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.243.104
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
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fuzzers are built into a binary (e.g. qemu-fuzz-i386). To select the
device to fuzz/fuzz target, we usually use the --fuzz-target= argument.
This commit allows the fuzz-target to be specified using the name of the
executable. If the executable name ends with -target-FUZZ_TARGET, then
we select the fuzz target based on this name, rather than the
--fuzz-target argument. This is useful for systems such as oss-fuzz
where we don't have control of the arguments passed to the fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 0d78ac8d36..c6932cec4a 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -91,6 +91,7 @@ static void usage(char *path)
         printf(" * %s  : %s\n", tmp->target->name,
                 tmp->target->description);
     }
+    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n");
     exit(0);
 }
 
@@ -143,18 +144,20 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
 
-    if (*argc <= 1) {
+    target_name = strstr(**argv, "-target-");
+    if (target_name) {        /* The binary name specifies the target */
+                target_name += strlen("-target-");
+    } else if (*argc > 1) {  /* The target is specified as an argument */
+        target_name = (*argv)[1];
+        if (!strstr(target_name, "--fuzz-target=")) {
+            usage(**argv);
+        }
+        target_name += strlen("--fuzz-target=");
+    } else {
         usage(**argv);
     }
 
     /* Identify the fuzz target */
-    target_name = (*argv)[1];
-    if (!strstr(target_name, "--fuzz-target=")) {
-        usage(**argv);
-    }
-
-    target_name += strlen("--fuzz-target=");
-
     fuzz_target = fuzz_get_target(target_name);
     if (!fuzz_target) {
         usage(**argv);
-- 
2.25.0


