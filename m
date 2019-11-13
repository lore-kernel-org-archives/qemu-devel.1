Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0EEC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B49F206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="jQrfUv6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49F206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1Zm-0005HD-8A
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-000847-RK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007em-Le
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007S1-E0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imX14DRnOLR4YYbGoHlNKcLbBcjIJdOWn5oa1kp3e8QEMltb1pXuf1YjS7hRJ7hJElTf+WBITsz6HoZQ2h4c8+/AhiW/+2ddp0J+w/di/6q5Issk1/7qaxC8+RDIK47v5XGz39nBe+db4fQXW6mFTwzfFz4r5dCh9bF41GLnc6j1tGgrdNrrgXS3LarHGIUReazRWYKHM6KTli0JWWlT6c1dJaPKYK4UOwsitsTEBn43TWN9qArTfIEeLCi7GKaDErYpzf0lVuANw2tcmRuiMHsD9qax3SLmGryho64XrzlagxIdBJnJCgycmfgbGXx9rE84+rUbemeD4XRMLAjUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haIvtUQ8AL1NrUC6qW6RriMjg9I5yJPf4gyKfSh9zdA=;
 b=BIDDGF01CAGSiOxp2g3MjqLhJQ+i1/curp7u6jIbTayAE/lCvtuKAsjZ3BJmxQhLadBKhtb/UnlqfZhnfzMVpGqIG3rgdcjh02BUceiZmrbtiDlOUH2HS4wepOQozxeLZg6uO5O9F/QYGUeJ+XA+IVDlx3NrEhzyNd8BUDHd4XVczg6m1PWN2wghRN5uu+0xio6bZoV77pQeI/7PIYNl4zzDVLhZfeaANkzF/wdjpWX935FQUeofd2askjJRGd7YH4BUyPYNBzqyxquICGb7ECjRxRVCKP+CSd7+Xxa74YEssOe8Bgc5zipKgp12Flvdumrn6I2dgK5VjESVCG58pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haIvtUQ8AL1NrUC6qW6RriMjg9I5yJPf4gyKfSh9zdA=;
 b=jQrfUv6YGo+AZi8wzTc7T2NqU9JDSqe7HBXnj878Ne4zKP+N92CaFkGmzBKdA9FhNRREwkAOmZLf8t5jzJXRWaKxWLTaXQJtO47ij08xvb6TB05SnFBLJX3JJu/OghgXtPu8ARa93bKIyb5lMLkBcr6Q3jzMq7ekoAsz13Gs51k=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:46 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:46 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 07/20] qtest: add in-process incoming command handler
Thread-Topic: [PATCH v5 07/20] qtest: add in-process incoming command handler
Thread-Index: AQHVmnTJDI8X2ryzJEKIdWffQMq+7Q==
Date: Wed, 13 Nov 2019 22:50:46 +0000
Message-ID: <20191113225030.17023-8-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3486310-d5cd-47ef-b830-08d7688beba7
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB502403DF8B71CDFF10F5731FBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDaCquOXlv814q8kKLsQFv5quobeNwVE/l+lSAqR3h/SB+wru4WcjgIJ6q8mYtwyyC9IJUkkD8Zo1T1prBq521rZDFqBoMSCpmffb4LvcAM78IyiHeOFaROXQIOWPgv4f1C1eSERleOywnclP6e8xWjoWwh+8I36mu+NrVg+E26n51W2+PtGFSHHyN0ZXFw0rGkuJ8EBG1Imjrums0PjuTXuNYs015lw2T4J5GF6C1TGXKt271cszT2NFOiosNwar3MaGcqOpkPn3w6Sm8s1K2/Q3orCi/y1as7daG0K9Yu4DWq7bPwZtfBGwLlQj4Vj1ESBV0SwIH5mVl5qgDq0daqhP6nhelJJPWU5Y3NHrkmsRrucrOfeIeb3tmfc6ehTkHiqHco9fCnQYayDqUJBtVFuGstcAZewYoNp9jjq7AnYlbAGzZt0rhocbKa211b5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3486310-d5cd-47ef-b830-08d7688beba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:46.1693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dj821dDwjByQDL6UwFlFr4wqoDI1uOloMf7s8yi1Tb/o13+rWDAm6oTLd8HYcDub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::72d
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
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handler allows a qtest client to send commands to the server by
directly calling a function, rather than using a file/CharBackend

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
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
index 58d7e2a6fb..1db712d302 100644
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


