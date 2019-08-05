Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF8DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0673720657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fm4f8dFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0673720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXAH-0006Aw-9v
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9B-0003CD-0i
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9A-0001uL-0u
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:08 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com
 ([40.107.68.112]:40006 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX99-0001u6-Rz
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRFQhnA58qXacpu7Dt0zgYqL41UZ8CibMBzTRO0aJBGxTc0anqypg7rodbkj9N3iAsKZP28PW818y8dwCmP/yHwCEgpXKBS1Mp5ISBlw49YWEO42mOCUR3IwUE1NXrPCpaKdmuNqHfYUclmtr16rruVCstdMUNjVd9UDwe8fPvXdq2LLJ/7uqmhsQBgscA+OTG8tgyFwv1XjfWyv7Wi0Wc0fK/bCYREYM/LEprzZaqGQyElOIS/lpXY//yuLZeCTZa/s42pUsPayPkfDYTYn1NDmLZ8l2U4635vlt+j+Ap/4PZEWh/weeFU5jdlv6WBluCHVyeaTVyL5NPn5QvXjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPo2jorBzNS7JLTYMOgKt5ow8GLuV+SnADTStbJ+6cw=;
 b=AnEDcWf8JBGgMv/fiFKIiqP0jdw1lcJrfNVV70QtP/NDy6sEJ8e9XQErnrjYk2CJIM70zxAFpx+4b2OdtfofGzzfoHifHskvtg4InrPLLQO3laXYRMJhjfLJ4uAo9Ajiv2ds9Cnx+Wau7MuWYM9xAgCNQpv42nQ+YeNT4Cmqs9kZZrIoBZSLQw6NLAKtrxUax85Ccw80ESB/ioceLvCg5dpRPKq/mtD1jmn7XXFabzF6UEPmDfbZqcJSmBHe6PH0fVE9Sqrl0LaF2O3enoZJwdfFDYvXpifcQT9vVdpDOxF3/ah5q0zcemnod7oAnUsSjEzhyhKmrPgWIbDjAyx/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPo2jorBzNS7JLTYMOgKt5ow8GLuV+SnADTStbJ+6cw=;
 b=fm4f8dFTw09fN877sJBkIo7kl/xEPWC3MnAMpHXG+wO76JaVeUHZCmRfscLfLnbi0ADYXtCdUoWtahkfBag66tATITko6mxTIyX+utNxpJXsIR+0D10Gc88uMmxtyPp6aHE0qBGq5V6fCZi3aVf/qDixlitvVAMjBXbPWuIMdPI=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:06 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:06 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 05/17] fuzz: Add direct receive function for qtest
 server
Thread-Index: AQHVS1zz7ZEXlCSwSU2E4rI4fNWZTw==
Date: Mon, 5 Aug 2019 07:11:06 +0000
Message-ID: <20190805071038.32146-6-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0560ab5d-e7f0-48de-d916-08d719741596
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646D87761D9ACBE3C911757BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: avRfaVlcf6WQYgMyo5e/Fuh0utj/tFDnHjOkHavx1fK5eIIDFvGhtXMJ2aL1NtWP+QD7oi/ZNQ99mzeSaSquogQ/nnx3BY9jbOzXplTYxaAzD9f404ZPxSAQ2CrsB1lsGncjQNn0Xv5KYWSmnzeiQsWAdpGY0Ik/tGQ4HFkkbxmIwNy7FMAfltAO6QSJJzgS/y1kzNXsvy1o4lLxTvzxpbdB4+kZL6nZ9Trso3zExY5R9JFNGEy0gb7kIWQ2BgdPoVKjeinGnKCIt9ZciYhyJx7ERURwW4VsYqjwyYeqWMH9maGKExrAzoPYM49fIBRQQrCNzfrQEtSU6I15/I+IYDJbtY2X4m9nLHrdjFEDM7yW1tVg9bapZiImF2K5/KtZSn5+KdfQ+z8duaLxsOw/phPNu6s+gFjQPOmOrwY3ryM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0560ab5d-e7f0-48de-d916-08d719741596
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:06.7961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.112
Subject: [Qemu-devel] [RFC PATCH v2 05/17] fuzz: Add direct receive function
 for qtest server
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

The direct receive function qtest_server_recv is directly invoked by the
qtest client, when the server and client exist within the same process.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/qtest.h |  4 ++++
 qtest.c                | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 5ed09c80b1..a7b7a3081e 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -26,4 +26,8 @@ bool qtest_driver(void);
=20
 void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp);
=20
+#ifdef CONFIG_FUZZ
+void qtest_server_recv(GString *inbuf); /* Client sends commands using thi=
s */
+#endif
+
 #endif
diff --git a/qtest.c b/qtest.c
index c9681dbdf3..427e1e5076 100644
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
@@ -760,6 +767,7 @@ void qtest_server_init(const char *qtest_chrdev, const =
char *qtest_log, Error **
         return;
     }
=20
+    assert(!qtest_log_fp);
     if (qtest_log) {
         if (strcmp(qtest_log, "none") !=3D 0) {
             qtest_log_fp =3D fopen(qtest_log, "w+");
@@ -780,3 +788,9 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
+#ifdef CONFIG_FUZZ
+void qtest_server_recv(GString *inbuf)
+{
+    qtest_process_inbuf(NULL, inbuf);
+}
+#endif
--=20
2.20.1


