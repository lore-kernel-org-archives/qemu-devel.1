Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC4B206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i/qst5NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC4B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB8y-0006Jr-Tg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuh-0001pt-2m
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:47 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAue-0005c7-TQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:46 -0400
Received: by mail-pg1-x52d.google.com with SMTP id n5so873274pgf.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tzS1NhxcZynnC3BiJPnOg5ltt6hy7hD1fUmF5Dof7xY=;
 b=i/qst5NB3gpcKwigmmRG8UBZDn+3ciJVdwAhIxCrmYHsBKD13BM5d1UpyV4yX3uW6i
 YwcwyfFSyzQOGEn+hhXJiaf0JTZ2CDD+twqnQ5tWhs0T5ZfPjIMBJwfu5o56fblvv0LI
 J77bX1HDwl9vfei6ED7NXg5K5JBWqL4rGAwiHYa5/2itJI9jluqRfq1jLQq2Sqp93xag
 B0zpQTrjGCshVvxtQ01mx6bwEngu8gdqKwfo7n81lOdEVhCrRgm/eFmhGQ3aHBRtUUww
 FkR2LwXBQY4SG0iPqi7okac2+EheRBVBkNLXz/FffFXZ1x2AAcoJEJ4leHTChoPCUXR9
 2XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tzS1NhxcZynnC3BiJPnOg5ltt6hy7hD1fUmF5Dof7xY=;
 b=lFBprkDFuSDI2RpLUlKEOdvAhirYtYVcBHz4eqOqkEWNOntIn9RQBiagvDT81w9Oww
 7r5gdQWZboH5ykQLUPy8A03jy/skigQFptGtKkdaTF728uD0/hCD0EygFHNb2dQYB/pt
 JVPPGt2pCGG2fcev2yQqyytcXUW4CExYl7IxotKsf54QJal1xYuq4n3fzl30Mz8TdlBv
 +6ECAnqCvlhdXSho5RwYGUQShiNpoa6aimZshj8WKscgICv7dwzsb4e9Yu7cG8Iy1f6i
 iHPOR+72akIVmo6C0mVUGFroJ5Mzy0vw+CpZa0MCRxYyssMo4Kb8yG3EiZihtVKCctg0
 ZVcw==
X-Gm-Message-State: AOAM5302whtER8UDGaI0V7niSJoczE0YMdtXET/c15f47NzWqL+1H4Fo
 YZYuT08XdO+v3M77335IPwSNIKH9X1Y=
X-Google-Smtp-Source: ABdhPJxMdS6cWMWKiBf1UK/uCt6dzGE47WB/MNcPgyXBErNe45ULB9WKJKk8w3Csj9zmoSA+2zQ7QQ==
X-Received: by 2002:aa7:8005:: with SMTP id j5mr26374609pfi.142.1595409583246; 
 Wed, 22 Jul 2020 02:19:43 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:42 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 29/76] target/riscv: rvv-0.9: take fractional LMUL into
 vector max elements calculation
Date: Wed, 22 Jul 2020 17:15:52 +0800
Message-Id: <20200722091641.8834-30-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Update vext_get_vlmax() and MAXSZ() to take fractional LMUL into
calculation for RVV 0.9.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h                      | 32 +++++++++++++++----------
 target/riscv/insn_trans/trans_rvv.inc.c | 11 ++++++++-
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a650df0441..446ce1a667 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -25,6 +25,8 @@
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
 
+#include "internals.h"
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #define TYPE_RISCV_CPU "riscv-cpu"
@@ -379,20 +381,14 @@ FIELD(TB_FLAGS, VMA, 12, 1)
 /* Skip MSTATUS_FS (0x6000) fields */
 FIELD(TB_FLAGS, VILL, 15, 1)
 
-/*
- * A simplification for VLMAX
- * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
- * = (VLEN << LMUL) / (8 << SEW)
- * = (VLEN << LMUL) >> (SEW + 3)
- * = VLEN >> (SEW + 3 - LMUL)
- */
 static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
 {
     uint8_t sew, lmul;
-
     sew = FIELD_EX64(vtype, VTYPE, VSEW);
-    lmul = FIELD_EX64(vtype, VTYPE, VLMUL);
-    return cpu->cfg.vlen >> (sew + 3 - lmul);
+    lmul = (FIELD_EX64(vtype, VTYPE, VFLMUL) << 2)
+            | FIELD_EX64(vtype, VTYPE, VLMUL);
+    float flmul = flmul_table[lmul];
+    return cpu->cfg.vlen * flmul / (1 << (sew + 3));
 }
 
 static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
@@ -404,13 +400,23 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     *cs_base = 0;
 
     if (riscv_has_ext(env, RVV)) {
+        /*
+         * If env->vl equals to VLMAX, we can use generic vector operation
+         * expanders (GVEC) to accerlate the vector operations.
+         * However, as LMUL could be a fractional number. The maximum
+         * vector size can be operated might be less than 8 bytes,
+         * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
+         * only when maxsz >= 8 bytes.
+         */
         uint32_t vlmax = vext_get_vlmax(env_archcpu(env), env->vtype);
-        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl);
+        uint32_t sew = FIELD_EX64(env->vtype, VTYPE, VSEW);
+        uint32_t maxsz = vlmax * (1 << sew);
+        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl)
+                           && (maxsz >= 8);
 
         flags = FIELD_DP32(flags, TB_FLAGS, VILL,
                     FIELD_EX64(env->vtype, VTYPE, VILL));
-        flags = FIELD_DP32(flags, TB_FLAGS, SEW,
-                    FIELD_EX64(env->vtype, VTYPE, VSEW));
+        flags = FIELD_DP32(flags, TB_FLAGS, SEW, sew);
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
                     (FIELD_EX64(env->vtype, VTYPE, VFLMUL) << 2)
                         | FIELD_EX64(env->vtype, VTYPE, VLMUL));
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4274daf08e..89209a5d18 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1270,7 +1270,16 @@ GEN_VEXT_TRANS(vamomaxuei64_v, 64, 8,  rwdvm, amo_op, amo_check)
 /*
  *** Vector Integer Arithmetic Instructions
  */
-#define MAXSZ(s) (s->vlen >> (3 - s->lmul))
+
+/*
+ * MAXSZ returns the maximum vector size can be operated in bytes,
+ * which is used in GVEC IR when vl_eq_vlmax flag is set to true
+ * to accerlate vector operation.
+ */
+static inline uint32_t MAXSZ(DisasContext *s)
+{
+    return (s->vlen >> 3) * s->flmul;
+}
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
 {
-- 
2.17.1


