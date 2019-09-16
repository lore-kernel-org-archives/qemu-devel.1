Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBADC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB755206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6NHrntb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB755206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sL4-0003rQ-9m
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnJ-0004Ob-Uf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnH-0006uz-5L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnG-0006uE-IV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id 5so4514809wmg.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JrBf8fxBHvOF8tG3dL8+QUmu7l6sNcvSOAp9ypkMt/s=;
 b=P6NHrntbsaFiirDv0faAxcpSCjv/GPHPWr+QVGUo+ETbfNP39cxRaTDlTNe94IJP+o
 qgVGiLlO0KJ9JagR58m3nyWKoqcFWX8HZxO4c1Q4J12vzg9EIyhAxGZY0gXW7e1ElsW/
 LFSYs53c8rKzn0FUMNlTsMprJfZ+mcVRBGAMRGH9immKFs7fm2oxxY8+EXM1qPLWPjdK
 zuuPqxqm3zWyrchBXqsfif21QoFOD5jAmkB9DBnC09idjkb+4QZlGVf5NPu4X7MnjOr1
 VVHZobM6ra2dnxQY/sCPtkWjpDGl+prnQRLLnSysYsLpllqB1RhWn+PRdHsl0IR1U4PC
 6GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JrBf8fxBHvOF8tG3dL8+QUmu7l6sNcvSOAp9ypkMt/s=;
 b=JtrP3gy3hJ0vgp/P5F2789PQg8DhXoNmlrksR8FULtOBXHHJN6hh6QhGJBlXlVJyOq
 wL2lWclE1Ko+63qgDrN4avATO/iyRrbEv9v8kqmWJlRIrHgvBbyHHgHL8FbpbGH4MAqw
 /wPui2J5jvA1pzrE4bszmlqLJSJ0JnVR6Uc+/59KHv/K63DRTtEI8+kC5RNynWnCGP8V
 2G5S43KLMoAfTtj0vVcDkuiwxuqmtZHRvdQ7e4NGS57dDm9SlVBYof75CfjdSUw5KM2E
 7GtqMfu7Zcbt1TaSdy1Ta8luzuYLV+vy2KAWh8kOXh7VO+NZrNbAp1n4Vj4pDkqZAAE4
 Djlw==
X-Gm-Message-State: APjAAAUi4VyiM9pyGbHbwryFdmJyxKJMz9sprmdjAGGxn4w2nz1Qi77I
 R6vi3KZvtVJBN5ZtfcQXFOooW8y3yKg/Iw==
X-Google-Smtp-Source: APXvYqwm4VQR9MHriuHthUMoHo3m+HOva1UCE/QIzpEdNBB7XNqYt0jJj7JSlPRa4b1PJhGvrU725Q==
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr8226546wmj.25.1568643353344; 
 Mon, 16 Sep 2019 07:15:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:34 +0100
Message-Id: <20190916141544.17540-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 05/15] target/arm/arm-semi: Restrict use of
 TaskState*
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The semihosting code needs accuss to the linux-user only
TaskState pointer so it can set the semihosting errno per-thread
for linux-user mode. At the moment we do this by having some
ifdefs so that we define a 'ts' local in do_arm_semihosting()
which is either a real TaskState * or just a CPUARMState *,
depending on which mode we're compiling for.

This is awkward if we want to refactor do_arm_semihosting()
into other functions which might need to be passed the TaskState.
Restrict usage of the TaskState local by:
 * making set_swi_errno() always take the CPUARMState pointer
   and (for the linux-user version) get TaskState from that
 * creating a new get_swi_errno() which reads the errno
 * having the two semihosting calls which need the TaskState
   for other purposes (SYS_GET_CMDLINE and SYS_HEAPINFO)
   define a variable with scope restricted to just that code

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We use 'CPUARMState *', aka 'env', rather than the other
options of passing the ARMCPU* or the CPUState *, purely
because it means that the later refactoring of each SYS_*
can pass just the CPUARMState * and incidentally avoid
an ugly ifdef caused by the implicit use of env in the
softmmu lock_user().
---
 target/arm/arm-semi.c | 111 ++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index a4741d7e11b..2618588076f 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -213,26 +213,45 @@ static GuestFD *get_guestfd(int guestfd)
     return gf;
 }
 
-#ifdef CONFIG_USER_ONLY
-static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
-{
-    if (code == (uint32_t)-1)
-        ts->swi_errno = errno;
-    return code;
-}
-#else
+/*
+ * The semihosting API has no concept of its errno being thread-safe,
+ * as the API design predates SMP CPUs and was intended as a simple
+ * real-hardware set of debug functionality. For QEMU, we make the
+ * errno be per-thread in linux-user mode; in softmmu it is a simple
+ * global, and we assume that the guest takes care of avoiding any races.
+ */
+#ifndef CONFIG_USER_ONLY
 static target_ulong syscall_err;
 
+#include "exec/softmmu-semi.h"
+#endif
+
 static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
 {
     if (code == (uint32_t)-1) {
+#ifdef CONFIG_USER_ONLY
+        CPUState *cs = env_cpu(env);
+        TaskState *ts = cs->opaque;
+
+        ts->swi_errno = errno;
+#else
         syscall_err = errno;
+#endif
     }
     return code;
 }
 
-#include "exec/softmmu-semi.h"
+static inline uint32_t get_swi_errno(CPUARMState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+    TaskState *ts = cs->opaque;
+
+    return ts->swi_errno;
+#else
+    return syscall_err;
 #endif
+}
 
 static target_ulong arm_semi_syscall_len;
 
@@ -379,12 +398,12 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
     if (is_a64(env)) {                                  \
         if (get_user_u64(arg ## n, args + (n) * 8)) {   \
             errno = EFAULT;                             \
-            return set_swi_errno(ts, -1);               \
+            return set_swi_errno(env, -1);              \
         }                                               \
     } else {                                            \
         if (get_user_u32(arg ## n, args + (n) * 4)) {   \
             errno = EFAULT;                             \
-            return set_swi_errno(ts, -1);               \
+            return set_swi_errno(env, -1);              \
         }                                               \
     }                                                   \
 } while (0)
@@ -413,11 +432,6 @@ target_ulong do_arm_semihosting(CPUARMState *env)
     int nr;
     uint32_t ret;
     uint32_t len;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
-#else
-    CPUARMState *ts = env;
-#endif
     GuestFD *gf;
 
     if (is_a64(env)) {
@@ -440,19 +454,19 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         s = lock_user_string(arg0);
         if (!s) {
             errno = EFAULT;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
         if (arg1 >= 12) {
             unlock_user(s, arg0, 0);
             errno = EINVAL;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         guestfd = alloc_guestfd();
         if (guestfd < 0) {
             unlock_user(s, arg0, 0);
             errno = EMFILE;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (strcmp(s, ":tt") == 0) {
@@ -466,7 +480,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             ret = arm_gdb_syscall(cpu, arm_semi_open_cb, "open,%s,%x,1a4", arg0,
                                   (int)arg2+1, gdb_open_modeflags[arg1]);
         } else {
-            ret = set_swi_errno(ts, open(s, open_modeflags[arg1], 0644));
+            ret = set_swi_errno(env, open(s, open_modeflags[arg1], 0644));
             if (ret == (uint32_t)-1) {
                 dealloc_guestfd(guestfd);
             } else {
@@ -483,13 +497,13 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         gf = get_guestfd(arg0);
         if (!gf) {
             errno = EBADF;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (use_gdb_syscalls()) {
             ret = arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
         } else {
-            ret = set_swi_errno(ts, close(gf->hostfd));
+            ret = set_swi_errno(env, close(gf->hostfd));
         }
         dealloc_guestfd(arg0);
         return ret;
@@ -507,7 +521,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         gf = get_guestfd(arg0);
         if (!gf) {
             errno = EBADF;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (use_gdb_syscalls()) {
@@ -520,7 +534,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 /* Return bytes not written on error */
                 return len;
             }
-            ret = set_swi_errno(ts, write(gf->hostfd, s, len));
+            ret = set_swi_errno(env, write(gf->hostfd, s, len));
             unlock_user(s, arg1, 0);
             if (ret == (uint32_t)-1) {
                 ret = 0;
@@ -537,7 +551,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         gf = get_guestfd(arg0);
         if (!gf) {
             errno = EBADF;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (use_gdb_syscalls()) {
@@ -551,7 +565,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 return len;
             }
             do {
-                ret = set_swi_errno(ts, read(gf->hostfd, s, len));
+                ret = set_swi_errno(env, read(gf->hostfd, s, len));
             } while (ret == -1 && errno == EINTR);
             unlock_user(s, arg1, len);
             if (ret == (uint32_t)-1) {
@@ -569,7 +583,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         gf = get_guestfd(arg0);
         if (!gf) {
             errno = EBADF;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (use_gdb_syscalls()) {
@@ -584,14 +598,14 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         gf = get_guestfd(arg0);
         if (!gf) {
             errno = EBADF;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
                                    gf->hostfd, arg1);
         } else {
-            ret = set_swi_errno(ts, lseek(gf->hostfd, arg1, SEEK_SET));
+            ret = set_swi_errno(env, lseek(gf->hostfd, arg1, SEEK_SET));
             if (ret == (uint32_t)-1)
               return -1;
             return 0;
@@ -602,7 +616,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         gf = get_guestfd(arg0);
         if (!gf) {
             errno = EBADF;
-            return set_swi_errno(ts, -1);
+            return set_swi_errno(env, -1);
         }
 
         if (use_gdb_syscalls()) {
@@ -610,7 +624,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                                    gf->hostfd, arm_flen_buf(cpu));
         } else {
             struct stat buf;
-            ret = set_swi_errno(ts, fstat(gf->hostfd, &buf));
+            ret = set_swi_errno(env, fstat(gf->hostfd, &buf));
             if (ret == (uint32_t)-1)
                 return -1;
             return buf.st_size;
@@ -628,9 +642,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             s = lock_user_string(arg0);
             if (!s) {
                 errno = EFAULT;
-                return set_swi_errno(ts, -1);
+                return set_swi_errno(env, -1);
             }
-            ret =  set_swi_errno(ts, remove(s));
+            ret =  set_swi_errno(env, remove(s));
             unlock_user(s, arg0, 0);
         }
         return ret;
@@ -648,9 +662,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             s2 = lock_user_string(arg2);
             if (!s || !s2) {
                 errno = EFAULT;
-                ret = set_swi_errno(ts, -1);
+                ret = set_swi_errno(env, -1);
             } else {
-                ret = set_swi_errno(ts, rename(s, s2));
+                ret = set_swi_errno(env, rename(s, s2));
             }
             if (s2)
                 unlock_user(s2, arg2, 0);
@@ -661,7 +675,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
     case TARGET_SYS_CLOCK:
         return clock() / (CLOCKS_PER_SEC / 100);
     case TARGET_SYS_TIME:
-        return set_swi_errno(ts, time(NULL));
+        return set_swi_errno(env, time(NULL));
     case TARGET_SYS_SYSTEM:
         GET_ARG(0);
         GET_ARG(1);
@@ -672,18 +686,14 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             s = lock_user_string(arg0);
             if (!s) {
                 errno = EFAULT;
-                return set_swi_errno(ts, -1);
+                return set_swi_errno(env, -1);
             }
-            ret = set_swi_errno(ts, system(s));
+            ret = set_swi_errno(env, system(s));
             unlock_user(s, arg0, 0);
             return ret;
         }
     case TARGET_SYS_ERRNO:
-#ifdef CONFIG_USER_ONLY
-        return ts->swi_errno;
-#else
-        return syscall_err;
-#endif
+        return get_swi_errno(env);
     case TARGET_SYS_GET_CMDLINE:
         {
             /* Build a command-line from the original argv.
@@ -706,6 +716,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             int status = 0;
 #if !defined(CONFIG_USER_ONLY)
             const char *cmdline;
+#else
+            TaskState *ts = cs->opaque;
 #endif
             GET_ARG(0);
             GET_ARG(1);
@@ -733,21 +745,21 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             if (output_size > input_size) {
                 /* Not enough space to store command-line arguments.  */
                 errno = E2BIG;
-                return set_swi_errno(ts, -1);
+                return set_swi_errno(env, -1);
             }
 
             /* Adjust the command-line length.  */
             if (SET_ARG(1, output_size - 1)) {
                 /* Couldn't write back to argument block */
                 errno = EFAULT;
-                return set_swi_errno(ts, -1);
+                return set_swi_errno(env, -1);
             }
 
             /* Lock the buffer on the ARM side.  */
             output_buffer = lock_user(VERIFY_WRITE, arg0, output_size, 0);
             if (!output_buffer) {
                 errno = EFAULT;
-                return set_swi_errno(ts, -1);
+                return set_swi_errno(env, -1);
             }
 
             /* Copy the command-line arguments.  */
@@ -763,7 +775,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             if (copy_from_user(output_buffer, ts->info->arg_start,
                                output_size)) {
                 errno = EFAULT;
-                status = set_swi_errno(ts, -1);
+                status = set_swi_errno(env, -1);
                 goto out;
             }
 
@@ -785,6 +797,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             target_ulong retvals[4];
             target_ulong limit;
             int i;
+#ifdef CONFIG_USER_ONLY
+            TaskState *ts = cs->opaque;
+#endif
 
             GET_ARG(0);
 
@@ -834,7 +849,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 if (fail) {
                     /* Couldn't write back to argument block */
                     errno = EFAULT;
-                    return set_swi_errno(ts, -1);
+                    return set_swi_errno(env, -1);
                 }
             }
             return 0;
-- 
2.20.1


