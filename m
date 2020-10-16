Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA65C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 19:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA26E20EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yS2Jo41y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA26E20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUzy-0000iy-JJ
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 15:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgi-0000gS-Hj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgR-0002Bn-OS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id o9so1739478plx.10
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sxotxj6XB7hzF7JenULfKlm4NqUCIgIUU5zaZ0WIWOQ=;
 b=yS2Jo41yV7EhlVhdqVxZ7EAubOw+rSsvov7dgPhqj481h70lP3dpb/mZwDCYW0hkP+
 ZL3qx/vEyAcBsrtUOBNsbchYradWQl0z5ejy5foaLM9HNmPay7A7lmQ5gRAJH4/dbrrR
 9CETd+4kfnNmFvMkM9bKqHcv9w19m5mdDAae/INUg2eqRjVHv2DCQ+Gskw1i+n0zZ470
 zaQCZ3W3Uu3eNySOLxDtS0PVRaSIQK45Ipcfmhs0Y5Z4A46s2DHEo7oIoApyqlQR3ALr
 Miw2jmcnQNFqjxo2A10TC+7dEZyyFsD78fuCBrzx62kMYNszMK1clGhI4LCs0Gc87/os
 Iv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sxotxj6XB7hzF7JenULfKlm4NqUCIgIUU5zaZ0WIWOQ=;
 b=Ae3cSJf39lp48L7pJAUP4rh09JMnbHPc7w17JeqiQD8unvaW6/DEuykb9dZjEy2oZU
 DEmMJ7AbGZgHWfxr58N1wQ0XJyQF8uqOy2txV3x/36GFiaR/bzd8Y6P8JcMQOkX9NKY4
 jA3heOtn5Ph7wCcO25lgoldIkmYUTzQ2IlLLMd88YQPd1+chiaPOC3E0Vrx9yy1+VCPo
 WzPr4kiALonWcwSJLpTIrnS/BviSXj6MBn1Ki90+zZRsvgwfWLkgCthPf/hoNeV498B9
 0onKbkVrI3TOg2LJLun1stsFZutIsvkCI3GhjsM0OQOPARTulKKUx/2oFgYJSD/KC6KE
 g1tg==
X-Gm-Message-State: AOAM532LEdZI0e2Q+Zu/WT0Mlm/CE9h8nwRaJmkmeohM2zS4/HMhuwPY
 7DmL2dCspqFpFJ67j712l+wXvbKNKLCaWA==
X-Google-Smtp-Source: ABdhPJzOnl5cpuWrA60i+NFXVU8zxCowjszm0rvCnuT52zUSguaWhUnTZN9+wwM+rH/Hmbd5zj2RZQ==
X-Received: by 2002:a17:90a:be11:: with SMTP id
 a17mr5136520pjs.181.1602873748439; 
 Fri, 16 Oct 2020 11:42:28 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 12/12] tests/tcg/aarch64: Add bti smoke tests
Date: Fri, 16 Oct 2020 11:42:07 -0700
Message-Id: <20201016184207.786698-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The note test requires gcc 10 for -mbranch-protection=standard.
The mmap test uses PROT_BTI and does not require special compiler support.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Expect and require gcc 10.
v11: Squash mmap smoke test.
---
 tests/tcg/aarch64/bti-1.c         |  62 +++++++++++++++++
 tests/tcg/aarch64/bti-2.c         | 108 ++++++++++++++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 ++++++++++++++
 tests/tcg/aarch64/Makefile.target |  10 +++
 tests/tcg/configure.sh            |   4 ++
 5 files changed, 235 insertions(+)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-2.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
new file mode 100644
index 0000000000..61924f0d7a
--- /dev/null
+++ b/tests/tcg/aarch64/bti-1.c
@@ -0,0 +1,62 @@
+/*
+ * Branch target identification, basic notskip cases.
+ */
+
+#include "bti-crt.inc.c"
+
+static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
+{
+    uc->uc_mcontext.pc += 8;
+    uc->uc_mcontext.pstate = 1;
+}
+
+#define NOP       "nop"
+#define BTI_N     "hint #32"
+#define BTI_C     "hint #34"
+#define BTI_J     "hint #36"
+#define BTI_JC    "hint #38"
+
+#define BTYPE_1(DEST) \
+    asm("mov %0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %0,#0" \
+        : "=r"(skipped) : : "x16")
+
+#define BTYPE_2(DEST) \
+    asm("mov %0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %0,#0" \
+        : "=r"(skipped) : : "x16", "x30")
+
+#define BTYPE_3(DEST) \
+    asm("mov %0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %0,#0" \
+        : "=r"(skipped) : : "x15")
+
+#define TEST(WHICH, DEST, EXPECT) \
+    do { WHICH(DEST); fail += skipped ^ EXPECT; } while (0)
+
+
+int main()
+{
+    int fail = 0;
+    int skipped;
+
+    /* Signal-like with SA_SIGINFO.  */
+    signal_info(SIGILL, skip2_sigill);
+
+    TEST(BTYPE_1, NOP, 1);
+    TEST(BTYPE_1, BTI_N, 1);
+    TEST(BTYPE_1, BTI_C, 0);
+    TEST(BTYPE_1, BTI_J, 0);
+    TEST(BTYPE_1, BTI_JC, 0);
+
+    TEST(BTYPE_2, NOP, 1);
+    TEST(BTYPE_2, BTI_N, 1);
+    TEST(BTYPE_2, BTI_C, 0);
+    TEST(BTYPE_2, BTI_J, 1);
+    TEST(BTYPE_2, BTI_JC, 0);
+
+    TEST(BTYPE_3, NOP, 1);
+    TEST(BTYPE_3, BTI_N, 1);
+    TEST(BTYPE_3, BTI_C, 1);
+    TEST(BTYPE_3, BTI_J, 0);
+    TEST(BTYPE_3, BTI_JC, 0);
+
+    return fail;
+}
diff --git a/tests/tcg/aarch64/bti-2.c b/tests/tcg/aarch64/bti-2.c
new file mode 100644
index 0000000000..6dc8908b5a
--- /dev/null
+++ b/tests/tcg/aarch64/bti-2.c
@@ -0,0 +1,108 @@
+/*
+ * Branch target identification, basic notskip cases.
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#ifndef PROT_BTI
+#define PROT_BTI  0x10
+#endif
+
+static void skip2_sigill(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.pc += 8;
+    uc->uc_mcontext.pstate = 1;
+}
+
+#define NOP       "nop"
+#define BTI_N     "hint #32"
+#define BTI_C     "hint #34"
+#define BTI_J     "hint #36"
+#define BTI_JC    "hint #38"
+
+#define BTYPE_1(DEST)    \
+    "mov x1, #1\n\t"     \
+    "adr x16, 1f\n\t"    \
+    "br x16\n"           \
+"1: " DEST "\n\t"        \
+    "mov x1, #0"
+
+#define BTYPE_2(DEST)    \
+    "mov x1, #1\n\t"     \
+    "adr x16, 1f\n\t"    \
+    "blr x16\n"          \
+"1: " DEST "\n\t"        \
+    "mov x1, #0"
+
+#define BTYPE_3(DEST)    \
+    "mov x1, #1\n\t"     \
+    "adr x15, 1f\n\t"    \
+    "br x15\n"           \
+"1: " DEST "\n\t"        \
+    "mov x1, #0"
+
+#define TEST(WHICH, DEST, EXPECT) \
+    WHICH(DEST) "\n"              \
+    ".if " #EXPECT "\n\t"         \
+    "eor x1, x1," #EXPECT "\n"    \
+    ".endif\n\t"                  \
+    "add x0, x0, x1\n\t"
+
+extern char test_begin[], test_end[];
+
+asm("\n"
+"test_begin:\n\t"
+    BTI_C "\n\t"
+    "mov x2, x30\n\t"
+    "mov x0, #0\n\t"
+
+    TEST(BTYPE_1, NOP, 1)
+    TEST(BTYPE_1, BTI_N, 1)
+    TEST(BTYPE_1, BTI_C, 0)
+    TEST(BTYPE_1, BTI_J, 0)
+    TEST(BTYPE_1, BTI_JC, 0)
+
+    TEST(BTYPE_2, NOP, 1)
+    TEST(BTYPE_2, BTI_N, 1)
+    TEST(BTYPE_2, BTI_C, 0)
+    TEST(BTYPE_2, BTI_J, 1)
+    TEST(BTYPE_2, BTI_JC, 0)
+
+    TEST(BTYPE_3, NOP, 1)
+    TEST(BTYPE_3, BTI_N, 1)
+    TEST(BTYPE_3, BTI_C, 1)
+    TEST(BTYPE_3, BTI_J, 0)
+    TEST(BTYPE_3, BTI_JC, 0)
+
+    "ret x2\n"
+"test_end:"
+);
+
+int main()
+{
+    struct sigaction sa;
+
+    void *p = mmap(0, getpagesize(),
+                   PROT_EXEC | PROT_READ | PROT_WRITE | PROT_BTI,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (p == MAP_FAILED) {
+        perror("mmap");
+        return 1;
+    }
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = skip2_sigill;
+    sa.sa_flags = SA_SIGINFO;
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        return 1;
+    }
+
+    memcpy(p, test_begin, test_end - test_begin);
+    return ((int (*)(void))p)();
+}
diff --git a/tests/tcg/aarch64/bti-crt.inc.c b/tests/tcg/aarch64/bti-crt.inc.c
new file mode 100644
index 0000000000..47805f4e35
--- /dev/null
+++ b/tests/tcg/aarch64/bti-crt.inc.c
@@ -0,0 +1,51 @@
+/*
+ * Minimal user-environment for testing BTI.
+ *
+ * Normal libc is not (yet) built with BTI support enabled,
+ * and so could generate a BTI TRAP before ever reaching main.
+ */
+
+#include <stdlib.h>
+#include <signal.h>
+#include <ucontext.h>
+#include <asm/unistd.h>
+
+int main(void);
+
+void _start(void)
+{
+    exit(main());
+}
+
+void exit(int ret)
+{
+    register int x0 __asm__("x0") = ret;
+    register int x8 __asm__("x8") = __NR_exit;
+
+    asm volatile("svc #0" : : "r"(x0), "r"(x8));
+    __builtin_unreachable();
+}
+
+/*
+ * Irritatingly, the user API struct sigaction does not match the
+ * kernel API struct sigaction.  So for simplicity, isolate the
+ * kernel ABI here, and make this act like signal.
+ */
+void signal_info(int sig, void (*fn)(int, siginfo_t *, ucontext_t *))
+{
+    struct kernel_sigaction {
+        void (*handler)(int, siginfo_t *, ucontext_t *);
+        unsigned long flags;
+        unsigned long restorer;
+        unsigned long mask;
+    } sa = { fn, SA_SIGINFO, 0, 0 };
+
+    register int x0 __asm__("x0") = sig;
+    register void *x1 __asm__("x1") = &sa;
+    register void *x2 __asm__("x2") = 0;
+    register int x3 __asm__("x3") = sizeof(unsigned long);
+    register int x8 __asm__("x8") = __NR_rt_sigaction;
+
+    asm volatile("svc #0"
+                 : : "r"(x0), "r"(x1), "r"(x2), "r"(x3), "r"(x8) : "memory");
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index e7249915e7..d7d33e293c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -25,6 +25,16 @@ run-pauth-%: QEMU_OPTS += -cpu max
 run-plugin-pauth-%: QEMU_OPTS += -cpu max
 endif
 
+# BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_BTI),)
+AARCH64_TESTS += bti-1
+bti-1: CFLAGS += -mbranch-protection=standard
+bti-1: LDFLAGS += -nostdlib
+endif
+# bti-2 tests PROT_BTI, so no special compiler support required.
+AARCH64_TESTS += bti-2
+
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
 run-semihosting: semihosting
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index be51bdb5a4..e1b70e25f2 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -240,6 +240,10 @@ for target in $target_list; do
                -march=armv8.3-a -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
             fi
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -mbranch-protection=standard -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_ARMV8_BTI=y" >> $config_target_mak
+            fi
         ;;
     esac
 
-- 
2.25.1


