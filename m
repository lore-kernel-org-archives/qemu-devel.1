Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E47C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677962072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kf45REac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677962072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxbs-0006vF-Jc
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWj-0003DT-M8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWi-000596-5R
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id k22so3809188pls.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8z6nXPR7A7x3OYVICMe1JtjXlF4OZnzlzqVhe7En9iU=;
 b=Kf45REacJKvbRslyMaI32TXHGeHT3x3QSle1TsHlTUfNL1UhF9ECVA0X8Yf/CR00tC
 TZFITRRCE5XiDELUD1wK465OUGCl5vJaeXa3erJFXADPwdhEXIRqj4fgHYmvpCUTY6lQ
 uNw/lC2KcvjFf2v8k7OsD+cu2hcFyv3VOQmsSFQToZPgpcLQCRVhg+ZkPFG2hoTQVbbE
 V30kK7D/Cg7DQxBMMJjkRFtbOdFErepHdfniO7JuysVrdwWiYz9stK8ngF5aAC0kdZgO
 wPhMzbq1dt7DtJw/YsoAz8Kgrj9hlL0eZC264mvrYMHXJcZxC2ZX+1JP3OlWL2+Ad4Jd
 lrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8z6nXPR7A7x3OYVICMe1JtjXlF4OZnzlzqVhe7En9iU=;
 b=n5AMX3TtouZVQCTzVSaDAuqbk0GYjmZrcpKCemlRuqbP0p3a35AF/RUEr+utNymjYk
 tSMt9loxgvRIwXlzxvrwY+i/sB2sDNChMrLG505Fnn9ikKQ8XewHITyboxb7W0AQwQp/
 0XR/5fFuP+jiuJjerVzKw41ZZbWPin7L6HbhCMoxwb5fP6ZRTQwiufTnd0yvlodbeCxR
 dIFQYs7juwQYGchGJiD1UYRoRV5/Z5APfr28BMnZtVj4pT+0A4UaexTbEUZBEg73rbLx
 Ly2TN9RRHBrNSxjKjCWeLL5czfdfByXPgW6C9yg7ueJAYdC/PpU6wdrNE+tDYOcNU0ex
 gtqQ==
X-Gm-Message-State: AOAM531z55WaE6/3/mEAbqN225VAQzRuo6w4leMc87B7HUBOnCJxpSZg
 kKzJnYNHg6I5U4GwhX1GkD/UO72GVRw=
X-Google-Smtp-Source: ABdhPJyJSSfUBT3jNI89cvSh2MPmdvSXca3SETUZieY7LSHUaBVYHGMPNsDcVM2jEMGAbqgnYLgX0w==
X-Received: by 2002:a17:902:82c9:: with SMTP id
 u9mr12390775plz.179.1590114909988; 
 Thu, 21 May 2020 19:35:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/25] Standardize reginfo_dump_mismatch printing
Date: Thu, 21 May 2020 19:34:37 -0700
Message-Id: <20200522023440.26261-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hoist the "master vs apprentice" label to apprentice(), since
we will want different labels for dumping.  Remove all of the
"mismatch" text from reginfo_dump_mismatch -- just print "vs".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                 |  4 ++--
 risu.c                 |  1 +
 risu_reginfo_aarch64.c | 12 +++++-------
 risu_reginfo_arm.c     | 18 ++++++++---------
 risu_reginfo_i386.c    |  6 +-----
 risu_reginfo_m68k.c    | 23 +++++++---------------
 risu_reginfo_ppc64.c   | 44 ++++++++++++++++++------------------------
 7 files changed, 44 insertions(+), 64 deletions(-)

diff --git a/risu.h b/risu.h
index bdb70c1..99f0d8e 100644
--- a/risu.h
+++ b/risu.h
@@ -123,8 +123,8 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 /* print reginfo state to a stream, returns 1 on success, 0 on failure */
 int reginfo_dump(struct reginfo *ri, FILE * f);
 
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
+/* reginfo_dump_mismatch: print mismatch details to a stream */
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
 
 /* return size of reginfo */
 int reginfo_size(struct reginfo *ri);
diff --git a/risu.c b/risu.c
index 1c096a8..f613fa9 100644
--- a/risu.c
+++ b/risu.c
@@ -449,6 +449,7 @@ static int apprentice(void)
         reginfo_dump(&ri[MASTER], stderr);
         fprintf(stderr, "apprentice reginfo:\n");
         reginfo_dump(&ri[APPRENTICE], stderr);
+        fprintf(stderr, "mismatch detail (master : apprentice):\n");
         reginfo_dump_mismatch(&ri[MASTER], &ri[APPRENTICE], stderr);
         return EXIT_FAILURE;
 
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index fb8e11a..b443745 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -316,15 +316,15 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     return !ferror(f);
 }
 
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 {
     int i;
-    fprintf(f, "mismatch detail (master : apprentice):\n");
+
     if (m->faulting_insn != a->faulting_insn) {
-        fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
+        fprintf(f, "  faulting insn: %08x vs %08x\n",
                 m->faulting_insn, a->faulting_insn);
     }
+
     for (i = 0; i < 31; i++) {
         if (m->regs[i] != a->regs[i]) {
             fprintf(f, "  X%-2d    : %016" PRIx64 " vs %016" PRIx64 "\n",
@@ -383,7 +383,7 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
                 sve_dump_preg_diff(f, vq, pm, pa);
             }
         }
-        return !ferror(f);
+        return;
     }
 #endif
 
@@ -398,6 +398,4 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
                     (uint64_t) a->simd.vregs[i]);
         }
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 202120b..ba1035e 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -183,32 +183,33 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
-    fprintf(f, "mismatch detail (master : apprentice):\n");
 
     if (m->faulting_insn_size != a->faulting_insn_size) {
-        fprintf(f, "  faulting insn size mismatch %d vs %d\n",
+        fprintf(f, "  faulting insn size: %d vs %d\n",
                 m->faulting_insn_size, a->faulting_insn_size);
     } else if (m->faulting_insn != a->faulting_insn) {
         if (m->faulting_insn_size == 2) {
-            fprintf(f, "  faulting insn mismatch %04x vs %04x\n",
+            fprintf(f, "  faulting insn: %04x vs %04x\n",
                     m->faulting_insn, a->faulting_insn);
         } else {
-            fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
+            fprintf(f, "  faulting insn: %08x vs %08x\n",
                     m->faulting_insn, a->faulting_insn);
         }
     }
+
     for (i = 0; i < 16; i++) {
         if (m->gpreg[i] != a->gpreg[i]) {
-            fprintf(f, "  r%d: %08x vs %08x\n", i, m->gpreg[i],
-                    a->gpreg[i]);
+            fprintf(f, "  r%d: %08x vs %08x\n", i, m->gpreg[i], a->gpreg[i]);
         }
     }
+
     if (m->cpsr != a->cpsr) {
         fprintf(f, "  cpsr: %08x vs %08x\n", m->cpsr, a->cpsr);
     }
+
     for (i = 0; i < 32; i++) {
         if (m->fpregs[i] != a->fpregs[i]) {
             fprintf(f, "  d%d: %016llx vs %016llx\n", i,
@@ -216,9 +217,8 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
                     (unsigned long long) a->fpregs[i]);
         }
     }
+
     if (m->fpscr != a->fpscr) {
         fprintf(f, "  fpscr: %08x vs %08x\n", m->fpscr, a->fpscr);
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index e9730be..57e4c00 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -349,14 +349,12 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i, j, n, w;
     uint64_t features;
     char r;
 
-    fprintf(f, "Mismatch (master v apprentice):\n");
-
     for (i = 0; i < NGREG; i++) {
         if (m->gregs[i] != a->gregs[i]) {
             assert(regname[i]);
@@ -399,6 +397,4 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
                     i, m->kregs[i], a->kregs[i]);
         }
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 4c25e77..29edce9 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -118,13 +118,12 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
 
     if (m->gregs[R_PS] != a->gregs[R_PS]) {
-        fprintf(f, "Mismatch: Register PS\n");
-        fprintf(f, "master: [%x] - apprentice: [%x]\n",
+        fprintf(f, "    PS: %08x vs %08x\n",
                 m->gregs[R_PS], a->gregs[R_PS]);
     }
 
@@ -133,22 +132,18 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
             continue;
         }
         if (m->gregs[i] != a->gregs[i]) {
-            fprintf(f, "Mismatch: Register %c%d\n", i < 8 ? 'D' : 'A',
-                    i % 8);
-            fprintf(f, "master: [%x] - apprentice: [%x]\n", m->gregs[i],
-                    a->gregs[i]);
+            fprintf(f, "    %c%d: %08x vs %08x\n",
+                    i < 8 ? 'D' : 'A', i % 8, m->gregs[i], a->gregs[i]);
         }
     }
 
     if (m->fpregs.f_pcr != a->fpregs.f_pcr) {
-        fprintf(f, "Mismatch: Register FPCR\n");
-        fprintf(f, "m: [%04x] != a: [%04x]\n",
+        fprintf(f, "  FPCR: %04x vs %04x\n",
                 m->fpregs.f_pcr, a->fpregs.f_pcr);
     }
 
     if (m->fpregs.f_psr != a->fpregs.f_psr) {
-        fprintf(f, "Mismatch: Register FPSR\n");
-        fprintf(f, "m: [%08x] != a: [%08x]\n",
+        fprintf(f, "  FPSR: %04x vs %04x\n",
                 m->fpregs.f_psr, a->fpregs.f_psr);
     }
 
@@ -156,14 +151,10 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
         if (m->fpregs.f_fpregs[i][0] != a->fpregs.f_fpregs[i][0] ||
             m->fpregs.f_fpregs[i][1] != a->fpregs.f_fpregs[i][1] ||
             m->fpregs.f_fpregs[i][2] != a->fpregs.f_fpregs[i][2]) {
-            fprintf(f, "Mismatch: Register FP%d\n", i);
-            fprintf(f, "m: [%08x %08x %08x] != a: [%08x %08x %08x]\n",
+            fprintf(f, "   FP%d: %08x%08x%08x vs %08x%08x%08x\n", i,
                     m->fpregs.f_fpregs[i][0], m->fpregs.f_fpregs[i][1],
                     m->fpregs.f_fpregs[i][2], a->fpregs.f_fpregs[i][0],
                     a->fpregs.f_fpregs[i][1], a->fpregs.f_fpregs[i][2]);
         }
     }
-
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 9899b36..e96dc48 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -27,6 +27,15 @@
 const struct option * const arch_long_opts;
 const char * const arch_extra_help;
 
+static const char * const greg_names[NGREG] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+   "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+   "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+   [XER] = "xer",
+   [CCR] = "ccr",
+};
+
 void process_arch_opt(int opt, const char *arg)
 {
     abort();
@@ -147,35 +156,21 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
-    for (i = 0; i < 32; i++) {
-        if (i == 1 || i == 13) {
-            continue;
+
+    for (i = 0; i < NGREG; i++) {
+        if (greg_names[i] != NULL && m->gregs[i] != a->gregs[i]) {
+            fprintf(f, "%6s: %016lx vs %016lx\n",
+                    greg_names[i], m->gregs[i], a->gregs[i]);
         }
-
-        if (m->gregs[i] != a->gregs[i]) {
-            fprintf(f, "Mismatch: Register r%d\n", i);
-            fprintf(f, "master: [%lx] - apprentice: [%lx]\n",
-                    m->gregs[i], a->gregs[i]);
-        }
-    }
-
-    if (m->gregs[XER] != a->gregs[XER]) {
-        fprintf(f, "Mismatch: XER\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n", m->gregs[XER], a->gregs[XER]);
-    }
-
-    if (m->gregs[CCR] != a->gregs[CCR]) {
-        fprintf(f, "Mismatch: Cond. Register\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n", m->gregs[CCR], a->gregs[CCR]);
     }
 
     for (i = 0; i < 32; i++) {
         if (m->fpregs[i] != a->fpregs[i]) {
-            fprintf(f, "Mismatch: Register f%d\n", i);
-            fprintf(f, "m: [%016lx] != a: [%016lx]\n",
+            fprintf(f, "%*s%d: %016lx vs %016lx\n",
+                    6 - (i < 10 ? 1 : 2), "f", i,
                     m->fpregs[i], a->fpregs[i]);
         }
     }
@@ -186,13 +181,12 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
             m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
             m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
 
-            fprintf(f, "Mismatch: Register vr%d\n", i);
-            fprintf(f, "m: [%x, %x, %x, %x] != a: [%x, %x, %x, %x]\n",
+            fprintf(f, "%*s%d: %08x%08x%08x%08x vs %08x%08x%08x%08x\n",
+                    6 - (i < 10 ? 1 : 2), "vr", i,
                     m->vrregs.vrregs[i][0], m->vrregs.vrregs[i][1],
                     m->vrregs.vrregs[i][2], m->vrregs.vrregs[i][3],
                     a->vrregs.vrregs[i][0], a->vrregs.vrregs[i][1],
                     a->vrregs.vrregs[i][2], a->vrregs.vrregs[i][3]);
         }
     }
-    return !ferror(f);
 }
-- 
2.20.1


