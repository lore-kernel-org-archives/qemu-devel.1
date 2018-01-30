Received: from eggs.gnu.org ([2001:4830:134:3::10]:59462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3N-00047y-DR
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3H-0000ZV-87
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3H-0000Yj-1E
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3339E780E7
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB7C96A03A
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:50 +0100
Message-Id: <20180130102202.28519-7-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/18] Typedef the subtypes of QObject in
 qemu/typedefs.h, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This renders many inclusions of qapi/qmp/q*.h superfluous.  They'll be
dropped in the next few commits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qbool.h   | 4 ++--
 include/qapi/qmp/qdict.h   | 4 ++--
 include/qapi/qmp/qlist.h   | 4 ++--
 include/qapi/qmp/qnum.h    | 4 ++--
 include/qapi/qmp/qstring.h | 4 ++--
 include/qemu/typedefs.h    | 7 ++++++-
 6 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
index f77ea86c4e..629c508d34 100644
--- a/include/qapi/qmp/qbool.h
+++ b/include/qapi/qmp/qbool.h
@@ -16,10 +16,10 @@
 
 #include "qapi/qmp/qobject.h"
 
-typedef struct QBool {
+struct QBool {
     QObject base;
     bool value;
-} QBool;
+};
 
 QBool *qbool_from_bool(bool value);
 bool qbool_get_bool(const QBool *qb);
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index fc218e7be6..d0c298114e 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -27,11 +27,11 @@ typedef struct QDictEntry {
     QLIST_ENTRY(QDictEntry) next;
 } QDictEntry;
 
-typedef struct QDict {
+struct QDict {
     QObject base;
     size_t size;
     QLIST_HEAD(,QDictEntry) table[QDICT_BUCKET_MAX];
-} QDict;
+};
 
 /* Object API */
 QDict *qdict_new(void);
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index ec3fcc1a4c..632b7ef2c1 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -23,10 +23,10 @@ typedef struct QListEntry {
     QTAILQ_ENTRY(QListEntry) next;
 } QListEntry;
 
-typedef struct QList {
+struct QList {
     QObject base;
     QTAILQ_HEAD(,QListEntry) head;
-} QList;
+};
 
 #define qlist_append(qlist, obj) \
         qlist_append_obj(qlist, QOBJECT(obj))
diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index c3d86794bb..15e3971c7f 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -44,7 +44,7 @@ typedef enum {
  * in range: qnum_get_try_int() / qnum_get_try_uint() check range and
  * convert under the hood.
  */
-typedef struct QNum {
+struct QNum {
     QObject base;
     QNumKind kind;
     union {
@@ -52,7 +52,7 @@ typedef struct QNum {
         uint64_t u64;
         double dbl;
     } u;
-} QNum;
+};
 
 QNum *qnum_from_int(int64_t value);
 QNum *qnum_from_uint(uint64_t value);
diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 65c05a9be5..98070ef3d6 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -15,12 +15,12 @@
 
 #include "qapi/qmp/qobject.h"
 
-typedef struct QString {
+struct QString {
     QObject base;
     char *string;
     size_t length;
     size_t capacity;
-} QString;
+};
 
 QString *qstring_new(void);
 QString *qstring_from_str(const char *str);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9bd7a834ba..78e2f08c0b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -92,8 +92,13 @@ typedef struct QemuOptsList QemuOptsList;
 typedef struct QEMUSGList QEMUSGList;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
-typedef struct QObject QObject;
+typedef struct QBool QBool;
+typedef struct QDict QDict;
+typedef struct QList QList;
 typedef struct QNull QNull;
+typedef struct QNum QNum;
+typedef struct QObject QObject;
+typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct SerialState SerialState;
-- 
2.13.6
