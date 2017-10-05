Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xH-0002my-5Q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xE-0003Ay-Tk
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:24:59 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:28 +0200
Message-Id: <1507220690-265042-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 01/23] qom: update doc comment for
 type_register[_static]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

type_register()/type_register_static() functions in current impl.
can't fail returning 0, also none of the users check for error
so update doc comment to reflect current behaviour.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e0d9824..a707b67 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -773,7 +773,7 @@ const char *object_get_typename(const Object *obj);
  * @info and all of the strings it points to should exist for the life time
  * that the type is registered.
  *
- * Returns: 0 on failure, the new #Type on success.
+ * Returns: the new #Type.
  */
 Type type_register_static(const TypeInfo *info);
 
@@ -784,7 +784,7 @@ Type type_register_static(const TypeInfo *info);
  * Unlike type_register_static(), this call does not require @info or its
  * string members to continue to exist after the call returns.
  *
- * Returns: 0 on failure, the new #Type on success.
+ * Returns: the new #Type.
  */
 Type type_register(const TypeInfo *info);
 
-- 
2.7.4
