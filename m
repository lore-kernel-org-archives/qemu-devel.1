Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4627DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEAA2089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SRhn94TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEAA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowPn-0006kA-6H
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI6-0002sm-MU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI4-0002zW-GM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208424; x=1624744424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uQEy8TypEIi/gR8DwB3R6CCzI8cH45ZiqSr+NGl1IoY=;
 b=SRhn94TQF6+b/M6GX802EqmeiFvZIZDOq+yzLqZGWYtTWMprEKkxKuDA
 CZ125CwDFHHUiYaQsz7LOAZRC0Z2BtK/vaB88GHfPgdWIyVGCZ+C3cMI3
 VHWpTDIZfegKHMbhDn98OHZKQKSHeS/rYsIs7lr0rjIX/CTOpSet9Ne9T
 wbJxNi6/DJ29IgnCnk/8K8PGUZLaXL+n0E5g4fRXzEnPJ9EZibnoamNHD
 emxm1pQ2E+rfzJN1wBmlLniiggA+QTG4IOYQWe3Annfu6EXied6gQcHKg
 r4VMtbpli75DPYgZfBkCSUitfIMpyqyDmh47uloxUv2OlKvz4/2EJ+vIR w==;
IronPort-SDR: gV+mytJSjDvm94uNVl0kI8FW53He2BaHKLemgD/yY22nroVJki8WAA0/S9ZufwIqLo1gAtCD56
 jYPKILfpstXYDdhejWF6MaNSfKZtoHeUpD3cf9xEDAdTMneiEqh+maCBcir/xFpvkmmiWas5fw
 6Bmwd67k5S249iZ1ogKP05wx7f+gI93TAk/tPfau3Oqh9s5Y365PJq6zo/QzVACFfEhOh09fl0
 RsxvPKpjgX3iAu4EOUzTxgfzUA6QsVrz6ed6FalIBhCCpz6F0/4nUAHX4JmMPQUWSSzC6wIfmr
 /sA=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:38 +0800
IronPort-SDR: a70BZnvm0unfF69Xi1/ed1LJWGGk5LQh/aIQIOWhfmIkIWhQ5SuX1MEpq9qhXTrW6OvK6qzG7k
 HxO4sixjup0T9O2y6RU7ox4Tp22BC9GQI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:37 -0700
IronPort-SDR: p9wWMG5DMAacXhrMyC/Twoe09/nQVlv0K61egOFyRwXi3wimzwjTFU/vg35WUw/9d2GyXDcDB+
 ORd5ZDssTtTA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/63] target/riscv: vector bitwise logical instructions
Date: Fri, 26 Jun 2020 14:43:22 -0700
Message-Id: <20200626214410.3613258-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:37
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
Message-id: 20200623215920.2594-14-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 25 ++++++++++++
 target/riscv/insn32.decode              |  9 +++++
 target/riscv/insn_trans/trans_rvv.inc.c | 11 ++++++
 target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 67a2e64c4a..f8b1c8a800 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -382,3 +382,28 @@ DEF_HELPER_6(vmsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vand_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index be63e900c6..34d05a5917 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -313,6 +313,15 @@ vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
 vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
 vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
 vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
+vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
+vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
+vor_vv          001010 . ..... ..... 000 ..... 1010111 @r_vm
+vor_vx          001010 . ..... ..... 100 ..... 1010111 @r_vm
+vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
+vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
+vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
+vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 98bd5bcb79..1552534796 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1362,3 +1362,14 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 
 GEN_OPIVI_TRANS(vadc_vim, 0, vadc_vxm, opivx_vadc_check)
 GEN_OPIVI_TRANS(vmadc_vim, 0, vmadc_vxm, opivx_vmadc_check)
+
+/* Vector Bitwise Logical Instructions */
+GEN_OPIVV_GVEC_TRANS(vand_vv, and)
+GEN_OPIVV_GVEC_TRANS(vor_vv,  or)
+GEN_OPIVV_GVEC_TRANS(vxor_vv, xor)
+GEN_OPIVX_GVEC_TRANS(vand_vx, ands)
+GEN_OPIVX_GVEC_TRANS(vor_vx,  ors)
+GEN_OPIVX_GVEC_TRANS(vxor_vx, xors)
+GEN_OPIVI_GVEC_TRANS(vand_vi, 0, vand_vx, andi)
+GEN_OPIVI_GVEC_TRANS(vor_vi, 0, vor_vx,  ori)
+GEN_OPIVI_GVEC_TRANS(vxor_vi, 0, vxor_vx, xori)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ad746175bd..6c53dc5796 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1265,3 +1265,54 @@ GEN_VEXT_VMADC_VXM(vmsbc_vxm_b, uint8_t,  H1, DO_MSBC)
 GEN_VEXT_VMADC_VXM(vmsbc_vxm_h, uint16_t, H2, DO_MSBC)
 GEN_VEXT_VMADC_VXM(vmsbc_vxm_w, uint32_t, H4, DO_MSBC)
 GEN_VEXT_VMADC_VXM(vmsbc_vxm_d, uint64_t, H8, DO_MSBC)
+
+/* Vector Bitwise Logical Instructions */
+RVVCALL(OPIVV2, vand_vv_b, OP_SSS_B, H1, H1, H1, DO_AND)
+RVVCALL(OPIVV2, vand_vv_h, OP_SSS_H, H2, H2, H2, DO_AND)
+RVVCALL(OPIVV2, vand_vv_w, OP_SSS_W, H4, H4, H4, DO_AND)
+RVVCALL(OPIVV2, vand_vv_d, OP_SSS_D, H8, H8, H8, DO_AND)
+RVVCALL(OPIVV2, vor_vv_b, OP_SSS_B, H1, H1, H1, DO_OR)
+RVVCALL(OPIVV2, vor_vv_h, OP_SSS_H, H2, H2, H2, DO_OR)
+RVVCALL(OPIVV2, vor_vv_w, OP_SSS_W, H4, H4, H4, DO_OR)
+RVVCALL(OPIVV2, vor_vv_d, OP_SSS_D, H8, H8, H8, DO_OR)
+RVVCALL(OPIVV2, vxor_vv_b, OP_SSS_B, H1, H1, H1, DO_XOR)
+RVVCALL(OPIVV2, vxor_vv_h, OP_SSS_H, H2, H2, H2, DO_XOR)
+RVVCALL(OPIVV2, vxor_vv_w, OP_SSS_W, H4, H4, H4, DO_XOR)
+RVVCALL(OPIVV2, vxor_vv_d, OP_SSS_D, H8, H8, H8, DO_XOR)
+GEN_VEXT_VV(vand_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vand_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vand_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vand_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vor_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vor_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vor_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vor_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vxor_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vxor_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vxor_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vxor_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vand_vx_b, OP_SSS_B, H1, H1, DO_AND)
+RVVCALL(OPIVX2, vand_vx_h, OP_SSS_H, H2, H2, DO_AND)
+RVVCALL(OPIVX2, vand_vx_w, OP_SSS_W, H4, H4, DO_AND)
+RVVCALL(OPIVX2, vand_vx_d, OP_SSS_D, H8, H8, DO_AND)
+RVVCALL(OPIVX2, vor_vx_b, OP_SSS_B, H1, H1, DO_OR)
+RVVCALL(OPIVX2, vor_vx_h, OP_SSS_H, H2, H2, DO_OR)
+RVVCALL(OPIVX2, vor_vx_w, OP_SSS_W, H4, H4, DO_OR)
+RVVCALL(OPIVX2, vor_vx_d, OP_SSS_D, H8, H8, DO_OR)
+RVVCALL(OPIVX2, vxor_vx_b, OP_SSS_B, H1, H1, DO_XOR)
+RVVCALL(OPIVX2, vxor_vx_h, OP_SSS_H, H2, H2, DO_XOR)
+RVVCALL(OPIVX2, vxor_vx_w, OP_SSS_W, H4, H4, DO_XOR)
+RVVCALL(OPIVX2, vxor_vx_d, OP_SSS_D, H8, H8, DO_XOR)
+GEN_VEXT_VX(vand_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vand_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vand_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vand_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vor_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vor_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vor_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vor_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vxor_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vxor_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vxor_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vxor_vx_d, 8, 8, clearq)
-- 
2.27.0


