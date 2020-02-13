Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD602C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B6520873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THdGCW3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B6520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2565-0003ut-Rr
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j255D-0002Bh-6W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j255B-0000BH-RB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:31 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:32824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j255B-000076-Kr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:29 -0500
Received: by mail-pj1-x1042.google.com with SMTP id m7so2277559pjs.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3RA4GH2ajonQfyTX2FF7Fo2q74LDzhgpTLSFFMfVDM0=;
 b=THdGCW3BNt7EkumthnWSpnaggBv5wTqJePjQFtUbV0FtYNR6Elwo6RmDAszysaDX93
 WZxt67oaz68yYxgCu/DmOwUR3qLrwQwuXBejZD7Fz7Jd0KgRtxo8rOLgJH3dSlvoyYQq
 4kMCGRVoGb7U3CbOTjulcz3d/M/izPUoiprD+3lCjRfPdRf+c5JgKBmYFOabTGYpXpYQ
 rVIy0h07eIUin5tRf/RxBiQEMfvOx9jb0d+hVn1gRFnB6ASyeyPGgt+hQTZKJsaC0YF3
 nvgh13RmH1LFDiqU54VZVgbW/d3+1+8pR+FlukC9/S26o+HJdwOddr3EewtR/vfWQlRk
 v0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3RA4GH2ajonQfyTX2FF7Fo2q74LDzhgpTLSFFMfVDM0=;
 b=LpIfLcNhtMhBXhb4yNvh25ACGWIs57eHXdwEkYhgTW95Jxhsonnv7nyQg/zUhxtavQ
 fgYpuiitKq0kAbow5m35O4hS4U8m75yRrtgqihpOFnBfnL7TvInvmAcwCGXcXHTtg+Yp
 b5VwMMLWNV7k5lyONtm25ioO9WX/UZ9GP8CKFDIquuEQDxuRuxEmiDHN80XBPTS1fFcS
 S3ewYEmGJ8LBI5j3ui6FBDtuIYK1/SH1NOt9oTepul9SdcCPIEzqv8zB7uMcUcAoIUYu
 ECYlZ/csl3VGeSr3DDYgsdETNioNKQIfohK/U+Qv0n+jKUbLYiSC4MvriCpgZMptjvCE
 wFqA==
X-Gm-Message-State: APjAAAWIvY80pDpqcDlIwSZj0sEuhql7qC8rGMdT7jMwC/LtTfms3iOd
 IqLV9qXCDeJ6omyrpCWbk7vEpJRWrqM=
X-Google-Smtp-Source: APXvYqwkxsQgvc7yg6I/O5sR/X0zBZGvTBAQRGCjDSrVYOl77FHeccjroXaStw3fR+3IZMG//koEWw==
X-Received: by 2002:a17:90a:f317:: with SMTP id
 ca23mr2611033pjb.20.1581564148049; 
 Wed, 12 Feb 2020 19:22:28 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm536067pgi.31.2020.02.12.19.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 19:22:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] linux-user/i386: Split out gen_signal
Date: Wed, 12 Feb 2020 19:22:20 -0800
Message-Id: <20200213032223.14643-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
References: <20200213032223.14643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a bit tidier than open-coding the 5 lines necessary
to initialize the target_siginfo_t.  In addition, this zeros
the remaining bytes of the target_siginfo_t, rather than
passing in garbage.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/cpu_loop.c | 93 ++++++++++++++------------------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 024b6f4d58..e217cca5ee 100644
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
2.20.1


