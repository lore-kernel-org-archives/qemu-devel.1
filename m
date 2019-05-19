Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6817C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806C320644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pU3oRYKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806C320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTID-0001Ql-NW
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:24:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZg-0003fo-7C
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZd-0004Qa-Ou
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZd-0004Ot-Ha
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id c5so5690839pll.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=i/scOGMWF8bWzvx8tsNwoDLjnfeTL/fRVFk/GWGzfuQ=;
	b=pU3oRYKPv6Id6hInOj/s4iOl45/+lVmFh+PQartwsUjaWX2vuzFP34vb8/uBdLzgku
	73Xbz8VsHqpXchVfaFQ87uX4l1p2DwgkHWKiE/IhVKNlMnj79l3/epXn0WqxBSPczVHx
	2y3hynA6b0U5cv0B4J451Gf2/u4ynkQI4w5+yCm0uAIRK6JgWum8QnMbyhtJGh0w8/+h
	G0ZMAemoCJCZw2egRWO8jUWTnNIO5su9YcK+tFJUndAYRhUqqzne0il1Afh6UZOj9F0f
	DWXArxVIYKTaHDO6eeXCEkQlQ+12J2WgyGQwogWmOJBOVYHxbR91i/Mwh9afzGkfZODH
	G2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=i/scOGMWF8bWzvx8tsNwoDLjnfeTL/fRVFk/GWGzfuQ=;
	b=W8YB98bG2U6dE6uP1I5IBFGp1a8HguFboP0owmj4dcT2W371vqg8jXqx85PrRGWRAy
	5B4AoS7FhtMwws4GnyvtqphF/Cy1NZZUDfxs8IaBUaPKI3qtCLV3Fb7qB+gNo5BDm1FL
	/cZzl6DZuXo2LHxMeUJ1B539RbKjJKCmb5NUKF2iL3DEziOhp6nmwMngjn4WzGz21FdE
	DYRhhOOpafzjcAkX4xrxBWQN0wnXZg8brf4iriI8U9/RfLRApxNPeKvHhGez7eUXWEBD
	I73U7Y9cl/74DfvSSyB1/MxGEU4+3EGlixD8vIsywuDkWG9uJE53NTKfq9VwxO5SR2Ue
	E8UQ==
X-Gm-Message-State: APjAAAX640OGdpVf1L063KZp1bi1hUyb2KsHG9uxfhACPXUt7w9tpgNs
	l8i6gZrnnghog/3c0hcYafPVQaWkeGU=
X-Google-Smtp-Source: APXvYqwlMLrSn2/ZVMkVhweUsbldcJJygP2XoefSAR+K/j1+LOLuCPNX9P24r5l13H+5cI9Yj6bPrA==
X-Received: by 2002:a17:902:4203:: with SMTP id
	g3mr53196000pld.288.1558298304197; 
	Sun, 19 May 2019 13:38:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:55 -0700
Message-Id: <20190519203726.20729-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 43/74] linux-user: Split out pipe, pipe2
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

Note that pipe2 is universally available for guests.
Implement host support with syscall when !CONFIG_PIPE2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     | 10 ++++++
 linux-user/syscall-file.inc.c | 51 +++++++++++++++++++++++++++
 linux-user/syscall.c          | 65 +++++++----------------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 74 insertions(+), 58 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 062adddd75..bd3301a72f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -132,6 +132,16 @@ SYSCALL_DEF(open_by_handle_at, ARG_DEC, ARG_PTR, ARG_OPENFLAG);
 #ifdef TARGET_NR_pause
 SYSCALL_DEF(pause);
 #endif
+#ifdef TARGET_NR_pipe
+# if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || \
+     defined(TARGET_SH4) || defined(TARGET_SPARC)
+/* ??? We have no way for strace to display the second returned fd.  */
+SYSCALL_DEF(pipe);
+# else
+SYSCALL_DEF(pipe, ARG_PTR);
+# endif
+#endif
+SYSCALL_DEF(pipe2, ARG_PTR, ARG_OPENFLAG);
 SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 7d97dd1ec1..5bd9eaa002 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -726,6 +726,57 @@ SYSCALL_IMPL(open_by_handle_at)
     return ret;
 }
 
+static abi_long do_pipe(CPUArchState *cpu_env, abi_ulong target_fds,
+                        int target_flags, bool is_pipe2)
+{
+    int host_flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
+    int host_fds[2];
+    abi_long ret;
+
+    ret = pipe2(host_fds, host_flags);
+    if (is_error(ret)) {
+        return get_errno(ret);
+    }
+
+    /*
+     * Several targets have special calling conventions for the original
+     * pipe syscall, but didn't replicate this into the pipe2 syscall.
+     */
+    if (!is_pipe2) {
+#if defined(TARGET_ALPHA)
+        cpu_env->ir[IR_A4] = host_fds[1];
+        return host_fds[0];
+#elif defined(TARGET_MIPS)
+        cpu_env->active_tc.gpr[3] = host_fds[1];
+        return host_fds[0];
+#elif defined(TARGET_SH4)
+        cpu_env->gregs[1] = host_fds[1];
+        return host_fds[0];
+#elif defined(TARGET_SPARC)
+        cpu_env->regwptr[1] = host_fds[1];
+        return host_fds[0];
+#endif
+    }
+
+    if (put_user_s32(host_fds[0], target_fds)
+        || put_user_s32(host_fds[1], target_fds + 4)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
+#ifdef TARGET_NR_pipe
+SYSCALL_IMPL(pipe)
+{
+    return do_pipe(cpu_env, arg1, 0, false);
+}
+#endif
+
+SYSCALL_IMPL(pipe2)
+{
+    return do_pipe(cpu_env, arg1, arg2, true);
+}
+
 /*
  * Both pread64 and pwrite64 merge args into a 64-bit offset,
  * but the input registers and ordering are target specific.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bab9a57ee0..cda1f8a205 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -207,6 +207,9 @@ _syscall0(int, sys_gettid)
 #ifndef __NR_dup3
 #define __NR_dup3  -1
 #endif
+#ifndef __NR_pipe2
+#define __NR_pipe2  -1
+#endif
 #ifndef __NR_syncfs
 #define __NR_syncfs  -1
 #endif
@@ -273,6 +276,16 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
 #ifndef CONFIG_SYNCFS
 _syscall1(int, syncfs, int, fd)
 #endif
+#ifndef CONFIG_PIPE2
+static int pipe2(int *fds, int flags)
+{
+    if (flags) {
+        return syscall(__NR_pipe2, fds, flags);
+    } else {
+        return pipe(fds);
+    }
+}
+#endif
 
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -1124,49 +1137,6 @@ static abi_long do_old_select(abi_ulong arg1)
 #endif
 #endif
 
-static abi_long do_pipe2(int host_pipe[], int flags)
-{
-#ifdef CONFIG_PIPE2
-    return pipe2(host_pipe, flags);
-#else
-    return -ENOSYS;
-#endif
-}
-
-static abi_long do_pipe(void *cpu_env, abi_ulong pipedes,
-                        int flags, int is_pipe2)
-{
-    int host_pipe[2];
-    abi_long ret;
-    ret = flags ? do_pipe2(host_pipe, flags) : pipe(host_pipe);
-
-    if (is_error(ret))
-        return get_errno(ret);
-
-    /* Several targets have special calling conventions for the original
-       pipe syscall, but didn't replicate this into the pipe2 syscall.  */
-    if (!is_pipe2) {
-#if defined(TARGET_ALPHA)
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = host_pipe[1];
-        return host_pipe[0];
-#elif defined(TARGET_MIPS)
-        ((CPUMIPSState*)cpu_env)->active_tc.gpr[3] = host_pipe[1];
-        return host_pipe[0];
-#elif defined(TARGET_SH4)
-        ((CPUSH4State*)cpu_env)->gregs[1] = host_pipe[1];
-        return host_pipe[0];
-#elif defined(TARGET_SPARC)
-        ((CPUSPARCState*)cpu_env)->regwptr[1] = host_pipe[1];
-        return host_pipe[0];
-#endif
-    }
-
-    if (put_user_s32(host_pipe[0], pipedes)
-        || put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0])))
-        return -TARGET_EFAULT;
-    return get_errno(ret);
-}
-
 static inline abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn,
                                               abi_ulong target_addr,
                                               socklen_t len)
@@ -5376,15 +5346,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_pipe
-    case TARGET_NR_pipe:
-        return do_pipe(cpu_env, arg1, 0, 0);
-#endif
-#ifdef TARGET_NR_pipe2
-    case TARGET_NR_pipe2:
-        return do_pipe(cpu_env, arg1,
-                       target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
-#endif
     case TARGET_NR_times:
         {
             struct target_tms *tmsp;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 2f78f4685b..a1c3dd98e0 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -860,9 +860,6 @@
 #ifdef TARGET_NR_personality
 { TARGET_NR_personality, "personality" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pipe
-{ TARGET_NR_pipe, "pipe" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_pivot_root
 { TARGET_NR_pivot_root, "pivot_root" , NULL, NULL, NULL },
 #endif
@@ -1377,9 +1374,6 @@
 #ifdef TARGET_NR_sync_file_range2
 { TARGET_NR_sync_file_range2, "sync_file_range2", NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pipe2
-{ TARGET_NR_pipe2, "pipe2", NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_atomic_cmpxchg_32
 { TARGET_NR_atomic_cmpxchg_32, "atomic_cmpxchg_32", NULL, NULL, NULL },
 #endif
-- 
2.17.1


