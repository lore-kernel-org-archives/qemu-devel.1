Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6EC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5034D20657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc7yjcyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5034D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSsp-00030X-GO
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:58:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZG-0003LS-If
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZF-0003vs-0e
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:02 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZE-0003uw-OF
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:00 -0400
Received: by mail-pl1-x643.google.com with SMTP id a5so5687509pls.12
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FtdYKl9zJgpOHr5aJ0qnR6xTcabKx8Fz/s3C+R4+JHc=;
	b=lc7yjcylh2ktAOsBbrksTXSHofdMS8y1fJpErjwgKKALi4DoeDrZFdwiJLtnRwogqq
	uzKXHDiNWlSDk9jmcN4Jbnlmq2TJGB61+m5EkYbqFsrUxBFSqsOr51y+kiJ7hqMmLRmT
	SaiiZuAySvjyr+deD3lpveSxGvx/0e6BXfarRBo6ABOIiIcCDUCBqHE30kwcB3PUgJo7
	zCmrpG1pFr8y8USr19n0hFqanfYdEJgN0LKvTx50QeaZSODE4cN8PWWgKNku2WD3R+zd
	zO/7jYK+qJm8k6HfPTxSAuSYqIYmHaFCKgwstAhMtS1EHkXUppOuuWfcqM9ES2F6lCxi
	cH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FtdYKl9zJgpOHr5aJ0qnR6xTcabKx8Fz/s3C+R4+JHc=;
	b=cqThUV6YuUowWv3ccn2kPvqkPbecRhT/KcGdnopNrsVUUMT/N+oJyp+j4/a1AE26Zh
	0vkmZxZg/EuOdz6/jlL8E21RdZUMXbgtaCwq9Y1QplNF+h5rrjr+ohxIrswhOLcU4Gle
	UKFihEVOj5uyW2DhzEpFw3WmoWqInvh11rlCQ/z7A3KCzLGe7JoxadCkxHpK01aiDWd2
	nQN0Q/lRcoPz18aEYyI3z2sOy65muho79YTQz05uqFxtwdzqKwqY37oXgzbgAW2Oq1Jk
	tBWGvPTGsw6H/YIUzyQs8tnka5EmKahFNIjblnBAJwHOb8jH9hJ9wNy3hCq7AkhUdnjU
	pOvA==
X-Gm-Message-State: APjAAAVFfYxnQufVgbyd/F1AGyBVrDFGYym2lbduK8MqlJVu7PFQdyZ+
	vx8N3lpZV8izEivIz0K77r98DvU2DWE=
X-Google-Smtp-Source: APXvYqzCVhJMTT5Zn3KVouE8P+0XIj4FtYblzR0qSAVFTSsBqGn0j779ornc1e6vDRaBdAfXn3oVhQ==
X-Received: by 2002:a17:902:b941:: with SMTP id
	h1mr13225338pls.289.1558298279505; 
	Sun, 19 May 2019 13:37:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:35 -0700
Message-Id: <20190519203726.20729-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 23/74] linux-user: Split out execve
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
 linux-user/syscall-defs.h     |   1 +
 linux-user/strace.c           |  32 ----------
 linux-user/syscall-proc.inc.c | 110 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          |  97 ------------------------------
 linux-user/strace.list        |   3 -
 5 files changed, 111 insertions(+), 132 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 78d3f600eb..58fef48666 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -25,6 +25,7 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(exit, ARG_DEC);
+SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 9ac0b859da..9d6c765715 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -568,38 +568,6 @@ print_newselect(const struct syscallname *name,
 }
 #endif
 
-static void
-print_execve(const struct syscallname *name,
-             abi_long arg1, abi_long arg2, abi_long arg3,
-             abi_long arg4, abi_long arg5, abi_long arg6)
-{
-    abi_ulong arg_ptr_addr;
-    char *s;
-
-    if (!(s = lock_user_string(arg1)))
-        return;
-    gemu_log("%s(\"%s\",{", name->name, s);
-    unlock_user(s, arg1, 0);
-
-    for (arg_ptr_addr = arg2; ; arg_ptr_addr += sizeof(abi_ulong)) {
-        abi_ulong *arg_ptr, arg_addr;
-
-        arg_ptr = lock_user(VERIFY_READ, arg_ptr_addr, sizeof(abi_ulong), 1);
-        if (!arg_ptr)
-            return;
-    arg_addr = tswapal(*arg_ptr);
-        unlock_user(arg_ptr, arg_ptr_addr, 0);
-        if (!arg_addr)
-            break;
-        if ((s = lock_user_string(arg_addr))) {
-            gemu_log("\"%s\",", s);
-            unlock_user(s, arg_addr, 0);
-        }
-    }
-
-    gemu_log("NULL})");
-}
-
 /*
  * Variants for the return value output function
  */
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index b7304b7a42..66ad768551 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -269,6 +269,116 @@ SYSCALL_IMPL(clone)
     return do_clone(cpu_env, arg1, arg2, arg3, arg4, arg5);
 }
 
+SYSCALL_IMPL(execve)
+{
+    char **argp, **envp;
+    int argc, envc;
+    abi_ulong gp;
+    abi_ulong guest_path = arg1;
+    abi_ulong guest_argp = arg2;
+    abi_ulong guest_envp = arg3;
+    abi_ulong addr;
+    char **q, *p;
+    int total_size = 0;
+    abi_long ret = -TARGET_EFAULT;
+
+    argc = 0;
+    for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            goto execve_nofree;
+        }
+        if (!addr) {
+            break;
+        }
+        argc++;
+    }
+    envc = 0;
+    for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
+        if (get_user_ual(addr, gp)) {
+            goto execve_nofree;
+        }
+        if (!addr) {
+            break;
+        }
+        envc++;
+    }
+
+    argp = g_new0(char *, argc + 1);
+    envp = g_new0(char *, envc + 1);
+
+    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+        char *this_q;
+
+        if (get_user_ual(addr, gp)) {
+            goto execve_free;
+        }
+        if (!addr) {
+            break;
+        }
+        this_q = lock_user_string(addr);
+        if (!this_q) {
+            goto execve_free;
+        }
+        *q = this_q;
+        total_size += strlen(this_q) + 1;
+    }
+
+    for (gp = guest_envp, q = envp; gp; gp += sizeof(abi_ulong), q++) {
+        char *this_q;
+
+        if (get_user_ual(addr, gp)) {
+            goto execve_free;
+        }
+        if (!addr) {
+            break;
+        }
+        this_q = lock_user_string(addr);
+        if (!this_q) {
+            goto execve_free;
+        }
+        *q = this_q;
+        total_size += strlen(this_q) + 1;
+    }
+
+    p = lock_user_string(guest_path);
+    if (!p) {
+        goto execve_free;
+    }
+
+    /*
+     * Although execve() is not an interruptible syscall it is
+     * a special case where we must use the safe_syscall wrapper:
+     * if we allow a signal to happen before we make the host
+     * syscall then we will 'lose' it, because at the point of
+     * execve the process leaves QEMU's control. So we use the
+     * safe syscall wrapper to ensure that we either take the
+     * signal as a guest signal, or else it does not happen
+     * before the execve completes and makes it the other
+     * program's problem.
+     */
+    ret = get_errno(safe_execve(p, argp, envp));
+    unlock_user(p, guest_path, 0);
+
+ execve_free:
+    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+    for (gp = guest_envp, q = envp; *q; gp += sizeof(abi_ulong), q++) {
+        if (get_user_ual(addr, gp) || !addr) {
+            break;
+        }
+        unlock_user(*q, addr, 0);
+    }
+    g_free(argp);
+    g_free(envp);
+
+ execve_nofree:
+    return ret;
+}
+
 SYSCALL_IMPL(exit)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 53e108b614..a00df1162f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5383,103 +5383,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_execve:
-        {
-            char **argp, **envp;
-            int argc, envc;
-            abi_ulong gp;
-            abi_ulong guest_argp;
-            abi_ulong guest_envp;
-            abi_ulong addr;
-            char **q;
-            int total_size = 0;
-
-            argc = 0;
-            guest_argp = arg2;
-            for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
-                if (get_user_ual(addr, gp))
-                    return -TARGET_EFAULT;
-                if (!addr)
-                    break;
-                argc++;
-            }
-            envc = 0;
-            guest_envp = arg3;
-            for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
-                if (get_user_ual(addr, gp))
-                    return -TARGET_EFAULT;
-                if (!addr)
-                    break;
-                envc++;
-            }
-
-            argp = g_new0(char *, argc + 1);
-            envp = g_new0(char *, envc + 1);
-
-            for (gp = guest_argp, q = argp; gp;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp))
-                    goto execve_efault;
-                if (!addr)
-                    break;
-                if (!(*q = lock_user_string(addr)))
-                    goto execve_efault;
-                total_size += strlen(*q) + 1;
-            }
-            *q = NULL;
-
-            for (gp = guest_envp, q = envp; gp;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp))
-                    goto execve_efault;
-                if (!addr)
-                    break;
-                if (!(*q = lock_user_string(addr)))
-                    goto execve_efault;
-                total_size += strlen(*q) + 1;
-            }
-            *q = NULL;
-
-            if (!(p = lock_user_string(arg1)))
-                goto execve_efault;
-            /* Although execve() is not an interruptible syscall it is
-             * a special case where we must use the safe_syscall wrapper:
-             * if we allow a signal to happen before we make the host
-             * syscall then we will 'lose' it, because at the point of
-             * execve the process leaves QEMU's control. So we use the
-             * safe syscall wrapper to ensure that we either take the
-             * signal as a guest signal, or else it does not happen
-             * before the execve completes and makes it the other
-             * program's problem.
-             */
-            ret = get_errno(safe_execve(p, argp, envp));
-            unlock_user(p, arg1, 0);
-
-            goto execve_end;
-
-        execve_efault:
-            ret = -TARGET_EFAULT;
-
-        execve_end:
-            for (gp = guest_argp, q = argp; *q;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp)
-                    || !addr)
-                    break;
-                unlock_user(*q, addr, 0);
-            }
-            for (gp = guest_envp, q = envp; *q;
-                  gp += sizeof(abi_ulong), q++) {
-                if (get_user_ual(addr, gp)
-                    || !addr)
-                    break;
-                unlock_user(*q, addr, 0);
-            }
-
-            g_free(argp);
-            g_free(envp);
-        }
-        return ret;
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f08ddaddac..39e5c5b1aa 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -139,9 +139,6 @@
 #ifdef TARGET_NR_execv
 { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
 #endif
-#ifdef TARGET_NR_execve
-{ TARGET_NR_execve, "execve" , NULL, print_execve, NULL },
-#endif
 #ifdef TARGET_NR_execveat
 { TARGET_NR_execveat, "execveat" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


