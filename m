Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE87C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAE520796
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqRcutZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAE520796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqib-0001nl-0K
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPqhO-0000qA-8z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:24:27 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:44348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPqhL-0006CL-KM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:24:25 -0400
Received: by mail-ej1-x629.google.com with SMTP id a3so18765210ejy.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ERee18FoTL0JMAd5NEQQsgDqJQ9rx0tJzGkfHm/LdgI=;
 b=xqRcutZD2orO5tu3bOZ+46W0sEzNpHj8u3EtWAvmUvYLtnmi1KhQXfy4dkLJrt2tz2
 BLh02lwqFk/noYcEjKrn0UC62GUc/pd9vm4Y6cypBrIiUynPWqHfR0gYDyyCPbk6FiPw
 XMdRrCQwLpMRIL3GTjfs6v+9R7tFeaoJpYsNqE/IihpfBMGNqy4jKoJKoNrrzDVIXRhE
 O6KeL+m+GnQgyZ6BxjePVHw8LBPR5cF2BnNkNTZM1rpeG8XuI2kJYfYg1KNYok+ocR7q
 CBavTdOmZfx9Blno8jszvaUFIarVcqLgaOHVqmIKME868CKGowCVyeIBKQh2WmZjp2dI
 s66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ERee18FoTL0JMAd5NEQQsgDqJQ9rx0tJzGkfHm/LdgI=;
 b=M1fgpQS1pZQCLHixxXRB2CwC5e90qpVb8+jdAdNJExhygYSY/VbOzaTI3ER0nJuNMW
 qDQkeWrEPWNSbE7PyWTMg3XwshBrh5wn4fGjo6MvfTjJJVCLvP0dp/D7S6Tt6uLhk+Ut
 Uv6IpvJPCNydLaTKGs1fQU+eEx324Zn/cYKZP3B2nU6VxqKK9tQMnSRKBFKw9qoOM5Si
 TP3nGHmGmpa/yaREQrtX+vsuDz2A5BAoE+bWgbeL0hQGd37EpaYQzJgOFi5k2/9yaGe2
 r9fJslG/J0BaF7FLHer0xaPdeHN/sdlsr3ElubCV84UCXoj4j9i+eN+Dxokvtrr3saUy
 FLBg==
X-Gm-Message-State: AOAM5330wmUlJ9AOZKyAwJ8vosbUZzQYKEqbZ2Rns7XW8qKSMgYY5VE6
 W8hMUpP2b99HlYU8+E7zQWk+779haa9k/ZGL
X-Google-Smtp-Source: ABdhPJxinL6to301GIvzEhZY+fHkEo+LIkLCEDHs8zyvRlaFm/WEqjSqS6iP19/5fyZKLyb0qPNgvg==
X-Received: by 2002:a17:906:f14b:: with SMTP id
 gw11mr610720ejb.41.1602005061639; 
 Tue, 06 Oct 2020 10:24:21 -0700 (PDT)
Received: from localhost.localdomain ([185.81.136.21])
 by smtp.gmail.com with ESMTPSA id a22sm2536968ejs.25.2020.10.06.10.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 10:24:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] tests/tcg/aarch64: Add bti mmap smoke test
Date: Tue,  6 Oct 2020 12:23:59 -0500
Message-Id: <20201006172359.2998-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006172359.2998-1-richard.henderson@linaro.org>
References: <20201006172359.2998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests PROT_BTI, and also does not require special
compiler support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/bti-2.c         | 108 ++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |   7 +-
 2 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-2.c

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
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 491683e91d..d7d33e293c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -26,11 +26,14 @@ run-plugin-pauth-%: QEMU_OPTS += -cpu max
 endif
 
 # BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_BTI),)
 AARCH64_TESTS += bti-1
-bti-%: CFLAGS += -mbranch-protection=standard
-bti-%: LDFLAGS += -nostdlib
+bti-1: CFLAGS += -mbranch-protection=standard
+bti-1: LDFLAGS += -nostdlib
 endif
+# bti-2 tests PROT_BTI, so no special compiler support required.
+AARCH64_TESTS += bti-2
 
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
-- 
2.25.1


