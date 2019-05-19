Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3BBC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504E020449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DN+SZarK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST6r-0007uW-IW
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:12:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZP-0003Uz-Ps
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZM-00044x-Vb
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZM-00044C-Mh
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:08 -0400
Received: by mail-pl1-x644.google.com with SMTP id y3so5734937plp.0
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Fr+Y83wJgizEP7CnBu6nXSORIZtVsEotOiuWEaOuuHQ=;
	b=DN+SZarK91Y4XHtFwUYdxqzhozTXefEyZ2fINNxGFOWw/Ggjwa4GgCqEt63vBTYfsd
	cqD1+5SXiGEJAng1nBCQ7X7aiu61iXl084tiqNjpXAELKKm24NkMZFMQjPFBE7tHI4vi
	mJWXUknNq5hsFdYuDSbX2RvJbjpgijNogsYGPJRAb1+kys7NgKQjOIOm7BKeW/NnXDAD
	RAuoo4m66u9xSCVpA5TB2mP0Dm17bjFJJ3fdycSTAliwt4PK8kZXXXJvhB7os7MShrll
	1S4mOHAqXJaRSyUzHXgG2cj31JCighBlEvZaOWMd698U1dakntjF2wff7Q/WLv7oY4q1
	fwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Fr+Y83wJgizEP7CnBu6nXSORIZtVsEotOiuWEaOuuHQ=;
	b=ul9NCu0OOKOEt4aMikvoXXmuhFxiNssfurfFybevS+IcHPdlTbDWiWG5MtnDaa/8u5
	fjPjkYqKq+eWKJ6h1cbkI5tckMhMxMO5TRsoLKsjdHbf1IGHhzH12ukHK5r/E5Ni4YGc
	h137jCN/NAG2RkDjRNqpufvTTqv2HndsGAUbjvuojMKekDbR9Bi56QUHmZoxD8hRvJu3
	oCCT4Coc16+i0xQt+qcFu/rUXalrhzU5h2fPp/yZ8bZUEQ5yTMKaBHOtG4NRDLc/fCLU
	AO5XL4dCIKQmUWiJxywMmMydD3TfSXdTYtGJztCkB21GM/uwfpyaFKPH8OPZ+Se2MJBR
	53Cg==
X-Gm-Message-State: APjAAAVu+nRfgBH+jMocVM3e2W7Zgyi/IHXv9MMqdAqOhOGrS7Me659d
	6Q/iqc8p7L7H6Ka06Cr84oFD/2pvh7c=
X-Google-Smtp-Source: APXvYqyuM6aunL+QLvpCCuRO1g140QFq/4dkTkhIrJ5QRKjdu27Hko4ECIV8KwGS+rclZXo+vLoLPQ==
X-Received: by 2002:a17:902:15c5:: with SMTP id
	a5mr72386863plh.39.1558298287474; 
	Sun, 19 May 2019 13:38:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:41 -0700
Message-Id: <20190519203726.20729-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v7 29/74] linux-user: Split out lseek, llseek
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

Canonicalise the target syscall name on llseek (new kernels)
instead of _llseek (old kernels).  Always use host lseek(3)
rather than attempting to use the host llseek(2).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  6 ++++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 39 +++++++++++++++--------------------
 linux-user/syscall-file.inc.c | 36 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 32 ++--------------------------
 linux-user/strace.list        |  6 ------
 6 files changed, 62 insertions(+), 58 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3ddf8aa0e3..3453e7afdf 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -43,6 +43,12 @@ SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 SYSCALL_DEF(link, ARG_STR, ARG_STR);
 #endif
 SYSCALL_DEF(linkat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR, ARG_ATFLAG);
+#ifdef TARGET_NR_lseek
+SYSCALL_DEF(lseek, ARG_DEC, ARG_DEC, ARG_LSEEKWHENCE);
+#endif
+#ifdef TARGET_NR_llseek
+SYSCALL_DEF_ARGS(llseek, ARG_DEC, ARG_DEC, ARG_PTR, ARG_LSEEKWHENCE);
+#endif
 #ifdef TARGET_NR_mknod
 SYSCALL_DEF(mknod, ARG_STR, ARG_MODEFLAG, ARG_HEX);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index bdc4d653c4..c16c0a3f1e 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -64,6 +64,7 @@ typedef enum {
     ARG_MODEFLAG,
     ARG_OPENFLAG,
     ARG_UNLINKATFLAG,
+    ARG_LSEEKWHENCE,
 
     /* These are interpreted as pointers.  */
     ARG_PTR,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4771badeb5..a4d7b397b4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -934,6 +934,20 @@ print_open_flags(abi_long flags, int last)
     gemu_log("%s%s", buf, get_comma(last));
 }
 
+static int add_lseek_whence(char *buf, int size, int whence)
+{
+    switch (whence) {
+    case SEEK_SET:
+        return snprintf(buf, size, "SEEK_SET");
+    case SEEK_CUR:
+        return snprintf(buf, size, "SEEK_CUR");
+    case SEEK_END:
+        return snprintf(buf, size, "SEEK_END");
+    default:
+        return snprintf(buf, size, "%#x", whence);
+    }
+}
+
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
@@ -1297,28 +1311,6 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR__llseek
-static void
-print__llseek(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    const char *whence = "UNKNOWN";
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    print_raw_param("%ld", arg1, 0);
-    print_raw_param("%ld", arg2, 0);
-    print_pointer(arg3, 0);
-    switch(arg4) {
-    case SEEK_SET: whence = "SEEK_SET"; break;
-    case SEEK_CUR: whence = "SEEK_CUR"; break;
-    case SEEK_END: whence = "SEEK_END"; break;
-    }
-    gemu_log("%s",whence);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
@@ -2329,6 +2321,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_UNLINKATFLAG:
             len = add_flags(b, rest, unlinkat_flags, arg, true);
             break;
+        case ARG_LSEEKWHENCE:
+            len = add_lseek_whence(b, rest, arg);
+            break;
         case ARG_PTR:
             len = add_pointer(b, rest, arg);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index fb64d5bd1d..e267adec1e 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -112,6 +112,42 @@ SYSCALL_IMPL(linkat)
     return do_linkat(arg1, arg2, arg3, arg4, arg5);
 }
 
+#ifdef TARGET_NR_lseek
+SYSCALL_IMPL(lseek)
+{
+    return get_errno(lseek(arg1, arg2, arg3));
+}
+#endif
+
+#ifdef TARGET_NR_llseek
+SYSCALL_ARGS(llseek)
+{
+    /* The parts for offset are *always* in big-endian order.  */
+    abi_ulong lo = in[2], hi = in[1];
+    out[1] = (((uint64_t)hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
+    out[2] = in[3];
+    out[3] = in[4];
+    return def;
+}
+
+SYSCALL_IMPL(llseek)
+{
+    int fd = arg1;
+    int64_t offset = arg2;
+    abi_ulong target_res = arg3;
+    int whence = arg4;
+
+    off_t res = lseek(fd, offset, whence);
+
+    if (res == -1) {
+        return get_errno(-1);
+    } else if (put_user_s64(res, target_res)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+#endif
+
 static abi_long do_mknodat(int dirfd, abi_ulong target_path,
                            mode_t mode, dev_t dev)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3c0de73aa4..9eff91d67e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -192,8 +192,8 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #endif
 
 /* Newer kernel ports have llseek() instead of _llseek() */
-#if defined(TARGET_NR_llseek) && !defined(TARGET_NR__llseek)
-#define TARGET_NR__llseek TARGET_NR_llseek
+#if !defined(TARGET_NR_llseek) && defined(TARGET_NR__llseek)
+#define TARGET_NR_llseek TARGET_NR__llseek
 #endif
 
 #define __NR_sys_gettid __NR_gettid
@@ -217,10 +217,6 @@ _syscall3(int, sys_getdents, uint, fd, struct linux_dirent *, dirp, uint, count)
     (defined(TARGET_NR_getdents64) && defined(__NR_getdents64))
 _syscall3(int, sys_getdents64, uint, fd, struct linux_dirent64 *, dirp, uint, count);
 #endif
-#if defined(TARGET_NR__llseek) && defined(__NR_llseek)
-_syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
-          loff_t *, res, uint, wh);
-#endif
 _syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, uinfo)
 _syscall4(int, sys_rt_tgsigqueueinfo, pid_t, pid, pid_t, tid, int, sig,
           siginfo_t *, uinfo)
@@ -5384,10 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_lseek
-    case TARGET_NR_lseek:
-        return get_errno(lseek(arg1, arg2, arg3));
-#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     /* Alpha specific */
     case TARGET_NR_getxpid:
@@ -6886,26 +6878,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(fchdir(arg1));
     case TARGET_NR_personality:
         return get_errno(personality(arg1));
-#ifdef TARGET_NR__llseek /* Not on alpha */
-    case TARGET_NR__llseek:
-        {
-            int64_t res;
-#if !defined(__NR_llseek)
-            res = lseek(arg1, ((uint64_t)arg2 << 32) | (abi_ulong)arg3, arg5);
-            if (res == -1) {
-                ret = get_errno(res);
-            } else {
-                ret = 0;
-            }
-#else
-            ret = get_errno(_llseek(arg1, arg2, arg3, &res, arg5));
-#endif
-            if ((ret == 0) && put_user_s64(res, arg4)) {
-                return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
 #ifdef EMULATE_GETDENTS_WITH_GETDENTS
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 0906aba812..fb37c72a1f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -455,9 +455,6 @@
 #ifdef TARGET_NR_llistxattr
 { TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR__llseek
-{ TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
-#endif
 #ifdef TARGET_NR_lock
 { TARGET_NR_lock, "lock" , NULL, NULL, NULL },
 #endif
@@ -467,9 +464,6 @@
 #ifdef TARGET_NR_lremovexattr
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


