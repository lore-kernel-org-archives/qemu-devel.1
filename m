Received: from eggs.gnu.org ([2001:4830:134:3::10]:56373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9GZ-00032o-VT
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9GW-0003s8-LJ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej9GW-0003rk-Fl
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:50:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15B0240201A0
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 19:50:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E57772166BDA
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 19:50:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Feb 2018 20:50:31 +0100
Message-Id: <20180206195044.8347-2-armbru@redhat.com>
In-Reply-To: <20180206195044.8347-1-armbru@redhat.com>
References: <20180206195044.8347-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 01/14] error: Improve documentation of
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

Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1502359588-29451-1-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 include/qapi/error.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 341b229066..c2115a6a4a 100644
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
2.13.6
