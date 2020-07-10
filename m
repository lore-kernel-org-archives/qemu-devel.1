Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6E320720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MzsT+sZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6E320720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsh6-000605-Ax
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfM-00064d-DF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfJ-0006xp-Ut
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id d4so2378104pgk.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ohs91PieSnw5TvEAg+p1lSTKb7MKGfyZY+BVcb712pA=;
 b=MzsT+sZ3dIQXsaeEp6zB/0vFADms4TsZzNgtfKvqtwr2NgjII7F3vWhamNl9G5eYhV
 xukZXtNNmkliVDEhgMhyK3zTBArynvBr00Z2//1miPp/d5Vttlr95f7oZWGUBpBcu4bT
 5mT1pHxZPnUqrnDI6xL/VYRFgBPm/R1d+wepICEb8TIkNO96w7ZyxsBFk4tibz2mV/CB
 SSoNGTsrGNP2NE7dHgkIPjKZeYHK8S1cURWPyMUwsmsaZ0c8Sa17sums+Cd+Bwv6qJid
 HbYJQaTDU2ubFNXJTOYOkzNz3XTVOrebXStqv15ccmRlqxoYtGVkFOffTQ25UVbjvjVH
 KLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ohs91PieSnw5TvEAg+p1lSTKb7MKGfyZY+BVcb712pA=;
 b=UvlMaDh5JemL4VpbF4q60CY6UVdMR2RFzYc71R7PDFCT2hqnmUBL2DqkdZgg+EkhCT
 Un721ZihVE+UYWU1ullMoP/DoATfAqDpequLMlhyb1cb5KazObfL/2V1Q2Z4acfWDj8G
 BfF5RX1PqRhJncnJF7j0RLLEe3dFgPyJpN3tgYzD/voCa9qnV3HZipFKTeqCypehxcuJ
 9R7d1rDSvN2833YhChkN6C6RHxn0hQ0/hAC7VZwLEMjfAT/6qfUdwmibvF41bO17Fafj
 F/F9T520NjBBy/5KXnCN57SVlyCHlCHh936Bg5nW349Qt0apyOK+pQo81dY81Oapv84e
 mulQ==
X-Gm-Message-State: AOAM532n+UwrUCPBschItjWQ6FgbDU9dfgxoi+L4SV1Xy7astQJ0VtEH
 6DVODXawhjufF13clJRU0Hr8oiunFWLGzg==
X-Google-Smtp-Source: ABdhPJw14/9pQb/xw3H7JizVOYlofxxRjteIr9J+/WBBiZayshlMv9qbXme9BdA2LvYONT9jpIT2/A==
X-Received: by 2002:a63:5fcc:: with SMTP id t195mr48749146pgb.56.1594378440538; 
 Fri, 10 Jul 2020 03:54:00 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:54:00 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 51/65] target/riscv: rvv-0.9: single-width floating-point
 reduction
Date: Fri, 10 Jul 2020 18:49:05 +0800
Message-Id: <20200710104920.13550-52-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x541.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |   3 +
 target/riscv/insn32.decode              |   3 +-
 target/riscv/insn_trans/trans_rvv.inc.c |   1 +
 target/riscv/vector_helper.c            | 144 +++++++++++++++++++-----
 4 files changed, 120 insertions(+), 31 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index caf335a703..e1dc1f83d3 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1066,6 +1066,9 @@ DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredosum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredosum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredosum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e4b36af89e..0fe46c10c2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -575,7 +575,8 @@ vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
 vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
 vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
 # Vector ordered and unordered reduction sum
-vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
+vfredsum_vs     000001 . ..... ..... 001 ..... 1010111 @r_vm
+vfredosum_vs    000011 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 # Vector widening ordered and unordered float reduction sum
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index f022c5f5e8..f308b2bc3b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2773,6 +2773,7 @@ GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_widen_check)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
 GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
+GEN_OPFVV_TRANS(vfredosum_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0a8f62b4a9..76ce3c8e3e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4675,43 +4675,127 @@ GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD)
 GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
-#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
-void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
-                  void *vs2, CPURISCVState *env,           \
-                  uint32_t desc)                           \
-{                                                          \
-    uint32_t vm = vext_vm(desc);                           \
-    uint32_t vta = vext_vta(desc);                         \
-    uint32_t vl = env->vl;                                 \
-    uint32_t i;                                            \
-    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;         \
-    TD s1 =  *((TD *)vs1 + HD(0));                         \
-                                                           \
-    for (i = 0; i < vl; i++) {                             \
-        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
-        if (!vm && !vext_elem_mask(v0, i)) {               \
-            continue;                                      \
-        }                                                  \
-        s1 = OP(s1, (TD)s2, &env->fp_status);              \
-    }                                                      \
-    *((TD *)vd + HD(0)) = s1;                              \
-    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                 \
+
+/*
+ * If f is NaN, canonicalize NaN f.
+ * Set the invalid exception flag if f is a sNaN.
+ */
+static uint64_t propagate_nan(uint64_t f, uint32_t sew, float_status * s)
+{
+    target_ulong ret;
+
+    switch (sew) {
+    case 16:
+        ret = fclass_h(f);
+        /* check if f is NaN */
+        if (ret & 0x300) {
+            /* check if f is a sNaN */
+            if (ret & 0x100) {
+                s->float_exception_flags |= float_flag_invalid;
+            }
+            /* canonicalize NaN */
+            return float16_default_nan(s);
+        } else {
+            return f;
+        }
+        break;
+    case 32:
+        ret = fclass_s(f);
+        /* check if f is NaN */
+        if (ret & 0x300) {
+            /* check if f is a sNaN */
+            if (ret & 0x100) {
+                s->float_exception_flags |= float_flag_invalid;
+            }
+            /* canonicalize NaN */
+            return float32_default_nan(s);
+        } else {
+            return f;
+        }
+        break;
+    case 64:
+        ret = fclass_d(f);
+        /* check if f is NaN */
+        if (ret & 0x300) {
+            /* check if f is a sNaN */
+            if (ret & 0x100) {
+                s->float_exception_flags |= float_flag_invalid;
+            }
+            /* canonicalize NaN */
+            return  float64_default_nan(s);
+        } else {
+            return f;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
+#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, PROPAGATE_NAN, OP, CLEAR_FN) \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,                           \
+                  void *vs2, CPURISCVState *env,                           \
+                  uint32_t desc)                                           \
+{                                                                          \
+    uint32_t vm = vext_vm(desc);                                           \
+    uint32_t vta = vext_vta(desc);                                         \
+    uint32_t vl = env->vl;                                                 \
+    uint32_t i;                                                            \
+    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;                         \
+    bool active = false;                                                   \
+    TD s1 =  *((TD *)vs1 + HD(0));                                         \
+                                                                           \
+    for (i = 0; i < vl; i++) {                                             \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                                   \
+        if (!vm && !vext_elem_mask(v0, i)) {                               \
+            continue;                                                      \
+        }                                                                  \
+        active = true;                                                     \
+        s1 = OP(s1, (TD)s2, &env->fp_status);                              \
+    }                                                                      \
+                                                                           \
+    if (vl > 0) {                                                          \
+        if (PROPAGATE_NAN && !active) {                                    \
+            *((TD *)vd + HD(0)) = propagate_nan(s1, sizeof(TD) * 8,        \
+                                                &env->fp_status);          \
+        } else {                                                           \
+            *((TD *)vd + HD(0)) = s1;                                      \
+        }                                                                  \
+    }                                                                      \
+    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                                 \
+}
+
+/* Ordered sum */
+GEN_VEXT_FRED(vfredosum_vs_h, uint16_t, uint16_t, H2, H2, false,
+              float16_add, clearh)
+GEN_VEXT_FRED(vfredosum_vs_w, uint32_t, uint32_t, H4, H4, false,
+              float32_add, clearl)
+GEN_VEXT_FRED(vfredosum_vs_d, uint64_t, uint64_t, H8, H8, false,
+              float64_add, clearq)
+
 /* Unordered sum */
-GEN_VEXT_FRED(vfredsum_vs_h, uint16_t, uint16_t, H2, H2, float16_add, clearh)
-GEN_VEXT_FRED(vfredsum_vs_w, uint32_t, uint32_t, H4, H4, float32_add, clearl)
-GEN_VEXT_FRED(vfredsum_vs_d, uint64_t, uint64_t, H8, H8, float64_add, clearq)
+GEN_VEXT_FRED(vfredsum_vs_h, uint16_t, uint16_t, H2, H2, true,
+              float16_add, clearh)
+GEN_VEXT_FRED(vfredsum_vs_w, uint32_t, uint32_t, H4, H4, true,
+              float32_add, clearl)
+GEN_VEXT_FRED(vfredsum_vs_d, uint64_t, uint64_t, H8, H8, true,
+              float64_add, clearq)
 
 /* Maximum value */
-GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, float16_maxnum, clearh)
-GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, float32_maxnum, clearl)
-GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum, clearq)
+GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, false,
+              float16_maxnum_noprop, clearh)
+GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, false,
+              float32_maxnum_noprop, clearl)
+GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, false,
+              float64_maxnum_noprop, clearq)
 
 /* Minimum value */
-GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum, clearh)
-GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum, clearl)
-GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
+GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, false,
+              float16_minnum_noprop, clearh)
+GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, false,
+              float32_minnum_noprop, clearl)
+GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, false,
+              float64_minnum_noprop, clearq)
 
 /* Vector Widening Floating-Point Reduction Instructions */
 /* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
-- 
2.17.1


