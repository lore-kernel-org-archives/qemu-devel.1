Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezV-0000Mr-4a
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezS-0004wM-2Z
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3ezR-0004vq-T5
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Apr 2017 10:41:24 +0200
Message-Id: <1493282486-28338-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-1-git-send-email-armbru@redhat.com>
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] qobject-input-visitor: Document
 full_name_nth()
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
 qapi/qobject-input-visitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 865e948..2530959 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -55,6 +55,17 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
     return container_of(v, QObjectInputVisitor, visitor);
 }
 
+/*
+ * Find the full name of something @qiv is currently visiting.
+ * @qiv is visiting something named @name in the stack of containers
+ * @qiv->stack.
+ * If @n is zero, return its full name.
+ * If @n is positive, return the full name of the @n-th container
+ * counting from the top.  The stack of containers must have at least
+ * @n elements.
+ * The returned string is valid until the next full_name_nth(@v) or
+ * destruction of @v.
+ */
 static const char *full_name_nth(QObjectInputVisitor *qiv, const char *name,
                                  int n)
 {
-- 
2.7.4
