Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFFBC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE00820714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="VLf46ePt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE00820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cNd-0001vv-QN
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFx-0006WJ-PL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFu-0008JO-Kf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:40 -0500
Received: from mail-bn8nam11on2135.outbound.protection.outlook.com
 ([40.107.236.135]:55392 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFo-0008Dh-Uq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/4PK0YLB2T1qvYtXWJFnwzXCEGC7sbjsBO7glauobH0EvxPbpr0L1wd0ALpmsJNTZyPG0JmFA83mY2xx8ag0SMTNstHiBP5B8m1NktLquRM9Zn/GxdzxUSarhutCZupKiVMJc7s7nnm8yHFXZVaofged8XkCenjAF5FbjOajiN5sOk9ywdrQmN699/auw9wi14LhmAYgkrEYxmpeO2iNqjyRBZtqvofq4nkx7+uTMyYYVaAQ+fMFOrgr4n79e8dGRiJRXRqAr6DaRN4VgeZFX60Gcu0gHvGkUJy983MxtI/L46aGfRQ74kGeX/4POJ245AGOdeEYpmh/f/TMw1KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG/X/2fjY04Hl3rIZX0SV8KvbcS454hTOmMR2jUMQTw=;
 b=Rk/xbOp8aknNHw8RWoWIb+vEySZDJGoz5twx67BSgL3RyJGsll5S0wnJnV048fjQWKLhhegq7ofUN3YQcLshbuYFxcf2JCE/qmTJY0B9GqlaPtydg/npZF/q3qBNiJNI9aG7tniLL7VKLTa7754CYCLGitQoZ3K7bWVYqatw8cKgVhhe0GvFHIfMa7sCnTH991Q9a78sUibR2HYlaNiRCkPPE1y7NSEIhMrU/clnvFJObWYaz4rHc13GQifxS4YxeCbWBxnFp6BnWBHPo2+Vgma3I80VVjejZcYD6yjPni/6yUjTgWmnSWwveykl9+QFK817DoqS1XSpmFO0sy/gAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG/X/2fjY04Hl3rIZX0SV8KvbcS454hTOmMR2jUMQTw=;
 b=VLf46ePt7CFqkzOo3YGz5LUV8WLagvcc0Yh5nZDJzuir4Lt0KI0TfmgIEF+xzK0RT0am5UhWl41uF7AYwyWCAofGCDUuv7oGynEG+mPg7DguWCLznoyi24+9YFwpjbQWEsoTugkDJhUUP9UhlEpHipBxlBT9izauLCKTGkISnG8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:28 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:28 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 07/23] libqtest: add a layer of abstraction to send/recv
Date: Tue, 11 Feb 2020 15:34:54 -0500
Message-ID: <20200211203510.3534-8-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:27 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 940ce189-5451-4250-b76d-08d7af31ee39
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB359942715587B30C2DF9ED4FBA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(54906003)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoQmKkg3eV7EiE7IhM9WnHHqjF9eUkfiwPcCtA8d5mMSQASmtP8oROEX9PcjNqSV+slV9n6dyvmO0Ulpo6QV6BBU9E1wrNNpnRe+6kRxvwJ82Op4oDzXs9mf3W4Tvd8ERyqBrkESKzWP6BF2c+rQNdSo+zYwCoE2YM5fKFKGoB96V4XYkIIVbT7Fa4KVMjCX44x22idyK6WYJFftYiJ6hLJmYYXtxHq7sTtTRgaafaE9yGPWWYqJZSUMi3Icm3XsT9MnggmZj3AiekkFnhnT3UH6ZctXrmwBN8H1Dq+ICbir/HH9wM12Gktih/M1y9D5/j7LBvd17u036hNqO98ctamtRwsOyRW3mhrLTlndMoZxl6jcl+hbggpGCTVL26hON3U2Xdt9eDXj6yXrOOgHL6p7sCqq2jd0I6x/V+VGIP9zXIxI1I4v2UuTjANemgdx
X-MS-Exchange-AntiSpam-MessageData: 4TUcPv7PHGn4f1fsvS3F/ceZGvrfJ0OsKXo3oyvv/71/Iw5EmMvQbF74IBGhfopX5oAind17A4jmS6uHEyUxFFvSL6Kra11egfmpiVlnxRokiKK31lScsv6QHQUTLsxHlarnS5KmzcQxCCkWUAWxBA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 940ce189-5451-4250-b76d-08d7af31ee39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:28.3071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/E79aHa7CK2hyFvr9XqhgKqMUuxSzbT42NTzzlRq9hQT/mWn09JAZZf/zv4uwl0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.236.135
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
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes it simple to swap the transport functions for qtest commands
to and from the qtest client. For example, now it is possible to
directly pass qtest commands to a server handler that exists within the
same process, without the standard way of writing to a file descriptor.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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
2.25.0


