Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C009BC48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BC32084A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BC32084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkO2g-0003lC-Qs
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 03:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO1H-00028a-E8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkO1F-0000sl-Vk
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkO1F-0000sV-O7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 03:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 196F488309
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 07:25:01 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31FD1001B02;
 Mon,  8 Jul 2019 07:24:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 11:24:36 +0400
Message-Id: <20190708072437.3339-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190708072437.3339-1-marcandre.lureau@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 08 Jul 2019 07:25:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] tests: add qtest_set_exit_status()
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
 berrange@redhat.com, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
index 3c5c3f49d8..d722de6da8 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -46,6 +46,7 @@ struct QTestState
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
+    int exit_status;
 };
=20
 static GHookList abrt_hooks;
@@ -125,27 +126,29 @@ static void kill_qemu(QTestState *s)
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
+void qtest_set_exit_status(QTestState *s, int status)
+{
+    s->exit_status =3D status;
 }
=20
 static void kill_qemu_hook_func(void *s)
@@ -215,7 +218,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
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
index cadf1d4a03..aa54225c0e 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -84,6 +84,15 @@ QTestState *qtest_init_with_serial(const char *extra_a=
rgs, int *sock_fd);
  */
 void qtest_quit(QTestState *s);
=20
+/**
+ * qtest_set_exit_status:
+ * @s: #QTestState instance to operate on.
+ * @status: the expected exit status
+ *
+ * Set the expected exit status when calling qtest_quit().
+ */
+void qtest_set_exit_status(QTestState *s, int status);
+
 /**
  * qtest_qmp_fds:
  * @s: #QTestState instance to operate on.
--=20
2.22.0.214.g8dca754b1e


