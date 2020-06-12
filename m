Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6118DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5F820792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7Dioscg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5F820792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp26-0000x0-Fc
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox7-0000q7-QJ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37917)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox5-0006sq-JH
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so10830804wrt.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QbPd3c5nq0iqQGGp+VQI0AU24TYH55OhmLcysF1VGuo=;
 b=g7Dioscget7717CInBFzsAqoBMsuDd445fJOwF9Z+TwxG7GLpopbFDw39YOj4aYRnD
 eDKd8qMKfpFKZRKetm1LFCmhYiuAhvPeh0o2BsJEsKOZGELnaMxcvexG5BtmAuSTtmNc
 +mNut2g1w3ecWQJGyPPXwzTLGhrsMKlOG+5Bj8GFf8nSyoLBRstKhPtXp8krh7J0HlMJ
 yRtCw5aonGQGcD+CJKV5edVgv7ypyEevYbGBhJrc3Cmy7HKVmlRoCMiRFNoL1tmya33C
 aeu5jzowTOPj6o6DbHyIj+GM0R96w1LQmeLaaje3pZcbdyZwAEfOo6ns466lIMSmLAio
 u6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QbPd3c5nq0iqQGGp+VQI0AU24TYH55OhmLcysF1VGuo=;
 b=AjpFlc+La0G7cvs5xjRpD1u4ZjzAsin0LP7VFaffwdMVRovEezpWZ3FO5wPqeeJeRl
 yY5SIE3bSKqutHH0ots6DcUPoImeFkgojqXGbqjZQlvBTNAt3IXNCVQTeNThJlcnH4JL
 m3Qb1nSVhJ/ZHQsN8O3Wg7d6Abt5sEk/msZz/2TX+Q7E2ySBg236r7rqTUANCipy3TcV
 HJzx8q5csbm/5CzLfPhNCmXVpNznU9uhIlZIJ9VwjZtB1MtCUaa+kPmRxxfU115g0pfj
 jy+1fWQ5p6YNnfEiFa1gKSDj7ek44OtUJK0J6gcb0LyNdI8oqqJTpHmDSq4b2o1bP1MZ
 /aow==
X-Gm-Message-State: AOAM533psYlSgTXXPzhuBj4CqSMrICBZjoEzllPug7qDmOfPUr7fZb5U
 N7cntj4FiidRvzJavoOimSAnDg==
X-Google-Smtp-Source: ABdhPJxHQddljtycKOMyhgk2Zp01quys3q6t5Zc9LofsNdR7C5IfSOjZqEY7su5z9AII+41jgzMPyA==
X-Received: by 2002:a05:600c:4152:: with SMTP id
 h18mr332272wmm.189.1591988566352; 
 Fri, 12 Jun 2020 12:02:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h27sm13313085wrb.18.2020.06.12.12.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86E2A1FF90;
 Fri, 12 Jun 2020 20:02:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/18] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
Date: Fri, 12 Jun 2020 20:02:23 +0100
Message-Id: <20200612190237.30436-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Lingfeng Yang <lfy@google.com>,
 aurelien@aurel32.net
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-2-robert.foley@linaro.org>
---
 configure                 | 47 +++++++++++++++++++++++++++-
 util/coroutine-ucontext.c | 66 +++++++++++++++++++++++++++++++++------
 2 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index af5d7aa57a1..860f4c63647 100755
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
@@ -6195,6 +6201,30 @@ if test "$fuzzing" = "yes" ; then
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
 
@@ -6296,6 +6326,16 @@ if test "$have_asan" = "yes"; then
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
@@ -6331,7 +6371,8 @@ if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
 fi
 
-if test "$solaris" = "no" ; then
+# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
+if test "$solaris" = "no" && test "$tsan" = "no"; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; then
         QEMU_LDFLAGS="-Wl,--warn-common $QEMU_LDFLAGS"
     fi
@@ -7385,6 +7426,10 @@ if test "$have_asan_iface_fiber" = "yes" ; then
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
index bd593e61bc0..613f4c118e4 100644
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
2.20.1


