Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C5EC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A129206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW3l2DuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A129206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtXG-0004eh-Ka
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:12:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQN-0007Kj-Ee
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0001Hv-BN
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:51 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:44209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQJ-0001Em-Nx; Sat, 04 May 2019 08:05:47 -0400
Received: by mail-oi1-x230.google.com with SMTP id t184so6328736oie.11;
	Sat, 04 May 2019 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Dst2FGMsCs9IpcjAwFYM6Y8XoVeXqqnJoYTrIPSeVd0=;
	b=JW3l2DuS8al+vh91Gj35Ygr5a5YHO8l5AVOFvhk/tSTNYpnnqfbYIfnMXv2eaPe0vK
	uCw+5cMP0owamtPcOdV59P6mIQJp3DTIRrni85DJWNODjYIF0OHKf2ZMC5BmPeyZG2/6
	rzJeu7WD2n56VNCpniQ3r2WS2QHPZOv4iIKYdgbc4OwXeL2RMp03/ayjqg1Ysmbnqwg+
	0sYtYpXo9I0SVk6ko/lSYfYrJNTXRPb5Qa1Zst8oOQg+N3uFYFzP+KX9YjAqJRz8Xszs
	ZdDUK9vZ2pa6KJ2LmRW5j63qryNXSWDXdsem77s39aanwR7C6Xo3uDQXDtRJL4QaRGd8
	x/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=Dst2FGMsCs9IpcjAwFYM6Y8XoVeXqqnJoYTrIPSeVd0=;
	b=HBEnjUxr4rLgUhU1sc0voac/p3vCWnQthVWPEeOknrABSvXE2SB01LPKUQa3zb0+qn
	49vaCNzLcyLNLJMx8fAA/WANJaVjL8EmTobt+bxnWFkFofPogQPt5m8yH0ujtABF2Bmv
	jkQc/czc1Ycu768eRURUfq52TbmvmRLRqWvocAe1XYzhJ2FGY/RyNeLYUgQlixAn8WdL
	lwIeBhPP0HV6KrGk/gAyfcMfjc5OTAE3xzAkxLREq1HcNeKrh9bcWs/qwUN6QI39qfev
	UOah4nGc/Y2OBh8DKA8Y4xkSww+D2YpuVIuzzbXYXrXNiWGZKDng/5hXB3QxaBPP+l9I
	JTTg==
X-Gm-Message-State: APjAAAUjuSI7cbvA1CvbAPv9YN0i3cTCC2FlcT+FjfHjUDjNd47PyKhm
	lPCP0NELmJs7syhCn1nOV2xEkiI4
X-Google-Smtp-Source: APXvYqwI+5y0uYDXcmd5U57FMj+sd0pER5XnICRZV76BvAjg4kj9QCRY6nJKYKJkFZv7uWxhN4tioA==
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr2355825oig.23.1556971540786; 
	Sat, 04 May 2019 05:05:40 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:28 -0600
Message-Id: <20190504120528.6389-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::230
Subject: [Qemu-devel] [PATCH 10/9] coroutine-asm: add x86 CET shadow stack
 support
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504120528.GAkZA8Ryz8SQKwkIoIFOpY53tgsbo8zXYjiwX2tu7_4@z>

Note that the ABI is not yet part of Linux; this patch is
not intended to be committed until that is approved.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure            | 14 ++++++++
 util/Makefile.objs   |  2 ++
 util/coroutine-asm.c | 82 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index c02a5f4b79..8e81d08ef1 100755
--- a/configure
+++ b/configure
@@ -5192,6 +5192,20 @@ if test "$cf_protection" != no; then
       feature_not_found "cf_protection" 'Control-flow protection is not supported by your toolchain'
     fi
     cf_protection=no
+  else
+    if test $cpu = x86_64; then
+      # only needed by coroutine-asm.c, however it should be rare to have
+      # CET support in the compiler but not in binutils
+      cat > $TMPC << EOF
+int main(void) { asm("rdsspq %%rax" : : : "rax"); }
+EOF
+      if ! compile_prog "" "" ; then
+        if test "$cf_protection" = yes; then
+          feature_not_found "cf_protection" 'CET is not supported by your toolchain'
+        fi
+        cf_protection=no
+      fi
+    fi
   fi
 fi
 if test "$cf_protection" = ""; then
diff --git a/util/Makefile.objs b/util/Makefile.objs
index d7add70b63..cf08b4d1c4 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -45,8 +45,10 @@ endif
 ifeq ($(CONFIG_CF_PROTECTION),y)
 coroutine-sigaltstack.o-cflags := -fcf-protection=branch
 coroutine-ucontext.o-cflags := -fcf-protection=branch
+ifneq ($(ARCH),x86_64)
 coroutine-asm.o-cflags += -fcf-protection=branch
 endif
+endif
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
index a9a80e9c71..01875acfc4 100644
--- a/util/coroutine-asm.c
+++ b/util/coroutine-asm.c
@@ -22,6 +22,13 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/coroutine_int.h"
+#include "qemu/error-report.h"
+
+#ifdef CONFIG_CF_PROTECTION
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+int arch_prctl(int code, unsigned long addr);
+#endif
 
 #ifdef CONFIG_VALGRIND_H
 #include <valgrind/valgrind.h>
@@ -42,12 +49,16 @@ typedef struct {
 
     /*
      * aarch64, s390x: instruction pointer
+     * x86: shadow stack pointer
      */
     void *scratch;
 
     void *stack;
     size_t stack_size;
 
+    /* x86: CET shadow stack */
+    void *sstack;
+    size_t sstack_size;
 #ifdef CONFIG_VALGRIND_H
     unsigned int valgrind_stack_id;
 #endif
@@ -82,6 +93,35 @@ static void start_switch_fiber(void **fake_stack_save,
 #endif
 }
 
+static bool have_sstack(void)
+{
+#if defined CONFIG_CF_PROTECTION && defined __x86_64__
+    uint64_t ssp;
+    asm ("xor %0, %0; rdsspq %0\n" : "=r" (ssp));
+    return !!ssp;
+#else
+    return 0;
+#endif
+}
+
+static void *alloc_sstack(size_t sz)
+{
+#if defined CONFIG_CF_PROTECTION && defined __x86_64__
+#ifndef ARCH_X86_CET_ALLOC_SHSTK
+#define ARCH_X86_CET_ALLOC_SHSTK 0x3004
+#endif
+
+    uint64_t arg = sz;
+    if (arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, (unsigned long) &arg) < 0) {
+        abort();
+    }
+
+    return (void *)arg;
+#else
+    abort();
+#endif
+}
+
 #ifdef __x86_64__
 /*
  * We hardcode all operands to specific registers so that we can write down all the
@@ -93,6 +133,26 @@ static void start_switch_fiber(void **fake_stack_save,
  * Note that push and call would clobber the red zone.  Makefile.objs compiles this
  * file with -mno-red-zone.  The alternative is to subtract/add 128 bytes from rsp
  * around the switch, with slightly lower cache performance.
+ *
+ * The RSTORSSP and SAVEPREVSSP instructions are intricate.  In a nutshell they are:
+ *
+ *      RSTORSSP(mem):    oldSSP = SSP
+ *                        SSP = mem
+ *                        *SSP = oldSSP
+ *
+ *      SAVEPREVSSP:      oldSSP = shadow_stack_pop()
+ *                        *(oldSSP - 8) = oldSSP       # "push" to old shadow stack
+ *
+ * Therefore, RSTORSSP(mem) followed by SAVEPREVSSP is the same as
+ *
+ *     shadow_stack_push(SSP)
+ *     SSP = mem
+ *     shadow_stack_pop()
+ *
+ * From the simplified description you can see that co->ssp, being stored before
+ * the RSTORSSP+SAVEPREVSSP sequence, points to the top actual entry of the shadow
+ * stack, not to the restore token.  Hence we use an offset of -8 in the operand
+ * of rstorssp.
  */
 #define CO_SWITCH(from, to, action, jump) ({                                          \
     int action_ = action;                                                             \
@@ -105,7 +165,15 @@ static void start_switch_fiber(void **fake_stack_save,
         "jmp 2f\n"                          /* switch back continues at label 2 */    \
                                                                                       \
         "1: .cfi_adjust_cfa_offset 8\n"                                               \
-        "movq %%rsp, %c[SP](%[FROM])\n"     /* save source SP */                      \
+        "xor %%rbp, %%rbp\n"                /* use old frame pointer as scratch reg */ \
+        "rdsspq %%rbp\n"                                                              \
+        "test %%rbp, %%rbp\n"               /* if CET is enabled... */                \
+        "jz 9f\n"                                                                     \
+        "movq %%rbp, %c[SCRATCH](%[FROM])\n" /* ... save source shadow SP, */         \
+        "movq %c[SCRATCH](%[TO]), %%rbp\n"   /* restore destination shadow stack, */  \
+        "rstorssp -8(%%rbp)\n"                                                        \
+        "saveprevssp\n"                     /* and save source shadow SP token */     \
+        "9: movq %%rsp, %c[SP](%[FROM])\n"  /* save source SP */                      \
         "movq %c[SP](%[TO]), %%rsp\n"       /* load destination SP */                 \
         jump "\n"                           /* coroutine switch */                    \
                                                                                       \
@@ -113,7 +181,8 @@ static void start_switch_fiber(void **fake_stack_save,
         "popq %%rbp\n"                                                                \
         ".cfi_adjust_cfa_offset -8\n"                                                 \
         : "+a" (action_), [FROM] "+b" (from_), [TO] "+D" (to_)                        \
-        : [SP] "i" (offsetof(CoroutineAsm, sp))                                       \
+        : [SP] "i" (offsetof(CoroutineAsm, sp)),                                      \
+          [SCRATCH] "i" (offsetof(CoroutineAsm, scratch))                             \
         : "rcx", "rdx", "rsi", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",  \
           "memory");                                                                  \
     action_;                                                                          \
@@ -220,6 +289,12 @@ Coroutine *qemu_coroutine_new(void)
     co->stack = qemu_alloc_stack(&co->stack_size);
     co->sp = co->stack + co->stack_size;
 
+    if (have_sstack()) {
+        co->sstack_size = COROUTINE_SHADOW_STACK_SIZE;
+        co->sstack = alloc_sstack(co->sstack_size);
+        co->scratch = co->sstack + co->sstack_size;
+    }
+
 #ifdef CONFIG_VALGRIND_H
     co->valgrind_stack_id =
         VALGRIND_STACK_REGISTER(co->stack, co->stack + co->stack_size);
@@ -265,6 +340,9 @@ void qemu_coroutine_delete(Coroutine *co_)
 #endif
 
     qemu_free_stack(co->stack, co->stack_size);
+    if (co->sstack) {
+        munmap(co->sstack, co->sstack_size);
+    }
     g_free(co);
 }
 
-- 
2.21.0


