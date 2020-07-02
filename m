Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BA1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E783A207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NHeyGb2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E783A207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2NY-0005xD-4I
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2A1-0004dl-6r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29y-00008e-Nw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707642; x=1625243642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yiQxrSzJ1dxtQ05to3QQbdQQ2roM5vjTiBiv///hbPk=;
 b=NHeyGb2IIGcGaHuEW7mDg6r6DbJ6tXahazlNW4NA087ued/oihPkdjDx
 9/PosiCamyAqnzQdFeVmIMrODZpqWToC8DkM/KlKOAhNCthREvYMHqtTM
 Uxt0DxCuofPs4oBkDD+NAZUE5hiPXqJN6ufEKpw8l8de4Jc8vAgUgTp9R
 +imw/X94rD3TcEy6Oi4+MRW9oVOvzufYgTuPAgY8si7/uISlMppLiQszy
 tusSXbDLIyraaG6aLnvQqN8prZxUjNg4+JBudLvpDRblBq2eCb4dyPpXE
 DzhvlTmC4utcUxuQGqCftp9zMhfNt+V7BAQTKXzE7C5SgIeuyA2oIxPee A==;
IronPort-SDR: effa7GdWXW+thkz5ucZzBGoWkltrYrs1zBLhAfm14pogObvvJYKVbIbCSnx1NGpIX9b6KulSKH
 87wLVn5RNNYEekZQp/aBq7yFxKFy3SH6msBor362k02i5Tlu/VZ5ujHPP8dKSmKrkulll7PuGg
 d6tmY6IaB/GaknFyGFWBE/YhXQxR1AuTK10OIarFOXmnVQiu9FwxxCIXu/bVTTKBIpXQMRzeFD
 H6Ui7VfAUfv118WDJyA6cbDAGejq/JgoZ/uHTeF3U9hgVwEDACWrZZjYLfpAmlLCmJhb1xPoIO
 LW0=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498472"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:22 +0800
IronPort-SDR: eg1zLBR5yaR5Ny6VBEVED97qLMNzNeoPEuSkCW0o6B49DL6hnIkBIYy0MqKkoXsuizQJ5l8XRo
 f87rQE26jk1lYDBadQjAjcxYdSUozSuBQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:37 -0700
IronPort-SDR: 87b4cxb0udjx9ZiAgWFanapMfgRHXGV/Ux9fMtpGd5mKyVLQIWxhx5R7SJtwlNpygv7uSGB+eC
 9IYfGrA7qmAQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 11/64] target/riscv: add fault-only-first unit stride load
Date: Thu,  2 Jul 2020 09:23:01 -0700
Message-Id: <20200702162354.928528-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

The unit-stride fault-only-fault load instructions are used to
vectorize loops with data-dependent exit conditions(while loops).
These instructions execute as a regular load except that they
will only take a trap on element 0.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200701152549.1218-9-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  22 +++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  73 ++++++++++++++++
 target/riscv/vector_helper.c            | 110 ++++++++++++++++++++++++
 4 files changed, 212 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f3650f736e..5c97bc446e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -224,3 +224,25 @@ DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhuff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwuff_v_d, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 287d52bcc9..7146aec22a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -226,6 +226,13 @@ vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
 vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
 vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
 vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
 vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 11a3a89d54..5e2fbb7078 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -561,3 +561,76 @@ GEN_VEXT_TRANS(vsxb_v, 0, rnfvm, st_index_op, st_index_check)
 GEN_VEXT_TRANS(vsxh_v, 1, rnfvm, st_index_op, st_index_check)
 GEN_VEXT_TRANS(vsxw_v, 2, rnfvm, st_index_op, st_index_check)
 GEN_VEXT_TRANS(vsxe_v, 3, rnfvm, st_index_op, st_index_check)
+
+/*
+ *** unit stride fault-only-first load
+ */
+static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+                       gen_helper_ldst_us *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base;
+    TCGv_i32 desc;
+
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    gen_set_label(over);
+    return true;
+}
+
+static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[7][4] = {
+        { gen_helper_vlbff_v_b,  gen_helper_vlbff_v_h,
+          gen_helper_vlbff_v_w,  gen_helper_vlbff_v_d },
+        { NULL,                  gen_helper_vlhff_v_h,
+          gen_helper_vlhff_v_w,  gen_helper_vlhff_v_d },
+        { NULL,                  NULL,
+          gen_helper_vlwff_v_w,  gen_helper_vlwff_v_d },
+        { gen_helper_vleff_v_b,  gen_helper_vleff_v_h,
+          gen_helper_vleff_v_w,  gen_helper_vleff_v_d },
+        { gen_helper_vlbuff_v_b, gen_helper_vlbuff_v_h,
+          gen_helper_vlbuff_v_w, gen_helper_vlbuff_v_d },
+        { NULL,                  gen_helper_vlhuff_v_h,
+          gen_helper_vlhuff_v_w, gen_helper_vlhuff_v_d },
+        { NULL,                  NULL,
+          gen_helper_vlwuff_v_w, gen_helper_vlwuff_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldff_trans(a->rd, a->rs1, data, fn, s);
+}
+
+GEN_VEXT_TRANS(vlbff_v, 0, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlhff_v, 1, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlwff_v, 2, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vleff_v, 3, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlbuff_v, 4, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlhuff_v, 5, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlwuff_v, 6, r2nfvm, ldff_op, ld_us_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bbf5991688..cbe87265a1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -577,3 +577,113 @@ GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
 GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
 GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
 GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
+
+/*
+ *** unit-stride fault-only-fisrt load instructions
+ */
+static inline void
+vext_ldff(void *vd, void *v0, target_ulong base,
+          CPURISCVState *env, uint32_t desc,
+          vext_ldst_elem_fn *ldst_elem,
+          clear_fn *clear_elem,
+          uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    void *host;
+    uint32_t i, k, vl = 0;
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+    target_ulong addr, offset, remain;
+
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        addr = base + nf * i * msz;
+        if (i == 0) {
+            probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+        } else {
+            /* if it triggers an exception, no need to check watchpoint */
+            remain = nf * msz;
+            while (remain > 0) {
+                offset = -(addr | TARGET_PAGE_MASK);
+                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
+                                         cpu_mmu_index(env, false));
+                if (host) {
+#ifdef CONFIG_USER_ONLY
+                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+#else
+                    probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+#endif
+                } else {
+                    vl = i;
+                    goto ProbeSuccess;
+                }
+                if (remain <=  offset) {
+                    break;
+                }
+                remain -= offset;
+                addr += offset;
+            }
+        }
+    }
+ProbeSuccess:
+    /* load bytes from guest memory */
+    if (vl != 0) {
+        env->vl = vl;
+    }
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    if (vl != 0) {
+        return;
+    }
+    for (k = 0; k < nf; k++) {
+        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+    }
+}
+
+#define GEN_VEXT_LDFF(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)     \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    vext_ldff(vd, v0, base, env, desc, LOAD_FN, CLEAR_FN,        \
+              sizeof(ETYPE), sizeof(MTYPE), GETPC());            \
+}
+
+GEN_VEXT_LDFF(vlbff_v_b,  int8_t,   int8_t,   ldb_b,  clearb)
+GEN_VEXT_LDFF(vlbff_v_h,  int8_t,   int16_t,  ldb_h,  clearh)
+GEN_VEXT_LDFF(vlbff_v_w,  int8_t,   int32_t,  ldb_w,  clearl)
+GEN_VEXT_LDFF(vlbff_v_d,  int8_t,   int64_t,  ldb_d,  clearq)
+GEN_VEXT_LDFF(vlhff_v_h,  int16_t,  int16_t,  ldh_h,  clearh)
+GEN_VEXT_LDFF(vlhff_v_w,  int16_t,  int32_t,  ldh_w,  clearl)
+GEN_VEXT_LDFF(vlhff_v_d,  int16_t,  int64_t,  ldh_d,  clearq)
+GEN_VEXT_LDFF(vlwff_v_w,  int32_t,  int32_t,  ldw_w,  clearl)
+GEN_VEXT_LDFF(vlwff_v_d,  int32_t,  int64_t,  ldw_d,  clearq)
+GEN_VEXT_LDFF(vleff_v_b,  int8_t,   int8_t,   lde_b,  clearb)
+GEN_VEXT_LDFF(vleff_v_h,  int16_t,  int16_t,  lde_h,  clearh)
+GEN_VEXT_LDFF(vleff_v_w,  int32_t,  int32_t,  lde_w,  clearl)
+GEN_VEXT_LDFF(vleff_v_d,  int64_t,  int64_t,  lde_d,  clearq)
+GEN_VEXT_LDFF(vlbuff_v_b, uint8_t,  uint8_t,  ldbu_b, clearb)
+GEN_VEXT_LDFF(vlbuff_v_h, uint8_t,  uint16_t, ldbu_h, clearh)
+GEN_VEXT_LDFF(vlbuff_v_w, uint8_t,  uint32_t, ldbu_w, clearl)
+GEN_VEXT_LDFF(vlbuff_v_d, uint8_t,  uint64_t, ldbu_d, clearq)
+GEN_VEXT_LDFF(vlhuff_v_h, uint16_t, uint16_t, ldhu_h, clearh)
+GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, ldhu_w, clearl)
+GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, ldhu_d, clearq)
+GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, ldwu_w, clearl)
+GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, ldwu_d, clearq)
-- 
2.27.0


