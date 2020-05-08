Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09008C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9DB20708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yT9P6ni7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9DB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7ta-0008Bu-VU
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hr-00075T-9p
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:43 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hq-0007Ns-22
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id w65so1358296pfc.12
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S9HEQQM80hO+EVGsjJ9OBeqQuwE6gwF9XnDO8sH6oUM=;
 b=yT9P6ni74P3IIwieb67fGOaBD0u0dLBSpPr/XJiQsXDki3FqrlDxV5uPoK+DXw9OfZ
 x0e8SQwUPIInV0cjOsWi001MNH2Im7UfZGnBXdmm+NcarvlSPsea5ddWyCJzZOZoAsIy
 Cj8p2JtkErm4fMacfNS1Gd1SRLJRDxqr5005rppexrciD2CfVoDtiUG8liq9AGqQbysv
 t8VTbLM3N/1ILAum1OGlgsBtp6XvMJwaRgcwy/yYfZC9K2wY2vrAQPF2xqYe/WUHlLBE
 KwOUU+iuOVKwb0iuxuAJfVTLZtL2y2jeAg+CdyK0/GHmHxDaxc0EWCRqMX8jJt+/reUp
 02+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S9HEQQM80hO+EVGsjJ9OBeqQuwE6gwF9XnDO8sH6oUM=;
 b=JUe3pK5bQLFgBU2AgppXPvsKjLC67fDJLX/UYvAtfyQzkTj1KWaR9Pf9I/CUMyQysR
 VRP6ezkPmt2wk3rdv6Gy2OXHjX0TdeCKXX/cEW7ytov/wnTDUR2tPtiJxDR+8ws2r1xx
 JgGhC7Q4s8VRY/D4fD1Wqb16zVRNWk0vp7Z9rHLj26IL5be875jXpHt/mdpKk1YrlxwH
 UirtNeYn3sPJ0lzUGJ9hQoDZeOq4BFEgJtc5Ga5x2MnCQD/LNQhJ3I25AVeGXs5nxQNv
 Fw9TFMm6O9mmSuFK3pwCpEt0w2ZtQsenugOURGfoj+1+s0c9bSaMiyKKfgUoTSAeFZdH
 74Xg==
X-Gm-Message-State: AGi0Puak9EnstlRL9tQtIyk1iEJ0Rcg/h70XUX0qkyif+g79E51ONBNJ
 uG7kC5xrg8AjrhdHyI3dI03EjOL5r2Q=
X-Google-Smtp-Source: APiQypKoRr3ZsxxaGP/BlGgOda2JSSRndmOEhPk00sl90mKw4Rfxz+ht3HDmdNtUYpPzdHClAmno+A==
X-Received: by 2002:a62:1415:: with SMTP id 21mr4116155pfu.203.1588962400203; 
 Fri, 08 May 2020 11:26:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/19] tcg: Increase tcg_out_dupi_vec immediate to int64_t
Date: Fri,  8 May 2020 11:26:13 -0700
Message-Id: <20200508182616.18318-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
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

While we don't store more than tcg_target_long in TCGTemp,
we shouldn't be limited to that for code generation.  We will
be able to use this for INDEX_op_dup2_vec with 2 constants.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  2 +-
 tcg/i386/tcg-target.inc.c    | 20 ++++++++++++--------
 tcg/ppc/tcg-target.inc.c     | 15 ++++++++-------
 tcg/tcg.c                    |  4 ++--
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index a7b1d36494..82b409ca7d 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -857,7 +857,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg rd, tcg_target_long v64)
+                             TCGReg rd, int64_t v64)
 {
     bool q = type == TCG_TYPE_V128;
     int cmode, imm8, i;
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 4118071dd9..5e73e5d02b 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -945,7 +945,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg ret, tcg_target_long arg)
+                             TCGReg ret, int64_t arg)
 {
     int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
 
@@ -958,7 +958,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS == 32 && arg == dup_const(MO_32, arg)) {
+        if (have_avx2) {
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
+        } else {
+            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+        }
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    } else {
         if (type == TCG_TYPE_V64) {
             tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
         } else if (have_avx2) {
@@ -966,14 +973,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         } else {
             tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
         }
-        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
-    } else {
-        if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
         } else {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+            new_pool_l2(s, R_386_32, s->code_ptr - 4, 0, arg, arg >> 32);
         }
-        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
     }
 }
 
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 7111da34dd..3f9690418f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -913,7 +913,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
-                             tcg_target_long val)
+                             int64_t val)
 {
     uint32_t load_insn;
     int rel, low;
@@ -921,20 +921,20 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
 
     low = (int8_t)val;
     if (low >= -16 && low < 16) {
-        if (val == (tcg_target_long)dup_const(MO_8, low)) {
+        if (val == dup_const(MO_8, low)) {
             tcg_out32(s, VSPLTISB | VRT(ret) | ((val & 31) << 16));
             return;
         }
-        if (val == (tcg_target_long)dup_const(MO_16, low)) {
+        if (val == dup_const(MO_16, low)) {
             tcg_out32(s, VSPLTISH | VRT(ret) | ((val & 31) << 16));
             return;
         }
-        if (val == (tcg_target_long)dup_const(MO_32, low)) {
+        if (val == dup_const(MO_32, low)) {
             tcg_out32(s, VSPLTISW | VRT(ret) | ((val & 31) << 16));
             return;
         }
     }
-    if (have_isa_3_00 && val == (tcg_target_long)dup_const(MO_8, val)) {
+    if (have_isa_3_00 && val == dup_const(MO_8, val)) {
         tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
         return;
     }
@@ -956,14 +956,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
         if (TCG_TARGET_REG_BITS == 64) {
             new_pool_label(s, val, rel, s->code_ptr, add);
         } else {
-            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+            new_pool_l2(s, rel, s->code_ptr, add, val >> 32, val);
         }
     } else {
         load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
         if (TCG_TARGET_REG_BITS == 64) {
             new_pool_l2(s, rel, s->code_ptr, add, val, val);
         } else {
-            new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+            new_pool_l4(s, rel, s->code_ptr, add,
+                        val >> 32, val, val >> 32, val);
         }
     }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a84a9d3d63..18ebcc98f6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -117,7 +117,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg dst, TCGReg base, intptr_t offset);
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg dst, tcg_target_long arg);
+                             TCGReg dst, int64_t arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                            unsigned vece, const TCGArg *args,
                            const int *const_args);
@@ -133,7 +133,7 @@ static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     g_assert_not_reached();
 }
 static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                                    TCGReg dst, tcg_target_long arg)
+                                    TCGReg dst, int64_t arg)
 {
     g_assert_not_reached();
 }
-- 
2.20.1


