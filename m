Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B21C11D40
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BC82465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="OPzENQ/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BC82465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dFK-0004OK-1u
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBg-0004IV-Cq
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBf-0005wT-92
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:44 -0500
Received: from mail-co1nam11on2100.outbound.protection.outlook.com
 ([40.107.220.100]:28052 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBf-0005wA-26
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+DV/S/MYMeHBQaZh7W1yA8bvAVpqzR33HvkgPiHNuJZ26ITGfV8pKGyF7dTLaAhOHNc5gEwJMbYoTU1uYg6cNEVB1RImgWp6hyMvX7CG8FhqUzaNjoZnHH2OpNHpSYvzoJjZcsGZtJZ0f+JVl4dzuBufFLQjemqF+MQJiysSHtxmHl0LLLsKGeOldulzHdqg+XXGdXnwXo+wBn32+y7XppZK+xzLkPvhNJd/QGa/wvPhqF6t42O9IwsAH3iANdRN51FSXG8HfY//UUK9AMqt4r+SKNrNEeXmX0tRHRoJaLXANqWFafoCA+aQkshheLzZ204L/39m1dTb4eeguySZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG/X/2fjY04Hl3rIZX0SV8KvbcS454hTOmMR2jUMQTw=;
 b=hAYOyRZ5LGc7iLKh49digmtGnYc77Oo5TUgjoatWwrIqb9VTt0Gfce7ynIqcyc1KJ5K+omoEP2qAOVDdbLKzM319RfrruarcUB8mecNt8W7D5AyfSyTKTmqJcKRy8jnzNS1gel7hhAGS7AJzoO5NsM+c0z9lpmhA6Qb5wq26ZG2ffcE53htyflnnfHPWRGLWKnHSDIuwvvqyNCdn5GHArLgVLfj9ZbL99PfT2QdKCBTnocrPoakTbJt0ga1HtByeZCaxERewnYAYZxiiqfIS+AELlf4+w1jApvWW7EoPRYTwyMzjjCoB6a2aFaLarBoP+OxfV9EwPFswEGKcX/hdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG/X/2fjY04Hl3rIZX0SV8KvbcS454hTOmMR2jUMQTw=;
 b=OPzENQ/Lgru3unbxM52AklCYwN1y47sahEnYwODDCqkHYFxr/mPeSsWbA4tIytqpix8hLuZV1/0L6qlhJxE40HLkke4W9kBUVhlwYlZ8p5NkeWd0LDvqgZ06yyE/ZBchjzxVzXtvcl47cn4jE05oD6K88JWA5yID8FyVkG5pdMI=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:41 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:41 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 06/22] libqtest: add a layer of abstraction to send/recv
Date: Wed, 19 Feb 2020 23:11:02 -0500
Message-ID: <20200220041118.23264-7-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:40 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8821c5-e7b0-408d-08a9-08d7b5bafd08
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807752FBEA65626DC5CA445BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z78cTKX0w2E+zy1kwgPytagOvZdqNaxO9jaMkh+sVAHfUbhtgOgoCWIVQF4cW0KuBP19/fbQ8Mp+ksCLUCJ6o0lzCytbbB9lSU8DjS1uVLPztW2MWaqwMPcJjOii4BzDp/KDpgUn3aeTQ67CVhxn6DjndVwGl6qgPHCxVJ0/VC2Cn8mKR04lYLpva5SNuv7Y1XllwKsxXwCMGbO8Gn5PecFz1jO15FygvPeumRjgCASFNccudvTq+9KVwUk2d/H5OEiDfvgn1s0dWqj1PqDxOHZ98885Kno7kXiH/FuFkt7SMzDR79/8XoBVzhMGgKku6hnIQJdA2iICZ5v4DKC6KAzAGTKbdcI8MLpEs45Rswun3Vg+DzeahCIoLQSID/9wGjRgpcg3fzBi9oqwb5aIOS++3xOUPRK1svO9uYK4eN+CeXeUHoO0XysbUI8WWse9
X-MS-Exchange-AntiSpam-MessageData: PoiLMzkeBta1MO5L1pUhGaRjBxub/TUeTuJO0yvcF08kDOcDZ20cLbl4SPVxWs3uoOrqAtb9RQ0pZyDttxR8UIWQWrAVKL9q6e96uswW+ubMqpNpNyu2/SQzNUaXmdY/RLwAxOCPGyoeWB0bbwbMGg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8821c5-e7b0-408d-08a9-08d7b5bafd08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:41.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsQbSPSsU8aXnOJVhpSIaMUty42qzJmPN6Xl8pUfQl0XGCNmGmLy2sJ6Qk8U9Gf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.100
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


