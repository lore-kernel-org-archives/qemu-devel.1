Received: from eggs.gnu.org ([2001:4830:134:3::10]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDU46-00008C-H6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDU42-0003nH-Ep
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gDU40-0003Fe-Dx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C86C356F3
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 12:39:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B25F600C0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 12:39:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 19 Oct 2018 14:39:23 +0200
Message-Id: <20181019123923.26649-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] error: Drop bogus "use error_setg() instead"
 admonitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 97f40301f1d "error: Functions to report warnings and
informational messages" copied the "use error_setg() instead"
admonition from the error reporting functions to new functions even
though it doesn't actually apply there.  Drop it.  Also drop it from
vreport(), where it doesn't apply anymore.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-error.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index 4ab428f7e4..fcbe8a1f74 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -194,7 +194,6 @@ bool enable_timestamp_msg;
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
- * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
@@ -242,7 +241,6 @@ void error_vreport(const char *fmt, va_list ap)
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
- * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
 void warn_vreport(const char *fmt, va_list ap)
 {
@@ -255,7 +253,6 @@ void warn_vreport(const char *fmt, va_list ap)
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
- * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
 void info_vreport(const char *fmt, va_list ap)
 {
@@ -283,7 +280,6 @@ void error_report(const char *fmt, ...)
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
- * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
 void warn_report(const char *fmt, ...)
 {
@@ -300,7 +296,6 @@ void warn_report(const char *fmt, ...)
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
- * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
 void info_report(const char *fmt, ...)
 {
-- 
2.17.2
