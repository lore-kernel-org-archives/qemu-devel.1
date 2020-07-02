Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD0820720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JBaprHmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD0820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2On-00014L-5R
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AU-0005w1-Kx
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2AS-0000BG-2o
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707672; x=1625243672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iCXKYe+02PI2Jfr0PzZ+47PwSmTC2Z75/vEoxFPWmfI=;
 b=JBaprHmUPPYrm/n23KzwXJULmCf4zNgwzpKUswsUO+T7U5auHpZF6sIk
 7FSHUnNO5r9ljUvkJW7eDOoHcgyGItDr4eN/TWuwUFBPG1QTHKNBwBTGZ
 ufbwEtKnNcO36iRhcUEDcodO0QLj0pysAcM9oxWG3WIbeqH7HeiTEUOHT
 xN+P0BdlPznzxaliLth1hInZ+zysg2j1WDLopXSH720pOM4Iu4iv4nu6k
 uCK9Hh95PeQ0bdYXb8QjbhIFfEVC8lx2Fh1Fvew+HpeBqCxWTda4Qd/QQ
 KknP1uY4J7IBzZ4uJuYefIh7RUdVk0x80+75BGLD7sDY1oYwyMzKdXZ6t Q==;
IronPort-SDR: Xw1VfuRRblYHbxBIU7BJHSnTy7UBkbHD0NL+pybM5f8pIlVewUqe8fHgCzeUdELu2xhnh4wdRY
 LZie6Xq6B7gzALov7rjfkJHlDIa+8C0bq2JRWuYkxN3kiwSWw5UCurye0Db2jsQNNXuGjubwvX
 Es8pJAzdI28omtgqoIBKqnEsN/AfwOYZKMimydnfzvEY/nc2oldCM88lRj5avIgRllIzfHCZTt
 4P7tPTQNdkmPUKhEt+KYFxPMiqMkyXEoi480rG69Wv+3JNTUw2actGFkVr3l5BhgX1V+q+3pBX
 p8I=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498522"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:30 +0800
IronPort-SDR: LsJmIKA0yba6hYUE55Z/DQtRkSSUe7oW3s7cKwBb/IcB/+4ufrKEHSFczK2KvrMTt0yfxxRkfi
 I9xMnSbumgo/jwN7TxgNvu7hgEYyDz6co=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:45 -0700
IronPort-SDR: v9fe8mHuYVOxMUFJW0+rEVof5qApJYJ0kLJhiWqIluiUJhLfkUWNQ2p2RfM+ewJVIwtkKLQVFv
 ykYynavDuqXQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 40/64] target/riscv: vector floating-point min/max
 instructions
Date: Thu,  2 Jul 2020 09:23:30 -0700
Message-Id: <20200702162354.928528-41-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-38-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 13 ++++++++++++
 target/riscv/insn32.decode              |  4 ++++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 ++++++
 target/riscv/vector_helper.c            | 27 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8d44154ad2..a080f8358a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -927,3 +927,16 @@ DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0d58c4c5e8..854ff9a38f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -492,6 +492,10 @@ vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
 vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
 vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
+vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
+vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
+vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
+vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index e875c0e48a..b40e8eec53 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2132,3 +2132,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 }
 
 GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
+GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
+GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
+GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 40ea67d116..6779e4b976 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3817,3 +3817,30 @@ RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
 GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
+
+/* Vector Floating-Point MIN/MAX Instructions */
+RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
+RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
+RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
+GEN_VEXT_VV_ENV(vfmin_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmin_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmin_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
+RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
+RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
+GEN_VEXT_VF(vfmin_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmin_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmin_vf_d, 8, 8, clearq)
+
+RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
+RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
+GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
+GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
+GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
+RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
+RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
+GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
+GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
+GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
-- 
2.27.0


