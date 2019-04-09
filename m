Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E4320880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kx3mSlLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E4320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDkez-0002FZ-0F
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 02:55:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDke7-0001v1-4x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDke5-0006Yh-Jb
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:54:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDke3-0006Y0-Iz
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:54:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id y6so8811849plt.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=S1EBn4hKibcFEvpxL87Lv7mgvrflcvS1lusFDrd7ffc=;
	b=kx3mSlLTHOOsdu8QmqMCBctPL4DNYT6IGyPwaXojX/+/yHfwYb6C/AeNJmyZOuwdiu
	zPg9BnYMZzl4RPARMILzb3kyN6Nlzf9v94XfuXJvJQyIaqIzX9hJlDcQaRLBPQQ4KBpp
	JHywQdIZhQFkfvN/Z0qHcfKXkKLrOSrKLnUg23mG5PRTThry5kwGuFM/uWau8skxVm1H
	/ghB5GEVc0Ryw6WHJJdUzqihn/fjjeUu3htK7Mkzycwo7MBo5MeHO4dkle0kwjAUHK5b
	pA1UaDo2he6Hq72OQ9m+g83aveqKQrj88avdk0gyFMf6FlfsJ2AFdREBetWQroD1hX0X
	W6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=S1EBn4hKibcFEvpxL87Lv7mgvrflcvS1lusFDrd7ffc=;
	b=MF04CJp4Rm4BEKu5R/bOdLhpY/NJW8jJhIwMW9dhjliqRftAOXe2I50eE8Xe5HzFU2
	UB40UyhhAgbxyj0MRfGMKUuGMcuajbW9RijDsPhfRCQ3VIr2OrcnQUSr9wYSCeQzitUR
	E8DoeRyk0ppVusaCKmVqL5t/htO/en2xbjOtp9bl++WxXuXsiC8I5+x/rOuiQy+gc+b5
	ZD1aZD5L0BIrXkYpshHN/jfp1pM6AacxUkWe5aCq+kiOmUKpgh1sM6cmu3rQpABZjJ2b
	ba+w1GiYt+VjsJXW94TngslxCIie82DfkWP78NGR1N2rnyFkSkfvx63O7cJNAVmMd1e7
	S2gw==
X-Gm-Message-State: APjAAAVilzfckwtbdXWy1/EsFxDlf+HSkez9NADefPwruKH4jMvJu6s2
	vMQvwPBMECm1HCtNFDTVAS8jhbA0hBE=
X-Google-Smtp-Source: APXvYqziVXj+0xXOiaOFK5HXsuALVlrP5e1voUOv9zkUO7VYPvLWnlmUbafrkMo9M2CA3PzdBdAUCA==
X-Received: by 2002:a17:902:e407:: with SMTP id
	ci7mr34908069plb.219.1554792848523; 
	Mon, 08 Apr 2019 23:54:08 -0700 (PDT)
Received: from localhost.localdomain (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	f71sm39983962pfc.109.2019.04.08.23.54.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 23:54:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 20:54:04 -1000
Message-Id: <20190409065404.9853-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [RISU v2] i386: Add avx512 state to reginfo_t
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
Cc: jan.bobek@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409065404.76jwUQnkzMMEhzprIxkR7bB8-WwHBp8Uoa0SieM2yhs@z>

The state expected for a given test must be specifically requested
with the --xfeatures=mask command-line argument.  This is recorded
with the saved state so that it is obvious if the apprentice is given
a different argument.  Any features beyond what are present on the
running cpu will read as zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

More fiddling.  This puts an --xfeature=mask argument on the command
line that must agree the test case being tested.  This requires somewhat
deeper knowledge of the cpu than I would otherwise like, but I cannot
disconnect this knowledge with that required for writing the test in
the first place.

Usual values for mask are 3 (SSE), 7 (AVX), 0xe7 (AVX512), and well
documented in the "Managing state using the XSAVE feature set"
chapter of the Intel architecture manual.

Thoughts?


r~

---
 risu_reginfo_i386.h |  14 +++
 risu_reginfo_i386.c | 228 ++++++++++++++++++++++++++++++++++++++++++--
 test_i386.S         |  39 ++++++++
 3 files changed, 273 insertions(+), 8 deletions(-)

diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
index 755283a..c838b68 100644
--- a/risu_reginfo_i386.h
+++ b/risu_reginfo_i386.h
@@ -12,6 +12,10 @@
 #ifndef RISU_REGINFO_I386_H
 #define RISU_REGINFO_I386_H
 
+struct avx512_reg {
+    uint64_t q[8];
+};
+
 /*
  * This is the data structure we pass over the socket.
  * It is a simplified and reduced subset of what can
@@ -19,7 +23,17 @@
  */
 struct reginfo {
     uint32_t faulting_insn;
+    uint32_t mxcsr;
+    uint64_t xfeatures;
+
     gregset_t gregs;
+
+#ifdef __x86_64__
+    struct avx512_reg vregs[32];
+#else
+    struct avx512_reg vregs[8];
+#endif
+    uint64_t kregs[8];
 };
 
 /*
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index c4dc14a..35ff7c8 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -11,19 +11,32 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <ucontext.h>
 #include <assert.h>
+#include <cpuid.h>
 
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-const struct option * const arch_long_opts;
-const char * const arch_extra_help;
+#include <asm/sigcontext.h>
+
+static uint64_t xfeatures = 3;  /* SSE */
+
+static const struct option extra_ops[] = {
+    {"xfeatures", required_argument, NULL, FIRST_ARCH_OPT },
+    {0, 0, 0, 0}
+};
+
+const struct option * const arch_long_opts = extra_ops;
+const char * const arch_extra_help
+    = "  --xfeatures=<mask>  Use features in mask for XSAVE\n";
 
 void process_arch_opt(int opt, const char *arg)
 {
-    abort();
+    assert(opt == FIRST_ARCH_OPT);
+    xfeatures = strtoull(arg, 0, 0);
 }
 
 const int reginfo_size(void)
@@ -31,13 +44,37 @@ const int reginfo_size(void)
     return sizeof(struct reginfo);
 }
 
+static void *xsave_feature_buf(struct _xstate *xs, int feature)
+{
+    unsigned int eax, ebx, ecx, edx;
+    int ok;
+
+    /*
+     * Get the location of the XSAVE feature from the cpuid leaf.
+     * Given that we know the xfeature bit is set, this must succeed.
+     */
+    ok = __get_cpuid_count(0xd, feature, &eax, &ebx, &ecx, &edx);
+    assert(ok);
+
+    /* Sanity check that the frame stored by the kernel contains the data. */
+    assert(xs->fpstate.sw_reserved.extended_size >= eax + ebx);
+
+    return (void *)xs + ebx;
+}
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
-    int i;
+    int i, nvecregs;
+    struct _fpstate *fp;
+    struct _xstate *xs;
+    uint64_t features;
 
     memset(ri, 0, sizeof(*ri));
 
+    /* Require master and apprentice to be given the same arguments.  */
+    ri->xfeatures = xfeatures;
+
     for (i = 0; i < NGREG; i++) {
         switch (i) {
         case REG_E(IP):
@@ -79,12 +116,89 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
      * distinguish 'do compare' from 'stop'.
      */
     ri->faulting_insn = *(uint32_t *)uc->uc_mcontext.gregs[REG_E(IP)];
+
+    /*
+     * FP state is omitted if unused (aka in init state).
+     * Use the <asm/sigcontext.h> struct for access to AVX state.
+     */
+
+    fp = (struct _fpstate *)uc->uc_mcontext.fpregs;
+    if (fp == NULL) {
+        return;
+    }
+
+#ifdef __x86_64__
+    nvecregs = 16;
+#else
+    /* We don't (currently) care about the 80387 state, only SSE+.  */
+    if (fp->magic != X86_FXSR_MAGIC) {
+        return;
+    }
+    nvecregs = 8;
+#endif
+
+    /*
+     * Now we know that _fpstate contains FXSAVE data.
+     */
+    ri->mxcsr = fp->mxcsr;
+
+    for (i = 0; i < nvecregs; ++i) {
+#ifdef __x86_64__
+        memcpy(&ri->vregs[i], &fp->xmm_space[i], 16);
+#else
+        memcpy(&ri->vregs[i], &fp->_xmm[i * 4], 16);
+#endif
+    }
+
+    if (fp->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+        return;
+    }
+    xs = (struct _xstate *)fp;
+    features = xfeatures & xs->xstate_hdr.xfeatures;
+
+    /*
+     * Now we know that _fpstate contains XSAVE data.
+     */
+
+    if (features & (1 << 2)) {
+        /* YMM_Hi128 state */
+        void *buf = xsave_feature_buf(xs, 2);
+        for (i = 0; i < nvecregs; ++i) {
+            memcpy(&ri->vregs[i].q[2], buf + 16 * i, 16);
+        }
+    }
+
+    if (features & (1 << 5)) {
+        /* Opmask state */
+        uint64_t *buf = xsave_feature_buf(xs, 5);
+        for (i = 0; i < 8; ++i) {
+            ri->kregs[i] = buf[i];
+        }
+    }
+
+    if (features & (1 << 6)) {
+        /* ZMM_Hi256 state */
+        void *buf = xsave_feature_buf(xs, 6);
+        for (i = 0; i < nvecregs; ++i) {
+            memcpy(&ri->vregs[i].q[4], buf + 32 * i, 32);
+        }
+    }
+
+#ifdef __x86_64__
+    if (features & (1 << 7)) {
+        /* Hi16_ZMM state */
+        void *buf = xsave_feature_buf(xs, 7);
+        for (i = 0; i < 16; ++i) {
+            memcpy(&ri->vregs[i + 16], buf + 64 * i, 64);
+        }
+    }
+#endif
 }
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
-    return 0 == memcmp(m, a, sizeof(*m));
+    return !memcmp(m, a, sizeof(*m));
 }
 
 static const char *const regname[NGREG] = {
@@ -126,28 +240,126 @@ static const char *const regname[NGREG] = {
 # define PRIxREG   "%08x"
 #endif
 
+static int get_nvecregs(uint64_t features)
+{
+#ifdef __x86_64__
+    return features & (1 << 7) ? 32 : 16;
+#else
+    return 8;
+#endif
+}
+
+static int get_nvecquads(uint64_t features)
+{
+    if (features & (1 << 6)) {
+        return 8;
+    } else if (features & (1 << 2)) {
+        return 4;
+    } else {
+        return 2;
+    }
+}
+
+static char get_vecletter(uint64_t features)
+{
+    if (features & (1 << 6 | 1 << 7)) {
+        return 'z';
+    } else if (features & (1 << 2)) {
+        return 'y';
+    } else {
+        return 'x';
+    }
+}
+
 /* reginfo_dump: print state to a stream, returns nonzero on success */
 int reginfo_dump(struct reginfo *ri, FILE *f)
 {
-    int i;
+    uint64_t features;
+    int i, j, n, w;
+    char r;
+
     fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
     for (i = 0; i < NGREG; i++) {
         if (regname[i]) {
             fprintf(f, "  %-6s: " PRIxREG "\n", regname[i], ri->gregs[i]);
         }
     }
+
+    fprintf(f, "  mxcsr : %x\n", ri->mxcsr);
+    fprintf(f, "  xfeat : %" PRIx64 "\n", ri->xfeatures);
+
+    features = ri->xfeatures;
+    n = get_nvecregs(features);
+    w = get_nvecquads(features);
+    r = get_vecletter(features);
+
+    for (i = 0; i < n; i++) {
+        fprintf(f, "  %cmm%-3d: ", r, i);
+        for (j = w - 1; j >= 0; j--) {
+            fprintf(f, "%016" PRIx64 "%c",
+                    ri->vregs[i].q[j], j == 0 ? '\n' : ' ');
+        }
+    }
+
+    if (features & (1 << 5)) {
+        for (i = 0; i < 8; i++) {
+            fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
+        }
+    }
+
     return !ferror(f);
 }
 
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
-    int i;
+    int i, j, n, w;
+    uint64_t features;
+    char r;
+
+    fprintf(f, "Mismatch (master v apprentice):\n");
+
     for (i = 0; i < NGREG; i++) {
         if (m->gregs[i] != a->gregs[i]) {
             assert(regname[i]);
-            fprintf(f, "Mismatch: %s: " PRIxREG " v " PRIxREG "\n",
+            fprintf(f, "  %-6s: " PRIxREG " v " PRIxREG "\n",
                     regname[i], m->gregs[i], a->gregs[i]);
         }
     }
+
+    if (m->mxcsr != a->mxcsr) {
+        fprintf(f, "  mxcsr : %x v %x\n", m->mxcsr, a->mxcsr);
+    }
+    if (m->xfeatures != a->xfeatures) {
+        fprintf(f, "  xfeat : %" PRIx64 " v %" PRIx64 "\n",
+                m->xfeatures, a->xfeatures);
+    }
+
+    features = m->xfeatures;
+    n = get_nvecregs(features);
+    w = get_nvecquads(features);
+    r = get_vecletter(features);
+
+    for (i = 0; i < n; i++) {
+        if (memcmp(&m->vregs[i], &a->vregs[i], w * 8)) {
+            fprintf(f, "  %cmm%-3d: ", r, i);
+            for (j = w - 1; j >= 0; j--) {
+                fprintf(f, "%016" PRIx64 "%c",
+                        m->vregs[i].q[j], j == 0 ? '\n' : ' ');
+            }
+            fprintf(f, "       v: ");
+            for (j = w - 1; j >= 0; j--) {
+                fprintf(f, "%016" PRIx64 "%c",
+                        a->vregs[i].q[j], j == 0 ? '\n' : ' ');
+            }
+        }
+    }
+
+    for (i = 0; i < 8; i++) {
+        if (m->kregs[i] != a->kregs[i]) {
+            fprintf(f, "  k%-5d: %016" PRIx64 " v %016" PRIx64 "\n",
+                    i, m->kregs[i], a->kregs[i]);
+        }
+    }
+
     return !ferror(f);
 }
diff --git a/test_i386.S b/test_i386.S
index 456b99c..05344d7 100644
--- a/test_i386.S
+++ b/test_i386.S
@@ -12,6 +12,37 @@
 /* A trivial test image for x86 */
 
 /* Initialise the registers to avoid spurious mismatches */
+
+#ifdef __x86_64__
+#define BASE	%rax
+	lea	2f(%rip), BASE
+#else
+#define BASE	%eax
+	call	1f
+1:	pop	BASE
+	add	$2f-1b, BASE
+#endif
+
+	movdqa	0(BASE), %xmm0
+	movdqa	1*16(BASE), %xmm1
+	movdqa	2*16(BASE), %xmm2
+	movdqa	3*16(BASE), %xmm3
+	movdqa	4*16(BASE), %xmm4
+	movdqa	5*16(BASE), %xmm5
+	movdqa	6*16(BASE), %xmm6
+	movdqa	7*16(BASE), %xmm7
+
+#ifdef __x86_64__
+	movdqa	8*16(BASE), %xmm8
+	movdqa	9*16(BASE), %xmm9
+	movdqa	10*16(BASE), %xmm10
+	movdqa	11*16(BASE), %xmm11
+	movdqa	12*16(BASE), %xmm12
+	movdqa	13*16(BASE), %xmm13
+	movdqa	14*16(BASE), %xmm14
+	movdqa	15*16(BASE), %xmm15
+#endif
+
 	xor	%eax, %eax
 	sahf				/* init eflags */
 
@@ -39,3 +70,11 @@
 
 /* exit test */
 	ud1	%ecx, %eax
+
+	.p2align 16
+2:
+	.set	i, 0
+	.rept	256
+	.byte	i
+	.set	i, i + 1
+	.endr
-- 
2.17.1


