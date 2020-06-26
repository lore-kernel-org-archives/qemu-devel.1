Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA48C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0C62088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cNVieOa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0C62088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowmq-0004dM-Dz
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJD-0004lN-2u
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJ7-00030Y-Tv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208491; x=1624744491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q8sAhMVT4TAclSmYzFeyVwajCLkUb4hu/iLpQ0/NHgE=;
 b=cNVieOa+sAkGqjsUkW2jpK7/v4VDGGGSyJbiyT10U3R24zY+3eqR/v+7
 B182qDf5LptGllHFj8MHVq/JJjCVQEx1IIK2uI6mcOqu6hmWB+LsbHlXD
 /XVNkyjSs76Nv++TscoCcejSgObEZNhEL15tAjNmojzT6DGfHSgCyjoor
 O/fTIiCSpXsgm9hzcNkFk9/mTdwM6V7OAepX/6wQxeN4i1ZTMif8gn/JO
 VJcrDvN79zlvZNfTQjI5BHuS270fy0K4ST0aphB1ACht2cveVjLoqOFcE
 iNwLem8g7zSkQN9OJnOh0XyQQoGR3pn5EsTVFiI98LVBbuHZ6Tf7dXQn5 A==;
IronPort-SDR: v+kb9CztkIaNXWgZQX8S5VAT6VVPXqM+Bz+X4me8FnPErWKLwTV4iVwYHcFBdxBWOQJuNspHOG
 O2s8cDOfuumObHhqr34/8vBSbMYI0CfXegltEG1KRe1xgsmlGrViqSAZC6xqpO+RLPbz+lg2Vo
 e6UQeDTwoxuwCkh6TpLIZYlaxFi0WhVWnmYwh+sSHT1LS7lIFqgfZiuwxgD+NFJENvjsnEXCrC
 k7E4fvMwPE4Lar4GO0wkP0rEbXsRm2iU1NoxGScEcPYcfMSra1o4irYbMXj9DI4V9J9bcg//PX
 d5o=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048416"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:53 +0800
IronPort-SDR: DrjDE/v2Of6++hmSxD6FecAIS9m/apCh6QysnopG4QqjFjV29npkhUDh8S/t1LTpkTYWbv0FBD
 l97Ro3pctEg84hcgpDQ5WycDyxwuYFVaw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:49 -0700
IronPort-SDR: hXohBGB3B8ml1pIbIVWhCjWAtoPaDTVy+H1WTDHlf/a26KwxBpAUwIDv9xBIBR6+extyqPaTcV
 smVhO2V49cNQ==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 57/63] target/riscv: integer extract instruction
Date: Fri, 26 Jun 2020 14:44:04 -0700
Message-Id: <20200626214410.3613258-58-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-56-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode              |   1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 116 ++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6f2e2df7d3..c4496cd010 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -563,6 +563,7 @@ vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index e94d149d3b..cfbbd88dbf 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2533,3 +2533,119 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
     }
     return false;
 }
+
+/*
+ *** Vector Permutation Instructions
+ */
+
+/* Integer Extract Instruction */
+
+static void load_element(TCGv_i64 dest, TCGv_ptr base,
+                         int ofs, int sew)
+{
+    switch (sew) {
+    case MO_8:
+        tcg_gen_ld8u_i64(dest, base, ofs);
+        break;
+    case MO_16:
+        tcg_gen_ld16u_i64(dest, base, ofs);
+        break;
+    case MO_32:
+        tcg_gen_ld32u_i64(dest, base, ofs);
+        break;
+    case MO_64:
+        tcg_gen_ld_i64(dest, base, ofs);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
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
+/* Load idx >= VLMAX ? 0 : vreg[idx] */
+static void vec_element_loadx(DisasContext *s, TCGv_i64 dest,
+                              int vreg, TCGv idx, int vlmax)
+{
+    TCGv_i32 ofs = tcg_temp_new_i32();
+    TCGv_ptr base = tcg_temp_new_ptr();
+    TCGv_i64 t_idx = tcg_temp_new_i64();
+    TCGv_i64 t_vlmax, t_zero;
+
+    /*
+     * Mask the index to the length so that we do
+     * not produce an out-of-range load.
+     */
+    tcg_gen_trunc_tl_i32(ofs, idx);
+    tcg_gen_andi_i32(ofs, ofs, vlmax - 1);
+
+    /* Convert the index to an offset. */
+    endian_adjust(ofs, s->sew);
+    tcg_gen_shli_i32(ofs, ofs, s->sew);
+
+    /* Convert the index to a pointer. */
+    tcg_gen_ext_i32_ptr(base, ofs);
+    tcg_gen_add_ptr(base, base, cpu_env);
+
+    /* Perform the load. */
+    load_element(dest, base,
+                 vreg_ofs(s, vreg), s->sew);
+    tcg_temp_free_ptr(base);
+    tcg_temp_free_i32(ofs);
+
+    /* Flush out-of-range indexing to zero.  */
+    t_vlmax = tcg_const_i64(vlmax);
+    t_zero = tcg_const_i64(0);
+    tcg_gen_extu_tl_i64(t_idx, idx);
+
+    tcg_gen_movcond_i64(TCG_COND_LTU, dest, t_idx,
+                        t_vlmax, dest, t_zero);
+
+    tcg_temp_free_i64(t_vlmax);
+    tcg_temp_free_i64(t_zero);
+    tcg_temp_free_i64(t_idx);
+}
+
+static void vec_element_loadi(DisasContext *s, TCGv_i64 dest,
+                              int vreg, int idx)
+{
+    load_element(dest, cpu_env, endian_ofs(s, vreg, idx), s->sew);
+}
+
+static bool trans_vext_x_v(DisasContext *s, arg_r *a)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv dest = tcg_temp_new();
+
+    if (a->rs1 == 0) {
+        /* Special case vmv.x.s rd, vs2. */
+        vec_element_loadi(s, tmp, a->rs2, 0);
+    } else {
+        /* This instruction ignores LMUL and vector register groups */
+        int vlmax = s->vlen >> (3 + s->sew);
+        vec_element_loadx(s, tmp, a->rs2, cpu_gpr[a->rs1], vlmax);
+    }
+    tcg_gen_trunc_i64_tl(dest, tmp);
+    gen_set_gpr(a->rd, dest);
+
+    tcg_temp_free(dest);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
-- 
2.27.0


