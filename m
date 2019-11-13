Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF85C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B22B206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="oP5BtB4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B22B206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1Wa-0001O1-7s
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-000845-Kk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007do-4i
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007S1-TT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxDNr0LSeYIUWeSqB5NqPxl32PdeOFHTA/xLk39E+XXVbBOFh0vgFKsCvUTIpIUPe+P6ofeStkPoECsEGfc4DPFMxJ/CI9V/c0wHx1EqShiGO6pJoeKEZ9EPgxRlY4WIyaofA8gcOX4xrm5MSuL6YnKC08fKNEnHQu7QzxDqH5OSY6fsfRxJpBwDSxuzFDuucFfhqAx9ngkF62zmOKiATleajL98Ya/dJz9iWd5X8LU73eI6xEj0qTccmddXaW8aDWi1dJPJJKiFHYM32Ixv3gGCw2EiSObIO04g1FnDLTAW1R6mOOu/ObkTjKn0FfeiFguY9TQgO/hBTUaaJquv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obIV4NY3qD5olAA+cfJBQhv1nBbxNyLmAkgS94i7eUw=;
 b=bkm/1vJCK8LgQ7ILlFp27dcSZsg79hGeRULkAobJVOkUdz4aVAMJ79yqlU7Xm7Vv86x3wv8+Zz9WgX8+o/lY8MDo+bpMfni+/VN5zAahk17B6XBnLeO85afb/7AFZy3pm/+miS2b/ACYeZzPEa35gj8pCenZFnQaWgS2bG7iZ6TvsO4dmaR0g6lBMxYIfdvkup/ali5kdOL7WjckgAGIl85SEWUXVQ72JNdPeR1WMgtU0Vg5BirO2f+d0wWk0TF2MkbsN9Q+uAO3KbxM4F6Vqv+mlPw/q4Cf+hZAF01hueMCUQQVzuioYQ/Y6nx6Ln21nlZjfuZn0G05Bwk/p4hAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obIV4NY3qD5olAA+cfJBQhv1nBbxNyLmAkgS94i7eUw=;
 b=oP5BtB4E2BXNYO6Whl6qLSAcmSi3qtXTXEX7+QTQkJkKm1otm5Txb9wcjiKIJarX3j8YC+cmVcHx5hJ8bRmE0PYBjpoZPZv97ryQr1+KjmzRzedfz1IpteP5Eqw5cJb4TUFFO+dVgc1kq91jge8ZETk/S7zCNfK44uOJFUfpmuw=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:45 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:45 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 05/20] libqtest: Add a layer of abstraciton to send/recv
Thread-Topic: [PATCH v5 05/20] libqtest: Add a layer of abstraciton to
 send/recv
Thread-Index: AQHVmnTIjdr12JgWMUi/sxHg+BqJ+Q==
Date: Wed, 13 Nov 2019 22:50:45 +0000
Message-ID: <20191113225030.17023-6-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 8dfcf1b3-8cb3-4214-e271-08d7688beb00
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50244BC9D0F0DCA3C111FC50BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
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
x-microsoft-antispam-message-info: eE/XWYU57seAvPNupk0BkSVJybEOhnSkunc7gfHY+ZJwuwiy12nkBwNEIgkepibNA+T90+3Xdl8pS8UCCc9AjdvERDJpjFEBDBaKZwDLw7e75RLQyr3YVsJCJyJGn/p61YwhBg9eng8UFgLI4sA7x1uCOr5ZDVfNWf6qZdxxtAfBndy1u9ZA1w3rCy1X9SplbLVqqvcP2YPtiSSu1wK5scjGgOHwfbmvZpjRPxI7LhBHZviwOSAsXVj8faCmhy61kJSgBBYwn6EtP8TEOwosSYXHDD3RgdYxyr7E6Gl90V9udZRsfGsyNs3xASYKDH2m36zP+FfhwiPxyKSDjEuAxQOKqQoJ491/XGf5fZ2/1qxxV/Kt10uDYYsEL6QGX78DfGaXn+tyAZTOBmutDlcpwUO1FANPkp/ydw3e01VDDIQk4LPDXZOMbhRu9O5+JR2g
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfcf1b3-8cb3-4214-e271-08d7688beb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:45.1109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40wk4axWXCCrZj4at/O78RlLcERtp4zg82HO5TKNz2Krwf/5Iy7n+lx0tr7760KO
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

This makes it simple to swap the transport functions for qtest commands
to and from the qtest client. For example, now it is possible to
directly pass qtest commands to a server handler that exists within the
same process, without the standard way of writing to a file descriptor.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/libqtest.c | 50 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3706bccd8d..c406b2ea09 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -35,6 +35,17 @@
 #define SOCKET_TIMEOUT 50
 #define SOCKET_MAX_FDS 16
=20
+
+typedef void (*QTestSendFn)(QTestState *s, const char *buf);
+typedef void (*ExternalSendFn)(void *s, const char *buf);
+typedef GString* (*QTestRecvFn)(QTestState *);
+
+typedef struct QTestClientTransportOps {
+    QTestSendFn     send;
+    ExternalSendFn  external_send;
+    QTestRecvFn     recv_line;
+} QTestTransportOps;
+
 struct QTestState
 {
     int fd;
@@ -45,6 +56,7 @@ struct QTestState
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
+    QTestTransportOps ops;
 };
=20
 static GHookList abrt_hooks;
@@ -52,6 +64,14 @@ static struct sigaction sigact_old;
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
@@ -234,6 +254,9 @@ QTestState *qtest_init_without_qmp_handshake(const char=
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
@@ -379,13 +402,9 @@ static void socket_send(int fd, const char *buf, size_=
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
@@ -393,8 +412,11 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState =
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
@@ -431,7 +453,7 @@ static void socket_send_fds(int socket_fd, int *fds, si=
ze_t fds_num,
     g_assert_cmpint(ret, >, 0);
 }
=20
-static GString *qtest_recv_line(QTestState *s)
+static GString *qtest_client_socket_recv_line(QTestState *s)
 {
     GString *line;
     size_t offset;
@@ -468,7 +490,7 @@ static gchar **qtest_rsp(QTestState *s, int expected_ar=
gs)
     int i;
=20
 redo:
-    line =3D qtest_recv_line(s);
+    line =3D s->ops.recv_line(s);
     words =3D g_strsplit(line->str, " ", 0);
     g_string_free(line, TRUE);
=20
@@ -1336,3 +1358,13 @@ void qmp_assert_error_class(QDict *rsp, const char *=
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


