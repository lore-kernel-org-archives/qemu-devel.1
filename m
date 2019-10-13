Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10553C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAA1206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUdCnRpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAA1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmUQ-0002Ms-F1
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJL-0006ii-5o
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJJ-0000s1-Kg
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:33189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJJ-0000rf-Es
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id i76so8944581pgc.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cUZEWTE4U4KpIW+xnrtwY7u98g/gstklJJokJGVCFWE=;
 b=iUdCnRpuCZVkHYzvyKgFKwDgFCvU08AHyxxGMrUZhBs+WbJzaKMe7ZgUazwkQky7dU
 GiowdMv/4yMvl9A9eVjoOb7AH1gsrnrxTg4N22htvwUsUxyQdQp/BNSnR9gHDKKbTn33
 uiIfYchcONeY/tYOq9A4APZ7Js1Xl/azEV04YOrCTNv7jzWn6eIErtyLmzlneVTAdCBT
 RRWyk9rpR+Ehil+/wZd9q8H4oUDMmrejkoudPrxiss31VWOJnmZp9g4uSBES+q1vRUl9
 v+HWUgiTr47hF0JLVWlZXD2S/laxrR70Xt9forl7VfiALtSIDt9QNn3ajXM84kw3rHMa
 Sh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cUZEWTE4U4KpIW+xnrtwY7u98g/gstklJJokJGVCFWE=;
 b=fZhGYwu8XlbSoF6czbhE4omJi0dGOyCVipmIBNcZbVoMIZ/aWBMPb7AYtkth4QV8IL
 PWRBDGbLlIabYc79A5UGTEBN7rNPmJIH6dTt/jXmDcKYUIwzAbAN310uTab2sbG2VGv7
 sjNNup5n3vXIPstCE4mk0X2YBkNyyk0onbtS7zQoJyvpUegmY78GEa1K9KYb/p7pmGz3
 L/o6WnSgyPljR2DBYhozRF/oQGeXYGV/xgDtIwMiD6vDqn4fWnNPC7zvMSaT9/Cmie93
 GvpOCAxL48dqsVwwD3uLRLJ7sSy5NJB/SboFEPfBvsiKdPegZY7HUEbqAvvirmoGrFTI
 GVzg==
X-Gm-Message-State: APjAAAXGWQGWNsOFdTWtU6X96dlbT6F70Yrdax7kL5UxJ1W7bVpqHO/B
 8mj8XmErjG7DCUezV9rSNDoX0h0uIMg=
X-Google-Smtp-Source: APXvYqw0GRsAGkpwsFXsUSShO7ZaqNgc5fILnUrPKJXLNF0SIol3txA3/VGAiti3ReyVwKPwN0iAvg==
X-Received: by 2002:aa7:8b4d:: with SMTP id i13mr30330782pfd.226.1571005556055; 
 Sun, 13 Oct 2019 15:25:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] tcg/ppc: Enable tcg backend vector compilation
Date: Sun, 13 Oct 2019 15:25:28 -0700
Message-Id: <20191013222544.3679-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce all of the flags required to enable tcg backend vector support,
and a runtime flag to indicate the host supports Altivec instructions.

For now, do not actually set have_isa_altivec to true, because we have not
yet added all of the code to actually generate all of the required insns.
However, we must define these flags in order to disable ifndefs that create
stub versions of the functions added here.

The change to tcg_out_movi works around a buglet in tcg.c wherein if we
do not define tcg_out_dupi_vec we get a declared but not defined Werror,
but if we only declare it we get a defined but not used Werror.  We need
to this change to tcg_out_movi eventually anyway, so it's no biggie.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     | 25 ++++++++++++++++
 tcg/ppc/tcg-target.opc.h |  5 ++++
 tcg/ppc/tcg-target.inc.c | 62 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 89 insertions(+), 3 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 35ba8693fa..498e950f0c 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -65,6 +65,7 @@ typedef enum {
 } TCGPowerISA;
 
 extern TCGPowerISA have_isa;
+extern bool have_altivec;
 
 #define have_isa_2_06  (have_isa >= tcg_isa_2_06)
 #define have_isa_3_00  (have_isa >= tcg_isa_3_00)
@@ -143,6 +144,30 @@ extern TCGPowerISA have_isa;
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
+/*
+ * While technically Altivec could support V64, it has no 64-bit store
+ * instruction and substituting two 32-bit stores makes the generated
+ * code quite large.
+ */
+#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v128             have_altivec
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_cmp_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
new file mode 100644
index 0000000000..fa680dd6a0
--- /dev/null
+++ b/tcg/ppc/tcg-target.opc.h
@@ -0,0 +1,5 @@
+/*
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index db28ae7eb1..c7ce0f923c 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -66,6 +66,7 @@ static tcg_insn_unit *tb_ret_addr;
 
 TCGPowerISA have_isa;
 static bool have_isel;
+bool have_altivec;
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG 30
@@ -714,10 +715,31 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 }
 
-static inline void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
-                                tcg_target_long arg)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long val)
 {
-    tcg_out_movi_int(s, type, ret, arg, false);
+    g_assert_not_reached();
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
+                         tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < TCG_REG_V0);
+        tcg_out_movi_int(s, type, ret, arg, false);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= TCG_REG_V0);
+        tcg_out_dupi_vec(s, type, ret, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool mask_operand(uint32_t c, int *mb, int *me)
@@ -2602,6 +2624,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     }
 }
 
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg dst, TCGReg src)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg out, TCGReg base, intptr_t offset)
+{
+    g_assert_not_reached();
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    g_assert_not_reached();
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    g_assert_not_reached();
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
@@ -2804,6 +2856,10 @@ static void tcg_target_init(TCGContext *s)
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    if (have_altivec) {
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
+    }
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
-- 
2.17.1


