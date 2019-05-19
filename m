Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3BC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD50520657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNoyolei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD50520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSJk-0006vK-UX
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:22:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHo-0005PI-Ft
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHn-0007I9-6z
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:00 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHn-0007HV-0m
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:19:59 -0400
Received: by mail-pf1-x443.google.com with SMTP id c6so6140816pfa.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=F6v6DXx3p/jSQwESHeV1J+7APHSrqQWGEt14uQc8gHo=;
	b=LNoyoleiOmWy0+b5gqhq8DClyyS7FdElq0Iyolo/4h3pAWSQOECoXCfuj6RQ8Fd3yo
	RqZOpo3P9VyQKhkETAtVf/1MhSofklJRjqtm4ZdmyqVu86sf7VStdm+C1ldRqT7bFZZf
	McXkW0M/tQ8SHgNu487ySJUA1x40uJZRmYoCZHAO5u+B8cUFLUiHaIz+RA6uBNOmZed7
	8TkwyIeZhaJNE/+/EzYjLru742oJAL43oEl3nv1zVvWaCgxhrLygcsqLi8/v6BJY5t0r
	z71BEx/7b1Pw08/dtu/WPt4pYR4Itu720vbE1moZINx9+7XAUQ74OpZfYyRhUF3aRTVM
	MXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=F6v6DXx3p/jSQwESHeV1J+7APHSrqQWGEt14uQc8gHo=;
	b=TXcytjB5kN1GHt5qUgwLMjo/8R7WKp7YoH2FDD7bnguMA8o76Y25uNrQ5Ek7QcdIQr
	cH0ok141Vz32ajLq7/ImV+yKQSkaqwC/tKnwxj8QQpJauSxyF5nbhfw71/jm6hKUS77M
	xyeu/rWmwBJ4XsA3YzyahcHpaUHNXVCDBkUsp0bBOsSzmkS9B+ISpgnshlBQZmECFLf2
	wYe/AOOzm0/4gGVvhlnQ5Lt8pB87NzgGPxeW0LtYOWLfEteLJMeK0N2WXqze7EBopW8p
	w6V/XOMVDdFryF624e2JwhstkUFEVHu54jQQSNcx/8qETQjMCtPqVlx3qm58M4rX20gZ
	0Jhg==
X-Gm-Message-State: APjAAAVJqzL5DnY3xO/hneECmiLMin24s9lHKQ1H3ewQfGCuaekYPL4w
	dXyRao1T5WO7Lj/LoyAsm/MTVOuCuiM=
X-Google-Smtp-Source: APXvYqx+Yhbor1WoBqlmIXCyQyXQzlpLrRCxiHTAQert1WXxy18ZDXEN/WFM/tgzFZhhYFfv8eUurA==
X-Received: by 2002:a63:144e:: with SMTP id 14mr53861332pgu.304.1558297197610; 
	Sun, 19 May 2019 13:19:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.19.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:19:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:41 -0700
Message-Id: <20190519201953.20161-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 01/13] util/path: Do not cache all filenames at
 startup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If one uses -L $PATH to point to a full chroot, the startup time
is significant.  In addition, the existing probing algorithm fails
to handle symlink loops.

Instead, probe individual paths on demand.  Cache both positive
and negative results within $PATH, so that any one filename is
probed only once.

Use glib filename functions for clarity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/path.c | 201 ++++++++++++----------------------------------------
 1 file changed, 47 insertions(+), 154 deletions(-)

diff --git a/util/path.c b/util/path.c
index 7f9fc272fb..8e174eb436 100644
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
-
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
-{
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
-    }
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
-
-    *e = new_entry(root->pathname, root, name);
-    if (is_dir_maybe(type)) {
-        *e = add_dir_maybe(*e);
-    }
-
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
-}
-
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
+static const char *base;
+static GHashTable *hash;
+static QemuMutex lock;
 
 void init_paths(const char *prefix)
 {
-    char pref_buf[PATH_MAX];
-
-    if (prefix[0] == '\0' ||
-        !strcmp(prefix, "/"))
+    if (prefix[0] == '\0' || !strcmp(prefix, "/")) {
         return;
-
-    if (prefix[0] != '/') {
-        char *cwd = getcwd(NULL, 0);
-        size_t pref_buf_len = sizeof(pref_buf);
-
-        if (!cwd)
-            abort();
-        pstrcpy(pref_buf, sizeof(pref_buf), cwd);
-        pstrcat(pref_buf, pref_buf_len, "/");
-        pstrcat(pref_buf, pref_buf_len, prefix);
-        free(cwd);
-    } else
-        pstrcpy(pref_buf, sizeof(pref_buf), prefix + 1);
-
-    base = new_entry("", NULL, pref_buf);
-    base = add_dir_maybe(base);
-    if (base->num_entries == 0) {
-        g_free(base->pathname);
-        g_free(base->name);
-        g_free(base);
-        base = NULL;
-    } else {
-        set_parents(base, base);
     }
+
+    if (prefix[0] == '/') {
+        base = g_strdup(prefix);
+    } else {
+        char *cwd = g_get_current_dir();
+        base = g_build_filename(cwd, prefix, NULL);
+        g_free(cwd);
+    }
+
+    hash = g_hash_table_new(g_str_hash, g_str_equal);
+    qemu_mutex_init(&lock);
 }
 
 /* Look for path in emulation dir, otherwise return name. */
 const char *path(const char *name)
 {
-    /* Only do absolute paths: quick and dirty, but should mostly be OK.
-       Could do relative by tracking cwd. */
-    if (!base || !name || name[0] != '/')
-        return name;
+    gpointer key, value;
+    const char *ret;
 
-    return follow_path(base, name) ?: name;
+    /* Only do absolute paths: quick and dirty, but should mostly be OK.  */
+    if (!base || !name || name[0] != '/') {
+        return name;
+    }
+
+    qemu_mutex_lock(&lock);
+
+    /* Have we looked up this file before?  */
+    if (g_hash_table_lookup_extended(hash, name, &key, &value)) {
+        ret = value ? value : name;
+    } else {
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
+    }
+
+    qemu_mutex_unlock(&lock);
+    return ret;
 }
-- 
2.17.1


