Received: from eggs.gnu.org ([2001:4830:134:3::10]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth3-0008Vy-N3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egtgz-0003dT-2e
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egtgy-0003cg-RH
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:53 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:34 +0100
Message-Id: <20180131144846.31697-8-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/19] Typedef the subtypes of QObject in
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
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

This renders many inclusions of qapi/qmp/q*.h superfluous.  They'll be
dropped in the next few commits.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
=20
 #include "qapi/qmp/qobject.h"
=20
-typedef struct QBool {
+struct QBool {
     QObject base;
     bool value;
-} QBool;
+};
=20
 QBool *qbool_from_bool(bool value);
 bool qbool_get_bool(const QBool *qb);
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index fc218e7be6..d0c298114e 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -27,11 +27,11 @@ typedef struct QDictEntry {
     QLIST_ENTRY(QDictEntry) next;
 } QDictEntry;
=20
-typedef struct QDict {
+struct QDict {
     QObject base;
     size_t size;
     QLIST_HEAD(,QDictEntry) table[QDICT_BUCKET_MAX];
-} QDict;
+};
=20
 /* Object API */
 QDict *qdict_new(void);
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index ec3fcc1a4c..632b7ef2c1 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -23,10 +23,10 @@ typedef struct QListEntry {
     QTAILQ_ENTRY(QListEntry) next;
 } QListEntry;
=20
-typedef struct QList {
+struct QList {
     QObject base;
     QTAILQ_HEAD(,QListEntry) head;
-} QList;
+};
=20
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
=20
 QNum *qnum_from_int(int64_t value);
 QNum *qnum_from_uint(uint64_t value);
diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 65c05a9be5..98070ef3d6 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -15,12 +15,12 @@
=20
 #include "qapi/qmp/qobject.h"
=20
-typedef struct QString {
+struct QString {
     QObject base;
     char *string;
     size_t length;
     size_t capacity;
-} QString;
+};
=20
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
--=20
2.13.6
