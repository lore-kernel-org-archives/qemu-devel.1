Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RX-00067k-UQ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RW-0000FP-18
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj4RV-0000Eg-Qy
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:13:59 +0200
Message-Id: <20180727151359.29061-24-armbru@redhat.com>
In-Reply-To: <20180727151359.29061-1-armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 23/23] libqtest: Rename qtest_FOOv() to
 qtest_vFOO() for consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.c | 12 ++++++------
 tests/libqtest.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index a0d44793fa..3706f30aa2 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -538,7 +538,7 @@ QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
     return qmp_fd_receive(fd);
 }
 
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
+QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
 {
     qtest_qmp_vsend(s, fmt, ap);
 
@@ -572,7 +572,7 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
     QDict *response;
 
     va_start(ap, fmt);
-    response = qtest_qmpv(s, fmt, ap);
+    response = qtest_vqmp(s, fmt, ap);
     va_end(ap);
     return response;
 }
@@ -608,7 +608,7 @@ void qtest_qmp_eventwait(QTestState *s, const char *event)
     qobject_unref(response);
 }
 
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
 {
     char *cmd;
     QDict *resp;
@@ -637,7 +637,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
     char *ret;
 
     va_start(ap, fmt);
-    ret = qtest_hmpv(s, fmt, ap);
+    ret = qtest_vhmp(s, fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -943,7 +943,7 @@ QDict *qmp(const char *fmt, ...)
     QDict *response;
 
     va_start(ap, fmt);
-    response = qtest_qmpv(global_qtest, fmt, ap);
+    response = qtest_vqmp(global_qtest, fmt, ap);
     va_end(ap);
     return response;
 }
@@ -963,7 +963,7 @@ char *hmp(const char *fmt, ...)
     char *ret;
 
     va_start(ap, fmt);
-    ret = qtest_hmpv(global_qtest, fmt, ap);
+    ret = qtest_vhmp(global_qtest, fmt, ap);
     va_end(ap);
     return ret;
 }
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 3848086928..7e60abc9fd 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -106,7 +106,7 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
+QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
 
 /**
@@ -189,7 +189,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
 
 /**
-- 
2.17.1
