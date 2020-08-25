Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0799620665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9K799MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0799620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg6j-0003uV-7o
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2z-0006vI-Q2
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:01 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2x-0001cb-NS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:01 -0400
Received: by mail-pj1-x1043.google.com with SMTP id j13so118705pjd.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6qPmiblB+ZyNN9MP1YkeatmcIUSnXTMdD0ACsae5YvQ=;
 b=J9K799MQUJG8gJFsWlmvUn/p7lg5eagJFY+rlKjGdkmdPDx5sV6qSvZ8onlvQbs2aI
 FohWbPjvbwsp5mULvYai/SMy4GH2gOeZaJX0x8d0x5829N3Ps6ObkhQXAhCKrldjOk4R
 gQXFhWSB0vFoJHPvbJV+urCocd9nh9GcavmG7iyO77Y9OxUfwWCyEYCMBF2SLlvc5ZQA
 WvS6muzuBHHqywNjAFgtUZCUGk5sZT8WKEFg/LoWez+a/uYC36P6dodL5iGkGXzzqwnd
 v5U+NBuTPoeNQYaEZzB1TllVoCVkH7KhIIsbJr7pkR/dvZG7HR5+zpYi0cgxvzoRr12j
 ga5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6qPmiblB+ZyNN9MP1YkeatmcIUSnXTMdD0ACsae5YvQ=;
 b=nk/PwpZNuOCZUpVAfzS9A2UKAqhZhV8cX5CATnOT6j3zmuSZbOAURe7+NHPrrHU4EI
 XWSd8wXwQKNVzJ8VY+HCPg5KtOB0Cc1wiDeB09VTkDng0daV6IoInZkgObEauZy36QYg
 +l2ociCxORK27fgA3eEeW4DRovONfhO1UYItSSRjCasDfz4ecK3Bbt3pyb4Z0o0+UAxI
 I+67pxJGOLnzLyGHWyPIPlTkeLWluhFRc+CnB+rrG7WJgymI1ZC264ow/fJmzpmWApxK
 kHDGTJA+9ZLrLVcw2s8dAwyQ+MXzWxRR7wI9uRPms0/PZUFTFTE0KiFXRDcoyC7wtn8w
 1a6A==
X-Gm-Message-State: AOAM532+ffXkRjaJKoYzROvJ/EE8kuBa6rl/c9iS6W5r9ZAVwfsvGJLX
 CRprEMdLtiiBelZBE/zmGPNDc4EK2dWQtQ==
X-Google-Smtp-Source: ABdhPJyKyOZbDBqCsyO8yEnRlgiP9zigUCQrn8YdBYEVFnxbuUKPRl9JUQIC7gUGCcoSZPy3R/RhKw==
X-Received: by 2002:a17:90a:1117:: with SMTP id
 d23mr3065772pja.33.1598389197690; 
 Tue, 25 Aug 2020 13:59:57 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.13.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 13:59:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/77] target/microblaze: Tidy gdbstub
Date: Tue, 25 Aug 2020 13:58:37 -0700
Message-Id: <20200825205950.730499-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use an enumeration for the gdb register mapping.  Use one
switch statement for the entire dispatch.  Drop sreg_map
and simply enumerate those cases explicitly.  Force r0 to
have value 0 and ignore writes.

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


