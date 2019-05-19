Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A4C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A6820657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEGzqTQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A6820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSno-0007AW-7Z
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:53:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZA-0003AT-6J
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ8-0003nP-Nr
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:56 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZ8-0003mZ-Gk
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:54 -0400
Received: by mail-pf1-x441.google.com with SMTP id q17so6155886pfq.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TKsC4B9qYWzPZIuweTYnPJXABDEFDxi0xaFzoRYmNLs=;
	b=QEGzqTQgB0lQhcnAdwwRtHKJaLqFPQpn9L/wlIuumvZu9JoVG5Tql9UDF00cHto77b
	mgH4Ps2qOrrfjQo7EdYarpcGJPjugBWAIUvk+lxxxZAz0A8L2/I2pThd1bojPGDmBl+k
	SimJBBrLfAWIsC0kwf1bVB/Awu92Da78pDsZ8u9tebkmq4dyaJch//29c6P7pjOxl1om
	ZNJgLerKNwcHdueonc4cjH7g/chVmJN4KuKjz9GMkL/kF0w5YACrjqAp/plU7b1Lp0K6
	ljS8Xb5rCB0nb+uT9dJZiEw9rjOOouA2Kncw2b9F4v4ldUMSXTKwDFLg/9vf+YH5uAx3
	Lpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TKsC4B9qYWzPZIuweTYnPJXABDEFDxi0xaFzoRYmNLs=;
	b=WUzClJnH++pcbjROB54H4jFOphqrXsYczfXm9jv555+MdtiLobYHJZT3OjqCKmWlkP
	+7bTVI3Xj0rDgvhuuRoU3MdZ7TOx4yoeV1t5K0l2fLV7esgYboIl3RZQEQ/c6pLtaH0h
	rxn5zJg1cSRncrfzrWvEr7kQGZqrbUtiytjXebe5H9ERZUmSRaQkW8TvOz7Brfs0mepk
	RChfwbPbobjc8WVW9qbsizsLaJ+weACQa3K7gxNT4zebW1vlsRggomlt/mhBCGkNoXxW
	wuZ5Lp52obdm3JZWcYyhWGJj/5GXe8xHLgBwwuk2QuyB0yyf0boHiZGPQ389Td/6PTn3
	RZag==
X-Gm-Message-State: APjAAAVZJGYLgtA3DmlahlviUwXyy+rtNa4DoBtfiPGDdTNFxXh9AK/V
	NDgAucl0CdslGbab6qiwLWgo23yPN5Q=
X-Google-Smtp-Source: APXvYqxHdDw/syQVaHDn/5PlfBv8KpdtyaaSKll0vir7oTedUTTWKLdHb0/X5uPPsaoZaJbBrcsExQ==
X-Received: by 2002:a65:6559:: with SMTP id a25mr47361736pgw.33.1558298273296; 
	Sun, 19 May 2019 13:37:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:30 -0700
Message-Id: <20190519203726.20729-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 18/74] linux-user: Split out wait4, waitid,
 waitpid
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

Note that waitid is universally provided and need not be conditional.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  5 ++
 linux-user/syscall-proc.inc.c | 88 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 67 --------------------------
 linux-user/strace.list        |  9 ----
 4 files changed, 93 insertions(+), 76 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 6f6f77927b..a84050a318 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -118,5 +118,10 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 /* Emulate vfork() with fork().  */
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
 #endif
+SYSCALL_DEF(wait4, ARG_DEC, ARG_PTR, ARG_HEX, ARG_PTR);
+SYSCALL_DEF(waitid, ARG_HEX, ARG_DEC, ARG_PTR, ARG_HEX);
+#ifdef TARGET_NR_waitpid
+SYSCALL_DEF(waitpid, ARG_DEC, ARG_PTR, ARG_HEX);
+#endif
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 9eda2b2ca2..7c647f36d7 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -318,3 +318,91 @@ SYSCALL_IMPL(fork)
     return do_clone(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0);
 }
 #endif
+
+/*
+ * Map host to target signal numbers for the wait family of syscalls.
+ * Assume all other status bits are the same.
+ */
+int host_to_target_waitstatus(int status)
+{
+    if (WIFSIGNALED(status)) {
+        return host_to_target_signal(WTERMSIG(status)) | (status & ~0x7f);
+    }
+    if (WIFSTOPPED(status)) {
+        return (host_to_target_signal(WSTOPSIG(status)) << 8)
+               | (status & 0xff);
+    }
+    return status;
+}
+
+SYSCALL_IMPL(wait4)
+{
+    int status;
+    pid_t pid = arg1;
+    abi_ulong status_ptr = arg2;
+    int options = arg3;
+    abi_ulong target_rusage = arg4;
+    struct rusage rusage;
+    struct rusage *rusage_ptr = target_rusage ? &rusage : NULL;
+    abi_long ret;
+
+    ret = get_errno(safe_wait4(pid, &status, options, rusage_ptr));
+    if (!is_error(ret)) {
+        if (status_ptr && ret) {
+            status = host_to_target_waitstatus(status);
+            if (put_user_s32(status, status_ptr)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        if (target_rusage) {
+            abi_long err = host_to_target_rusage(target_rusage, &rusage);
+            if (err) {
+                ret = err;
+            }
+        }
+    }
+    return ret;
+}
+
+SYSCALL_IMPL(waitid)
+{
+    idtype_t idtype = arg1;
+    id_t id = arg2;
+    abi_ulong target_info = arg3;
+    int options = arg4;
+    siginfo_t info, *info_ptr = target_info ? &info : NULL;
+    abi_long ret;
+
+    info.si_pid = 0;
+    ret = get_errno(safe_waitid(idtype, id, info_ptr, options, NULL));
+    if (!is_error(ret) && target_info && info.si_pid != 0) {
+        target_siginfo_t *p = lock_user(VERIFY_WRITE, target_info,
+                                        sizeof(target_siginfo_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &info);
+        unlock_user(p, target_info, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+
+#ifdef TARGET_NR_waitpid
+SYSCALL_IMPL(waitpid)
+{
+    pid_t pid = arg1;
+    abi_ulong target_status = arg2;
+    int options = arg3;
+    int status;
+    abi_long ret;
+
+    ret = get_errno(safe_wait4(pid, &status, options, NULL));
+    if (!is_error(ret)
+        && target_status
+        && ret
+        && put_user_s32(host_to_target_waitstatus(status), target_status)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 26140ebb2f..bdb0d45d9a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5271,20 +5271,6 @@ static abi_long do_signalfd4(int fd, abi_long mask, int flags)
 }
 #endif
 
-/* Map host to target signal numbers for the wait family of syscalls.
-   Assume all other status bits are the same.  */
-int host_to_target_waitstatus(int status)
-{
-    if (WIFSIGNALED(status)) {
-        return host_to_target_signal(WTERMSIG(status)) | (status & ~0x7f);
-    }
-    if (WIFSTOPPED(status)) {
-        return (host_to_target_signal(WSTOPSIG(status)) << 8)
-               | (status & 0xff);
-    }
-    return status;
-}
-
 #define TIMER_MAGIC 0x0caf0000
 #define TIMER_MAGIC_MASK 0xffff0000
 
@@ -5397,32 +5383,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_waitpid
-    case TARGET_NR_waitpid:
-        {
-            int status;
-            ret = get_errno(safe_wait4(arg1, &status, arg3, 0));
-            if (!is_error(ret) && arg2 && ret
-                && put_user_s32(host_to_target_waitstatus(status), arg2))
-                return -TARGET_EFAULT;
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_waitid
-    case TARGET_NR_waitid:
-        {
-            siginfo_t info;
-            info.si_pid = 0;
-            ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
-            if (!is_error(ret) && arg3 && info.si_pid != 0) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_siginfo(p, &info);
-                unlock_user(p, arg3, sizeof(target_siginfo_t));
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_creat /* not on alpha */
     case TARGET_NR_creat:
         if (!(p = lock_user_string(arg1)))
@@ -7022,33 +6982,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
 #endif
-    case TARGET_NR_wait4:
-        {
-            int status;
-            abi_long status_ptr = arg2;
-            struct rusage rusage, *rusage_ptr;
-            abi_ulong target_rusage = arg4;
-            abi_long rusage_err;
-            if (target_rusage)
-                rusage_ptr = &rusage;
-            else
-                rusage_ptr = NULL;
-            ret = get_errno(safe_wait4(arg1, &status, arg3, rusage_ptr));
-            if (!is_error(ret)) {
-                if (status_ptr && ret) {
-                    status = host_to_target_waitstatus(status);
-                    if (put_user_s32(status, status_ptr))
-                        return -TARGET_EFAULT;
-                }
-                if (target_rusage) {
-                    rusage_err = host_to_target_rusage(target_rusage, &rusage);
-                    if (rusage_err) {
-                        ret = rusage_err;
-                    }
-                }
-            }
-        }
-        return ret;
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 76d983a882..759b35458e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1494,15 +1494,6 @@
 #ifdef TARGET_NR_vserver
 { TARGET_NR_vserver, "vserver" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_wait4
-{ TARGET_NR_wait4, "wait4" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_waitid
-{ TARGET_NR_waitid, "waitid" , "%s(%#x,%d,%p,%#x)", NULL, NULL },
-#endif
-#ifdef TARGET_NR_waitpid
-{ TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_utimensat
 { TARGET_NR_utimensat, "utimensat", NULL, print_utimensat, NULL },
 #endif
-- 
2.17.1


