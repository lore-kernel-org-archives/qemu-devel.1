Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6352DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBEB2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="viEPld+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBEB2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS6m-0005hm-7B
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5j-0004Dv-Bg
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:19 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5h-0002Ew-63
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngZQJTHa4jJkrrfVKVEIEASWh0gsMJAYC4G1YoYBEcycEL9BNncuF60We5q4YUX4McY6LYR85tyoBVBJuZZpc1JT2p9SswJCPJbPkruWUGnuD39qGNak1gtQ7mEVB5jlXrjXNmYXnL03QpOzTbgFax7Q9QHhG9SesRujpPUekJ5N759bT//IdqblUjlNp9rDBSJMFLPgdr3dlD5rQ7cr8Pp8FFrfKSjSxQISAFnVXinVFujycMaVIcDuHZ0s6wc43YEdvCaXgGQSclqreCVB65c29nMmbN+9u6Fcw9ql+M2CUYIb4plPkMOJk1MBzbg+XoNZYkX2LSCUeT1bnqq+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6S+IHJebSGinGzPFgRA3eC+Bx1vEJjgEh3FZOQNL7s=;
 b=Fwo4tVka/Rm1bPZYlq8s5KVBwqJnpUrW68fXWhitRVHF5pwjyXyVTB0RTScbDNMEIDOVdCVvZy5snvTWpxqrnUrQw4WT9QzYk7HWck7t043mfbEj9x5h+VF6frrdTaE3HApVOLRvPww0WWve0Nh/zdu8e45iyUo5kW6mCx7rSZ/nCTBS6cv+xZzSoFfA2z3myZ1kwuGisst4tssGDRFtW7LWtHbZjfTa6kpok+6eEHTGg0Vo/JssSv2rtGXJSATUpg3zAmhwGjbAskSY7v3FVZ/2Q1+/1ga8JIofdT59JN0h2Isym56cAIVsH6M0WS4cIIT+E79+WvVeIURI6fHusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6S+IHJebSGinGzPFgRA3eC+Bx1vEJjgEh3FZOQNL7s=;
 b=viEPld+Ze5sAhkHMqbx773KHNjrRo6pBYpGZighSGpVTR9fnR/0RaVNlrHRnxd+V2H/O8nJOn5fmck/7l3pytxG2VX6glAaYcxGK2kW6wDOSraassa/QoF9zK6UR4Cxkb4Txcqqe4Eb+wO9VBb+UulTfJOaGQqvnb9MKmxa3WWM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:06 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:06 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/12] fuzz: Change the way we write qtest log to stderr
Date: Wed, 22 Jul 2020 23:39:22 -0400
Message-Id: <20200723033933.21883-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:05 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282cda87-fedc-42b3-19f9-08d82eba1707
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3982BD2775D779238C35357DBA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqHA1caXqbQHERKh1zR8tBuUBxpKywm3IGk1FoBHfpuX4wwxu/8SmFmaMQTCSLihVtP3Tcm7Mnr1scdOKi3Bfe27FxijoPcATyZnhjz/rmid2A6FpJX6myxzpAuVIi+2C2uj7KCDxP8JJOBlG4vhanfI+UierxcXKe34rZNBgrpFlWgo3q6aJlpG/o+pJmITC1DSPlX/Bkfe5zCUuLfSyXmjaBfQtcIaOTOz7zyUBVhFtZpgP8LQ3LIXtEPKPfyI1iyy+GmvEPCZ70P5/5OAmTg/FzAcky0SyRQMm2kI0HJcnYBmET40U+YlRdk8ASjb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(7416002)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MIWCiO07V60vGflxYNmWtXpXzU4se+diyJ5dvOMYmToW+Apd6Vxelu3/MzCMCdEjcR+cz+3X8CEEd+dKZJ3sO/BWEhGd7fY8LEbNIGRdWHsP0Q3ESh45iK7IFwniMd+HC71q3SY0yeBjQIiuIbMvz0F79AWdpUjgLvfeXv33Gu+DaZUwfRjgseo5hag57OzooZIjzbb7bzrN9z5D7YHwsnqG8yGyofGIGYDwBp3X7YkJc7V0/PFMdHDbAm4Ij11UM/lkscZzQs9C3DNDzg/1fnYUXkA9MMwoSv50+8Y+8d3FeBAy3L5wjJjo2sSlbk+SJs5r8HFz06Pi9MCkDvyzc7SBcrXkmxLHAqupkeLetdeyl2JMtQNe789HZ7raezcNcLOISFWTKqFDH26Rbo7jomrZU6oY1EszgITNc6+sO2DWyNKKLAcu3YS43f/GGvQiwpSUAauLifdwDtGUuGmkR1N72vByMw1TGzPGiR3joWA=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 282cda87-fedc-42b3-19f9-08d82eba1707
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:06.0759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht7cnedfjDjRXUDRL4eGOzQd9jmFraUC0I5LhKWOL9ANf2ah9i0sD09EnL5E1Znx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 bsd@redhat.com, dstepanov.src@gmail.com, stefanha@redhat.com,
 andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Telling QTest to log to /dev/fd/2, essentially results in dup(2). This
is fine, if other code isn't logging to stderr. Otherwise, the order of
the logs is mixed due to buffering issues, since two file-descriptors
are used to write to the same file. We can avoid this, since just
specifying "-qtest" sets the log fd to stderr. If we want to disable
qtest logs, we can just add -qtest-log none.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 031594a686..8234b68754 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -202,9 +202,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
     GString *cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
-    g_string_append_printf(cmd_line,
-                           " -qtest /dev/null -qtest-log %s",
-                           getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null");
+    g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
+                           getenv("QTEST_LOG") ? "" : "-qtest-log none");
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
-- 
2.27.0


