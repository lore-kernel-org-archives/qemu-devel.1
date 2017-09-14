Received: from eggs.gnu.org ([2001:4830:134:3::10]:51707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvR-0006AK-BA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvO-0006Wv-5h
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOvN-0006Vy-Vp
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:02 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:23 +0800
Message-Id: <1505375436-28439-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 02/15] qobject: allow NULL for qstring_get_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Then I can get NULL rather than crash when calling things like:

  qstring_get_str(qobject_to_qstring(object));

when key does not exist.

CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qobject/qstring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/qstring.c b/qobject/qstring.c
index 5da7b5f..c499fec 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -125,7 +125,7 @@ QString *qobject_to_qstring(const QObject *obj)
  */
 const char *qstring_get_str(const QString *qstring)
 {
-    return qstring->string;
+    return qstring ? qstring->string : NULL;
 }
 
 /**
-- 
2.7.4
