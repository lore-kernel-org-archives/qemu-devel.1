Received: from eggs.gnu.org ([2001:4830:134:3::10]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezV-0000Mq-4N
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezS-0004wh-6x
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3ezS-0004vu-0n
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Apr 2017 10:41:25 +0200
Message-Id: <1493282486-28338-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-1-git-send-email-armbru@redhat.com>
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qapi: Document intended use of @name
 within alternate visits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/visitor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 1a1b620..b0e233d 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -63,8 +63,10 @@
  * The @name parameter of visit_type_FOO() describes the relation
  * between this QAPI value and its parent container.  When visiting
  * the root of a tree, @name is ignored; when visiting a member of an
- * object, @name is the key associated with the value; and when
- * visiting a member of a list, @name is NULL.
+ * object, @name is the key associated with the value; when visiting a
+ * member of a list, @name is NULL; and when visiting the member of an
+ * alternate, @name should equal the name used for visiting the
+ * alternate.
  *
  * The visit_type_FOO() functions expect a non-null @obj argument;
  * they allocate *@obj during input visits, leave it unchanged on
-- 
2.7.4
