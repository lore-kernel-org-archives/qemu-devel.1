Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A64C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627432072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpDLWiHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627432072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqbd-0005nM-J8
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVi-0003d4-5j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVg-0004OV-F1
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVg-0004Nu-8M
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id e26so2232323wmk.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1J4Mb00cD/gBndme3KRwMHmDdy2oCcZCIa8IBou3aHg=;
 b=GpDLWiHOKc9NuiNI7Z/GbclUEwnk9F1uroe7YWurmeYHOylclPEBBoN0mPwRqDnI73
 skZfvA/M3g3CvUyYsQFcCkOo2ufbemcf7ZXhenFjutLgAIXnbXhjSEjWqqJ8UELNrCVe
 XEK7wrKmlySAQefuSXKDlAluJo9l2VsOaUydQa49MvuMoLjcrWay2RSDI3iS/F1D5iPN
 pBTyuDu0lLXzQSkf9BqEc/za62i416Dl0wfyJwIgAnof1fZmSb1c8L+z0l+NQVd8vj/h
 4d5itWKb4vRDKEvOAs1wE3PpfJMK3uv5hc50drqA/K595xqM/foF/2CaC1KlQ34u3nWZ
 yW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1J4Mb00cD/gBndme3KRwMHmDdy2oCcZCIa8IBou3aHg=;
 b=dVcMkzQ4/vLwq15pEGRLbHEXl7JSMbIAF8CIeZso/JiS04wO6BMeSzRxwkCa0Dsn7M
 1K9msRDIFR/V7+AstIEBzfh42TifN8ogBAbJaKjE9+4PcK8EQmWmzumWAujkdgV64qfo
 ldlu5PJGNmYzCaIdYIPLcBvvjOWEKNJzq+3T3Z2MF6D4ysiZXAHDnjiL1hbTwWGxixL4
 bBgs6SiIpEITbb+wp8UG6S7DaPGCIDNV0uZCbOQaT0qKRaCvHKUN/rZu8so1ZnthP50E
 ppMXod1vNEEqBiL9rH1i2kD7brjUQlO7XzvaeAYaXqBxPUOM/VILyYdJrVNhSHcoSzP8
 j7WQ==
X-Gm-Message-State: AGi0PubYOuCDXq9P/Mx2ymmfc4/nBrWnhl1qZ7W1JGtej97516iY7JMN
 zy3E2nmJSVPmtFsNrlE3ICp8GgpTwJ4=
X-Google-Smtp-Source: APiQypKC1zBU/34fmCdCAJ+GiqRzDVXYcqkGz0tWTvPZUnQx73ZuuJtvf7NwhvlP1nM0mPZej4brBQ==
X-Received: by 2002:a7b:c3ce:: with SMTP id t14mr3167701wmj.9.1586274691083;
 Tue, 07 Apr 2020 08:51:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p22sm2849817wmc.42.2020.04.07.08.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 165AD1FF98;
 Tue,  7 Apr 2020 16:51:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/13] linux-user: factor out reading of /proc/self/maps
Date: Tue,  7 Apr 2020 16:51:14 +0100
Message-Id: <20200407155118.20139-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately reading /proc/self/maps is still considered the gold
standard for a process finding out about it's own memory layout. As we
will want this data in other contexts soon factor out the code to read
and parse the data. Rather than just blindly copying the existing
sscanf based code we use a more modern glib version of the parsing
code to make a more general purpose map structure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200403191150.863-9-alex.bennee@linaro.org>

diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h
new file mode 100644
index 00000000000..8382c4c779d
--- /dev/null
+++ b/include/qemu/selfmap.h
@@ -0,0 +1,44 @@
+/*
+ * Utility functions to read our own memory map
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _SELFMAP_H_
+#define _SELFMAP_H_
+
+typedef struct {
+    unsigned long start;
+    unsigned long end;
+
+    /* flags */
+    bool is_read;
+    bool is_write;
+    bool is_exec;
+    bool is_priv;
+
+    unsigned long offset;
+    gchar *dev;
+    uint64_t inode;
+    gchar *path;
+} MapInfo;
+
+
+/**
+ * read_self_maps:
+ *
+ * Read /proc/self/maps and return a list of MapInfo structures.
+ */
+GSList *read_self_maps(void);
+
+/**
+ * free_self_maps:
+ * @info: a GSlist
+ *
+ * Free a list of MapInfo structures.
+ */
+void free_self_maps(GSList *info);
+
+#endif /* _SELFMAP_H_ */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b679bc6b136..5f117872947 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -117,6 +117,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "qemu/selfmap.h"
 #include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
@@ -7232,45 +7233,45 @@ static int open_self_maps(void *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
-    FILE *fp;
-    char *line = NULL;
-    size_t len = 0;
-    ssize_t read;
+    GSList *map_info = read_self_maps();
+    GSList *s;
 
-    fp = fopen("/proc/self/maps", "r");
-    if (fp == NULL) {
-        return -1;
-    }
+    for (s = map_info; s; s = g_slist_next(s)) {
+        MapInfo *e = (MapInfo *) s->data;
 
-    while ((read = getline(&line, &len, fp)) != -1) {
-        int fields, dev_maj, dev_min, inode;
-        uint64_t min, max, offset;
-        char flag_r, flag_w, flag_x, flag_p;
-        char path[512] = "";
-        fields = sscanf(line, "%"PRIx64"-%"PRIx64" %c%c%c%c %"PRIx64" %x:%x %d"
-                        " %512s", &min, &max, &flag_r, &flag_w, &flag_x,
-                        &flag_p, &offset, &dev_maj, &dev_min, &inode, path);
-
-        if ((fields < 10) || (fields > 11)) {
-            continue;
-        }
-        if (h2g_valid(min)) {
+        if (h2g_valid(e->start)) {
+            unsigned long min = e->start;
+            unsigned long max = e->end;
             int flags = page_get_flags(h2g(min));
-            max = h2g_valid(max - 1) ? max : (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;
+            const char *path;
+
+            max = h2g_valid(max - 1) ?
+                max : (uintptr_t) g2h(GUEST_ADDR_MAX) + 1;
+
             if (page_check_range(h2g(min), max - min, flags) == -1) {
                 continue;
             }
+
             if (h2g(min) == ts->info->stack_limit) {
-                pstrcpy(path, sizeof(path), "      [stack]");
+                path = "      [stack]";
+            } else {
+                path = e->path;
             }
+
             dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                    " %c%c%c%c %08" PRIx64 " %02x:%02x %d %s%s\n",
-                    h2g(min), h2g(max - 1) + 1, flag_r, flag_w,
-                    flag_x, flag_p, offset, dev_maj, dev_min, inode,
-                    path[0] ? "         " : "", path);
+                    " %c%c%c%c %08" PRIx64 " %s %"PRId64" %s%s\n",
+                    h2g(min), h2g(max - 1) + 1,
+                    e->is_read ? 'r' : '-',
+                    e->is_write ? 'w' : '-',
+                    e->is_exec ? 'x' : '-',
+                    e->is_priv ? 'p' : '-',
+                    (uint64_t) e->offset, e->dev, e->inode,
+                    path ? "         " : "", path ? path : "");
         }
     }
 
+    free_self_maps(map_info);
+
 #ifdef TARGET_VSYSCALL_PAGE
     /*
      * We only support execution from the vsyscall page.
@@ -7281,9 +7282,6 @@ static int open_self_maps(void *cpu_env, int fd)
             TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
 #endif
 
-    free(line);
-    fclose(fp);
-
     return 0;
 }
 
diff --git a/util/selfmap.c b/util/selfmap.c
new file mode 100644
index 00000000000..2ec99dfdda1
--- /dev/null
+++ b/util/selfmap.c
@@ -0,0 +1,78 @@
+/*
+ * Utility function to get QEMU's own process map
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/selfmap.h"
+
+GSList *read_self_maps(void)
+{
+    gchar *maps;
+    GSList *map_info = NULL;
+
+    if (g_file_get_contents("/proc/self/maps", &maps, NULL, NULL)) {
+        gchar **lines = g_strsplit(maps, "\n", 0);
+        int i, entries = g_strv_length(lines);
+
+        for (i = 0; i < entries; i++) {
+            gchar **fields = g_strsplit(lines[i], " ", 6);
+            if (g_strv_length(fields) > 4) {
+                MapInfo *e = g_new0(MapInfo, 1);
+                int errors;
+                const char *end;
+
+                errors  = qemu_strtoul(fields[0], &end, 16, &e->start);
+                errors += qemu_strtoul(end + 1, NULL, 16, &e->end);
+
+                e->is_read  = fields[1][0] == 'r';
+                e->is_write = fields[1][1] == 'w';
+                e->is_exec  = fields[1][2] == 'x';
+                e->is_priv  = fields[1][3] == 'p';
+
+                errors += qemu_strtoul(fields[2], NULL, 16, &e->offset);
+                e->dev = g_strdup(fields[3]);
+                errors += qemu_strtou64(fields[4], NULL, 10, &e->inode);
+
+                /*
+                 * The last field may have leading spaces which we
+                 * need to strip.
+                 */
+                if (g_strv_length(fields) == 6) {
+                    e->path = g_strdup(g_strchug(fields[5]));
+                }
+                map_info = g_slist_prepend(map_info, e);
+            }
+
+            g_strfreev(fields);
+        }
+        g_strfreev(lines);
+        g_free(maps);
+    }
+
+    /* ensure the map data is in the same order we collected it */
+    return g_slist_reverse(map_info);
+}
+
+/**
+ * free_self_maps:
+ * @info: a GSlist
+ *
+ * Free a list of MapInfo structures.
+ */
+static void free_info(gpointer data)
+{
+    MapInfo *e = (MapInfo *) data;
+    g_free(e->dev);
+    g_free(e->path);
+    g_free(e);
+}
+
+void free_self_maps(GSList *info)
+{
+    g_slist_free_full(info, &free_info);
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 6718a38b616..fe339c2636b 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -63,3 +63,4 @@ util-obj-y += guest-random.o
 util-obj-$(CONFIG_GIO) += dbus.o
 dbus.o-cflags = $(GIO_CFLAGS)
 dbus.o-libs = $(GIO_LIBS)
+util-obj-$(CONFIG_USER_ONLY) += selfmap.o
-- 
2.20.1


