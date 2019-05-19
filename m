Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44110C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DC020644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dt6Oh+GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DC020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSgs-0001BN-47
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:45:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYs-0002m9-74
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYq-0003Rl-Qa
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYq-0003Qv-Jr
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id a3so5747684pgb.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=T/gNF/+WQ4Pn+UuyOMg1wvHnA4fUii7t4Tux8xUmkoc=;
	b=Dt6Oh+GYc5ECBGvXm8k40HNriBNshJGfarJIgu4ZyvWlyiJ7RPVRJRXbceNCNFeHdZ
	+HXBwmHKQSKyam0OggyMej2UtxVQQEpbzY3AeIhhaoOKO4E6pHgV+Aq8mtJXE8UrCvfi
	hDiaIpcW7AsenQSdR7tqqEN7Qsx4B2yWK2wMfKNQhk9J5H2/Dovott+pRkDvG0LIE6Tw
	aTi/a8PkuqOpG4DnnbMTzxJC4ot9S02hjUALTRVErDxBZCG2JV+3zGlIXlJmEbTjHTBK
	Q1sAILEQ7kqiIRPhk+errWRwwixVqmWL8sRbEIS3mUi0O/nu9kQK7iV8cgZcAmWzHLLY
	EICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=T/gNF/+WQ4Pn+UuyOMg1wvHnA4fUii7t4Tux8xUmkoc=;
	b=qBDKjF0fH6RrsoBwNIC9hcKx4EoFP9kIj9UtZdFu+hD6NiEd3NLfzNA1I49Um3wkKt
	is3CilLtKU6YhsFnmeCFGXBBwAxwTsV2JvElQOTpjwTxbIi5VFGXJn/Jd1NWYgBHJBcZ
	Kwbp3vIHffUgbmL6vOXgiFrR1fnLmKY9gSx4ThJetqL0F7hwdmKOBLdzZM99Gr5cYvva
	SYVeBqDcsTaYdD2veiydQveY+/Wrr221CNb8qfjUnCvyhCZ3LeTfn4gzTKVedHPb5VVt
	woCdQP7NQ4qPz7Krlz9FiFkUyGm+vBm2HC+tVxnsGwotrR1hvML5kMbvErunCt3y4nIX
	hrPg==
X-Gm-Message-State: APjAAAU/3FzwhjuxQQzt1tYB9lzhpjZKZ+AtL27G54DUeuwQmE0B0GVw
	7SMwxOB6DrqFK3e2rh7fGLrY0rBoElc=
X-Google-Smtp-Source: APXvYqy8+fS70NI1GkAOCZBtCYqeXlqWSSt1gl0TgvzZGXd1GubkQOgY3SCjreK5VnBXdjJr+ndNWA==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr71871984pgt.334.1558298255333; 
	Sun, 19 May 2019 13:37:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:17 -0700
Message-Id: <20190519203726.20729-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 05/74] linux-user: Split out readlink,
 readlinkat
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

Split out a shared implementation for both of these;
unify the best parts of /proc/self/exe checking.

Remove the temporary forward declaration for is_proc_self.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/strace.c           | 29 ------------------
 linux-user/syscall-file.inc.c | 45 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 55 -----------------------------------
 linux-user/strace.list        |  6 ----
 5 files changed, 51 insertions(+), 90 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 1f3a9c47ab..d1a6c6fa3c 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -20,3 +20,9 @@
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+#ifdef TARGET_NR_readlink
+SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
+#ifdef TARGET_NR_readlinkat
+SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 24ef14b5e6..2f1c7e537f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2256,35 +2256,6 @@ print_fstatat64(const struct syscallname *name,
 #define print_newfstatat    print_fstatat64
 #endif
 
-#ifdef TARGET_NR_readlink
-static void
-print_readlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_pointer(arg1, 0);
-    print_raw_param("%u", arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_readlinkat
-static void
-print_readlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_pointer(arg2, 0);
-    print_raw_param("%u", arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rename
 static void
 print_rename(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 30f8e35cdd..4ef0be2c6f 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -314,3 +314,48 @@ SYSCALL_IMPL(openat)
 {
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
+
+static abi_long do_readlinkat(int dirfd, abi_ulong target_path,
+                              abi_ulong target_buf, abi_ulong bufsiz)
+{
+    char *p = lock_user_string(target_path);
+    void *buf = lock_user(VERIFY_WRITE, target_buf, bufsiz, 0);
+    abi_long ret;
+
+    if (!p || !buf) {
+        ret = -TARGET_EFAULT;
+    } else if (!bufsiz) {
+        /* Short circuit this for the magic exe check. */
+        ret = -TARGET_EINVAL;
+    } else if (is_proc_myself((const char *)p, "exe")) {
+        char real[PATH_MAX];
+        char *temp = realpath(exec_path, real);
+
+        if (temp == NULL) {
+            ret = -host_to_target_errno(errno);
+        } else {
+            ret = MIN(strlen(real), bufsiz);
+            /* We cannot NUL terminate the string. */
+            memcpy(buf, real, ret);
+        }
+    } else {
+        ret = get_errno(readlinkat(dirfd, path(p), buf, bufsiz));
+    }
+    unlock_user(buf, target_buf, ret);
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_readlink
+SYSCALL_IMPL(readlink)
+{
+    return do_readlinkat(AT_FDCWD, arg1, arg2, arg3);
+}
+#endif
+
+#ifdef TARGET_NR_readlinkat
+SYSCALL_IMPL(readlinkat)
+{
+    return do_readlinkat(arg1, arg2, arg3, arg4);
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fe52ac15c2..53fb211f16 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6633,8 +6633,6 @@ int host_to_target_waitstatus(int status)
     return status;
 }
 
-static int is_proc_myself(const char *filename, const char *entry);
-
 #define TIMER_MAGIC 0x0caf0000
 #define TIMER_MAGIC_MASK 0xffff0000
 
@@ -8108,59 +8106,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_readlink
-    case TARGET_NR_readlink:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (!arg3) {
-                /* Short circuit this for the magic exe check. */
-                ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                /* Return value is # of bytes that we wrote to the buffer. */
-                if (temp == NULL) {
-                    ret = get_errno(-1);
-                } else {
-                    /* Don't worry about sign mismatch as earlier mapping
-                     * logic would have thrown a bad address error. */
-                    ret = MIN(strlen(real), arg3);
-                    /* We cannot NUL terminate the string. */
-                    memcpy(p2, real, ret);
-                }
-            } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
-            }
-            unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_readlinkat)
-    case TARGET_NR_readlinkat:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                ret = temp == NULL ? get_errno(-1) : strlen(real) ;
-                snprintf((char *)p2, arg4, "%s", real);
-            } else {
-                ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
-            }
-            unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 2c7a595e19..53cee3db92 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1079,12 +1079,6 @@
 #ifdef TARGET_NR_readdir
 { TARGET_NR_readdir, "readdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_readlink
-{ TARGET_NR_readlink, "readlink" , NULL, print_readlink, NULL },
-#endif
-#ifdef TARGET_NR_readlinkat
-{ TARGET_NR_readlinkat, "readlinkat" , NULL, print_readlinkat, NULL },
-#endif
 #ifdef TARGET_NR_readv
 { TARGET_NR_readv, "readv" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


