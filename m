Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C138C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5D320885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C8gLsqUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5D320885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowom-0007lQ-8Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJJ-00053g-Rm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJH-00031d-Vo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208505; x=1624744505;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FsRgePvLj/4v9beSBTvqtUqY2I8z+eAU6GenEENxbwA=;
 b=C8gLsqUAC/yIYGUPVkH5/SiG+Qxc7LTBHUS9RJ6OvmQNwy1uQJL3C8yy
 Kwcr+i7fDdlokZWX9zPpnarlwMPNT+y9OpL7IZKTZBg81WuteyXFl4p0w
 bdfIyI+na3KQJtWyDelJ0kYGQ6wI+9bVT3nlXcRD8XnC7ddau0NxBzUt+
 irsBbpCJtjcrnJU5ZjfcEzDvqIUwGbVH70I7WR4Jl0NMJwK4ZszBz9lN6
 lxZLKYXAEpvOJ3HrK0RuAc56GQc5U21IYV/iNKdopL/BuzvEibRNfyVib
 sDKUVG2AIug9CJlUz84kS6elWgbM1cyfnNUX6r1AyqAiuNUY4EEu5bYRC g==;
IronPort-SDR: OZDx8GPADYJw67LFbT195UuYUC7nRUkP4jI74meQOEqTZZZiMpDBU8wwSy+VRjWHuNB4a/ouaD
 D2JZBcRg9K8qhdD2nWnM+rg7WhtoHCYKBpDCRLQ7AOmDSZG6DjC8fJxVyHM7E8o6GmU24229nB
 oaMa0BWbcP9vj6m/NZTOJgwHPQ6xHETXuRr6cXwhYAYrHN9Chpo53DgJU6owuVPmmKgxCoH+E8
 hVZjqwrFZBD9sEpv5kmgWKFa4ZirZ0VGgAG1MW7oVkLdm9qmz7JnVqeyM6q7ECJD4GAa9Ss7YD
 Kng=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048417"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:53 +0800
IronPort-SDR: f0xgBgNxHwXPJFh+WJBqVUu/luO2DON2syrit3iiVy7glCyaafoMXCijtXVA2p73L4vNN9cCxn
 XdDSnzEKBGW7g+bWMW6rvQbB2QngLbOms=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:49 -0700
IronPort-SDR: 6k8IWD4zRCRRsVUpOWlbv+A/Di2XyaPBHJvbfPtTrQPWcFVlPW2dml5DBNCsXKjES7yKvwad0m
 sC7QbKicpi2Q==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:51 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 58/63] target/riscv: integer scalar move instruction
Date: Fri, 26 Jun 2020 14:44:05 -0700
Message-Id: <20200626214410.3613258-59-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-57-zhiwei_liu@c-sky.com
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


