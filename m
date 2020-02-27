Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C0C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8000F20801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="LOBY6Ct1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000F20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79eU-0006H7-NN
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 22:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79dZ-0004xz-RR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79dY-0002vM-T5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:57 -0500
Received: from mail-bn7nam10on2112.outbound.protection.outlook.com
 ([40.107.92.112]:31328 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j79dY-0002rw-P0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3mvhc6J6pLgU4V4n9aL0/YZx+hhOansPotHXtdi1Ks2SzDj1rAoxVf+FKuYGbJiryoLhC26JBmylKiEWpZ9TtBO8PkTkNTDCFvqvFdG8QCXTm0E4KzEp4cAo9ZanMVx5qVDifCtVgtrLmpwNBXIs4IxePF2EvxRYuLZJgrsF6q6hg5Mr6yGqD6pdPqvdfKjGJ2Zt8HOwhDtFxJv+ROhk7GdrPzfB4/aTp4l+mzSlgHR1z9fx42vo/8usxrokImBOOtYYdnYrk0BTgAIyTYjnDEdif/qQVaPtGByEhFCVpjjuTWWL3AwjEK0UQCPmTLA1W8RPqgD+PBGNex4sI7FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmmjwsQsOHhLIwuoSBy3cDXimQrSsDiGMU74PF5r8to=;
 b=kNMV1jhpcyah0l6maWuxuXSdCTcBiXI3iI1HW8N8jV4jgxQrWLtrs89B+/zmcqwy+yyFkPrS5k7m4hK7WQNnRCtAQqc4aRGqpKVJPBkqEntYh2vOU0PwGDKectoFNnwrGE2lpjSqoxZb8TTQZz142/iMaRoDFI9SUBeB3QNZx513GLxxsiQsbRfTejE5ZbHDkuVxKg2FC/TjJ3TAQts9PUXoPEa8GLS5JfGHEgHYkX/nhZB/D82WRV2N2SjvDLYrXv1S0lr3Fli1dcvPXOhqsLzYo/rljsXsjYvS6s2lzgzfpync+seAy/Dd/o/kl/mYkq/tPNyRaj5JHn21qblDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmmjwsQsOHhLIwuoSBy3cDXimQrSsDiGMU74PF5r8to=;
 b=LOBY6Ct1vPuTKgUUWMBmgZc+XLXV1FLZ/7gJbjD/2al7IUJON8T5Ix/zR73NbnJlDsRDjC+b0ILQO3qBw9FtpBovse8Dk8AvwI6octGvOrvm/sueAZxJtLXwzgHrAPupcQ3QrcD4RKsPIlkvh0E6BFdYFeZRtt6jwUr/dGaUi8w=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3582.namprd03.prod.outlook.com (2603:10b6:805:41::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 03:14:56 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 03:14:56 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] qtest: fix fuzzer-related 80-char limit violations
Date: Wed, 26 Feb 2020 22:14:39 -0500
Message-ID: <20200227031439.31386-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227031439.31386-1-alxndr@bu.edu>
References: <20200227031439.31386-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:2d::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 03:14:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4296dc5-93c0-4c91-e852-08d7bb333848
X-MS-TrafficTypeDiagnostic: SN6PR03MB3582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB358292B42A5550C1812FC9FABAEB0@SN6PR03MB3582.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(52116002)(7696005)(8936002)(86362001)(6486002)(6666004)(66556008)(478600001)(4326008)(66946007)(36756003)(66476007)(81166006)(81156014)(6916009)(2906002)(8676002)(786003)(316002)(956004)(2616005)(5660300002)(16526019)(1076003)(54906003)(26005)(186003)(75432002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3582;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYfLZQQGNwRpf9525+nvLxbQflTqDNpY5DKeZM2jjfLjwlrF1cj91kWa0/3w4tTVCNycNZWdsEjfAoFu4aafm3PgAWxuO2WoEFE5P9WWv6IRfUMgOxZOkRReLHUD0XRmT6+h2FVSfvsn4AsVVw9qP8KH5c16SAxCRCrVMD8uHBxzjPr88WpMeXhe0YNtHvLa1/VvmxUpCGiZDQUBRb2sYYwtShrEwpd5Z8+Dy6erVIb9jZRghZWMssssHBnU5R2yDCdMRMdtdM4xD8VjpS1kdOBURk+NQbVS+rpVBjxMq18/LuheqQxhmXlfFgU2pht0i8U2PaQMB/LUiI3CJ/nYzBeHjEoPRWdcSlZD+NnlwR5HkVjZQF/OXzrtnJuIHgMB+KGU99ruLZYsiMVGRxnWN363vMuCGKj3cJ0LscZrIscTeb/T3EMqkkhoTbqi7Uab
X-MS-Exchange-AntiSpam-MessageData: 1M3Unz5RPQDeigLqxUkxQ174tgQWW/XDvvU0CgyojespKXzH4hkPKcn2WpglhTujfkYTc8qxqLu7bwqtPCWqkizBmQPm9yHk7V9CjjQ1wtoKZ3f5ZiRTdzC5a2DLgZEEFCgQnMzJMQ4YLsAq+48NiA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4296dc5-93c0-4c91-e852-08d7bb333848
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 03:14:56.0411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxxviAfYHDnrBwrz9Ot3ieL5ewYUZxU3YColMHEe6Z2/MAcJALr6/yBf9xujwhK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3582
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.112
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
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qtest.c                     | 3 ++-
 tests/qtest/fuzz/qos_fuzz.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/qtest.c b/qtest.c
index 1af4e1b08d..5672b75c35 100644
--- a/qtest.c
+++ b/qtest.c
@@ -794,7 +794,8 @@ void qtest_server_init(const char *qtest_chrdev, const =
char *qtest_log, Error **
     }
 }
=20
-void qtest_server_set_send_handler(void (*send)(void*, const char*), void =
*opaque)
+void qtest_server_set_send_handler(void (*send)(void*, const char*),
+                                   void *opaque)
 {
     qtest_server_send =3D send;
     qtest_server_send_opaque =3D opaque;
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index bbb17470ff..1a99277d60 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -120,7 +120,10 @@ static void walk_path(QOSGraphNode *orig_path, int len=
)
     QOSGraphNode *path;
     QOSGraphEdge *edge;
=20
-    /* etype set to QEDGE_CONSUMED_BY so that machine can add to the comma=
nd line */
+    /*
+     * etype set to QEDGE_CONSUMED_BY so that machine can add to the comma=
nd
+     * line
+     */
     QOSEdgeType etype =3D QEDGE_CONSUMED_BY;
=20
     /* twice QOS_PATH_MAX_ELEMENT_SIZE since each edge can have its arg */
--=20
2.25.0


