Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1E6251FD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5poUFB4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1E6251FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMUy-0003px-L3
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSMTq-0003Bw-Iz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:44:51 -0400
Received: from mail-eopbgr760102.outbound.protection.outlook.com
 ([40.107.76.102]:48835 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kSMTn-00053y-57
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a520d+aj6Oz4MAgTx3jiTiKLobPg4Y6IqSiRP+lv2a2SkPzsTIuMbGJmOkxRwlv7bzHkvbqm0o6LQCR00xaKecuNshg7S5qgV5/k4AzLevSVc6vKz/fm2DE2ZwLfHkAKRrkfHWyF+3PJjaE4wR7C2AMpo2E3i4sgRs6tlFlfhUHF//5MzRwg+IxWXUj6KWajFNffv8TU3GJq7HEJn9UGBBigtuQqQulLIx/wRCyASo730C61aA/QnBRSrGry+3pvePEZe9YeNzLTthHADuGHzg75zsZfHZ6MRLxjGVdqvugwEDZYMWCQJ6vj74fgaceszayrnvfdFRuMXvRCdO/czA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJD6p0GPoGIE+uGyOXyIxoeviyQ7sgmck0mmxuehZQg=;
 b=iY2hfa0wJt3X2PoRwnW/93XFBZwuZe+UDZZC3021Xm9K68b7Uc82Fp5tKNJ34d7dyOygiVv+vw9UWhXk7AYZG9Rjcr9Qknt0pe2VVyTBy9StwiPRKY6UaVOFSNKbhWnC760dvnm2K4SCr2ib/hB7OrCNAGEHvmpV+0JQT/6BvjyDj9BCUeJzntGDUeWKET4E05xpMSoV8xpGUHtktgJQm+KTdsMjYg2YFwOin4N6qQFmUfPOZ5opnnMhg9Ge2VMDp9UcCnyDdcMsaTojWxzeWBq7wCz+ytv5Ybl0f84vJXZuabL+GzFO8G++2WU3r7buyCVeUrtkhqzOs+zcPciFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJD6p0GPoGIE+uGyOXyIxoeviyQ7sgmck0mmxuehZQg=;
 b=5poUFB4TEFX+mHFKsY4jy1N4qY49gMeY1xbcpZY4eLmfPquMBeoog+WMEGrgrKBkYVLBXWDmflKdPcTXX9WCIFDjDJQR+MD2NHtMuRIiv03mi9ps4hKztoUbwnKUukJ8guZIVWr2HCI20BWo1bORiaJArfUux9NWVAyxacobx64=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3984.namprd03.prod.outlook.com (2603:10b6:805:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 15:29:40 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 15:29:40 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: Disable QEMU's signal handlers
Date: Tue, 13 Oct 2020 11:29:20 -0400
Message-Id: <20201013152920.448335-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:208:15e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Tue, 13 Oct 2020 15:29:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 222f7c51-7c4c-4d1a-c4a6-08d86f8ccce6
X-MS-TrafficTypeDiagnostic: SN6PR03MB3984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3984391E3B3B7CBA8E146367BA040@SN6PR03MB3984.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FNJuBS/fffEKxEovDJxgEnPEDgFcJ56VhgO/DBEaphGuGuI9EhfCnuX3k1HTnktUhE0AYLvg0HookVE+FakjjgSNRzw1K1h1JjTdi8njePr6P/TvMBkTP7y4hvqH8ORasPQTpLgeouiOGg3FIuhUI2HTz02kAL9XPmzu/KOVfifVpCk8xYMVLMX2kTmRh1KVsCxsuDwbAELrN8sPrdhMYmZINJMf+ixp74jjLNX+l/KnmdIGXoMCd7Uz5qoRDaPP2RRbxF2+VEHwNW4UzHMPk1QNOE7zaBUZE1/IrVsHg4hXWmI18CAIlkqUGPuMFpFH9QgrTPWZIXYH/w8MDVOow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(6916009)(36756003)(26005)(86362001)(54906003)(478600001)(6486002)(66946007)(75432002)(2906002)(5660300002)(16526019)(786003)(66556008)(8676002)(8936002)(186003)(956004)(316002)(66476007)(6512007)(2616005)(52116002)(6506007)(1076003)(4326008)(6666004)(83380400001)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IrqEuiKUFnjANv4HRKvzdLAM14UzcIi/CWvMrqho1TaZj4J9ONbZuZXHuA11w2C9zwKMu0flCoLC5fOBkjjDU23orOGU5wDoYCu/j3r4Ns2r0obyEF5o5aSL2NF6pfgMRwwDKYuo5Q2FCYK/C8FtJQzMFNL2Q7QTdzaRUHatLaiEjbjKIviqVqYXeQkuf/CXvLm1hRmueoprxblZd5irrJrctFV0I7hAd/qbUPr79IhdERKTOa6i06sC4DVNVcb7Y+PWI7f60FCUEnDqO0XQogyxSQS2i59s1uPzP0LLFHzNo7dE9oPRVqPOkAQQClaTyVgxLwuBVMGML8nrxtyXR0eWVBpKwWlFxNst9aMZJbCTaefIi6M8MciYFqwqe5ywOB7c+e8vEvDC5oQM4cb5US5546/HPsv82zJeH9CtK0o8huEPEz7IANdyQJkKc93CNozmCOy8yasbWcDPF2WYEGwkBThTRAaFi03OBMvg+WrfwbQ9sa8fByPR7EmjA9YoLseynpjwpNmKbAJWw03sBurDB8NbG90EdgpUCYBL43L6LLJ0Vg9ybQZzCU+MgHu7+dO0GiraB50qTgzkRco9+/frTWAGojudaRGgK+58RCqeru+h+Vebz/AiTPwHBk7nu2cHqbuGv8trh1x8W45EGg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f7c51-7c4c-4d1a-c4a6-08d86f8ccce6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 15:29:40.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/gNuNiAHdgx8tPmecrKEqkMiKw+NdLcl0du9cz1bZxh5dnxHiih283/yeN/3dwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3984
Received-SPF: pass client-ip=40.107.76.102; envelope-from=alxndr@bu.edu;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:44:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.44,
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
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the fuzzer, we never call main_loop_should_exit, since we manually
call main_loop_wait. This means that the only way to terminate the
fuzzer is with SIGKILL. Disable the signal handlers, so there are
reasonable ways to terminate the fuzzer and use atexit() to clean-up
after the fuzzer.

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


