Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53372C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAEA20700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VjC0I443"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAEA20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkC1-0003eE-0g
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk86-0004qO-Nv
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk85-0004ek-Kr
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk84-0004Yo-Vt; Sun, 26 Apr 2020 12:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918461; x=1619454461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=geVKr+eAd6TRrsvx87S5GLuULxN/XM/aIct6v8Bs1IY=;
 b=VjC0I443StYuoooF3tBLTSHjhRGTekVMLB44tT/ADnSNADcKZOECWyL8
 B9al5eLb3U74GYFTkmtPAUSTenjimvlBfPmycaB2X4SDnI+ASiA4JjNNM
 DhxH4aHQrQVDn1pJnJRDbb4MC85Ft+x5h47lhBQQa2oH2+KtfobEWCWap
 AnXr5I91fwaJ+Vm/BreP9mZMGwiUKKs19Ycv+0Nqvc/3csklXnNpt0FCR
 gOnhFyYGJ5VRDfbP1I2y4WKax2mHy/SOcQmtsUo1D7eaINt2x7VBDQoRZ
 /ts5aeNx/4UmkWRKcPeCZ/mrLI2meY/LOCDRVGKG9eWnVvj1zvyqmcljC Q==;
IronPort-SDR: 73DPbEA9SjC2aXO+ctfgdxV6E5Tdl3HosxKiP2R+gWtJcHhyp3pAiX18+JhZyO7J85eRMGb0p+
 2iIBPfHlC/WZoZlq5PRZEFbU2wlIQmxoXS3rGBbsytHXy01o12DCJBOc28QTz+4JK67vAGIMgg
 jKsMV33/QNYuqntWmed7dFW6DWxJszyC06NJgqiA4fJ8RTm2JayobxJJ63rn3CBBqbs4zilW/q
 kNDs2i+VQfqjZJef/wbQCIIT4GEKYyYuNBsOCqDdGaQksYAY7T+WRsssCwFv/WzzXioocOIo0S
 aWI=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="137626676"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:40 +0800
IronPort-SDR: 0veoq64zi42SVQfGZ63jarSur4sWZT7ZTYbwOqq90NIoChmkXZBJcMtpfUDfN3O6jSHD9V8I30
 Q0hoehzBcqPAQqJ7g2A6mkOPDL9IKrsU0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:22 -0700
IronPort-SDR: w5S5hsnsrRSabRAdnVYDet+HJild6jKTPgebqqsvkYL7F7N/EYGYZMUJJjmlny1oxcxz5P5NH5
 ldXoTcom+jdQ==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 06/15] target/riscv: Allow generating hlv/hlvx/hsv
 instructions
Date: Sun, 26 Apr 2020 09:19:29 -0700
Message-Id: <e813681a5ca95e204e427d885d0423d9fee52959.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h                 |   1 +
 target/riscv/helper.h                   |   3 +
 target/riscv/insn32-64.decode           |   5 +
 target/riscv/insn32.decode              |  11 +
 target/riscv/insn_trans/trans_rvh.inc.c | 340 ++++++++++++++++++++++++
 target/riscv/op_helper.c                | 114 ++++++++
 6 files changed, 474 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f52711ac32..bb4ee3fc35 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -428,6 +428,7 @@
 #define HSTATUS_SP2V         0x00000200
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
+#define HSTATUS_HU           0x00000200
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b36be978d5..d020d1459c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -80,4 +80,7 @@ DEF_HELPER_1(tlb_flush, void, env)
 /* Hypervisor functions */
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
+DEF_HELPER_4(hyp_load, tl, env, tl, tl, tl)
+DEF_HELPER_5(hyp_store, void, env, tl, tl, tl, tl)
+DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
 #endif
diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 380bf791bc..24feef4e0f 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -70,3 +70,8 @@ fmv_x_d    1110001  00000 ..... 000 ..... 1010011 @r2
 fcvt_d_l   1101001  00010 ..... ... ..... 1010011 @r2_rm
 fcvt_d_lu  1101001  00011 ..... ... ..... 1010011 @r2_rm
 fmv_d_x    1111001  00000 ..... 000 ..... 1010011 @r2
+
+# *** RV32H Base Instruction Set ***
+hlv_wu    0110100  00001   ..... 100 ..... 1110011 @r2
+hlv_d     0110110  00000   ..... 100 ..... 1110011 @r2
+hsv_d     0110111  .....   ..... 100 00000 1110011 @r2_s
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 05266f5a36..d87c6ba122 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -62,6 +62,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r2_s    .......   ..... ..... ... ..... ....... %rs2 %rs1
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @hfence_bvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -207,5 +208,15 @@ fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
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
 hfence_bvma 0010001  .....  ..... 000 00000 1110011 @hfence_bvma
diff --git a/target/riscv/insn_trans/trans_rvh.inc.c b/target/riscv/insn_trans/trans_rvh.inc.c
index 60978f2fa5..a2bf4b6c50 100644
--- a/target/riscv/insn_trans/trans_rvh.inc.c
+++ b/target/riscv/insn_trans/trans_rvh.inc.c
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 53dca7128d..d7f26b22f3 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -214,4 +214,118 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
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
+            pte = cpu_ldsb_data(env, address);
+            break;
+        case MO_UB:
+            pte = cpu_ldub_data(env, address);
+            break;
+        case MO_TESW:
+            pte = cpu_ldsw_data(env, address);
+            break;
+        case MO_TEUW:
+            pte = cpu_lduw_data(env, address);
+            break;
+        case MO_TESL:
+            pte = cpu_ldl_data(env, address);
+            break;
+        case MO_TEUL:
+            pte = cpu_ldl_data(env, address);
+            break;
+        case MO_TEQ:
+            pte = cpu_ldq_data(env, address);
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
+            cpu_stb_data(env, address, val);
+            break;
+        case MO_TESW:
+        case MO_TEUW:
+            cpu_stw_data(env, address, val);
+            break;
+        case MO_TESL:
+        case MO_TEUL:
+            cpu_stl_data(env, address, val);
+            break;
+        case MO_TEQ:
+            cpu_stq_data(env, address, val);
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
+            pte = cpu_ldub_data(env, address);
+            break;
+        case MO_TEUW:
+            pte = cpu_lduw_data(env, address);
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
-- 
2.26.2


