Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BDFC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4DF2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="cs6ENqWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4DF2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dJ9-00025F-Re
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBi-0004O1-IB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBh-0005x0-GE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:46 -0500
Received: from mail-co1nam11on2125.outbound.protection.outlook.com
 ([40.107.220.125]:2574 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBh-0005wh-8y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxoS2300CNo26rfOKfm1hkk/B1bisCBT56gDAcuLdAeo+3Kd/RLdBwnHXXnLLk9vY2E2ElgN4CFg9kktqAD4XNo7p4gUPQRHTjF5rHXZlIWgAK9YsGhnckwFcg4uJAEs9I8Wmu80ank/ro3NCbNfHlP4LdMzAcDQSPOhepflYQ2pB5UElyEaqOdrV5N1oizPqvv1KQMko8BGhTf/wV0dtl+volcqpSOEZYTmNVyozhpS5ZAEIgbmMF7aYxPD/qQ8GRNT23NUZblpZMIMDFN7PbFTNCtFU7Dv5QgpqzAKknLeGADxY6QXrzd2q6CtLdUMkKyNCKcjNhGSDrb0x7t10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAidgwmCx9R0FC/cXsWTjZAqBx55lZLV5BnNnzQDp9s=;
 b=Zu6PRV4MP8zrsoayHZW/YvjcVFdQeIlyIQOgsqYDwYty2MyRCPT6SE7Z1dY0+JHyS0NjI6lsajvAF+/smtHBALQBr3mhZ24raMJlozuQ3s6DbbdrTUqH5XUA1zN4p/naSQKf2a+7oOCC56ziGQHpkOnLNXC1zPZb3WP7yW+mklO6oznO97gJeMPVbAp00VV86OX2SP68sbwTCw0okCYIGEs1vmrGsdAXr+ZTrfsFiT34GjVNAThl6Duey2IjLfqCh2PVHe78/JqAjm1haacb9dOhuWa3YwIT1A+9PMFSOWDNKDlBL1nHws8muWxXu0plD/BugEjFMD7ACqF5Sb+FYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAidgwmCx9R0FC/cXsWTjZAqBx55lZLV5BnNnzQDp9s=;
 b=cs6ENqWrLR16MhFntNZiRO3RwMeCHgyNO099ua9o1vMoZRrtbZTLp8iYkGToQPMUr/fM5zQUkGJRLqVpbuCTEsvmlsoEud4iW2ASntjkbsu5Rmn+ek79cmF4w4eO6koEsZ5PKXe/QoKkI7ImcN7Bfjm/0AVIgCxjx6mduvzknfk=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:43 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 08/22] qtest: add in-process incoming command handler
Date: Wed, 19 Feb 2020 23:11:04 -0500
Message-ID: <20200220041118.23264-9-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:42 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69fe034c-10d7-4149-06dc-08d7b5bafe6f
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38078086006CF18F5858BC51BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xo5auTmm4Z1rAlhLrR6TT4rCsoxoahjWzO7itMRbmB3yJ+VrI+HJLb8wk/L6VETMMdreNUpcDkEG+GkEGYrIxK2jgZDgNEfLG3PTSwRT7IVpSS7fhai+TMvqdbh4kKl1aBe3Ge5ugI9bW8uRpb8R/RXw/VvFmoD0y2oNBNq4WMdZHlqDMuZInFTl+FruizgWgA6Uuk5/626wffQaaBRWA3xycpB2U0B4iRaWMjB5duqME9KWm21+ql48WYZiVil7f+ZuuMk9SvlAgiDkO7L8KDqHoryFHc3C9qHhuvexD7wSOm/LemAf+clcdeHLLi7hjs/60GEZw0y9MEST3HCu/3tcXyRWXK8yQGDhECSwACzUGr3/h2dE2Tf0cmqTFWdVGvH2QwiREXUMzRbOI1qHovZdlX21vhpIuYQ020n5QOr7RwEvJ8fsuuNg7v3DTv3N
X-MS-Exchange-AntiSpam-MessageData: EmT+RYNJS4FYnEcPq1qvBkRRZR2SS1rQC0afr3pAwyNEkwKJb9XXUG1T8NtCyvX6gxszhnr2enK5rGRcOyvrPljkZ5vkkgiXb6XMPBavfdpCXKHUqo4MtVfVX5lcdSrkObc0h1Uv+xDIt26pha+dLw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fe034c-10d7-4149-06dc-08d7b5bafe6f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:43.5696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5Jli7XPMR3UoFRODyuOtREXh2W2gCmcwIjytHgyZDIDYq8HudJqPunl2x175VTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.125
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


