Received: from eggs.gnu.org ([2001:4830:134:3::10]:59470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3N-000482-Sa
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3H-0000Zm-Dk
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3H-0000Yv-6A
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AB5628213
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F25FB60C8B
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:53 +0100
Message-Id: <20180130102202.28519-10-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 09/18] Include qapi/qmp/qobject.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/block.h                 | 1 -
 include/qapi/qmp/dispatch.h           | 1 -
 include/qapi/qmp/qjson.h              | 1 -
 include/qapi/qobject-input-visitor.h  | 1 -
 include/qapi/qobject-output-visitor.h | 1 -
 include/qapi/visitor.h                | 2 +-
 qapi/qapi-visit-core.c                | 1 -
 qmp.c                                 | 1 -
 qobject/qbool.c                       | 1 -
 qobject/qdict.c                       | 1 -
 qobject/qlist.c                       | 1 -
 qobject/qnum.c                        | 1 -
 qobject/qstring.c                     | 1 -
 qom/object.c                          | 1 -
 tests/test-qmp-event.c                | 1 -
 15 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 0608834396..62ba19d78d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -8,7 +8,6 @@
 #include "block/accounting.h"
 #include "block/dirty-bitmap.h"
 #include "block/blockjob.h"
-#include "qapi/qmp/qobject.h"
 #include "qemu/hbitmap.h"
 
 /* block.c */
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 20578dcd48..47a0ff348b 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -14,7 +14,6 @@
 #ifndef QAPI_QMP_DISPATCH_H
 #define QAPI_QMP_DISPATCH_H
 
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
 
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index 6e84082d5f..6b38b0f074 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -14,7 +14,6 @@
 #ifndef QJSON_H
 #define QJSON_H
 
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qstring.h"
 
 QObject *qobject_from_json(const char *string, Error **errp);
diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index daee18c6ac..95985e25e5 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -16,7 +16,6 @@
 #define QOBJECT_INPUT_VISITOR_H
 
 #include "qapi/visitor.h"
-#include "qapi/qmp/qobject.h"
 
 typedef struct QObjectInputVisitor QObjectInputVisitor;
 
diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject-output-visitor.h
index e5a3490812..2b1726baf5 100644
--- a/include/qapi/qobject-output-visitor.h
+++ b/include/qapi/qobject-output-visitor.h
@@ -15,7 +15,6 @@
 #define QOBJECT_OUTPUT_VISITOR_H
 
 #include "qapi/visitor.h"
-#include "qapi/qmp/qobject.h"
 
 typedef struct QObjectOutputVisitor QObjectOutputVisitor;
 
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 62a51a54cb..ecff296c11 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -15,7 +15,7 @@
 #ifndef QAPI_VISITOR_H
 #define QAPI_VISITOR_H
 
-#include "qapi/qmp/qobject.h"
+#include "qapi-types.h"
 
 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 3dcb968867..d9a113726f 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
diff --git a/qmp.c b/qmp.c
index a56faf1b9a..f87de2bc26 100644
--- a/qmp.c
+++ b/qmp.c
@@ -32,7 +32,6 @@
 #include "qom/qom-qobject.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "hw/boards.h"
 #include "qom/object_interfaces.h"
diff --git a/qobject/qbool.c b/qobject/qbool.c
index ac825fc5a2..e5a7a53879 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qobject.h"
 #include "qemu-common.h"
 
 /**
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 7e7ac24cf7..88f87d2527 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -16,7 +16,6 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 268e46c8f0..613a95c12b 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -15,7 +15,6 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 517610d9da..60c395c1bc 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -14,7 +14,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qobject.h"
 #include "qemu-common.h"
 
 /**
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 74182a1c02..05b4bbc2d6 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu-common.h"
 
diff --git a/qom/object.c b/qom/object.c
index d97f09c1fb..5dcee4683c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -25,7 +25,6 @@
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
  * of the QOM core on QObject?  */
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index cad94778c7..e5ee69e9af 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -19,7 +19,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
 
-- 
2.13.6
