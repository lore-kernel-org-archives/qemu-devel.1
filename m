Received: from eggs.gnu.org ([209.51.188.92]:59768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3GN3-0001p9-1S
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3GMs-0007TC-Ok
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:53281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3GMs-0007Pm-GT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:06 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 11 Mar 2019 16:32:34 +0800
Message-Id: <20190311083234.20841-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qom: use object_new_with_type in
 object_new_with_propv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: afaerber@suse.de, Wei Yang <richardw.yang@linux.intel.com>

Function object_new_with_propv already get the Type of the object, so we
could leverage object_new_with_type here.

[make check test pass]

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 05a8567041..76d2f1eb2f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -640,7 +640,7 @@ Object *object_new_with_propv(const char *typename,
         error_setg(errp, "object type '%s' is abstract", typename);
         return NULL;
     }
-    obj = object_new(typename);
+    obj = object_new_with_type(klass->type);
 
     if (object_set_propv(obj, &local_err, vargs) < 0) {
         goto error;
-- 
2.19.1
