Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACC0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B16620780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LqRjbFJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B16620780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2SM-0000gZ-So
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AB-00054C-HC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2A9-00008W-IH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707653; x=1625243653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zlZevgr5oUMeYRDdBlWvtPtkM2HwLs+kb43TN+czGt0=;
 b=LqRjbFJ+AUYraohaSWzJxQDc3/BRn628Bj5Yb72qC/b/xfYthTeqB5Ag
 RWIvJq9oOMP9aLQPbKT427+3C/NY4ex17XL2G/OlroXbzJJmPDjQkP9r1
 Lp9RnLfnwSMXhuYbW51J1BcBuIaBA2Yw5u0uko4L3RqyfDO+jMvKwfnYd
 peI4m6SFVtF6obfk4d9DJwCp5mNa47Ru6FqhpdqYzT4lwgb8VNiNnwhU0
 OBn/kENVNbG/KWWYr7AfNjQJ0zfXcOnDMOO1rVDScyWjzlv7HiiD9g3bZ
 cZNTVPBEl87IlULqmnGtj+AXB6XX9OIDjKu2KBntFOCefqgtVhih39WH0 w==;
IronPort-SDR: fcnP2AyjxxuferKHsMW+IEAqkQ1gRCKKSxVM2WBg4auPZJ20n0S8U/M6Jek7jWvfEA0rorVpzN
 2lva0gODwO+5gr4nUHfX7e0RlkpIXEdeRK+noa/6gX05Xb0JYHPm/p9fpDsbgdRyylVuTfr/CZ
 Qwe9sMHLHlmN0mk/xKlu3LUUnDJ4u/1KfBR99OfBQ+tZs7KWKXUTNSd+IZrpEOBSETY5IqbSAh
 E9FlfqjkeskWV5A8C36R6PsBSOu0CA5vj4/JIM8IVqtwLQtLJ/JjkNGRwKrDmdeZzGC82jb8a5
 5u8=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498488"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:26 +0800
IronPort-SDR: Wim740UfshUxgjgV6QgVdbmxMNQkGaNcvh/oyp2RVYv//f/vojPiA21lZas/fouo8ZDdu1dhHB
 VJpT4hjX/6mQaP59EJcx/zKlZ5s1xW0WE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:41 -0700
IronPort-SDR: DPlefH9Z18XdmQZ5EUKH8qiDG6Hu8grdZHGxBaCjI5hjhmsEYVdkN96hewHg8Isn/k54sXZ+jf
 tqwcOyIErhNw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 25/64] target/riscv: vector widening integer multiply-add
 instructions
Date: Thu,  2 Jul 2020 09:23:15 -0700
Message-Id: <20200702162354.928528-26-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-23-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 22 ++++++++++++
 target/riscv/insn32.decode              |  7 ++++
 target/riscv/insn_trans/trans_rvv.inc.c |  9 +++++
 target/riscv/vector_helper.c            | 45 +++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a65a38596b..1249ee274d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -653,3 +653,25 @@ DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vwmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f01cf14777..843c15f8fa 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -395,6 +395,13 @@ vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
 vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
 vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
 vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
+vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
+vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0f549f7a19..24e43c615c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1609,3 +1609,12 @@ GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
 GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
+
+/* Vector Widening Integer Multiply-Add Instructions */
+GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9c31e4d75a..9dd2d5748e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1979,3 +1979,48 @@ GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
+
+/* Vector Widening Integer Multiply-Add Instructions */
+RVVCALL(OPIVV3, vwmaccu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vwmaccu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vwmaccu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MACC)
+RVVCALL(OPIVV3, vwmacc_vv_b, WOP_SSS_B, H2, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vwmacc_vv_h, WOP_SSS_H, H4, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vwmacc_vv_w, WOP_SSS_W, H8, H4, H4, DO_MACC)
+RVVCALL(OPIVV3, vwmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, DO_MACC)
+RVVCALL(OPIVV3, vwmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, DO_MACC)
+RVVCALL(OPIVV3, vwmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, DO_MACC)
+GEN_VEXT_VV(vwmaccu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmaccu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmaccu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmacc_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmacc_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmaccsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmaccsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmaccsu_vv_w, 4, 8, clearq)
+
+RVVCALL(OPIVX3, vwmaccu_vx_b, WOP_UUU_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmaccu_vx_h, WOP_UUU_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmaccu_vx_w, WOP_UUU_W, H8, H4, DO_MACC)
+RVVCALL(OPIVX3, vwmacc_vx_b, WOP_SSS_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmacc_vx_h, WOP_SSS_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmacc_vx_w, WOP_SSS_W, H8, H4, DO_MACC)
+RVVCALL(OPIVX3, vwmaccsu_vx_b, WOP_SSU_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmaccsu_vx_h, WOP_SSU_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmaccsu_vx_w, WOP_SSU_W, H8, H4, DO_MACC)
+RVVCALL(OPIVX3, vwmaccus_vx_b, WOP_SUS_B, H2, H1, DO_MACC)
+RVVCALL(OPIVX3, vwmaccus_vx_h, WOP_SUS_H, H4, H2, DO_MACC)
+RVVCALL(OPIVX3, vwmaccus_vx_w, WOP_SUS_W, H8, H4, DO_MACC)
+GEN_VEXT_VX(vwmaccu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmacc_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmacc_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmacc_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccsu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccus_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccus_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccus_vx_w, 4, 8, clearq)
-- 
2.27.0


