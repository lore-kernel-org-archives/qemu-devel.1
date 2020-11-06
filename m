Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35603C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CD820735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvQTND5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CD820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasiP-0006Q2-EW
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSE-0005f2-UU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:22 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSC-0007D0-7f
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:22 -0500
Received: by mail-pl1-x643.google.com with SMTP id b12so27295plr.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cOhvs0ghq8muGX3iEeRtFXrjJiLy3u5yfl5gf+ftseU=;
 b=AvQTND5azXdlgOoPmrY31+7AmHD68NiGIyZQgKjqvWWgpHgP0f0RI7osvKzOW0CjsG
 f5zk+kp7LDbMDJHpVNVrHnCpBuatpRjAXgSG5V216x8NjAQAzlufKjYxwTYfnuffhZ3f
 AotgP2Miv0ARh8Y1WlbEw/FLrSamV2EIpnibq/9LfGFpaM1c/ZAWsgk6P2HRS36NO6Ba
 jmSi+obGeWixJ01EtAewe0jX/78znceIIRJx1aerclDlkczaJZXxBOYveU099H1JD/7j
 W9Ovk3N/aYUtu2sjF1aeTl6BwXC0SQ/aoA9+THxCDq4DPwsPnf7Zdqrux3HmQh6xESfK
 LtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cOhvs0ghq8muGX3iEeRtFXrjJiLy3u5yfl5gf+ftseU=;
 b=E97VyvN/cGt/HRYFIfPANH2ZEgQ5m21YW7yP2ZQmbc505FGmZ44zyNVUm3VL6a/hPL
 WBQsbmJRzsEr78mef4LyoOOJuC9QqHLSg/r7XaYweJ2d02cBfZ2pKuH2Xy2x5L6P8cF4
 96609QoE4K98vMePhlRs6ouB5UcDmDb1GQleoqM47QXEvq893MYiBAMsuYt5io1SkTZV
 jZ/nuRyy/bmDiNpXR6eZdqnbW+ElTHkhjGVpMie/k31Cy2vx5ZfjudnRFLc4bEwuOFi0
 PEWWC/RNHCI6siuZs6v6MvvC5DhC3jD2jyoCuJZk+NuL7sVUO+R3+4ddTvOsOpp1kwS8
 R6Lw==
X-Gm-Message-State: AOAM531tCOBwzojXRsyr7USItiFeutxqd7pfdaHmwhlTo/IWU0sEyboq
 0YdfdRNVR+ibdvSclc7CO1Pf5nOQvgn4JA==
X-Google-Smtp-Source: ABdhPJyjSuBRgtQT6+VRgJh6kXWkvQHAQ5ByhNICn3KvUuGKeW8uLEBB5PrHJWBg2cTlxoglVLu5mQ==
X-Received: by 2002:a17:902:ab89:b029:d5:b297:2cc1 with SMTP id
 f9-20020a170902ab89b02900d5b2972cc1mr121527plr.7.1604633408196; 
 Thu, 05 Nov 2020 19:30:08 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 32/41] tcg/riscv: Fix branch range checks
Date: Thu,  5 Nov 2020 19:29:12 -0800
Message-Id: <20201106032921.600200-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The offset even checks were folded into the range check incorrectly.
By offsetting by 1, and not decrementing the width, we silently
allowed out of range branches.

Assert that the offset is always even instead.  Move tcg_out_goto
down into the CONFIG_SOFTMMU block so that it is not unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 025e3cd0bb..195c3eff03 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -429,7 +429,8 @@ static bool reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
 
-    if (offset == sextreg(offset, 1, 12) << 1) {
+    tcg_debug_assert((offset & 1) == 0);
+    if (offset == sextreg(offset, 0, 12)) {
         code_ptr[0] |= encode_sbimm12(offset);
         return true;
     }
@@ -441,7 +442,8 @@ static bool reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
 
-    if (offset == sextreg(offset, 1, 20) << 1) {
+    tcg_debug_assert((offset & 1) == 0);
+    if (offset == sextreg(offset, 0, 20)) {
         code_ptr[0] |= encode_ujimm20(offset);
         return true;
     }
@@ -854,28 +856,21 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
     g_assert_not_reached();
 }
 
-static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
-{
-    ptrdiff_t offset = tcg_pcrel_diff(s, target);
-    tcg_debug_assert(offset == sextreg(offset, 1, 20) << 1);
-    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
-}
-
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
     int ret;
 
-    if (offset == sextreg(offset, 1, 20) << 1) {
+    tcg_debug_assert((offset & 1) == 0);
+    if (offset == sextreg(offset, 0, 20)) {
         /* short jump: -2097150 to 2097152 */
         tcg_out_opc_jump(s, OPC_JAL, link, offset);
-    } else if (TCG_TARGET_REG_BITS == 32 ||
-        offset == sextreg(offset, 1, 31) << 1) {
+    } else if (TCG_TARGET_REG_BITS == 32 || offset == (int32_t)offset) {
         /* long jump: -2147483646 to 2147483648 */
         tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
         tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
-        ret = reloc_call(s->code_ptr - 2, arg);\
+        ret = reloc_call(s->code_ptr - 2, arg);
         tcg_debug_assert(ret == true);
     } else if (TCG_TARGET_REG_BITS == 64) {
         /* far jump: 64-bit */
@@ -962,6 +957,13 @@ QEMU_BUILD_BUG_ON(TCG_TARGET_REG_BITS < TARGET_LONG_BITS);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
 QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 11));
 
+static void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
+{
+    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
+    bool ok = reloc_jimm20(s->code_ptr - 1, target);
+    tcg_debug_assert(ok);
+}
+
 static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit **label_ptr, bool is_load)
-- 
2.25.1


