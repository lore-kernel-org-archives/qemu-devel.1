Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC1520719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDqGgh9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC1520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmiY-0006dB-Iv
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLG-0006KX-0i
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:39650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLE-000697-21
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id u128so810712pfb.6
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQ0LfAVoBPployk6kB6YiHjM59FX58JiRnl2u3IyKWs=;
 b=oDqGgh9vT80uBueamEINE2OAUqA5ubG1l+SCohRLS2ghPp0v/b+XjjWbU1WA2di7pA
 5N/v+hboVg4O+5+XL2HJPva5d19kBcBI7yVPTAZsi1xlY/I7Jo9xe6jiBU/HazgAnT6y
 /D84goIVMu9fQfXds9U2mZQQgeGfCvPOsKNL7dK1NXW90rFGD7B90BZOxZyvL3remfyN
 hXbgktJ71DjROJaLFiQvk02IcGuVWBn4Y7+OCqxd0Asi8OWNoZz9KEhIhqrquBXQl4nc
 xc/NpzEQqV1Fx+Uh/zJFyr3Bf1Mo/ZIYXj9wd6KIBXwb5mTD3eBnlT1ismJwscc0vd0b
 r90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQ0LfAVoBPployk6kB6YiHjM59FX58JiRnl2u3IyKWs=;
 b=H+Kw8EfOEFcGru16MPsLBDfHXYUHR3KYSjrqYS9bQm8vuKXb/KvChzW1/TwDZXfEja
 eRsxIHy+k0V0rplJVDotRiW6l1uJtc14HVYWYLx8A3ED0K5bHpDXlph7cQ7TkG2uUCzi
 CsVTSziwSxsJM969hFOYeKh8pzJtmJDYMcRkkIlpDzd6pKYc2zxwrsPfovUBLujh86It
 73ldMflS2BFvjy4+p92koGJqjq6qLEFY3ro/qIrTSE9FOa20JCxEnwNgvaRCBdezovwl
 2XrYb7W6HyC1Q58Hk7Ly87ozGk2wU1zOrnqFFlZdpaGz8UdYXdz6ATzcpULJrA64h8p9
 lGQA==
X-Gm-Message-State: AOAM530522UfwFkXAuhD5DtJUsqOlQLg15P81HPMOU5NPuJ3QH47BIX8
 w0KcWgeglapAp4HIQ80R3AQoi1vXU+zvmQ==
X-Google-Smtp-Source: ABdhPJw7jeS0LnScteXUgxdktdOQOeJwpZU7EriAN+zgmXeB/5TuGIotwq18z0i2QYPR+/G07tqVPA==
X-Received: by 2002:a62:1514:: with SMTP id 20mr1854293pfv.62.1598890050337;
 Mon, 31 Aug 2020 09:07:30 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/76] target/microblaze: Convert mbar to decodetree
Date: Mon, 31 Aug 2020 09:05:49 -0700
Message-Id: <20200831160601.833692-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Split this out of the normal branch instructions,
as it requires special handling.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  2 +
 target/microblaze/translate.c  | 85 +++++++++++++++++++---------------
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 9273a51d20..8eba47d90c 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -127,6 +127,8 @@ lwea            110010 ..... ..... ..... 0001 000 0000  @typea
 lwx             110010 ..... ..... ..... 1000 000 0000  @typea
 lwi             111010 ..... ..... ................     @typeb
 
+mbar            101110 imm:5 00010 0000 0000 0000 0100
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1c772b95d9..832cf85c64 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1127,6 +1127,52 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
     return true;
 }
 
+static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
+{
+    int mbar_imm = arg->imm;
+
+    /* Data access memory barrier.  */
+    if ((mbar_imm & 2) == 0) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+
+    /* Sleep. */
+    if (mbar_imm & 16) {
+        TCGv_i32 tmp_1;
+
+        if (trap_userspace(dc, true)) {
+            /* Sleep is a privileged instruction.  */
+            return true;
+        }
+
+        t_sync_flags(dc);
+
+        tmp_1 = tcg_const_i32(1);
+        tcg_gen_st_i32(tmp_1, cpu_env,
+                       -offsetof(MicroBlazeCPU, env)
+                       +offsetof(CPUState, halted));
+        tcg_temp_free_i32(tmp_1);
+
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
+
+        gen_raise_exception(dc, EXCP_HLT);
+    }
+
+    /*
+     * If !(mbar_imm & 1), this is an instruction access memory barrier
+     * and we need to end the TB so that we recognize self-modified
+     * code immediately.
+     *
+     * However, there are some data mbars that need the TB break
+     * (and return to main loop) to recognize interrupts right away.
+     * E.g. recognizing a change to an interrupt controller register.
+     *
+     * Therefore, choose to end the TB always.
+     */
+    dc->cpustate_changed = 1;
+    return true;
+}
+
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
@@ -1417,50 +1463,13 @@ static void dec_bcc(DisasContext *dc)
 
 static void dec_br(DisasContext *dc)
 {
-    unsigned int dslot, link, abs, mbar;
+    unsigned int dslot, link, abs;
     uint32_t add_pc;
 
     dslot = dc->ir & (1 << 20);
     abs = dc->ir & (1 << 19);
     link = dc->ir & (1 << 18);
 
-    /* Memory barrier.  */
-    mbar = (dc->ir >> 16) & 31;
-    if (mbar == 2 && dc->imm == 4) {
-        uint16_t mbar_imm = dc->rd;
-
-        /* Data access memory barrier.  */
-        if ((mbar_imm & 2) == 0) {
-            tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
-        }
-
-        /* mbar IMM & 16 decodes to sleep.  */
-        if (mbar_imm & 16) {
-            TCGv_i32 tmp_1;
-
-            if (trap_userspace(dc, true)) {
-                /* Sleep is a privileged instruction.  */
-                return;
-            }
-
-            t_sync_flags(dc);
-
-            tmp_1 = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp_1, cpu_env,
-                           -offsetof(MicroBlazeCPU, env)
-                           +offsetof(CPUState, halted));
-            tcg_temp_free_i32(tmp_1);
-
-            tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
-
-            gen_raise_exception(dc, EXCP_HLT);
-            return;
-        }
-        /* Break the TB.  */
-        dc->cpustate_changed = 1;
-        return;
-    }
-
     if (dslot) {
         dec_setup_dslot(dc);
     }
-- 
2.25.1


