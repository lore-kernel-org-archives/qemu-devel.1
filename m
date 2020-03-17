Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFBC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E98920663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E98920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEZD-00040z-6m
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVC-0004d6-OH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVB-00072G-AI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVB-0006x1-0y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:33 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3sZy-1jMn5Y1qXQ-00zkvc; Tue, 17 Mar 2020 16:51:24 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/37] linux-user/i386: Split out gen_signal
Date: Tue, 17 Mar 2020 16:50:41 +0100
Message-Id: <20200317155116.1227513-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yl9iV5z5k4ilKegLV/oxiSfHKw4x+y1m3eUvIFi6YySUnmMJlzq
 6EK+P0XKhoDu95lX0GqdLWYuGkALFDHbtGxyZ47dsNy5GdGK9v3FrWm5hoZy7475Uibg1RD
 gqTlFIhB/6HSSaYPbB8eAYHo3S5FNlAMVBkbfHMCqa3xbazE9LRqgP8tgg42+qQfrr9nSUj
 +y3hymR5CE++DJ8gnSkXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GB7Mwgs9lI4=:Z1OElvx9QlWZUBspJ8YXeP
 CZ0RxQyiJLWAANPJgVStjVNjsYCurIkiCbNLssdFBNlFVVHSFTJuqj3j/Qg5XqNL+vXk2a9cm
 XOLZNaztAGtxQmzwE6Ca1cIFcK+sP04puFZkLSDVetrlqgfDFY5Bq5Gpz1G0IXX6k603DYGJS
 hl9DMX/7JeeyvjLsanADkdVP4Ge271UgK60mw18JvZaLUqQTVZi4jKBifIKuwWPzygioPMlG0
 MgqVvMdWAiSSdwzBjPmU+zg/M84rEAQyuit9xWHDe1oJJhc1OC3BnZ/pFh43btIyAKmuIZs7B
 hoSKV5vGarRIVc0yaIxKSK18kRSn0oSNPF5wSTHC2KlSCbEN5qXtwHJlBuULRWOOEHLt2z2pW
 Wa8J/1egTGaTMd8DS54wxPFL4OX1YSjVJfpZPGNXRMi2pXlNzpwiOe8puean0NCyVwerLtDNs
 cy9ObWPTUZOTe8KgbMp8pq9FTOZi/67dKHw/bo2LxV8Z5YJaadSda6XGYnMsh47CCHoTW2SNQ
 SiH8yGRb8kXVitOL7kE7amncT2CGFftBnuKttGWyZTP0/Z2P74Wz60Hd0BcNSzVWGkKQ1R9dd
 RSKbih+HaO0Q2DaKQl/MU4A9BRMLNj1yBC0L3C2BtVJTs5pMtXBJ9DM3L0dZlQyYXNkvWEwoc
 4+0rAhov888IcZzUw41HtimXVRj7ttJTqiJR5EpdWOlK/AptmLKccQHSQpqi+qMnPBfgG/pHm
 rvdsmP/0INRDpy4r20xVgnwokSg+CxQPhBuY3yoKoxF847Tt/r8LzMQ/QhUGd4GgINF1VV2mJ
 K1jPNXbjFQ6MhUySMpFGZsE6VE7P8yvErNGCHvqbCJOLnD7IKD+SeigXcHyuUciIhvUBdsH
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is a bit tidier than open-coding the 5 lines necessary
to initialize the target_siginfo_t.  In addition, this zeros
the remaining bytes of the target_siginfo_t, rather than
passing in garbage.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/i386/cpu_loop.c | 93 ++++++++++++++------------------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 024b6f4d588c..e217cca5ee1e 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -81,13 +81,23 @@ static void set_idt(int n, unsigned int dpl)
 }
 #endif
 
+static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
+{
+    target_siginfo_t info = {
+        .si_signo = sig,
+        .si_code = code,
+        ._sifields._sigfault._addr = addr
+    };
+
+    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+}
+
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr;
     abi_ulong pc;
     abi_ulong ret;
-    target_siginfo_t info;
 
     for(;;) {
         cpu_exec_start(cs);
@@ -134,70 +144,45 @@ void cpu_loop(CPUX86State *env)
 #endif
         case EXCP0B_NOSEG:
         case EXCP0C_STACK:
-            info.si_signo = TARGET_SIGBUS;
-            info.si_errno = 0;
-            info.si_code = TARGET_SI_KERNEL;
-            info._sifields._sigfault._addr = 0;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGBUS, TARGET_SI_KERNEL, 0);
             break;
         case EXCP0D_GPF:
             /* XXX: potential problem if ABI32 */
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_fault(env);
-            } else
-#endif
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                info.si_code = TARGET_SI_KERNEL;
-                info._sifields._sigfault._addr = 0;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
             }
+#endif
+            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
             break;
         case EXCP0E_PAGE:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            if (!(env->error_code & 1))
-                info.si_code = TARGET_SEGV_MAPERR;
-            else
-                info.si_code = TARGET_SEGV_ACCERR;
-            info._sifields._sigfault._addr = env->cr[2];
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGSEGV,
+                       (env->error_code & 1 ?
+                        TARGET_SEGV_ACCERR : TARGET_SEGV_MAPERR),
+                       env->cr[2]);
             break;
         case EXCP00_DIVZ:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_trap(env, trapnr);
-            } else
-#endif
-            {
-                /* division by zero */
-                info.si_signo = TARGET_SIGFPE;
-                info.si_errno = 0;
-                info.si_code = TARGET_FPE_INTDIV;
-                info._sifields._sigfault._addr = env->eip;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
             }
+#endif
+            gen_signal(env, TARGET_SIGFPE, TARGET_FPE_INTDIV, env->eip);
             break;
         case EXCP01_DB:
         case EXCP03_INT3:
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_trap(env, trapnr);
-            } else
+                break;
+            }
 #endif
-            {
-                info.si_signo = TARGET_SIGTRAP;
-                info.si_errno = 0;
-                if (trapnr == EXCP01_DB) {
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    info._sifields._sigfault._addr = env->eip;
-                } else {
-                    info.si_code = TARGET_SI_KERNEL;
-                    info._sifields._sigfault._addr = 0;
-                }
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            if (trapnr == EXCP01_DB) {
+                gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->eip);
+            } else {
+                gen_signal(env, TARGET_SIGTRAP, TARGET_SI_KERNEL, 0);
             }
             break;
         case EXCP04_INTO:
@@ -205,31 +190,19 @@ void cpu_loop(CPUX86State *env)
 #ifndef TARGET_X86_64
             if (env->eflags & VM_MASK) {
                 handle_vm86_trap(env, trapnr);
-            } else
-#endif
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                info.si_code = TARGET_SI_KERNEL;
-                info._sifields._sigfault._addr = 0;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
             }
+#endif
+            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
             break;
         case EXCP06_ILLOP:
-            info.si_signo = TARGET_SIGILL;
-            info.si_errno = 0;
-            info.si_code = TARGET_ILL_ILLOPN;
-            info._sifields._sigfault._addr = env->eip;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGILL, TARGET_ILL_ILLOPN, env->eip);
             break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_DEBUG:
-            info.si_signo = TARGET_SIGTRAP;
-            info.si_errno = 0;
-            info.si_code = TARGET_TRAP_BRKPT;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, 0);
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
-- 
2.24.1


