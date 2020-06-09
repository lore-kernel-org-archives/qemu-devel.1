Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0798220835
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvN7s+Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0798220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikaF-0000Wf-7E
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ1-0007NR-UN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:39 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ0-0005Yy-AX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:39 -0400
Received: by mail-pl1-x643.google.com with SMTP id t7so25209plr.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PEbujPtBaJg3B2IT0hPnYXWImSAP6JwyxZ2Cqb86MEY=;
 b=SvN7s+MjJJ7ADNt5weFq9NU9aiPFWeG9ft6r1PtTQHd+3Gl7ccE4YXSi6/TY6Gxcac
 D20wS7o7f1naPiFINjoWEKkNr4pVdtSQa0S/aYdAGEVSSl9rpTeE1WFFUnHAVq2WrZBA
 PFgxacabSIBZ7svHkx90sm50Kia5ly7lZiWHk5d5sXp5ZuP/0FZBdtFlGPqRXLHlwtg9
 YP6STyvxaK1o2xW3JeBTkMD+genH0b9J5KssTSRw+TXuJUWuWXYeBiNVKIgUtc9GR0Nh
 s/0r0LlMZ8y3LVrOLt8Y/0HC7M1TT6DkYv+99MOU9xMp2+ykz47o0OKzLClwjOWwGRje
 ekNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PEbujPtBaJg3B2IT0hPnYXWImSAP6JwyxZ2Cqb86MEY=;
 b=ouAi0af6BUydq+FGArZCkyP2GK1Pv0V9Z8egfKN/jP0nl+gSHBCYHbz4c7C48KcY4D
 9PbwFcAgG05trcVm9rgpX+tGffxerAtAepHS6YMFTBWOtoT3LMg/4y7+4vgjZZ7vvPfE
 YsWlvAJvfB4+TbdT1Sfx+lcqJChCt9CHKLLRF+npOjmc7xBQLArvYHTyK7CjcWNRQF3z
 Nr5j5ytqiMyCyqbEjMDM65YuhhDQamKMQEEE9vnvCZ5syzuKF0EzIEyx3rHFEfO2Xi/I
 L+KuQqgvxIrirp8YDzPmxYt5ppnhU4ictRtuphFo2/84e88SoJSZUy+6sJBPyzfM7D3Z
 pkXQ==
X-Gm-Message-State: AOAM532o3oE9D+Uwqxl4ff9Ixf4ReALGfJ2uestRRlnzu2I/Abvc5g7p
 t++v28RsF3zafOikxRWysS+UfC1h4hv1Wg==
X-Google-Smtp-Source: ABdhPJxxJgmIuAK7Dsrr+C1xb6yzvhfArxJ3Rkx7JmEmqecu1FybFjMEzmK8Zqq482a4R9iRL9os5w==
X-Received: by 2002:a17:90a:3608:: with SMTP id
 s8mr6294130pjb.167.1591733376257; 
 Tue, 09 Jun 2020 13:09:36 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/13] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
Date: Tue,  9 Jun 2020 16:07:26 -0400
Message-Id: <20200609200738.445-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
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
[RF: configure changes, coroutine fix + minor modifications]
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                 | 47 +++++++++++++++++++++++++++-
 util/coroutine-ucontext.c | 66 +++++++++++++++++++++++++++++++++------
 2 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 597e909b53..da46f9556e 100755
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
@@ -1754,6 +1759,7 @@ Advanced options (experts only):
   --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
+  --enable-tsan            enable thread sanitizer
   --disable-strip          disable stripping binaries
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
@@ -6196,6 +6202,30 @@ if test "$fuzzing" = "yes" ; then
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
 
@@ -6297,6 +6327,16 @@ if test "$have_asan" = "yes"; then
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
@@ -6332,7 +6372,8 @@ if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
 fi
 
-if test "$solaris" = "no" ; then
+# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
+if test "$solaris" = "no" && test "$tsan" = "no"; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; then
         QEMU_LDFLAGS="-Wl,--warn-common $QEMU_LDFLAGS"
     fi
@@ -7386,6 +7427,10 @@ if test "$have_asan_iface_fiber" = "yes" ; then
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
index bd593e61bc..613f4c118e 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -37,12 +37,19 @@
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
@@ -65,7 +72,18 @@ union cc_arg {
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
+#endif
+}
+
+static inline __attribute__((always_inline))
+void finish_switch_fiber(void *fake_stack_save)
 {
 #ifdef CONFIG_ASAN
     const void *bottom_old;
@@ -78,13 +96,30 @@ static void finish_switch_fiber(void *fake_stack_save)
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
+    __sanitizer_start_switch_fiber(
+            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
+            bottom, size);
+#endif
+#ifdef CONFIG_TSAN
+    void *curr_fiber =
+        __tsan_get_current_fiber();
+    __tsan_acquire(curr_fiber);
+
+    *fake_stack_save = curr_fiber;
+    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=synchronize */
 #endif
 }
 
@@ -104,8 +139,12 @@ static void coroutine_trampoline(int i0, int i1)
 
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
-        start_switch_fiber(&fake_stack_save,
-                           leader.stack, leader.stack_size);
+        start_switch_fiber(
+            COROUTINE_YIELD,
+            &fake_stack_save,
+            leader.stack,
+            leader.stack_size,
+            self->tsan_caller_fiber);
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
 
@@ -154,12 +193,16 @@ Coroutine *qemu_coroutine_new(void)
 
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
 
@@ -216,8 +259,8 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
-        start_switch_fiber(action == COROUTINE_TERMINATE ?
-                           NULL : &fake_stack_save, to->stack, to->stack_size);
+        start_switch_fiber(action, &fake_stack_save,
+                           to->stack, to->stack_size, to->tsan_co_fiber);
         siglongjmp(to->env, action);
     }
 
@@ -231,6 +274,11 @@ Coroutine *qemu_coroutine_self(void)
     if (!current) {
         current = &leader.base;
     }
+#ifdef CONFIG_TSAN
+    if (!leader.tsan_co_fiber) {
+        leader.tsan_co_fiber = __tsan_get_current_fiber();
+    }
+#endif
     return current;
 }
 
-- 
2.17.1


