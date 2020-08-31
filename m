Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE30C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FAF206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaEv84Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FAF206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmOD-0003W8-E8
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJy-0003SX-Pp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJv-0005u4-Qe
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id c142so804699pfb.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EAqHVd7k8qnFGYSw1XH+Q9LqQUEdcVQsZIdVmMRUJCo=;
 b=yaEv84DwJSc1LaJNI+Yu4tyRP9PN6oLWy6S+wvSiSuMRkFUi5Qvs8ajcINvPTck8Qs
 Kcx9UUjk0fC2BOh67v2j4VRB+82fNqU3wgv6nYEA5j/ynLyjbAOKe3rI0h/aLUXntwjW
 T5liPMFFEUagpYpYBaMjJ111D6GonBo8TUaArh8AEbz9RFVF5h7BjLfZrRSXx0PU/DMi
 qQZoqRZyS+7tvcWMdsXmaNmz8fxCrFlgqhLJAkucrB0il68gM9WYb7q7dCKv0rI6ZEKN
 clpEzrQp814qqpE1It1VhQlIv5cZ3LAGQUkn0lhlo7tlyJAm4LgWub/EnypNJ+Qnakgj
 IyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EAqHVd7k8qnFGYSw1XH+Q9LqQUEdcVQsZIdVmMRUJCo=;
 b=A/42wvBBVzyt434rzFYtQRSqcYt/NlG6ZjiREUGADoRh6bUzH4EStFRNdYJFftErXL
 SZ7mPlCoO3Ytxgs4CkoQzeEtgXFSz3VdSJ9wnGzeTqbgvB/EpzA9yo/04REzl110CHGl
 NYl35cr940YqbxlJebNWAsKzJ31M6I8QW2mKc2ymjgXLCHFS+nU+MBFjJbccnzdmIkaL
 57+x+eT2/HbvuwJusUhehW5khLCGUkrTyW3aun35oVtcYu/K1Ckcb4z2W19GaoNnJvuB
 BhjDazT3DdCVPJwd5AH2WblxuiqW9qQESVLVqk4keNsikYaWswTfxgE8wElf+sQIHA/J
 7boQ==
X-Gm-Message-State: AOAM533Wb8ilfXsKN092F3rfac2smz3Ms9xJ6xqG2X8xyno8tO2cw3FC
 8rFRDyBCJvuckHiWkjccXMx0M6haRl0r3A==
X-Google-Smtp-Source: ABdhPJy99AJH1SHXr+9rcWqCo+2PcVIrbMvrPAmovZVCKec/SC6JjfqAwyi/SIlUvkY4b1XXdfIplA==
X-Received: by 2002:a62:8c91:: with SMTP id m139mr1822568pfd.267.1598889969889; 
 Mon, 31 Aug 2020 09:06:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/76] target/microblaze: Tidy gdbstub
Date: Mon, 31 Aug 2020 09:04:49 -0700
Message-Id: <20200831160601.833692-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use an enumeration for the gdb register mapping.  Use one
switch statement for the entire dispatch.  Drop sreg_map
and simply enumerate those cases explicitly.  Force r0 to
have value 0 and ignore writes.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/gdbstub.c | 193 +++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 92 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 73e8973597..e65ec051a5 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -21,58 +21,80 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
+/*
+ * GDB expects SREGs in the following order:
+ * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
+ *
+ * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
+ * map them to anything and return a value of 0 instead.
+ */
+
+enum {
+    GDB_PC    = 32 + 0,
+    GDB_MSR   = 32 + 1,
+    GDB_EAR   = 32 + 2,
+    GDB_ESR   = 32 + 3,
+    GDB_FSR   = 32 + 4,
+    GDB_BTR   = 32 + 5,
+    GDB_PVR0  = 32 + 6,
+    GDB_PVR11 = 32 + 17,
+    GDB_EDR   = 32 + 18,
+    GDB_SLR   = 32 + 25,
+    GDB_SHR   = 32 + 26,
+};
+
 int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUMBState *env = &cpu->env;
-    /*
-     * GDB expects SREGs in the following order:
-     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
-     * They aren't stored in this order, so make a map.
-     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
-     * map them to anything and return a value of 0 instead.
-     */
-    static const uint8_t sreg_map[6] = {
-        SR_PC,
-        SR_MSR,
-        SR_EAR,
-        SR_ESR,
-        SR_FSR,
-        SR_BTR
-    };
+    uint32_t val;
 
-    /*
-     * GDB expects registers to be reported in this order:
-     * R0-R31
-     * PC-BTR
-     * PVR0-PVR11
-     * EDR-TLBHI
-     * SLR-SHR
-     */
-    if (n < 32) {
-        return gdb_get_reg32(mem_buf, env->regs[n]);
-    } else {
-        n -= 32;
-        switch (n) {
-        case 0 ... 5:
-            return gdb_get_reg32(mem_buf, env->sregs[sreg_map[n]]);
-        /* PVR12 is intentionally skipped */
-        case 6 ... 17:
-            n -= 6;
-            return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
-        case 18:
-            return gdb_get_reg32(mem_buf, env->sregs[SR_EDR]);
-        /* Other SRegs aren't modeled, so report a value of 0 */
-        case 19 ... 24:
-            return gdb_get_reg32(mem_buf, 0);
-        case 25:
-            return gdb_get_reg32(mem_buf, env->slr);
-        case 26:
-            return gdb_get_reg32(mem_buf, env->shr);
-        default:
-            return 0;
-        }
+    if (n > cc->gdb_num_core_regs) {
+        return 0;
     }
+
+    switch (n) {
+    case 1 ... 31:
+        val = env->regs[n];
+        break;
+    case GDB_PC:
+        val = env->sregs[SR_PC];
+        break;
+    case GDB_MSR:
+        val = env->sregs[SR_MSR];
+        break;
+    case GDB_EAR:
+        val = env->sregs[SR_EAR];
+        break;
+    case GDB_ESR:
+        val = env->sregs[SR_ESR];
+        break;
+    case GDB_FSR:
+        val = env->sregs[SR_FSR];
+        break;
+    case GDB_BTR:
+        val = env->sregs[SR_BTR];
+        break;
+    case GDB_PVR0 ... GDB_PVR11:
+        /* PVR12 is intentionally skipped */
+        val = env->pvr.regs[n - GDB_PVR0];
+        break;
+    case GDB_EDR:
+        val = env->sregs[SR_EDR];
+        break;
+    case GDB_SLR:
+        val = env->slr;
+        break;
+    case GDB_SHR:
+        val = env->shr;
+        break;
+    default:
+        /* Other SRegs aren't modeled, so report a value of 0 */
+        val = 0;
+        break;
+    }
+    return gdb_get_reg32(mem_buf, val);
 }
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
@@ -82,60 +104,47 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUMBState *env = &cpu->env;
     uint32_t tmp;
 
-    /*
-     * GDB expects SREGs in the following order:
-     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
-     * They aren't stored in this order, so make a map.
-     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
-     * map them to anything.
-     */
-    static const uint8_t sreg_map[6] = {
-        SR_PC,
-        SR_MSR,
-        SR_EAR,
-        SR_ESR,
-        SR_FSR,
-        SR_BTR
-    };
-
     if (n > cc->gdb_num_core_regs) {
         return 0;
     }
 
     tmp = ldl_p(mem_buf);
 
-    /*
-     * GDB expects registers to be reported in this order:
-     * R0-R31
-     * PC-BTR
-     * PVR0-PVR11
-     * EDR-TLBHI
-     * SLR-SHR
-     */
-    if (n < 32) {
+    switch (n) {
+    case 1 ... 31:
         env->regs[n] = tmp;
-    } else {
-        n -= 32;
-        switch (n) {
-        case 0 ... 5:
-            env->sregs[sreg_map[n]] = tmp;
-            break;
+        break;
+    case GDB_PC:
+        env->sregs[SR_PC] = tmp;
+        break;
+    case GDB_MSR:
+        env->sregs[SR_MSR] = tmp;
+        break;
+    case GDB_EAR:
+        env->sregs[SR_EAR] = tmp;
+        break;
+    case GDB_ESR:
+        env->sregs[SR_ESR] = tmp;
+        break;
+    case GDB_FSR:
+        env->sregs[SR_FSR] = tmp;
+        break;
+    case GDB_BTR:
+        env->sregs[SR_BTR] = tmp;
+        break;
+    case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
-        case 6 ... 17:
-            n -= 6;
-            env->pvr.regs[n] = tmp;
-            break;
-        /* Only EDR is modeled in these indeces, so ignore the rest */
-        case 18:
-            env->sregs[SR_EDR] = tmp;
-            break;
-        case 25:
-            env->slr = tmp;
-            break;
-        case 26:
-            env->shr = tmp;
-            break;
-        }
+        env->pvr.regs[n - GDB_PVR0] = tmp;
+        break;
+    case GDB_EDR:
+        env->sregs[SR_EDR] = tmp;
+        break;
+    case GDB_SLR:
+        env->slr = tmp;
+        break;
+    case GDB_SHR:
+        env->shr = tmp;
+        break;
     }
     return 4;
 }
-- 
2.25.1


