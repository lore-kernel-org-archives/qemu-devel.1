Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9242072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrgStOtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9242072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxiy-0005vJ-SE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWm-0003Np-E6
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:16 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWl-0005Ai-7H
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id u22so3800403plq.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jg8schz/DdjNAa/Xi5ymKEIjRDrXBwYH1uhacJEJtGY=;
 b=KrgStOtuLFuUuccfNSJf3bvzggv4IzMOsiMnsu1lOSHJPyO82fXmbck+BOECxTUXav
 OvqzloYXGQKdj4/UVCQK4OPA5KB+PyAAJuhK3mHHOiY4ugvuiBiuDp1H7h/qI1BwNLqU
 lRoXkLY+HxcR0TFiYI6+CR1acSdFIYyU+lJfcX2sVkhgkD7M8pLc5OnxwA3bAF4fsjRl
 m0rKFLeDAAiNQyy+s8yTxcQO1RiFc3T+JgLuBrTHGQKCXVekUvIxHQHqODp/j60XBun9
 nrcfeq8r737LKYihPA035i7Cg/lsYIy2kSDTOItWcr5j/Bl2sVQu2jc6oFxaLeqWanGQ
 A9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jg8schz/DdjNAa/Xi5ymKEIjRDrXBwYH1uhacJEJtGY=;
 b=koZc9wo6VcxE7juVAVngwLy/9RgBD3eIxSVrmpe72d0haAopjsunADoUgLDrl4/ivS
 yT6Lqcey9V/kChNZ1M+0R3ivxvTrK0ftnrro2RFtvHeiRlyiGrxgFS6Yc3ONwSzNf/91
 xb7ZmklxOrtmeOpTMHQLSVkPbkSym7gAaTVcov0fLGzhkwNWP2pT916xxCKtC4KnRh6J
 8nIW8v8VdQSRUpidf0PPX+g4+PDkqmhZjmbuhF8cs+2D/LUdXjy99URNwOTIkZx1fzrG
 VRWP+9Sr6HZs7d/4UoNrDPj524POJ0n75WMjpaQ5KyYewco410BHkJbuFoyU+nEtbEtx
 h9pg==
X-Gm-Message-State: AOAM532kHxqfo3hdR4m/XXBXKE05x4OifI+xA1NyleMvaA5AmxVHQ1el
 9tuslO9/jcro9uvXCbCDvwbkBLGj+QE=
X-Google-Smtp-Source: ABdhPJwH0cQqedW9opHCVGuCrAsxSnmCWPbeE3NYLd7Gt3Eiv562/I/2uepgbdH1XK2gvIOiDYN8Ug==
X-Received: by 2002:a17:90a:8a08:: with SMTP id
 w8mr1825913pjn.53.1590114913512; 
 Thu, 21 May 2020 19:35:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/25] ppc64: Clean up reginfo handling
Date: Thu, 21 May 2020 19:34:40 -0700
Message-Id: <20200522023440.26261-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

Several of the gp_reg[] elements are not relevant -- e.g. orig r3,
which is related to system calls.  Omit those from the original
reginfo_init(), so that any differences are automatically hidden.

Do not only compare bit 4 of CCR -- this register is 32 bits wide
with 8 cr subfields.  We should compare all of them.

Tidy reginfo_dump() output.  Especially, do not dump the non-
relevant fields.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_ppc64.c | 114 +++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 70 deletions(-)

diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 134a152..62d7ff2 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -21,19 +21,30 @@
 #include "risu.h"
 #include "risu_reginfo_ppc64.h"
 
-#define XER 37
-#define CCR 38
+/* Names for indexes within gregset_t, ignoring those irrelevant here */
+enum {
+    NIP = 32,
+    MSR = 33,
+    CTR = 35,
+    LNK = 36,
+    XER = 37,
+    CCR = 38,
+};
 
 const struct option * const arch_long_opts;
 const char * const arch_extra_help;
 
 static const char * const greg_names[NGREG] = {
-    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
-    "r8",  "r9", "r10", "r11", "r12", "r13", "r14", "r15",
-   "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
-   "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
-   [XER] = "xer",
-   [CCR] = "ccr",
+     "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+     "r8",  "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+    [NIP] = "nip",
+    [MSR] = "msr",
+    [CTR] = "ctr",
+    [LNK] = "lnk",
+    [XER] = "xer",
+    [CCR] = "ccr",
 };
 
 void process_arch_opt(int opt, const char *arg)
@@ -61,8 +72,13 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
 
     for (i = 0; i < NGREG; i++) {
-        ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
+        /* Do not copy gp_reg entries not relevant to the context. */
+        if (greg_names[i]) {
+            ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
+        }
     }
+    ri->gregs[1] = 0xdeadbeef;   /* sp */
+    ri->gregs[13] = 0xdeadbeef;  /* gp */
 
     memcpy(ri->fpregs, uc->uc_mcontext.fp_regs, 32 * sizeof(double));
     ri->fpscr = uc->uc_mcontext.fp_regs[32];
@@ -76,79 +92,37 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
-    int i;
-    for (i = 0; i < 32; i++) {
-        if (i == 1 || i == 13) {
-            continue;
-        }
-
-        if (m->gregs[i] != a->gregs[i]) {
-            return 0;
-        }
-    }
-
-    if (m->gregs[XER] != a->gregs[XER]) {
-        return 0;
-    }
-
-    if ((m->gregs[CCR] & 0x10) != (a->gregs[CCR] & 0x10)) {
-        return 0;
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (m->fpregs[i] != a->fpregs[i]) {
-            return 0;
-        }
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
-            m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-            m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
-            m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
-            return 0;
-        }
-    }
-    return 1;
+    return memcmp(m, a, sizeof(*m));
 }
 
 /* reginfo_dump: print state to a stream */
 void reginfo_dump(struct reginfo *ri, FILE * f)
 {
-    int i;
+    const char *sep;
+    int i, j;
 
-    fprintf(f, "  faulting insn 0x%x\n", ri->faulting_insn);
-    fprintf(f, "  prev insn     0x%x\n", ri->prev_insn);
-    fprintf(f, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
+    fprintf(f, "%6s: %08x\n", "insn", ri->faulting_insn);
+    fprintf(f, "%6s: %016lx\n", "pc", ri->nip);
 
-    for (i = 0; i < 16; i++) {
-        fprintf(f, "\tr%2d: %16lx\tr%2d: %16lx\n", i, ri->gregs[i],
-                i + 16, ri->gregs[i + 16]);
+    sep = "";
+    for (i = j = 0; i < NGREG; i++) {
+        if (greg_names[i] != NULL) {
+            fprintf(f, "%s%6s: %016lx", sep, greg_names[i], ri->gregs[i]);
+            sep = (++j & 1 ? "  " : "\n");
+        }
     }
 
-    fprintf(f, "\n");
-    fprintf(f, "\tnip    : %16lx\n", ri->gregs[32]);
-    fprintf(f, "\tmsr    : %16lx\n", ri->gregs[33]);
-    fprintf(f, "\torig r3: %16lx\n", ri->gregs[34]);
-    fprintf(f, "\tctr    : %16lx\n", ri->gregs[35]);
-    fprintf(f, "\tlnk    : %16lx\n", ri->gregs[36]);
-    fprintf(f, "\txer    : %16lx\n", ri->gregs[37]);
-    fprintf(f, "\tccr    : %16lx\n", ri->gregs[38]);
-    fprintf(f, "\tmq     : %16lx\n", ri->gregs[39]);
-    fprintf(f, "\ttrap   : %16lx\n", ri->gregs[40]);
-    fprintf(f, "\tdar    : %16lx\n", ri->gregs[41]);
-    fprintf(f, "\tdsisr  : %16lx\n", ri->gregs[42]);
-    fprintf(f, "\tresult : %16lx\n", ri->gregs[43]);
-    fprintf(f, "\tdscr   : %16lx\n\n", ri->gregs[44]);
-
-    for (i = 0; i < 16; i++) {
-        fprintf(f, "\tf%2d: %016lx\tf%2d: %016lx\n", i, ri->fpregs[i],
-                i + 16, ri->fpregs[i + 16]);
+    sep = "\n";
+    for (i = j = 0; i < 32; i++) {
+        fprintf(f, "%s%*s%d: %016lx",
+                sep, 6 - (i < 10 ? 1 : 2), "f", i, ri->fpregs[i]);
+        sep = (++j & 1 ? "  " : "\n");
     }
-    fprintf(f, "\tfpscr: %016lx\n\n", ri->fpscr);
+    fprintf(f, "\n%6s: %016lx\n", "fpscr", ri->fpscr);
 
     for (i = 0; i < 32; i++) {
-        fprintf(f, "vr%02d: %8x, %8x, %8x, %8x\n", i,
+        fprintf(f, "%*s%d: %08x %08x %08x %08x\n",
+                6 - (i < 10 ? 1 : 2), "vr", i,
                 ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
                 ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
     }
-- 
2.20.1


