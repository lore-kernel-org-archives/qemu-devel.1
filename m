Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC7EC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FC520657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="M6gcTPfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FC520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXDZ-0004Wx-KM
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9F-0003QG-Rh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9E-000219-Nj
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:13 -0400
Received: from mail-eopbgr680135.outbound.protection.outlook.com
 ([40.107.68.135]:31792 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9E-0001z9-If
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaECqEmKZlvsrH9xNjTaLSlZSL8dhPY5DgorD92ng0Ku+YI00x87U9HV/gaza6/XxI9PHK3U/aGjqWAYnHPs7ISKKzVOOSHd6+N1t0WdEJ/4jqxCdu+LDEblsTsXOTRXhSKqvvv3mG3HSfUt0uE0Irvgoi9eTNLowOXltTsS0DVXV9SNpwQZUiQjRzSYdYgiQPzK8SoyIyG1IkKZiaEt+/1dTIsZOdVS1BL9b6dUBkSgen4Ojo/HM2i1hCLnJVsu5WyTHIOE/gBRVFgMDMOgUJjsFOm9Mzgb4A1h5yzVvfV5EW1FInKJPTGgM9JDkP42ylcNX/cVScuOV1WzJ+soMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7jLKLHckXmQgYF6EQNRxVAS8lfkJd9vH2NzKIr35sk=;
 b=IWQmrOnJkdqseax44xucwxiczq6qWxZJZSfnSeHyRyAeUTd0gtX+F0jUXqWCX2dg9+8k5Oe3zem4dfIgsU92/rnWcq+1b4KC4H+1fOLIaqo1XdywGm9nNNWO4c3DcC+/GmftkSjB+a6eeLhfrP7Ptcdr2R/yp2zBr9cPHaBK2UqiGNtC9OR37NDSRI4jftD+H7IpxCRX8JP1wH0326k1Of7+qPa01HTgrph3DtYsDjvJRjPrKV5f2O7AYOJ16OEWp1sUUL+ESy+1H9mre6dA4dtM+mC97OSEvyxOunCt1cAETmUkLPPlo882cRY8b8kizQhLTvPagHRv0Yxlv+r6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7jLKLHckXmQgYF6EQNRxVAS8lfkJd9vH2NzKIr35sk=;
 b=M6gcTPfqi5U9EaoeF8Qt9X6hZWEz+0HtUNzzVexSFjrAAgnFYVhpMKjEhjiqMlLioZVtuDLO/mHT1EtbeIYpy6es3gEn0gK8e3hVj9AA7A25pExth3NKuMTZ+4YgMCqXE4OkdCc8dY/Uht0sstRPbbSl/ia5lkqJ1bjum3mk7mw=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:11 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:11 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 10/17] fuzz: qtest client directly interacts with
 server
Thread-Index: AQHVS1z26M08P07mFUi4Z4GHP3ay8A==
Date: Mon, 5 Aug 2019 07:11:11 +0000
Message-ID: <20190805071038.32146-11-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: c251b0f3-e476-4c82-9330-08d719741871
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646BEA1613E3A9812C1847FBADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OHTwzZ8dzsbq5jonIOlpXUPUw0tq70NBHQF9fso2qx3Y+/ozXs/ltGNkgEOcC08iOCv/WJXrbqlsygTtSp1+i+REd9ngvZwRQ3gnG5beg6+SjifH84qUNdGu+u3PXitTWU3VnUp5c/lvvMHY+2fmXqQXus17zV5qpR0Cf4bxxg0EwpzpOIvzBk5T/W6XFAd7j/1VDI89bOiW4A2AlnjZdrFjfepKQ6y8dm4RUl92M2nVnAVB0HIgXHCgwPxPS//VhLCdi/Q9E0rnbzNsEbMmn8uVeuJT50VVrK6O9Xu+9x2P1jP13ZeIWc23bMCn3Vnbx9SkO8YTs5ULuWB5LGgdLx+ibu3Vyybc9dgLl5r3LMYgoG+n/5yjNSifBCLe3jCY3UNky/v5qVaESAqWBBOIu2KVGnw2vE8XXPU2m6c43FU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c251b0f3-e476-4c82-9330-08d719741871
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:11.5520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.135
Subject: [Qemu-devel] [RFC PATCH v2 10/17] fuzz: qtest client directly
 interacts with server
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++--
 tests/libqtest.h |  6 +++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3c5c3f49d8..a9c1dc4fb6 100644
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
@@ -317,6 +323,21 @@ QTestState *qtest_initf(const char *fmt, ...)
     return s;
 }
=20
+#ifdef CONFIG_FUZZ
+QTestState *qtest_fuzz_init(const char *extra_args, int *sock_fd)
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
+
 QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
 {
     int sock_fd_init;
@@ -374,14 +395,25 @@ static void socket_send(int fd, const char *buf, size=
_t size)
         offset +=3D len;
     }
 }
-
+/*
+ * TODO: Remove the ifdefs by adding a layer of indirection and separating=
 the
+ * implemetation of sendf and init for the fuzzer and qtest client
+ */
 static void socket_sendf(int fd, const char *fmt, va_list ap)
 {
     gchar *str =3D g_strdup_vprintf(fmt, ap);
     size_t size =3D strlen(str);
+#ifdef CONFIG_FUZZ
+    /* Directly call qtest_process_inbuf in the qtest server */
+    GString *gstr =3D g_string_new_len(str, size);
+    qtest_server_recv(gstr);
=20
+    g_string_free(gstr, true);
+    g_free(str);
+#else
     socket_send(fd, str, size);
     g_free(str);
+#endif
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt,=
 ...)
@@ -433,6 +465,13 @@ static GString *qtest_recv_line(QTestState *s)
     size_t offset;
     char *eol;
=20
+#ifdef CONFIG_FUZZ
+    eol =3D strchr(recv_str->str, '\n');
+    offset =3D eol - recv_str->str;
+    line =3D g_string_new_len(recv_str->str, offset);
+    g_string_erase(recv_str, 0, offset + 1);
+    printf("<<< %s\n", line->str);
+#else
     while ((eol =3D strchr(s->rx->str, '\n')) =3D=3D NULL) {
         ssize_t len;
         char buffer[1024];
@@ -453,7 +492,7 @@ static GString *qtest_recv_line(QTestState *s)
     offset =3D eol - s->rx->str;
     line =3D g_string_new_len(s->rx->str, offset);
     g_string_erase(s->rx, 0, offset + 1);
-
+#endif
     return line;
 }
=20
@@ -797,6 +836,9 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
=20
 const char *qtest_get_arch(void)
 {
+#ifdef CONFIG_FUZZ
+    return TARGET_NAME;
+#endif
     const char *qemu =3D qtest_qemu_binary();
     const char *end =3D strrchr(qemu, '/');
=20
@@ -1339,3 +1381,18 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class)
=20
     qobject_unref(rsp);
 }
+#ifdef CONFIG_FUZZ
+void qtest_clear_rxbuf(QTestState *s)
+{
+    g_string_set_size(recv_str, 0);
+}
+
+void qtest_client_recv(const char *str, size_t len)
+{
+    if (!recv_str) {
+        recv_str =3D g_string_new(NULL);
+    }
+    g_string_append_len(recv_str, str, len);
+    return;
+}
+#endif
diff --git a/tests/libqtest.h b/tests/libqtest.h
index cadf1d4a03..4e32f39be7 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -1001,4 +1001,10 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class);
  */
 bool qtest_probe_child(QTestState *s);
=20
+#ifdef CONFIG_FUZZ
+QTestState *qtest_fuzz_init(const char *extra_args, int *sock_fd);
+void qtest_clear_rxbuf(QTestState *s);
+void qtest_client_recv(const char *str, size_t len);
+#endif
+
 #endif
--=20
2.20.1


