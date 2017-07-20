Received: from eggs.gnu.org ([2001:4830:134:3::10]:56962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJB9-00062c-D0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJB8-0000az-MK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYJB8-0000aV-GT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 20 Jul 2017 16:40:06 -0500
Message-Id: <20170720214008.28494-3-eblake@redhat.com>
In-Reply-To: <20170720214008.28494-1-eblake@redhat.com>
References: <20170720214008.28494-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] qapi: Visitor documentation tweak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Make it clear that the name parameter to visit_start_struct()
has the same semantics as for visit_start_int().

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>

---
v2: tweak wording to avoid overloaded 'OBJ'
---
 include/qapi/visitor.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 74768aabda..8243fa271f 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -60,13 +60,13 @@
  * visitors are declared here; the remaining visitors are generated in
  * qapi-visit.h.
  *
- * The @name parameter of visit_type_FOO() describes the relation
- * between this QAPI value and its parent container.  When visiting
- * the root of a tree, @name is ignored; when visiting a member of an
- * object, @name is the key associated with the value; when visiting a
- * member of a list, @name is NULL; and when visiting the member of an
- * alternate, @name should equal the name used for visiting the
- * alternate.
+ * The @name parameter of visit_type_FOO() and visit_start_BAR()
+ * describes the relation between this QAPI value and its parent
+ * container.  When visiting the root of a tree, @name is ignored;
+ * when visiting a member of an object, @name is the key associated
+ * with the value; when visiting a member of a list, @name is NULL;
+ * and when visiting the member of an alternate, @name should equal
+ * the name used for visiting the alternate.
  *
  * The visit_type_FOO() functions expect a non-null @obj argument;
  * they allocate *@obj during input visits, leave it unchanged on
-- 
2.13.3
