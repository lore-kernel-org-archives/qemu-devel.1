Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE022145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIOceMSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE022145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnpf-0004UK-Op
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnO-0007xU-D6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnM-0002DL-Gv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:06 -0400
Received: by mail-pf1-x444.google.com with SMTP id z19so548958pfn.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1eE3lAmyrdjuzVxb1U2PcBVqu2mO9eS/d8wE+vhl4dk=;
 b=CIOceMSbz6q5hVVYR8y/JyXR9F/6OZRg3aj94I0bIMta8PVatNahlpYokct61Xek5N
 7Naq0OyTWHOOCByBdzHS0edv0QIKzxA1kNXwLNLSuS6L30qHiizJsPlRWm+P1kJED4ad
 hFUsEIYLBMp6SnwkPPhGvODoH7Ic0WcI/S3s6F4PNge6xc5IPuBSfbTgvgNkrUWLDYrk
 2jYzRHn3XC3S5kXYRuLjWn+ff1v80xz3rgKF2T6+Z8xwUCA3rEWJJkUOISopcRQjLsTN
 qQ1yr0nfevxYkncVT6MuL87ysmLYorHTNFjflakfSHra+croKkBZFE/fGgt4vO0YFoPa
 nlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1eE3lAmyrdjuzVxb1U2PcBVqu2mO9eS/d8wE+vhl4dk=;
 b=WjD19U9RUSY5IorU82Xp2/gdNq7ZVimZr7wxtcuxi6k/mPzXuXv5t/NF1MfbaCEaVn
 nv2bckXteQuWWW2b7M3J09EEAOGkN9D6uv4YZ1hDuCBhYBacoql/JmBkL9JPmU5smxAE
 crBxwaBdsZb6QV6koupy44e6s5Lv0hx0AWHII3yJ7Od3Op/LnjbzgdUrNKsqrrtFMlyL
 oKkXsZdp6+ZH/a4rWx76mtGtkAr8y5FyYpEyCQ6e0ECspsM/dZk74SHhYuV//RmyqJA0
 i24uBUAuXG5LRfhgk8CmYpO9QhtLPBqDb1LlaS7/FISYZ5ZmK/UgOVkbgfOVjAl6gDV0
 Sblg==
X-Gm-Message-State: AOAM532pi+5GWYrKhj8ti/U8PxJCuqtwmSJiCVnvdfQ1f/wdzeLI5jOw
 7T4WzJeET9U32/CV2mMCAp7Vig8UuErd9g==
X-Google-Smtp-Source: ABdhPJzRjuXLh4AZlQFLLJ2tYnHoPo8sPrRI0G/gV/pdEg4/dn9dHURMr3/Q/5PVBYTBCHkRNwO+WA==
X-Received: by 2002:a63:4e5e:: with SMTP id o30mr948390pgl.324.1599610622907; 
 Tue, 08 Sep 2020 17:17:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/43] tcg: Use tcg_out_dupi_vec from temp_load
Date: Tue,  8 Sep 2020 17:16:15 -0700
Message-Id: <20200909001647.532249-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having dupi pass though movi is confusing and arguably wrong.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                    |  6 +++-
 tcg/aarch64/tcg-target.c.inc |  7 ----
 tcg/i386/tcg-target.c.inc    | 63 ++++++++++++++++++++++++------------
 tcg/ppc/tcg-target.c.inc     |  6 ----
 4 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ad4b7fb90f..84bdcc6537 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3305,7 +3305,11 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
     case TEMP_VAL_CONST:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
                             preferred_regs, ts->indirect_base);
-        tcg_out_movi(s, ts->type, reg, ts->val);
+        if (ts->type <= TCG_TYPE_I64) {
+            tcg_out_movi(s, ts->type, reg, ts->val);
+        } else {
+            tcg_out_dupi_vec(s, ts->type, reg, ts->val);
+        }
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 479a9d26be..72c4d25fdb 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1007,13 +1007,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     case TCG_TYPE_I64:
         tcg_debug_assert(rd < 32);
         break;
-
-    case TCG_TYPE_V64:
-    case TCG_TYPE_V128:
-        tcg_debug_assert(rd >= 32);
-        tcg_out_dupi_vec(s, type, rd, value);
-        return;
-
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d8797ed398..e2852cbb09 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -966,30 +966,32 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
     }
 }
 
-static void tcg_out_movi(TCGContext *s, TCGType type,
-                         TCGReg ret, tcg_target_long arg)
+static void tcg_out_movi_vec(TCGContext *s, TCGType type,
+                             TCGReg ret, tcg_target_long arg)
+{
+    if (arg == 0) {
+        tcg_out_vex_modrm(s, OPC_PXOR, ret, ret, ret);
+        return;
+    }
+    if (arg == -1) {
+        tcg_out_vex_modrm(s, OPC_PCMPEQB, ret, ret, ret);
+        return;
+    }
+
+    int rexw = (type == TCG_TYPE_I32 ? 0 : P_REXW);
+    tcg_out_vex_modrm_pool(s, OPC_MOVD_VyEy + rexw, ret);
+    if (TCG_TARGET_REG_BITS == 64) {
+        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
+    } else {
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    }
+}
+
+static void tcg_out_movi_int(TCGContext *s, TCGType type,
+                             TCGReg ret, tcg_target_long arg)
 {
     tcg_target_long diff;
 
-    switch (type) {
-    case TCG_TYPE_I32:
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-#endif
-        if (ret < 16) {
-            break;
-        }
-        /* fallthru */
-    case TCG_TYPE_V64:
-    case TCG_TYPE_V128:
-    case TCG_TYPE_V256:
-        tcg_debug_assert(ret >= 16);
-        tcg_out_dupi_vec(s, type, ret, arg);
-        return;
-    default:
-        g_assert_not_reached();
-    }
-
     if (arg == 0) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
@@ -1018,6 +1020,25 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     tcg_out64(s, arg);
 }
 
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+#if TCG_TARGET_REG_BITS == 64
+    case TCG_TYPE_I64:
+#endif
+        if (ret < 16) {
+            tcg_out_movi_int(s, type, ret, arg);
+        } else {
+            tcg_out_movi_vec(s, type, ret, arg);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
 {
     if (val == (int8_t)val) {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7a5760bb23..bc6fb09adb 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -983,12 +983,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out_movi_int(s, type, ret, arg, false);
         break;
 
-    case TCG_TYPE_V64:
-    case TCG_TYPE_V128:
-        tcg_debug_assert(ret >= TCG_REG_V0);
-        tcg_out_dupi_vec(s, type, ret, arg);
-        break;
-
     default:
         g_assert_not_reached();
     }
-- 
2.25.1


