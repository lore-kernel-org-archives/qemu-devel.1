Received: from eggs.gnu.org ([2001:4830:134:3::10]:34673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfkMP-0000by-Fn
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfkMK-0002qz-FI
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfkMK-0002pd-7z
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:06:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 10 Aug 2017 12:06:28 +0200
Message-Id: <1502359588-29451-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] error: Improve documentation of
 error_append_hint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 341b229..c2115a6 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -230,6 +230,12 @@ void error_prepend(Error **errp, const char *fmt, ...)
 
 /*
  * Append a printf-style human-readable explanation to an existing error.
+ * If the error is later reported to a human user with
+ * error_report_err() or warn_report_err(), the hints will be shown,
+ * too.  If it's reported via QMP, the hints will be ignored.
+ * Intended use is adding helpful hints on the human user interface,
+ * e.g. a list of valid values.  It's not for clarifying a confusing
+ * error message.
  * @errp may be NULL, but not &error_fatal or &error_abort.
  * Trivially the case if you call it only after error_setg() or
  * error_propagate().
@@ -267,11 +273,13 @@ void error_free_or_abort(Error **errp);
 
 /*
  * Convenience function to warn_report() and free @err.
+ * The report includes hints added with error_append_hint().
  */
 void warn_report_err(Error *err);
 
 /*
  * Convenience function to error_report() and free @err.
+ * The report includes hints added with error_append_hint().
  */
 void error_report_err(Error *err);
 
-- 
2.7.5
