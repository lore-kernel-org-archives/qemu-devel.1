Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C153C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391BD2077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XoyhUxES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391BD2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsoo-0003bl-DH
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdI-0005Ic-NI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:56 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:35221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdF-0006d8-Lu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:56 -0400
Received: by mail-pj1-x1032.google.com with SMTP id f16so2454136pjt.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pmld6bMtA4CjQtBb8ulLf3NdwVMFPe4sDtpXqgR3nnE=;
 b=XoyhUxESmAtow3mQf/YCcRc5yddlaTotHqTosZP14sOsYbjsGnnNtXDVjkLTLEeHH1
 vNLVK8ZRfcpKXo3Shj+y250bWYAee2jOx5mWP3td+4SpGET7/XobctUePSftDqRupB+N
 uhGTc9ASjbg6rGgRd4K9SQtUEdg2t2zTgntTwdnHkQvMqc4moyjpWepPX9BSGAHsrN+s
 +sGOIRsor/ucbXVJ2mvJc4ExsSqoh6deM7LquO/KyrBsBLD79Hz33yDKNyTNeJRMkH4v
 eTzS4h6aitVlxUXAzMBdj2HwZd4QupvfqEu/2+f1EzK487LBq7g7c+FjhszlY/npYaLg
 tKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pmld6bMtA4CjQtBb8ulLf3NdwVMFPe4sDtpXqgR3nnE=;
 b=jW6BGABBNjo8344vyWeWhREOXatdE9H9yMuXHhNulOGn4jm36VFfPW2aL/4bWEq41w
 A+4+Pam56eG/iXi1CVBXT6KiAe0vZZ9kO4Uvvw0ObRl9AfjXU7y46kDIY8Gmo1QELgGx
 FpRP4gPXTOYAI63XktxRu6sqUV5fSVuirSXsNQZuG4tlmbtQagp8FavP9VlxShCAS28c
 uhYOVRPH4sBs9KkH9+q1HoP4ctCIHBs8hJOLYKiBQmMOujmv1zuD9HRjJoNb5Wv5CEVq
 HjfZjkGzjZf0zFnSjN00rlCk86NnAHXn+YBA8KNdXct72AqsTbK9f4tYzEfifqO03m/l
 PNKQ==
X-Gm-Message-State: AOAM533ptGaXQ+Pa0a3P6WImOW3TjBdxGYmgKxSnQUzQkwSHf10XKTda
 BI93DSrySEzqyUD4935yfAG2B8K4zBGO/g==
X-Google-Smtp-Source: ABdhPJzNSY3KxqsB7CDHyQSFE2YYLOFaP+lLp963Cl3dyx3r/ihsjXwSH6NUKxJU56drElyLi5q0wQ==
X-Received: by 2002:a17:902:7d86:: with SMTP id
 a6mr23682820plm.215.1594378312204; 
 Fri, 10 Jul 2020 03:51:52 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:51:51 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 19/65] target/riscv: rvv-0.9: load/store whole register
 instructions
Date: Fri, 10 Jul 2020 18:48:33 +0800
Message-Id: <20200710104920.13550-20-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1032.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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

Add the following instructions:

* vl1r.v
* vs1r.v

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  3 ++
 target/riscv/insn32.decode              |  4 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 55 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 46 +++++++++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 22784b2d8c..924c334f71 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -145,6 +145,9 @@ DEF_HELPER_5(vle16ff_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32ff_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle64ff_v, void, ptr, ptr, tl, env, i32)
 
+DEF_HELPER_4(vl1r_v, void, ptr, tl, env, i32)
+DEF_HELPER_4(vs1r_v, void, ptr, tl, env, i32)
+
 DEF_HELPER_6(vamoswapei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamoswapei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamoswapei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6a9cf6ad53..e3f0fba912 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -267,6 +267,10 @@ vle16ff_v     ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
 vle32ff_v     ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 vle64ff_v     ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
 
+# Vector whole register insns
+vl1r_v        000 000 1 01000 ..... 000 ..... 0000111 @r2
+vs1r_v        000 000 1 01000 ..... 000 ..... 0100111 @r2
+
 #*** Vector AMO operations are encoded under the standard AMO major opcode ***
 vamoswapei8_v   00001 . . ..... ..... 000 ..... 0101111 @r_wdvm
 vamoswapei16_v  00001 . . ..... ..... 101 ..... 0101111 @r_wdvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1ceac5ef30..7db62053ab 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -823,6 +823,61 @@ GEN_VEXT_TRANS(vle16ff_v, 16, 1, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vle32ff_v, 32, 2, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vle64ff_v, 64, 3, r2nfvm, ldff_op, ld_us_check)
 
+/*
+ * load and store whole register instructions
+ */
+typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
+
+static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+                             gen_helper_ldst_whole *fn, DisasContext *s)
+{
+    TCGv_ptr dest;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+
+    fn(dest, base, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+/*
+ * load and store whole register instructions ignore vtype and vl setting.
+ * Thus, we don't need to check vill bit. (Section 7.9)
+ */
+#define GEN_LDST_WHOLE_TRANS(NAME, EEW, SEQ, ARGTYPE, ARG_NF)          \
+static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE * a)           \
+{                                                                      \
+    s->eew = EEW;                                                      \
+    s->emul = (float)EEW / (1 << (s->sew + 3)) * s->flmul;             \
+                                                                       \
+    REQUIRE_RVV;                                                       \
+                                                                       \
+    uint32_t data = 0;                                                 \
+    bool ret;                                                          \
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                     \
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);                       \
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);                       \
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);                       \
+    data = FIELD_DP32(data, VDATA, NF, ARG_NF);                        \
+    ret = ldst_whole_trans(a->rd, a->rs1, data, gen_helper_##NAME, s); \
+    mark_vs_dirty(s);                                                  \
+    return ret;                                                        \
+}
+
+GEN_LDST_WHOLE_TRANS(vl1r_v, 8, 0, vl1r_v, 1)
+
+GEN_LDST_WHOLE_TRANS(vs1r_v, 8, 1, vs1r_v, 1)
+
 /*
  *** vector atomic operation
  */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index dc9bd0b68a..39b9a462ab 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -649,6 +649,52 @@ GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h, clearh)
 GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w, clearl)
 GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d, clearq)
 
+/*
+ *** load and store whole register instructions
+ */
+static void
+vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
+                vext_ldst_elem_fn *ldst_elem, uint32_t esz, uintptr_t ra,
+                MMUAccessType access_type)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access */
+    probe_pages(env, base, env->vlenb * nf * esz, ra, access_type);
+
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vlenb; i++) {
+        k = 0;
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * esz;
+            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+#define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN)             \
+void HELPER(NAME)(void *vd, target_ulong base,              \
+                  CPURISCVState *env, uint32_t desc)        \
+{                                                           \
+    vext_ldst_whole(vd, base, env, desc, LOAD_FN,           \
+                    sizeof(ETYPE), GETPC(), MMU_DATA_LOAD); \
+}
+
+GEN_VEXT_LD_WHOLE(vl1r_v, int8_t, lde_b)
+
+#define GEN_VEXT_ST_WHOLE(NAME, ETYPE, STORE_FN)             \
+void HELPER(NAME)(void *vd, target_ulong base,               \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    vext_ldst_whole(vd, base, env, desc, STORE_FN,           \
+                    sizeof(ETYPE), GETPC(), MMU_DATA_STORE); \
+}
+
+GEN_VEXT_ST_WHOLE(vs1r_v, int8_t, ste_b)
+
 /*
  *** Vector AMO Operations (Zvamo)
  */
-- 
2.17.1


