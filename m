Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E103CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7712088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a9tMeK2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7712088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Wv-0008Nk-VB
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2B1-0007RA-P0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:35:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Az-00008e-Pg
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707705; x=1625243705;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0sCW/GSWSkqSg+PBCbX4cSJGm6OKYpy7N4TrvM8cf8=;
 b=a9tMeK2qfNwKWr0RTm5uVRAj1Ycg4zVmwWdK7nvK/+yb3QDKvOaGh7e8
 SIWCOYZlqSe515UfPsrIpLyXrbYs+HrNO5/TqB64KMdjjyHZiX+wZ/qIM
 8nYcMW8MozJwk0inf2au9jfRz8B+xm/M6ZuEo/9K5KD5kHco1ykDm1XR5
 dd1XSQ3fDjvGBI2jFTjCJxa4+94fp//DhB1nWvLKj1xMLXCK/z3dMHZgy
 EGGR8Atya5I2+ZJHOlgDMioUacye3s5MKgp+FLpISAFKUidPBQxdCScmg
 jULDtrYq/lFATT61W4IqytzU0GtvL2oiWRDh6TlOJzcrftdIBLhsfKFu8 w==;
IronPort-SDR: oAcHxK8orLwT8YIhYeMHas5yum8nvrlSZOUJijIEQ5ceWnPWLnOM6q7xde7nrvYTRODbebrOmH
 YVO3QaVZdj86KFDArf5sZGOumRS8HCrfjvyJZOXQk7kmb4LGFSkkGCKpOQlnOxiktkT1t/e9WA
 SXa42bcOdXHjh4H4Q4wLGSnkvLtyxtZ0gsQX5wxOvwwmwKbB77nRzFgCCty3RHoNliHylh7sDN
 S+n5w7MQtm+1eCZzhZaUUaQiKEVBv304IybsjyivXTCIBi3Zyd04Bs5oiaPWARcI9RuuvUEz4O
 WsU=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498566"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:36 +0800
IronPort-SDR: DiBXLotPpKDs4PGSDeUSNoEixndMKZKigtc4s+UCDiLQf6q6NQzeWT+EMgjuxuzHNhwszSsRfk
 pbwY3m1rdi3560uFX74HRgQPHSoBg3Hck=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:51 -0700
IronPort-SDR: WG+Xmnr7LK6d38Rv6pgHcfWUfMi3G3pddpOtX7QBh4USDf0zLWGOY8kH4P5bQ3IM72B6BWvke5
 gpca/NXhoXfg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 59/64] target/riscv: integer scalar move instruction
Date: Thu,  2 Jul 2020 09:23:49 -0700
Message-Id: <20200702162354.928528-60-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-57-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h                |  6 +++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 60 +++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f3cea478f7..37d33820ad 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -32,4 +32,10 @@ FIELD(VDATA, WD, 11, 1)
 target_ulong fclass_h(uint64_t frs1);
 target_ulong fclass_s(uint64_t frs1);
 target_ulong fclass_d(uint64_t frs1);
+
+#define SEW8  0
+#define SEW16 1
+#define SEW32 2
+#define SEW64 3
+
 #endif
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c4496cd010..e06c0ffc22 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -564,6 +564,7 @@ vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
+vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index cfbbd88dbf..b10b89daa9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2649,3 +2649,63 @@ static bool trans_vext_x_v(DisasContext *s, arg_r *a)
     tcg_temp_free_i64(tmp);
     return true;
 }
+
+/* Integer Scalar Move Instruction */
+
+static void store_element(TCGv_i64 val, TCGv_ptr base,
+                          int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_st8_i64(val, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_st16_i64(val, base, ofs);
+        break;
+    case MO_32:
+        tcg_gen_st32_i64(val, base, ofs);
+        break;
+    case MO_64:
+        tcg_gen_st_i64(val, base, ofs);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+/*
+ * Store vreg[idx] = val.
+ * The index must be in range of VLMAX.
+ */
+static void vec_element_storei(DisasContext *s, int vreg,
+                               int idx, TCGv_i64 val)
+{
+    store_element(val, cpu_env, endian_ofs(s, vreg, idx), s->sew);
+}
+
+/* vmv.s.x vd, rs1 # vd[0] = rs1 */
+static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
+{
+    if (vext_check_isa_ill(s)) {
+        /* This instruction ignores LMUL and vector register groups */
+        int maxsz = s->vlen >> 3;
+        TCGv_i64 t1;
+        TCGLabel *over = gen_new_label();
+
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), maxsz, maxsz, 0);
+        if (a->rs1 == 0) {
+            goto done;
+        }
+
+        t1 = tcg_temp_new_i64();
+        tcg_gen_extu_tl_i64(t1, cpu_gpr[a->rs1]);
+        vec_element_storei(s, a->rd, 0, t1);
+        tcg_temp_free_i64(t1);
+    done:
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
-- 
2.27.0


