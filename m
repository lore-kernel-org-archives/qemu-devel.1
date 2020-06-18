Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2161C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B58A20888
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6kpZWXIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B58A20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlx4N-0004le-Mi
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jlx2t-00030E-N9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:05:43 -0400
Received: from mail-dm6nam11on2106.outbound.protection.outlook.com
 ([40.107.223.106]:21216 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jlx2o-0005q6-6V
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0ulvHDwtXKmsfPjyll0Zm1rwmWbgffjP2wTM05hHrP4OykstpqXGU5mHQrn54/a/gBewbcxc8FFPqV0p+zNgjx1Ny6h6bJegyzQ9FIDJsinHBNWzbvO4wOqBrV1UW9xMg43sDCtR/34y+trItPFMqkbShwVcTviZF9SpNHTKnWVFFV3WuLoVW9nhprb/OWcHHIvidAyootLn+BnvjsU2x7u3LZ6N/zVYgDeNovjMqeMb1ci3rcgJwAV6u07uLifhGlKJkKuzuis4AMoL4xGf+Z+wlFd3PEBRAwNGLT8Wo5CZsVPAGa20VuDkhkOz3dKjW5ovsUhmQYXpduLGlJpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1gUomRwNuEQ0sYEhB4aQoekqEON0f3EII0MakEtJx4=;
 b=jjaVAmze62YW7xfVlfbkVnw/bEeoKRbd2UZuu1ohuoM1rAbhCkK0IRgim7DLG3qs5BS0lvCKWiWuvaThl4V5BM/pFkWD58mxdXSnxlSYFWjPKB8WcRBz3Sm2sGMUzKo2yaraP/7fSKwJgaMFRk+F6PqWU/rp3nCZy5dtOVTlmwz3B2WVs2TyxfdgQHYM2Gr8vUyM8Pg3Iegm/st2jBKsessigouUzB86rRTybivbN36ITNrDipzv/SZr4amHf/0MTvFm/96rPhq3xDdsrlkRj81utc7jGIY4KlCfdGdgZzNBdEOmuQfeOCqf4XUDtoc6a170+qkfE93+AEUnS6NTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1gUomRwNuEQ0sYEhB4aQoekqEON0f3EII0MakEtJx4=;
 b=6kpZWXIajlCs4uDwLFk94AUZm8ero5GKRBeIqv1GSzhwfYteSs+BTwLEqtGMz8CXObo9VOKfbyL2lms2P+V0Q92tbojry0QZK3Njq+so4SWblTSMPToe09yADG3o9x3CMw2lcSs0OGo8JdW4XVs3PH4hj64zb6DOZSagn2Jdexo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3679.namprd03.prod.outlook.com (2603:10b6:805:42::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 16:05:34 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 16:05:34 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: fix broken qtest check at rcu_disable_atfork
Date: Thu, 18 Jun 2020 12:05:16 -0400
Message-Id: <20200618160516.2817-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:208:178::31) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:208:178::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Thu, 18 Jun 2020 16:05:33 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd20deba-bddc-479d-d78d-08d813a16ed3
X-MS-TrafficTypeDiagnostic: SN6PR03MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3679AEE54FDA22B975986A49BA9B0@SN6PR03MB3679.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpJHQhAqP450XVPlRAqHJVv2vmzOeKLmWFeiYRPPi6HQHsS9t5/QVF/BNyjoSyd+NvU4bSDWgWcxFnoOALqR0hGd/AATi4qewaxFItflWH+atBOOa5FDdAYPl0X9sH3Q78J4wesXha6oA9mDMYkji7Orp0cT63VYIcJd/R2GnhU8b3X6Ps+VRyhE4Nohi91BCaCpuORw/gHBmwktX8xepbj13/lEU4UkPp+HhuLC30BWhmDkAULBiyUhrLDWBeGYv0SNqd+DxX291vlBWcZJF7tKBbnejh25z2N9cDyWZZqWTN5/qSgkJ1r+/Ajm6+yHgqRulMIMe5YfWFbpEPVWAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(66946007)(6666004)(66556008)(5660300002)(75432002)(52116002)(16526019)(956004)(7696005)(36756003)(6916009)(186003)(86362001)(8676002)(2616005)(2906002)(6486002)(1076003)(4326008)(26005)(786003)(83380400001)(54906003)(316002)(8936002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jFAb7cBWvTntpQz6D/+U9F7w+O/4CFlc1IzoAUM3Etfq8dzh0dCsvhHPnZvfaeEBu91Rb6OmHwkp8Yd2jQsrR+qguCzsun10gKuiLH5ZVrAZPF5ryvNrkLGPLYS0jUrTcECjixqKNlAkr5mR4pQ5kYzoJsv7o+uldquiLXGx0Yi6K1AzWrQnQL2Xhos5YOoMobVe3ddC8c+WrrAib3CYdBvKgq8kerqYaSdAlGWmGMrf16dpAC2PMYM6j7oqmQJKzT6ubaaDXlI6enL3W2XGcuMPWHoyaHjoOk6NIYYO/1s+p247chOS2BoRnyKoz+LEb742h8Vct8Mlt48gx8P6jrEV51JGumpyOKm4camiwZ17sxBDCpoY4aF19/rFCOnt5Abn9KIisuulSw3DYStve/RXxtYlmuaKPYjk1xRpLFidvdIFJzmKvMh7XT/KJzhzvJVbyVazZ+Ul5hbzyqGdg++KvFXgR91eVfjK1gEFUQ4=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cd20deba-bddc-479d-d78d-08d813a16ed3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 16:05:34.6352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94YhxJD7inyEXzrFnzEomr93ZsuzWzdSSQsf4439h3i+VulkAjxUek+Nd0VMGiBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3679
Received-SPF: pass client-ip=40.107.223.106; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 12:05:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtest_enabled check introduced in d6919e4 always returns false, as
it is called prior to configure_accelerators(). Instead of trying to
skip rcu_disable_atfork in qemu_main, simply call rcu_enable_atfork in
the fuzzer, after qemu_main returns.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 softmmu/vl.c            | 12 +-----------
 tests/qtest/fuzz/fuzz.c |  3 +++
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index f669c06ede..95e2fed7f4 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3832,17 +3832,7 @@ void qemu_init(int argc, char **argv, char **envp)
                                               machine_class);
 
     os_daemonize();
-
-    /*
-     * If QTest is enabled, keep the rcu_atfork enabled, since system processes
-     * may be forked testing purposes (e.g. fork-server based fuzzing) The fork
-     * should happen before a signle cpu instruction is executed, to prevent
-     * deadlocks. See commit 73c6e40, rcu: "completely disable pthread_atfork
-     * callbacks as soon as possible"
-     */
-    if (!qtest_enabled()) {
-        rcu_disable_atfork();
-    }
+    rcu_disable_atfork();
 
     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
         error_reportf_err(err, "cannot create PID file: ");
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a44fe479db..a36d9038e0 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -211,5 +211,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     qemu_init(result.we_wordc, result.we_wordv, NULL);
 
+    /* re-enable the rcu atfork, which was previously disabled in qemu_init */
+    rcu_enable_atfork();
+
     return 0;
 }
-- 
2.26.2


