Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D1AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CA022582
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="7y3Zkx1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CA022582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPGo-0004lx-4g
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jvPFJ-0003Ud-Dk
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:01:37 -0400
Received: from mail-dm6nam11on2127.outbound.protection.outlook.com
 ([40.107.223.127]:38464 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jvPFG-0002Ug-TD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg9La0hE84Cpb8LThMa+dfju4Dv0dsNNEv6mwHeXiv0Z5mLENwe74EqZ0f5ID1Me7bj2sja/LVGFbi3HuX/sFz3EmpXo1b/Wc+6mU9p12nBfqMGwwHmPDkv+qvjJLQb7OrR0oroO3+Kuot1i9OSePSS8a2H9jmZ/M/Hl2k3Pv+zUZ7W+NMkxfgPIY8RMqbOpdZNibhqIqk+xaDPtyCnYm2ZFUTcTjpSHSFl6+i8ECCvhHRLjRbZHR4MqNVZ6QMqawaKy98lnjmSCNNyBtGlTsDci24v7YycpT6zzSUX+k3tka8A5TaceABTZ/DX6Zt1f72HFBlm6KcHk0QAww0VLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOMZ+KBh/iv1hIWbkFZGwsRYQOgAyLdqSmafG2TEZTE=;
 b=U+pgNLEKy+tw/RyQuLXVKg9RoYhlaKIPg/WJWNr3ngfzI70k8eoRJJH/RYQQCxvVzfbwxh2TARckz3923lY1ObpdlhFnFcc/cMSf/IKMyIAQNSfh1t/S2atzwtHC1jYyVENPcYKTqu527bxU32V73PpNZn0Adj7R82XHtC/8a/Ix/WHFJwl6UACkOv/Mjqt4c/JJrwelne1xGQyCw4pYhRhV9jlzHNcez91b6VJnprnSTutVq6ur3PMiFf1i8WchorodjZstOUbcmKtW9NAnnOGUfq/gNkuxpk9icbgokVaNzujw/vtyDn3wd4yuQgxYxCm8QdZztkJxRPpBn7DA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOMZ+KBh/iv1hIWbkFZGwsRYQOgAyLdqSmafG2TEZTE=;
 b=7y3Zkx1rvyStgwjp+tk2zF3KmV8FxEuLBqKN71ZIXVFoWAvED0+aMOJCFAUbm3+IOw7tu7BjC5N7l+vD33uQ1O0p8u/S0io4+UdJmuVDW/bhPBQtC65tR3n3teiYrQ0b3g9j3EUcODtpKPogSPKbqPZd/abNWgWca4dHXbEFkKo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2382.namprd03.prod.outlook.com (2603:10b6:804:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 17:46:31 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3195.017; Tue, 14 Jul 2020
 17:46:31 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: Expect the cmdline in a freeable GString
Date: Tue, 14 Jul 2020 13:46:16 -0400
Message-Id: <20200714174616.20709-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 14 Jul 2020 17:46:30 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e71de46-3ce0-4513-46ef-08d8281dd78e
X-MS-TrafficTypeDiagnostic: SN2PR03MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2382A59D132A094749E9D9F4BA610@SN2PR03MB2382.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZhmEVv0ByZdVrHC4NWKs5tm300n6T+aX6oSKzVR1eDbnx6x9aB7xpEu7wQK8TEFKjgrlvczI2c3m2JPebmnr32uQmFw16+Mzex8+ZPH4CLAP2VaH3qRGxKspXQFiXh/Z4u+2aBND+a500EL2hIZbz7njYfbXlJEEo/an/pvE8JWlaQN3SwnK2AFvigDqyRAcnHf3PolVFb2dol5ckiRAmbAc3BOjXVTw45/oDeIw8lyY/XhkATLCiBQ3UUuZB/s0/fg8NX4u6ZUdPS8842vRBqdXKqsk7WhX5F0+GanSRTJuqjEVCDaTtqt1syjC7n2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(4326008)(66556008)(66476007)(8936002)(6486002)(86362001)(2906002)(75432002)(83380400001)(478600001)(66946007)(16526019)(54906003)(956004)(36756003)(2616005)(186003)(786003)(26005)(5660300002)(6666004)(8676002)(52116002)(316002)(1076003)(7696005)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 95+GgeVpxtaqO4qBlH1haajHzNH1JOOuHeJAPziEWdk+aG1yIrdYppNcBulDWLMeHhT5triZQOHJm45ql5EhnWftA/b7EZ8CkZ5DaIRAtHDeOqE7M27d6fyVk+DDQpgZ66SeDu47cjsq3+lO5bt/XfxNl8w1ZHDB/dU4bU5d49wBJw8o5qijBgtej9Cyvi5ETiv3kK9V7M+r+hnuxcrYKNKbT0KDknYeJblwPtv/W0uTC8N4pzkW4cxZHbb1hATyq3w0oQ4Q0VUlaj0q672Rk4UQBFGT1LGh4rR5LFs0WlSDXbJ5eqxpfs+sxprHINJJOCl02jemxIH3EpFf67NfNNhTskeX1XNwfm1Py4xp1shj/RAvDEpg0SNdJGKT8EZzA+ottEF0CgUPaTDf2gNkjTvzDBgMzE/c/IyALUyDRIEmM9BfpX8mZS58Cuxe9VW1QN5TgPKXCTh3JIis8RvtnL9l46bXcfCxlNvpc1y3rjY=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e71de46-3ce0-4513-46ef-08d8281dd78e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 17:46:31.1132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFb/e4f7DXp2n8aQmU4q4pk3Up13BviCso5BFZB1QNNFeSMTDB01qiAEHA6oXibl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2382
Received-SPF: pass client-ip=40.107.223.127; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 14:01:33
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the initial FuzzTarget, get_init_cmdline returned a char *. With this
API, we had no guarantee about where the string came from. For example,
i440fx-qtest-reboot-fuzz simply returned a pointer to a string literal,
while the QOS-based targets build the arguments out in a GString an
return the gchar *str pointer. Since we did not try to free the cmdline,
we have a leak for any targets that do not simply return string
literals. Clean up this mess by forcing fuzz-targets to return
a GString, that we can free.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c        | 13 ++++++-------
 tests/qtest/fuzz/fuzz.h        |  6 +++---
 tests/qtest/fuzz/i440fx_fuzz.c |  4 ++--
 tests/qtest/fuzz/qos_fuzz.c    |  6 +++---
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 0b66e43409..6bc17ef313 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -199,16 +199,15 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     }
 
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
-    const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
-    init_cmdline = g_strdup_printf("%s -qtest /dev/null -qtest-log %s",
-                                   init_cmdline,
-                                   getenv("QTEST_LOG") ? "/dev/fd/2"
-                                                       : "/dev/null");
-
+    GString *cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
+    g_string_append_printf(cmd_line,
+                           " -qtest /dev/null -qtest-log %s",
+                           getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null");
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
-    wordexp(init_cmdline, &result, 0);
+    wordexp(cmd_line->str, &result, 0);
+    g_string_free(cmd_line, true);
 
     qemu_init(result.we_wordc, result.we_wordv, NULL);
 
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 72d5710f6c..9ca3d107c5 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -50,10 +50,10 @@ typedef struct FuzzTarget {
 
 
     /*
-     * returns the arg-list that is passed to qemu/softmmu init()
-     * Cannot be NULL
+     * Returns the arguments that are passed to qemu/softmmu init(). Freed by
+     * the caller.
      */
-    const char* (*get_init_cmdline)(struct FuzzTarget *);
+    GString *(*get_init_cmdline)(struct FuzzTarget *);
 
     /*
      * will run once, prior to running qemu/softmmu init.
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index e2f31e56f9..bf966d478b 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -158,9 +158,9 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
 
 static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
                                        " -m 0 -display none";
-static const char *i440fx_argv(FuzzTarget *t)
+static GString *i440fx_argv(FuzzTarget *t)
 {
-    return i440fx_qtest_argv;
+    return g_string_new(i440fx_qtest_argv);
 }
 
 static void fork_init(void)
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index 0c68f5361f..d52f3ebd83 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -66,7 +66,7 @@ void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
     return allocate_objects(qts, current_path + 1, p_alloc);
 }
 
-static const char *qos_build_main_args(void)
+static GString *qos_build_main_args(void)
 {
     char **path = fuzz_path_vec;
     QOSGraphNode *test_node;
@@ -88,7 +88,7 @@ static const char *qos_build_main_args(void)
     /* Prepend the arguments that we need */
     g_string_prepend(cmd_line,
             TARGET_NAME " -display none -machine accel=qtest -m 64 ");
-    return cmd_line->str;
+    return cmd_line;
 }
 
 /*
@@ -189,7 +189,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     g_free(path_str);
 }
 
-static const char *qos_get_cmdline(FuzzTarget *t)
+static GString *qos_get_cmdline(FuzzTarget *t)
 {
     /*
      * Set a global variable that we use to identify the qos_path for our
-- 
2.26.2


