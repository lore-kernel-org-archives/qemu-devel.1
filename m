Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49994C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DC020720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H241r71B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DC020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2BE-00075v-AY
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29m-00044g-Mk
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29k-00008W-Fn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707628; x=1625243628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bjZLGb5Wy2W3v9bGS8MibIb3VbtDRB/zzCFNSU7IqEw=;
 b=H241r71BaO24dfFu49VDVZ/Van5yQvDMhdtA39XIUOmQYdgwCdpLpV5b
 tVQ6Vrvmtv3muFzDo/chF1qANaIRQ942r9NNcClFUZax3QIlOvJwksmki
 Y9lVH/cRBv5Au1gLT4D1UDAZkbRUBS69STOPaxxK1Ubx3byq8qmi2125d
 XgkhbamPdjnEHUlxdOEsb3gcpEfxXwMbNOvl0QlJgfkO9xyD/0/sSp3YG
 66XnXOqWKAdg0laVfe0Rlq5dQcPUmgPnf5xRUs1kEqgMPpa7Hpm99+eIY
 ZmlRFXITWe8CpaQUukLmaffJ7hdyKsri31iVVlwjvq0uF2nayWRfZM1RS g==;
IronPort-SDR: wq8p0FX3Q4zMAwuB7IJZY+H+u+XoGM8RowLmxBGrSNFB+4sVPPsbOTp16UaZfOAAAvpqYyeUvy
 vx+fcLBIuK3G/HYmJJ4AX7nhBfGGngBka29nGWBo3gQ1zZW6nlwysmTz7V2Feg27PtLIhTYxny
 Mp0P7JT+55ZA3sh964NxqM5RIzI4C7eKWl2P3fIzhxYLie8KIrkdgVlWOfPay0L1iElvmuu8ei
 9BxRFamU2GTi5vMS/6jfrxsJ7oY798W1F85dAHWLdxWnPxVnr5BpfG8EmuZqmjk1ANykaigGDC
 PsU=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498485"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:25 +0800
IronPort-SDR: OXE8C5/Nd2Fp4FY55I5SH3USCTiRJUhLeGUn7iTkR8oxD92noE0wF49OGQKCISoZ2fxQFOtWm6
 OkRjJJ4sFB2nINasgBNspFIrWXj6GB8UA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:40 -0700
IronPort-SDR: 0Mcx5BH4hhE6Xnq6TC+M26GWpYx+SYbiV4mERx1FeF/Rp+fhwujKiGx0oGxGISRWWPFiGq54I+
 XxTi7qVRUzsQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 22/64] target/riscv: vector integer divide instructions
Date: Thu,  2 Jul 2020 09:23:12 -0700
Message-Id: <20200702162354.928528-23-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-20-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 33 +++++++++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
 target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c2de0d29ba..e14979e452 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -568,3 +568,36 @@ DEF_HELPER_6(vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vdivu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6b29aad4d2..cf58764308 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -373,6 +373,14 @@ vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
 vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
 vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
 vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
+vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
+vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
+vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
+vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
+vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
+vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
+vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
+vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b5ea1c59a1..f3a8baf581 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1581,3 +1581,13 @@ GEN_OPIVX_GVEC_TRANS(vmul_vx,  muls)
 GEN_OPIVX_TRANS(vmulh_vx, opivx_check)
 GEN_OPIVX_TRANS(vmulhu_vx, opivx_check)
 GEN_OPIVX_TRANS(vmulhsu_vx, opivx_check)
+
+/* Vector Integer Divide Instructions */
+GEN_OPIVV_TRANS(vdivu_vv, opivv_check)
+GEN_OPIVV_TRANS(vdiv_vv, opivv_check)
+GEN_OPIVV_TRANS(vremu_vv, opivv_check)
+GEN_OPIVV_TRANS(vrem_vv, opivv_check)
+GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
+GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
+GEN_OPIVX_TRANS(vremu_vx, opivx_check)
+GEN_OPIVX_TRANS(vrem_vx, opivx_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 77f0399ebe..1a90f6e967 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1766,3 +1766,77 @@ GEN_VEXT_VX(vmulhsu_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vmulhsu_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vmulhsu_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vmulhsu_vx_d, 8, 8, clearq)
+
+/* Vector Integer Divide Instructions */
+#define DO_DIVU(N, M) (unlikely(M == 0) ? (__typeof(N))(-1) : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? N : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? (__typeof(N))(-1) :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? N :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
+RVVCALL(OPIVV2, vdivu_vv_b, OP_UUU_B, H1, H1, H1, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_h, OP_UUU_H, H2, H2, H2, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_w, OP_UUU_W, H4, H4, H4, DO_DIVU)
+RVVCALL(OPIVV2, vdivu_vv_d, OP_UUU_D, H8, H8, H8, DO_DIVU)
+RVVCALL(OPIVV2, vdiv_vv_b, OP_SSS_B, H1, H1, H1, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_h, OP_SSS_H, H2, H2, H2, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_w, OP_SSS_W, H4, H4, H4, DO_DIV)
+RVVCALL(OPIVV2, vdiv_vv_d, OP_SSS_D, H8, H8, H8, DO_DIV)
+RVVCALL(OPIVV2, vremu_vv_b, OP_UUU_B, H1, H1, H1, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_h, OP_UUU_H, H2, H2, H2, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_w, OP_UUU_W, H4, H4, H4, DO_REMU)
+RVVCALL(OPIVV2, vremu_vv_d, OP_UUU_D, H8, H8, H8, DO_REMU)
+RVVCALL(OPIVV2, vrem_vv_b, OP_SSS_B, H1, H1, H1, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_h, OP_SSS_H, H2, H2, H2, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_w, OP_SSS_W, H4, H4, H4, DO_REM)
+RVVCALL(OPIVV2, vrem_vv_d, OP_SSS_D, H8, H8, H8, DO_REM)
+GEN_VEXT_VV(vdivu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdivu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdivu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdivu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vdiv_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdiv_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdiv_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdiv_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vremu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vremu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vremu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vremu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vrem_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vrem_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vrem_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vrem_vv_d, 8, 8, clearq)
+
+RVVCALL(OPIVX2, vdivu_vx_b, OP_UUU_B, H1, H1, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_h, OP_UUU_H, H2, H2, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_w, OP_UUU_W, H4, H4, DO_DIVU)
+RVVCALL(OPIVX2, vdivu_vx_d, OP_UUU_D, H8, H8, DO_DIVU)
+RVVCALL(OPIVX2, vdiv_vx_b, OP_SSS_B, H1, H1, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_h, OP_SSS_H, H2, H2, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_w, OP_SSS_W, H4, H4, DO_DIV)
+RVVCALL(OPIVX2, vdiv_vx_d, OP_SSS_D, H8, H8, DO_DIV)
+RVVCALL(OPIVX2, vremu_vx_b, OP_UUU_B, H1, H1, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_h, OP_UUU_H, H2, H2, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_w, OP_UUU_W, H4, H4, DO_REMU)
+RVVCALL(OPIVX2, vremu_vx_d, OP_UUU_D, H8, H8, DO_REMU)
+RVVCALL(OPIVX2, vrem_vx_b, OP_SSS_B, H1, H1, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_h, OP_SSS_H, H2, H2, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_w, OP_SSS_W, H4, H4, DO_REM)
+RVVCALL(OPIVX2, vrem_vx_d, OP_SSS_D, H8, H8, DO_REM)
+GEN_VEXT_VX(vdivu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdivu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdivu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdivu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vdiv_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdiv_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdiv_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdiv_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vremu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vremu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vremu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vremu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
-- 
2.27.0


