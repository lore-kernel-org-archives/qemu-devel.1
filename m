Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81144C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBA12075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANYlbfUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBA12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43119 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTuev-0001Lz-EF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:49:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZr-00064W-FQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZp-000362-Is
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:39 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:42415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZp-00030k-63
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:37 -0400
Received: by mail-yw1-xc43.google.com with SMTP id s5so2780904ywd.9
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=aODOLM3NOnu56JKijoWk061uBitwLRabA4Po4UrCVRU=;
	b=ANYlbfUEWYQgbUCsFIcX4Vh0BrMTTf6WphjMjJN52U3v9s6w/PJWKYLBcQiO5Bm5W2
	NpqH926IMiFjk0X0PcnaPktGVmbG1rb2IfFwdvyqV8AO4ax8CQVB169bjRdZQIsT5hD+
	e1A3VrTwlk7EAwy3KiEUwuRFkpjYXtIx4Ni+7ahXR0uoiy34sbvElMcq1IgXEhUVNDz/
	AskDVebsvEKcoBgbPO1VnsDwpmeqom/Jf1snlCmniADJgWC5NWes/IvNwy7qaW70Z6kd
	ditWTi15IyMwD481VTqUGPMNyvWU4joFxMzDzlk9jBObITDCJK/3pTYaOtAPdYBECMNQ
	0q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aODOLM3NOnu56JKijoWk061uBitwLRabA4Po4UrCVRU=;
	b=YoQylO7HEKtWHWg/f0gbkgsuTxruvfLzCZL9Ho8SjUI5ZpU5hKPKsf07Olt3hmNW+Z
	q4miN0jCNhbHRqJtO48sxazlbHVsVx3VUOO7w95xdu2kx2lnC9iJ95Luxrq+AYaN1v8X
	ibK/Zig6CUZvom/RlqIojMyJddKNRublBikAYlvoRGML3IZkK8Bxx3wwB2Gi7nxHv0ps
	+K1J9tglq+N+/i3A5mpQIC/bTLXBNKtdMzc3VvBY4EOu6fa4h/k6enN4DYvkaArwl8rq
	7cYymGVWFLuvYcg3gsyjARj8UHl2pGsBNmx/Mxw+thhOuBH71YfkgrXEZ5AUu8m39g4w
	+u5Q==
X-Gm-Message-State: APjAAAVpuOnFp+aPngCVNWFNreXsjYPRPjadE+rYuYoBdtxO9EV3UoV2
	Tyoc80waJ0DkHbEmnxAg/PNLsd50
X-Google-Smtp-Source: APXvYqwepg/w0SlHOAzbaYRP7cp+qwxdpnJxMAUq5QgI849Y+p2gN0l9cHTALhkeOxP4jZFhYv9G8g==
X-Received: by 2002:a0d:db91:: with SMTP id
	d139mr25144807ywe.300.1558644272326; 
	Thu, 23 May 2019 13:44:32 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:31 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:02 -0400
Message-Id: <20190523204409.21068-5-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RISU v3 04/11] risu_reginfo_i386: implement
 arch-specific reginfo interface
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU-specific code in risu_reginfo_* is expected to define and export
the following symbols:

- arch_long_opts, arch_extra_help, process_arch_opt
- reginfo_size
- reginfo_init
- reginfo_is_eq
- reginfo_dump, reginfo_dump_mismatch

Make risu_reginfo_i386.c implement this interface; and while we're at
it, expand the support to x86_64 as well.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.h |  24 ++++----
 risu_reginfo_i386.c | 147 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 127 insertions(+), 44 deletions(-)

diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
index 5bba439..e350f01 100644
--- a/risu_reginfo_i386.h
+++ b/risu_reginfo_i386.h
@@ -12,7 +12,8 @@
 #ifndef RISU_REGINFO_I386_H
 #define RISU_REGINFO_I386_H
 
-/* This is the data structure we pass over the socket.
+/*
+ * This is the data structure we pass over the socket.
  * It is a simplified and reduced subset of what can
  * be obtained with a ucontext_t*
  */
@@ -21,17 +22,14 @@ struct reginfo {
     gregset_t gregs;
 };
 
-#ifndef REG_GS
-/* Assume that either we get all these defines or none */
-#   define REG_GS      0
-#   define REG_FS      1
-#   define REG_ES      2
-#   define REG_DS      3
-#   define REG_ESP     7
-#   define REG_TRAPNO 12
-#   define REG_EIP    14
-#   define REG_EFL    16
-#   define REG_UESP   17
-#endif /* !defined(REG_GS) */
+/*
+ * For i386, the defines are named REG_EAX, etc.
+ * For x86_64, the defines are named REG_RAX, etc.
+ */
+#ifdef __x86_64__
+# define REG_E(X)   REG_R##X
+#else
+# define REG_E(X)   REG_E##X
+#endif
 
 #endif /* RISU_REGINFO_I386_H */
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index e8d671f..c4dc14a 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -10,59 +10,144 @@
  ******************************************************************************/
 
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <ucontext.h>
+#include <assert.h>
 
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
+const struct option * const arch_long_opts;
+const char * const arch_extra_help;
+
+void process_arch_opt(int opt, const char *arg)
+{
+    abort();
+}
+
+const int reginfo_size(void)
+{
+    return sizeof(struct reginfo);
+}
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
     int i;
+
+    memset(ri, 0, sizeof(*ri));
+
     for (i = 0; i < NGREG; i++) {
         switch (i) {
-        case REG_ESP:
-        case REG_UESP:
-        case REG_GS:
-        case REG_FS:
-        case REG_ES:
-        case REG_DS:
-        case REG_TRAPNO:
-        case REG_EFL:
-            /* Don't store these registers as it results in mismatches.
-             * In particular valgrind has different values for some
-             * segment registers, and they're boring anyway.
-             * We really shouldn't be ignoring EFL but valgrind doesn't
-             * seem to set it right and I don't care to investigate.
-             */
-            ri->gregs[i] = 0xDEADBEEF;
-            break;
-        case REG_EIP:
-            /* Store the offset from the start of the test image */
+        case REG_E(IP):
+            /* Store the offset from the start of the test image.  */
             ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
             break;
-        default:
+        case REG_EFL:
+            /* Store only the "flaggy" bits: SF, ZF, AF, PF, CF.  */
+            ri->gregs[i] = uc->uc_mcontext.gregs[i] & 0xd5;
+            break;
+        case REG_E(SP):
+            /* Ignore the stack.  */
+            ri->gregs[i] = 0xdeadbeef;
+            break;
+        case REG_E(AX):
+        case REG_E(BX):
+        case REG_E(CX):
+        case REG_E(DX):
+        case REG_E(DI):
+        case REG_E(SI):
+        case REG_E(BP):
+#ifdef __x86_64__
+        case REG_R8:
+        case REG_R9:
+        case REG_R10:
+        case REG_R11:
+        case REG_R12:
+        case REG_R13:
+        case REG_R14:
+        case REG_R15:
+#endif
             ri->gregs[i] = uc->uc_mcontext.gregs[i];
             break;
         }
     }
-    /* x86 insns aren't 32 bit but we're not really testing x86 so
-     * this is just to distinguish 'do compare' from 'stop'
+
+    /*
+     * x86 insns aren't 32 bit but 3 bytes are sufficient to
+     * distinguish 'do compare' from 'stop'.
      */
-    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
+    ri->faulting_insn = *(uint32_t *)uc->uc_mcontext.gregs[REG_E(IP)];
 }
 
-static char *regname[] = {
-    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
-    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-    "CS", "EFL", "UESP", "SS", 0
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+{
+    return 0 == memcmp(m, a, sizeof(*m));
+}
+
+static const char *const regname[NGREG] = {
+    [REG_EFL] = "eflags",
+#ifdef __x86_64__
+    [REG_RIP] = "rip",
+    [REG_RAX] = "rax",
+    [REG_RBX] = "rbx",
+    [REG_RCX] = "rcx",
+    [REG_RDX] = "rdx",
+    [REG_RDI] = "rdi",
+    [REG_RSI] = "rsi",
+    [REG_RBP] = "rbp",
+    [REG_RSP] = "rsp",
+    [REG_R8]  = "r8",
+    [REG_R9]  = "r9",
+    [REG_R10] = "r10",
+    [REG_R11] = "r11",
+    [REG_R12] = "r12",
+    [REG_R13] = "r13",
+    [REG_R14] = "r14",
+    [REG_R15] = "r15",
+#else
+    [REG_EIP] = "eip",
+    [REG_EAX] = "eax",
+    [REG_EBX] = "ebx",
+    [REG_ECX] = "ecx",
+    [REG_EDX] = "edx",
+    [REG_EDI] = "edi",
+    [REG_ESI] = "esi",
+    [REG_EBP] = "ebp",
+    [REG_ESP] = "esp",
+#endif
 };
 
-static void dump_reginfo(struct reginfo *ri)
+#ifdef __x86_64__
+# define PRIxREG   "%016llx"
+#else
+# define PRIxREG   "%08x"
+#endif
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
-    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
     for (i = 0; i < NGREG; i++) {
-        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
-                ri->gregs[i]);
+        if (regname[i]) {
+            fprintf(f, "  %-6s: " PRIxREG "\n", regname[i], ri->gregs[i]);
+        }
     }
+    return !ferror(f);
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        if (m->gregs[i] != a->gregs[i]) {
+            assert(regname[i]);
+            fprintf(f, "Mismatch: %s: " PRIxREG " v " PRIxREG "\n",
+                    regname[i], m->gregs[i], a->gregs[i]);
+        }
+    }
+    return !ferror(f);
 }
-- 
2.20.1


