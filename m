Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C680CC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0EE2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPcaOMFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0EE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irCXB-000139-LC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 22:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54245)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3RS8dXgMKChAz0Fw44w1u.s426u2A-tuBu1343w3A.47w@flex--jkz.bounces.google.com>)
 id 1irCTQ-0004sC-TN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3RS8dXgMKChAz0Fw44w1u.s426u2A-tuBu1343w3A.47w@flex--jkz.bounces.google.com>)
 id 1irCTP-0000zf-4X
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:32 -0500
Received: from mail-ua1-x94a.google.com ([2607:f8b0:4864:20::94a]:55931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3RS8dXgMKChAz0Fw44w1u.s426u2A-tuBu1343w3A.47w@flex--jkz.bounces.google.com>)
 id 1irCTO-0000yW-Vy
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:31 -0500
Received: by mail-ua1-x94a.google.com with SMTP id 71so1808977uae.22
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 19:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=q7n2mu/O/iU2pd48BW5jqVfwlCDPfPKtfKm+vp2zkyw=;
 b=sPcaOMFyh+jeV3vpTZonODNTc6X6hyzMdxpou/TVg0UMXsyvGWn7T8rAthNQCtwv8Y
 6qO+I1+Cd8n1vJCCYqfQb7jnVsrhbajWk/hR2VvmCTD2dhQhiVJgzdKv7H7D9hSN1ThW
 rkrhDxBRU4Z51yCqM6z93KUui2dLrKlbSLbbTxFPzYW7Xq5+kjoUBW5vqr58BCtDe51n
 S7TmdtczZA9GL4HdrqDAUi/xyPY8MC/t4wrmO6mQInQ3LO6Q8WaLFhzYTJ6NjeAe0pUG
 K4XYgqpEbgbbcZFZ2Eu6vWNrpQGB6R3fsqLjiZLGP5SP+fPFqgdbOXTmGcwLugOMbO97
 l0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=q7n2mu/O/iU2pd48BW5jqVfwlCDPfPKtfKm+vp2zkyw=;
 b=AqGNzvGm78eRULj2mEKvIgvSkoDVL0w28paEekLdztNR0aKYajYGZ0NY0pXLbBHfr6
 p2RPlXPJ1+LbPYNRzK0ZzAXe8FVJhRb6mHtvPxEhitD5k0ObHp6gZTxDkGUZTzqBgo8b
 6FudZDAkAM4yDmOwhRABOwNNorNOyYSXxpij3eHP3YPzh8jq0KSpT5qmBuAaZQ1rEJ1L
 TJSPSC7XkSqVocM+l3NnUUjYbJKToFHMK7uDMiJol42Qavz5fEKuwpbKujF3P+BUOV9r
 mAbaIrvmorVuyHbtWKBsdyP+AQM1VvJk3qEwc80Uu2cisDetmMxpWhYgffcOKISN9wXF
 DcaQ==
X-Gm-Message-State: APjAAAXZBSpUY/YWPZ/6iWcKi2aYqwlB+67UCRkJx8BZco07Fbnyn3Sv
 Nens+yHqQRqcqyE9rxdfKPMOU/vL9xSAqqebtsu8ClUwvh14QyvpQaz+X3ulfP2kqNX93XUxnxq
 ZWbcousjPXscW5y7pbvNsIxX12Q6OuDqQa5frURzLoGskLqCfbIe0
X-Google-Smtp-Source: APXvYqwrrZL2eaqJ2smYESOxaovHkO0F4c+tuBzSCjA3QlSBDLXgyuXFnyyDGCz8aFcFXfb0uOzLv2w=
X-Received: by 2002:a1f:d583:: with SMTP id m125mr9286012vkg.17.1578970949827; 
 Mon, 13 Jan 2020 19:02:29 -0800 (PST)
Date: Mon, 13 Jan 2020 19:01:38 -0800
In-Reply-To: <20200114030138.260347-1-jkz@google.com>
Message-Id: <20200114030138.260347-5-jkz@google.com>
Mime-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 4/4] bsd-user: Replace gemu_log with qemu_log
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::94a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gemu_log is an old logging mechanism used to implement strace logging in
the bsd-user tree. It logs directly to stderr and cannot easily be
redirected. This change instead causes strace to log via the qemu_log
subsystem which has fine-grained logging control, and a centralized
mechanism for log redirection. bsd-user does not currently implement any
logging redirection options, or log masking options, but this change
brings it more in line with the linux-user tree.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 bsd-user/main.c    | 13 ++-----------
 bsd-user/qemu.h    |  2 --
 bsd-user/strace.c  | 32 +++++++++++++++-----------------
 bsd-user/syscall.c | 31 +++++++++++++++++++------------
 4 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7f4e3cd627..e726b0a7fb 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -55,15 +55,6 @@ enum BSDType bsd_type;
    by remapping the process stack directly at the right place */
 unsigned long x86_stack_size = 512 * 1024;
 
-void gemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-}
-
 #if defined(TARGET_I386)
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
@@ -845,7 +836,7 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "singlestep")) {
             singlestep = 1;
         } else if (!strcmp(r, "strace")) {
-            do_strace = 1;
+            qemu_add_log(LOG_STRACE);
         } else if (!strcmp(r, "trace")) {
             g_free(trace_file);
             trace_file = trace_opt_parse(optarg);
@@ -917,7 +908,7 @@ int main(int argc, char **argv)
     thread_cpu = cpu;
 
     if (getenv("QEMU_STRACE")) {
-        do_strace = 1;
+        qemu_add_log(LOG_STRACE);
     }
 
     target_environ = envlist_to_environ(envlist, NULL);
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 09e8aed9c7..5762e3a6e5 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -152,7 +152,6 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
 abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6);
-void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 extern THREAD CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
@@ -188,7 +187,6 @@ print_openbsd_syscall(int num,
                       abi_long arg1, abi_long arg2, abi_long arg3,
                       abi_long arg4, abi_long arg5, abi_long arg6);
 void print_openbsd_syscall_ret(int num, abi_long ret);
-extern int do_strace;
 
 /* signal.c */
 void process_pending_signals(CPUArchState *cpu_env);
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index fa66fe1ee2..6ee1510555 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -23,8 +23,6 @@
 
 #include "qemu.h"
 
-int do_strace;
-
 /*
  * Utility functions
  */
@@ -36,17 +34,17 @@ static void print_sysctl(const struct syscallname *name, abi_long arg1,
     uint32_t i;
     int32_t *namep;
 
-    gemu_log("%s({ ", name->name);
+    qemu_log("%s({ ", name->name);
     namep = lock_user(VERIFY_READ, arg1, sizeof(int32_t) * arg2, 1);
     if (namep) {
         int32_t *p = namep;
 
         for (i = 0; i < (uint32_t)arg2; i++) {
-            gemu_log("%d ", tswap32(*p++));
+            qemu_log("%d ", tswap32(*p++));
         }
         unlock_user(namep, arg1, 0);
     }
-    gemu_log("}, %u, 0x" TARGET_ABI_FMT_lx ", 0x" TARGET_ABI_FMT_lx ", 0x"
+    qemu_log("}, %u, 0x" TARGET_ABI_FMT_lx ", 0x" TARGET_ABI_FMT_lx ", 0x"
         TARGET_ABI_FMT_lx ", 0x" TARGET_ABI_FMT_lx ")",
         (uint32_t)arg2, arg3, arg4, arg5, arg6);
 }
@@ -62,7 +60,7 @@ static void print_execve(const struct syscallname *name, abi_long arg1,
     if (s == NULL) {
         return;
     }
-    gemu_log("%s(\"%s\",{", name->name, s);
+    qemu_log("%s(\"%s\",{", name->name, s);
     unlock_user(s, arg1, 0);
 
     for (arg_ptr_addr = arg2; ; arg_ptr_addr += sizeof(abi_ulong)) {
@@ -78,11 +76,11 @@ static void print_execve(const struct syscallname *name, abi_long arg1,
             break;
         }
         if ((s = lock_user_string(arg_addr))) {
-            gemu_log("\"%s\",", s);
+            qemu_log("\"%s\",", s);
             unlock_user(s, arg_addr, 0);
         }
     }
-    gemu_log("NULL})");
+    qemu_log("NULL})");
 }
 
 static void print_ioctl(const struct syscallname *name,
@@ -90,7 +88,7 @@ static void print_ioctl(const struct syscallname *name,
         abi_long arg5, abi_long arg6)
 {
     /* Decode the ioctl request */
-    gemu_log("%s(%d, 0x%0lx { IO%s%s GRP:0x%x('%c') CMD:%d LEN:%d }, 0x"
+    qemu_log("%s(%d, 0x%0lx { IO%s%s GRP:0x%x('%c') CMD:%d LEN:%d }, 0x"
             TARGET_ABI_FMT_lx ", ...)",
             name->name,
             (int)arg1,
@@ -111,9 +109,9 @@ static void print_ioctl(const struct syscallname *name,
 static void print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
 {
     if (ret == -1) {
-        gemu_log(" = -1 errno=%d (%s)\n", errno, strerror(errno));
+        qemu_log(" = -1 errno=%d (%s)\n", errno, strerror(errno));
     } else {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
     }
 }
 
@@ -121,7 +119,7 @@ static void print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
 static void
 print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
 }
 #endif
 
@@ -148,7 +146,7 @@ static void print_syscall(int num, const struct syscallname *scnames,
         TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ","
         TARGET_ABI_FMT_ld ")";
 
-    gemu_log("%d ", getpid() );
+    qemu_log("%d ", getpid());
 
     for (i = 0; i < nscnames; i++) {
         if (scnames[i].nr == num) {
@@ -161,13 +159,13 @@ static void print_syscall(int num, const struct syscallname *scnames,
                 if (scnames[i].format != NULL) {
                     format = scnames[i].format;
                 }
-                gemu_log(format, scnames[i].name, arg1, arg2, arg3, arg4, arg5,
+                qemu_log(format, scnames[i].name, arg1, arg2, arg3, arg4, arg5,
                         arg6);
             }
             return;
         }
     }
-    gemu_log("Unknown syscall %d\n", num);
+    qemu_log("Unknown syscall %d\n", num);
 }
 
 static void print_syscall_ret(int num, abi_long ret,
@@ -181,10 +179,10 @@ static void print_syscall_ret(int num, abi_long ret,
                 scnames[i].result(&scnames[i], ret);
             } else {
                 if (ret < 0) {
-                    gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n", -ret,
+                    qemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n", -ret,
                              strerror(-ret));
                 } else {
-                    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
+                    qemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
                 }
             }
             break;
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 0d45b654bb..53635d183e 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -321,12 +321,13 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     void *p;
 
 #ifdef DEBUG
-    gemu_log("freebsd syscall %d\n", num);
+    qemu_log("freebsd syscall %d\n", num);
 #endif
     record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
 
-    if(do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
 
     switch(num) {
     case TARGET_FREEBSD_NR_exit:
@@ -401,10 +402,12 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     }
  fail:
 #ifdef DEBUG
-    gemu_log(" = %ld\n", ret);
+    qemu_log(" = %ld\n", ret);
 #endif
-    if (do_strace)
+
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_freebsd_syscall_ret(num, ret);
+    }
 
     record_syscall_return(cpu, num, ret);
     return ret;
@@ -422,13 +425,14 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
     void *p;
 
 #ifdef DEBUG
-    gemu_log("netbsd syscall %d\n", num);
+    qemu_log("netbsd syscall %d\n", num);
 #endif
 
     record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
 
-    if(do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
 
     switch(num) {
     case TARGET_NETBSD_NR_exit:
@@ -480,10 +484,11 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
     }
  fail:
 #ifdef DEBUG
-    gemu_log(" = %ld\n", ret);
+    qemu_log(" = %ld\n", ret);
 #endif
-    if (do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_netbsd_syscall_ret(num, ret);
+    }
 
     record_syscall_return(cpu, num, ret);
     return ret;
@@ -501,13 +506,14 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
     void *p;
 
 #ifdef DEBUG
-    gemu_log("openbsd syscall %d\n", num);
+    qemu_log("openbsd syscall %d\n", num);
 #endif
 
     record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
 
-    if(do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
 
     switch(num) {
     case TARGET_OPENBSD_NR_exit:
@@ -559,10 +565,11 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
     }
  fail:
 #ifdef DEBUG
-    gemu_log(" = %ld\n", ret);
+    qemu_log(" = %ld\n", ret);
 #endif
-    if (do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_openbsd_syscall_ret(num, ret);
+    }
 
     record_syscall_return(cpu, num, ret);
     return ret;
-- 
2.25.0.rc1.283.g88dfdc4193-goog


