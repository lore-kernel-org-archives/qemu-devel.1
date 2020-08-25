Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F65C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4E42074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="be6Hh8Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4E42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeEC-0001cG-MJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9y-0003fs-E3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9u-0002vu-Ik
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381943; x=1629917943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EHWJ1pz0YNdwoWsCapvnP2MiK2bVeKYRnBKYZpjj8Wg=;
 b=be6Hh8AcdNK6tL7EtSanTHGlEZc/ZSbUl1REu7Obfqvna15nJDhcSEZi
 /l4Y/V4dyTXuQpyVSLZdF3nD831ZfSvITtVdB2bDssy97eDa3wlppGlwf
 9IOKy0/NISS2LPizbABz8uf+1f6T+K2ndpY3vCIummHgn3Tzl4mzZAEUL
 iNz8p8JkKtBigNFvNjqAwszcTNgeb7iAPPIw10jCDZSQajGgyM7ZlnwRy
 AY6NM1N7j95GCiSwOXORLGE8l8/TE66bI6IZQ4mFz3zvBhJqsFTs8OwA4
 mXQmBkBfyRZOalvNnwkmk9e+TzWaJ2fGr1xuTuvwS0CAKnilfrfXiDetX w==;
IronPort-SDR: jP++ffwP0Ck5/b3qcuPss2JsiFSCC/gob+4Dqag+gDuLtSgyvkGitXvu58Kq0+O5s2jkdGvuzO
 rGUQ6TiM4Vw3NhMsaJqFnZntpeQFezLyIfCueiARRtRRC53Myn348pr2rIyciFF8Gn4U3toOFv
 rYqeIgDdAbbH1+Cu6Z92hvVT8zoAPdQq1hwC5cKpD4c3djiOIVMk7rblFpIm53h5oNWI6lqRbn
 5adNtmvfv/X21NBeWjQ2JawN5JWzRmI/q52oTGk17dXw5/AVmXR+aeu/88+qSTvCs6sS+sFJvM
 MMk=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145289"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:56 +0800
IronPort-SDR: fofSiQMQMvirsXMbdmACYF8u0auf7m5jd8Vm6lYgLcapJheClJaEBmp2oVpJCHRcQwB3wuLwYl
 MlxW1HLdn5/w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:31 -0700
IronPort-SDR: mlU+84PPLfrn9JN5sI8eckxx8+hTfOokff7ubiWj5Lei0M8vVgeUgxRHcnN1xZtmohCOPG5nQo
 mei+pQaWQ/vg==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] target/riscv: Allow generating hlv/hlvx/hsv instructions
Date: Tue, 25 Aug 2020 11:48:25 -0700
Message-Id: <20200825184836.1282371-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 477c864312280ea55a98dc84cb01d826751b6c14.1597259519.git.alistair.francis@wdc.com
Message-Id: <477c864312280ea55a98dc84cb01d826751b6c14.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h                 |   1 +
 target/riscv/helper.h                   |   3 +
 target/riscv/insn32-64.decode           |   5 +
 target/riscv/insn32.decode              |  11 +
 target/riscv/op_helper.c                | 114 ++++++++
 target/riscv/insn_trans/trans_rvh.c.inc | 340 ++++++++++++++++++++++++
 6 files changed, 474 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ba0a5b50ff..7abae4267f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -443,6 +443,7 @@
 #define HSTATUS_SP2V         0x00000200
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
+#define HSTATUS_HU           0x00000200
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index acc298219d..c8029d83f9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -80,6 +80,9 @@ DEF_HELPER_1(tlb_flush, void, env)
 /* Hypervisor functions */
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
+DEF_HELPER_4(hyp_load, tl, env, tl, tl, tl)
+DEF_HELPER_5(hyp_store, void, env, tl, tl, tl, tl)
+DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
 #endif
 
 /* Vector functions */
diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 86153d93fa..8157dee8b7 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -81,3 +81,8 @@ fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
 fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
 fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
 fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
+
+# *** RV32H Base Instruction Set ***
+hlv_wu    0110100  00001   ..... 100 ..... 1110011 @r2
+hlv_d     0110110  00000   ..... 100 ..... 1110011 @r2
+hsv_d     0110111  .....   ..... 100 00000 1110011 @r2_s
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bdd8563067..84080dd18c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -78,6 +78,7 @@
 @r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
+@r2_s    .......   ..... ..... ... ..... ....... %rs2 %rs1
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @hfence_vvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -223,6 +224,16 @@ fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
 
 # *** RV32H Base Instruction Set ***
+hlv_b       0110000  00000  ..... 100 ..... 1110011 @r2
+hlv_bu      0110000  00001  ..... 100 ..... 1110011 @r2
+hlv_h       0110010  00000  ..... 100 ..... 1110011 @r2
+hlv_hu      0110010  00001  ..... 100 ..... 1110011 @r2
+hlvx_hu     0110010  00011  ..... 100 ..... 1110011 @r2
+hlv_w       0110100  00000  ..... 100 ..... 1110011 @r2
+hlvx_wu     0110100  00011  ..... 100 ..... 1110011 @r2
+hsv_b       0110001  .....  ..... 100 00000 1110011 @r2_s
+hsv_h       0110011  .....  ..... 100 00000 1110011 @r2_s
+hsv_w       0110101  .....  ..... 100 00000 1110011 @r2_s
 hfence_gvma 0110001  .....  ..... 000 00000 1110011 @hfence_gvma
 hfence_vvma 0010001  .....  ..... 000 00000 1110011 @hfence_vvma
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 7cccd42a1e..3d306c343c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -207,4 +207,118 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
     riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
 }
 
+target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
+                             target_ulong attrs, target_ulong memop)
+{
+    if (env->priv == PRV_M ||
+        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+            get_field(env->hstatus, HSTATUS_HU))) {
+        target_ulong pte;
+
+        riscv_cpu_set_two_stage_lookup(env, true);
+
+        switch (memop) {
+        case MO_SB:
+            pte = cpu_ldsb_data_ra(env, address, GETPC());
+            break;
+        case MO_UB:
+            pte = cpu_ldub_data_ra(env, address, GETPC());
+            break;
+        case MO_TESW:
+            pte = cpu_ldsw_data_ra(env, address, GETPC());
+            break;
+        case MO_TEUW:
+            pte = cpu_lduw_data_ra(env, address, GETPC());
+            break;
+        case MO_TESL:
+            pte = cpu_ldl_data_ra(env, address, GETPC());
+            break;
+        case MO_TEUL:
+            pte = cpu_ldl_data_ra(env, address, GETPC());
+            break;
+        case MO_TEQ:
+            pte = cpu_ldq_data_ra(env, address, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        riscv_cpu_set_two_stage_lookup(env, false);
+
+        return pte;
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    return 0;
+}
+
+void helper_hyp_store(CPURISCVState *env, target_ulong address,
+                      target_ulong val, target_ulong attrs, target_ulong memop)
+{
+    if (env->priv == PRV_M ||
+        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+            get_field(env->hstatus, HSTATUS_HU))) {
+        riscv_cpu_set_two_stage_lookup(env, true);
+
+        switch (memop) {
+        case MO_SB:
+        case MO_UB:
+            cpu_stb_data_ra(env, address, val, GETPC());
+            break;
+        case MO_TESW:
+        case MO_TEUW:
+            cpu_stw_data_ra(env, address, val, GETPC());
+            break;
+        case MO_TESL:
+        case MO_TEUL:
+            cpu_stl_data_ra(env, address, val, GETPC());
+            break;
+        case MO_TEQ:
+            cpu_stq_data_ra(env, address, val, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        riscv_cpu_set_two_stage_lookup(env, false);
+
+        return;
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+}
+
+target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
+                               target_ulong attrs, target_ulong memop)
+{
+    if (env->priv == PRV_M ||
+        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+            get_field(env->hstatus, HSTATUS_HU))) {
+        target_ulong pte;
+
+        riscv_cpu_set_two_stage_lookup(env, true);
+
+        switch (memop) {
+        case MO_TEUL:
+            pte = cpu_ldub_data_ra(env, address, GETPC());
+            break;
+        case MO_TEUW:
+            pte = cpu_lduw_data_ra(env, address, GETPC());
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        riscv_cpu_set_two_stage_lookup(env, false);
+
+        return pte;
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    return 0;
+}
+
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 263b652d90..db650ae62a 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -16,6 +16,346 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+static bool trans_hlv_b(DisasContext *ctx, arg_hlv_b *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_SB);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hlv_h(DisasContext *ctx, arg_hlv_h *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TESW);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hlv_w(DisasContext *ctx, arg_hlv_w *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TESL);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hlv_bu(DisasContext *ctx, arg_hlv_bu *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_UB);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hlv_hu(DisasContext *ctx, arg_hlv_hu *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TEUW);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hsv_b(DisasContext *ctx, arg_hsv_b *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    gen_get_gpr(dat, a->rs2);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_SB);
+
+    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(dat);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hsv_h(DisasContext *ctx, arg_hsv_h *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    gen_get_gpr(dat, a->rs2);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TESW);
+
+    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(dat);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hsv_w(DisasContext *ctx, arg_hsv_w *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    gen_get_gpr(dat, a->rs2);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TESL);
+
+    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(dat);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+#ifdef TARGET_RISCV64
+static bool trans_hlv_wu(DisasContext *ctx, arg_hlv_wu *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TEUL);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hlv_d(DisasContext *ctx, arg_hlv_d *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TEQ);
+
+    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hsv_d(DisasContext *ctx, arg_hsv_d *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv dat = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    gen_get_gpr(dat, a->rs2);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TEQ);
+
+    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(dat);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+#endif
+
+static bool trans_hlvx_hu(DisasContext *ctx, arg_hlvx_hu *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TEUW);
+
+    gen_helper_hyp_x_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
+static bool trans_hlvx_wu(DisasContext *ctx, arg_hlvx_wu *a)
+{
+    REQUIRE_EXT(ctx, RVH);
+#ifndef CONFIG_USER_ONLY
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mem_idx = tcg_temp_new();
+    TCGv memop = tcg_temp_new();
+
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
+    tcg_gen_movi_tl(memop, MO_TEUL);
+
+    gen_helper_hyp_x_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_set_gpr(a->rd, t1);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(mem_idx);
+    tcg_temp_free(memop);
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
-- 
2.28.0


