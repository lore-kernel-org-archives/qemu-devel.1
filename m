Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65933C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3024E20870
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zn2VmjRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3024E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2VI-0005ho-FD
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Av-00077P-KO
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:35:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2At-0000Ah-1J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707699; x=1625243699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6Ynlm94Zc+VFzL93voN7Gbl80eTnrXSvwDT3htX/+BU=;
 b=Zn2VmjReifz9mh7G0RIBIUt7r4FCp3gbIwJ1MkPPnPwBhxeqn/cvanbm
 rClSmKM7fUA6YSIaxLS4ksuSIEI/gzAZQFcdqhOvBLqD4ifhcHwzfAI15
 5SdKctP2LVONk+333NMVmOXiGEvvSgamGjWtE89n3MNpl9ljuMWXzgl5y
 SR1bn7dL2NfuelgxoMfqn7Z4guEf4wRWkgQJG9bnRHi8zwWU5/CmaWlrT
 EoJOw9HgaBLnsjzgKfUuuvDPG3nc9QehN7RbHfz17ufOxsYR5w4B/g+DH
 7OjrmCNU9jN/yihtQGWWC6p/za6y54ENCSqivfmtPxVDPHmyy6xoaUnAS A==;
IronPort-SDR: dhPNzo22te8ZM42nBfhW/82rGRnsjMUjsk0CBDvJfHX4+ORM6y1NnEJWWuaeOcZVyhTfRZScw+
 alDX63nQU49G9eCgCDX2ES3F9ODN2+QSxxKx5KH/BFXoq7ki2fP1PNaOlAsyi6bNSFjKUS+q7z
 U59d+1+GkFqQkpZx0tA5HJaK3izdN2MUCLdeYUyAIG0YoP0rxfaNKnTtm7T+VSNYeerKIOhqMN
 MF0mOUMvRI68ed4ydG39TdGCFM6SjGBL+CPQBs3LA0vq1g2cug4r7GX7o3oFDzZlQf7Q8Msgny
 JoY=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498560"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:35 +0800
IronPort-SDR: BOyex8aqGFkfUYtI4rLRaHUGCMizrivundEJFSJn7apjsYz8TdHfNpWvhwciFYYHnPefcIA3ri
 r1BeEh9GUJS9UUiZ2gq2/PFFKeu7N74OM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:50 -0700
IronPort-SDR: 5Fu2XOAsE6+Qs6VpbjXnD/4goTnA8uTYfKE8TOI/IvzOyGY58uQGyCfLBYpyXQugirQDjtz0Wf
 FgjRbutATv/Q==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 57/64] target/riscv: vector element index instruction
Date: Thu,  2 Jul 2020 09:23:47 -0700
Message-Id: <20200702162354.928528-58-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-55-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  5 +++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 25 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 24 ++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 91db396979..c6695ea7a8 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1114,3 +1114,8 @@ DEF_HELPER_5(viota_m_b, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(viota_m_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(viota_m_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(viota_m_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_4(vid_v_b, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vid_v_h, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vid_v_w, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vid_v_d, void, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 415523573d..6f2e2df7d3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -70,6 +70,7 @@
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
+@r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
@@ -561,6 +562,7 @@ vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4dc893fa70..e94d149d3b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2508,3 +2508,28 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
     }
     return false;
 }
+
+/* Vector Element Index Instruction */
+static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false) &&
+        vext_check_overlap_mask(s, a->rd, a->vm, false)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        static gen_helper_gvec_2_ptr * const fns[4] = {
+            gen_helper_vid_v_b, gen_helper_vid_v_h,
+            gen_helper_vid_v_w, gen_helper_vid_v_d,
+        };
+        tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e0e6299e64..0fa899b6ff 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4673,3 +4673,27 @@ GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
 GEN_VEXT_VIOTA_M(viota_m_h, uint16_t, H2, clearh)
 GEN_VEXT_VIOTA_M(viota_m_w, uint32_t, H4, clearl)
 GEN_VEXT_VIOTA_M(viota_m_d, uint64_t, H8, clearq)
+
+/* Vector Element Index Instruction */
+#define GEN_VEXT_VID_V(NAME, ETYPE, H, CLEAR_FN)                          \
+void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    int i;                                                                \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = i;                                        \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+
+GEN_VEXT_VID_V(vid_v_b, uint8_t, H1, clearb)
+GEN_VEXT_VID_V(vid_v_h, uint16_t, H2, clearh)
+GEN_VEXT_VID_V(vid_v_w, uint32_t, H4, clearl)
+GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
-- 
2.27.0


