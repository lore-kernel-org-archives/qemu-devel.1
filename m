Received: from eggs.gnu.org ([2001:4830:134:3::10]:55156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtIBi-0004yG-Kf
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtIBh-0000SE-St
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 14:51:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 16 Sep 2017 20:51:19 +0200
Message-Id: <20170916185123.29255-3-mreitz@redhat.com>
In-Reply-To: <20170916185123.29255-1-mreitz@redhat.com>
References: <20170916185123.29255-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/6] qapi/qlist: Add qlist_append_null()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qapi/qmp/qlist.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index c4b5fdad9b..59d209bbae 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -15,6 +15,7 @@
 
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu/queue.h"
 
 typedef struct QListEntry {
@@ -37,6 +38,8 @@ typedef struct QList {
         qlist_append(qlist, qbool_from_bool(value))
 #define qlist_append_str(qlist, value) \
         qlist_append(qlist, qstring_from_str(value))
+#define qlist_append_null(qlist) \
+        qlist_append(qlist, qnull())
 
 #define QLIST_FOREACH_ENTRY(qlist, var)             \
         for ((var) = ((qlist)->head.tqh_first);     \
-- 
2.13.5
