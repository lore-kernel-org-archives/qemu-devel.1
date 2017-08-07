Received: from eggs.gnu.org ([2001:4830:134:3::10]:48688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIq-00075K-Q6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIb-0003jr-MT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:44 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:05 +0200
Message-Id: <1502117160-24655-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/56] qobject: Touch up comments to say
 @param instead of 'param'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/qdict.c | 68 ++++++++++++++++++++++++++++-----------------------------
 qobject/qlist.c |  2 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/qobject/qdict.c b/qobject/qdict.c
index 576018e..d795079 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -116,13 +116,13 @@ static QDictEntry *qdict_find(const QDict *qdict,
 /**
  * qdict_put_obj(): Put a new QObject into the dictionary
  *
- * Insert the pair 'key:value' into 'qdict', if 'key' already exists
- * its 'value' will be replaced.
+ * Insert the pair @key:@value into @qdict, if @key already exists
+ * its value will be replaced.
  *
  * This is done by freeing the reference to the stored QObject and
  * storing the new one in the same entry.
  *
- * NOTE: ownership of 'value' is transferred to the QDict
+ * NOTE: ownership of @value is transferred to the QDict
  */
 void qdict_put_obj(QDict *qdict, const char *key, QObject *value)
 {
@@ -144,10 +144,10 @@ void qdict_put_obj(QDict *qdict, const char *key, QObject *value)
 }
 
 /**
- * qdict_get(): Lookup for a given 'key'
+ * qdict_get(): Lookup for a given @key
  *
- * Return a weak reference to the QObject associated with 'key' if
- * 'key' is present in the dictionary, NULL otherwise.
+ * Return a weak reference to the QObject associated with @key if
+ * @key is present in the dictionary, NULL otherwise.
  */
 QObject *qdict_get(const QDict *qdict, const char *key)
 {
@@ -158,9 +158,9 @@ QObject *qdict_get(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_haskey(): Check if 'key' exists
+ * qdict_haskey(): Check if @key exists
  *
- * Return 1 if 'key' exists in the dict, 0 otherwise
+ * Return 1 if @key exists in the dict, 0 otherwise
  */
 int qdict_haskey(const QDict *qdict, const char *key)
 {
@@ -177,11 +177,11 @@ size_t qdict_size(const QDict *qdict)
 }
 
 /**
- * qdict_get_double(): Get an number mapped by 'key'
+ * qdict_get_double(): Get an number mapped by @key
  *
- * This function assumes that 'key' exists and it stores a QNum.
+ * This function assumes that @key exists and it stores a QNum.
  *
- * Return number mapped by 'key'.
+ * Return number mapped by @key.
  */
 double qdict_get_double(const QDict *qdict, const char *key)
 {
@@ -189,12 +189,12 @@ double qdict_get_double(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_get_int(): Get an integer mapped by 'key'
+ * qdict_get_int(): Get an integer mapped by @key
  *
- * This function assumes that 'key' exists and it stores a
+ * This function assumes that @key exists and it stores a
  * QNum representable as int.
  *
- * Return integer mapped by 'key'.
+ * Return integer mapped by @key.
  */
 int64_t qdict_get_int(const QDict *qdict, const char *key)
 {
@@ -202,12 +202,12 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_get_bool(): Get a bool mapped by 'key'
+ * qdict_get_bool(): Get a bool mapped by @key
  *
- * This function assumes that 'key' exists and it stores a
+ * This function assumes that @key exists and it stores a
  * QBool object.
  *
- * Return bool mapped by 'key'.
+ * Return bool mapped by @key.
  */
 bool qdict_get_bool(const QDict *qdict, const char *key)
 {
@@ -232,12 +232,12 @@ QDict *qdict_get_qdict(const QDict *qdict, const char *key)
 
 /**
  * qdict_get_str(): Get a pointer to the stored string mapped
- * by 'key'
+ * by @key
  *
- * This function assumes that 'key' exists and it stores a
+ * This function assumes that @key exists and it stores a
  * QString object.
  *
- * Return pointer to the string mapped by 'key'.
+ * Return pointer to the string mapped by @key.
  */
 const char *qdict_get_str(const QDict *qdict, const char *key)
 {
@@ -245,11 +245,11 @@ const char *qdict_get_str(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_get_try_int(): Try to get integer mapped by 'key'
+ * qdict_get_try_int(): Try to get integer mapped by @key
  *
- * Return integer mapped by 'key', if it is not present in the
+ * Return integer mapped by @key, if it is not present in the
  * dictionary or if the stored object is not a QNum representing an
- * integer, 'def_value' will be returned.
+ * integer, @def_value will be returned.
  */
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value)
@@ -265,11 +265,11 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
 }
 
 /**
- * qdict_get_try_bool(): Try to get a bool mapped by 'key'
+ * qdict_get_try_bool(): Try to get a bool mapped by @key
  *
- * Return bool mapped by 'key', if it is not present in the
+ * Return bool mapped by @key, if it is not present in the
  * dictionary or if the stored object is not of QBool type
- * 'def_value' will be returned.
+ * @def_value will be returned.
  */
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value)
 {
@@ -280,9 +280,9 @@ bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value)
 
 /**
  * qdict_get_try_str(): Try to get a pointer to the stored string
- * mapped by 'key'
+ * mapped by @key
  *
- * Return a pointer to the string mapped by 'key', if it is not present
+ * Return a pointer to the string mapped by @key, if it is not present
  * in the dictionary or if the stored object is not of QString type
  * NULL will be returned.
  */
@@ -427,8 +427,8 @@ void qdict_destroy_obj(QObject *obj)
 }
 
 /**
- * qdict_copy_default(): If no entry mapped by 'key' exists in 'dst' yet, the
- * value of 'key' in 'src' is copied there (and the refcount increased
+ * qdict_copy_default(): If no entry mapped by @key exists in @dst yet, the
+ * value of @key in @src is copied there (and the refcount increased
  * accordingly).
  */
 void qdict_copy_default(QDict *dst, QDict *src, const char *key)
@@ -447,8 +447,8 @@ void qdict_copy_default(QDict *dst, QDict *src, const char *key)
 }
 
 /**
- * qdict_set_default_str(): If no entry mapped by 'key' exists in 'dst' yet, a
- * new QString initialised by 'val' is put there.
+ * qdict_set_default_str(): If no entry mapped by @key exists in @dst yet, a
+ * new QString initialised by @val is put there.
  */
 void qdict_set_default_str(QDict *dst, const char *key, const char *val)
 {
@@ -667,8 +667,8 @@ void qdict_array_split(QDict *src, QList **dst)
  *    'foo.0.bar' -> prefix='foo' and suffix='0.bar'
  *    'foo..0.bar' -> prefix='foo.0' and suffix='bar'
  *
- * The '..' sequence will be unescaped in the returned 'prefix'
- * string. The 'suffix' string will be left in escaped format, so it
+ * The '..' sequence will be unescaped in the returned @prefix
+ * string. The @suffix string will be left in escaped format, so it
  * can be fed back into the qdict_split_flat_key() key as the input
  * later.
  *
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 86b60cb..f11dc5b 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -52,7 +52,7 @@ QList *qlist_copy(QList *src)
 /**
  * qlist_append_obj(): Append an QObject into QList
  *
- * NOTE: ownership of 'value' is transferred to the QList
+ * NOTE: ownership of @value is transferred to the QList
  */
 void qlist_append_obj(QList *qlist, QObject *value)
 {
-- 
2.7.5
