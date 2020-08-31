Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E92C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E40E2083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzoIcbAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E40E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmsk-0000J4-Oe
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLP-0006l2-SR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLN-0006B0-DK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:43 -0400
Received: by mail-pl1-x642.google.com with SMTP id q3so3234680pls.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hba68ezEWb+nS0e4nSSkWGW78a7UsmlXp2xiIpotygQ=;
 b=WzoIcbAPp9R7brAgHL5BISzHwIOYaCl+YKm4rFuUOLMHGfLCu35dev5PFuYeg2sVLl
 PddIUAYIGFI9uMy46kO8/3yZLo0OncFg0gW9C4HWsBZxBlstMrzoSiQ4MO2OLd5X5UR3
 3sbrDCyRk0nEz+654EzqJe0MeifuCzWHz3LrhY35J34p+4exOdGmkFyW45gQ4c78zdzx
 6AvQcC2NGMWHeIJIH0weCGW6NUW9Rq1hCLmOIDl/ynVpbkjrLwbbJTJElV131cfYPC26
 E/cTePPKlpzBvZlPSU1X6fLqNVyswHq4OlYuLACnbKnHxs/axETB5nLOKPrb8GBgueV6
 mCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hba68ezEWb+nS0e4nSSkWGW78a7UsmlXp2xiIpotygQ=;
 b=CBXFspi333dB1Z3cf1DjiFerIFuy6HPrKXLbTjZ73Cldn3Q1w6kS3gTg448Tq7Ahav
 2fbMYarEZdtMilrxR5qJhPOpArCU9cv9jQvwy78JpKZq4IZejdEvI19yDMPY+z+1saC7
 UI0BcpuXb+ygLo/uSIRLZyWW3nw9mIJ+L4Qmz5fLaogiuwdNa+H4aGvYgteucS76vld+
 5m3kNwUPsj5PAM5gUBoENS2Z9Se0BQnc91vH0F6TgoIFQwB9vESauE05Ri498iTKefFf
 GsWEXUZRUU327FgCjF8AIbhu3knGGkP16J2Hk58g+UNuQTI7YlZ0/D9zu+x3oObXSj0f
 +1xQ==
X-Gm-Message-State: AOAM531FHsy1x85YMm861jqBAYICr3NZvN6el6i+xG8+nkyCyuJiuwaS
 DwzTgNzvysgTihYxm4imrRGpjJYTMQJoJw==
X-Google-Smtp-Source: ABdhPJyeY9Vz59LpQIyQvzlKSZpNhQ/pIvxnkKYEfofJR0DWGU0Unz5QBqbNRpMrBFuYnqAO5+JR4Q==
X-Received: by 2002:a17:90b:1988:: with SMTP id mv8mr85832pjb.23.1598890059551; 
 Mon, 31 Aug 2020 09:07:39 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/76] target/microblaze: Convert dec_msr to decodetree
Date: Mon, 31 Aug 2020 09:05:56 -0700
Message-Id: <20200831160601.833692-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |   3 +
 target/microblaze/translate.c  | 270 +++++++++++++++++----------------
 2 files changed, 139 insertions(+), 134 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index ed3312982f..43c9e16819 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -182,6 +182,9 @@ lwi             111010 ..... ..... ................     @typeb
 
 mbar            101110 imm:5 00010 0000 0000 0000 0100
 
+mfs             100101 rd:5  0 e:1 000 10 rs:14
+mts             100101 0 e:1 000 ra:5  11 rs:14
+
 msrclr          100101 ..... 100010 ...............     @type_msr
 msrset          100101 ..... 100000 ...............     @type_msr
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9479dbc103..582f5a1577 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1300,6 +1300,7 @@ static void msr_read(DisasContext *dc, TCGv_i32 d)
     tcg_temp_free_i32(t);
 }
 
+#ifndef CONFIG_USER_ONLY
 static void msr_write(DisasContext *dc, TCGv_i32 v)
 {
     dc->cpustate_changed = 1;
@@ -1310,6 +1311,7 @@ static void msr_write(DisasContext *dc, TCGv_i32 v)
     /* Clear MSR_C and MSR_CC; MSR_PVR is not writable, and is always clear. */
     tcg_gen_andi_i32(cpu_msr, v, ~(MSR_C | MSR_CC | MSR_PVR));
 }
+#endif
 
 static bool do_msrclrset(DisasContext *dc, arg_type_msr *arg, bool set)
 {
@@ -1358,151 +1360,152 @@ static bool trans_msrset(DisasContext *dc, arg_type_msr *arg)
     return do_msrclrset(dc, arg, true);
 }
 
-static void dec_msr(DisasContext *dc)
+static bool trans_mts(DisasContext *dc, arg_mts *arg)
 {
-    CPUState *cs = CPU(dc->cpu);
-    unsigned int sr, rn;
-    bool to, extended = false;
-
-    sr = extract32(dc->imm, 0, 14);
-    to = extract32(dc->imm, 14, 1);
-    dc->type_b = 1;
-    if (to) {
-        dc->cpustate_changed = 1;
+    if (trap_userspace(dc, true)) {
+        return true;
     }
 
-    /* Extended MSRs are only available if addr_size > 32.  */
-    if (dc->cpu->cfg.addr_size > 32) {
-        /* The E-bit is encoded differently for To/From MSR.  */
-        static const unsigned int e_bit[] = { 19, 24 };
-
-        extended = extract32(dc->imm, e_bit[to], 1);
+#ifdef CONFIG_USER_ONLY
+    g_assert_not_reached();
+#else
+    if (arg->e && arg->rs != 0x1003) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid extended mts reg 0x%x\n", arg->rs);
+        return true;
     }
 
-    if (trap_userspace(dc, to)) {
-        return;
-    }
+    TCGv_i32 src = reg_for_read(dc, arg->ra);
+    switch (arg->rs) {
+    case SR_MSR:
+        msr_write(dc, src);
+        break;
+    case SR_FSR:
+        tcg_gen_st_i32(src, cpu_env, offsetof(CPUMBState, fsr));
+        break;
+    case 0x800:
+        tcg_gen_st_i32(src, cpu_env, offsetof(CPUMBState, slr));
+        break;
+    case 0x802:
+        tcg_gen_st_i32(src, cpu_env, offsetof(CPUMBState, shr));
+        break;
 
-#if !defined(CONFIG_USER_ONLY)
-    /* Catch read/writes to the mmu block.  */
-    if ((sr & ~0xff) == 0x1000) {
-        TCGv_i32 tmp_ext = tcg_const_i32(extended);
-        TCGv_i32 tmp_sr;
+    case 0x1000: /* PID */
+    case 0x1001: /* ZPR */
+    case 0x1002: /* TLBX */
+    case 0x1003: /* TLBLO */
+    case 0x1004: /* TLBHI */
+    case 0x1005: /* TLBSX */
+        {
+            TCGv_i32 tmp_ext = tcg_const_i32(arg->e);
+            TCGv_i32 tmp_reg = tcg_const_i32(arg->rs & 7);
 
-        sr &= 7;
-        tmp_sr = tcg_const_i32(sr);
-        if (to) {
-            gen_helper_mmu_write(cpu_env, tmp_ext, tmp_sr, cpu_R[dc->ra]);
-        } else {
-            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tmp_ext, tmp_sr);
+            gen_helper_mmu_write(cpu_env, tmp_ext, tmp_reg, src);
+            tcg_temp_free_i32(tmp_reg);
+            tcg_temp_free_i32(tmp_ext);
         }
-        tcg_temp_free_i32(tmp_sr);
-        tcg_temp_free_i32(tmp_ext);
-        return;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid mts reg 0x%x\n", arg->rs);
+        return true;
     }
+    dc->cpustate_changed = 1;
+    return true;
+#endif
+}
+
+static bool trans_mfs(DisasContext *dc, arg_mfs *arg)
+{
+    TCGv_i32 dest = reg_for_write(dc, arg->rd);
+
+    if (arg->e) {
+        switch (arg->rs) {
+        case SR_EAR:
+            {
+                TCGv_i64 t64 = tcg_temp_new_i64();
+                tcg_gen_ld_i64(t64, cpu_env, offsetof(CPUMBState, ear));
+                tcg_gen_extrh_i64_i32(dest, t64);
+                tcg_temp_free_i64(t64);
+            }
+            return true;
+#ifndef CONFIG_USER_ONLY
+        case 0x1003: /* TLBLO */
+            /* Handled below. */
+            break;
+#endif
+        case 0x2006 ... 0x2009:
+            /* High bits of PVR6-9 not implemented. */
+            tcg_gen_movi_i32(dest, 0);
+            return true;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid extended mfs reg 0x%x\n", arg->rs);
+            return true;
+        }
+    }
+
+    switch (arg->rs) {
+    case SR_PC:
+        tcg_gen_movi_i32(dest, dc->base.pc_next);
+        break;
+    case SR_MSR:
+        msr_read(dc, dest);
+        break;
+    case SR_EAR:
+        {
+            TCGv_i64 t64 = tcg_temp_new_i64();
+            tcg_gen_ld_i64(t64, cpu_env, offsetof(CPUMBState, ear));
+            tcg_gen_extrl_i64_i32(dest, t64);
+            tcg_temp_free_i64(t64);
+        }
+        break;
+    case SR_ESR:
+        tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, esr));
+        break;
+    case SR_FSR:
+        tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, fsr));
+        break;
+    case SR_BTR:
+        tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, btr));
+        break;
+    case SR_EDR:
+        tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, edr));
+        break;
+    case 0x800:
+        tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, slr));
+        break;
+    case 0x802:
+        tcg_gen_ld_i32(dest, cpu_env, offsetof(CPUMBState, shr));
+        break;
+
+#ifndef CONFIG_USER_ONLY
+    case 0x1000: /* PID */
+    case 0x1001: /* ZPR */
+    case 0x1002: /* TLBX */
+    case 0x1003: /* TLBLO */
+    case 0x1004: /* TLBHI */
+    case 0x1005: /* TLBSX */
+        {
+            TCGv_i32 tmp_ext = tcg_const_i32(arg->e);
+            TCGv_i32 tmp_reg = tcg_const_i32(arg->rs & 7);
+
+            gen_helper_mmu_read(dest, cpu_env, tmp_ext, tmp_reg);
+            tcg_temp_free_i32(tmp_reg);
+            tcg_temp_free_i32(tmp_ext);
+        }
+        break;
 #endif
 
-    if (to) {
-        switch (sr) {
-            case SR_PC:
-                break;
-            case SR_MSR:
-                msr_write(dc, cpu_R[dc->ra]);
-                break;
-            case SR_EAR:
-                {
-                    TCGv_i64 t64 = tcg_temp_new_i64();
-                    tcg_gen_extu_i32_i64(t64, cpu_R[dc->ra]);
-                    tcg_gen_st_i64(t64, cpu_env, offsetof(CPUMBState, ear));
-                    tcg_temp_free_i64(t64);
-                }
-                break;
-            case SR_ESR:
-                tcg_gen_st_i32(cpu_R[dc->ra],
-                               cpu_env, offsetof(CPUMBState, esr));
-                break;
-            case SR_FSR:
-                tcg_gen_st_i32(cpu_R[dc->ra],
-                               cpu_env, offsetof(CPUMBState, fsr));
-                break;
-            case SR_BTR:
-                tcg_gen_st_i32(cpu_R[dc->ra],
-                               cpu_env, offsetof(CPUMBState, btr));
-                break;
-            case SR_EDR:
-                tcg_gen_st_i32(cpu_R[dc->ra],
-                               cpu_env, offsetof(CPUMBState, edr));
-                break;
-            case 0x800:
-                tcg_gen_st_i32(cpu_R[dc->ra],
-                               cpu_env, offsetof(CPUMBState, slr));
-                break;
-            case 0x802:
-                tcg_gen_st_i32(cpu_R[dc->ra],
-                               cpu_env, offsetof(CPUMBState, shr));
-                break;
-            default:
-                cpu_abort(CPU(dc->cpu), "unknown mts reg %x\n", sr);
-                break;
-        }
-    } else {
-        switch (sr) {
-            case SR_PC:
-                tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
-                break;
-            case SR_MSR:
-                msr_read(dc, cpu_R[dc->rd]);
-                break;
-            case SR_EAR:
-                {
-                    TCGv_i64 t64 = tcg_temp_new_i64();
-                    tcg_gen_ld_i64(t64, cpu_env, offsetof(CPUMBState, ear));
-                    if (extended) {
-                        tcg_gen_extrh_i64_i32(cpu_R[dc->rd], t64);
-                    } else {
-                        tcg_gen_extrl_i64_i32(cpu_R[dc->rd], t64);
-                    }
-                    tcg_temp_free_i64(t64);
-                }
-                break;
-            case SR_ESR:
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                               cpu_env, offsetof(CPUMBState, esr));
-                break;
-            case SR_FSR:
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                               cpu_env, offsetof(CPUMBState, fsr));
-                break;
-            case SR_BTR:
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                               cpu_env, offsetof(CPUMBState, btr));
-                break;
-            case SR_EDR:
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                               cpu_env, offsetof(CPUMBState, edr));
-                break;
-            case 0x800:
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                               cpu_env, offsetof(CPUMBState, slr));
-                break;
-            case 0x802:
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                               cpu_env, offsetof(CPUMBState, shr));
-                break;
-            case 0x2000 ... 0x200c:
-                rn = sr & 0xf;
-                tcg_gen_ld_i32(cpu_R[dc->rd],
-                              cpu_env, offsetof(CPUMBState, pvr.regs[rn]));
-                break;
-            default:
-                cpu_abort(cs, "unknown mfs reg %x\n", sr);
-                break;
-        }
-    }
-
-    if (dc->rd == 0) {
-        tcg_gen_movi_i32(cpu_R[0], 0);
+    case 0x2000 ... 0x200c:
+        tcg_gen_ld_i32(dest, cpu_env,
+                       offsetof(CPUMBState, pvr.regs[arg->rs - 0x2000]));
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid mfs reg 0x%x\n", arg->rs);
+        break;
     }
+    return true;
 }
 
 static void do_rti(DisasContext *dc)
@@ -1593,7 +1596,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
 };
-- 
2.25.1


