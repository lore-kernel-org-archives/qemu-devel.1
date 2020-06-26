Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE62C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD479208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kVnZU8/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD479208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowft-0001WL-3m
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIk-0003n6-2e
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIg-0002yu-QE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208462; x=1624744462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BcwAB+ogv3PTHvbq1Jgzhc/H4cmmTkFF162wU2S75wg=;
 b=kVnZU8/gPDuxONc8YcD2yRiPd7gdcZmBfK79HxWDg7+YYfNg4OS5gx+9
 TWpMpT2CxaYQwDJjBLVvpP6di5wNfS6aVJWOQZoSEXShXvxuKVsR7RucD
 Nauxjiwd9T9n4Ut58r5G1nB5TQpdh2ENPf2J4drYHyx48Lyy5pYHNR/pp
 t7gFbcbgOKu0nrOzkosaJZzB/fODIO9Th/d+2WVxGxpbUxGZEuNwb+dPb
 NDN6scaSClxzyYG/NxozWOqUL4lnZ2VKo0ilSCUGEmW+AihXGUNpmXEaz
 Q5yes/O8Y7lhP6IlVuKY7PUKvetzBg5q9jPntrtkT8tf6LARzmRrGDewL A==;
IronPort-SDR: OMYAfstRGTF3/V2YMpcIYq4P9AW6bqs8nXHDVcO1x6oPCV4mK6Bb3FJUmgdlhwTMiyk8RHVfLH
 ZXeq9wd06QThqmVh4wqgfKfoX0wgKYc5VTU69vWxTBECkTu868bNq6spNeLermlKSANJC2uc8l
 NqR8F05KTcML5ZmdMhJ1ZIbHjhdjDAWlgAEFnZledeULUvddmqFdJxqjlzydjffX2Wr2cuShOH
 hsdS8LV0BqF+w1cD7AI6/cg6BJPlK35mAI9gSx7M5vWeqfs/ly22B7tOZHonRATmdfPfS3lS3o
 0FE=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261268"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:42 +0800
IronPort-SDR: CUBKNiMZA3JqCQ0iKlal+mhe7vNjUXmaUOj3nBDr7MeUTH9TtG7RtYXGCEzYNvqJ6G8P28RaF6
 yxlfIem8eI44jPzHDAddQFy39rmNHDe1I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:40 -0700
IronPort-SDR: w//2AMM+NQSRy5Y/p5PN93/Z7bM2sFK8gz+MOUDJ0uEvcFW7+oEUhQ7RmrwskcHEQcQ668WIJL
 GDU+2OB9aSrg==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 27/63] target/riscv: vector single-width averaging add and
 subtract
Date: Fri, 26 Jun 2020 14:43:34 -0700
Message-Id: <20200626214410.3613258-28-alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-26-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   5 ++
 target/riscv/insn_trans/trans_rvv.inc.c |   7 ++
 target/riscv/vector_helper.c            | 100 ++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 85bd4b91bc..db9e2024ae 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -725,3 +725,20 @@ DEF_HELPER_6(vssub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vaadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 70df42de9a..57228242aa 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -419,6 +419,11 @@ vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
 vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
 vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
 vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
+vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
+vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
+vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index a2ab14ade0..354a802518 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1747,3 +1747,10 @@ GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
 GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
+
+/* Vector Single-Width Averaging Add and Subtract */
+GEN_OPIVV_TRANS(vaadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vasub_vv, opivv_check)
+GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
+GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
+GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ded3104337..8bb8fe159a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2497,3 +2497,103 @@ GEN_VEXT_VX_RM(vssub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_RM(vssub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_RM(vssub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_RM(vssub_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Averaging Add and Subtract */
+static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
+{
+    uint8_t d = extract64(v, shift, 1);
+    uint8_t d1;
+    uint64_t D1, D2;
+
+    if (shift == 0 || shift > 64) {
+        return 0;
+    }
+
+    d1 = extract64(v, shift - 1, 1);
+    D1 = extract64(v, 0, shift);
+    if (vxrm == 0) { /* round-to-nearest-up (add +0.5 LSB) */
+        return d1;
+    } else if (vxrm == 1) { /* round-to-nearest-even */
+        if (shift > 1) {
+            D2 = extract64(v, 0, shift - 1);
+            return d1 & ((D2 != 0) | d);
+        } else {
+            return d1 & d;
+        }
+    } else if (vxrm == 3) { /* round-to-odd (OR bits into LSB, aka "jam") */
+        return !d & (D1 != 0);
+    }
+    return 0; /* round-down (truncate) */
+}
+
+static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res >> 1) + round;
+}
+
+static inline int64_t aadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    int64_t res = a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+    int64_t over = (res ^ a) & (res ^ b) & INT64_MIN;
+
+    /* With signed overflow, bit 64 is inverse of bit 63. */
+    return ((res >> 1) ^ over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_h, OP_SSS_H, H2, H2, H2, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_w, OP_SSS_W, H4, H4, H4, aadd32)
+RVVCALL(OPIVV2_RM, vaadd_vv_d, OP_SSS_D, H8, H8, H8, aadd64)
+GEN_VEXT_VV_RM(vaadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vaadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vaadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vaadd_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vaadd_vx_b, OP_SSS_B, H1, H1, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_h, OP_SSS_H, H2, H2, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_w, OP_SSS_W, H4, H4, aadd32)
+RVVCALL(OPIVX2_RM, vaadd_vx_d, OP_SSS_D, H8, H8, aadd64)
+GEN_VEXT_VX_RM(vaadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vaadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vaadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vaadd_vx_d, 8, 8, clearq)
+
+static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res >> 1) + round;
+}
+
+static inline int64_t asub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+    int64_t over = (res ^ a) & (a ^ b) & INT64_MIN;
+
+    /* With signed overflow, bit 64 is inverse of bit 63. */
+    return ((res >> 1) ^ over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vasub_vv_b, OP_SSS_B, H1, H1, H1, asub32)
+RVVCALL(OPIVV2_RM, vasub_vv_h, OP_SSS_H, H2, H2, H2, asub32)
+RVVCALL(OPIVV2_RM, vasub_vv_w, OP_SSS_W, H4, H4, H4, asub32)
+RVVCALL(OPIVV2_RM, vasub_vv_d, OP_SSS_D, H8, H8, H8, asub64)
+GEN_VEXT_VV_RM(vasub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vasub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vasub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vasub_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vasub_vx_b, OP_SSS_B, H1, H1, asub32)
+RVVCALL(OPIVX2_RM, vasub_vx_h, OP_SSS_H, H2, H2, asub32)
+RVVCALL(OPIVX2_RM, vasub_vx_w, OP_SSS_W, H4, H4, asub32)
+RVVCALL(OPIVX2_RM, vasub_vx_d, OP_SSS_D, H8, H8, asub64)
+GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)
-- 
2.27.0


