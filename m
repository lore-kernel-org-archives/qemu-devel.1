Received: from eggs.gnu.org ([2001:4830:134:3::10]:48821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Ct8-0001eq-6g
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0Ct6-0000Ez-BH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0Ct6-0000E1-4F
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:36:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  5 Oct 2017 17:36:37 -0300
Message-Id: <20171005203638.19255-9-ehabkost@redhat.com>
In-Reply-To: <20171005203638.19255-1-ehabkost@redhat.com>
References: <20171005203638.19255-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] qom: update doc comment for
 type_register[_static]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

type_register()/type_register_static() functions in current impl.
can't fail returning 0, also none of the users check for error
so update doc comment to reflect current behaviour.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1507111682-66171-2-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e0d9824415..a707b67781 100644
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
2.13.6
