Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5CC4BA37
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A815222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="p9bEFRR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A815222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79GH-0004sc-MK
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79Ep-00044Q-LG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79Eo-0003o1-NI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:23 -0500
Received: from mail-co1nam11on2115.outbound.protection.outlook.com
 ([40.107.220.115]:56929 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j79Eo-0003aU-Fn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqGk3OWKRsnQR9Uicrfqb1tV8vUEF3sYLdTgI5hWwK4cV18O+aj3wdr3siWd0IS6dYFtcjTnFds1oByYhywGaBSN6An9xHP7prJ/tkCK8QGhrmkFc3+KmoY+xouCrBvzDsC1Snrw7/ryR1CFR9SGztckfp1rj25toQWDJsZNhb/9OYtawhQUUNElJJlZombir4T4Jn1DuSY+PM3uVu3Tz5J3lZRUnfNR5IQLGqBdkdd6aaHvomCfexyf6izSANAz8JaLgA/m/iN5P+fp3q8jeqtkExmzKW0xz+dtg2fdoxu+LQ9NSdOx8Qmm2NpDz65FpK19BKFTKwulTmv2pUz2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jbLtLu2/YUO66r+bcCX0QUkEASyx45ywdaXcLwEGzc=;
 b=culG/UVNk25g8YqKTbwuVgSCKctZLDyyv7ZPb4133MUsOsAlhSzMSWeY8KTJUC1RHUrc3O/rgpNeiUighT/61JPatJAOgM5ZJHODfjo6vYWiid5RcyVki5cSuRlLXPKjTzYa4cCWQW87Ym3FoOXcXqcSNrUGzb2lPr8pcl48H8UKWBKtdwYMwB5f57A9R4yhelkwHZ7cA56l8YCcct06wFLLs4USejDi6ctGQ3JhBxwOgbaCtZ+EGUmoDrSUDrj5fDnzwW1tD9gJ3g1UJ96Zk99y/sbUtlvGZi2HfhNrZp53plZlcCT0wF5DLM/Hodh55CLDqwyzWbVPel6iBSJqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jbLtLu2/YUO66r+bcCX0QUkEASyx45ywdaXcLwEGzc=;
 b=p9bEFRR3JhguGGc2ODbLcquR8mYYRldZ5sZl9qjXK4SKYKIMt0PCEEIvoa7sRShKpDI7t76FH++8DpGx8efZYOLvDBXGutA1uyRkvPtuFB4kQVwqLU4TQeNz6x2M3lqOJbIYhIv9Y3CuMtquSyy7f7ldr/iJlvMLDhT69TPnQn4=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3503.namprd03.prod.outlook.com (2603:10b6:805:41::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 02:49:16 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 02:49:16 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qtest: fix fuzzer-related 80-char limit violations
Date: Wed, 26 Feb 2020 21:48:55 -0500
Message-ID: <20200227024856.23777-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227024856.23777-1-alxndr@bu.edu>
References: <20200227024856.23777-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0111.namprd02.prod.outlook.com (2603:10b6:208:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 02:49:16 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbeb9f53-fec8-4b5e-09ed-08d7bb2fa2cb
X-MS-TrafficTypeDiagnostic: SN6PR03MB3503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3503D0DECAEEC783662BE91BBAEB0@SN6PR03MB3503.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(189003)(199004)(36756003)(26005)(8676002)(6486002)(16526019)(186003)(4326008)(478600001)(52116002)(6916009)(786003)(316002)(81156014)(81166006)(1076003)(86362001)(2906002)(54906003)(7696005)(6666004)(5660300002)(2616005)(66946007)(956004)(66556008)(66476007)(8936002)(75432002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3503;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8+ZZYEHvdir1yRHDmuk5SBTCHRVmtRQfY2EmZivLjsJQXjHhyoe9Ld/NQlWADW5tjxuY6Esl19hmMFfHQt3qYmeLp3CGWkZ+syMPyJeTATEV/fSBLKkiiek6oCDvzRpiZ/i9mO2ydMpV2wNfcDruBkZjpB9nCy7RDsDm4krV3dO4MegEwBjkNCF7+oNIU8n2k16r7TJJNTSd/4JcYyHGwwybcN+lP2hKmANtEIoD/dtkeMCIU1nVzXpl20pOI+O9ag+hdbnMSTLPs7/VX+h8qxCDw4CILUOQbrsWeG2TiiBtoC8E3IKtkeA87/Iq/C+MoFO93NEj2Sx9AOsDNDBp0OfhEbfsb1H387+j4IDh268ydf7+UpPa9389EI+QYUVusvGHnabrQJMTEggXNaeLMwHbwkA8duCsWMJprvkHH8SYAcHwQrwiAfHOFqN5P1q
X-MS-Exchange-AntiSpam-MessageData: c+sgZcxfg1kI74KyYZeItqMomKxgjKTPUVct4mQH/8WbNctCxuX++bYkYFPlztOnt21441TPmEt7FN3+HbMh6c7q6Beh1sP5V8a4uP3lbzG7ur+QzzO2b8pBNa3RsDzW5oy4KGT2uKI8Vj3Zd6mA4g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeb9f53-fec8-4b5e-09ed-08d7bb2fa2cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 02:49:16.8175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/SbPKMulprItMuYlF9X8KXWRi43QCcWLBu8G27r16u8zY7UuuoQiCzQIIkFmgph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3503
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.115
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


