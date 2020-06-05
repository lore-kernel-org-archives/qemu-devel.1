Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC807206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frrsC2El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC807206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGIW-0004vU-Tg
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHf-0003Gy-PE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:35 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHe-0003pr-El
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id z64so5296232pfb.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PolYfWsjQxLFUFecxYjpFffyz0BlbK4AQIvIQhTtHFk=;
 b=frrsC2Elmq/htA0uFNhU4ByXtqejBBJec9CpBtisYiHUYZfniReqC1lrrUGNczcoIg
 zFm1C9ESCWw3o9gkEkuYArO2RP4nxXWJC4VV0HI6E86YhNOg7LvdP1uIOJvgpUpNkfyL
 ZHOV5UjOOHnBtR0Y1PeGdBHlD+WhJN3ivXktJ3g7EGf/PXAyuI5O0pOZLWaylsMiDGLQ
 oxDgANy3zH09suNVRpmLFCzC0eZEEnC9grot77r35ldUs+UI9n1qrxdVKW49UWwED1yN
 Bv1fi0/qDP2Iold2kaIE2Kc9ZXZ+aVNE1tuW6u2MryhrWJaIt9h7o95dqnSWGmyX9oZg
 jipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PolYfWsjQxLFUFecxYjpFffyz0BlbK4AQIvIQhTtHFk=;
 b=M37pjFFZzFhWI0sH6iH5dyFSj6i5f7t+w/nDW+0JKAPDWJ2ZdZZTMLi6tTrptMlGIn
 RfqxUJ+RXRbkxc3ARtue0MSoo7gLqBLXmTbsEQywOAS7SuPfdjveYv0IxBs3pbbMybGc
 sKG3Oa2ouuXgkuMkU1FpR4Ydj/zGkx6NUl+G713hnCcrnTBegoqPWH1qlVUENDV3hRDa
 omP8tsmEbewiqrx4Fz8VtWl1XpnYMqvQDstZ4nzOf14hAs/XOxh/b1cXQY02roHuCWvu
 Q6vAgwsrdDOvMftHmPd13+Yz7gqGPSGSOT54vpXjfr6MeJZnyajDqZ3au6hSpU2ysBNj
 8ahw==
X-Gm-Message-State: AOAM530dP33qTP4WxbXppQNcUdlnBZzfBGbe2mmSBkvRAICMHnGzXFJh
 eG1o9W4oimN8p2OG47EUMU0jgVR737iROw==
X-Google-Smtp-Source: ABdhPJyd6iqN+f2lZcfB1N+jhvme4nlL2cxYXx/SzPpgifhA9THzo37JpRM6CpCTZ+mPSprF6YBHUg==
X-Received: by 2002:a62:2cd7:: with SMTP id s206mr3403909pfs.305.1591378652406; 
 Fri, 05 Jun 2020 10:37:32 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/13] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
Date: Fri,  5 Jun 2020 13:34:10 -0400
Message-Id: <20200605173422.1490-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, robert.foley@linaro.org,
 alex.bennee@linaro.org, cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Lingfeng Yang <lfy@google.com>, peter.puhov@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
[RF: configure changes for warnings, erorr handling + minor modifications]
---
 configure                 | 47 ++++++++++++++++++-
 util/coroutine-ucontext.c | 97 +++++++++++++++++++++++++++++++++++----
 2 files changed, 134 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index f087d2bcd1..9b50820366 100755
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
@@ -6192,6 +6198,30 @@ if test "$fuzzing" = "yes" ; then
   fi
 fi
 
+# Thread sanitizer is, for now, much noisier than the other sanitizers;
+# keep it separate until that is not the case.
+if test "$tsan" = "yes" && test "$sanitizers" = "yes"; then
+  error_exit "TSAN is not supported with other sanitiziers."
+fi
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
 
@@ -6293,6 +6323,16 @@ if test "$have_asan" = "yes"; then
            "Without code annotation, the report may be inferior."
   fi
 fi
+if test "$have_tsan" = "yes" ; then
+  if test "$have_tsan_iface_fiber" = "yes" ; then
+    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
+    QEMU_LDFLAGS="-fsanitize=thread $QEMU_LDFLAGS"
+  else
+    error_exit "Cannot enable TSAN due to missing fiber annotation interface."
+  fi
+elif test "$tsan" = "yes" ; then
+  error_exit "Cannot enable TSAN due to missing sanitize thread interface."
+fi
 if test "$have_ubsan" = "yes"; then
   QEMU_CFLAGS="-fsanitize=undefined $QEMU_CFLAGS"
   QEMU_LDFLAGS="-fsanitize=undefined $QEMU_LDFLAGS"
@@ -6328,7 +6368,8 @@ if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
 fi
 
-if test "$solaris" = "no" ; then
+# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
+if test "$solaris" = "no" && test "$tsan" = "no"; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; then
         QEMU_LDFLAGS="-Wl,--warn-common $QEMU_LDFLAGS"
     fi
@@ -7382,6 +7423,10 @@ if test "$have_asan_iface_fiber" = "yes" ; then
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


