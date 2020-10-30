Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02742071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0k0EtnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02742071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIld-00027b-Ik
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbo-00049E-Mr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:39473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbh-0001pS-Ss
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id x23so2147238plr.6
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9GnCTaQR7eRGioV5lyi5+Xdu7qQoceM+UfaHP4z4mMs=;
 b=a0k0EtnRzFsqZjytenrERAsk9pWSO5YD4ttsFFf6BzH+0resHshvI9WODIFcr0BVHj
 /SPqWdPcGui99Hkax7kB7tFicWa8FJYqq2EQlzyeOnkESTe8NRwmedHThaL3DsIv0owK
 aNjhd3S25wGb0xxF8dqh7wB4s1Z1on3/YcRtfZkTDCD/vicWdQLSonhiKDLoL2e1x8R6
 AvMWx2Za9RDqCe9WxUn6hQ9diEw1r1fWM5iWPKpWiOkNyB87iPXdgw6UJ890Dz7R5P8Z
 n0UDTLrzvTy31OLe6z/lu90NyA8ebmLi7y97x9vjPc2ta0dSxSY6rduQcMsT9RklnV+A
 PIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9GnCTaQR7eRGioV5lyi5+Xdu7qQoceM+UfaHP4z4mMs=;
 b=m4OqDq4LYYuQhe8SS2ll1cGPh9F1Y/ZUuQ0KOqVdAgXhG4i7Qte+8j6vru25//550I
 tphqCOsd3NK9+rkmPqEyJECE3Mz06Baf3G6pn2ydOFwuv8z0DKyFeRacqTu46ZHrY/LO
 X0GrtoJf+qn5UlEo6lTe3CkZVqvSou0e3IT5Nf6AXkfIYjaZKsCM/jK4sTOKoFkd/mdE
 C53rVhR4kPIXbaKMvYqG41b9tCudcoI4TAxZIQEFYODmi2CjqHG8lhW3CM34D3sMlzkF
 oQ7Egg6xQfutPlhGcKslFPwxFN1+AVEJDsOo+v8dz51Cr3X9Mn7suEEeejgGdjh82nMA
 3Ktw==
X-Gm-Message-State: AOAM530SXObGUh7B+0Te3OVgKKDh2Q+/Ix8VXMSNjfSGJ//fhxnbK03S
 4V7Ohck9RQgn7H8pNui8SqiDxDvmgMZpIg==
X-Google-Smtp-Source: ABdhPJxN31i5VdVChBvEBNGVpUFoCm8bU8twbSsPJC3IeO7g2CBrbGcJE+SPM9lQ5L7CFsxjR/osvw==
X-Received: by 2002:a17:902:8ecc:b029:d6:991d:1193 with SMTP id
 x12-20020a1709028eccb02900d6991d1193mr2475677plo.56.1604018967458; 
 Thu, 29 Oct 2020 17:49:27 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/19] tcg: Move tcg epilogue pointer out of TCGContext
Date: Thu, 29 Oct 2020 17:49:05 -0700
Message-Id: <20201030004921.721096-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This value is constant across all thread-local copies of TCGContext,
so we might as well move it out of thread-local storage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 2 +-
 accel/tcg/tcg-runtime.c      | 2 +-
 tcg/tcg.c                    | 3 ++-
 tcg/aarch64/tcg-target.c.inc | 4 ++--
 tcg/arm/tcg-target.c.inc     | 2 +-
 tcg/i386/tcg-target.c.inc    | 4 ++--
 tcg/mips/tcg-target.c.inc    | 2 +-
 tcg/ppc/tcg-target.c.inc     | 2 +-
 tcg/riscv/tcg-target.c.inc   | 4 ++--
 tcg/s390/tcg-target.c.inc    | 4 ++--
 tcg/sparc/tcg-target.c.inc   | 2 +-
 11 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 5ff5bf2a73..3c56a90abc 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -621,7 +621,6 @@ struct TCGContext {
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
        extension that allows arithmetic on void*.  */
-    void *code_gen_epilogue;
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
@@ -678,6 +677,7 @@ struct TCGContext {
 
 extern TCGContext tcg_init_ctx;
 extern __thread TCGContext *tcg_ctx;
+extern void *tcg_code_gen_epilogue;
 extern TCGv_env cpu_env;
 
 static inline size_t temp_idx(TCGTemp *ts)
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 446465a09a..f85dfefeab 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -154,7 +154,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cflags());
     if (tb == NULL) {
-        return tcg_ctx->code_gen_epilogue;
+        return tcg_code_gen_epilogue;
     }
     qemu_log_mask_and_addr(CPU_LOG_EXEC, pc,
                            "Chain %d: %p ["
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8d63c714fb..1916a818d9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -160,6 +160,7 @@ static int tcg_out_ldst_finalize(TCGContext *s);
 static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
 TCGv_env cpu_env = 0;
+void *tcg_code_gen_epilogue;
 
 #ifndef CONFIG_TCG_INTERPRETER
 tcg_prologue_fn *tcg_qemu_tb_exec;
@@ -1128,7 +1129,7 @@ void tcg_prologue_init(TCGContext *s)
 
     /* Assert that goto_ptr is implemented completely.  */
     if (TCG_TARGET_HAS_goto_ptr) {
-        tcg_debug_assert(s->code_gen_epilogue != NULL);
+        tcg_debug_assert(tcg_code_gen_epilogue != NULL);
     }
 }
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 83af3108a4..76f8ae48ad 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1873,7 +1873,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_exit_tb:
         /* Reuse the zeroing that exists for goto_ptr.  */
         if (a0 == 0) {
-            tcg_out_goto_long(s, s->code_gen_epilogue);
+            tcg_out_goto_long(s, tcg_code_gen_epilogue);
         } else {
             tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
             tcg_out_goto_long(s, tb_ret_addr);
@@ -2894,7 +2894,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_X0, 0);
 
     /* TB epilogue */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 62c37a954b..1e32bf42b8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2297,7 +2297,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
     tcg_out_epilogue(s);
 }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d8797ed398..424dd1cdcf 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2267,7 +2267,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_exit_tb:
         /* Reuse the zeroing that exists for goto_ptr.  */
         if (a0 == 0) {
-            tcg_out_jmp(s, s->code_gen_epilogue);
+            tcg_out_jmp(s, tcg_code_gen_epilogue);
         } else {
             tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, a0);
             tcg_out_jmp(s, tb_ret_addr);
@@ -3825,7 +3825,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);
 
     /* TB epilogue */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index c255ecb444..f641105f9a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2483,7 +2483,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_V0, TCG_REG_ZERO);
 
     /* TB epilogue */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a848e98383..be116c6164 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2341,7 +2341,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
-    s->code_gen_epilogue = tb_ret_addr = s->code_ptr;
+    tcg_code_gen_epilogue = tb_ret_addr = s->code_ptr;
 
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); ++i) {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d536f3ccc1..ab08af7457 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1288,7 +1288,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_exit_tb:
         /* Reuse the zeroing that exists for goto_ptr.  */
         if (a0 == 0) {
-            tcg_out_call_int(s, s->code_gen_epilogue, true);
+            tcg_out_call_int(s, tcg_code_gen_epilogue, true);
         } else {
             tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_A0, a0);
             tcg_out_call_int(s, tb_ret_addr, true);
@@ -1822,7 +1822,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, tcg_target_call_iarg_regs[1], 0);
 
     /* Return path for goto_ptr. Set return value to 0 */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_A0, TCG_REG_ZERO);
 
     /* TB epilogue */
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index c5e096449b..ac99ccea73 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -1756,7 +1756,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* Reuse the zeroing that exists for goto_ptr.  */
         a0 = args[0];
         if (a0 == 0) {
-            tgen_gotoi(s, S390_CC_ALWAYS, s->code_gen_epilogue);
+            tgen_gotoi(s, S390_CC_ALWAYS, tcg_code_gen_epilogue);
         } else {
             tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, a0);
             tgen_gotoi(s, S390_CC_ALWAYS, tb_ret_addr);
@@ -2561,7 +2561,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, 0);
 
     /* TB epilogue */
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 6e2d755f6a..5b3bc91b05 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1038,7 +1038,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_nop(s);
 
     /* Epilogue for goto_ptr.  */
-    s->code_gen_epilogue = s->code_ptr;
+    tcg_code_gen_epilogue = s->code_ptr;
     tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
     /* delay slot */
     tcg_out_movi_imm13(s, TCG_REG_O0, 0);
-- 
2.25.1


