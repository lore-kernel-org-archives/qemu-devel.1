Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB09C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A448208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dr/Q6n6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A448208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowhX-0004zY-DG
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJ7-0004g7-O2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJ5-00031d-N7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208490; x=1624744490;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9SXQtUtJ5qsaYk/439J2moCd7KbvRR8Dqbhw2tPYyRI=;
 b=dr/Q6n6fQAT9jwGRz5030BQYjEeyTWeMseAsJHWrtziIboXdCmsUQNO5
 y0xymvhdTVlPd3GhO6suz8KP5ANHkV9QonZvA6E3oiatclRqB5rhPtUHC
 xXL90d2sbV+yjWyjEkHOrWkwsr3uAQD1qSWGwfVjXqVZJzkCeIWPL40fn
 Tsfh+UumEqB0L01tY24sgkFmFDdqVtIS/3xM5vn0hDfosLbEFaUe7bcfh
 m+4P1nqmgrfr6MfbQ6vgrV48V/gwEUrKxm/h6u4HwBFQhXDTU1RNLxkFy
 qqV0gngQrX2C0n62H2ZTLBOGjWvEsSVf/7wQjUD1Jqtxb4DMWlVaMyrqx g==;
IronPort-SDR: TNrSV6Pd5jpYo8nX7w4xe52t6WYXLlEg03z794JWvDVNPhOFOBeWyp3XKqRL+6SoDt75QXJg0p
 C12HfbcKo6MMaROfKqIGzs7mDJXVFUljZ4sx/fNn5kC487Rg21QcJLayMPYv1cdOGIooNqFr6C
 HskJZhC08VZBZbuXEwXMxoegHi2mrgSZQ7Z+wzN+BS/o7KUXPWCY9fCAIO648/Qxncm/ZOKb7W
 GxjSaPGrf31NwzQ9e3tUanzFbe1DhBeanF8Mdt+ZQGwR5KXUeysJM90nkMtCYFd0x7vjADS3HN
 QDo=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048413"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:51 +0800
IronPort-SDR: q00bSpHb2+xt9lVquyXXCUP22J2rTaT48PWXUseD7jk9kHkl9X7ZOFV2G+OpRpsoadtMaYviXC
 4Y0l9ARd4Ufdd0g3brHNjHIn3MrPaZ6DM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:48 -0700
IronPort-SDR: sma0jyFj/duOSqrip7jgfVLAJy8MRcFI/OP/5PAmiRBLSl/lmol05fwLalsVHQGQpyq9wHfW6q
 xr/ypUvkUtEA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 54/63] target/riscv: set-X-first mask bit
Date: Fri, 26 Jun 2020 14:44:01 -0700
Message-Id: <20200626214410.3613258-55-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-53-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  3 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 28 +++++++++++
 target/riscv/vector_helper.c            | 63 +++++++++++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 28aeb74f43..0f9012be7e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1105,3 +1105,7 @@ DEF_HELPER_6(vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_4(vmpopc_m, tl, ptr, ptr, env, i32)
 
 DEF_HELPER_4(vmfirst_m, tl, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vmsbf_m, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vmsif_m, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vmsof_m, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a0f3315dbc..fab4a0b7e2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -557,6 +557,9 @@ vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
 vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
 vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
 vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
+vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
+vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
+vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 01c32a3278..33ffe5dc1a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2453,3 +2453,31 @@ static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
     }
     return false;
 }
+
+/* vmsbf.m set-before-first mask bit */
+/* vmsif.m set-includ-first mask bit */
+/* vmsof.m set-only-first mask bit */
+#define GEN_M_TRANS(NAME)                                          \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (vext_check_isa_ill(s)) {                                   \
+        uint32_t data = 0;                                         \
+        gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
+        TCGLabel *over = gen_new_label();                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
+                           vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
+                           cpu_env, 0, s->vlen / 8, data, fn);     \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_M_TRANS(vmsbf_m)
+GEN_M_TRANS(vmsif_m)
+GEN_M_TRANS(vmsof_m)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 441308be12..d07abb34ed 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4581,3 +4581,66 @@ target_ulong HELPER(vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     }
     return -1LL;
 }
+
+enum set_mask_type {
+    ONLY_FIRST = 1,
+    INCLUDE_FIRST,
+    BEFORE_FIRST,
+};
+
+static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                   uint32_t desc, enum set_mask_type type)
+{
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    int i;
+    bool first_mask_bit = false;
+
+    for (i = 0; i < vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        /* write a zero to all following active elements */
+        if (first_mask_bit) {
+            vext_set_elem_mask(vd, mlen, i, 0);
+            continue;
+        }
+        if (vext_elem_mask(vs2, mlen, i)) {
+            first_mask_bit = true;
+            if (type == BEFORE_FIRST) {
+                vext_set_elem_mask(vd, mlen, i, 0);
+            } else {
+                vext_set_elem_mask(vd, mlen, i, 1);
+            }
+        } else {
+            if (type == ONLY_FIRST) {
+                vext_set_elem_mask(vd, mlen, i, 0);
+            } else {
+                vext_set_elem_mask(vd, mlen, i, 1);
+            }
+        }
+    }
+    for (; i < vlmax; i++) {
+        vext_set_elem_mask(vd, mlen, i, 0);
+    }
+}
+
+void HELPER(vmsbf_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                     uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, BEFORE_FIRST);
+}
+
+void HELPER(vmsif_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                     uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, INCLUDE_FIRST);
+}
+
+void HELPER(vmsof_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                     uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, ONLY_FIRST);
+}
-- 
2.27.0


