Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003My-Ac
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxM-00019l-00
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxL-000197-Mg
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BFC440216EA
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EBFB05032B
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:32:00 +0200
Message-Id: <20180824193206.25475-53-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 52/58] qobject: Drop superfluous includes of
 qemu-common.h
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-53-armbru@redhat.com>
---
 include/qapi/qmp/json-parser.h | 1 -
 qobject/json-lexer.c           | 1 -
 qobject/json-streamer.c        | 1 -
 qobject/qbool.c                | 1 -
 qobject/qlist.c                | 1 -
 qobject/qnull.c                | 1 -
 qobject/qnum.c                 | 1 -
 qobject/qobject.c              | 1 -
 qobject/qstring.c              | 1 -
 9 files changed, 9 deletions(-)

diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.h
index 21b23d7bec..55f75954c3 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -14,7 +14,6 @@
 #ifndef QEMU_JSON_PARSER_H
 #define QEMU_JSON_PARSER_H
 
-#include "qemu-common.h"
 #include "qapi/qmp/json-lexer.h"
 
 typedef struct JSONToken JSONToken;
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index a728c32faa..06ec67dc45 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -12,7 +12,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-streamer.h"
 
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 467bc29413..da53e770e9 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -12,7 +12,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-parser.h"
diff --git a/qobject/qbool.c b/qobject/qbool.c
index b58249925c..06dfc43498 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qbool.h"
-#include "qemu-common.h"
 
 /**
  * qbool_from_bool(): Create a new QBool from a bool
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 37c1c167f1..b3274af88b 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -17,7 +17,6 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/queue.h"
-#include "qemu-common.h"
 
 /**
  * qlist_new(): Create a new QList
diff --git a/qobject/qnull.c b/qobject/qnull.c
index f6f55f11ea..00870a1824 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qnull.h"
 
 QNull qnull_ = {
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 1501c82832..7012fc57f2 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -14,7 +14,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qnum.h"
-#include "qemu-common.h"
 
 /**
  * qnum_from_int(): Create a new QNum from an int64_t
diff --git a/qobject/qobject.c b/qobject/qobject.c
index cf4b7e229e..878dd76e79 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -8,7 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 0f1510e792..1c6897df00 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qstring.h"
-#include "qemu-common.h"
 
 /**
  * qstring_new(): Create a new empty QString
-- 
2.17.1
