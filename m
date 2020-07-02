Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F8A2088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YtD5KNqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F8A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2X1-00006y-Vw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AW-00060I-95
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AU-0000Ah-2K
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707674; x=1625243674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hgZAUBbvJguy0AvKs1vKgsw7LE0qRYkkDHQpbaeklqE=;
 b=YtD5KNqMr50e6rJYOcEnbVBNSnM71362Do8h+Rlch3z2FrKEjPQJBe6/
 ccIM6rJLKEdpeKhsW2DXxmESFPVndWyn9ndgLBX8JXdpohd00mVxDvVQy
 d6n3NQQqZFHyv2yi5vtdpqAqdWZKjyjJF4hxQQ7ItkzTnyNUH+XtVelFv
 HIzwLcxT7GRSlebmtqH9N/EjsprlVHwn08vasT/oyNoJaxkC1A9+PdJR6
 9c1aE3XVfE3Fo52BAAl8juEJOJd+mmak9Xnz7Y/C0uROUQgfWwhdx0tGn
 oaJCGrD04QGOwZdcjysNdqBxlWYwY8hM1HMgG8oDpWzWFcigFdAUAXfoK A==;
IronPort-SDR: Qg94leNeA9GXsjiA/FL8IwZnBooFRW1lOaOMB8QkvhTJ3qk2mRwVs6SQ1Tr1M5sNIw8H8vELuF
 0oP+awMWUt27i7qgkmJxT9IAR6aoE3FWpQLozwcznQ1VGoK1wvM32l/H9mp+qiqC+q33TFgIj+
 rBVsbRitcFgUJ7k+APQTuwUEscnL3LnfSd4UpPFMf4T6GRKjLbO68PM8qPYEQ1Q16BQjb+Kl1l
 cgNpR/qN4taJXVP2CTAi8iMWxh/SDzVhzK0wFAHXdW/QfCV/sT2qAE+Ysl9s1nuDe3RtcGaW9l
 WkE=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498524"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:31 +0800
IronPort-SDR: kRT0dyJkB38efVUbQE002P1Pl2uweAuI7xaMjkqXawoJcVtxPH8kD+R4WkQ4f+nqQNQqUnfN/M
 8t3nRzGQzoYxfYFWwqCUqy4xnjZmYwQ+E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:46 -0700
IronPort-SDR: +uwALKQrOF5oCpUDyt7BvWQxn92FPG6A2y+A3ogOe2v8uCYgKuQBgnzHI0fgdz9UpOQ/mttMKR
 vZDKWuYZwmwQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 41/64] target/riscv: vector floating-point sign-injection
 instructions
Date: Thu,  2 Jul 2020 09:23:31 -0700
Message-Id: <20200702162354.928528-42-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-39-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 19 ++++++
 target/riscv/insn32.decode              |  6 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  8 +++
 target/riscv/vector_helper.c            | 85 +++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a080f8358a..eea4c59820 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -940,3 +940,22 @@ DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfsgnj_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnj_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 854ff9a38f..0e173e9b71 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -496,6 +496,12 @@ vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
 vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
 vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
 vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnj_vv       001000 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnj_vf       001000 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
+vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
+vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b40e8eec53..460d9bce8c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2138,3 +2138,11 @@ GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
 GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
 GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
+
+/* Vector Floating-Point Sign-Injection Instructions */
+GEN_OPFVV_TRANS(vfsgnj_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfsgnjn_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6779e4b976..7f1b7a8614 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3844,3 +3844,88 @@ RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
 GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
+
+/* Vector Floating-Point Sign-Injection Instructions */
+static uint16_t fsgnj16(uint16_t a, uint16_t b, float_status *s)
+{
+    return deposit64(b, 0, 15, a);
+}
+
+static uint32_t fsgnj32(uint32_t a, uint32_t b, float_status *s)
+{
+    return deposit64(b, 0, 31, a);
+}
+
+static uint64_t fsgnj64(uint64_t a, uint64_t b, float_status *s)
+{
+    return deposit64(b, 0, 63, a);
+}
+
+RVVCALL(OPFVV2, vfsgnj_vv_h, OP_UUU_H, H2, H2, H2, fsgnj16)
+RVVCALL(OPFVV2, vfsgnj_vv_w, OP_UUU_W, H4, H4, H4, fsgnj32)
+RVVCALL(OPFVV2, vfsgnj_vv_d, OP_UUU_D, H8, H8, H8, fsgnj64)
+GEN_VEXT_VV_ENV(vfsgnj_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsgnj_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsgnj_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsgnj_vf_h, OP_UUU_H, H2, H2, fsgnj16)
+RVVCALL(OPFVF2, vfsgnj_vf_w, OP_UUU_W, H4, H4, fsgnj32)
+RVVCALL(OPFVF2, vfsgnj_vf_d, OP_UUU_D, H8, H8, fsgnj64)
+GEN_VEXT_VF(vfsgnj_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsgnj_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsgnj_vf_d, 8, 8, clearq)
+
+static uint16_t fsgnjn16(uint16_t a, uint16_t b, float_status *s)
+{
+    return deposit64(~b, 0, 15, a);
+}
+
+static uint32_t fsgnjn32(uint32_t a, uint32_t b, float_status *s)
+{
+    return deposit64(~b, 0, 31, a);
+}
+
+static uint64_t fsgnjn64(uint64_t a, uint64_t b, float_status *s)
+{
+    return deposit64(~b, 0, 63, a);
+}
+
+RVVCALL(OPFVV2, vfsgnjn_vv_h, OP_UUU_H, H2, H2, H2, fsgnjn16)
+RVVCALL(OPFVV2, vfsgnjn_vv_w, OP_UUU_W, H4, H4, H4, fsgnjn32)
+RVVCALL(OPFVV2, vfsgnjn_vv_d, OP_UUU_D, H8, H8, H8, fsgnjn64)
+GEN_VEXT_VV_ENV(vfsgnjn_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsgnjn_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsgnjn_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsgnjn_vf_h, OP_UUU_H, H2, H2, fsgnjn16)
+RVVCALL(OPFVF2, vfsgnjn_vf_w, OP_UUU_W, H4, H4, fsgnjn32)
+RVVCALL(OPFVF2, vfsgnjn_vf_d, OP_UUU_D, H8, H8, fsgnjn64)
+GEN_VEXT_VF(vfsgnjn_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsgnjn_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsgnjn_vf_d, 8, 8, clearq)
+
+static uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s)
+{
+    return deposit64(b ^ a, 0, 15, a);
+}
+
+static uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s)
+{
+    return deposit64(b ^ a, 0, 31, a);
+}
+
+static uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s)
+{
+    return deposit64(b ^ a, 0, 63, a);
+}
+
+RVVCALL(OPFVV2, vfsgnjx_vv_h, OP_UUU_H, H2, H2, H2, fsgnjx16)
+RVVCALL(OPFVV2, vfsgnjx_vv_w, OP_UUU_W, H4, H4, H4, fsgnjx32)
+RVVCALL(OPFVV2, vfsgnjx_vv_d, OP_UUU_D, H8, H8, H8, fsgnjx64)
+GEN_VEXT_VV_ENV(vfsgnjx_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfsgnjx_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfsgnjx_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfsgnjx_vf_h, OP_UUU_H, H2, H2, fsgnjx16)
+RVVCALL(OPFVF2, vfsgnjx_vf_w, OP_UUU_W, H4, H4, fsgnjx32)
+RVVCALL(OPFVF2, vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
+GEN_VEXT_VF(vfsgnjx_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
-- 
2.27.0


