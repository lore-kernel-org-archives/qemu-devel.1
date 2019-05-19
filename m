Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE4EC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE9D20657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPZtMxnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE9D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSvw-0005sA-4w
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:01:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZT-0003X3-HG
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZQ-00049X-HK
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:14 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZP-000471-QR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id p1so336479plo.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9Z3useuzztxYfCeDiCfuyQXw+fak2amXB2su9Sfs8mg=;
	b=mPZtMxnCs5H13UhWV/nYpwBKyqzbAKant19NkKg2wWlvfuMcwP0JO88J1xRoHKCvY2
	tPwW38EU9gWuMhioCd4UXG8tkAKYkMAa7W0OwCa0N+ZvP2j9a/6F5HihPR7+1FaLx8JD
	dCnUWGzOywUKHnVXY3zikG0Z44XdaZl6DADVI0eoaW1nsz9gvITMMKP1ATgpY5oEzKkw
	gRRDVxC8iRuirAkeVdE4WENwgLWbFsacL+zeK4nmGz6qFvyDyE5tqoL6U966QZrvWa25
	9ygk7nJgylfEZWKysXG9m1IgQbo1HFFxzOgn3Sabgnoe9Qn7lithEC8jei8uEt6G9O6Y
	vq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9Z3useuzztxYfCeDiCfuyQXw+fak2amXB2su9Sfs8mg=;
	b=QMEB2YICtTkuunfm5fw19Foh3Op+HDdCyRqNwRtmE9L+LJybRDmcL9EA18N0oy2O7N
	B/vB9Ob/TlIXb1bZtIk+AzRPtuKfP5DfjECA43SwVJ5NdfBlmfeVgRwGfHj0gTiLtrXn
	TdMfauTMtTsAaZqhjEOyAmTcu/WY3h4dIxkLD7gj++wKQZAeAT065xStvWHiPmAKIMq2
	5XLNdb3iCzxIDYQ8yo2c+BZ3fejm1iPVnQxe52zDaZKDAgdoxEINXVvi+EjFXXVWti96
	KInMDgEgBqJ7tQ5XoKOrLJRvE0/DS3zMNp+0uxq+O8WLPRat46HWp/sAO/ZX/6iN0eJc
	g/kw==
X-Gm-Message-State: APjAAAXsNRSV77yNW9V89AOfIqiWzBgRQqzdQ2L1Rro7qgMbVN904NrB
	/AkPxjvkyq1S39HqzrghP45YIknsPbY=
X-Google-Smtp-Source: APXvYqyGHZUHuRwszwyfwgoCAJMjBP+VdtaF7ZSBSuVL2kmuVa1lS7vewwO6Mlnvm0uGvi/gYy9Rbw==
X-Received: by 2002:a17:902:e409:: with SMTP id
	ci9mr61761083plb.103.1558298289784; 
	Sun, 19 May 2019 13:38:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:43 -0700
Message-Id: <20190519203726.20729-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 31/74] linux-user: Split out mount
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 21 +++----------
 linux-user/syscall-file.inc.c | 48 ++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 55 -----------------------------------
 linux-user/strace.list        |  3 --
 6 files changed, 54 insertions(+), 75 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index d163bbf409..2b331c6a6d 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -78,6 +78,7 @@ SYSCALL_DEF_FULL(mmap2, .impl = impl_mmap,
                  .arg_type = { ARG_PTR, ARG_DEC, ARG_MMAPPROT,
                                ARG_MMAPFLAG, ARG_DEC, ARG_DEC64 });
 #endif
+SYSCALL_DEF(mount, ARG_STR, ARG_STR, ARG_STR, ARG_MOUNTFLAG, ARG_PTR);
 SYSCALL_DEF(mprotect, ARG_PTR, ARG_DEC, ARG_MMAPPROT);
 SYSCALL_DEF_FULL(mremap, .impl = impl_mremap,
                  .print_ret = print_syscall_ptr_ret,
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index c16c0a3f1e..35dd3e5fa3 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -62,6 +62,7 @@ typedef enum {
     ARG_MMAPFLAG,
     ARG_MMAPPROT,
     ARG_MODEFLAG,
+    ARG_MOUNTFLAG,
     ARG_OPENFLAG,
     ARG_UNLINKATFLAG,
     ARG_LSEEKWHENCE,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index a4d7b397b4..a99ab46b97 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -708,7 +708,7 @@ static struct flags const open_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags mount_flags[] = {
+static struct flags const mount_flags[] = {
 #ifdef MS_BIND
     FLAG_GENERIC(MS_BIND),
 #endif
@@ -2015,22 +2015,6 @@ print_symlinkat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_mount
-static void
-print_mount(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_string(arg1, 0);
-    print_string(arg2, 0);
-    print_flags(mount_flags, arg3, 0);
-    print_pointer(arg4, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_umount
 static void
 print_umount(const struct syscallname *name,
@@ -2315,6 +2299,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_MODEFLAG:
             len = add_flags(b, rest, mode_flags, arg, true);
             break;
+        case ARG_MOUNTFLAG:
+            len = add_flags(b, rest, mount_flags, arg, true);
+            break;
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index e267adec1e..4fc12512c2 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -174,6 +174,54 @@ SYSCALL_IMPL(mknodat)
     return do_mknodat(arg1, arg2, arg3, arg4);
 }
 
+SYSCALL_IMPL(mount)
+{
+    abi_ulong target_src = arg1;
+    abi_ulong target_tgt = arg2;
+    abi_ulong target_fst = arg3;
+    abi_ulong mountflags = arg4;
+    abi_ulong target_data = arg5;
+    char *p_src = NULL, *p_tgt = NULL, *p_fst = NULL, *p_data = NULL;
+    abi_long ret = -TARGET_EFAULT;
+
+    if (target_src) {
+        p_src = lock_user_string(target_src);
+        if (!p_src) {
+            goto exit0;
+        }
+    }
+
+    p_tgt = lock_user_string(target_tgt);
+    if (!p_tgt) {
+        goto exit1;
+    }
+
+    if (target_fst) {
+        p_fst = lock_user_string(target_fst);
+        if (!p_fst) {
+            goto exit2;
+        }
+    }
+
+    /*
+     * FIXME - arg5 should be locked, but it isn't clear how to
+     * do that since it's not guaranteed to be a NULL-terminated
+     * string.
+     */
+    if (target_data) {
+        p_data = g2h(target_data);
+    }
+    ret = get_errno(mount(p_src, p_tgt, p_fst, mountflags, p_data));
+
+    unlock_user(p_fst, target_fst, 0);
+ exit2:
+    unlock_user(p_tgt, target_tgt, 0);
+ exit1:
+    unlock_user(p_src, target_src, 0);
+ exit0:
+    return ret;
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 29ea56deee..c826c65317 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,61 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_mount:
-        {
-            /* need to look at the data field */
-            void *p2, *p3;
-
-            if (arg1) {
-                p = lock_user_string(arg1);
-                if (!p) {
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                p = NULL;
-            }
-
-            p2 = lock_user_string(arg2);
-            if (!p2) {
-                if (arg1) {
-                    unlock_user(p, arg1, 0);
-                }
-                return -TARGET_EFAULT;
-            }
-
-            if (arg3) {
-                p3 = lock_user_string(arg3);
-                if (!p3) {
-                    if (arg1) {
-                        unlock_user(p, arg1, 0);
-                    }
-                    unlock_user(p2, arg2, 0);
-                    return -TARGET_EFAULT;
-                }
-            } else {
-                p3 = NULL;
-            }
-
-            /* FIXME - arg5 should be locked, but it isn't clear how to
-             * do that since it's not guaranteed to be a NULL-terminated
-             * string.
-             */
-            if (!arg5) {
-                ret = mount(p, p2, p3, (unsigned long)arg4, NULL);
-            } else {
-                ret = mount(p, p2, p3, (unsigned long)arg4, g2h(arg5));
-            }
-            ret = get_errno(ret);
-
-            if (arg1) {
-                unlock_user(p, arg1, 0);
-            }
-            unlock_user(p2, arg2, 0);
-            if (arg3) {
-                unlock_user(p3, arg3, 0);
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_umount
     case TARGET_NR_umount:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3e898ea307..9b4024d94f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -497,9 +497,6 @@
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_mount
-{ TARGET_NR_mount, "mount" , NULL, print_mount, NULL },
-#endif
 #ifdef TARGET_NR_move_pages
 { TARGET_NR_move_pages, "move_pages" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


