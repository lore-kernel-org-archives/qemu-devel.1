Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4260EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B762464A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IFby7LyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B762464A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao3U-0002HM-Km
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianue-00005o-Qr
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianud-0002t0-Jh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:52 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianud-0002ik-En
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJs8aItvAdgKSiGb67EQSujuo1YMN4v+FdFtMerZeJ0chKEGQkZRzs7vgmW3MP2lTLwZOfDnsCzWBsC1XkxDIO2GiOwkibJ71ioIQr+roHjBdfgXoHwgLppIEN7fCaHXCJS2sXO4QsxD5ZQlwUxs1MJeJgVI9HqfMEhQrPQlaqYsh7QHzFI8cdjlYRpKmtwb5wqdkqHmvbCI3c9Lj7YtCGCkFwPOvedNnAIdrHyDrPbMDyI/zLnZAsdk33PdlTVll5Ucmzl10PKtw8W5wLoM3V7rHl29YRTHFhTrf2peJPuu7tQhsOxgMPbbkthxi4uqKKhRkcAkhoYiPBDm3XgGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haIvtUQ8AL1NrUC6qW6RriMjg9I5yJPf4gyKfSh9zdA=;
 b=iVjTkrh9xXl+/yQw1YDN0IPXQUBYuNRZhdCJRlUD0dcBMDSfMBkNVxPibn8XxWhIJMNZfX5Kszjbq48PLQBivZT3sy+F7wPdu6GtJaSlc4gYvedP01HIBTjLlZs0ma3EWWGwPz2URZPXRGpHbGglg7cYZMRvX/FUDM+bbC5UKAW3TmR9zdJwljBfUvpy3UP0B9S2ke34eiHo8cI1COft1qPNK099WtvrhaOqp6mt0PjeZ6lk+oChFeppUnBlzMEtjBL6ru4rZ+fgadPkWPyJTmn2IrUUX+xqNPpMSpnJMyBPYjATC/CQBdJshj8tPHEtyQgnV2D9MUJcQAeYjEt3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haIvtUQ8AL1NrUC6qW6RriMjg9I5yJPf4gyKfSh9zdA=;
 b=IFby7LyAtntc4xGx+X1FQAotwVR5E5w9QvKzshjAFa67BKpTkpCOHNi4KzVk941eVR5RPm9m/hUsB72Q/ckWGsrEd3czXB0yii+1MR+rCQArxVAxkGi9qn5AJBsZVIQ66DHjIZaRrICSh2ZqV98Ga85D0W7GHqn1q0+9e7tLKNg=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:43 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:43 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 07/21] qtest: add in-process incoming command handler
Thread-Topic: [PATCH v6 07/21] qtest: add in-process incoming command handler
Thread-Index: AQHVpvzQqjtaovJ18k+iCOY/i4ur2Q==
Date: Fri, 29 Nov 2019 21:34:43 +0000
Message-ID: <20191129213424.6290-8-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d80a64b3-3e92-4fe5-51c8-08d77513f2aa
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050F3B02FBF0D440D44E8AFBA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLYkqiQO+W+8QrRfRckZ/H0Vhiy0SioVEQrDbFmZOG5OSXdD0a17MpIyjC9ROZFv6RmZXo4988ly+QnXyEl09Yfcf7wUV5wE/sFqlTQtlKUlz8yR1pprmt74RkjDyHfLNtEfL97enHr5LrNqWttTAQbPWvqdi4QN7Au0c+jwuaJEToc4ZR77asLIykQVlr+1GehHnAE7qFc+GADHco3lbvT8UC1wib47j6ipalU1hL/H5s565mCBhNia7zXUJVuotXJLFNfsQQEG+rnET9oQB3D9Kc3rteD5F69veipF3eya27aQtTSxCu/RApueCQZI1G9waPKHYMmbLAoSoAd5Oit8Ci50vug3+6uvzW8Frt3rkp3cBtFd4zkqJZZlpCqHoswCGAsJ4hyzDf1J7OPlXDwhmjmDX+0GCeor53xuQKUIDfF5XkhpkWwicAUcbr88
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d80a64b3-3e92-4fe5-51c8-08d77513f2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:43.4450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5fmOtk5jUV/O8eeVPI+M7ucuaZAPMfWxEwpWzrCEjt4Zwj4QcYv/SJFLzddLd5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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


