Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2594EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FFB22201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="snFKh2fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FFB22201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShgN-0008L0-Pv
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kShfV-0007pL-VQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:22:17 -0400
Received: from mail-eopbgr760104.outbound.protection.outlook.com
 ([40.107.76.104]:35335 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kShfT-0004LZ-SY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj+qE/qWfZfdVXjv+ais51R7OFgYu3cMg2FiUh0fLveifl/bPSGqClLIMapyP+kSI+kWjTzBcEDV+vpdDYbSyJVdoH1zzi7u7l1f1LvdH7AV5uZTszXT5xts/sy80lrVbPKN2ttA65anb6BQSeuGjwWTrkPSPLYn69T2YkAc3SOfdKvc5S+zRQgHFqn4O27RyhLTwzatHxMBI7IXzYEJNspH5a6NWyhpIhNCOmz5JN8kUutpAzIX1lQYAv3HFIc1hZbArGxroBHDAQvXWelEgC/PqsJejAH8lFAHb5k+y9aXilHefVYa0AVFKjFyPqWPwq56ja4SJpXfJzHIDy3Pyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dfo6GqWQzoXIjms9xXSSLhgJeD6Nootr/io6pMWUIw=;
 b=FUht9c0tYq4+6ixn8PhPfBYinrvhpgMLz8iJSbTPLbImXLxh+gd1TA/qCQSuMwY9zniw0QWMWboMLDjIiivvRAXCdfbCniDMPz7vGH8hiJ1GahjHOVc7ycWoagtTUJ/y+BjXxr1XkLFzU2rTbllQs75uJDE0WvPtKHSPFVacN0/7RquhujufSkot9A1PePTQQsKcqRPPGQMjiSoWiTO5Y9JwH5NQf+tvpSQi/fkfCOnCj8XQ5mOk/oHf8N4yHfr+lZjczzol0zLLVgIxBoBxc/ByQQLOIsOjgIQKVtgzGDiCMQCVLFHHdM0QErIeMsKpbNFKbvdy1U+zBwhXNWXMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dfo6GqWQzoXIjms9xXSSLhgJeD6Nootr/io6pMWUIw=;
 b=snFKh2fcozIz6ET6//x01GyiWu7hCCCvE0JOhMaNfcoPtlR4aJERorrV+RLkpGBABsaiBnxupDAk8e/WGF29AmvoXN93qsjdCLvL2daaj8GMPUVPM7HYp4AvgzXQzyQTAabRzsrdYwZO1N0bF8r0kh3TrEHS6tFGSpgtJpajqO0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3518.namprd03.prod.outlook.com (2603:10b6:805:4b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 14:22:12 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 14:22:12 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] fuzz: Disable QEMU's SIG{INT,HUP,TERM} handlers
Date: Wed, 14 Oct 2020 10:21:57 -0400
Message-Id: <20201014142157.46028-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 14:22:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd92f05a-2d56-47d7-0653-08d8704c8ab1
X-MS-TrafficTypeDiagnostic: SN6PR03MB3518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB351890B92A7400E772B62A0DBA050@SN6PR03MB3518.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiH3y9ZLp3dwioXNGDdXD4A4kCrEQFIblXGjHFk/NIMbZayLeyRClPAJR5pgGz2XTjTMaHiMLAIIt1cWcsRJtNJOLh/RhEvlF1GYtHMU83r7hJuTSwosTiZILT5+OZV7/Rycgzqmmefdg6NomW9P0hF46eCLBG1FcAJD3tTrlJS2DEwWRtu0HtzuT+yjxVq9/mhP8X74E1paXbfxtVZxzdSHtt3pyEPLcF5z3WWwFoMxBMqcFCSjtjDQnPXWVzm7TCNOyMG8mWC+uQBpKQ1g8i4eunmQgXFUkKtOnH8Q3VkBoJ6D5s16gekY8s9C/tHu9RAKuVL2sYDoyNVWiVrhMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(52116002)(5660300002)(66556008)(478600001)(8936002)(8676002)(66476007)(66946007)(2616005)(83380400001)(956004)(16526019)(6666004)(54906003)(6916009)(1076003)(86362001)(75432002)(26005)(186003)(316002)(786003)(4326008)(6486002)(6506007)(2906002)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8c+QlnTPkch3EZb36lpyDVaavTSA5VE7FeUgBqzMlXI0rh2R0Reb8kZmj7JC036yBuBF4mttxV6ghkppoA25QWJyGuChQQSHy5F5mX1rHXd4zsEZtlbHsEXxO23XH5YmD0QdFMUlFgjVHdA5pr4K2x6vCfc/A5n07/nH+sgRlHqX379Mi6RBHkOxZV6xPNqPVzpHL1WofFOiSrOM1QhQ1rLNWs2l8YICJAEHeM1S9iQ+z29WTjqbVqFfTwyagpcggYWrqdBuXvPZ/6YI9JkSeWRmkXfLVfz0OjHPgmUdKaVNWMbrqsZdQeH6O+4jaBwSRX3Rc06apIwCLqEdpUeMDxmAP6JO8VmB4SgPWi+dd4v02T+sWRjzwEDkLOZT/INq7l2bBAl6DZpUwsoIuwH0loUeRcbvqfLYgCHK5knGVp+TrD5wEiTVwH0ghrRqh1CqpzsDMCGICE8dbLjG8/8LQJXi1Hb0FgtJVgS2A2zMM74DqDWxCyTIuwUN40cZrgncpTiHzqyM3RTRaK5BRsS4CaPmnFzDq5M88+xpmEQK21dsCpkMhznbWgoxH29qVADuoJ/ZUJXlln2ILu6whz18Ao/uOCHwtscM8RZad8UrAT+NTjRfzPpAyr8O9XGoJTpSCbSeerAqkMb84UqmsIryZQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92f05a-2d56-47d7-0653-08d8704c8ab1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 14:22:12.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOHAy8fBs7oRcA1vRLhl7vWnwT1VofvIonvlTZ4lEByexSUDxAc5GAJQLR9oOUSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3518
Received-SPF: pass client-ip=40.107.76.104; envelope-from=alxndr@bu.edu;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 10:22:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.282,
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
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to this patch, the only way I found to terminate the fuzzer was
either to:
 1. Explicitly specify the number of fuzzer runs with the -runs= flag
 2. SIGKILL the process with "pkill -9 qemu-fuzz-*" or similar

In addition to being annoying to deal with, SIGKILLing the process skips
over any exit handlers(e.g. registered with atexit()). This is bad,
since some fuzzers might create temporary files that should ideally be
removed on exit using an exit handler. The only way to achieve a clean
exit now is to specify -runs=N , but the desired "N" is tricky to
identify prior to fuzzing.

Why doesn't the process exit with standard SIGINT,SIGHUP,SIGTERM
signals? QEMU installs its own handlers for these signals in
os-posix.c:os_setup_signal_handling, which notify the main loop that an
exit was requested. The fuzzer, however, does not run qemu_main_loop,
which performs the main_loop_should_exit() check.  This means that the
fuzzer effectively ignores these signals. As we don't really care about
cleanly stopping the disposable fuzzer "VM", this patch uninstalls
QEMU's signal handlers. Thus, we can stop the fuzzer with
SIG{INT,HUP,TERM} and the fuzzing code can optionally use atexit() to
clean up temporary files/resources.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index d926c490c5..eb0070437f 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* re-enable the rcu atfork, which was previously disabled in qemu_init */
     rcu_enable_atfork();
 
+    /*
+     * Disable QEMU's signal handlers, since we manually control the main_loop,
+     * and don't check for main_loop_should_exit
+     */
+    signal(SIGINT, SIG_DFL);
+    signal(SIGHUP, SIG_DFL);
+    signal(SIGTERM, SIG_DFL);
+
     return 0;
 }
-- 
2.28.0


