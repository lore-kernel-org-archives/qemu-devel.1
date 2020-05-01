Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2030C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB373206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="MvXHv5AO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB373206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWOt-00007t-Q2
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jUWO8-0007tA-TJ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jUWO3-0003AR-0F
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:11:36 -0400
Received: from mail-mw2nam10on2103.outbound.protection.outlook.com
 ([40.107.94.103]:2177 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jUWO2-00033u-Fo
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:11:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X55IpdSgdL+g55misuC3/EX5YFsvhpKdLqaTbmVOcdpo9HJsO80hwW2FhTmjhMUiOe1TkaBtQln2JEQFyI+UpriZ0rDIOoztoYFczm4y2ihOEBcV8b9yx+gKqziUFonfdJ2Qm2sexOwTNt25N8rJHMOrCxAGjax/hsNr7SEe/ZeQE2lWa6MfIB6C2A6UuSDEJT15O7PbKQUBKijT7/oCrnY4PLdbme3H+dkm0p2XnBCV/oaoKfFuWEMzvUOQFxg7SORABn/cQiycaa2Yfle/jvYIORLiO6yocLmuzUyynihGO1ZC/ZpFZFGgsc9ZHJGrceXEBfTtQKzqCUZi6jVppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXLyKHp/EhiDt+ZJtK+kzqrKg4nIB7VoH5CFXpI3p14=;
 b=lIC7ff+QoyBSHGiajmRJ0XTyfqgvSH6546dFhklDSmFDQGx/tQ7VOYgErbL06Tl/+bfuJs07FUoRtI6/vfagv21QKkH/8OYteKFw8K6XGqMjRrJf8vJvRUWaIa+r4gkvN/EuSKEpalktZlHd3W7ecMC3gIZNF5LVioK95f81qHWKZg7gZDM1djscSXs/G/+1r2uh4NpglCXweo/alWyOvlcS9r8l1Lhzix97nxjwAqPtypRa8ihlUrZ00RqkyFNzItk/eQtAz9Jm8NYUVza9wblBVuGtrMV2yS9M8o4UXMa9/N+6bMEk2xHCODyjECxAAsg/GloLhUw/9pKY9QJMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXLyKHp/EhiDt+ZJtK+kzqrKg4nIB7VoH5CFXpI3p14=;
 b=MvXHv5AOtrI+ZjvbXdy8LSORy4l1EVhk464IqTU+Q/CpLa2HaJt3f5uWBtYuqiLjdy1mALSl3QA9bfuJtNRMrXnglujktyv+3d5w6A49nOu/ebHEPvjXQ6nFQ4uh2kzO4qFnnRHQhpF46rMIn7JRp0g9Rq9Nb9sHEfzR35uDgH4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4157.namprd03.prod.outlook.com (2603:10b6:805:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Fri, 1 May
 2020 13:56:23 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2958.020; Fri, 1 May 2020
 13:56:23 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] fuzz: select fuzz target using executable name
Date: Fri,  1 May 2020 09:56:12 -0400
Message-Id: <20200501135612.32249-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0022.prod.exchangelabs.com (2603:10b6:207:18::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 13:56:22 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b85dc2c-aece-4845-a388-08d7edd76ef4
X-MS-TrafficTypeDiagnostic: SN6PR03MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4157ACFF28A91202FCCCCAA0BAAB0@SN6PR03MB4157.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzli2R1ASBtPbDmWDAFBgVc9zI6LttKjpk9ik4SDYxEu3CHelQldpMGe4uk4eVGraxtBHUlrvZallDGvim80WRwtzda5KQpU8Z9ximjw45HbTWWAAaw2cBKUNMaJDKia6Ns909WLUyZSqkJPB3zmu+mNDWwL47pp4V4qctqPAkXfPgBKcS8ZTz7WzrtvoNekUkKG/xZQq8QNp/2KSEsl4DOL7gQ6TBAkcpVsLRJtWCgMXMOwcmvp/x6mBWr9laXE+rAcvZMkxehgYMopiEv/Pzqt1KIMfD1KM+3KhVfD5tsh2JCZS3w+fBrhfEr8ZWNbxEHaBH2StMeMFuI2oK9rfqv0B6BB74Ic+is4kIrownWGf3CNVye++H2xgAHVaRCoWkn8SjUORohsxeSBq8+0iX3Xitskqme3w4J9hJHnDVSInVHs8hpU4zGnSfoGpxig
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(54906003)(66946007)(786003)(8676002)(316002)(8936002)(6666004)(4326008)(6916009)(36756003)(75432002)(66556008)(66476007)(52116002)(7696005)(2616005)(956004)(86362001)(1076003)(5660300002)(2906002)(186003)(16526019)(26005)(478600001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: l/a3Jpw8olRnc/0edKZiA/De1DN/6+WCwaPUGQKeM/i5Q17e6W5R2UGROyVIjahh7+g2LgF+MnN3nrorjMSX8GhDXLPbHH7/mSSAO/sKKl7ABen1ScJaUn6tZqzPiOubfx3y5KFyECN8jUnV/obtvHT+aCxGc8P4Sv7Aj6Oaqhv/qs5CNmP5/tDiS8+97pBO05smLxTgzq+PYzs/1N4rTbgPpG6DnXABbsEncJWyp3W+1xW9rNr9rFSXERX8m2Yv/F2YIiKoVEisSV9KEzquh9M6iX/P3H/B8uSJBHWTRvJJT1KHVzGoLo/E2hkQEWljftiuVsWzjdcdKEmy8NGbtqGgBt9V5Syq+VXgrstviJU7cUWI0eMkrl7URgZF84ARvcCcmm7TmvlGs6P6v+Ww6bVIKqHSamoTc0jRcPrZk2GtSds+joq16eVFWOc/vLniKr4brQmuWBERyX28MAc3g36//1H7SmM6++oTg5o5PJhvVL7ZYDN6RFoTEYpAWMtzssfnt3YOK5QQXTuFBXvJ1vBRXeclg1vtbeGSpWjO9l26hiuHkw1b5uWzlx11X0fCfWd8xgNt8hkhn3JdlGSUgunOdcJ19ET/fXAwUlstVT5hhndd3OO+l3g0zTsWmvkX8bOwStOVOaCoAaWc90K6+Nk+mSJGBADBCCkSs2CiDumkJEz9Ibp6W0xK2YirHguBkR7GDglQ5JSWFvxWpvSXIojaK8ik/7ryoM6P3b+X4br0srGKaJdou5gHjP+Yfh9DwrWOsrNxvSASIZD8Lajgo0zBHBehYZDKFDpCN0+LNKo=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b85dc2c-aece-4845-a388-08d7edd76ef4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 13:56:23.4510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUhGvzC2I03jtC38GkfeuUPCpL9mbIFYaPQ0bivdoUEXW3nOVTe2WCYR/XkmfyID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4157
Received-SPF: pass client-ip=40.107.94.103; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 10:11:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.94.103
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
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

This patch should be free of any changes to the slirp submodule.

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
2.26.2


