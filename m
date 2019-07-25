Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942D1C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6551222AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Cyl/QuNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6551222AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUOx-0006n0-4w
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMG-0004GZ-TJ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMF-0001qs-Sq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:56 -0400
Received: from mail-co1nam04on070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::70e]:20866
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMF-0001qN-MS
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjbzbe5QCAIJGBOzmBO+ZpH0bnGo3gBWIwzp7epyjIPVp0qxJv/DLKZugGE64W0y7y55lQjuQfG7tsWTHJDHuOSibx6TJU9D62GWfod46QihIgTIwqqVrKtPE8MSj7hW5gQNZvn+HMfx8Tyj4rzygDFPNNyeUR97WJlVu2NLC66Wp6oY25xDSRmobSU0IPL8WkOnZqszmNU+CaYTwzstFQzA+EjGp5iXx5RVzK8N3CbOPWmDILn+E6XOF/6/u4K1qmdoSmLw8977B7vnxF76imDEgsg6D46DuuSnYIOIir6axTXNm/stg4dxL8iq0SI9ie+GLPNOErqj8t2yps3f5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/38ezUuNsRUe47fY6wTbPadWihiYh1TxSruuZFHFbL4=;
 b=LITc3KUoOv5tOvQPO7nheS2Xwy9XcFeh2wLudRGBiszZkS59AcVkEIRzA9XClfPObfa0uP+g8A3taywJTZxhm+3XjhbI+kzo0tciaGBnEoznClm2nsunD3LHYcE43y1BFmx8eXEAxzAKCZnWW5Ed/BbNZUorRkvOJEb6rBXrg1Qo7/Sr7+PZrLxYIQ/GUOnSjfiFvLa5PYNlSPwrK+mtoMx1FKd+vtIGP6O5pGMlxdYqbVVm+u9mmNhYPAoyGBWT2HnPyCRtKnAHRYC40HcXLM7/lJIb/xM1aEUdldPXDWiHgc85CifVdYFU1aUMGUcjRQY2A9RV2I3NNMmpsOQFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/38ezUuNsRUe47fY6wTbPadWihiYh1TxSruuZFHFbL4=;
 b=Cyl/QuNT0C2yWvqwlxEldXTL15HIUKPoMLQn5aK9Hgt0mew4E/tnpMqNn0d1FBOvOQatsPTjVl0HFxYNydipxKonyVeoJV2UbyO715Kh9QsBH6FuPiDPXq3aavCSy9Xx+8ixKbjgc1lOXaPcLlKOitPF4YBBW12TS4qNJBLxpGk=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:53 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:53 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 11/19] fuzz: add direct send/receive in qtest client
Thread-Index: AQHVQphi6RX4toOzHUaVS5cIdn5Dsg==
Date: Thu, 25 Jul 2019 03:23:53 +0000
Message-ID: <20190725032321.12721-12-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66faa6e5-45d4-4006-a8ae-08d710af8515
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB2726AEE1C2208534CF93E0D5BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HIk/EMECuwAf4BobJsXtFEjnWnqlurfFR9uYqC8fKIg34CAY4sZs0LxleSBUGH74CD8M5dTAR9wjjoFC9SU0Z138iNSXj5E68lso7t62y6QjxT6v/q5WOd3CxP6bFBIpvNpnIGdLjG8PTDHQSI9EVbUDK91JSABbvJ+K7C00HaWfTSd/EOC6vFgSx60CnP9D5lrZhbXJOGx1oHg4knZjM8nA+IkmpAigJU35UphENa5jEyECffMsL0I2kTSYj/+sxOzGD3lfnnNtL3yOV84EGkPD1w0obJUlO5XKjCDoKBpD/bV4bOHEW30zCwPXKdXxQPKWJ5cDi94nprXqdnpWmJB92frfOy2SqH8pIvohbY7NPqYXSu9Sn0WMyqF8dJ3jRGtjTdskcFFpanLintwStGS6YDV88hqWhBswCE00O50=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 66faa6e5-45d4-4006-a8ae-08d710af8515
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:53.6214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::70e
Subject: [Qemu-devel] [RFC 11/19] fuzz: add direct send/receive in qtest
 client
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
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Directly interact with tests/libqtest.c functions

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 qtest.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/qtest.c b/qtest.c
index 15e27e911f..a6134d3ed0 100644
--- a/qtest.c
+++ b/qtest.c
@@ -31,6 +31,9 @@
 #ifdef TARGET_PPC64
 #include "hw/ppc/spapr_rtas.h"
 #endif
+#ifdef CONFIG_FUZZ
+#include "tests/libqtest.h"
+#endif
=20
 #define MAX_IRQ 256
=20
@@ -231,10 +234,14 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const c=
har *fmt, ...)
=20
 static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
 {
+#ifdef CONFIG_FUZZ
+    qtest_client_recv(str, len);
+#else
     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
     if (qtest_log_fp && qtest_opened) {
         fprintf(qtest_log_fp, "%s", str);
     }
+#endif
 }
=20
 static void qtest_send(CharBackend *chr, const char *str)
@@ -748,8 +755,11 @@ static void qtest_event(void *opaque, int event)
         break;
     }
 }
-
+#ifdef CONFIG_FUZZ
+void qtest_init_server(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp)
+#else
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **e=
rrp)
+#endif
 {
     Chardev *chr;
=20
@@ -781,3 +791,10 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
+#ifdef CONFIG_FUZZ
+void qtest_server_recv(GString *inbuf)
+{
+    qtest_process_inbuf(NULL, inbuf);
+}
+#endif
+
--=20
2.20.1


