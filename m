Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CFCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CD620874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="nmJyd6jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpX4-0008Ed-8A
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-00050E-HU
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007Gv-Rh
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com
 ([40.107.80.135]:59246 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIN-0006yI-Mj
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3tqH1q4vAvdlOF3x0ImVSly7Dsjy/kP6X97ScsKFRCX6oyukvD4CdaVgZmyslukOtkNmpqGWH63Jrit43cFWVvwBsnEgVG1kmr5FMNIaKWHrp8QHjhmt4d3z7nd3x5FcKVmosjio+fQsrgjW6T1ns6h0yRHNQxodeQ3MaQQnP/UdHtTuTg6eLe+VX+2kz3C8ktrnGjgKapSZ2swFq4A9RaGJPrVcz+dX+2Z5WmVTPQ9Tqhkxk8xP9OXEB+ZRLq+gUtuStdseXLNPm0HhxKXiTtY2CmO2qumLKJslVh6gqT8MzamLbnUbU/nEYa2rQVcapRcRDK0sRS44cgIicBZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1JxxlXgRErwgkLWh3FvRbtEg2H/TM+rNQ2wfM/68go=;
 b=dALZBlyzB07osX8BlU/WdbDW4BcRCrd4/tw7VYAGuiGMQ4rG4znukMSR8nwdwb7/WmiElxbVyhGTeAabbGZ8CZPgKUPwEt4xlu5hFGGk+Vu55esqQQTcO0KQTC3PhDxt4kqcRVwtk4lH/ZYmeHifuuDn48smd9DdGq1oekH/YIakhmoyVwWzw1KU/6DMbXO301EuVAxMOStkKFzjUQrjlURUujI7zFSmMM++75PKN9Uafg31q7KSdUGczYIeKaRwi9PQsZkW3yXKMvtaUEojf4Gf1drE1HzMnv+FiLekQIko67Jxa+08EZUzF36x34/mtZU/UD89mZtHN9bD/bNV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1JxxlXgRErwgkLWh3FvRbtEg2H/TM+rNQ2wfM/68go=;
 b=nmJyd6jh5YpTHGJ6aggp7LBS+WFTeTQaqx8U8pSdIamEv5lwHelTpVnymnnfdR9Eh7vBSQgr3HIouQIhjpSzeUPAMWOw3FN8OrHG84Mid/ajTJhJfxbGPfPdEKzResD1QXlelYXp805vabreRO8SHfwaWxMmRIrx2cFQ/ZRDhrM=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:52 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:52 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 05/20] libqtest: Add a layer of abstraciton to send/recv
Thread-Topic: [PATCH v4 05/20] libqtest: Add a layer of abstraciton to
 send/recv
Thread-Index: AQHVjzFJVwQsnl1HE0isDTNe7F+n/Q==
Date: Wed, 30 Oct 2019 14:49:52 +0000
Message-ID: <20191030144926.11873-6-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da08934a-7fd5-4588-2a73-08d75d486b8d
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50543E75DA70A65ABAF2CE8CBA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(54906003)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Lv8+TaIkkm4WT/UAs6z1ZRBvNxFiKMXA/yNftKeXzyYJXDZMF61p7gYq8plvbaxDl6KdyhY0CTaJHETlmK7HSQ2QHiQtEr9t8YO2BjXLs7ltifTvvTqOByYPC6xOAN62l8pljsI3MUfVufQb6SrAiN3PiyKfnFroEpwZD7/AbXb2qFrOhjyeGowrchbyQcw+K6WuZ9ar8hHB2mo4MlMbY/Uvkr8jKOSBsiMUBWc7TtouIR3ETZ6+VzlfL9CzFROBG1jl7hBKfwZOeiia2+iu8TMPyV8cJgY13NU5tQOJSMOW2pCFF1dqhkDn1sycX2B8GOmlCrEb6tOUkNRZTsfSHHKGtb5LGiXqJ6R6R1qnx9cQhG7WFyQPu3JA3Ampdxi0yNbTBo764GWtHlLjBh3W8TMhd/gBXTtYUVS0bpDxBRUuji6iYGUrlY1z8qYG5Jp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: da08934a-7fd5-4588-2a73-08d75d486b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:52.1645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7wSOKO7BZ2pM24lO50dLhFpMXldVUYX9hmERQmI4B2oXCDRpAWO4cd1PzQFzCd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.135
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

This makes it simple to swap the transport functions for qtest commands
to and from the qtest client. For example, now it is possible to
directly pass qtest commands to a server handler that exists within the
same process, without the standard way of writing to a file descriptor.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 56 +++++++++++++++++++++++++++++++++++++++---------
 tests/libqtest.h |  1 -
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3706bccd8d..822bfe208b 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -35,6 +35,13 @@
 #define SOCKET_TIMEOUT 50
 #define SOCKET_MAX_FDS 16
=20
+
+typedef struct QTestClientTransportOps {
+    void     (*send)(QTestState* , const char*, size_t);
+
+    GString* (*recv_line)(QTestState *);
+} QTestTransportOps;
+
 struct QTestState
 {
     int fd;
@@ -45,6 +52,7 @@ struct QTestState
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
+    QTestTransportOps ops;
 };
=20
 static GHookList abrt_hooks;
@@ -52,6 +60,18 @@ static struct sigaction sigact_old;
=20
 static int qtest_query_target_endianness(QTestState *s);
=20
+static void qtest_client_socket_send(QTestState*,
+        const char *buf, size_t size);
+static void socket_send(int fd, const char *buf, size_t size);
+
+static GString *qtest_client_socket_recv_line(QTestState *);
+
+static void qtest_client_set_tx_handler(QTestState *s,
+        void (*send)(QTestState*, const char *, size_t));
+static void qtest_client_set_rx_handler(QTestState *s,
+        GString * (*recv)(QTestState *));
+
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
@@ -360,6 +383,7 @@ void qtest_quit(QTestState *s)
     g_free(s);
 }
=20
+
 static void socket_send(int fd, const char *buf, size_t size)
 {
     size_t offset;
@@ -379,22 +403,23 @@ static void socket_send(int fd, const char *buf, size=
_t size)
     }
 }
=20
-static void socket_sendf(int fd, const char *fmt, va_list ap)
+static void qtest_client_socket_send(QTestState *s,
+                                     const char *buf, size_t size)
 {
-    gchar *str =3D g_strdup_vprintf(fmt, ap);
-    size_t size =3D strlen(str);
-
-    socket_send(fd, str, size);
-    g_free(str);
+    socket_send(s->fd, buf, size);
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt,=
 ...)
 {
     va_list ap;
-
     va_start(ap, fmt);
-    socket_sendf(s->fd, fmt, ap);
+    gchar *str =3D g_strdup_vprintf(fmt, ap);
     va_end(ap);
+
+    size_t size =3D strlen(str);
+
+    s->ops.send(s, str, size);
+    g_free(str);
 }
=20
 /* Sends a message and file descriptors to the socket.
@@ -431,7 +456,7 @@ static void socket_send_fds(int socket_fd, int *fds, si=
ze_t fds_num,
     g_assert_cmpint(ret, >, 0);
 }
=20
-static GString *qtest_recv_line(QTestState *s)
+static GString *qtest_client_socket_recv_line(QTestState *s)
 {
     GString *line;
     size_t offset;
@@ -468,7 +493,7 @@ static gchar **qtest_rsp(QTestState *s, int expected_ar=
gs)
     int i;
=20
 redo:
-    line =3D qtest_recv_line(s);
+    line =3D s->ops.recv_line(s);
     words =3D g_strsplit(line->str, " ", 0);
     g_string_free(line, TRUE);
=20
@@ -1336,3 +1361,14 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class)
=20
     qobject_unref(rsp);
 }
+
+static void qtest_client_set_tx_handler(QTestState *s,
+                    void (*send)(QTestState*, const char*, size_t))
+{
+    s->ops.send =3D send;
+}
+static void qtest_client_set_rx_handler(QTestState *s,
+                    GString* (*recv)(QTestState *))
+{
+    s->ops.recv_line =3D recv;
+}
diff --git a/tests/libqtest.h b/tests/libqtest.h
index c9e21e05b3..31267fc915 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -728,5 +728,4 @@ bool qtest_probe_child(QTestState *s);
  * Set expected exit status of the child.
  */
 void qtest_set_expected_status(QTestState *s, int status);
-
 #endif
--=20
2.23.0


