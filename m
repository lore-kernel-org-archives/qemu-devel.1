Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9780EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6553D20B80
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ImWicszj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6553D20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowXz-0004zB-Lu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIR-0003Db-KM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIP-0002yn-0f
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208446; x=1624744446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YmShn/Y/XF+QnKhRavjsQg5Ck4b0ia9ae9YGeYVbz0Y=;
 b=ImWicszjCuUH7xloCtDrd8UR7xfUkQ+bPEypqU4qnFEbQLI9zWPoy4A1
 GoaW84fqWpSvYu8udGJrfEC1blRjYVOt3k+h6+dlNkiHY+nRgQnroZizy
 QcgSNjxk1nwiSqxakFmx8KwymFg+xBuToM6qMe+dJvUIPCRiRwDx42GzS
 mcnsva5LQzpBE9nh4otxI2iHo0WpAErhxV3C6/eURcXAlXR9izOTHPK5d
 ZnYxCbWehlhoiwJef4eWf2VNstG5cPIW5rLtUhMYSQO4alIVbiFEhJ5HD
 o/B3MFowqXwTzNxMU/p+dZZCUJz5dfKRuquhmNKfQNqKn7Yolg2eqoG6G g==;
IronPort-SDR: C9V2Dr3KVtHrMxBkf1RGJoy2dm/8o/pl6xlAMAoAWiNpOtmV2oM+TdSP2Qn7CIZNbMThSX8WnJ
 kfm3rvjsL2ecYjYMrRjEw3S8Eb79mOQ7d6Fw+cG9IISsVuByhAI794DFQkpRd6tn5I4jMZM4gM
 1X2Ao41cwIRJUh+7d+yUy/zQ6JbFjh1tW2JYMPc3690UGYiSpGUL1mIkAwJT13d2P8nulhXEeK
 y29CwP6nrWQpz23bJD41mMZ3KdWAEQWGVmtAVHTe+XVhruPq8YxuGPYU2wwFd8V2k9Jgrx0nOp
 svU=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360039"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:43 +0800
IronPort-SDR: hwxxc7wFVkixMSaf1fMxZywSHO+s/UfKyJ1Hr/DlWspeHTzA1fDelYa4kOnyVmAYorzrNhIIKq
 9wC0aHrUT3ea8o4P1laFadgFGsh0gvCno=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:40 -0700
IronPort-SDR: +aWKe9SZfW8MhTnEHZPIuGzUH6Q7QMtDkhc5HRLYuwS+DTj5w7khbdMnZSsh99x/pDhdy6cu70
 1zFR/VcwgnXg==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 28/63] target/riscv: vector single-width fractional multiply
 with rounding and saturation
Date: Fri, 26 Jun 2020 14:43:35 -0700
Message-Id: <20200626214410.3613258-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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
Message-id: 20200623215920.2594-27-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |   9 ++
 target/riscv/insn32.decode              |   2 +
 target/riscv/insn_trans/trans_rvv.inc.c |   4 +
 target/riscv/vector_helper.c            | 107 ++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index db9e2024ae..b2fc71c2ea 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -742,3 +742,12 @@ DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vsmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 57228242aa..1dfc5f7ca0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -424,6 +424,8 @@ vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
 vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
 vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
 vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
+vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
+vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 354a802518..8e85a2aed3 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1754,3 +1754,7 @@ GEN_OPIVV_TRANS(vasub_vv, opivv_check)
 GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
 GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
+GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8bb8fe159a..bfd2312b61 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2597,3 +2597,110 @@ GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
 GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
 GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
 GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
+static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
+{
+    uint8_t round;
+    int16_t res;
+
+    res = (int16_t)a * (int16_t)b;
+    round = get_round(vxrm, res, 7);
+    res   = (res >> 7) + round;
+
+    if (res > INT8_MAX) {
+        env->vxsat = 0x1;
+        return INT8_MAX;
+    } else if (res < INT8_MIN) {
+        env->vxsat = 0x1;
+        return INT8_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
+{
+    uint8_t round;
+    int32_t res;
+
+    res = (int32_t)a * (int32_t)b;
+    round = get_round(vxrm, res, 15);
+    res   = (res >> 15) + round;
+
+    if (res > INT16_MAX) {
+        env->vxsat = 0x1;
+        return INT16_MAX;
+    } else if (res < INT16_MIN) {
+        env->vxsat = 0x1;
+        return INT16_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    uint8_t round;
+    int64_t res;
+
+    res = (int64_t)a * (int64_t)b;
+    round = get_round(vxrm, res, 31);
+    res   = (res >> 31) + round;
+
+    if (res > INT32_MAX) {
+        env->vxsat = 0x1;
+        return INT32_MAX;
+    } else if (res < INT32_MIN) {
+        env->vxsat = 0x1;
+        return INT32_MIN;
+    } else {
+        return res;
+    }
+}
+
+static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
+{
+    uint8_t round;
+    uint64_t hi_64, lo_64;
+    int64_t res;
+
+    if (a == INT64_MIN && b == INT64_MIN) {
+        env->vxsat = 1;
+        return INT64_MAX;
+    }
+
+    muls64(&lo_64, &hi_64, a, b);
+    round = get_round(vxrm, lo_64, 63);
+    /*
+     * Cannot overflow, as there are always
+     * 2 sign bits after multiply.
+     */
+    res = (hi_64 << 1) | (lo_64 >> 63);
+    if (round) {
+        if (res == INT64_MAX) {
+            env->vxsat = 1;
+        } else {
+            res += 1;
+        }
+    }
+    return res;
+}
+
+RVVCALL(OPIVV2_RM, vsmul_vv_b, OP_SSS_B, H1, H1, H1, vsmul8)
+RVVCALL(OPIVV2_RM, vsmul_vv_h, OP_SSS_H, H2, H2, H2, vsmul16)
+RVVCALL(OPIVV2_RM, vsmul_vv_w, OP_SSS_W, H4, H4, H4, vsmul32)
+RVVCALL(OPIVV2_RM, vsmul_vv_d, OP_SSS_D, H8, H8, H8, vsmul64)
+GEN_VEXT_VV_RM(vsmul_vv_b, 1, 1, clearb)
+GEN_VEXT_VV_RM(vsmul_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_RM(vsmul_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_RM(vsmul_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2_RM, vsmul_vx_b, OP_SSS_B, H1, H1, vsmul8)
+RVVCALL(OPIVX2_RM, vsmul_vx_h, OP_SSS_H, H2, H2, vsmul16)
+RVVCALL(OPIVX2_RM, vsmul_vx_w, OP_SSS_W, H4, H4, vsmul32)
+RVVCALL(OPIVX2_RM, vsmul_vx_d, OP_SSS_D, H8, H8, vsmul64)
+GEN_VEXT_VX_RM(vsmul_vx_b, 1, 1, clearb)
+GEN_VEXT_VX_RM(vsmul_vx_h, 2, 2, clearh)
+GEN_VEXT_VX_RM(vsmul_vx_w, 4, 4, clearl)
+GEN_VEXT_VX_RM(vsmul_vx_d, 8, 8, clearq)
-- 
2.27.0


