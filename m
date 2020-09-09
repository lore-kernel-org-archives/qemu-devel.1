Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A76BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DBC2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErqkwNHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DBC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo3b-0002nM-1Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFno3-0001B9-AC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:40729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFno1-0002MK-0T
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id gf14so425818pjb.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6/ILzcejAdFHbdG8HmT3rcq+iPboCnjCW40CyRLv1Po=;
 b=ErqkwNHLK9zpsfvMJvi1pj4ZnwX1I6Fya0BOkg5fYig4xrwtCRYcFR0Ophn07BIoQc
 vzuuJ9SdTCR2/NJ/6ZhMGKpbSctRa+FJcZGZZMD+PdcT65p/GsupQz1+zLeZ2jqV/SR1
 qjX8RdHFg0Zl6KxJexV4ciNlmJr3AnxeBmKvA/0xQ3i8zVaDCoIUJtUOP8GQSHVaMe2Z
 w5YY2yOIohe7rmEsO9URPUOL0LrUYhnyaeJjOBmCx4AQnK8Tk+w9KhvkAZjT/ghgzRXP
 BglH86Nz+3/yssfKqbvxGgXqgoByKcDHxpcnaGKeRaDkJ28m4fgTHKVrH7hYO/a2BETy
 GAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6/ILzcejAdFHbdG8HmT3rcq+iPboCnjCW40CyRLv1Po=;
 b=Kcw01vlpDXs2vWO8EcjfeOcxlBx1oPthWwkOCRC5Kw+ydJfaXrRdwy5nLR5//vKKdm
 wJ2XOi5grE/tjufKkW3iy69c/0nANq4kcd0PdGyj8pdhrBYMxgU1b/BFFWHmsuhh2Tu8
 vbfkVMwljXfSZRxbtrPkj1lDdesQ9XgsBNrhj52/Ota5g3k6jD5Q87n5swIIVLD/qzSq
 /83NG999H4/ieh0gHxLZ63XsvWJfi/qaZV8iN3dnZVrUJoxa8wJKHa9G2AlCxHijQUaL
 yJXmOEaePELp92tHi4iZHFbsTHYjdTg11ZYoltbN8K9qqbqpzsIa7FYMnjyM5lWU4HkE
 +vxQ==
X-Gm-Message-State: AOAM532z5hUS+Y3eStfWmeJ+umdzet0HmeJOTjomfcazWLbr1mmLTmMD
 F5EzYY+10JfulbV7UQ9EngL4uxwnDaBtUw==
X-Google-Smtp-Source: ABdhPJxS1/J9QorbC3JP8e8DeX8AYPUbJWpuEeiiEod0dzecYpgrQRVaaZNVqj4Ehu41h3gN8D1mbQ==
X-Received: by 2002:a17:90a:9103:: with SMTP id k3mr1221896pjo.4.1599610662849; 
 Tue, 08 Sep 2020 17:17:42 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/43] tcg/tci: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:47 -0700
Message-Id: <20200909001647.532249-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does require finishing the conversion to tcg_target_op_def.
Remove quite a lot of ifdefs, since we can reference opcodes
even if they are not implemented.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-constr.h |  28 +++
 tcg/tci/tcg-target.c.inc    | 360 ++++++++++++++----------------------
 2 files changed, 163 insertions(+), 225 deletions(-)
 create mode 100644 tcg/tci/tcg-target-constr.h

diff --git a/tcg/tci/tcg-target-constr.h b/tcg/tci/tcg-target-constr.h
new file mode 100644
index 0000000000..6658e905e6
--- /dev/null
+++ b/tcg/tci/tcg-target-constr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * TCI target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I2(r, r)
+C_O0_I2(r, ri)
+C_O0_I2(r, S)
+C_O0_I3(r, r, S)
+C_O0_I3(r, S, S)
+C_O0_I4(r, r, S, S)
+C_O1_I1(r, L)
+C_O1_I1(r, r)
+C_O1_I2(r, 0, r)
+C_O1_I2(r, L, L)
+C_O1_I2(r, ri, ri)
+C_O1_I2(r, r, r)
+C_O1_I2(r, r, ri)
+C_O2_I1(r, r, L)
+C_O2_I2(r, r, L, L)
+
+#if TCG_TARGET_REG_BITS == 32
+C_O0_I4(r, r, ri, ri)
+C_O1_I4(r, r, r, ri, ri)
+C_O2_I2(r, r, r, r)
+C_O2_I4(r, r, r, r, r, r)
+#endif
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 25ed868505..350cb498d7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -37,236 +37,146 @@
 /* Bitfield n...m (in 32 bit value). */
 #define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)
 
-/* Macros used in tcg_target_op_defs. */
-#define R       "r"
-#define RI      "ri"
-#if TCG_TARGET_REG_BITS == 32
-# define R64    "r", "r"
-#else
-# define R64    "r"
-#endif
-#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
-# define L      "L", "L"
-# define S      "S", "S"
-#else
-# define L      "L"
-# define S      "S"
-#endif
-
-/* TODO: documentation. */
-static const TCGTargetOpDef tcg_target_op_defs[] = {
-    { INDEX_op_exit_tb, { NULL } },
-    { INDEX_op_goto_tb, { NULL } },
-    { INDEX_op_br, { NULL } },
-
-    { INDEX_op_ld8u_i32, { R, R } },
-    { INDEX_op_ld8s_i32, { R, R } },
-    { INDEX_op_ld16u_i32, { R, R } },
-    { INDEX_op_ld16s_i32, { R, R } },
-    { INDEX_op_ld_i32, { R, R } },
-    { INDEX_op_st8_i32, { R, R } },
-    { INDEX_op_st16_i32, { R, R } },
-    { INDEX_op_st_i32, { R, R } },
-
-    { INDEX_op_add_i32, { R, RI, RI } },
-    { INDEX_op_sub_i32, { R, RI, RI } },
-    { INDEX_op_mul_i32, { R, RI, RI } },
-#if TCG_TARGET_HAS_div_i32
-    { INDEX_op_div_i32, { R, R, R } },
-    { INDEX_op_divu_i32, { R, R, R } },
-    { INDEX_op_rem_i32, { R, R, R } },
-    { INDEX_op_remu_i32, { R, R, R } },
-#elif TCG_TARGET_HAS_div2_i32
-    { INDEX_op_div2_i32, { R, R, "0", "1", R } },
-    { INDEX_op_divu2_i32, { R, R, "0", "1", R } },
-#endif
-    /* TODO: Does R, RI, RI result in faster code than R, R, RI?
-       If both operands are constants, we can optimize. */
-    { INDEX_op_and_i32, { R, RI, RI } },
-#if TCG_TARGET_HAS_andc_i32
-    { INDEX_op_andc_i32, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_eqv_i32
-    { INDEX_op_eqv_i32, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_nand_i32
-    { INDEX_op_nand_i32, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_nor_i32
-    { INDEX_op_nor_i32, { R, RI, RI } },
-#endif
-    { INDEX_op_or_i32, { R, RI, RI } },
-#if TCG_TARGET_HAS_orc_i32
-    { INDEX_op_orc_i32, { R, RI, RI } },
-#endif
-    { INDEX_op_xor_i32, { R, RI, RI } },
-    { INDEX_op_shl_i32, { R, RI, RI } },
-    { INDEX_op_shr_i32, { R, RI, RI } },
-    { INDEX_op_sar_i32, { R, RI, RI } },
-#if TCG_TARGET_HAS_rot_i32
-    { INDEX_op_rotl_i32, { R, RI, RI } },
-    { INDEX_op_rotr_i32, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_deposit_i32
-    { INDEX_op_deposit_i32, { R, "0", R } },
-#endif
-
-    { INDEX_op_brcond_i32, { R, RI } },
-
-    { INDEX_op_setcond_i32, { R, R, RI } },
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_setcond_i64, { R, R, RI } },
-#endif /* TCG_TARGET_REG_BITS == 64 */
-
-#if TCG_TARGET_REG_BITS == 32
-    /* TODO: Support R, R, R, R, RI, RI? Will it be faster? */
-    { INDEX_op_add2_i32, { R, R, R, R, R, R } },
-    { INDEX_op_sub2_i32, { R, R, R, R, R, R } },
-    { INDEX_op_brcond2_i32, { R, R, RI, RI } },
-    { INDEX_op_mulu2_i32, { R, R, R, R } },
-    { INDEX_op_setcond2_i32, { R, R, R, RI, RI } },
-#endif
-
-#if TCG_TARGET_HAS_not_i32
-    { INDEX_op_not_i32, { R, R } },
-#endif
-#if TCG_TARGET_HAS_neg_i32
-    { INDEX_op_neg_i32, { R, R } },
-#endif
-
-#if TCG_TARGET_REG_BITS == 64
-    { INDEX_op_ld8u_i64, { R, R } },
-    { INDEX_op_ld8s_i64, { R, R } },
-    { INDEX_op_ld16u_i64, { R, R } },
-    { INDEX_op_ld16s_i64, { R, R } },
-    { INDEX_op_ld32u_i64, { R, R } },
-    { INDEX_op_ld32s_i64, { R, R } },
-    { INDEX_op_ld_i64, { R, R } },
-
-    { INDEX_op_st8_i64, { R, R } },
-    { INDEX_op_st16_i64, { R, R } },
-    { INDEX_op_st32_i64, { R, R } },
-    { INDEX_op_st_i64, { R, R } },
-
-    { INDEX_op_add_i64, { R, RI, RI } },
-    { INDEX_op_sub_i64, { R, RI, RI } },
-    { INDEX_op_mul_i64, { R, RI, RI } },
-#if TCG_TARGET_HAS_div_i64
-    { INDEX_op_div_i64, { R, R, R } },
-    { INDEX_op_divu_i64, { R, R, R } },
-    { INDEX_op_rem_i64, { R, R, R } },
-    { INDEX_op_remu_i64, { R, R, R } },
-#elif TCG_TARGET_HAS_div2_i64
-    { INDEX_op_div2_i64, { R, R, "0", "1", R } },
-    { INDEX_op_divu2_i64, { R, R, "0", "1", R } },
-#endif
-    { INDEX_op_and_i64, { R, RI, RI } },
-#if TCG_TARGET_HAS_andc_i64
-    { INDEX_op_andc_i64, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_eqv_i64
-    { INDEX_op_eqv_i64, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_nand_i64
-    { INDEX_op_nand_i64, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_nor_i64
-    { INDEX_op_nor_i64, { R, RI, RI } },
-#endif
-    { INDEX_op_or_i64, { R, RI, RI } },
-#if TCG_TARGET_HAS_orc_i64
-    { INDEX_op_orc_i64, { R, RI, RI } },
-#endif
-    { INDEX_op_xor_i64, { R, RI, RI } },
-    { INDEX_op_shl_i64, { R, RI, RI } },
-    { INDEX_op_shr_i64, { R, RI, RI } },
-    { INDEX_op_sar_i64, { R, RI, RI } },
-#if TCG_TARGET_HAS_rot_i64
-    { INDEX_op_rotl_i64, { R, RI, RI } },
-    { INDEX_op_rotr_i64, { R, RI, RI } },
-#endif
-#if TCG_TARGET_HAS_deposit_i64
-    { INDEX_op_deposit_i64, { R, "0", R } },
-#endif
-    { INDEX_op_brcond_i64, { R, RI } },
-
-#if TCG_TARGET_HAS_ext8s_i64
-    { INDEX_op_ext8s_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext16s_i64
-    { INDEX_op_ext16s_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext32s_i64
-    { INDEX_op_ext32s_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext8u_i64
-    { INDEX_op_ext8u_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext16u_i64
-    { INDEX_op_ext16u_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext32u_i64
-    { INDEX_op_ext32u_i64, { R, R } },
-#endif
-    { INDEX_op_ext_i32_i64, { R, R } },
-    { INDEX_op_extu_i32_i64, { R, R } },
-#if TCG_TARGET_HAS_bswap16_i64
-    { INDEX_op_bswap16_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_bswap32_i64
-    { INDEX_op_bswap32_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_bswap64_i64
-    { INDEX_op_bswap64_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_not_i64
-    { INDEX_op_not_i64, { R, R } },
-#endif
-#if TCG_TARGET_HAS_neg_i64
-    { INDEX_op_neg_i64, { R, R } },
-#endif
-#endif /* TCG_TARGET_REG_BITS == 64 */
-
-    { INDEX_op_qemu_ld_i32, { R, L } },
-    { INDEX_op_qemu_ld_i64, { R64, L } },
-
-    { INDEX_op_qemu_st_i32, { R, S } },
-    { INDEX_op_qemu_st_i64, { R64, S } },
-
-#if TCG_TARGET_HAS_ext8s_i32
-    { INDEX_op_ext8s_i32, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext16s_i32
-    { INDEX_op_ext16s_i32, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext8u_i32
-    { INDEX_op_ext8u_i32, { R, R } },
-#endif
-#if TCG_TARGET_HAS_ext16u_i32
-    { INDEX_op_ext16u_i32, { R, R } },
-#endif
-
-#if TCG_TARGET_HAS_bswap16_i32
-    { INDEX_op_bswap16_i32, { R, R } },
-#endif
-#if TCG_TARGET_HAS_bswap32_i32
-    { INDEX_op_bswap32_i32, { R, R } },
-#endif
-
-    { INDEX_op_mb, { } },
-    { -1 },
-};
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    int i, n = ARRAY_SIZE(tcg_target_op_defs);
+    switch (op) {
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+        return C_O1_I1(r, r);
 
-    for (i = 0; i < n; ++i) {
-        if (tcg_target_op_defs[i].op == op) {
-            return &tcg_target_op_defs[i];
-        }
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return C_O0_I2(r, r);
+
+    case INDEX_op_div_i32:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i32:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i32:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i32:
+    case INDEX_op_remu_i64:
+        return C_O1_I2(r, r, r);
+
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+    case INDEX_op_nand_i32:
+    case INDEX_op_nand_i64:
+    case INDEX_op_nor_i32:
+    case INDEX_op_nor_i64:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i32:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i32:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
+        /* TODO: Does R, RI, RI result in faster code than R, R, RI? */
+        return C_O1_I2(r, ri, ri);
+
+    case INDEX_op_deposit_i32:
+    case INDEX_op_deposit_i64:
+        return C_O1_I2(r, 0, r);
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return C_O0_I2(r, ri);
+
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        return C_O1_I2(r, r, ri);
+
+#if TCG_TARGET_REG_BITS == 32
+    /* TODO: Support R, R, R, R, RI, RI? Will it be faster? */
+    case INDEX_op_add2_i32:
+    case INDEX_op_sub2_i32:
+        return C_O2_I4(r, r, r, r, r, r);
+    case INDEX_op_brcond2_i32:
+        return C_O0_I4(r, r, ri, ri);
+    case INDEX_op_mulu2_i32:
+        return C_O2_I2(r, r, r, r);
+    case INDEX_op_setcond2_i32
+        return C_O1_I4(r, r, r, ri, ri);
+#endif
+
+    case INDEX_op_qemu_ld_i32:
+        return (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+                ? C_O1_I1(r, L)
+                : C_O1_I2(r, L, L));
+    case INDEX_op_qemu_ld_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L)
+                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? C_O2_I1(r, r, L)
+                : C_O2_I2(r, r, L, L));
+    case INDEX_op_qemu_st_i32:
+        return (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+                ? C_O0_I2(r, S)
+                : C_O0_I3(r, S, S));
+    case INDEX_op_qemu_st_i64:
+        return (TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, S)
+                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? C_O0_I3(r, r, S)
+                : C_O0_I4(r, r, S, S));
+
+    default:
+        return NULL;
     }
-    return NULL;
 }
 
 static const int tcg_target_reg_alloc_order[] = {
-- 
2.25.1


