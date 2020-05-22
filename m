Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6E920663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0Qa8JM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6E920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcALT-0004N9-OK
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAK7-0002T7-P2
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:03 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAK6-000662-8w
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:03 -0400
Received: by mail-pj1-x1041.google.com with SMTP id l73so2349970pjb.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vLmwpV4CahL0pJZ+ld8j2cVRuvN4pfMS6sb1kFhB4zs=;
 b=s0Qa8JM5KVLZCBbZzIiGJU8iOkPsgRkpZoVYn1R6VuYtkxh4VueGuaTYapE9zoNLpF
 c8SPbIvVICU0FwYPFi9+KJJizgMHbOynsGPFFSdW5bIRt+l+vdsMNL/5KgkvN1RaoZHH
 755W2UUf/zyon3kX8vBU5o4ZiBuRPdAChYK5BS1B+p/z0G2DdWyXX4TTBJvO51HMTglw
 c0DxW8Jy59itXNLCE8XWE1SonG7W9zxLrsdqd9acNWA4PsnDf9NoFGP6lwoBPgkYceGX
 owbXhUva+9VsrwrpxTcQdcX4zNQUjtHoKrlnqeOvRBK/YKlaL/XE0fOKjZSkLSaY2J4A
 RxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vLmwpV4CahL0pJZ+ld8j2cVRuvN4pfMS6sb1kFhB4zs=;
 b=gQJf+ARuasCDqC/XkOa3LPEVv5hPwxDm0cqcxT7L5w+MCf9O7KIQFHQzHOQqJDXdxY
 BUqu+VmQO5C3kStoIHcy6jIaFVv2NoRSk5dvEehjCVP6JgWerYUkYNGsHuelKs2E5R1e
 W7ygeLqZy6E2MGZopcVYNrnWkXxiELJxSZYEotnfrhRg6hZh+oG/k+c5UWTebjPKb6vY
 SN0aJPup4eG3eptXXP4ELLYYi8Zcjcl1oXbvmOyT8SVDicl3LMcXZVYTSqtHf5OlP7u3
 /Ms1i28sMvZ1DEFPeVM24nCsxGglxuY3Bzj1vHj6RmziI6fueAaF6pABZnsMibuAOmPI
 pqYA==
X-Gm-Message-State: AOAM531prDn9grBEagzY8gHWPnwK5nGtDxw99dEkwH4RjkEYdH2yBfiJ
 F4DdfMmUU2ymWMQk1DHhff/cezywsMq6hA==
X-Google-Smtp-Source: ABdhPJzxSmD7KEq2QPryYQMHBtj+5onh5agc3+Yz2is4fS0MDWtw+Cs+5HX/qpkXNG/lQa97hbuSlw==
X-Received: by 2002:a17:90b:ed2:: with SMTP id
 gz18mr5434570pjb.22.1590164100020; 
 Fri, 22 May 2020 09:15:00 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:14:59 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/19] configure: add --enable-tsan flag + fiber annotations
 for coroutine-ucontext
Date: Fri, 22 May 2020 12:07:37 -0400
Message-Id: <20200522160755.886-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lingfeng Yang <lfy@google.com>

We tried running QEMU under tsan in 2016, but tsan's lack of support for
longjmp-based fibers was a blocker:
  https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw

Fortunately, thread sanitizer gained fiber support in early 2019:
  https://reviews.llvm.org/D54889

This patch brings tsan support upstream by importing the patch that annotated
QEMU's coroutines as tsan fibers in Android's QEMU fork:
  https://android-review.googlesource.com/c/platform/external/qemu/+/844675

Tested with '--enable-tsan --cc=clang-9 --cxx=clang++-9 --disable-werror'
configure flags.

Signed-off-by: Lingfeng Yang <lfy@google.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[cota: minor modifications + configure changes]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
[RF: minor changes to clean up checkpatch warnings/errors]
---
 configure                 | 39 ++++++++++++++++
 util/coroutine-ucontext.c | 97 +++++++++++++++++++++++++++++++++++----
 2 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 26084fc53a..c95c54fb48 100755
--- a/configure
+++ b/configure
@@ -395,6 +395,7 @@ gprof="no"
 debug_tcg="no"
 debug="no"
 sanitizers="no"
+tsan="no"
 fortify_source=""
 strip_opt="yes"
 tcg_interpreter="no"
@@ -1150,6 +1151,10 @@ for opt do
   ;;
   --disable-sanitizers) sanitizers="no"
   ;;
+  --enable-tsan) tsan="yes"
+  ;;
+  --disable-tsan) tsan="no"
+  ;;
   --enable-sparse) sparse="yes"
   ;;
   --disable-sparse) sparse="no"
@@ -1750,6 +1755,7 @@ Advanced options (experts only):
   --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
+  --enable-tsan            enable thread sanitizer
   --disable-strip          disable stripping binaries
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
@@ -6176,6 +6182,27 @@ if test "$fuzzing" = "yes" ; then
   fi
 fi
 
+# Thread sanitizer is, for now, much noisier than the other sanitizers;
+# keep it separate until that is not the case.
+have_tsan=no
+have_tsan_iface_fiber=no
+if test "$tsan" = "yes" ; then
+  write_c_skeleton
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
+      have_tsan=yes
+  fi
+  cat > $TMPC << EOF
+#include <sanitizer/tsan_interface.h>
+int main(void) {
+  __tsan_create_fiber(0);
+  return 0;
+}
+EOF
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
+      have_tsan_iface_fiber=yes
+  fi
+fi
+
 ##########################################
 # check for libpmem
 
@@ -6277,6 +6304,14 @@ if test "$have_asan" = "yes"; then
            "Without code annotation, the report may be inferior."
   fi
 fi
+if test "$have_tsan" = "yes" ; then
+  if test "$have_tsan_iface_fiber" = "yes" ; then
+    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
+    QEMU_LDFLAGS="-fsanitize=thread $QEMU_LDFLAGS"
+  else
+    echo "Cannot enable TSAN due to missing fiber annotation interface."
+  fi
+fi
 if test "$have_ubsan" = "yes"; then
   QEMU_CFLAGS="-fsanitize=undefined $QEMU_CFLAGS"
   QEMU_LDFLAGS="-fsanitize=undefined $QEMU_LDFLAGS"
@@ -7365,6 +7400,10 @@ if test "$have_asan_iface_fiber" = "yes" ; then
     echo "CONFIG_ASAN_IFACE_FIBER=y" >> $config_host_mak
 fi
 
+if test "$have_tsan" = "yes" && test "$have_tsan_iface_fiber" = "yes" ; then
+    echo "CONFIG_TSAN=y" >> $config_host_mak
+fi
+
 if test "$has_environ" = "yes" ; then
   echo "CONFIG_HAS_ENVIRON=y" >> $config_host_mak
 fi
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index bd593e61bc..a3dc78e67a 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -37,18 +37,33 @@
 #endif
 #endif
 
+#ifdef CONFIG_TSAN
+#include <sanitizer/tsan_interface.h>
+#endif
+
 typedef struct {
     Coroutine base;
     void *stack;
     size_t stack_size;
     sigjmp_buf env;
 
+    void *tsan_co_fiber;
+    void *tsan_caller_fiber;
+
 #ifdef CONFIG_VALGRIND_H
     unsigned int valgrind_stack_id;
 #endif
 
 } CoroutineUContext;
 
+#define UC_DEBUG 0
+#if UC_DEBUG && defined(CONFIG_TSAN)
+#define UC_TRACE(fmt, ...) fprintf(stderr, "%s:%d:%p " fmt "\n", \
+    __func__, __LINE__, __tsan_get_current_fiber(), ##__VA_ARGS__);
+#else
+#define UC_TRACE(fmt, ...)
+#endif
+
 /**
  * Per-thread coroutine bookkeeping
  */
@@ -65,7 +80,20 @@ union cc_arg {
     int i[2];
 };
 
-static void finish_switch_fiber(void *fake_stack_save)
+/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it. */
+static inline __attribute__((always_inline))
+void on_new_fiber(CoroutineUContext *co)
+{
+#ifdef CONFIG_TSAN
+    co->tsan_co_fiber = __tsan_create_fiber(0); /* flags: sync on switch */
+    co->tsan_caller_fiber = __tsan_get_current_fiber();
+    UC_TRACE("Create new TSAN co fiber. co: %p co fiber: %p caller fiber: %p ",
+             co, co->tsan_co_fiber, co->tsan_caller_fiber);
+#endif
+}
+
+static inline __attribute__((always_inline))
+void finish_switch_fiber(void *fake_stack_save)
 {
 #ifdef CONFIG_ASAN
     const void *bottom_old;
@@ -78,18 +106,40 @@ static void finish_switch_fiber(void *fake_stack_save)
         leader.stack_size = size_old;
     }
 #endif
+#ifdef CONFIG_TSAN
+    if (fake_stack_save) {
+        __tsan_release(fake_stack_save);
+        __tsan_switch_to_fiber(fake_stack_save, 0);  /* 0=synchronize */
+    }
+#endif
 }
 
-static void start_switch_fiber(void **fake_stack_save,
-                               const void *bottom, size_t size)
+static inline __attribute__((always_inline)) void start_switch_fiber(
+    CoroutineAction action, void **fake_stack_save,
+    const void *bottom, size_t size, void *new_fiber)
 {
 #ifdef CONFIG_ASAN
-    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
+    if (action == COROUTINE_TERMINATE) {
+        __sanitizer_start_switch_fiber(
+            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
+            bottom, size);
+    }
+#endif
+#ifdef CONFIG_TSAN
+    void *curr_fiber =
+        __tsan_get_current_fiber();
+    __tsan_acquire(curr_fiber);
+
+    UC_TRACE("Current fiber: %p.", curr_fiber);
+    *fake_stack_save = curr_fiber;
+    UC_TRACE("Switch to fiber %p", new_fiber);
+    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=synchronize */
 #endif
 }
 
 static void coroutine_trampoline(int i0, int i1)
 {
+    UC_TRACE("Start trampoline");
     union cc_arg arg;
     CoroutineUContext *self;
     Coroutine *co;
@@ -104,21 +154,34 @@ static void coroutine_trampoline(int i0, int i1)
 
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
-        start_switch_fiber(&fake_stack_save,
-                           leader.stack, leader.stack_size);
+        UC_TRACE("Current fiber: %p. Set co %p to env 0x%lx",
+                 __tsan_get_current_fiber(), self, (unsigned long)self->env);
+        start_switch_fiber(
+            COROUTINE_YIELD,
+            &fake_stack_save,
+            leader.stack,
+            leader.stack_size,
+            self->tsan_caller_fiber);
+        UC_TRACE("Jump to co %p caller fiber %p env 0x%lx",
+                 co, self->tsan_caller_fiber, *(unsigned long *)co->entry_arg);
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
 
+    UC_TRACE("After first siglongjmp");
+
     finish_switch_fiber(fake_stack_save);
 
     while (true) {
         co->entry(co->entry_arg);
+        UC_TRACE("switch from co %p to caller co %p fiber %p\n",
+                 co, co->caller, self->tsan_caller_fiber);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
     }
 }
 
 Coroutine *qemu_coroutine_new(void)
 {
+    UC_TRACE("Start new coroutine");
     CoroutineUContext *co;
     ucontext_t old_uc, uc;
     sigjmp_buf old_env;
@@ -154,12 +217,16 @@ Coroutine *qemu_coroutine_new(void)
 
     arg.p = co;
 
+    on_new_fiber(co);
     makecontext(&uc, (void (*)(void))coroutine_trampoline,
                 2, arg.i[0], arg.i[1]);
 
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
-        start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
+        start_switch_fiber(
+            COROUTINE_YIELD,
+            &fake_stack_save,
+            co->stack, co->stack_size, co->tsan_co_fiber);
         swapcontext(&old_uc, &uc);
     }
 
@@ -185,6 +252,7 @@ static inline void valgrind_stack_deregister(CoroutineUContext *co)
 
 void qemu_coroutine_delete(Coroutine *co_)
 {
+    UC_TRACE("Nuking co %p from orbit", co_);
     CoroutineUContext *co = DO_UPCAST(CoroutineUContext, base, co_);
 
 #ifdef CONFIG_VALGRIND_H
@@ -209,6 +277,10 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 {
     CoroutineUContext *from = DO_UPCAST(CoroutineUContext, base, from_);
     CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, to_);
+    UC_TRACE("from to: %p %p uc: %p %p. fibers: %p %p caller fibers: %p %p\n",
+            from_, to_, from, to,
+            from->tsan_co_fiber, to->tsan_co_fiber,
+            from->tsan_caller_fiber, to->tsan_caller_fiber);
     int ret;
     void *fake_stack_save = NULL;
 
@@ -216,8 +288,8 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
-        start_switch_fiber(action == COROUTINE_TERMINATE ?
-                           NULL : &fake_stack_save, to->stack, to->stack_size);
+        start_switch_fiber(action, &fake_stack_save,
+                           to->stack, to->stack_size, to->tsan_co_fiber);
         siglongjmp(to->env, action);
     }
 
@@ -231,6 +303,13 @@ Coroutine *qemu_coroutine_self(void)
     if (!current) {
         current = &leader.base;
     }
+#ifdef CONFIG_TSAN
+    if (!leader.tsan_co_fiber) {
+        leader.tsan_co_fiber = __tsan_get_current_fiber();
+        UC_TRACE("For co %p set leader co fiber to %p",
+                 current, leader.tsan_co_fiber);
+    }
+#endif
     return current;
 }
 
-- 
2.17.1


