Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CCDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BC3206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Hkg0Uas5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BC3206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7awJ-0000Hy-97
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arO-00087H-2H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:41836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arL-00052e-7y
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id a79so7888341pfa.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ilv4oS+naP+1NFBXaPazACxKaoolnVKjPTkRbsbHgqo=;
 b=Hkg0Uas5/sT7pXIuTthsWp5HsaSwx7RGQT+cGGWHydcDMXwiUeWc6XRRJOjr73Ans+
 xix2AWMsbuMMYS4ztIZpP5X0e1xdiMRiy2IAJuGZ10EBX2T7lG3Ekcz5quh6hFkJ6xlg
 YBqFAw0RHSoF+fEJDW6v1Oe6wgP/hWDmKwvzmtOjK6ygwjD6yted3i8ql3fyc7Kbt3aQ
 J/zUM+JqL07uD3edaLDRcvvqnWfSxD8T13S8/9Zj4RCJ9gLngUd8fyU+Jcb282A8WxSq
 8ZLGTm2HPFDjCvICdo84gVE/naOGJWG5snEM+nwCrNjvh1kfuXpi8QdnRmXpXyytJxh3
 eG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ilv4oS+naP+1NFBXaPazACxKaoolnVKjPTkRbsbHgqo=;
 b=LRnbfJD+FQbXF+aDBPnHQj/d6FrPUwp0ghZnMAE9EeXMZRyGMTZMjGzu3TH51hC/RW
 bGuRfTIBjFWhEC3ajzAPwzYbVE3Qc6BoQ+1icgNRuXFiDmsAG567RgJEyY7jyDZWXk0F
 AEZXYo/2kCZD5ZYFyY1vCxsAv95E+1ZqeoecXiltuwrE6cvCNx7zK6Yc5sbb/N76m/Ks
 i2A17HtQRUOqYSGBzR7VyI8T2zqvGT5h6sQHxbj1jPYNWqMxn8lGZ+Egq0Eg6N7bos4L
 UwHDApFlyub+dPgW4TX4QLh91mPywq5Npj+NkUG4p5AIn3WpqqTZNbhx5IgTjJBnxSbI
 dWbA==
X-Gm-Message-State: AOAM531PbspJF5V4gBRiWEDA4E+ZHqKQjph6/POe7PARdrIqpiNb7utf
 IgyFTcXcQtbonRNoU4Y0kPZzkUE4vD8+tA==
X-Google-Smtp-Source: ABdhPJz3ik/LPT6icwdxnbh1LuVLR+WT41vbNWHvf+xypCN2dPgAOc0SVqrStqAAV5ln2mgX9cCfXw==
X-Received: by 2002:a63:6f02:: with SMTP id k2mr9238956pgc.191.1597654273214; 
 Mon, 17 Aug 2020 01:51:13 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 24/70] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
Date: Mon, 17 Aug 2020 16:49:09 +0800
Message-Id: <20200817084955.28793-25-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42a.google.com
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

Unlike other vector instructions, load/store vector instructions return
the maximum vector size calculated with EMUL.
For other vector instructions, return VLMAX as the maximum vector size.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 57 +++++++++++-----
 target/riscv/vector_helper.c            | 90 ++++++++++++++-----------
 2 files changed, 88 insertions(+), 59 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 6a2f175b50a..334e1fc123b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -583,11 +583,17 @@ static bool vext_check_isa_ill(DisasContext *s)
 static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE * a) \
 {                                                            \
     if (CHECK(s, a, EEW)) {                                  \
-        return OP(s, a, SEQ);                                \
+        return OP(s, a, EEW, SEQ);                           \
     }                                                        \
     return false;                                            \
 }
 
+static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)
+{
+    int8_t emul = ctzl(eew) - (s->sew + 3) + s->lmul;
+    return emul < 0 ? 0 : emul;
+}
+
 /*
  *** unit stride load and store
  */
@@ -611,7 +617,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
 
     /*
      * As simd_desc supports at most 256 bytes, and in this implementation,
-     * the max vector group length is 2048 bytes. So split it into two parts.
+     * the max vector group length is 1024 bytes. So split it into two parts.
      *
      * The first part is vlen in bytes, encoded in maxsz of simd_desc.
      * The second part is lmul, encoded in data of simd_desc.
@@ -635,7 +641,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     return true;
 }
 
-static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_us *fn;
@@ -653,8 +659,14 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
         return false;
     }
 
+    /*
+     * Vector load/store instructions have the EEW encoded
+     * directly in the instructions. The maximum vector size is
+     * calculated with EMUL rather than LMUL.
+     */
+    uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
@@ -671,7 +683,7 @@ GEN_VEXT_TRANS(vle16_v, 16, 1, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle32_v, 32, 2, r2nfvm, ld_us_op, ld_us_check)
 GEN_VEXT_TRANS(vle64_v, 64, 3, r2nfvm, ld_us_op, ld_us_check)
 
-static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_us *fn;
@@ -689,8 +701,9 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
         return false;
     }
 
+    uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
@@ -749,7 +762,8 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     return true;
 }
 
-static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew,
+                         uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_stride *fn;
@@ -763,8 +777,9 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
         return false;
     }
 
+    uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
@@ -781,7 +796,8 @@ GEN_VEXT_TRANS(vlse16_v, 16, 1, rnfvm, ld_stride_op, ld_stride_check)
 GEN_VEXT_TRANS(vlse32_v, 32, 2, rnfvm, ld_stride_op, ld_stride_check)
 GEN_VEXT_TRANS(vlse64_v, 64, 3, rnfvm, ld_stride_op, ld_stride_check)
 
-static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew,
+                         uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_stride *fn;
@@ -791,8 +807,9 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
         gen_helper_vsse32_v,  gen_helper_vsse64_v
     };
 
+    uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     fn = fns[seq];
     if (fn == NULL) {
@@ -856,7 +873,7 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     return true;
 }
 
-static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_index *fn;
@@ -889,8 +906,9 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     fn = fns[seq][s->sew];
 
+    uint8_t emul = vext_get_emul(s, 1 << (s->sew + 3));
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
@@ -907,7 +925,7 @@ GEN_VEXT_TRANS(vlxei16_v, 16, 1, rnfvm, ld_index_op, ld_index_check)
 GEN_VEXT_TRANS(vlxei32_v, 32, 2, rnfvm, ld_index_op, ld_index_check)
 GEN_VEXT_TRANS(vlxei64_v, 64, 3, rnfvm, ld_index_op, ld_index_check)
 
-static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_index *fn;
@@ -940,8 +958,9 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 
     fn = fns[seq][s->sew];
 
+    uint8_t emul = vext_get_emul(s, 1 << (s->sew + 3));
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
@@ -991,7 +1010,7 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     return true;
 }
 
-static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_us *fn;
@@ -1005,8 +1024,9 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
         return false;
     }
 
+    uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     return ldff_trans(a->rd, a->rs1, data, fn, s);
 }
@@ -1127,7 +1147,7 @@ static bool amo_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     return true;
 }
 
-static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
+static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t eew, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_amo *fn;
@@ -1187,8 +1207,9 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
         return false;
     }
 
+    uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
-    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, WD, a->wd);
     return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f3da2e7fbbd..f802e8c9c05 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "cpu.h"
 #include "exec/memop.h"
 #include "exec/exec-all.h"
@@ -121,14 +122,21 @@ static uint32_t vext_wd(uint32_t desc)
 }
 
 /*
- * Get vector group length in bytes. Its range is [64, 2048].
+ * Get the maximum number of elements can be operated.
  *
- * As simd_desc support at most 256, the max vlen is 512 bits.
- * So vlen in bytes is encoded as maxsz.
+ * esz: log2 of element size in bytes.
  */
-static inline uint32_t vext_maxsz(uint32_t desc)
+static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz)
 {
-    return simd_maxsz(desc) << vext_lmul(desc);
+    /*
+     * As simd_desc support at most 256 bytes, the max vlen is 256 bits.
+     * so vlen in bytes (vlenb) is encoded as maxsz.
+     */
+    uint32_t vlenb = simd_maxsz(desc);
+
+    /* Return VLMAX */
+    int scale = vext_lmul(desc) - esz;
+    return scale < 0 ? vlenb >> -scale : vlenb << scale;
 }
 
 /*
@@ -223,14 +231,14 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz);
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        probe_pages(env, base + stride * i, nf * esz, ra, access_type);
+        probe_pages(env, base + stride * i, nf << esz, ra, access_type);
     }
     /* do real access */
     for (i = 0; i < env->vl; i++) {
@@ -239,8 +247,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
             continue;
         }
         while (k < nf) {
-            target_ulong addr = base + stride * i + k * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            target_ulong addr = base + stride * i + (k << esz);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -253,7 +261,7 @@ void HELPER(NAME)(void *vd, void * v0, target_ulong base,               \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
     vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,      \
-                     sizeof(ETYPE), GETPC(), MMU_DATA_LOAD);            \
+                     ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_LOAD);      \
 }
 
 GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)
@@ -268,7 +276,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
 {                                                                       \
     uint32_t vm = vext_vm(desc);                                        \
     vext_ldst_stride(vd, v0, base, stride, env, desc, vm, STORE_FN,     \
-                     sizeof(ETYPE), GETPC(), MMU_DATA_STORE);           \
+                     ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_STORE);     \
 }
 
 GEN_VEXT_ST_STRIDE(vsse8_v,  int8_t,  ste_b)
@@ -288,16 +296,16 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz);
 
     /* probe every access */
-    probe_pages(env, base, env->vl * nf * esz, ra, access_type);
+    probe_pages(env, base, env->vl * (nf << esz), ra, access_type);
     /* load bytes from guest memory */
     for (i = 0; i < env->vl; i++) {
         k = 0;
         while (k < nf) {
-            target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            target_ulong addr = base + ((i * nf + k) << esz);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -312,16 +320,16 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
                          CPURISCVState *env, uint32_t desc)             \
 {                                                                       \
-    uint32_t stride = vext_nf(desc) * sizeof(ETYPE);                    \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
     vext_ldst_stride(vd, v0, base, stride, env, desc, false, LOAD_FN,   \
-                     sizeof(ETYPE), GETPC(), MMU_DATA_LOAD);            \
+                     ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_LOAD);      \
 }                                                                       \
                                                                         \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                   CPURISCVState *env, uint32_t desc)                    \
 {                                                                       \
     vext_ldst_us(vd, base, env, desc, LOAD_FN,                          \
-                 sizeof(ETYPE), GETPC(), MMU_DATA_LOAD);                \
+                 ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_LOAD);          \
 }
 
 GEN_VEXT_LD_US(vle8_v,  int8_t,  lde_b)
@@ -333,16 +341,16 @@ GEN_VEXT_LD_US(vle64_v, int64_t, lde_d)
 void HELPER(NAME##_mask)(void *vd, void *v0, target_ulong base,         \
                          CPURISCVState *env, uint32_t desc)             \
 {                                                                       \
-    uint32_t stride = vext_nf(desc) * sizeof(ETYPE);                    \
+    uint32_t stride = vext_nf(desc) << ctzl(sizeof(ETYPE));             \
     vext_ldst_stride(vd, v0, base, stride, env, desc, false, STORE_FN,  \
-                     sizeof(ETYPE), GETPC(), MMU_DATA_STORE);           \
+                     ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_STORE);     \
 }                                                                       \
                                                                         \
 void HELPER(NAME)(void *vd, void *v0, target_ulong base,                \
                   CPURISCVState *env, uint32_t desc)                    \
 {                                                                       \
     vext_ldst_us(vd, base, env, desc, STORE_FN,                         \
-                 sizeof(ETYPE), GETPC(), MMU_DATA_STORE);               \
+                 ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_STORE);         \
 }
 
 GEN_VEXT_ST_US(vse8_v,  int8_t,  ste_b)
@@ -378,14 +386,14 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz);
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        probe_pages(env, get_index_addr(base, i, vs2), nf * esz, ra,
+        probe_pages(env, get_index_addr(base, i, vs2), nf << esz, ra,
                     access_type);
     }
     /* load bytes from guest memory */
@@ -395,8 +403,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
             continue;
         }
         while (k < nf) {
-            abi_ptr addr = get_index_addr(base, i, vs2) + k * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            abi_ptr addr = get_index_addr(base, i, vs2) + (k << esz);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -407,7 +415,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
                   void *vs2, CPURISCVState *env, uint32_t desc)            \
 {                                                                          \
     vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,                \
-                    LOAD_FN, sizeof(ETYPE), GETPC(), MMU_DATA_LOAD);       \
+                    LOAD_FN, ctzl(sizeof(ETYPE)), GETPC(), MMU_DATA_LOAD); \
 }
 
 GEN_VEXT_LD_INDEX(vlxei8_8_v,   int8_t,  idx_b, lde_b)
@@ -432,7 +440,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
                   void *vs2, CPURISCVState *env, uint32_t desc)  \
 {                                                                \
     vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,      \
-                    STORE_FN, sizeof(ETYPE),                     \
+                    STORE_FN, ctzl(sizeof(ETYPE)),               \
                     GETPC(), MMU_DATA_STORE);                    \
 }
 
@@ -466,7 +474,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t i, k, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz);
     target_ulong addr, offset, remain;
 
     /* probe every access*/
@@ -474,24 +482,24 @@ vext_ldff(void *vd, void *v0, target_ulong base,
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        addr = base + nf * i * esz;
+        addr = base + i * (nf << esz);
         if (i == 0) {
-            probe_pages(env, addr, nf * esz, ra, MMU_DATA_LOAD);
+            probe_pages(env, addr, nf << esz, ra, MMU_DATA_LOAD);
         } else {
             /* if it triggers an exception, no need to check watchpoint */
-            remain = nf * esz;
+            remain = nf << esz;
             while (remain > 0) {
                 offset = -(addr | TARGET_PAGE_MASK);
                 host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
                                          cpu_mmu_index(env, false));
                 if (host) {
 #ifdef CONFIG_USER_ONLY
-                    if (page_check_range(addr, nf * esz, PAGE_READ) < 0) {
+                    if (page_check_range(addr, nf << esz, PAGE_READ) < 0) {
                         vl = i;
                         goto ProbeSuccess;
                     }
 #else
-                    probe_pages(env, addr, nf * esz, ra, MMU_DATA_LOAD);
+                    probe_pages(env, addr, nf << esz, ra, MMU_DATA_LOAD);
 #endif
                 } else {
                     vl = i;
@@ -516,8 +524,8 @@ ProbeSuccess:
             continue;
         }
         while (k < nf) {
-            target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            target_ulong addr = base + ((i * nf + k) << esz);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -528,7 +536,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
                   CPURISCVState *env, uint32_t desc)      \
 {                                                         \
     vext_ldff(vd, v0, base, env, desc, LOAD_FN,           \
-              sizeof(ETYPE), GETPC());                    \
+              ctzl(sizeof(ETYPE)), GETPC());              \
 }
 
 GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b)
@@ -741,7 +749,7 @@ void HELPER(NAME)(void *vs3, void *v0, target_ulong base,       \
 {                                                               \
     vext_amo_noatomic(vs3, v0, base, vs2, env, desc,            \
                       INDEX_FN, vext_##NAME##_noatomic_op,      \
-                      sizeof(ETYPE), GETPC());                  \
+                      ctzl(sizeof(ETYPE)), GETPC());            \
 }
 
 GEN_VEXT_AMO(vamoswapei8_32_v,  int32_t, idx_b)
@@ -1227,7 +1235,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
                   void *vs2, CPURISCVState *env, uint32_t desc) \
 {                                                               \
     uint32_t vl = env->vl;                                      \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);          \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE))); \
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
@@ -3888,7 +3896,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE)));     \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -4693,7 +4701,7 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE)));           \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t index, i;                                                    \
@@ -4721,7 +4729,7 @@ GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE)));           \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t index = s1, i;                                               \
-- 
2.17.1


