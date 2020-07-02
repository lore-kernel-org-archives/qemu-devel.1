Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E559FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ABE207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L8Hz6IN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ABE207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2S0-0008Iv-Vx
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ai-0006Vu-Ol
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ag-0000Ah-GP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707686; x=1625243686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DcuwCid1IqA/c2kNIuquwMTEfd/oE7xs2gv/wPRKfVU=;
 b=L8Hz6IN33YBA/IuN4Mlrk16kFJJUYdmcr8hO1wk7u9OGud0cv9PVReOa
 5C5fWkFDkOlEdXd00xu6qqIVMl2j/ZPn5rSR4szWbCSWu34/edREd6c/M
 Hd9zwYeXjKAuhPBXEImiHDlmR/uqDjVCtCvnZcevBS+R51oq0Gzed9k0u
 7GZb6TgY/3sZdyFR1DSvB8nbWMCvfnsdE1hg0U6w233DfjpjFsBKVwnB4
 8UuzCRMq5+Xg2Pc1VaW22wwoqr6kjT05K/u/al6CXLKZY4frZmXEZw7uX
 p4SKeqtXgycaHUDr3Xe7fnCS33iY4LH0wSat770mVrBf3eRxH88/dkU4J w==;
IronPort-SDR: O74dXo3/xekxERnUOhKSnu8p56W58TPhECgkh57ZvZA6sIt7jF+y5nBhf0c1jp46Rsy2BsPT5V
 BPpoS3Pzoe2kcsiLXnad1FQ/eelXQLzXTtUm1AGfwqWxPklgDX+rghob/wIUUfQ6rDVyk2IAHv
 qHpb+A9ednLc+qNvDmjGni4kJK49vepL6JqMOX/D75MBR7Q2Q5LGVL3LHobW8uajboPZNglAD4
 cNQZmfJdhtJ3hfiokUNSQsDqANFK1wUwkUs94zUW/Kh2L1dajdITAw+Dau7zBLjNwSzRNSeuj6
 EzI=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498545"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:33 +0800
IronPort-SDR: Hz2Gw/JWvAvpHOQpe50Rg1Wj9ctawVVp4qZxP4dRc1frsdcfWbBaFqJsSVHS/75Z091P3xaRFJ
 Pcv0cLRLTvmvE/dl/4dqyFu9X8H5dCqeQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:48 -0700
IronPort-SDR: FPKdo+z6jyoKNZF4VYLsjFOBzPOoJZkgkZogXWEkWvVeqdlFuaSNxP/L7qlntTRolSEnrvvTE+
 PfHQ5e+HiIrQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 50/64] target/riscv: vector single-width floating-point
 reduction instructions
Date: Thu,  2 Jul 2020 09:23:40 -0700
Message-Id: <20200702162354.928528-51-alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200701152549.1218-48-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 10 +++++++
 target/riscv/insn32.decode              |  4 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  5 ++++
 target/riscv/vector_helper.c            | 39 +++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1c1277c0d1..8e8b8d0407 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1079,3 +1079,13 @@ DEF_HELPER_6(vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b78fd8bc04..986308e99a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -541,6 +541,10 @@ vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
 vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
 vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
 vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
+# Vector ordered and unordered reduction sum
+vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
+vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
+vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 91fc1fd059..3dd4171898 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2346,3 +2346,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 /* Vector Widening Integer Reduction Instructions */
 GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
 GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
+
+/* Vector Single-Width Floating-Point Reduction Instructions */
+GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
+GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
+GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 72b812c743..73214534cb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4417,3 +4417,42 @@ GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
 GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
 GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
 GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
+
+/* Vector Single-Width Floating-Point Reduction Instructions */
+#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
+void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
+                  void *vs2, CPURISCVState *env,           \
+                  uint32_t desc)                           \
+{                                                          \
+    uint32_t mlen = vext_mlen(desc);                       \
+    uint32_t vm = vext_vm(desc);                           \
+    uint32_t vl = env->vl;                                 \
+    uint32_t i;                                            \
+    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;         \
+    TD s1 =  *((TD *)vs1 + HD(0));                         \
+                                                           \
+    for (i = 0; i < vl; i++) {                             \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {         \
+            continue;                                      \
+        }                                                  \
+        s1 = OP(s1, (TD)s2, &env->fp_status);              \
+    }                                                      \
+    *((TD *)vd + HD(0)) = s1;                              \
+    CLEAR_FN(vd, 1, sizeof(TD), tot);                      \
+}
+
+/* Unordered sum */
+GEN_VEXT_FRED(vfredsum_vs_h, uint16_t, uint16_t, H2, H2, float16_add, clearh)
+GEN_VEXT_FRED(vfredsum_vs_w, uint32_t, uint32_t, H4, H4, float32_add, clearl)
+GEN_VEXT_FRED(vfredsum_vs_d, uint64_t, uint64_t, H8, H8, float64_add, clearq)
+
+/* Maximum value */
+GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, float16_maxnum, clearh)
+GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, float32_maxnum, clearl)
+GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum, clearq)
+
+/* Minimum value */
+GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum, clearh)
+GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum, clearl)
+GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
-- 
2.27.0


