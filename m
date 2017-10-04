Received: from eggs.gnu.org ([2001:4830:134:3::10]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzgb7-0000hZ-Jv
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dzgb3-0005t5-Lt
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dzgb3-0005ss-Fa
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:08:09 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  4 Oct 2017 12:08:00 +0200
Message-Id: <1507111682-66171-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507111682-66171-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qom: update doc comment for
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
Cc: ehabkost@redhat.com, peter.maydell@linaro.org

type_register()/type_register_static() functions in current impl.
can't fail returning 0, also none of the users check for error
so update doc comment to reflect current behaviour.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/qom/object.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f3e5cff..76a5e3a 100644
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
