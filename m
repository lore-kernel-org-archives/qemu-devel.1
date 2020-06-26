Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2B6206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BX+859tM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2B6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowjq-0008Ul-L6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJX-0005Q0-O0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJU-00031d-5J
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208523; x=1624744523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G5aJs2qui+PMJ+c5UAjw7pPsqCfX1UfvDGTywWuyteo=;
 b=BX+859tMHRYJuo/RELXAqNHKS2xDMIrkmVy0A/FYXNYBqCIi9Eg6CVlY
 aqzkJAqvmVw0IRjHXFo1uu7DbXyTJFN8wKATKM4dWEGi+IJC2DmZWdmeq
 I9yGlq44wrmdlrv50gaLoyC4IE1uf/Xzr8fOJE+3BK/4ya8UZk4bSTHra
 Ew+Fqwyl85V/n1lXq+KwDa5wUQktrncUqFxPcNtFPWfxAmCyKywNr2KU7
 MKuhiiSAyMbhYh9Gzya4+NcyrgCD5nx2KqaRaeVW6gtB4F2mNln2jZGDW
 5DjfCibUMsXMzfJEJRyb+FlP9w/ohfvfcWbxhnwbXna4KwHonDTU22IcQ g==;
IronPort-SDR: YxlWC98zgmp+hrjyu7akk2M+5vIdippe6t1bcO7p0ptuWMFkdPbqZdsCtD010XtDg/wOKx6CIX
 FRDMSYxT4sl74DIdcr1D/4rVsEV6SquJsf/EBEIp8cWhBnsLEQRJGFKznt2cKeObu8KLND+klZ
 RpVR77o08Uzh7rnPlbI7imZV1NdcLE3FsjWdmTPEKOWrHTtnqtbYWGo7+Mfs9bgegrX2o/zxxu
 LnjfJDPTtWCqMWF3rQnUKj0lb0BdqreyhmtfVaApfW2kDFvhSsYNabYbH6II9LecODvzI77wre
 fsQ=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048425"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:53 +0800
IronPort-SDR: jsW2+A9B8kj8FaIqPS38D0nRAAI9RzWI3+peE95h/T7UYW1+h6pKDTBqHucNVra0rvFyaVacSD
 4+zmpdbiZnNDcavsC6BSays8ZRO2IVnAM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:50 -0700
IronPort-SDR: aQhaq2ZO+/flsckvQiLWCXLVzQWUzr/IAfSrX4egO/Y8FyOAdCALrlCUT6PeRudmcDIP6ZlMY1
 Fh+nRbDMIFAA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:52 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 62/63] target/riscv: vector compress instruction
Date: Fri, 26 Jun 2020 14:44:09 -0700
Message-Id: <20200626214410.3613258-63-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:44
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
Message-id: 20200623215920.2594-61-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  5 ++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 32 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 26 ++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index eca1ab541b..acc298219d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1145,3 +1145,8 @@ DEF_HELPER_6(vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vcompress_vm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 80d5ff74a9..bdd8563067 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -577,6 +577,7 @@ vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
 vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
+vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c0b7745a63..dc333e6a91 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2854,3 +2854,35 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
     return true;
 }
+
+/* Vector Compress Instruction */
+static bool vcompress_vm_check(DisasContext *s, arg_r *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs1, 1) &&
+            (a->rd != a->rs2));
+}
+
+static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
+{
+    if (vcompress_vm_check(s, a)) {
+        uint32_t data = 0;
+        static gen_helper_gvec_4_ptr * const fns[4] = {
+            gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
+            gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
+        };
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
+                           cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7ee87154c1..dea1a398dc 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4871,3 +4871,29 @@ GEN_VEXT_VRGATHER_VX(vrgather_vx_b, uint8_t, H1, clearb)
 GEN_VEXT_VRGATHER_VX(vrgather_vx_h, uint16_t, H2, clearh)
 GEN_VEXT_VRGATHER_VX(vrgather_vx_w, uint32_t, H4, clearl)
 GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
+
+/* Vector Compress Instruction */
+#define GEN_VEXT_VCOMPRESS_VM(NAME, ETYPE, H, CLEAR_FN)                   \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vl = env->vl;                                                \
+    uint32_t num = 0, i;                                                  \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vext_elem_mask(vs1, mlen, i)) {                              \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
+        num++;                                                            \
+    }                                                                     \
+    CLEAR_FN(vd, num, num * sizeof(ETYPE), vlmax * sizeof(ETYPE));        \
+}
+
+/* Compress into vd elements of vs2 where vs1 is enabled */
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_b, uint8_t, H1, clearb)
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_h, uint16_t, H2, clearh)
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_w, uint32_t, H4, clearl)
+GEN_VEXT_VCOMPRESS_VM(vcompress_vm_d, uint64_t, H8, clearq)
-- 
2.27.0


