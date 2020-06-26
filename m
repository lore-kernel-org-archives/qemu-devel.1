Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BA4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364282089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nZJzuaHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364282089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowS2-0001xr-Us
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIB-00033w-Es
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI7-00031I-Ah
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208429; x=1624744429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HbvJXye63TtI94nRo/126sg24u2sc9ZgmkLeLLN5Eds=;
 b=nZJzuaHNnVc05sgl4dnWlkv2FWniNQlBz4GHMX0a9Uofm8Qf+t31GwgP
 5gCRh1abTz5q/8BGGs4OWPt4zpvPWtGVjMWfC3rZbROnxY1bYqjNSxfSl
 iY1RUQ34wPQuZAKc6TpgzQgHVhUGy3iYdzoPHOM7rrQvTLuOXZITo3lDj
 cppbJbB3RrYVCIX9On7w5PVWKplg5wlzIRWY2N5yB0x6Xc/+7bdxP8Dxd
 WIAAIJ1C80iu6JavJ5S48HMPkrWSX+Kmk0mkVVA+H/bbtFI8lH/9MZQGg
 lx/MorEgnYDikncU2AF4MMx8oilEZnTYlfRFdSr/laUFbiTWJcYUYgUkc w==;
IronPort-SDR: QEyAMKKiKMvZPZT5sO+xzh/3eQhX5XoUMLDW9Ie+DYrb8fNDkmu4QBucfTRvi4IwNjBQjBfaQN
 2z2JZznzP6AAlUp6TE/rfJCGCL2K9+COF3Pq9NiRz6RTGxSGy4FnM7zPpFx5Mm9pvi3pKye9Gi
 pL4mtwqARGg6ZYCNc0wiU8J1xaI2Mt6wcpx5WzH2o0GY5m2R3Sglk33yngOMQECiEzPA6VZqlX
 WYVD7Hae02I12FTwc99RYcDolKL9idESMBXP1o3wPBvvLJM5wXyyuGSN0TShD3PTm+3duATETJ
 rMg=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048390"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:46 +0800
IronPort-SDR: N0JwICPavBqIWm91O9J8ppXd1sLD84ddjJ6OkB7N6nWgJeIlELFOujhLxJpQgoTQPN6YXWft04
 wupnzHC6hlxjPw7wmt/tpFxpMJUT2lvHU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:42 -0700
IronPort-SDR: +FVY3BkRf8Ihe7ZcEqKeHl0UnddVyyFl/kXTuO/sSiFf56QisPl0zWpsNFjOK/pYN7B/BKBdv5
 wyNunvUh3/2Q==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 35/63] target/riscv: vector widening floating-point multiply
Date: Fri, 26 Jun 2020 14:43:42 -0700
Message-Id: <20200626214410.3613258-36-alistair.francis@wdc.com>
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200623215920.2594-34-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  5 +++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
 target/riscv/vector_helper.c            | 22 ++++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 94305bd870..9d7dcfeef9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -852,3 +852,8 @@ DEF_HELPER_6(vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5db02f0c0a..dd9bca7eeb 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -463,6 +463,8 @@ vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
 vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
 vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
 vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
+vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
+vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index be9a9a8295..3ce7815f5d 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2057,3 +2057,7 @@ GEN_OPFVV_TRANS(vfdiv_vv, opfvv_check)
 GEN_OPFVF_TRANS(vfmul_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfdiv_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
+
+/* Vector Widening Floating-Point Multiply */
+GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8538a63419..6441d0ee08 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3410,3 +3410,25 @@ RVVCALL(OPFVF2, vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
 GEN_VEXT_VF(vfrdiv_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfrdiv_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfrdiv_vf_d, 8, 8, clearq)
+
+/* Vector Widening Floating-Point Multiply */
+static uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_mul(float16_to_float32(a, true, s),
+            float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s)
+{
+    return float64_mul(float32_to_float64(a, s),
+            float32_to_float64(b, s), s);
+
+}
+RVVCALL(OPFVV2, vfwmul_vv_h, WOP_UUU_H, H4, H2, H2, vfwmul16)
+RVVCALL(OPFVV2, vfwmul_vv_w, WOP_UUU_W, H8, H4, H4, vfwmul32)
+GEN_VEXT_VV_ENV(vfwmul_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwmul_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
+RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
+GEN_VEXT_VF(vfwmul_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwmul_vf_w, 4, 8, clearq)
-- 
2.27.0


