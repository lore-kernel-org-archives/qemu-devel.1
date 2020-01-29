Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C4C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD1420720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="puEe0tsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD1420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg0e-0001AG-DQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzZ-0007o1-Nc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzY-0001uV-F3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:21 -0500
Received: from mail-mw2nam10on2110.outbound.protection.outlook.com
 ([40.107.94.110]:45280 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzY-0001tn-7w
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUaa2y0Qk1SfqrYOtOIVOEtYcqAwSG3XlgX45lJVfrZV70pD1s5tF3uQako9srHN115kZKhS6Qm7sW/jtAG/iXp4Pn0ac/OQJCJutcq0Wcooxj56NbfHwtRugJNcnBdm9/uHkwiQks4+CEHeC4MTuhltcU0AJ7TfKUMkkAwWaHiiysagQR6OHn0JoTznQd+4p2BlaPHmRcndWym699lhl9CJwmRCmF3kmHeeMOZyyOjoDWBeicQVytihcCWq0a8GD5XLsC8LE/wj1wTnsRSLMCBaPcHfaxLG+asFsWrNHEg08FI3fyavHrxU7KKN2KxnXV8NEnd9B2SBb0b1Eg4hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/nC58PkrV1BS/kZeyEjMo6kMm9lskCxHO6QiHS9JfI=;
 b=MQHH4QkM7SWX7Sk3CK6RHZkXj03JkdoE0bedDFYHH+g+AFaa/iM/AG4RI4Xju3LSALjiwTP0+JYtYfB2l28A5U1Wb8uzlzIbEVUMSjHglRP4Kvy8Ed0K4/Tpe3rSJrJQl40H/IfoQhshg2ahs+WqyziBFvXDnQYpUHZS+HVT/PvVnanxDQVjyN7CaaojqP6jarmNjywdHF2jFSDU6+dnIWyhtmRVw6gCmoGS4LxwPQYQD9YyPrdVtkQQO7dp7fr6BeziKrZ/NTHDJmoQSYyLN21uHkwRGHzzRSjTRct8LsunLHD4n3L9BfLmyfcnMf6HiAbzBOIhaDBZ28YSMICXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/nC58PkrV1BS/kZeyEjMo6kMm9lskCxHO6QiHS9JfI=;
 b=puEe0tsD7Fn8T1L4yX+BMCSXhMWAaP30wkYP0DRzzyIRU3s6vTuPw/hR/gATayeUaO+uwc+fN30R9P3gy5+tTL5z6IBIl9NeDoGpcHSmZ/SR2L+IO/XSVSOEgYLGOfRoeAOnd4JEopvTgGH4ubHhIDmXbpE++LZp8N2wQsn07R8=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:16 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:16 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:15 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 05/21] libqtest: add a layer of abstraction to send/recv
Thread-Topic: [PATCH v8 05/21] libqtest: add a layer of abstraction to
 send/recv
Thread-Index: AQHV1mW+meb1dl2NREiu3u8I/suiQQ==
Date: Wed, 29 Jan 2020 05:34:15 +0000
Message-ID: <20200129053357.27454-6-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 676e2379-6234-4f88-64a5-08d7a47ce104
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4206FC8EEFC4772ACE121D9DBA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOrVfUVMScZmqIi9IMlf16BegfGpnMJS+xZJbH6+0GzryE/7PIp19EVwr0nrPtratubO2R9scREyA/UE4qATh2/EFfGZfIjoo76FXiAAkKsV1hQFzBBJtq9sd/dAr87vyImEQums/kwj+WAVm8CjXKmlX0AdRKrvaMAfR2PrcmAtz69NGi7d9T+EuKvzW2TT5y00VaaZAvhAINC9n/iY7VaCso4OW6+b/1a0jXAOBJzHiivmbxpVrXLlzpOOsTIZfYpetJkhk4eEZWY/t8810nrDrGwUx1liY3mmBKoZSfSg8TnZEK8fXdPe3yTFBvFOS9vGGwuw5zqOonWXyTVtxyIM2+5hH1DzRLudscFJ5IImMXSul5/2GGsVIAG4/6NHrv3Uj+DkCfXqenJlofOXgb8ltG77i/fh/6PdcAIEwJYNeyG8PAXRATXrEXHm5wT4
x-ms-exchange-antispam-messagedata: p0DaH0wlxEpjtl/cZ+yVOEcs+Gw2Mk+hMChZIe4RTW33ouS9VZcA4SUJ5i03V0+evuWN2RROugSd25CeM+M05UL+RsytybC/iKP4Kqjh1A4S5PlkStlfHDvRRddfrwG9lSfv40pzoIhYeulkCOKbzg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 676e2379-6234-4f88-64a5-08d7a47ce104
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:15.6035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TMvruQw218f0CHSn5hTJlh42cQFHfY1RrAZ4J5Yu2ALYHXUtloRNb25bGo7ny5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.110
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

This makes it simple to swap the transport functions for qtest commands
to and from the qtest client. For example, now it is possible to
directly pass qtest commands to a server handler that exists within the
same process, without the standard way of writing to a file descriptor.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/libqtest.c | 48 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 76c9f8eade..e5056a1d0f 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -35,6 +35,15 @@
 #define SOCKET_TIMEOUT 50
 #define SOCKET_MAX_FDS 16
=20
+
+typedef void (*QTestSendFn)(QTestState *s, const char *buf);
+typedef GString* (*QTestRecvFn)(QTestState *);
+
+typedef struct QTestClientTransportOps {
+    QTestSendFn     send;      /* for sending qtest commands */
+    QTestRecvFn     recv_line; /* for receiving qtest command responses */
+} QTestTransportOps;
+
 struct QTestState
 {
     int fd;
@@ -45,6 +54,7 @@ struct QTestState
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
+    QTestTransportOps ops;
 };
=20
 static GHookList abrt_hooks;
@@ -52,6 +62,14 @@ static struct sigaction sigact_old;
=20
 static int qtest_query_target_endianness(QTestState *s);
=20
+static void qtest_client_socket_send(QTestState*, const char *buf);
+static void socket_send(int fd, const char *buf, size_t size);
+
+static GString *qtest_client_socket_recv_line(QTestState *);
+
+static void qtest_client_set_tx_handler(QTestState *s, QTestSendFn send);
+static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv);
+
 static int init_socket(const char *socket_path)
 {
     struct sockaddr_un addr;
@@ -234,6 +252,9 @@ QTestState *qtest_init_without_qmp_handshake(const char=
 *extra_args)
     sock =3D init_socket(socket_path);
     qmpsock =3D init_socket(qmp_socket_path);
=20
+    qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
+    qtest_client_set_tx_handler(s, qtest_client_socket_send);
+
     qtest_add_abrt_handler(kill_qemu_hook_func, s);
=20
     command =3D g_strdup_printf("exec %s "
@@ -379,13 +400,9 @@ static void socket_send(int fd, const char *buf, size_=
t size)
     }
 }
=20
-static void socket_sendf(int fd, const char *fmt, va_list ap)
+static void qtest_client_socket_send(QTestState *s, const char *buf)
 {
-    gchar *str =3D g_strdup_vprintf(fmt, ap);
-    size_t size =3D strlen(str);
-
-    socket_send(fd, str, size);
-    g_free(str);
+    socket_send(s->fd, buf, strlen(buf));
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt,=
 ...)
@@ -393,8 +410,11 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState =
*s, const char *fmt, ...)
     va_list ap;
=20
     va_start(ap, fmt);
-    socket_sendf(s->fd, fmt, ap);
+    gchar *str =3D g_strdup_vprintf(fmt, ap);
     va_end(ap);
+
+    s->ops.send(s, str);
+    g_free(str);
 }
=20
 /* Sends a message and file descriptors to the socket.
@@ -431,7 +451,7 @@ static void socket_send_fds(int socket_fd, int *fds, si=
ze_t fds_num,
     g_assert_cmpint(ret, >, 0);
 }
=20
-static GString *qtest_recv_line(QTestState *s)
+static GString *qtest_client_socket_recv_line(QTestState *s)
 {
     GString *line;
     size_t offset;
@@ -468,7 +488,7 @@ static gchar **qtest_rsp(QTestState *s, int expected_ar=
gs)
     int i;
=20
 redo:
-    line =3D qtest_recv_line(s);
+    line =3D s->ops.recv_line(s);
     words =3D g_strsplit(line->str, " ", 0);
     g_string_free(line, TRUE);
=20
@@ -1337,3 +1357,13 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class)
=20
     qobject_unref(rsp);
 }
+
+static void qtest_client_set_tx_handler(QTestState *s,
+                    QTestSendFn send)
+{
+    s->ops.send =3D send;
+}
+static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv)
+{
+    s->ops.recv_line =3D recv;
+}
--=20
2.23.0


