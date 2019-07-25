Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B11C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFCE22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="TKqFXV2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFCE22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUNP-00008Q-40
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMC-0003ym-Nl
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMB-0001ox-Iu
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:52 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMB-0001mt-CF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDOKuFKD8L9/T239lCYSZixMHe2Z84+jFXWJAA8tpwoYRUBWWGSV3hVYfsH/k/3RIxkn0tC3vu9jDTa+bMJnshZc7hifC8NHUCr4VX77C5yXCQUWjfvm6txQ4N//Q/5PiDAmPWKvwFGHqSGLZDbgL5OPOo9Rj0LY08Erd9BfrMXazfOvT9lfYTidA9lrmnvkgdiQ3uuIBhusnpaLaOjb32G0rXkVCzt7xN800zKykxuuHdKxRj0zkbDcksik/3/szcOzC+1RltLQzW6ndJF91bVXug3I7FGy8pM7SJRKEKRgIfT+l3Rc42e63kyoqijay12xcW2nS+exw/F1MSk26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYp83DgzQi+Gq3/Is3+1ZwNdFWACoIiDCSqxanHxsyY=;
 b=Pl1MWGUtc6SpcDso58JvfYmkgzdNVHN4cdf1XiiPJYc5AobW9L7+R9I/p2z7A1eZTy95CjRl7sblHz76ENDtg9qQKTSB9ymRoYdKXiDwaCgowiQ3GFZtZ9ox5ZvSiKNvGcBmelV2lAd4wHYSh/uzXEi2uIJ3X4UpB6m8X/WdKAsNKySPRRRDKIy531ofcPw/SqvVaE+s6tDI1iCeiU73ixujEy4C50VEvkM0vUobOYmF0X5SRUEcuqKqFHb4CSFXyGf0q7ByFVHn9yr1r8Ez93gD4238mmhNpq3zeAK5eXXBPO2yWTPaZTTb+ym5zpkmx1YIxzw2Vq0DiV6WxMwk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYp83DgzQi+Gq3/Is3+1ZwNdFWACoIiDCSqxanHxsyY=;
 b=TKqFXV2VjVlXNOEbWOPueYRF/vNeHaPB2dXxG6+1cbTkf0RIAqL/bfmgY56UpNX71wZDb1vcEC3u8fIaLbe2UGPPoV8QYUU7Y9kV5YUssBczuod7Lqae8J2fIslD3bsY7riic1PODmpZYcHWj0Bux6A59WlQbzq9u7xQGhYCr2c=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:50 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:50 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 07/19] fuzz: Modify libqtest to directly invoke qtest.c
Thread-Index: AQHVQphgLYpwnCOLmkuHDOxi0AT8oA==
Date: Thu, 25 Jul 2019 03:23:49 +0000
Message-ID: <20190725032321.12721-8-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 058eb46d-d5d1-4228-685e-08d710af82eb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB272628ADF42667AB8B6EEDC4BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OQ6NVyuNhJNOOkbckfKCPUMhw1s9JlsHIg62V4ui/+hZNhmJ0xLF5A2kFq7heKoCJsgf5AbeBU/nKwnA3JY11Ta6++SHfPjhEW9Ry6mBM68et9Cq+no1Go1aDg81k7NoIcXg5oa2RQ+QHKOLkI9JyJPonF6z+zOOcGhi4OSqWuoPbmsOeW2iOIQHCotukrImukY6mDYXprpcv83y4OSb3gb0aku/dmGKUlXbWKF/Tmdjc7gmlEfzravJzXFzBuEpIpjNQ+VSU5b7hvq28Ih5Vmlx5vFJ0nGEie7mxD09acSQEc3vF7utC8CUWhKysJ+4CCeyLkU48nvvOLiOMqUcZyrjnfUEWUIOT1lblHDklHtogXNBvQbJMV/exW/6fNq+gr7mGV2SwXdFHo/4tKSeG+FvAh1qk4+f/tM3aooC1eQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 058eb46d-d5d1-4228-685e-08d710af82eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:49.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 07/19] fuzz: Modify libqtest to directly invoke
 qtest.c
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

libqtest directly invokes the qtest client and exposes a function to
accept responses.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
 tests/libqtest.h |  6 ++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3c5c3f49d8..a68a7287cb 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -30,12 +30,18 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
+#ifdef CONFIG_FUZZ
+#include "sysemu/qtest.h"
+#endif
=20
 #define MAX_IRQ 256
 #define SOCKET_TIMEOUT 50
 #define SOCKET_MAX_FDS 16
=20
 QTestState *global_qtest;
+#ifdef CONFIG_FUZZ
+static GString *recv_str;
+#endif
=20
 struct QTestState
 {
@@ -316,6 +322,20 @@ QTestState *qtest_initf(const char *fmt, ...)
     va_end(ap);
     return s;
 }
+#ifdef CONFIG_FUZZ
+QTestState *qtest_init_fuzz(const char *extra_args, int *sock_fd)
+{
+    QTestState *qts;
+    qts =3D g_new(QTestState, 1);
+    qts->wstatus =3D 0;
+    for (int i =3D 0; i < MAX_IRQ; i++) {
+        qts->irq_level[i] =3D false;
+    }
+    qts->big_endian =3D qtest_query_target_endianness(qts);
+
+    return qts;
+}
+#endif
=20
 QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
 {
@@ -379,9 +399,18 @@ static void socket_sendf(int fd, const char *fmt, va_l=
ist ap)
 {
     gchar *str =3D g_strdup_vprintf(fmt, ap);
     size_t size =3D strlen(str);
+#ifdef CONFIG_FUZZ
+    // Directly call qtest_process_inbuf in the qtest server
+    GString *gstr =3D g_string_new_len(str, size);
+	/* printf(">>> %s",gstr->str); */
+    qtest_server_recv(gstr);
+    g_string_free(gstr, true);
+    g_free(str);
+#else
=20
     socket_send(fd, str, size);
     g_free(str);
+#endif
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt,=
 ...)
@@ -433,6 +462,12 @@ static GString *qtest_recv_line(QTestState *s)
     size_t offset;
     char *eol;
=20
+#ifdef CONFIG_FUZZ
+    eol =3D strchr(recv_str->str, '\n');
+    offset =3D eol - recv_str->str;
+    line =3D g_string_new_len(recv_str->str, offset);
+    g_string_erase(recv_str, 0, offset + 1);
+#else
     while ((eol =3D strchr(s->rx->str, '\n')) =3D=3D NULL) {
         ssize_t len;
         char buffer[1024];
@@ -453,7 +488,7 @@ static GString *qtest_recv_line(QTestState *s)
     offset =3D eol - s->rx->str;
     line =3D g_string_new_len(s->rx->str, offset);
     g_string_erase(s->rx, 0, offset + 1);
-
+#endif
     return line;
 }
=20
@@ -797,6 +832,9 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
=20
 const char *qtest_get_arch(void)
 {
+#ifdef CONFIG_FUZZ
+    return "i386";
+#endif
     const char *qemu =3D qtest_qemu_binary();
     const char *end =3D strrchr(qemu, '/');
=20
@@ -1339,3 +1377,16 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class)
=20
     qobject_unref(rsp);
 }
+#ifdef CONFIG_FUZZ
+void qtest_clear_rxbuf(QTestState *s){
+    g_string_set_size(recv_str,0);
+}
+
+void qtest_client_recv(const char *str, size_t len)
+{
+    if(!recv_str)
+        recv_str =3D g_string_new(NULL);
+    g_string_append_len(recv_str, str, len);
+    return;
+}
+#endif
diff --git a/tests/libqtest.h b/tests/libqtest.h
index cadf1d4a03..dca8f2c2f2 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -1001,4 +1001,10 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class);
  */
 bool qtest_probe_child(QTestState *s);
=20
+#ifdef CONFIG_FUZZ
+QTestState *qtest_init_fuzz(const char *extra_args, int *sock_fd);
+void qtest_clear_rxbuf(QTestState *s);
+void qtest_client_recv(const char *str, size_t len);
+#endif
+
 #endif
--=20
2.20.1


