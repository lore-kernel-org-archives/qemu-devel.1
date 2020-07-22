Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937D920729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G7P1buDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937D920729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB6W-0000rd-Pg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuW-0001XH-4u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:35190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuT-0005bA-0V
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id x9so659460plr.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=65H2nOM6Zv+jL3nuWxhgnkDNOjW7kakLBlArAff0dV0=;
 b=G7P1buDVN0d8pjSI7vqvYDgbTtKzCuY/e1R3o6qruNqUYrz+3OC0gFi80fq2+e+/0c
 I1NGI7ritFuJY1naPC36Xgtt9twtifwo37RYqnkSGCG2NRsyK6ORjqPsqg3wJWrupOZj
 B4B6Esufpc3dVY5BLAip8F5xQ1M4opv5cBGrlevCi58Zs+Ki6cN7bPohjIRdo3OHPS7x
 EyzCLV9CLRfTcqhHfftRAaBnPanGR2yVpaNAxrI0wqPnpd6gbyOE71RtOzbNWzI96Z6+
 q/CM1+9XHXimeP3Xxg3Lqu2RpHW6U6zk+BYd+p1ahz2XdP08J9WsZFMBmxfwXBD+gEen
 eHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=65H2nOM6Zv+jL3nuWxhgnkDNOjW7kakLBlArAff0dV0=;
 b=dfce9RaFnYc9flD0HMbk6udc/2+Lt2ZqLF7/ApIFj/VddaKEUCsp8uc2nKTp54xTdz
 Z0CbKnjQcbCUVhv+uOGJr7O6u5mRaMbktND+P0a1pW/YU0NYhx4GTcyuwKDi9ksnOT4Y
 SgLpfE9Fz3FcfJzYdXOtxVfKJXNCdWf7P7zBY0X28hdB1ctD6enkTVvFe6ddinRxYY2T
 zRD90zBasiJNfzExOth0kNaGpznH5RyjpMpPuaizWG713H1zMICgFJmVgTlQxd7BOfGp
 /MhZczdVE9LzpWS15xOaUG1eJ0CR5gmRyefHLh+LfDQ5Dx3oNdzzUnWkt8pNInOU+TpT
 on+g==
X-Gm-Message-State: AOAM531E4zIJ7XpPdn4YVC9R4KQjq9T5ycMnSXuQ+fMmTa4gWaCEtDw+
 EY7rsIxwMd+KH5bVBov8uVd6pjouofI=
X-Google-Smtp-Source: ABdhPJxd/hABcyKYPaLagYppy+5ZBz6tj69h8VJ/Pao3lQ29S8OwK5BGSu0BxL+DdnGrmYbdKPoE/A==
X-Received: by 2002:a17:902:c211:: with SMTP id
 17mr25364314pll.302.1595409571573; 
 Wed, 22 Jul 2020 02:19:31 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:31 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 27/76] target/riscv: rvv-0.9: load/store whole register
 instructions
Date: Wed, 22 Jul 2020 17:15:50 +0800
Message-Id: <20200722091641.8834-28-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
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

Add the following instructions:

* vl1r.v
* vs1r.v

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  3 ++
 target/riscv/insn32.decode              |  4 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 61 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 47 +++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 808f88fbeb..8cf5c4c065 100644
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
index fb6d092539..4274daf08e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1030,6 +1030,67 @@ GEN_VEXT_TRANS(vle16ff_v, 16, 1, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vle32ff_v, 32, 2, r2nfvm, ldff_op, ld_us_check)
 GEN_VEXT_TRANS(vle64ff_v, 64, 3, r2nfvm, ldff_op, ld_us_check)
 
+/*
+ * load and store whole register instructions
+ */
+typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
+
+static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+                             gen_helper_ldst_whole *fn, DisasContext *s,
+                             bool is_store)
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
+    if (!is_store) {
+        mark_vs_dirty(s);
+    }
+    return true;
+}
+
+/*
+ * load and store whole register instructions ignore vtype and vl setting.
+ * Thus, we don't need to check vill bit. (Section 7.9)
+ */
+#define GEN_LDST_WHOLE_TRANS(NAME, EEW, SEQ, ARGTYPE, ARG_NF, IS_STORE) \
+static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE * a)            \
+{                                                                       \
+    s->eew = EEW;                                                       \
+    s->emul = (float)EEW / (1 << (s->sew + 3)) * s->flmul;              \
+                                                                        \
+    if (!require_rvv(s)) {                                              \
+        return false;                                                   \
+    }                                                                   \
+                                                                        \
+    uint32_t data = 0;                                                  \
+    bool ret;                                                           \
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                      \
+    data = FIELD_DP32(data, VDATA, SEW, s->sew);                        \
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);                        \
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);                        \
+    data = FIELD_DP32(data, VDATA, NF, ARG_NF);                         \
+    ret = ldst_whole_trans(a->rd, a->rs1, data, gen_helper_##NAME,      \
+                           s, IS_STORE);                                \
+    return ret;                                                         \
+}
+
+GEN_LDST_WHOLE_TRANS(vl1r_v, 8, 0, vl1r_v, 1, false)
+
+GEN_LDST_WHOLE_TRANS(vs1r_v, 8, 1, vs1r_v, 1, true)
+
 /*
  *** vector atomic operation
  */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f49af084ef..995e873549 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -642,6 +642,53 @@ GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h, clearh)
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
+    uint32_t vlenb = env_archcpu(env)->cfg.vlen >> 3;
+
+    /* probe every access */
+    probe_pages(env, base, vlenb * nf * esz, ra, access_type);
+
+    /* load bytes from guest memory */
+    for (i = 0; i < vlenb; i++) {
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


