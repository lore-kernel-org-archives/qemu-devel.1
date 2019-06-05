Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D58C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF702075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF702075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUZi-0007vB-MK
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:59:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUUW-00040k-E8
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUUU-0002yJ-Ho
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:54:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hYUUS-0002nZ-Q4
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:54:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A42A530860BD;
	Wed,  5 Jun 2019 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
	[10.36.116.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 041EC5D705;
	Wed,  5 Jun 2019 11:53:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 13:53:17 +0200
Message-Id: <20190605115318.9972-5-quintela@redhat.com>
In-Reply-To: <20190605115318.9972-1-quintela@redhat.com>
References: <20190605115318.9972-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 11:53:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] migration-test: Add a test for fd protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Yury Kotov <yury-kotov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/libqtest.c       |  80 ++++++++++++++++++++++++++++++--
 tests/libqtest.h       |  51 ++++++++++++++++++++-
 tests/migration-test.c | 101 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 546a875913..9b9b5f37fc 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -32,6 +32,7 @@
=20
 #define MAX_IRQ 256
 #define SOCKET_TIMEOUT 50
+#define SOCKET_MAX_FDS 16
=20
 QTestState *global_qtest;
=20
@@ -391,6 +392,40 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestStat=
e *s, const char *fmt, ...)
     va_end(ap);
 }
=20
+/* Sends a message and file descriptors to the socket.
+ * It's needed for qmp-commands like getfd/add-fd */
+static void socket_send_fds(int socket_fd, int *fds, size_t fds_num,
+                            const char *buf, size_t buf_size)
+{
+    ssize_t ret;
+    struct msghdr msg =3D { 0 };
+    char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)] =3D { 0 };
+    size_t fdsize =3D sizeof(int) * fds_num;
+    struct cmsghdr *cmsg;
+    struct iovec iov =3D { .iov_base =3D (char *)buf, .iov_len =3D buf_s=
ize };
+
+    msg.msg_iov =3D &iov;
+    msg.msg_iovlen =3D 1;
+
+    if (fds && fds_num > 0) {
+        g_assert_cmpuint(fds_num, <, SOCKET_MAX_FDS);
+
+        msg.msg_control =3D control;
+        msg.msg_controllen =3D CMSG_SPACE(fdsize);
+
+        cmsg =3D CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_len =3D CMSG_LEN(fdsize);
+        cmsg->cmsg_level =3D SOL_SOCKET;
+        cmsg->cmsg_type =3D SCM_RIGHTS;
+        memcpy(CMSG_DATA(cmsg), fds, fdsize);
+    }
+
+    do {
+        ret =3D sendmsg(socket_fd, &msg, 0);
+    } while (ret < 0 && errno =3D=3D EINTR);
+    g_assert_cmpint(ret, >, 0);
+}
+
 static GString *qtest_recv_line(QTestState *s)
 {
     GString *line;
@@ -545,7 +580,8 @@ QDict *qtest_qmp_receive(QTestState *s)
  * in the case that they choose to discard all replies up until
  * a particular EVENT is received.
  */
-void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
+void qmp_fd_vsend_fds(int fd, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap)
 {
     QObject *qobj;
=20
@@ -569,25 +605,49 @@ void qmp_fd_vsend(int fd, const char *fmt, va_list =
ap)
             fprintf(stderr, "%s", str);
         }
         /* Send QMP request */
-        socket_send(fd, str, qstring_get_length(qstr));
+        if (fds && fds_num > 0) {
+            socket_send_fds(fd, fds, fds_num, str, qstring_get_length(qs=
tr));
+        } else {
+            socket_send(fd, str, qstring_get_length(qstr));
+        }
=20
         qobject_unref(qstr);
         qobject_unref(qobj);
     }
 }
=20
+void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
+{
+    qmp_fd_vsend_fds(fd, NULL, 0, fmt, ap);
+}
+
+void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
+                         const char *fmt, va_list ap)
+{
+    qmp_fd_vsend_fds(s->qmp_fd, fds, fds_num, fmt, ap);
+}
+
 void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
 {
-    qmp_fd_vsend(s->qmp_fd, fmt, ap);
+    qmp_fd_vsend_fds(s->qmp_fd, NULL, 0, fmt, ap);
 }
=20
 QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
 {
-    qmp_fd_vsend(fd, fmt, ap);
+    qmp_fd_vsend_fds(fd, NULL, 0, fmt, ap);
=20
     return qmp_fd_receive(fd);
 }
=20
+QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap)
+{
+    qtest_qmp_vsend_fds(s, fds, fds_num, fmt, ap);
+
+    /* Receive reply */
+    return qtest_qmp_receive(s);
+}
+
 QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
 {
     qtest_qmp_vsend(s, fmt, ap);
@@ -616,6 +676,18 @@ void qmp_fd_send(int fd, const char *fmt, ...)
     va_end(ap);
 }
=20
+QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
+                     const char *fmt, ...)
+{
+    va_list ap;
+    QDict *response;
+
+    va_start(ap, fmt);
+    response =3D qtest_vqmp_fds(s, fds, fds_num, fmt, ap);
+    va_end(ap);
+    return response;
+}
+
 QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
 {
     va_list ap;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 32d927755d..cadf1d4a03 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -84,6 +84,21 @@ QTestState *qtest_init_with_serial(const char *extra_a=
rgs, int *sock_fd);
  */
 void qtest_quit(QTestState *s);
=20
+/**
+ * qtest_qmp_fds:
+ * @s: #QTestState instance to operate on.
+ * @fds: array of file descriptors
+ * @fds_num: number of elements in @fds
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
+ *
+ * Sends a QMP message to QEMU with fds and returns the response.
+ */
+QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
+                     const char *fmt, ...)
+    GCC_FMT_ATTR(4, 5);
+
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
@@ -120,7 +135,23 @@ void qtest_qmp_send_raw(QTestState *s, const char *f=
mt, ...)
     GCC_FMT_ATTR(2, 3);
=20
 /**
- * qtest_qmpv:
+ * qtest_vqmp_fds:
+ * @s: #QTestState instance to operate on.
+ * @fds: array of file descriptors
+ * @fds_num: number of elements in @fds
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
+ * @ap: QMP message arguments
+ *
+ * Sends a QMP message to QEMU with fds and returns the response.
+ */
+QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap)
+    GCC_FMT_ATTR(4, 0);
+
+/**
+ * qtest_vqmp:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
@@ -132,6 +163,22 @@ void qtest_qmp_send_raw(QTestState *s, const char *f=
mt, ...)
 QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
=20
+/**
+ * qtest_qmp_vsend_fds:
+ * @s: #QTestState instance to operate on.
+ * @fds: array of file descriptors
+ * @fds_num: number of elements in @fds
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
+ * @ap: QMP message arguments
+ *
+ * Sends a QMP message to QEMU and leaves the response in the stream.
+ */
+void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
+                         const char *fmt, va_list ap)
+    GCC_FMT_ATTR(4, 0);
+
 /**
  * qtest_qmp_vsend:
  * @s: #QTestState instance to operate on.
@@ -888,6 +935,8 @@ static inline int64_t clock_step(int64_t step)
 }
=20
 QDict *qmp_fd_receive(int fd);
+void qmp_fd_vsend_fds(int fd, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap) GCC_FMT_ATTR(4, 0);
 void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0=
);
 void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void qmp_fd_send_raw(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
diff --git a/tests/migration-test.c b/tests/migration-test.c
index bd3f5c3125..e0407576cb 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -174,6 +174,21 @@ static void stop_cb(void *opaque, const char *name, =
QDict *data)
     }
 }
=20
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+GCC_FMT_ATTR(3, 4)
+static QDict *wait_command_fd(QTestState *who, int fd, const char *comma=
nd, ...)
+{
+    va_list ap;
+
+    va_start(ap, command);
+    qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
+    va_end(ap);
+
+    return qtest_qmp_receive_success(who, stop_cb, NULL);
+}
+
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
@@ -480,6 +495,7 @@ static void migrate(QTestState *who, const char *uri,=
 const char *fmt, ...)
     qdict_put_str(args, "uri", uri);
=20
     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': %p}", args);
+
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
@@ -1027,6 +1043,90 @@ static void test_precopy_tcp(void)
     g_free(uri);
 }
=20
+static void test_migrate_fd_proto(void)
+{
+    QTestState *from, *to;
+    int ret;
+    int pair[2];
+    QDict *rsp;
+    const char *error_desc;
+
+    if (test_migrate_start(&from, &to, "defer", false, false)) {
+        return;
+    }
+
+    /*
+     * We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge */
+    migrate_set_parameter(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /* Create two connected sockets for migration */
+    ret =3D socketpair(PF_LOCAL, SOCK_STREAM, 0, pair);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Send the 1st socket to the target */
+    rsp =3D wait_command_fd(to, pair[0],
+                          "{ 'execute': 'getfd',"
+                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    qobject_unref(rsp);
+    close(pair[0]);
+
+    /* Start incoming migration from the 1st socket */
+    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { 'uri': 'fd:fd-mig' }}");
+    qobject_unref(rsp);
+
+    /* Send the 2nd socket to the target */
+    rsp =3D wait_command_fd(from, pair[1],
+                          "{ 'execute': 'getfd',"
+                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    qobject_unref(rsp);
+    close(pair[1]);
+
+    /* Start migration to the 2nd socket*/
+    migrate(from, "fd:fd-mig", "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300ms should converge */
+    migrate_set_parameter(from, "downtime-limit", 300);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    /* Test closing fds */
+    /* We assume, that QEMU removes named fd from its list,
+     * so this should fail */
+    rsp =3D qtest_qmp(from, "{ 'execute': 'closefd',"
+                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    error_desc =3D qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
+    g_assert_cmpstr(error_desc, =3D=3D, "File descriptor named 'fd-mig' =
not found");
+    qobject_unref(rsp);
+
+    rsp =3D qtest_qmp(to, "{ 'execute': 'closefd',"
+                        "  'arguments': { 'fdname': 'fd-mig' }}");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    error_desc =3D qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
+    g_assert_cmpstr(error_desc, =3D=3D, "File descriptor named 'fd-mig' =
not found");
+    qobject_unref(rsp);
+
+    /* Complete migration */
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1081,6 +1181,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
=20
     ret =3D g_test_run();
=20
--=20
2.21.0


