Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F9EC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1D820657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0uU6tyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1D820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSnu-0007EH-Kp
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:53:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ4-00032X-Ca
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ2-0003gB-JR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZ2-0003fG-4u
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:48 -0400
Received: by mail-pg1-x543.google.com with SMTP id a3so5747808pgb.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oMFlfEqih7Sfj/vQATNw8M06mkjRkntlWcN2dDQKmHc=;
	b=E0uU6tyHCgCKWSZLU5LvFSsaJUIx03ALgXp7QiGMVHAj1BpnCQzXTldbc4Yiwpni0z
	q/C3bhJCcxjojQMNzUitgZP04GZ40WsMTQk0h34YvWmnhxdMUUtEroZK/SwP5yBFjGy4
	jUxItShfEtRrfI85qS7ZW4Ngqn76o+kfCXZh9ovsbaJqrPTskUUZS90j1nyRDMXIpI4L
	/MfWXEQoYguf160JYIqfRFQt3KGKHuBKtBlM+RAPnFaEsmBBmz6LMM5zb1nQf4Y59iqV
	FPOSDJvla8r3dtWjftZcDxKneQx0fjgI+vBQd1shL8+R7sr4T9tv3OYG2VdTvmh6Ou4d
	Txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oMFlfEqih7Sfj/vQATNw8M06mkjRkntlWcN2dDQKmHc=;
	b=aMlO17uN7P0W9RtgCEVff1pD6umIYbjOAcJ91TSGSVkUBQvR1lgkHHYzt725QDcVdY
	qJHSNvmMpLiiftrM6tYIpDxUEyLIvp+B4Nr6V+BRJVrOYkETSHJQv6avJFtwCrdB2Akk
	hh3G1Scoqr+CV2O5z6ShAv4XoMn/DayusRYoMzwl6rGSAYlXwtnndx1nIOVWGx/VBz1x
	VI4TGFUjsuR+DBn/WB/DadDM1OSAnaUHpwnLS/KOsFu0/3FcRMfpmUgUJUFT2Ww3z5Br
	XTKvKqu0ARKePwEDPzVT84JhTrET/wP2ObCPWeCwL3oD18FfqyDWFvT4aO80RR9PT0Zy
	mJ8A==
X-Gm-Message-State: APjAAAXwXfLb8ef7s+FEzGMH0WiV6FAKw/ujgzIGO8Tcrhu6GEhYQGOM
	RoA8fmboFPdV5jNfa1MSQEmojIUJoIM=
X-Google-Smtp-Source: APXvYqyr+e02ira13sLoyJh80aPmo6OJu1Vv+77fb8YISG2tQ4zcWnMMz0g4QUg5k2FrewCVOaI15Q==
X-Received: by 2002:a62:1b85:: with SMTP id
	b127mr47952138pfb.165.1558298265797; 
	Sun, 19 May 2019 13:37:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:24 -0700
Message-Id: <20190519203726.20729-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v7 12/74] linux-user: Split out
 name_to_handle_at, open_by_handle_at
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

All targets have these syscalls, so they need not be ifdefed.
If we provide safe syscalls for the host, we can remove the
configure test for this too.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |   3 +
 linux-user/syscall.h          |   1 +
 linux-user/strace.c           |   5 +-
 linux-user/syscall-file.inc.c |  81 +++++++++++++++++++++++++++
 linux-user/syscall.c          | 102 ++--------------------------------
 configure                     |  20 -------
 linux-user/strace.list        |   3 -
 7 files changed, 93 insertions(+), 122 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index ae89be0e87..1fc89c1b08 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -17,10 +17,13 @@
  */
 
 SYSCALL_DEF(close, ARG_DEC);
+SYSCALL_DEF(name_to_handle_at,
+            ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
 #ifdef TARGET_NR_open
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF(open_by_handle_at, ARG_DEC, ARG_PTR, ARG_OPENFLAG);
 SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 43b5dc0684..83f602f8e7 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -57,6 +57,7 @@ typedef enum {
 
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
+    ARG_ATFLAG,
     ARG_MODEFLAG,
     ARG_OPENFLAG,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2f1c7e537f..e92b2c298e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -780,7 +780,7 @@ UNUSED static struct flags access_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags at_file_flags[] = {
+static struct flags const at_file_flags[] = {
 #ifdef AT_EACCESS
     FLAG_GENERIC(AT_EACCESS),
 #endif
@@ -2693,6 +2693,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATDIRFD:
             len = add_atdirfd(b, rest, arg);
             break;
+        case ARG_ATFLAG:
+            len = add_flags(b, rest, at_file_flags, arg, false);
+            break;
         case ARG_MODEFLAG:
             len = add_flags(b, rest, mode_flags, arg, true);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 61cfe2acb7..dd44d5b804 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -323,6 +323,87 @@ SYSCALL_IMPL(openat)
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
 
+SYSCALL_IMPL(name_to_handle_at)
+{
+    struct file_handle *target_fh;
+    struct file_handle *fh;
+    int mid = 0;
+    abi_long ret;
+    char *name;
+    uint32_t size, total_size;
+
+    if (get_user_s32(size, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    total_size = sizeof(struct file_handle) + size;
+    target_fh = lock_user(VERIFY_WRITE, arg3, total_size, 0);
+    if (!target_fh) {
+        return -TARGET_EFAULT;
+    }
+
+    name = lock_user_string(arg2);
+    if (!name) {
+        unlock_user(target_fh, arg3, 0);
+        return -TARGET_EFAULT;
+    }
+
+    fh = g_malloc0(total_size);
+    fh->handle_bytes = size;
+
+    ret = get_errno(safe_name_to_handle_at(arg1, path(name), fh, &mid, arg5));
+    unlock_user(name, arg2, 0);
+
+    /*
+     * man name_to_handle_at(2):
+     * Other than the use of the handle_bytes field, the caller should treat
+     * the file_handle structure as an opaque data type
+     */
+    if (!is_error(ret)) {
+        memcpy(target_fh, fh, total_size);
+        target_fh->handle_bytes = tswap32(fh->handle_bytes);
+        target_fh->handle_type = tswap32(fh->handle_type);
+        g_free(fh);
+        unlock_user(target_fh, arg3, total_size);
+
+        if (put_user_s32(mid, arg4)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+SYSCALL_IMPL(open_by_handle_at)
+{
+    abi_long mount_fd = arg1;
+    abi_long handle = arg2;
+    int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+    struct file_handle *target_fh;
+    struct file_handle *fh;
+    unsigned int size, total_size;
+    abi_long ret;
+
+    if (get_user_s32(size, handle)) {
+        return -TARGET_EFAULT;
+    }
+    total_size = sizeof(struct file_handle) + size;
+    target_fh = lock_user(VERIFY_READ, handle, total_size, 1);
+    if (!target_fh) {
+        return -TARGET_EFAULT;
+    }
+
+    fh = g_memdup(target_fh, total_size);
+    fh->handle_bytes = size;
+    fh->handle_type = tswap32(target_fh->handle_type);
+
+    ret = get_errno(safe_open_by_handle_at(mount_fd, fh, host_flags));
+
+    g_free(fh);
+    unlock_user(target_fh, handle, total_size);
+
+    fd_trans_unregister(ret);
+    return ret;
+}
+
 /*
  * Both pread64 and pwrite64 merge args into a 64-bit offset,
  * but the input registers and ordering are target specific.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 817c4a7296..c49f8aebd2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -806,6 +806,10 @@ safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
 #endif
+safe_syscall5(int, name_to_handle_at, int, dirfd, const char *, pathname,
+              struct file_handle *, handle, int *, mount_id, int, flags)
+safe_syscall3(int, open_by_handle_at, int, mount_fd,
+              struct file_handle *, handle, int, flags)
 /* We do ioctl like this rather than via safe_syscall3 to preserve the
  * "third argument might be integer or pointer or not present" behaviour of
  * the libc function.
@@ -6479,93 +6483,6 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         return -TARGET_ENOSYS;
     }
 }
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
-                                     abi_long handle, abi_long mount_id,
-                                     abi_long flags)
-{
-    struct file_handle *target_fh;
-    struct file_handle *fh;
-    int mid = 0;
-    abi_long ret;
-    char *name;
-    unsigned int size, total_size;
-
-    if (get_user_s32(size, handle)) {
-        return -TARGET_EFAULT;
-    }
-
-    name = lock_user_string(pathname);
-    if (!name) {
-        return -TARGET_EFAULT;
-    }
-
-    total_size = sizeof(struct file_handle) + size;
-    target_fh = lock_user(VERIFY_WRITE, handle, total_size, 0);
-    if (!target_fh) {
-        unlock_user(name, pathname, 0);
-        return -TARGET_EFAULT;
-    }
-
-    fh = g_malloc0(total_size);
-    fh->handle_bytes = size;
-
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
-    unlock_user(name, pathname, 0);
-
-    /* man name_to_handle_at(2):
-     * Other than the use of the handle_bytes field, the caller should treat
-     * the file_handle structure as an opaque data type
-     */
-
-    memcpy(target_fh, fh, total_size);
-    target_fh->handle_bytes = tswap32(fh->handle_bytes);
-    target_fh->handle_type = tswap32(fh->handle_type);
-    g_free(fh);
-    unlock_user(target_fh, handle, total_size);
-
-    if (put_user_s32(mid, mount_id)) {
-        return -TARGET_EFAULT;
-    }
-
-    return ret;
-
-}
-#endif
-
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-static abi_long do_open_by_handle_at(abi_long mount_fd, abi_long handle,
-                                     abi_long flags)
-{
-    struct file_handle *target_fh;
-    struct file_handle *fh;
-    unsigned int size, total_size;
-    abi_long ret;
-
-    if (get_user_s32(size, handle)) {
-        return -TARGET_EFAULT;
-    }
-
-    total_size = sizeof(struct file_handle) + size;
-    target_fh = lock_user(VERIFY_READ, handle, total_size, 1);
-    if (!target_fh) {
-        return -TARGET_EFAULT;
-    }
-
-    fh = g_memdup(target_fh, total_size);
-    fh->handle_bytes = size;
-    fh->handle_type = tswap32(target_fh->handle_type);
-
-    ret = get_errno(open_by_handle_at(mount_fd, fh,
-                    target_to_host_bitmask(flags, fcntl_flags_tbl)));
-
-    g_free(fh);
-
-    unlock_user(target_fh, handle, total_size);
-
-    return ret;
-}
-#endif
 
 #if defined(TARGET_NR_signalfd) || defined(TARGET_NR_signalfd4)
 
@@ -6761,17 +6678,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_name_to_handle_at:
-        ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
-        return ret;
-#endif
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_open_by_handle_at:
-        ret = do_open_by_handle_at(arg1, arg2, arg3);
-        fd_trans_unregister(ret);
-        return ret;
-#endif
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
diff --git a/configure b/configure
index d2fc346302..6573fcefcb 100755
--- a/configure
+++ b/configure
@@ -5243,22 +5243,6 @@ if test "$debug_stack_usage" = "yes"; then
 fi
 
 
-##########################################
-# check if we have open_by_handle_at
-
-open_by_handle_at=no
-cat > $TMPC << EOF
-#include <fcntl.h>
-#if !defined(AT_EMPTY_PATH)
-# error missing definition
-#else
-int main(void) { struct file_handle fh; return open_by_handle_at(0, &fh, 0); }
-#endif
-EOF
-if compile_prog "" "" ; then
-    open_by_handle_at=yes
-fi
-
 ########################################
 # check if we have linux/magic.h
 
@@ -7012,10 +6996,6 @@ if test "$crypto_afalg" = "yes" ; then
   echo "CONFIG_AF_ALG=y" >> $config_host_mak
 fi
 
-if test "$open_by_handle_at" = "yes" ; then
-  echo "CONFIG_OPEN_BY_HANDLE=y" >> $config_host_mak
-fi
-
 if test "$linux_magic_h" = "yes" ; then
   echo "CONFIG_LINUX_MAGIC_H=y" >> $config_host_mak
 fi
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f326613934..bf239cb9a3 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -635,9 +635,6 @@
 #ifdef TARGET_NR_munmap
 { TARGET_NR_munmap, "munmap" , NULL, print_munmap, NULL },
 #endif
-#ifdef TARGET_NR_name_to_handle_at
-{ TARGET_NR_name_to_handle_at, "name_to_handle_at" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_nanosleep
 { TARGET_NR_nanosleep, "nanosleep" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


