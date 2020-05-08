Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0875CC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E1C21841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7TfdgZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E1C21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4yS-0002HX-Tm
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lP-000689-3W
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lN-00034s-P3
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:10 -0400
Received: by mail-pl1-x644.google.com with SMTP id t16so844724plo.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dTuL5S6jrin2+ysLj262uH3ZxCyTSd1WxaHvCqnz6aM=;
 b=x7TfdgZ2+UWmNvM7v4XvuK0wV5TYbDWyFenPvkv3Jgnd01hZC8/sbZxsyuYDSfKWO/
 oArdX5E4OOHbk/lmNKjZv3qeA/TzmH8lXftIhU/vCsd4I0Srkxfko3Dfo1mRGA3FPSzc
 XDAHV84MMBzRCsKuakTvGimlVePaeNvn2EX4vh8F+RT2+XGxHDKtfSbGSKMxsRLZoRnz
 VmrGPnkXbGN/X+WhtbyF1QgXad7yiJQLuK2UE07QzBAx1xcjRie4+XUI4f7JXI0fzOta
 dK77aRTVW6nMVJwfIWPyhoeFRshDyFiAwLJiY6upkwsu8HhOHbv5NF7tSfT6AZWhv8GG
 lmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dTuL5S6jrin2+ysLj262uH3ZxCyTSd1WxaHvCqnz6aM=;
 b=JdzBrrSQ3KKOYTQqqsLwOcNgCBltQFAQ70vet7DC8MBJ+kccfvpVVF8YbutHMS13zV
 oOaHuQeTlMvx1cCygZgmTdWS0Ejy4/ek2KvkUK+siC9+7BJai0TZaRBXmM7m5AA3YfR1
 f/aB7hRbzUSZD/jQw2d7gWyxuR4tpzGBu6d71RGnd6zs+yTakUCEYjLj+WJBOAeT0Ec/
 SEjtA7sdZH0yFc50svaw0vrwD0dOxmygXgIMzaDWDidvNa9Oo4WqaGb9jPJq0h/apAsc
 MBmYnLK3qoFxTHHSJDM/Jt3ilkMZ+RjUJOZATXjoQ80ik2FgMrOGBt7uf2hoJ/Ff8Nd4
 kc/A==
X-Gm-Message-State: AGi0Pua9LCYLGJWgxqROvozn211W0MVQUYxFjcO2dqrvrToOB3oQAICv
 qI95l2qJ+hM+iKBco7vixA5VsRblev0=
X-Google-Smtp-Source: APiQypI0Eua5D76zvcQFKpgZYY7TSK6kHB3ozruj6Ntb6WOKtyd1KBxxWiZ9V3kj6AiGY31NivITMA==
X-Received: by 2002:a17:90a:f40f:: with SMTP id
 ch15mr2368961pjb.178.1588951087480; 
 Fri, 08 May 2020 08:18:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:18:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/19] tcg: Use tcg_out_dupi_vec from temp_load
Date: Fri,  8 May 2020 08:17:43 -0700
Message-Id: <20200508151747.6166-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
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

Having dupi pass though movi is confusing and arguably wrong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  7 ----
 tcg/i386/tcg-target.inc.c    | 63 ++++++++++++++++++++++++------------
 tcg/ppc/tcg-target.inc.c     |  6 ----
 tcg/tcg.c                    |  8 ++++-
 4 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index d065fd600b..a7b1d36494 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1010,13 +1010,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
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
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index bc957e7bed..4118071dd9 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -977,30 +977,32 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
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
@@ -1029,6 +1031,25 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
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
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c525439b62..7111da34dd 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -987,12 +987,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
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
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7a23ccb017..a84a9d3d63 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3400,7 +3400,13 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
     case TEMP_VAL_CONST:
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
                             preferred_regs, ts->indirect_base);
-        tcg_out_movi(s, ts->type, reg, ts->val);
+        if (ts->type <= TCG_TYPE_I64) {
+            tcg_out_movi(s, ts->type, reg, ts->val);
+        } else if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_dupi_vec(s, ts->type, reg, ts->val);
+        } else {
+            tcg_out_dupi_vec(s, ts->type, reg, dup_const(MO_32, ts->val));
+        }
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
-- 
2.20.1


