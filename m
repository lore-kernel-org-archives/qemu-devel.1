Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D2C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263AB20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kul8EKJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263AB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSShf-00020p-8g
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:46:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYw-0002nl-Ci
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYv-0003Wm-4f
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYu-0003Vo-Ug
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id h17so5751680pgv.0
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=v+DSPWFfKETKW6djLG4dV30pA06tpKN/mDvUPl9xg1M=;
	b=kul8EKJ+Q4XjOZ96gaPQl3ei1QXKW4h4xkEUQ6XK080ElloUc1iEFs6lO9vKbFR9XY
	7yItQEu89XB+RVe1GfGBGgx8UCwOw02bedJvIQWxH5IgnRZYvAtsHdVdQ72LooB5RrBc
	hh4wqx6aRaaoEQtdJCY+ikK8aMH5LKP1PQT764rE9KUxkk+wpvSH4xFwHJhbu67LKWLg
	9Q3APNNKUkiDWwaW65EAa+QJ2sHwD/LK4UQM+yZwYBdQwTLZ8Hnx+sHu0YxXID+X6OQH
	F+i5qwjcdFRP6k+iuxxvvRgKUqWDUtbWSZEew2Zkk/rG2WpvE3jgcLSrqhGTgmHcQclh
	ORBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=v+DSPWFfKETKW6djLG4dV30pA06tpKN/mDvUPl9xg1M=;
	b=lDEuC6ATvINchhGeLD35ckGs9uuZ4F1GQYQ5D/RTIe0mS1Fr79kXalqn8ujlh4rpps
	SlV/DsQ92iqMNskQoxeXGOfcW56HYbdEicnzViPOls3+uQkobveNWmUmu8fu6gOId0vA
	GZotglboVrWPWCswmOQ3IWIyPYzNnAhgdB7f2k6ovmOrxn12OmvQOTTJyGu+mTipVV1N
	u79UNwndAReKCnZLPhvT1beWic389wXxVGO0Mp87IENXxykkQ/41wFKI7JnB2syQgPQL
	9fD3zIidm0nEhNC5cKzL2XXCIdfdPtk/q02M+iffRyjHDJv071kI5TiLzLSjhrD2muwh
	vPIQ==
X-Gm-Message-State: APjAAAWNBb9ya+pw8T4zCcqBQWU6Iyc7FNhRSxrccB/hfSEVP8Fp8NBM
	ga5fnCWaYANDRUZ2hDpeib6jUVuk1UQ=
X-Google-Smtp-Source: APXvYqwMA3kqcXRsnECaZ7cBhBGOMLDrpu6VEL+UHy5PpeAOF0u/w+6XXKE0g1Cosiz4qHMWiCq6JQ==
X-Received: by 2002:a65:64da:: with SMTP id t26mr71680641pgv.322.1558298259460;
	Sun, 19 May 2019 13:37:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:19 -0700
Message-Id: <20190519203726.20729-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 07/74] linux-user: Split out read, write
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
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-file.inc.c | 58 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 34 --------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 797426ae6f..b031de1375 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,9 +21,11 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index d9b09c2cd2..e6adcc351c 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -323,6 +323,32 @@ SYSCALL_IMPL(openat)
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
 
+SYSCALL_IMPL(read)
+{
+    int fd = arg1;
+    abi_ulong target_p = arg2;
+    abi_ulong size = arg3;
+    void *p;
+    abi_long ret;
+
+    if (target_p == 0 && size == 0) {
+        return get_errno(safe_read(fd, NULL, 0));
+    }
+    p = lock_user(VERIFY_WRITE, target_p, size, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(safe_read(fd, p, size));
+    if (!is_error(ret)) {
+        TargetFdDataFunc trans = fd_trans_host_to_target_data(fd);
+        if (trans) {
+            ret = trans(p, ret);
+        }
+    }
+    unlock_user(p, target_p, ret);
+    return ret;
+}
+
 static abi_long do_readlinkat(int dirfd, abi_ulong target_path,
                               abi_ulong target_buf, abi_ulong bufsiz)
 {
@@ -367,3 +393,35 @@ SYSCALL_IMPL(readlinkat)
     return do_readlinkat(arg1, arg2, arg3, arg4);
 }
 #endif
+
+SYSCALL_IMPL(write)
+{
+    int fd = arg1;
+    abi_ulong target_p = arg2;
+    abi_ulong size = arg3;
+    TargetFdDataFunc trans;
+    abi_long ret;
+    void *p;
+
+    if (target_p == 0 && size == 0) {
+        return get_errno(safe_write(fd, NULL, 0));
+    }
+    p = lock_user(VERIFY_READ, target_p, size, 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    trans = fd_trans_target_to_host_data(fd);
+    if (trans) {
+        void *copy = g_malloc(size);
+        memcpy(copy, p, size);
+        ret = trans(copy, size);
+        if (ret >= 0) {
+            ret = get_errno(safe_write(fd, copy, ret));
+        }
+        g_free(copy);
+    } else {
+        ret = get_errno(safe_write(fd, p, size));
+    }
+    unlock_user(p, target_p, 0);
+    return ret;
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d2b1bb76c4..de80ddb330 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6782,40 +6782,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
-    case TARGET_NR_read:
-        if (arg2 == 0 && arg3 == 0) {
-            return get_errno(safe_read(arg1, 0, 0));
-        } else {
-            if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-                return -TARGET_EFAULT;
-            ret = get_errno(safe_read(arg1, p, arg3));
-            if (ret >= 0 &&
-                fd_trans_host_to_target_data(arg1)) {
-                ret = fd_trans_host_to_target_data(arg1)(p, ret);
-            }
-            unlock_user(p, arg2, ret);
-        }
-        return ret;
-    case TARGET_NR_write:
-        if (arg2 == 0 && arg3 == 0) {
-            return get_errno(safe_write(arg1, 0, 0));
-        }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        if (fd_trans_target_to_host_data(arg1)) {
-            void *copy = g_malloc(arg3);
-            memcpy(copy, p, arg3);
-            ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
-            if (ret >= 0) {
-                ret = get_errno(safe_write(arg1, copy, ret));
-            }
-            g_free(copy);
-        } else {
-            ret = get_errno(safe_write(arg1, p, arg3));
-        }
-        unlock_user(p, arg2, 0);
-        return ret;
-
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 43d3088669..2d6bfec692 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1067,9 +1067,6 @@
 #ifdef TARGET_NR_quotactl
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
 #endif
@@ -1611,9 +1608,6 @@
 #ifdef TARGET_NR_waitpid
 { TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_write
-{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_writev
 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-- 
2.17.1


