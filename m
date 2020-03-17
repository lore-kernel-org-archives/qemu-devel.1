Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EACCC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CBD20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CBD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFaI-0007ly-Hd
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFXR-0003f9-2w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFXP-0003l3-N2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFXP-0002JL-7D; Tue, 17 Mar 2020 12:57:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07470568|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_alarm|0.192127-0.000262492-0.80761; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.H1.prKF_1584464265; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.prKF_1584464265)
 by smtp.aliyun-inc.com(10.147.42.253);
 Wed, 18 Mar 2020 00:57:45 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 55/61] target/riscv: integer extract instruction
Date: Tue, 17 Mar 2020 23:06:47 +0800
Message-Id: <20200317150653.9008-56-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 91 +++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1231628cb2..26dd0f1b1b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -561,6 +561,7 @@ vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index fae72acaa1..4d7bb6b54e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2347,3 +2347,94 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
     }
     return false;
 }
+
+/*
+ *** Vector Permutation Instructions
+ */
+/* Integer Extract Instruction */
+static void extract_element(TCGv dest, TCGv_ptr base,
+                            int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_ld8u_tl(dest, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_ld16u_tl(dest, base, ofs);
+        break;
+    default:
+        tcg_gen_ld32u_tl(dest, base, ofs);
+        break;
+#if TARGET_LONG_BITS == 64
+    case MO_64:
+        tcg_gen_ld_i64(dest, base, ofs);
+        break;
+#endif
+    }
+}
+
+/* offset of the idx element with base regsiter r */
+static uint32_t endian_ofs(DisasContext *s, int r, int idx)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    return vreg_ofs(s, r) + ((idx ^ (7 >> s->sew)) << s->sew);
+#else
+    return vreg_ofs(s, r) + (idx << s->sew);
+#endif
+}
+
+/* adjust the index according to the endian */
+static void endian_adjust(TCGv_i32 ofs, int sew)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    tcg_gen_xori_i32(ofs, ofs, 7 >> sew);
+#endif
+}
+
+static bool trans_vext_x_v(DisasContext *s, arg_r *a)
+{
+    TCGv dest = tcg_temp_new();
+
+    if (a->rs1 == 0) {
+        /* Special case vmv.x.s rd, vs2. */
+        extract_element(dest, cpu_env,
+                        endian_ofs(s, a->rs2, 0), s->sew);
+    } else {
+        int vlen = s->vlen >> (3 + s->sew);
+        TCGv_i32 ofs = tcg_temp_new_i32();
+        TCGv_ptr  base = tcg_temp_new_ptr();
+        TCGv t_vlen, t_zero;
+
+        /*
+         * Mask the index to the length so that we do
+         * not produce an out-of-range load.
+         */
+        tcg_gen_trunc_tl_i32(ofs, cpu_gpr[a->rs1]);
+        tcg_gen_andi_i32(ofs, ofs, vlen - 1);
+
+        /* Convert the index to an offset. */
+        endian_adjust(ofs, s->sew);
+        tcg_gen_shli_i32(ofs, ofs, s->sew);
+
+        /* Convert the index to a pointer. */
+        tcg_gen_ext_i32_ptr(base, ofs);
+        tcg_gen_add_ptr(base, base, cpu_env);
+
+        /* Perform the load. */
+        extract_element(dest, base,
+                        vreg_ofs(s, a->rs2), s->sew);
+        tcg_temp_free_ptr(base);
+        tcg_temp_free_i32(ofs);
+
+        /* Flush out-of-range indexing to zero.  */
+        t_vlen = tcg_const_tl(vlen);
+        t_zero = tcg_const_tl(0);
+        tcg_gen_movcond_tl(TCG_COND_LTU, dest, cpu_gpr[a->rs1],
+                           t_vlen, dest, t_zero);
+        tcg_temp_free(t_vlen);
+        tcg_temp_free(t_zero);
+    }
+    gen_set_gpr(a->rd, dest);
+    tcg_temp_free(dest);
+    return true;
+}
-- 
2.23.0


