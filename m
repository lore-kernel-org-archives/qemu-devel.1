Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38F9217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVPRj+E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38F9217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAw7-0006kt-3F
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:12:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPAvI-000667-Dk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPAvE-0002pt-QO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:11:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPAvB-0002kT-6C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:11:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id d12so9003650wrm.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=d6TLWS7RtIcv4B4DpCpsrRR4kh8Z/F3NenDWVNK0XWU=;
	b=HVPRj+E7aXRWoEiBO16sTm2O4zv1rnbhXlpyRBiRwr2uKa7p/gtf5l5eCsRwaaMJlC
	K5y0eaQTQE5Q2WAcSSI38EB6g1gweYRoZyE4wVvCWk6D5+EqnMMuNqzxrJsQ/EyyMjUI
	MxcPq/P0abfKde/SohPiGBdHgL4kepNV8ZqoNtVA4QiL+KbHVVaPLCCvP867grMouKKF
	IE2SV/QD4LiifnNfeOLI79H0fNW0pfSFymDaKPJkXqJk7YTLSG8yXjxzSA+PG/z7t7Ik
	Gu3PQHQZrG9K4PvdtbXVd/pmfR7Y2Sc3QULYQ5LY+PM6ugc2/HMhDI8mzdbmKQ1lGcuc
	G6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=d6TLWS7RtIcv4B4DpCpsrRR4kh8Z/F3NenDWVNK0XWU=;
	b=IpfxayUqkfR1OyGUA6HyM0d6H8L7fAM5s7QO1CeDI8PhV+uwOtBLFGNw8vmVeYwlxR
	fRy2NAE5E8V4DQY3rl31tnt9zAVbJQy7yu6lIRVP85DS41enFhGYT3vWe3XSnUXnb+m2
	9M6ubpc756vIw9zJk4wF+SAUbraJamkBMUp7cgPi+jS9Hl/IJEEdzTOTqgtb38biNxvq
	VF2ww3ls7bsLipkmuRf8aSwsEEu03zXNsWvvwcBcNHABG+lNFQaZxCjhVZziePB+tXxO
	Lolm2Jh2hzj75h0pFYnlaHZ7tfGB6iyq3mDSmDs/zaUCE3SIYqSSTlhasyiMbVqXHbwk
	Xaeg==
X-Gm-Message-State: APjAAAWojUSJYZLx61Pobkz3JL4xTNwLEtB5eh/rRcQ7MuQrlk0Br+aY
	knYk6LhWVI5RVl4EHgaj3bYkEA==
X-Google-Smtp-Source: APXvYqyCZ/KaEgicK1xQ+owj0o0qxqpY/37QUE4jeIj0OXrJMJl4OYfx0TBfd/SgfQ0Un4Ia0JIW/g==
X-Received: by 2002:a5d:6249:: with SMTP id m9mr8646952wrv.255.1557515459139; 
	Fri, 10 May 2019 12:10:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n4sm11300720wmb.22.2019.05.10.12.10.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 12:10:57 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 35D331FF87;
	Fri, 10 May 2019 20:10:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Date: Fri, 10 May 2019 20:10:50 +0100
Message-Id: <20190510191051.5973-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [RFC PATCH] target/arm: semihosting docs,
 formatting and return clean-ups
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a clean-up of the semihosting calls after reading ver 2.0 of
the specification. There are a number of small fixes that seemed too
insignificant to split into smaller patches:

  - add reference to the ARM semihosting spec
  - add some additional commentary on return values
  - fixup block comments as per standard
  - audit return values, return 0xdeadbeef for corrupted values
  - fix up leaks from early returns with lock_user_string
  - return bytes not written/read instead of -1
  - add LOG_UNIMP for missing functionality

This is very much a Friday patch. It might be worth splitting up if
coming back for a more concerted clean-up series for semihosting as
the asynchronous gdb calls probably need more attention.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-semi.c | 180 +++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 71 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 4c326fdc2fb..8deaed2807c 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -2,6 +2,7 @@
  *  Arm "Angel" semihosting syscalls
  *
  *  Copyright (c) 2005, 2007 CodeSourcery.
+ *  Copyright (c) 2019 Linaro
  *  Written by Paul Brook.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -15,13 +16,19 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  along with this program; if not, see
+ *  <http://www.gnu.org/licenses/>.
+ *
+ *  ARM Semihosting is documented in:
+ *     Semihosting for AArch32 and AArch64 Release 2.0
+ *     https://static.docs.arm.com/100863/0200/semihosting.pdf
  */
 
 #include "qemu/osdep.h"
 
 #include "cpu.h"
 #include "exec/semihost.h"
+#include "exec/log.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
@@ -241,13 +248,18 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
      put_user_u64(val, args + (n) * 8) :                \
      put_user_u32(val, args + (n) * 4))
 
+/*
+ * Do a semihosting call. Returns the "RETURN REGISTER" which is
+ * documented as corrupted for some calls. In this case we use the
+ * venerable 0xdeadbeef.
+ */
 target_ulong do_arm_semihosting(CPUARMState *env)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
     target_ulong args;
     target_ulong arg0, arg1, arg2, arg3;
-    char * s;
+    char *s;
     int nr;
     uint32_t ret;
     uint32_t len;
@@ -273,9 +285,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(2);
         s = lock_user_string(arg0);
         if (!s) {
-            /* FIXME - should this error code be -TARGET_EFAULT ? */
             return (uint32_t)-1;
         }
+        /* check for invalid open mode */
         if (arg1 >= 12) {
             unlock_user(s, arg0, 0);
             return (uint32_t)-1;
@@ -287,7 +299,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
         if (use_gdb_syscalls()) {
             ret = arm_gdb_syscall(cpu, arm_semi_cb, "open,%s,%x,1a4", arg0,
-                                  (int)arg2+1, gdb_open_modeflags[arg1]);
+                                  (int) arg2 + 1, gdb_open_modeflags[arg1]);
         } else {
             ret = set_swi_errno(ts, open(s, open_modeflags[arg1], 0644));
         }
@@ -301,48 +313,51 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, close(arg0));
         }
     case TARGET_SYS_WRITEC:
-        {
-          char c;
-
-          if (get_user_u8(c, args))
-              /* FIXME - should this error code be -TARGET_EFAULT ? */
-              return (uint32_t)-1;
-          /* Write to debug console.  stderr is near enough.  */
-          if (use_gdb_syscalls()) {
+    {
+        char c;
+        if (!get_user_u8(c, args)) {
+            /* Write to debug console.  stderr is near enough.  */
+            if (use_gdb_syscalls()) {
                 return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1", args);
-          } else {
+            } else {
 #ifdef CONFIG_SOFTMMU
-              Chardev *chardev = semihosting_get_chardev();
-              if (chardev) {
-                  return qemu_chr_write_all(chardev, (uint8_t *) &c, 1);
-              } else
+                Chardev *chardev = semihosting_get_chardev();
+                if (chardev) {
+                    return qemu_chr_write_all(chardev, (uint8_t *) &c, 1);
+                }
 #endif
-              {
-                  return write(STDERR_FILENO, &c, 1);
-              }
-          }
+                return write(STDERR_FILENO, &c, 1);
+            }
+        } else {
+            /* return register is corrupted */
+            return 0xdeadbeef;
         }
+    }
     case TARGET_SYS_WRITE0:
-        if (!(s = lock_user_string(args)))
-            /* FIXME - should this error code be -TARGET_EFAULT ? */
-            return (uint32_t)-1;
-        len = strlen(s);
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
-                                   args, len);
-        } else {
+    {
+        s = lock_user_string(args);
+        if (s) {
+            len = strlen(s);
+            if (use_gdb_syscalls()) {
+                arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
+                                args, len);
+            } else {
 #ifdef CONFIG_SOFTMMU
-            Chardev *chardev = semihosting_get_chardev();
-            if (chardev) {
-                ret = qemu_chr_write_all(chardev, (uint8_t *) s, len);
-            } else
+                Chardev *chardev = semihosting_get_chardev();
+                if (chardev) {
+                    qemu_chr_write_all(chardev, (uint8_t *) s, len);
+                } else
 #endif
-            {
-                ret = write(STDERR_FILENO, s, len);
+                {
+                    /* result ignored */
+                    ret = write(STDERR_FILENO, s, len);
+                }
             }
         }
         unlock_user(s, args, 0);
-        return ret;
+        /* return register is corrupted */
+        return 0xdeadbeef;
+    }
     case TARGET_SYS_WRITE:
         GET_ARG(0);
         GET_ARG(1);
@@ -355,13 +370,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user(VERIFY_READ, arg1, len, 1);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                /* Return bytes not written on error */
+                return len;
             }
             ret = set_swi_errno(ts, write(arg0, s, len));
             unlock_user(s, arg1, 0);
-            if (ret == (uint32_t)-1)
-                return -1;
+            if (ret == (uint32_t)-1) {
+                ret = 0;
+            }
+            /* Return bytes not written */
             return len - ret;
         }
     case TARGET_SYS_READ:
@@ -376,26 +393,33 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user(VERIFY_WRITE, arg1, len, 0);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                /* return bytes not read */
+                return len;
             }
             do {
                 ret = set_swi_errno(ts, read(arg0, s, len));
             } while (ret == -1 && errno == EINTR);
             unlock_user(s, arg1, len);
-            if (ret == (uint32_t)-1)
-                return -1;
+            if (ret == (uint32_t)-1) {
+                ret = 0;
+            }
+            /* Return bytes not read */
             return len - ret;
         }
     case TARGET_SYS_READC:
-       /* XXX: Read from debug console. Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: TARGET_SYS_READC not implemented",
+                      __func__);
         return 0;
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", arg0);
         } else {
-            return isatty(arg0);
+            if (isatty(arg0)) {
+                return 1;
+            } else {
+                return (errno == EBADF ? -1 : 0);
+            }
         }
     case TARGET_SYS_SEEK:
         GET_ARG(0);
@@ -405,8 +429,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                                    arg0, arg1);
         } else {
             ret = set_swi_errno(ts, lseek(arg0, arg1, SEEK_SET));
-            if (ret == (uint32_t)-1)
-              return -1;
+            if (ret == (uint32_t)-1) {
+                return -1;
+            }
             return 0;
         }
     case TARGET_SYS_FLEN:
@@ -417,28 +442,30 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             struct stat buf;
             ret = set_swi_errno(ts, fstat(arg0, &buf));
-            if (ret == (uint32_t)-1)
+            if (ret == (uint32_t)-1) {
                 return -1;
+            }
             return buf.st_size;
         }
     case TARGET_SYS_TMPNAM:
-        /* XXX: Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: TARGET_SYS_TMPNAM not implemented",
+                      __func__);
         return -1;
     case TARGET_SYS_REMOVE:
         GET_ARG(0);
         GET_ARG(1);
         if (use_gdb_syscalls()) {
             ret = arm_gdb_syscall(cpu, arm_semi_cb, "unlink,%s",
-                                  arg0, (int)arg1+1);
+                                  arg0, (int)arg1 + 1);
         } else {
             s = lock_user_string(arg0);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                return -EIO;
             }
-            ret =  set_swi_errno(ts, remove(s));
+            ret = set_swi_errno(ts, remove(s));
             unlock_user(s, arg0, 0);
         }
+        /* 0 on success or host-specific error code */
         return ret;
     case TARGET_SYS_RENAME:
         GET_ARG(0);
@@ -447,20 +474,23 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(3);
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "rename,%s,%s",
-                                   arg0, (int)arg1+1, arg2, (int)arg3+1);
+                                   arg0, (int)arg1 + 1, arg2, (int)arg3 + 1);
         } else {
             char *s2;
             s = lock_user_string(arg0);
             s2 = lock_user_string(arg2);
-            if (!s || !s2)
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                ret = (uint32_t)-1;
-            else
+            if (s && s2) {
                 ret = set_swi_errno(ts, rename(s, s2));
-            if (s2)
+            } else {
+                ret = -EIO;
+            }
+            if (s2) {
                 unlock_user(s2, arg2, 0);
-            if (s)
+            }
+            if (s) {
                 unlock_user(s, arg0, 0);
+            }
+            /* 0 on success or host-specific error code */
             return ret;
         }
     case TARGET_SYS_CLOCK:
@@ -472,7 +502,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(1);
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "system,%s",
-                                   arg0, (int)arg1+1);
+                                   arg0, (int)arg1 + 1);
         } else {
             s = lock_user_string(arg0);
             if (!s) {
@@ -527,14 +557,16 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
             output_size = ts->info->arg_end - ts->info->arg_start;
             if (!output_size) {
-                /* We special-case the "empty command line" case (argc==0).
-                   Just provide the terminating 0. */
+                /*
+                 * We special-case the "empty command line" case (argc==0).
+                 * Just provide the terminating 0.
+                 */
                 output_size = 1;
             }
 #endif
 
             if (output_size > input_size) {
-                 /* Not enough space to store command-line arguments.  */
+                /* Not enough space to store command-line arguments.  */
                 return -1;
             }
 
@@ -588,8 +620,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             GET_ARG(0);
 
 #ifdef CONFIG_USER_ONLY
-            /* Some C libraries assume the heap immediately follows .bss, so
-               allocate it using sbrk.  */
+            /*
+             * Some C libraries assume the heap immediately follows .bss, so
+             * allocate it using sbrk.
+             */
             if (!ts->heap_limit) {
                 abi_ulong ret;
 
@@ -637,7 +671,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
     case TARGET_SYS_EXIT:
         if (is_a64(env)) {
-            /* The A64 version of this call takes a parameter block,
+            /*
+             * The A64 version of this call takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
              */
@@ -650,14 +685,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 ret = 1;
             }
         } else {
-            /* ARM specifies only Stopped_ApplicationExit as normal
-             * exit, everything else is considered an error */
+            /*
+             * ARM specifies only Stopped_ApplicationExit as normal
+             * exit, everything else is considered an error
+             */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
         gdb_exit(env, ret);
         exit(ret);
     case TARGET_SYS_SYNCCACHE:
-        /* Clean the D-cache and invalidate the I-cache for the specified
+        /*
+         * Clean the D-cache and invalidate the I-cache for the specified
          * virtual address range. This is a nop for us since we don't
          * implement caches. This is only present on A64.
          */
-- 
2.20.1


