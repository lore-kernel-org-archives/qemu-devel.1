Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56FC47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E817120830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E817120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OLY-00041K-M5
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAh-0003LH-51
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAf-0007Wp-7b
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i8OAe-0007WA-Ve
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1FF9811BF
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:25:55 +0000 (UTC)
Received: from localhost (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 625084518;
 Thu, 12 Sep 2019 12:25:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 16:25:12 +0400
Message-Id: <20190912122514.22504-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190912122514.22504-1-marcandre.lureau@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 12 Sep 2019 12:25:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/6] tests: add qtest_expect_exit_status()
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify the behaviour of qtest_quit() to check against the expected
exit status value. The default remains 0.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqtest.c | 41 ++++++++++++++++++++++-------------------
 tests/libqtest.h |  9 +++++++++
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0a6b91737e..1f7910e583 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -44,6 +44,7 @@ struct QTestState
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
+    int exit_status;
 };
=20
 static GHookList abrt_hooks;
@@ -123,27 +124,29 @@ static void kill_qemu(QTestState *s)
         assert(pid =3D=3D s->qemu_pid);
     }
=20
-    /*
-     * We expect qemu to exit with status 0; anything else is
-     * fishy and should be logged with as much detail as possible.
-     */
     wstatus =3D s->wstatus;
-    if (wstatus) {
-        if (WIFEXITED(wstatus)) {
-            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU =
"
-                    "process but encountered exit status %d\n",
-                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
-        } else if (WIFSIGNALED(wstatus)) {
-            int sig =3D WTERMSIG(wstatus);
-            const char *signame =3D strsignal(sig) ?: "unknown ???";
-            const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)" :=
 "";
-
-            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
-                    "from signal %d (%s)%s\n",
-                    __FILE__, __LINE__, sig, signame, dump);
+    if (WIFEXITED(wstatus)) {
+        if (WEXITSTATUS(wstatus) =3D=3D s->exit_status) {
+            return;
         }
-        abort();
+        fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
+                "process but encountered exit status %d\n",
+                __FILE__, __LINE__, WEXITSTATUS(wstatus));
+    } else if (WIFSIGNALED(wstatus)) {
+        int sig =3D WTERMSIG(wstatus);
+        const char *signame =3D strsignal(sig) ?: "unknown ???";
+        const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)" : "";
+
+        fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
+                "from signal %d (%s)%s\n",
+                __FILE__, __LINE__, sig, signame, dump);
     }
+    abort();
+}
+
+void qtest_expect_exit_status(QTestState *s, int status)
+{
+    s->exit_status =3D status;
 }
=20
 static void kill_qemu_hook_func(void *s)
@@ -213,7 +216,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
     gchar *command;
     const char *qemu_binary =3D qtest_qemu_binary();
=20
-    s =3D g_new(QTestState, 1);
+    s =3D g_new0(QTestState, 1);
=20
     socket_path =3D g_strdup_printf("/tmp/qtest-%d.sock", getpid());
     qmp_socket_path =3D g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
diff --git a/tests/libqtest.h b/tests/libqtest.h
index c8cffe5d68..d41229d7fd 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -82,6 +82,15 @@ QTestState *qtest_init_with_serial(const char *extra_a=
rgs, int *sock_fd);
  */
 void qtest_quit(QTestState *s);
=20
+/**
+ * qtest_expect_exit_status:
+ * @s: #QTestState instance to operate on.
+ * @status: the expected exit status
+ *
+ * Set the expected exit status when calling qtest_quit().
+ */
+void qtest_expect_exit_status(QTestState *s, int status);
+
 /**
  * qtest_qmp_fds:
  * @s: #QTestState instance to operate on.
--=20
2.23.0


