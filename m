Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF59C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC0620644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sg/4sKNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC0620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSdn-0006yM-Nl
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:42:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYo-0002jK-I1
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYn-0003Nn-Cg
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:34 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYn-0003Mi-5l
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:33 -0400
Received: by mail-pl1-x641.google.com with SMTP id g9so5708797plm.6
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eSYdriPx4kdDTBySMjSQ3hbHBLevuc9v6XaVM577ESk=;
	b=Sg/4sKNreLI47I2kSXyvKrfz/F9UXr8TRh0XKbe/P//pAE2vgTHjX0USqkAoNdpenR
	1AHiGGzNl8e+QgGrMqaEYMUrYdGlXuBYXWGsJ4XY4dz2IBBhEqpD/iOdJYDs/i1AS3NI
	s0ZRWShf11oA39tEj2NZUPCj96dwvKsz2sD//woQ5rVHMgzvXDJX6dAEtnWLhD+wo9KU
	oxiT4rBTbQJ1ckGTbgCqH1VSAJ/vaBV44QHHLMJZMA6+UnT5J+EwV4ax2Gv90NLjFnfI
	9W9GwBGMCElBsP9R89Ujbsu1MgNks/D4GHqdQZhHmOeo4IrIr+bPeI55Kd/BgI/Mr7dy
	HfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eSYdriPx4kdDTBySMjSQ3hbHBLevuc9v6XaVM577ESk=;
	b=bS5B/KC70G0uN+dWCEmqizNw0DXlLQqfJwkri9/B+mTRu8hLQSEv5XYccOjDNfmx2c
	TtHKAh597oU/lLuwydPlRlHB5YIqoBGvswOIkyXZYPC1QgsO+AKWnjc1Pbs+NNJqIM/9
	kdrsN2lbmZWUd5CJWkaMOZ8dEF7qDyR75PliWUoXxUqnCduXxkUcN7NGxd5swwVect99
	97NmWFFFg9HkbVBGiVfiIP/TuKJk/pFxDMgWmJG2s0f7ERIif3kFoYYgtg8E7CyowNz4
	4hfxJVWQcvjZ4ph9C6A6Qd6PyP/qF/kKmVeI9hJeGAP5t5cfi4BCNvQIE3hKRbfl764h
	yFIg==
X-Gm-Message-State: APjAAAUiNWv6d/MG80Jwwe25tf7Ha1ZpRy/XldSguT77PuatZZUEBhK4
	Z8hIZ4P6MlzrLtAwRHneG1MYJKHqCGI=
X-Google-Smtp-Source: APXvYqzTc7xPJiOo2QTPVlHn5xM7bl2SbzTtj/ogb/Zg2ZCCUZedQSu/5j/to5T4ex4NoMGifEIhFQ==
X-Received: by 2002:a17:902:bd46:: with SMTP id
	b6mr10556307plx.173.1558298251963; 
	Sun, 19 May 2019 13:37:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:15 -0700
Message-Id: <20190519203726.20729-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 03/74] linux-user: Share more code for open
 and openat
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

The do_openat helper can have all of the code that is not directly
related to the argument ordering of these two syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-file.inc.c | 69 ++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 7974148ccb..961eed13ae 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -227,8 +227,8 @@ static int open_net_route(void *cpu_env, int fd)
 }
 #endif
 
-static int do_openat(void *cpu_env, int dirfd, const char *pathname,
-                     int flags, mode_t mode)
+static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
+                          int target_flags, mode_t mode)
 {
     struct fake_open {
         const char *filename;
@@ -247,9 +247,20 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname,
         { NULL, NULL, NULL }
     };
 
+    char *pathname = lock_user_string(target_path);
+    int flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
+    abi_long ret;
+
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
     if (is_proc_myself(pathname, "exe")) {
-        int execfd = qemu_getauxval(AT_EXECFD);
-        return execfd ? execfd : safe_openat(dirfd, exec_path, flags, mode);
+        ret = qemu_getauxval(AT_EXECFD);
+        if (ret == 0) {
+            ret = get_errno(safe_openat(dirfd, exec_path, flags, mode));
+        }
+        goto done;
     }
 
     for (fake_open = fakes; fake_open->filename; fake_open++) {
@@ -261,7 +272,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname,
     if (fake_open->filename) {
         const char *tmpdir;
         char filename[PATH_MAX];
-        int fd, r;
+        int fd;
 
         /* create temporary file to map stat to */
         tmpdir = getenv("TMPDIR");
@@ -271,55 +282,37 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname,
         snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpdir);
         fd = mkstemp(filename);
         if (fd < 0) {
-            return fd;
+            ret = -TARGET_ENOENT;
+            goto done;
         }
         unlink(filename);
 
-        r = fake_open->fill(cpu_env, fd);
-        if (r) {
-            int e = errno;
+        ret = fake_open->fill(cpu_env, fd);
+        if (ret) {
+            ret = get_errno(ret);
             close(fd);
-            errno = e;
-            return r;
+            goto done;
         }
         lseek(fd, 0, SEEK_SET);
-
-        return fd;
+        ret = fd;
+        goto done;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    ret = get_errno(safe_openat(dirfd, path(pathname), flags, mode));
+ done:
+    fd_trans_unregister(ret);
+    unlock_user(pathname, target_path, 0);
+    return ret;
 }
 
 #ifdef TARGET_NR_open
 SYSCALL_IMPL(open)
 {
-    char *p = lock_user_string(arg1);
-    abi_long ret;
-
-    if (!p) {
-        return -TARGET_EFAULT;
-    }
-    ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
-                              target_to_host_bitmask(arg2, fcntl_flags_tbl),
-                              arg3));
-    fd_trans_unregister(ret);
-    unlock_user(p, arg1, 0);
-    return ret;
+    return do_openat(cpu_env, AT_FDCWD, arg1, arg2, arg3);
 }
 #endif
 
 SYSCALL_IMPL(openat)
 {
-    char *p = lock_user_string(arg2);
-    abi_long ret;
-
-    if (!p) {
-        return -TARGET_EFAULT;
-    }
-    ret = get_errno(do_openat(cpu_env, arg1, p,
-                              target_to_host_bitmask(arg3, fcntl_flags_tbl),
-                              arg4));
-    fd_trans_unregister(ret);
-    unlock_user(p, arg2, 0);
-    return ret;
+    return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
-- 
2.17.1


