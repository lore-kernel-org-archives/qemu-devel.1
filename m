Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6899C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B391E20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kcybet1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B391E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2hV-0008BH-1l
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ag-0006Qi-LL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ae-00009X-DB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707684; x=1625243684;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hI9c92WbeND+JccI0RJGBsOtSvKXMKiKL06qWmNRWAw=;
 b=Kcybet1R6AN3/hVFbGmEs8P2rVrz0Qxl+YVIEwn41iywAHUerqw5cdL2
 61x/QWl/8vwiYglNRoGnq7VSp6tMoTaQmqsxKq6F+FZqtKnqhF79qob2l
 rAhclthyRYo9meWzPmZYV6TQzeJshMMG09/fRhtSd6Rawk2aWL9IPBkT2
 cMlkwPa4Y2O7RgkjZrn6RZpHNZxuwLpukMwUCiJUnR4MM4HaeAq92JskD
 zCgLoAQT+U1oK6sTTLy7KT1jhiEfUgiVHf3MzHHYT9KgNQtyOzRz4CitW
 W+AiIYcUUGHWZ/1tWEH6zur8HVShrXdZQSKdoQsAESUVRQFtlq3rO4L/h A==;
IronPort-SDR: 7LVaw8ve+BOznSGNcIFIjZNtphkkUw/vjzz9mNCDkq/q232TPLNQMtgx1NKtL+r0M2cJZ9TWZA
 sIFn8R6zA0XwGLz5DfyjHKHYtXILND6jV368rP7DPro3nl16VTMJZpsd3ie5Smof9NVzm6rLY/
 6NM/nIzb5cZz/ebbsUZTkEIhodVjoJ/56bg/ys6mOCyIRe6fpcmsbdO38YPwbvtb/IVClR6UKn
 qdptIhuR2DkKC7mqqiywXanaMHp4YPwHUpwkRgQinZ/oUiMM/zs2kwFxwNytJKhSzLRHbvYWGY
 /u4=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498535"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:32 +0800
IronPort-SDR: 9vKkTSID9Gp35jKDcQrrRt5sbBwoU79sK3oVtsp/zU02/4KvXW7SCI6gvgc7f1EI8M9ZO+DQqc
 VQ6w0eS6IllBYuYiSaj+RqaApPmFRXNyc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:47 -0700
IronPort-SDR: vSNarqEqxrGGOcy0ORwa7TaugopOwXkSh9RJzVrdCz+Ut+VTafG+zRlMQHwWihglR5xWtVaieP
 qYD+6DLCJ0Xg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 45/64] target/riscv: vector floating-point/integer
 type-convert instructions
Date: Thu,  2 Jul 2020 09:23:35 -0700
Message-Id: <20200702162354.928528-46-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-43-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 13 ++++++++++
 target/riscv/insn32.decode              |  4 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 +++++
 target/riscv/vector_helper.c            | 33 +++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2c3f0a4e0c..d01e739607 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1004,3 +1004,16 @@ DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_xu_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 38e7445a16..913c3b099b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -517,6 +517,10 @@ vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
 vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
+vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
+vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
+vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
+vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b6872376ce..ed238edfa9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2222,3 +2222,9 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
     }
     return false;
 }
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1d5667f471..8da9ca18d3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4218,3 +4218,36 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
 GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
 GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+/* vfcvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+RVVCALL(OPFVV1, vfcvt_xu_f_v_h, OP_UU_H, H2, H2, float16_to_uint16)
+RVVCALL(OPFVV1, vfcvt_xu_f_v_w, OP_UU_W, H4, H4, float32_to_uint32)
+RVVCALL(OPFVV1, vfcvt_xu_f_v_d, OP_UU_D, H8, H8, float64_to_uint64)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_d, 8, 8, clearq)
+
+/* vfcvt.x.f.v vd, vs2, vm # Convert float to signed integer. */
+RVVCALL(OPFVV1, vfcvt_x_f_v_h, OP_UU_H, H2, H2, float16_to_int16)
+RVVCALL(OPFVV1, vfcvt_x_f_v_w, OP_UU_W, H4, H4, float32_to_int32)
+RVVCALL(OPFVV1, vfcvt_x_f_v_d, OP_UU_D, H8, H8, float64_to_int64)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_d, 8, 8, clearq)
+
+/* vfcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to float. */
+RVVCALL(OPFVV1, vfcvt_f_xu_v_h, OP_UU_H, H2, H2, uint16_to_float16)
+RVVCALL(OPFVV1, vfcvt_f_xu_v_w, OP_UU_W, H4, H4, uint32_to_float32)
+RVVCALL(OPFVV1, vfcvt_f_xu_v_d, OP_UU_D, H8, H8, uint64_to_float64)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_d, 8, 8, clearq)
+
+/* vfcvt.f.x.v vd, vs2, vm # Convert integer to float. */
+RVVCALL(OPFVV1, vfcvt_f_x_v_h, OP_UU_H, H2, H2, int16_to_float16)
+RVVCALL(OPFVV1, vfcvt_f_x_v_w, OP_UU_W, H4, H4, int32_to_float32)
+RVVCALL(OPFVV1, vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
-- 
2.27.0


