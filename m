Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77FFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B586E2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCYyfJHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B586E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfln-0000Pk-0A
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFR-0002DS-8M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:57 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:38550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFP-0005Q5-4P
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id t11so532656plr.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=22O6iYfJ5kkzdH0WE/DLGgphQgLtnFGPTphEDVG9AXk=;
 b=gCYyfJHKnyUHQp+yl6xOzNVCdVtSM/Hr3+m8f5aeT3rhPOVWmhrHe64ZbHXsSCRtie
 4mVLvtGrbEHPo94cDnd8YVApz0eWgEDnYzRF5Z3486TYGzyrjWg7Wk/rVRycGdwqeV0g
 3gHeGiSGscw5Jnt7UutXpgUcF4chIqlkM5Xe3PhMNzTJmth0qezF+1KV1/2hIVcPbaTY
 NPsTDwafXXUOLPuEslQ8f/xyGo3entrbH4ePe/SMhOXqXsc7f6f5AnM72jATkx8A1q0K
 +VO2kvWTwE9XKFiIkksUxam58KGMbabhFx+N71p8IokZCuh/0mI7j1HGEeopHdMCcKFU
 8Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=22O6iYfJ5kkzdH0WE/DLGgphQgLtnFGPTphEDVG9AXk=;
 b=I7CJKEYQOO01FoGrQOcZuqgRvvJrAN/rSgrgWXP1NSPV+5Bx1WZkBqH6elyTkQChzh
 OcQqdYkf27q6tt2K7/wxDfDiMdXuICKmi0+LDFhwVzzXRgc0/y7GJ1roFo2BP/E5fFOd
 63WitFi2Z8FU1RjLOSDk3PbRRucio4B4R43bURrC1lPMOdpILDR2SVXnZ/phnCHmpIKk
 hi8r5btjH88TcD/VUiO+OL/lwUsAIXfa8G6xT8uH8HhSrioiFoyo6g29ix0hAbAK20mO
 RTsHVUArP+22p8lIUdk8H7cduU4hhJzRAwayBbr15ux8MJbtND6GMTc7W1SiYnnYNvIF
 Vg1g==
X-Gm-Message-State: AOAM530bwhn5zhxQdQ97g3Wml9d6aP7rDLMYfwYHsiD44Iumk7Zq89LH
 ahqPdDzkgYiYaAG3vUqFWnmEstGL4Pn4uA==
X-Google-Smtp-Source: ABdhPJylDatz2nz1I2HkzchdR3s6oIr/Z0+NOJhNa4KiuOhaYp07N6o0tlOd5KUnLFIo2dR9+IMjOw==
X-Received: by 2002:a17:902:b497:: with SMTP id
 y23mr1448539plr.251.1598624452993; 
 Fri, 28 Aug 2020 07:20:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 64/76] target/microblaze: Convert mbar to decodetree
Date: Fri, 28 Aug 2020 07:19:17 -0700
Message-Id: <20200828141929.77854-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split this out of the normal branch instructions,
as it requires special handling.

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


