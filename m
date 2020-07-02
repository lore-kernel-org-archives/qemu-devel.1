Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F26C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4933D2088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kjYvb9eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4933D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Tt-0003FD-II
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AR-0005oG-UZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AP-0000Az-V0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707669; x=1625243669;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Z5i5ffFR3uj5Cyl6qFS/UdVL1wK5Cru6gO78Y8SYa8=;
 b=kjYvb9eFPkwue5j01IP69UcIBReLAtCxzwdbe0uQrzbPQxMPImMObugh
 B1zHFJnUDLo+19YJUWW9a0/0t/t42s7mBebpmtRsE9wRSPaICJTjsEvkz
 idZnRiQklNYOz7nRUBoa+cmSirqvocO7+6Qwire5G61QQHaEUCIFvxPTk
 Z8JtCdcVDBKto0r2DeTMhWkk3AmzvxNH83Tchxmh7cSAj4cv3cpEb899j
 0D0egVHt/iabwPj/hpCnSV8GdeIlcGWV6fUuz6jA9j5roqfyyErqdreHR
 5wEwgrc6QIFSma/9BzM4LNPCkc/1AZuMPphlBpFL4vVvQyuYCimPDqgrT A==;
IronPort-SDR: ldwgBnNOt5MhxbUE0oTUDbKzSx+sVuwCXrYs73cnpICjJQX8laLmhAgB7VvrrRUo/7tlHr5BuY
 m3Np5olLCn2QbwTTfa+aSAgqbqEf8XssYlSANH/oSDdMGh/c6Nn9MBwjsj2ocMrP+I5eT0iqN7
 T4MlpHPTVqPQt6yD7hsclsDBSEbxGmF1pCrHsO0dwgy7RCa5ZzzC41Ggls5kvb7vD7PpPsgbJo
 8iZJCD97oGJ7hqzhH3Ci2IMxLwYFNQiBmE9/5C272D+jdg+Hfpjv4LzPY8Vni0t2QNEHXjnFmC
 4dg=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498513"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:29 +0800
IronPort-SDR: L57GsmhFW4f+ZAY2HdRpQ1yRtjWliJQv5xKiZuYt4Piu3iPSRwEqsCzYlP87WO9qaBDPubSjZn
 D+cMh82YGVKFG1KquZQpw/5aNNQLUAU4Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:44 -0700
IronPort-SDR: jyf8ZR8dRgqoZTLJTo08diIw5ACrCtGmpAH5d5AGgfhPAGj8Au4WX/rfJrqpBSBLjNEhHR7KZz
 CQDeUdul4Nvg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 36/64] target/riscv: vector widening floating-point multiply
Date: Thu,  2 Jul 2020 09:23:26 -0700
Message-Id: <20200702162354.928528-37-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-34-zhiwei_liu@c-sky.com>
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
index e0da273849..dbdfeacf25 100644
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


