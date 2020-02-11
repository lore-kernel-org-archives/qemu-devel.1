Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08412C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1B920659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="BF1Lay5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cMF-0007wx-Ul
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFx-0006WU-Rn
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFv-0008LD-9k
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:40 -0500
Received: from mail-bn8nam11on2135.outbound.protection.outlook.com
 ([40.107.236.135]:55392 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFv-0008Dh-2G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrrtwt1fmFsMwI3QFJ8gQ++uNKo2HkkYv7XNcvMGxrtOC7VkIhoMkdDKMNCnnAlCl6z/8sqApDX7HeBEyZpy0p4yd0LGJbrdVYghmdvzcfzMoKSXTCdY0Wyf4Ex2tIZlK5cjDykvYqTSrU6brDTMB+Qj4S3u57u6F2z7yHjSmEgbOx49sGfIkGaSEJovHAzt0TwqBA2rmBDLZ/7L1mtk7uIJTBXqikgFOuhlvrfeMNgThVlh58bT8wyVwBDcmdbbWCdQz9+CK8v7XVUJIdJkytPiN2c4GiV2J4GahoxJuc4iTBvAl1kwNoWznL3CclZlIql3qk3e9KBNbUbpP7yUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAidgwmCx9R0FC/cXsWTjZAqBx55lZLV5BnNnzQDp9s=;
 b=CgrTOZcPT0GnXYQzOof+jUmCxK2gLdtVRNdi5rLNDSKkrTAaF71TNeKles6gwfWF/63R8ATUAqfob/jNZnyTH3JQBFWSoMTVFF5/WkdaqBTSIq4bZOxKxfEzfBrEzhTPpQA0/aQJJlHwfSFFmqb8ZMj5Z/HWab0TUaLVS1vrEWeZQyVfKkNx+x7KsnSrG6Ar3R25UgkDuRlvBbxWSGfRHf2qnBq4XkBPboFJrzbq8DqmISL+ZHPrTR0QCDWnLSeIIm9uwgw0c12IBuNgpfTPtWk0kvznosnPM9GfnAgY2QMmJ0nj6A9iEC8t9VFrXBqdUaCN3FRvSVIxJouNvDmwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAidgwmCx9R0FC/cXsWTjZAqBx55lZLV5BnNnzQDp9s=;
 b=BF1Lay5KYkrMXG08D0TEwNABNUXGD6cb1gZ7EGYUi6uWdvP0WJaKTIL3KMFxmQzXr+pLkZxIJuUM/w6vWcAs91EaE3V4dd56zP2y5tQ1evxTnhmEiqjk4cSLUwD+A2cnQiCxmqYGbJCCAaUsZN8zlhI3PEmmHQWckgXDTtlVu/4=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:30 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:30 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/23] qtest: add in-process incoming command handler
Date: Tue, 11 Feb 2020 15:34:56 -0500
Message-ID: <20200211203510.3534-10-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:29 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18acee9-847e-463e-79ac-08d7af31ef40
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35990315CCE82DC104A259A6BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(54906003)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajNCzpfTtzPxNIRlpJbJaP6tU8Cqdr6yOonrj3TsH07nRRcOovoF0ZpT+c2f5vM5E5dvneQkpNoG73du/caWJcRvJeOZ0VwFDgsyedEinxfHlKpjmt0VZfQjAl+DGqC8fEqILLdUA4PlVVMr9QY8D3SGCXSABBNUWZ6fSvlJjaaQsSTuhfAORmhp0Mb+SZXGp4/jR98vmKar/wGHzIJxJbizzyI31LpZpAZordgnRMQeqCFG2nt/5dOqMZCqgFRIdaIJcH0OdyPW+vW0gITONg0G1wUihuLqJDy9LZ6YhKY99gUGVTebBuN25fZ266iBmXCEhZBRebHqF74Fu47sr4dw58yXThSYb1s2l7bWGdaiuA5F6EkCHK/CwkLq07szoIpP3q1Q/tyx872qcXZs1VXqkVDPIbbLaXd6k3sp+fZ1hBPDVQ+Fal+ctB7Ysl/w
X-MS-Exchange-AntiSpam-MessageData: zKu72KJGboI2sffE5JzVoMucQmB/Rj7V+1Hddr/Z7dAD4qK+GY5gEp2ghuXZLemw//XAhP/oKE/M2S3o80/O7IXUI99DMjpqNxSQejJG1aFPA4MSQ2JY/RHemFx7nJxijRPrEYzxElSuBtrm6a7hdA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d18acee9-847e-463e-79ac-08d7af31ef40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:30.0391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BaIG2eFyHykOZChkOFolQguKMaDuCtw1h6jgXjJ0+ifaMz/CigHApHFrFKa6lOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.236.135
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
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handler allows a qtest client to send commands to the server by
directly calling a function, rather than using a file/CharBackend

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 include/sysemu/qtest.h |  1 +
 qtest.c                | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index e2f1047fd7..eedd3664f0 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -28,5 +28,6 @@ void qtest_server_init(const char *qtest_chrdev, const ch=
ar *qtest_log, Error **
=20
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
+void qtest_server_inproc_recv(void *opaque, const char *buf);
=20
 #endif
diff --git a/qtest.c b/qtest.c
index 938c3746d6..ad6eb6a526 100644
--- a/qtest.c
+++ b/qtest.c
@@ -803,3 +803,16 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
+
+void qtest_server_inproc_recv(void *dummy, const char *buf)
+{
+    static GString *gstr;
+    if (!gstr) {
+        gstr =3D g_string_new(NULL);
+    }
+    g_string_append(gstr, buf);
+    if (gstr->str[gstr->len - 1] =3D=3D '\n') {
+        qtest_process_inbuf(NULL, gstr);
+        g_string_truncate(gstr, 0);
+    }
+}
--=20
2.25.0


