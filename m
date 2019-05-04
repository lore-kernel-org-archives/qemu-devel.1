Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA91C04AA9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C90206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjGrNLQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C90206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtUj-0002F7-2a
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:10:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQA-000795-Dd
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ7-0001CK-0m
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQ6-0001Bq-Oi; Sat, 04 May 2019 08:05:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id g8so7624747otl.8;
	Sat, 04 May 2019 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JLVM6LVe8Ci/wZhURG+abGdUOpJKnFkyRFzRhc1SJWU=;
	b=XjGrNLQ7KSyKQyu5UmbwKRrE0WcO8JeUSinNAWStQOurprmn5Vzj9dGaemEKFp7tM4
	8NpNqASxAcAOQ1faSaaSrjq3b5QU623zKuwPkGlgrvLHx2PYX3uVc25whrztlJBR9sch
	jpkwCVBMuBCkNCqP7NA3MPXnnuN8RIjqh0Z1HAdCqCW/3yo3xuYDblazypY7j67Nc/5Z
	Vm5ItF8sFd+3FJJXPa+7eBpmzRRJPgN2GEsMxKzbudloWE89441BvJo53gUTitQ40I9a
	/GKVAE4CpfMxQEarVQHoVjee67mjtaghic1GlCfNCnKR3x01lay3cBnnr1k7UlBITfse
	PV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=JLVM6LVe8Ci/wZhURG+abGdUOpJKnFkyRFzRhc1SJWU=;
	b=gysFq4+r4qqfWaDoJcqfyADhBMqmXLPVB/rpIcbu1vuticTvYp/igIPJE68Ob/63ve
	9P27Y10kWyB77K3uDxpoo0Agmfkm/HrdvSeXTs2pRgCP0II4d1BW/kgmVadToKjDPs+0
	TQHhSSUamv95lxrY1dGBmrPe8s70uz8GuH4FFxqZnmAi8sV9DrDyS9qe33qdJh4i9nwp
	KhuC+FN3e7Gx+c0xU51xZ6aDALrl5M63dhj04m9/Qk8ZIxtktUC/0HzLPT6XA74lUt26
	h7tKZmPhNF/w6lKbVWf2IMESue1vgMWnKeJkUBFlSo9n9HxZw1+b4rc0ELapQzEMTArX
	YPwA==
X-Gm-Message-State: APjAAAX7UHDjBKVq/dItYqJB6CZWdTqL3nkkOaT/fdE8ibLkhVjUNL2z
	iXVs8r7mnud1ZNe1nWU+uzptT+NC
X-Google-Smtp-Source: APXvYqwFgA6xZyLcLIz6WrCS29JaaXR+3+Z4YuzBt62cE9J8ViTsxDmC7YyA6payPMOi+y6zu2wDvQ==
X-Received: by 2002:a9d:67:: with SMTP id 94mr10123010ota.57.1556971533699;
	Sat, 04 May 2019 05:05:33 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:21 -0600
Message-Id: <20190504120528.6389-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH 3/9] coroutine: add host specific coroutine
 backend for 64-bit x86
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
Message-ID: <20190504120521.s9-TfnCj4t7XD-jF1hdpR_Dp11z3ex1yawrdna2FtFc@z>

This backend is faster (100ns vs 150ns per switch on my laptop), but
especially it will be possible to add CET support to it.  Most of the
code is actually not architecture specific.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                        |  10 ++
 scripts/qemugdb/coroutine.py     |   5 +-
 scripts/qemugdb/coroutine_asm.py |  20 +++
 util/Makefile.objs               |   1 +
 util/coroutine-asm.c             | 230 +++++++++++++++++++++++++++++++
 5 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_asm.py
 create mode 100644 util/coroutine-asm.c

diff --git a/configure b/configure
index 5b183c2e39..c01f57a3ae 100755
--- a/configure
+++ b/configure
@@ -5200,6 +5200,8 @@ fi
 if test "$coroutine" = ""; then
   if test "$mingw32" = "yes"; then
     coroutine=win32
+  elif test "$cpu" = "x86_64"; then
+     coroutine=asm
   elif test "$ucontext_works" = "yes"; then
     coroutine=ucontext
   else
@@ -5225,6 +5227,14 @@ else
       error_exit "only the 'windows' coroutine backend is valid for Windows"
     fi
     ;;
+  asm)
+    if test "$mingw32" = "yes"; then
+      error_exit "only the 'windows' coroutine backend is valid for Windows"
+    fi
+    if test "$cpu" != "x86_64"; then
+      error_exit "the 'asm' backend is only valid for x86_64 hosts"
+    fi
+    ;;
   *)
     error_exit "unknown coroutine backend $coroutine"
     ;;
diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 076f6808ab..dc760235e7 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -10,14 +10,15 @@
 # This work is licensed under the terms of the GNU GPL, version 2
 # or later.  See the COPYING file in the top-level directory.
 
-from . import coroutine_ucontext
+from . import coroutine_ucontext, coroutine_asm
 import gdb
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 UINTPTR_T = gdb.lookup_type('uintptr_t')
 
 backends = {
-    'CoroutineUContext': coroutine_ucontext
+    'CoroutineUContext': coroutine_ucontext,
+    'CoroutineAsm': coroutine_asm
 }
 
 def coroutine_backend():
diff --git a/scripts/qemugdb/coroutine_asm.py b/scripts/qemugdb/coroutine_asm.py
new file mode 100644
index 0000000000..b4ac1291db
--- /dev/null
+++ b/scripts/qemugdb/coroutine_asm.py
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+# GDB debugging support
+#
+# Copyright 2019 Red Hat, Inc.
+#
+# Authors:
+#  Paolo Bonzini <pbonzini@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import gdb
+
+U64_PTR = gdb.lookup_type('uint64_t').pointer()
+
+def get_coroutine_regs(addr):
+    addr = addr.cast(gdb.lookup_type('CoroutineAsm').pointer())
+    rsp = addr['sp'].cast(U64_PTR)
+    return {'sp': rsp, 'pc': rsp.dereference()}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 9206878dec..41a10539cf 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -39,6 +39,7 @@ util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
+coroutine-asm.o-cflags := -mno-red-zone
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
new file mode 100644
index 0000000000..a06ecbcb0a
--- /dev/null
+++ b/util/coroutine-asm.c
@@ -0,0 +1,230 @@
+/*
+ * Host-specific coroutine initialization code
+ *
+ * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
+ * Copyright (C) 2011  Kevin Wolf <kwolf@redhat.com>
+ * Copyright (C) 2019  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.0 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/coroutine_int.h"
+
+#ifdef CONFIG_VALGRIND_H
+#include <valgrind/valgrind.h>
+#endif
+
+#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#ifdef CONFIG_ASAN_IFACE_FIBER
+#define CONFIG_ASAN 1
+#include <sanitizer/asan_interface.h>
+#endif
+#endif
+
+#define COROUTINE_SHADOW_STACK_SIZE    4096
+
+typedef struct {
+    Coroutine base;
+    void *sp;
+
+    void *stack;
+    size_t stack_size;
+
+#ifdef CONFIG_VALGRIND_H
+    unsigned int valgrind_stack_id;
+#endif
+} CoroutineAsm;
+
+/**
+ * Per-thread coroutine bookkeeping
+ */
+static __thread CoroutineAsm leader;
+static __thread Coroutine *current;
+
+static void finish_switch_fiber(void *fake_stack_save)
+{
+#ifdef CONFIG_ASAN
+    const void *bottom_old;
+    size_t size_old;
+
+    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &size_old);
+
+    if (!leader.stack) {
+        leader.stack = (void *)bottom_old;
+        leader.stack_size = size_old;
+    }
+#endif
+}
+
+static void start_switch_fiber(void **fake_stack_save,
+                               const void *bottom, size_t size)
+{
+#ifdef CONFIG_ASAN
+    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
+#endif
+}
+
+#ifdef __x86_64__
+/*
+ * We hardcode all operands to specific registers so that we can write down all the
+ * others in the clobber list.  Note that action also needs to be hardcoded so that
+ * it is the same register in all expansions of this macro.  Also, we use %rdi
+ * for the coroutine because that is the ABI's first argument register;
+ * coroutine_trampoline can then retrieve the current coroutine from there.
+ *
+ * Note that push and call would clobber the red zone.  Makefile.objs compiles this
+ * file with -mno-red-zone.  The alternative is to subtract/add 128 bytes from rsp
+ * around the switch, with slightly lower cache performance.
+ */
+#define CO_SWITCH(from, to, action, jump) ({                                          \
+    int action_ = action;                                                             \
+    void *from_ = from;                                                               \
+    void *to_ = to;                                                                   \
+    asm volatile(                                                                     \
+        "pushq %%rbp\n"                     /* save frame register on source stack */ \
+        ".cfi_adjust_cfa_offset 8\n"                                                  \
+        "call 1f\n"                         /* switch continues at label 1 */         \
+        "jmp 2f\n"                          /* switch back continues at label 2 */    \
+                                                                                      \
+        "1: .cfi_adjust_cfa_offset 8\n"                                               \
+        "movq %%rsp, %c[SP](%[FROM])\n"     /* save source SP */                      \
+        "movq %c[SP](%[TO]), %%rsp\n"       /* load destination SP */                 \
+        jump "\n"                           /* coroutine switch */                    \
+                                                                                      \
+        "2: .cfi_adjust_cfa_offset -8\n"                                              \
+        "popq %%rbp\n"                                                                \
+        ".cfi_adjust_cfa_offset -8\n"                                                 \
+        : "+a" (action_), [FROM] "+b" (from_), [TO] "+D" (to_)                        \
+        : [SP] "i" (offsetof(CoroutineAsm, sp))                                       \
+        : "rcx", "rdx", "rsi", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",  \
+          "memory");                                                                  \
+    action_;                                                                          \
+})
+/* Use "call" to ensure the stack  is aligned correctly.  */
+#define CO_SWITCH_NEW(from, to) CO_SWITCH(from, to, 0, "call coroutine_trampoline")
+#define CO_SWITCH_RET(from, to, action) CO_SWITCH(from, to, action, "ret")
+#else
+#error coroutine-asm.c not ported to this architecture.
+#endif
+
+static void __attribute__((__used__)) coroutine_trampoline(CoroutineAsm *self)
+{
+    finish_switch_fiber(NULL);
+
+    while (true) {
+        Coroutine *co = &self->base;
+        qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
+        co->entry(co->entry_arg);
+    }
+}
+
+Coroutine *qemu_coroutine_new(void)
+{
+    CoroutineAsm *co;
+    void *fake_stack_save = NULL;
+
+    co = g_malloc0(sizeof(*co));
+    co->stack_size = COROUTINE_STACK_SIZE;
+    co->stack = qemu_alloc_stack(&co->stack_size);
+    co->sp = co->stack + co->stack_size;
+
+#ifdef CONFIG_VALGRIND_H
+    co->valgrind_stack_id =
+        VALGRIND_STACK_REGISTER(co->stack, co->stack + co->stack_size);
+#endif
+
+    /*
+     * Immediately enter the coroutine once to initialize the stack
+     * and program counter.  We could instead just push the address
+     * of coroutine_trampoline and let qemu_coroutine_switch return
+     * to it, but doing it this way confines the non-portable code
+     * to the CO_SWITCH* macros.
+     */
+    co->base.caller = qemu_coroutine_self();
+    start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
+    CO_SWITCH_NEW(current, co);
+    finish_switch_fiber(fake_stack_save);
+    co->base.caller = NULL;
+
+    return &co->base;
+}
+
+#ifdef CONFIG_VALGRIND_H
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
+/* Work around an unused variable in the valgrind.h macro... */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
+#endif
+static inline void valgrind_stack_deregister(CoroutineAsm *co)
+{
+    VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
+}
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+#endif
+
+void qemu_coroutine_delete(Coroutine *co_)
+{
+    CoroutineAsm *co = DO_UPCAST(CoroutineAsm, base, co_);
+
+#ifdef CONFIG_VALGRIND_H
+    valgrind_stack_deregister(co);
+#endif
+
+    qemu_free_stack(co->stack, co->stack_size);
+    g_free(co);
+}
+
+/*
+ * This function is marked noinline to prevent GCC from inlining it
+ * into coroutine_trampoline(). If we allow it to do that then it
+ * hoists the code to get the address of the TLS variable "current"
+ * out of the while() loop. This is an invalid transformation because
+ * qemu_coroutine_switch() may be called when running thread A but
+ * return in thread B, and so we might be in a different thread
+ * context each time round the loop.
+ */
+CoroutineAction __attribute__((noinline))
+qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
+                      CoroutineAction action)
+{
+    CoroutineAsm *from = DO_UPCAST(CoroutineAsm, base, from_);
+    CoroutineAsm *to = DO_UPCAST(CoroutineAsm, base, to_);
+    void *fake_stack_save = NULL;
+
+    current = to_;
+
+    start_switch_fiber(action == COROUTINE_TERMINATE ?
+                       NULL : &fake_stack_save, to->stack, to->stack_size);
+    action = CO_SWITCH_RET(from, to, action);
+    finish_switch_fiber(fake_stack_save);
+
+    return action;
+}
+
+Coroutine *qemu_coroutine_self(void)
+{
+    if (!current) {
+        current = &leader.base;
+    }
+    return current;
+}
+
+bool qemu_in_coroutine(void)
+{
+    return current && current->caller;
+}
-- 
2.21.0



