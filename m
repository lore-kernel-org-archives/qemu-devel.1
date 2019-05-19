Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F29120675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDdO0zc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F29120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST4s-0005nL-Dq
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:10:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZc-0003cU-CZ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZZ-0004Kt-92
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZX-0004F6-9f
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:20 -0400
Received: by mail-pl1-x641.google.com with SMTP id a5so5687657pls.12
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=RSrci5Zj8IDwkVKyxa0LFWqGkMUNuHHhltz/gMocb2g=;
	b=jDdO0zc2XOPVrgHNM7q3palvQ30e3PDzRDXcePaLqRdKym7cLd/LjwZG688coSBiDH
	uhPpWTjODsh5mhOWQBcN4VnB+PnRHeE/zGifzcRVu0yIOk5t2DAsX6UNFUtKqWVnBI0e
	1umbfEqqJnQ1FdgLO/wH3NC60ltA6G2HX3yeHsdQoDq3vjgriqgHJIG9DsE5istdSWKg
	KvT2nm0jxrN7+OKsHkN+uzIn6IEivAqeS1imme5WHtTaM18gkB+QUDF/4t6RzP2J814f
	l30i1GJRYTzQPvmOW12bA2y8C9tn953vOADKHtdurdxHBqDE2FSsTn4J0AWKzOagBDu5
	OGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=RSrci5Zj8IDwkVKyxa0LFWqGkMUNuHHhltz/gMocb2g=;
	b=S8qtEUhfE0CyhO+ja31G+a9sHtc1wkgjQaEjae/Gf6WvBXAufMhoj2S6SkuksvfgLz
	j95DNW6ALLXy0M0h8gWI+fnz2ic0zMvT6pkxCEW0W++JSRKFbLnX6i41I9BHnuCdDEz1
	xE+XvpQS0bqEs5fjKjQrDxM3mIUV2M9wTHPMEkUrp02jZowciU+zGIq0U5bkFrd4CQ07
	Jr5rDnhO84Tqmhd8LZhzRBGEfGWTTqqC+YAtJ0iUCLG73c685HTY4BHDGWMRSezOvX2w
	cAMGMxXcRRGo73iBta0R1sO+2FK63EF42Pfo5IFOgmgJJ8SBkGwB3B7ThJHtPK8zapjJ
	yaBQ==
X-Gm-Message-State: APjAAAUSiNeMLCWCnpuHzqdQE5VCEf1m+RLXDzsqASNV60vbKhEcQFgw
	fdPY1jexUkR9aTJhXDI7OgF9tYQpmco=
X-Google-Smtp-Source: APXvYqyg33KigYZdisgsLHMaEcrvljDSGOptpKvJFbcNdKMwErkuChYRydfSBxlLKkBKLJMSJt+77Q==
X-Received: by 2002:a17:902:4e:: with SMTP id 72mr19186217pla.80.1558298295592;
	Sun, 19 May 2019 13:38:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:48 -0700
Message-Id: <20190519203726.20729-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 36/74] linux-user: Split out access,
 faccessat
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

Note that faccessat is unconditionally available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 33 ++++-----------------------------
 linux-user/syscall-file.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  6 ------
 6 files changed, 34 insertions(+), 53 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 2767e335d8..39e3ae3c21 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef TARGET_NR_access
+SYSCALL_DEF(access, ARG_STR, ARG_ACCESSFLAG);
+#endif
 #ifdef TARGET_NR_alarm
 SYSCALL_DEF(alarm, ARG_DEC);
 #endif
@@ -34,6 +37,7 @@ SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+SYSCALL_DEF(faccessat, ARG_ATDIRFD, ARG_STR, ARG_ACCESSFLAG);
 SYSCALL_DEF(fchmod, ARG_DEC, ARG_MODEFLAG);
 SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_futimesat
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 3c936b648a..84a52b2d9a 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -57,6 +57,7 @@ typedef enum {
 
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
+    ARG_ACCESSFLAG,
     ARG_ATFLAG,
     ARG_CLONEFLAG,
     ARG_MMAPFLAG,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3a7a5c30ec..c42abc2f08 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -634,7 +634,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
     gemu_log("\n");
 }
 
-UNUSED static struct flags access_flags[] = {
+static struct flags const access_flags[] = {
     FLAG_GENERIC(F_OK),
     FLAG_GENERIC(R_OK),
     FLAG_GENERIC(W_OK),
@@ -1114,19 +1114,6 @@ print_accept(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_access
-static void
-print_access(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_flags(access_flags, arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_chroot
 static void
 print_chroot(const struct syscallname *name,
@@ -1165,21 +1152,6 @@ print_execv(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_faccessat
-static void
-print_faccessat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_flags(access_flags, arg2, 0);
-    print_flags(at_file_flags, arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_fchownat
 static void
 print_fchownat(const struct syscallname *name,
@@ -2218,6 +2190,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATDIRFD:
             len = add_atdirfd(b, rest, arg);
             break;
+        case ARG_ACCESSFLAG:
+            len = add_flags(b, rest, access_flags, arg, false);
+            break;
         case ARG_ATFLAG:
             len = add_flags(b, rest, at_file_flags, arg, false);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 42e5cd2dc1..5e276d13bc 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -16,6 +16,26 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+static abi_long do_faccessat(int dirfd, abi_ulong target_path, int mode)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(faccessat(dirfd, p, mode, 0));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_access
+SYSCALL_IMPL(access)
+{
+    return do_faccessat(AT_FDCWD, arg1, arg2);
+}
+#endif
+
 SYSCALL_IMPL(chdir)
 {
     abi_ulong target_path = arg1;
@@ -74,6 +94,11 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+SYSCALL_IMPL(faccessat)
+{
+    return do_faccessat(arg1, arg2, arg3);
+}
+
 SYSCALL_IMPL(fchmod)
 {
     return get_errno(fchmod(arg1, arg2));
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f66acbf27c..b5ade974a7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,24 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_access
-    case TARGET_NR_access:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(access(path(p), arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
-    case TARGET_NR_faccessat:
-        if (!(p = lock_user_string(arg2))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(faccessat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_nice /* not on alpha */
     case TARGET_NR_nice:
         return get_errno(nice(arg1));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3f92224b55..80b9220e89 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -9,9 +9,6 @@
 #ifdef TARGET_NR_accept4
 { TARGET_NR_accept4, "accept4" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_access
-{ TARGET_NR_access, "access" , NULL, print_access, NULL },
-#endif
 #ifdef TARGET_NR_acct
 { TARGET_NR_acct, "acct" , NULL, NULL, NULL },
 #endif
@@ -142,9 +139,6 @@
 #ifdef TARGET_NR_exit_group
 { TARGET_NR_exit_group, "exit_group" , "%s(%d)\n", NULL, NULL },
 #endif
-#ifdef TARGET_NR_faccessat
-{ TARGET_NR_faccessat, "faccessat" , NULL, print_faccessat, NULL },
-#endif
 #ifdef TARGET_NR_fadvise64
 { TARGET_NR_fadvise64, "fadvise64" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


