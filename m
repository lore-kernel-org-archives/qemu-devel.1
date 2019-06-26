Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5473C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8690F20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8690F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6oS-0007Sa-Q6
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mV-0005bP-GV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mT-0000pL-Le
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6mT-0000l5-36
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:05 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAwPf-1hqo1q0ucL-00BJMb; Wed, 26 Jun 2019 14:11:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:34 +0200
Message-Id: <20190626121139.19114-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
References: <20190626121139.19114-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ui0tnn6wr8frkgkNKUI2A5bMESmhU0/bggWXerM4U3JzIGWhPzj
 SDcYe/WEQeD3/6u7R06IPk1+uipyZsz0qKDf5ERxSaW+fNAOffzhwlCyQNJI7ekAx2w10G0
 G3DShJuZ1DUcr1H0M1dngBE1+KsTlZWE/hQOF2Z4+qtvKkSkyB5pufTSsAYMZ0KjSFQcf4J
 FzaH67N/4WI5rNa7o5LRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v7FjBSlm+fk=:y7w1AUsHyS4jQbtYxiop6t
 ulz3tGZi8uENGzaGKXaS/M+v1GdW6Rpcc6ae76LHK4SkwBwMXKGFC1pZ8rlKE1LV7WZJQbG0J
 ePTG5pVH7O/nWvRiBHkP6zYRvGvTx9tdldNIZO8FooxIYHTu8aaJ2xLZiABuPH4LHCrOd6HyO
 6YGwaPavOFC+k8ujjpcPlZ2IJze20Lo2W82MBBlqFKHdjlnYqyMY5M0CLKK21MgO44/7Q1CAy
 YiQj5j3qKv8Prz8s8fvyxeBY12IDzSYx4+zVFQtNXFb2OcDaQh/4ZqDxVKQzcJTiT1jTPq4Ei
 QITzHOZUZGxdeqKtPo+LS3PbdtvIg755+gi2bhvuKmOtWMzeEJyQ8O1maAtEF4MrMb6J+3rf5
 bCCZFcKCz4s1hH5xA0lD81C4G8s0/Jy91vCRY1/2Iu42+yZFa01sKf9kHRKz+g7EuWaBnKTOz
 fqshisatzc6yhDP1voW3U4INQfTzLO9PcMrVCXpDByiU6MnmG3sFVtQptH/2m8YcvuBIPwafD
 4hinh1RB5HzKf9vx6E3V96uHs+kJco0UUAG7+U6x6Ho+Oq+1i/9KBcvbjR0pI8iB7WZnqVjse
 seELPfsE90NaxpyJ+Sino6Xk+TUQMdFy+locWnfeyBX9GtXNNoTn6UABMy7EK9P1L+tLAHNEq
 WHHgWF/yMZaZaHcZVJOCXyQC4r+rTDLH3G1y/+Yprq9bIEe8YNzdS0RIjvZfNokY9VO9W+Dz3
 0YpzSXk714yTeZTjA4ho+hWNWzWqn5luZVl+Bg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 1/6] util/path: Do not cache all filenames at
 startup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

If one uses -L $PATH to point to a full chroot, the startup time
is significant.  In addition, the existing probing algorithm fails
to handle symlink loops.

Instead, probe individual paths on demand.  Cache both positive
and negative results within $PATH, so that any one filename is
probed only once.

Use glib filename functions for clarity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190519201953.20161-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/path.c | 193 ++++++++++++----------------------------------------
 1 file changed, 43 insertions(+), 150 deletions(-)

diff --git a/util/path.c b/util/path.c
index 7f9fc272fbb3..8e174eb43642 100644
--- a/util/path.c
+++ b/util/path.c
@@ -8,170 +8,63 @@
 #include <dirent.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
+#include "qemu/thread.h"
 
-struct pathelem
-{
-    /* Name of this, eg. lib */
-    char *name;
-    /* Full path name, eg. /usr/gnemul/x86-linux/lib. */
-    char *pathname;
-    struct pathelem *parent;
-    /* Children */
-    unsigned int num_entries;
-    struct pathelem *entries[0];
-};
-
-static struct pathelem *base;
-
-/* First N chars of S1 match S2, and S2 is N chars long. */
-static int strneq(const char *s1, unsigned int n, const char *s2)
-{
-    unsigned int i;
-
-    for (i = 0; i < n; i++)
-        if (s1[i] != s2[i])
-            return 0;
-    return s2[i] == 0;
-}
-
-static struct pathelem *add_entry(struct pathelem *root, const char *name,
-                                  unsigned type);
+static const char *base;
+static GHashTable *hash;
+static QemuMutex lock;
 
-static struct pathelem *new_entry(const char *root,
-                                  struct pathelem *parent,
-                                  const char *name)
-{
-    struct pathelem *new = g_malloc(sizeof(*new));
-    new->name = g_strdup(name);
-    new->pathname = g_strdup_printf("%s/%s", root, name);
-    new->num_entries = 0;
-    return new;
-}
-
-#define streq(a,b) (strcmp((a), (b)) == 0)
-
-/* Not all systems provide this feature */
-#if defined(DT_DIR) && defined(DT_UNKNOWN) && defined(DT_LNK)
-# define dirent_type(dirent) ((dirent)->d_type)
-# define is_dir_maybe(type) \
-    ((type) == DT_DIR || (type) == DT_UNKNOWN || (type) == DT_LNK)
-#else
-# define dirent_type(dirent) (1)
-# define is_dir_maybe(type)  (type)
-#endif
-
-static struct pathelem *add_dir_maybe(struct pathelem *path)
+void init_paths(const char *prefix)
 {
-    DIR *dir;
-
-    if ((dir = opendir(path->pathname)) != NULL) {
-        struct dirent *dirent;
-
-        while ((dirent = readdir(dir)) != NULL) {
-            if (!streq(dirent->d_name,".") && !streq(dirent->d_name,"..")){
-                path = add_entry(path, dirent->d_name, dirent_type(dirent));
-            }
-        }
-        closedir(dir);
+    if (prefix[0] == '\0' || !strcmp(prefix, "/")) {
+        return;
     }
-    return path;
-}
-
-static struct pathelem *add_entry(struct pathelem *root, const char *name,
-                                  unsigned type)
-{
-    struct pathelem **e;
-
-    root->num_entries++;
-
-    root = g_realloc(root, sizeof(*root)
-                   + sizeof(root->entries[0])*root->num_entries);
-    e = &root->entries[root->num_entries-1];
 
-    *e = new_entry(root->pathname, root, name);
-    if (is_dir_maybe(type)) {
-        *e = add_dir_maybe(*e);
+    if (prefix[0] == '/') {
+        base = g_strdup(prefix);
+    } else {
+        char *cwd = g_get_current_dir();
+        base = g_build_filename(cwd, prefix, NULL);
+        g_free(cwd);
     }
 
-    return root;
-}
-
-/* This needs to be done after tree is stabilized (ie. no more reallocs!). */
-static void set_parents(struct pathelem *child, struct pathelem *parent)
-{
-    unsigned int i;
-
-    child->parent = parent;
-    for (i = 0; i < child->num_entries; i++)
-        set_parents(child->entries[i], child);
+    hash = g_hash_table_new(g_str_hash, g_str_equal);
+    qemu_mutex_init(&lock);
 }
 
-/* FIXME: Doesn't handle DIR/.. where DIR is not in emulated dir. */
-static const char *
-follow_path(const struct pathelem *cursor, const char *name)
-{
-    unsigned int i, namelen;
-
-    name += strspn(name, "/");
-    namelen = strcspn(name, "/");
-
-    if (namelen == 0)
-        return cursor->pathname;
-
-    if (strneq(name, namelen, ".."))
-        return follow_path(cursor->parent, name + namelen);
-
-    if (strneq(name, namelen, "."))
-        return follow_path(cursor, name + namelen);
-
-    for (i = 0; i < cursor->num_entries; i++)
-        if (strneq(name, namelen, cursor->entries[i]->name))
-            return follow_path(cursor->entries[i], name + namelen);
-
-    /* Not found */
-    return NULL;
-}
-
-void init_paths(const char *prefix)
+/* Look for path in emulation dir, otherwise return name. */
+const char *path(const char *name)
 {
-    char pref_buf[PATH_MAX];
-
-    if (prefix[0] == '\0' ||
-        !strcmp(prefix, "/"))
-        return;
+    gpointer key, value;
+    const char *ret;
 
-    if (prefix[0] != '/') {
-        char *cwd = getcwd(NULL, 0);
-        size_t pref_buf_len = sizeof(pref_buf);
+    /* Only do absolute paths: quick and dirty, but should mostly be OK.  */
+    if (!base || !name || name[0] != '/') {
+        return name;
+    }
 
-        if (!cwd)
-            abort();
-        pstrcpy(pref_buf, sizeof(pref_buf), cwd);
-        pstrcat(pref_buf, pref_buf_len, "/");
-        pstrcat(pref_buf, pref_buf_len, prefix);
-        free(cwd);
-    } else
-        pstrcpy(pref_buf, sizeof(pref_buf), prefix + 1);
+    qemu_mutex_lock(&lock);
 
-    base = new_entry("", NULL, pref_buf);
-    base = add_dir_maybe(base);
-    if (base->num_entries == 0) {
-        g_free(base->pathname);
-        g_free(base->name);
-        g_free(base);
-        base = NULL;
+    /* Have we looked up this file before?  */
+    if (g_hash_table_lookup_extended(hash, name, &key, &value)) {
+        ret = value ? value : name;
     } else {
-        set_parents(base, base);
+        char *save = g_strdup(name);
+        char *full = g_build_filename(base, name, NULL);
+
+        /* Look for the path; record the result, pass or fail.  */
+        if (access(full, F_OK) == 0) {
+            /* Exists.  */
+            g_hash_table_insert(hash, save, full);
+            ret = full;
+        } else {
+            /* Does not exist.  */
+            g_free(full);
+            g_hash_table_insert(hash, save, NULL);
+            ret = name;
+        }
     }
-}
-
-/* Look for path in emulation dir, otherwise return name. */
-const char *path(const char *name)
-{
-    /* Only do absolute paths: quick and dirty, but should mostly be OK.
-       Could do relative by tracking cwd. */
-    if (!base || !name || name[0] != '/')
-        return name;
 
-    return follow_path(base, name) ?: name;
+    qemu_mutex_unlock(&lock);
+    return ret;
 }
-- 
2.21.0


