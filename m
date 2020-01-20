Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914C5C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE602073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QQuFAISV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE602073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQJC-0002rI-2n
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1T-0006vg-NH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1S-0006Lc-JT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:51 -0500
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com
 ([40.107.92.100]:50976 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1S-0006LJ-Ek
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXu0FDJyTyX914mp4wG1TUX+ZrrUO7FUAB37fk0SzRfz+JH5LvgUxWweWyIlSp5kVjUkvY0CgQAI7WZl5q/ZLF0UvwJyvyLdDuWI5Hju2KnJfQEABuWGWFMdBexMX2qOi0kQHBiUcO0uBh1aS38L8SywUWRZ1Prtm00F1weqvNdV0gYnyZcXeQ6Vw2OQ297Zguv5lp0V9ZRBSbxPJrmhH5jNb5ZJt3FMUcxQE0IuVS3EfkQYKtYRupTbI/GjmAdkzFNyzn9RtFiqip/mCPVblNIeugvhixc3CLWINZQGdxNFdHm+KHppfOb+ylwFdIc8XF4j5ProKeGj2ktg5ovJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pyU+EWwWoz7a+tVKk2F3sx5oHPPmQUWy8kzp3v+g28=;
 b=c+MuDu8wPvu9ciEbAIb9fe//4mDx/uuKq1VUAPxfUTl8hWgwjv6gUd3saaWbRDt74XrtjfsypOihlAi9l/YxaP3r2OfjGHErCipJO1f6DE/En0WLDlqjHadiQkXo75SGkxevC4LWW6c5HuG2ysRKsZYo97tvslz1L7TrT7DMXxHBV68ycokWmvnl2HDEB/zQ6m3dtqiaiJ+QHglq81jg73e6eMQanx4uzu0o/uUFGoQDuyy22ifEnhvqwGwDK/EXHeN1L1f6VDZKGvnzrVCx8k4C9eq7yayF1RYNDYLqF24N71BBcCJee1fBOCAh2XdsSv8dF0vW4DS/x3aShZMaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pyU+EWwWoz7a+tVKk2F3sx5oHPPmQUWy8kzp3v+g28=;
 b=QQuFAISVCmnAaKk/4H0/jCB8E+EU5wKz1X4EsbMA6mLKRZXdS/Il2k8+xsgk5gxIoy0M7XGfNggaKuHFsBRkC6lYIHP4VCrIpAS75LbDTDW42TsCIQW7ArbwXCFkZnkfhiRr0OvSoKV0iZ20C0P7/Nr8sdlUxSxW6t4RKNPSB68=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:49 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:49 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:48 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 07/20] qtest: add in-process incoming command handler
Thread-Topic: [PATCH v7 07/20] qtest: add in-process incoming command handler
Thread-Index: AQHVz1YgoQju/shf0UaMzvpGLh31iw==
Date: Mon, 20 Jan 2020 05:54:49 +0000
Message-ID: <20200120055410.22322-10-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3655422b-51b4-400d-3228-08d79d6d4274
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB439920169A9D42922B73B8F0BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzafJe02tG9xcDredDAM1GSDYwafJXE3yA/E9YcTrr6M4hKr/Qkps1EsMZhokxh+VB6FpTRu2Xz44lKjK4mf9xrpXhY+5LBGjYFqROFlI/DUIvNghnUxkhrGHAuJYxfn17NGwVpM8iG5aT0MCR6WfoS3lJF3a+JQm/h5CAMAvkr8tW+5dcPCp8SP0TeA7xYLql3cDH0RJMbG5judkDcgeCJ3DORddVSoLjfqhDv8s+uH4uZyuq9DUQeUYNecrrFgNjX3dJ6dYI4gNQV1XavxF/JOToRheXcFtHBlz7q9BqhJiIl994l+n3drXEu8IGxoNFp5cuuG+knXnMvOnBRE9p9t7c03i/Y00BqDM71Gw/FneNPSdLCOlXW/3bOEps2hawZvQZBEYAQa9PmovcuSQmQZidQjNDbawp+h7IweUMnLiWWesRLSm5VAfaH3qrau
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3655422b-51b4-400d-3228-08d79d6d4274
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:49.0100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkuWTMVLwgQrx6LgECgE2a6Sj1atFDzJ1EY2amF68bz6kznndtRhO9GfINLqWUyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.100
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
 "Bulekov, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handler allows a qtest client to send commands to the server by
directly calling a function, rather than using a file/CharBackend

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.23.0


