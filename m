Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9969AC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5779220874
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pi3aTdqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5779220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdB4-0007rR-Kq
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:10:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyW-0006Ym-Rx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyT-0000k8-9Z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYcyP-0000CX-6P
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id r10so2079085otd.4
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=c6s3cz8Azngdshx9nMls9ehZ7rxdcfsNQPzwRD0wABs=;
	b=Pi3aTdqrqeBRGYuhTiHfiPC9dJQoKV2XJ37yN/xweKBwjVEvLlHt442LxzAWbr5mDD
	hHDFdAC+YGK+/sJAOM7ZuQMgz2EyltsxHz2v1//GtT/DI650Hp8gfUKN6NEUHmiGJ8/W
	W3V7UQRZHps8uhZ/6SrC9f3Hw32ugHwDhAOF/hvEWZMi7oczhrN7tzTCEdLKSKRSPv4t
	68am+nU/xhCyOKxRvXzRibHYcDbkVM+6A6GJLdRVU4lKt5iKbLP4AwYbs5UAHLQql/ye
	i2GHYJbqTrzCfK6cT/8Y4Dh/5re747t4ZJP+lspe6bOachDWMFA7Bs2GvyQfGOGF1EOr
	ak3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=c6s3cz8Azngdshx9nMls9ehZ7rxdcfsNQPzwRD0wABs=;
	b=qgr0tgxoJBkztPsjFd70vCT4WYNeFVd0UG2V5cYgQ68HioGCPMpHhFgyI5afbakRXD
	Jk+QMMgebj2uUxWczdni0xwAF5LuBj83IJA4zurAGiY71N4thw5Ls4fTSAY3aVmkwQgy
	hZvK64IBoAVzc2qoF4D5u9nqUUimbcf/0T2FAsGZxccyISmFNCeXN1KIUwcu0W5hEg8R
	voaaGhW22mYMy0KSJGKwd5yTKa80CZNVuF8bS3sFaao4OCCz/k2wx9UgJ3DJliDF3mDc
	VGj4GHIc85cmsNN1LcGaqT5GQkKGLaABCrp8sXmgMEaNOfCu2VrWqHoWdruKtPpsnOxY
	R4fw==
X-Gm-Message-State: APjAAAUn58NsubxSy9N8ssUSOdQRis8SUo2s7WtPq9VwLBtg+eWuE6nM
	tyoaS4zf6CqPKX+ZivQTfp35G616BmjTSA==
X-Google-Smtp-Source: APXvYqwxE8XvdFWNRcxxFqCwbcQEQzs3ZF9tRjHfCGQDr3QLQYMbh/qZEZuWHorRrsJ1j59BdXhVdQ==
X-Received: by 2002:a9d:10c:: with SMTP id 12mr11837547otu.123.1559768241530; 
	Wed, 05 Jun 2019 13:57:21 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id f5sm7414155otl.51.2019.06.05.13.57.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 13:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:57:06 -0500
Message-Id: <20190605205706.569-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605205706.569-1-richard.henderson@linaro.org>
References: <20190605205706.569-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v6 6/6] tests/tcg/aarch64: Add bti smoke test
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will build with older toolchains, without the upstream support
for -mbranch-protection.  Such a toolchain will produce a warning
in such cases,

ld: warning: /tmp/ccyZt0kq.o: unsupported GNU_PROPERTY_TYPE (5) \
type: 0xc0000000

but the still places the note at the correct location in the binary
for processing by the runtime loader.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/bti-1.c         | 77 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   | 69 +++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  3 ++
 3 files changed, 149 insertions(+)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
new file mode 100644
index 0000000000..2aee57ea7a
--- /dev/null
+++ b/tests/tcg/aarch64/bti-1.c
@@ -0,0 +1,77 @@
+/*
+ * Branch target identification, basic notskip cases.
+ */
+
+#include "bti-crt.inc.c"
+
+/*
+ * Work around lack of -mbranch-protection=standard in older toolchains.
+ * The signal handler is invoked by the kernel with PSTATE.BTYPE=2, which
+ * means that the handler must begin with a marker like BTI_C.
+ */
+asm("skip2_sigill1:\n\
+	hint	#34\n\
+	b	skip2_sigill2\n\
+.type skip2_sigill1,%function\n\
+.size skip2_sigill1,8");
+
+extern void skip2_sigill1(int sig, siginfo_t *info, ucontext_t *uc)
+    __attribute__((visibility("hidden")));
+
+static void __attribute__((used))
+skip2_sigill2(int sig, siginfo_t *info, ucontext_t *uc)
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
+    signal_info(SIGILL, skip2_sigill1);
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
diff --git a/tests/tcg/aarch64/bti-crt.inc.c b/tests/tcg/aarch64/bti-crt.inc.c
new file mode 100644
index 0000000000..bb363853de
--- /dev/null
+++ b/tests/tcg/aarch64/bti-crt.inc.c
@@ -0,0 +1,69 @@
+/*
+ * Minimal user-environment for testing BTI.
+ *
+ * Normal libc is not built with BTI support enabled, and so could
+ * generate a BTI TRAP before ever reaching main.
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
+
+/*
+ * Create the PT_NOTE that will enable BTI in the page tables.
+ * This will be created by the compiler with -mbranch-protection=standard,
+ * but as of 2019-03-29, this is has not been committed to gcc mainline.
+ * This will probably be in GCC10.
+ */
+asm(".section .note.gnu.property,\"a\"\n\
+	.align	3\n\
+	.long	4\n\
+        .long	16\n\
+        .long	5\n\
+        .string	\"GNU\"\n\
+	.long	0xc0000000\n\
+	.long	4\n\
+	.long	1\n\
+        .align  3\n\
+	.previous");
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 2bb914975b..21da3bc37f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -18,4 +18,7 @@ run-fcvt: fcvt
 AARCH64_TESTS += pauth-1
 run-pauth-%: QEMU += -cpu max
 
+AARCH64_TESTS += bti-1
+bti-1: LDFLAGS += -nostartfiles -nodefaultlibs -nostdlib
+
 TESTS:=$(AARCH64_TESTS)
-- 
2.17.1


