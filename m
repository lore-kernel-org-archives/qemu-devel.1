Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A93C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502AD22CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nqee0zeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502AD22CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dkV-0003pi-V1
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRn-0002dy-Ck
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:42684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRl-0007rU-P0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id q17so27288841pls.9
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nX6MJ9PYiWQKpC5zQpm1pvFGgxZuOcYLJio0AUt2XK8=;
 b=Nqee0zeVycSdmGnb/QA/jFgJ2oLQya+RO1oTsv0A3UhlsOCmVA0C4YlEJ1aRr2e1MZ
 yDLXMFps6HZMUk/MoKtssYkwCRE/gIovOzy7d2N5i0OM0vMb/cbPtObewR4G811WOymQ
 kfLcfEuLRDIzU5wjgxhmBYyfFFMB21EyGcpjg43Po2MWm9eUDl/tDAMi/kRfMm+e9o1q
 aLyKqSv3YDuOz0AOvPVNko7itnTy0shpAtS8LHm+m4D9ObQcxM7AGWccihloDhExd0OI
 vFibhUSRk1pi9Don+bKaH/XfpFhec1lfXXjSMrRMRe3MsaWYkt2kJcBOuOwah6uGwHZd
 dC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nX6MJ9PYiWQKpC5zQpm1pvFGgxZuOcYLJio0AUt2XK8=;
 b=ac7FJt9+V2s417qsF+Fe2C0cla1+pKuPShBxr36h5hrYyTWvDE6JQAZy93QDbbryRQ
 ArkuptsfHFzM22BKCO+DygAeqpfkYvz72FS4OJp6h4duhZsrLTyw8gWir9wLP4G+ueAw
 XiTXdehdvFjz3noQFOP4UYTfZBYxUrtAkGKyKtRebqNbukKjVYALWKmdqE8LoCfhCwNe
 mYD7h3tM7fHPJ1sOpCFZ3M7PL/xTw0yMAz59ciq0sg08TpWisyJrtntlA5VJMcJvJAxA
 gF64nCWamJTOFl2DIL0iEFcf4Cv+PoB7KBepceADQQSmlvn+nizHelJ7tK0S2ItMAy+1
 zNGw==
X-Gm-Message-State: AOAM532GU7tj0Iq5JNT/G+vwE5REJvrWL5VCadsOoBvOHnvSZg5C7+pE
 B1QTH9S4fT45piA9YwXFDEGhNBHfZOg=
X-Google-Smtp-Source: ABdhPJzh4qsQ2Uc/uwOz6+xvIpv3WuDLqHwNASnpaKpX9obRlkusvSCsxZCIFjhCS8T/KNMMpw+hLg==
X-Received: by 2002:a17:902:368:: with SMTP id
 95mr7355581pld.279.1596710908164; 
 Thu, 06 Aug 2020 03:48:28 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:27 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 27/71] target/riscv: rvv-1.0: take fractional LMUL into
 vector max elements calculation
Date: Thu,  6 Aug 2020 18:46:24 +0800
Message-Id: <20200806104709.13235-28-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Update vext_get_vlmax() and MAXSZ() to take fractional LMUL into
calculation for RVV 1.0.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h                      | 44 ++++++++++++++++++-------
 target/riscv/insn_trans/trans_rvv.inc.c | 11 ++++++-
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8b5e6429015..78264d6ffc4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -376,18 +376,28 @@ FIELD(TB_FLAGS, SEW, 6, 3)
 FIELD(TB_FLAGS, VILL, 11, 1)
 
 /*
- * A simplification for VLMAX
- * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
- * = (VLEN << LMUL) / (8 << SEW)
- * = (VLEN << LMUL) >> (SEW + 3)
- * = VLEN >> (SEW + 3 - LMUL)
+ * Encode LMUL to lmul as following:
+ *     LMUL    vlmul    lmul
+ *      1       000       0
+ *      2       001       1
+ *      4       010       2
+ *      8       011       3
+ *      -       100       -
+ *     1/8      101      -3
+ *     1/4      110      -2
+ *     1/2      111      -1
+ *
+ * then, we can calculate VLMAX = vlen >> (vsew + 3 - lmul)
+ * e.g. vlen = 256 bits, SEW = 16, LMUL = 1/8
+ *      => VLMAX = vlen >> (1 + 3 - (-3))
+ *               = 256 >> 7
+ *               = 2
  */
 static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
 {
-    uint8_t sew, lmul;
-
-    sew = FIELD_EX64(vtype, VTYPE, VSEW);
-    lmul = FIELD_EX64(vtype, VTYPE, VLMUL);
+    uint8_t sew = FIELD_EX64(vtype, VTYPE, VSEW);
+    uint8_t vlmul = FIELD_EX64(vtype, VTYPE, VLMUL);
+    int8_t lmul = (int8_t)(vlmul << 5) >> 5;
     return cpu->cfg.vlen >> (sew + 3 - lmul);
 }
 
@@ -400,12 +410,22 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
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
                     FIELD_EX64(env->vtype, VTYPE, VLMUL));
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 725f36fcfcc..82403dff4b9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1255,7 +1255,16 @@ GEN_VEXT_TRANS(vamomaxuei64_v, 64, 35, rwdvm, amo_op, amo_check)
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


