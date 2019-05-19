Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD7C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F4420657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzueuHJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F4420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSzH-0000R2-VK
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:04:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZf-0003fD-Is
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZd-0004Pw-IC
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:27 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZd-0004Kj-7H
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id g9so5709210plm.6
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MZ4xTXHoRnqxjbKzyUEkFjQQbSbYuTgwnyU38LEY1MU=;
	b=jzueuHJih53MA65QrNMqcmuShPK8bfIscnDjn98SrMNKFRBaG66E6Wv8nseh/UiCH0
	Rc4r985n1zXgVQN7RER0C+GI6nU74Ol7UFOXvqkGkEHXx8aylIljtPGYt1ecc2HgAV6I
	XnBHTnln+h9kPUsQbPtwxI3KknAAIF141R0mizaBlCwRSqQOqTjn/TZlhspqEQ+G7qCP
	p1LfBJfNIf67dk0kNz84mwpWUSxW4+CEK/6BugaRzBxozECjHDN6jRs3o7NBm1LoHfCK
	EsZp6KkusZBriWnFYo5vV8HR+H5+AMkGDT1BRSsPzVAdcaUytGM+jKKpY1lCrw11Btbq
	bfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MZ4xTXHoRnqxjbKzyUEkFjQQbSbYuTgwnyU38LEY1MU=;
	b=i6PYpOI5AFVYm5BT7yTmr6V92O3uLhVyw8ufyDK4RwJipEjEFtc20eOOkP62PIRXYL
	3rjy7QHKfSNhxqkBkYbrZ093qixasP3vyID2cuEWvoPIOOyLpFOTf7vL3lELeCXYxo/f
	hbHQ+xW9xj9TQqeu57cCwtur7Ne+jh0+vATjL7/ihGlsZbXMsMW4M1UW1LIEtUgsGY/9
	6zMV1bFtnnje02xKk5RqRXVeqnEDA/Hm/VMak7JlGTuAqVpizyPlmoZO1k0Xw9zyjvAB
	Hmgy+PchgkS5nS+5fTDK2wKH7naVgRQM6rr1BVxTIvqwhq8l6ShA3OwDqNA9IMbfVyY0
	iWuA==
X-Gm-Message-State: APjAAAUZ1w3vNB5y4vTWvzUbm7uM+gZLI2Vq/wJ+mT8cR37l3W9eTIBF
	S+jTqTHXNK4nrHn08VmWDQ8mTkE+deM=
X-Google-Smtp-Source: APXvYqw8zkeTTVsa6JRfBrdWR6x5trbPLxBaxOV/a3jRn652ikneWC6CBBNPz8HjdNxICRPdGEw5hw==
X-Received: by 2002:a17:902:201:: with SMTP id
	1mr26872192plc.263.1558298300365; 
	Sun, 19 May 2019 13:38:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:52 -0700
Message-Id: <20190519203726.20729-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 40/74] linux-user: Split out rename, renameat,
 renameat2
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

Note that renameat2 is universally available for guests.
Merge sys_renameat2 into the new do_renameat2 helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  8 +++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 39 ++++++---------------
 linux-user/syscall-file.inc.c | 45 ++++++++++++++++++++++++
 linux-user/syscall.c          | 64 -----------------------------------
 linux-user/strace.list        |  9 -----
 6 files changed, 65 insertions(+), 101 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index c672b5ad99..0ed01aa100 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -142,6 +142,14 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+#ifdef TARGET_NR_rename
+SYSCALL_DEF(rename, ARG_STR, ARG_STR);
+#endif
+#ifdef TARGET_NR_renameat
+SYSCALL_DEF(renameat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR);
+#endif
+SYSCALL_DEF(renameat2, ARG_ATDIRFD, ARG_STR,
+            ARG_ATDIRFD, ARG_STR, ARG_RENAMEFLAG);
 SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_rmdir
 SYSCALL_DEF(rmdir, ARG_STR);
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 642fb6dccb..7b197840f5 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -69,6 +69,7 @@ typedef enum {
     ARG_MODEFLAG,
     ARG_MOUNTFLAG,
     ARG_OPENFLAG,
+    ARG_RENAMEFLAG,
     ARG_UMOUNTFLAG,
     ARG_UNLINKATFLAG,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 01a5c210fa..8f871b30ae 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4,6 +4,7 @@
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
+#include <linux/fs.h>
 #include <sched.h>
 #include "qemu.h"
 #include "syscall.h"
@@ -741,6 +742,13 @@ static struct flags const mount_flags[] = {
     FLAG_END,
 };
 
+static struct flags const renameat2_flags[] = {
+    FLAG_GENERIC(RENAME_EXCHANGE),
+    FLAG_GENERIC(RENAME_NOREPLACE),
+    FLAG_GENERIC(RENAME_WHITEOUT),
+    FLAG_END,
+};
+
 static struct flags const umount2_flags[] = {
 #ifdef MNT_FORCE
     FLAG_GENERIC(MNT_FORCE),
@@ -1899,34 +1907,6 @@ print_fstatat64(const struct syscallname *name,
 #define print_newfstatat    print_fstatat64
 #endif
 
-#ifdef TARGET_NR_rename
-static void
-print_rename(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_string(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_renameat
-static void
-print_renameat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_at_dirfd(arg2, 0);
-    print_string(arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_statfs
 static void
 print_statfs(const struct syscallname *name,
@@ -2212,6 +2192,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
+        case ARG_RENAMEFLAG:
+            len = add_flags(b, rest, renameat2_flags, arg, false);
+            break;
         case ARG_UMOUNTFLAG:
             len = add_flags(b, rest, umount2_flags, arg, false);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 9f3cf7221a..18553f055e 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -873,6 +873,51 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+static abi_long do_renameat2(int oldfd, abi_ulong target_oldpath,
+                             int newfd, abi_ulong target_newpath,
+                             unsigned int flags)
+{
+    char *p_old = lock_user_string(target_oldpath);
+    char *p_new = lock_user_string(target_newpath);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p_old && p_new) {
+        if (flags == 0) {
+            ret = renameat(oldfd, p_old, newfd, p_new);
+        } else {
+#ifdef __NR_renameat2
+            ret = syscall(__NR_renameat2, oldfd, p_old, newfd, p_new, flags);
+#else
+            errno = ENOSYS;
+            ret = -1;
+#endif
+        }
+        ret = get_errno(ret);
+    }
+    unlock_user(p_old, target_oldpath, 0);
+    unlock_user(p_new, target_newpath, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_rename
+SYSCALL_IMPL(rename)
+{
+    return do_renameat2(AT_FDCWD, arg1, AT_FDCWD, arg2, 0);
+}
+#endif
+
+#ifdef TARGET_NR_renameat
+SYSCALL_IMPL(renameat)
+{
+    return do_renameat2(arg1, arg2, arg3, arg4, 0);
+}
+#endif
+
+SYSCALL_IMPL(renameat2)
+{
+    return do_renameat2(arg1, arg2, arg3, arg4, arg5);
+}
+
 SYSCALL_IMPL(sync)
 {
     sync();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3fe770890c..d8f6da63cc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -331,24 +331,6 @@ static int sys_utimensat(int dirfd, const char *pathname,
 #endif
 #endif /* TARGET_NR_utimensat */
 
-#ifdef TARGET_NR_renameat2
-#if defined(__NR_renameat2)
-#define __NR_sys_renameat2 __NR_renameat2
-_syscall5(int, sys_renameat2, int, oldfd, const char *, old, int, newfd,
-          const char *, new, unsigned int, flags)
-#else
-static int sys_renameat2(int oldfd, const char *old,
-                         int newfd, const char *new, int flags)
-{
-    if (flags == 0) {
-        return renameat(oldfd, old, newfd, new);
-    }
-    errno = ENOSYS;
-    return -1;
-}
-#endif
-#endif /* TARGET_NR_renameat2 */
-
 #ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
 
@@ -5391,52 +5373,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_rename
-    case TARGET_NR_rename:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(rename(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_renameat)
-    case TARGET_NR_renameat:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(renameat(arg1, p, arg3, p2));
-            unlock_user(p2, arg4, 0);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_renameat2)
-    case TARGET_NR_renameat2:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else {
-                ret = get_errno(sys_renameat2(arg1, p, arg3, p2, arg5));
-            }
-            unlock_user(p2, arg4, 0);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 07e5f7c518..3b002a0500 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -944,15 +944,6 @@
 #ifdef TARGET_NR_removexattr
 { TARGET_NR_removexattr, "removexattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rename
-{ TARGET_NR_rename, "rename" , NULL, print_rename, NULL },
-#endif
-#ifdef TARGET_NR_renameat
-{ TARGET_NR_renameat, "renameat" , NULL, print_renameat, NULL },
-#endif
-#ifdef TARGET_NR_renameat2
-{ TARGET_NR_renameat2, "renameat2" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_request_key
 { TARGET_NR_request_key, "request_key" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


