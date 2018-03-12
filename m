Received: from eggs.gnu.org ([2001:4830:134:3::10]:45106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJQ-0000cd-7P
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJO-0005tu-Nd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJO-0005sh-I9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BB44814DF58
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:42 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:59 -0500
Message-Id: <20180312183628.394722-9-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 08/36] qapi: Remove qobject_to_X() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Max Reitz <mreitz@redhat.com>

They are no longer needed now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20180224154033.29559-5-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qbool.h   |  1 -
 include/qapi/qmp/qdict.h   |  1 -
 include/qapi/qmp/qlist.h   |  1 -
 include/qapi/qmp/qnum.h    |  1 -
 include/qapi/qmp/qstring.h |  1 -
 qobject/qbool.c            | 11 -----------
 qobject/qdict.c            | 11 -----------
 qobject/qlist.c            | 11 -----------
 qobject/qnum.c             | 11 -----------
 qobject/qstring.c          | 11 -----------
 10 files changed, 60 deletions(-)

diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
index 629c508d34f..b9a44a1bfe0 100644
--- a/include/qapi/qmp/qbool.h
+++ b/include/qapi/qmp/qbool.h
@@ -23,7 +23,6 @@ struct QBool {

 QBool *qbool_from_bool(bool value);
 bool qbool_get_bool(const QBool *qb);
-QBool *qobject_to_qbool(const QObject *obj);
 bool qbool_is_equal(const QObject *x, const QObject *y);
 void qbool_destroy_obj(QObject *obj);

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 7c6d8445495..2cc3e906f7b 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -39,7 +39,6 @@ void qdict_put_obj(QDict *qdict, const char *key, QObject *value);
 void qdict_del(QDict *qdict, const char *key);
 int qdict_haskey(const QDict *qdict, const char *key);
 QObject *qdict_get(const QDict *qdict, const char *key);
-QDict *qobject_to_qdict(const QObject *obj);
 bool qdict_is_equal(const QObject *x, const QObject *y);
 void qdict_iter(const QDict *qdict,
                 void (*iter)(const char *key, QObject *obj, void *opaque),
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 5fd976a3981..5c673acb060 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -53,7 +53,6 @@ QObject *qlist_pop(QList *qlist);
 QObject *qlist_peek(QList *qlist);
 int qlist_empty(const QList *qlist);
 size_t qlist_size(const QList *qlist);
-QList *qobject_to_qlist(const QObject *obj);
 bool qlist_is_equal(const QObject *x, const QObject *y);
 void qlist_destroy_obj(QObject *obj);

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 15e3971c7f1..3e47475b2cb 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -68,7 +68,6 @@ double qnum_get_double(QNum *qn);

 char *qnum_to_string(QNum *qn);

-QNum *qobject_to_qnum(const QObject *obj);
 bool qnum_is_equal(const QObject *x, const QObject *y);
 void qnum_destroy_obj(QObject *obj);

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 98070ef3d6a..b72843fc1b0 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -30,7 +30,6 @@ const char *qstring_get_str(const QString *qstring);
 void qstring_append_int(QString *qstring, int64_t value);
 void qstring_append(QString *qstring, const char *str);
 void qstring_append_chr(QString *qstring, int c);
-QString *qobject_to_qstring(const QObject *obj);
 bool qstring_is_equal(const QObject *x, const QObject *y);
 void qstring_destroy_obj(QObject *obj);

diff --git a/qobject/qbool.c b/qobject/qbool.c
index 5be6277cca8..b58249925c2 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -39,17 +39,6 @@ bool qbool_get_bool(const QBool *qb)
     return qb->value;
 }

-/**
- * qobject_to_qbool(): Convert a QObject into a QBool
- */
-QBool *qobject_to_qbool(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) != QTYPE_QBOOL) {
-        return NULL;
-    }
-    return container_of(obj, QBool, base);
-}
-
 /**
  * qbool_is_equal(): Test whether the two QBools are equal
  */
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 1e588123d00..45c8b53361f 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -37,17 +37,6 @@ QDict *qdict_new(void)
     return qdict;
 }

-/**
- * qobject_to_qdict(): Convert a QObject into a QDict
- */
-QDict *qobject_to_qdict(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) != QTYPE_QDICT) {
-        return NULL;
-    }
-    return container_of(obj, QDict, base);
-}
-
 /**
  * tdb_hash(): based on the hash agorithm from gdbm, via tdb
  * (from module-init-tools)
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 77f19ffda78..954fe983751 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -151,17 +151,6 @@ size_t qlist_size(const QList *qlist)
     return count;
 }

-/**
- * qobject_to_qlist(): Convert a QObject into a QList
- */
-QList *qobject_to_qlist(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) != QTYPE_QLIST) {
-        return NULL;
-    }
-    return container_of(obj, QList, base);
-}
-
 /**
  * qlist_is_equal(): Test whether the two QLists are equal
  *
diff --git a/qobject/qnum.c b/qobject/qnum.c
index ea091cfaa4b..1501c828323 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -199,17 +199,6 @@ char *qnum_to_string(QNum *qn)
     return NULL;
 }

-/**
- * qobject_to_qnum(): Convert a QObject into a QNum
- */
-QNum *qobject_to_qnum(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) != QTYPE_QNUM) {
-        return NULL;
-    }
-    return container_of(obj, QNum, base);
-}
-
 /**
  * qnum_is_equal(): Test whether the two QNums are equal
  *
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 2b2153206df..8bae529ef79 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -105,17 +105,6 @@ void qstring_append_chr(QString *qstring, int c)
     qstring->string[qstring->length] = 0;
 }

-/**
- * qobject_to_qstring(): Convert a QObject to a QString
- */
-QString *qobject_to_qstring(const QObject *obj)
-{
-    if (!obj || qobject_type(obj) != QTYPE_QSTRING) {
-        return NULL;
-    }
-    return container_of(obj, QString, base);
-}
-
 /**
  * qstring_get_str(): Return a pointer to the stored string
  *
-- 
2.14.3
