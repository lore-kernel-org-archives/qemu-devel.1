Received: from eggs.gnu.org ([2001:4830:134:3::10]:44688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPV-0000ws-Qr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPS-0001KG-OQ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dCqPS-0001Jw-IJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 446282B0A76
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:42:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 May 2017 18:42:13 +0200
Message-Id: <1495471335-23707-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-1-git-send-email-armbru@redhat.com>
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] qapi: Document visit_type_any() issues
 with keyval input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mlureau@redhat.com

It's already documented in keyval.c (commit 0ee9ae7), but visitor.h
can use a note, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/visitor.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index b0e233d..4721c39 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -607,6 +607,10 @@ void visit_type_number(Visitor *v, const char *name, double *obj,
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.  *@obj must be non-NULL
  * for output visitors.
+ *
+ * Note that some kinds of input can't express arbitrary QObject.
+ * E.g. the visitor returned by qobject_input_visitor_new_keyval()
+ * can't create numbers or booleans, only strings.
  */
 void visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp);
 
-- 
2.7.4
