Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3825520760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FB3IhCTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3825520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2iQ-0001B3-Hk
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2An-0006jl-9v
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Al-00008W-A7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707691; x=1625243691;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=001vdMcQ+PNzQ7pj2gtHV0C3fLJ4dE5a4mTIxOQVY4Y=;
 b=FB3IhCTPF/36OEuzKfXtZo3LrP170yK1Op4zZOKPjmJ1+fK2U/uQkH7P
 ZK74hhmR1XSQGabLIR6DWISoYL+CDQkTWWeGqrDyaj1fzUGb2t6/zq0s3
 fsLQ7ZFe6qVuKnoMvLnXW3e8SPMQl5yK5bPi1uBIZ+FfJeJbR8AsDmZQq
 ELz3rIzryr3+vh/8/7L8xNa9r0s5caeNMpiDBAgZ3CDM9KRhV6ZLS4iwb
 zjhYYKm1RxuwrAferKqzzDAqBXfbw2ILwadRyWlfcqyJu+2Z235eo+D9x
 kEUjDqnkA9A5vm7vRPMAvpyWSYHEgGxrfFDhyqsRAF+adgnR4HJtNxhVw A==;
IronPort-SDR: mMRtKPe/dyevYb2JZBjVo9NFmI7O6D4Af7aOlyKC9vt8vq/gK4JayqIHnuj+PL3u9uGlwLvQuq
 CpinMEtOAJpEa2vj3tAtQrvl3tchCwcgB8O7FnYpiogPh4SsN38rimiIvhczDCIzj2tJyxX4yO
 KbvZ7YHuEQz42Taf028pH24+dbmn6AMkZUunQfazhHpKoXI2CjBJUI7KWEim+v1cS+SkGbc64p
 +khntzYJvIPFwQP7ZB4nS3GtYXPMUH0la3l3hRmphPlibkGN4A2P7n2tlbXAcNceooMCcj8NHh
 kPs=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498543"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:33 +0800
IronPort-SDR: 9Ka6vaS0iT6S70H05FDkar1aOJqDAz234SUekPVb3WObsKdO3QfQsBaEchmkWdfvxyJJwHYUqr
 vN0ZwsSKL7DWIgy+wdNFlLsDqxCyhVi7c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:48 -0700
IronPort-SDR: 7dTjChmEe9Vz2ZfNY/e2wr8/Pd0AkwOtYGL60cBC9UArgRDTmpnDmFbtiCF6dneePFpJXMBHP/
 ivJfv/zbUdcA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 49/64] target/riscv: vector wideing integer reduction
 instructions
Date: Thu,  2 Jul 2020 09:23:39 -0700
Message-Id: <20200702162354.928528-50-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-47-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  7 +++++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
 target/riscv/vector_helper.c            | 11 +++++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a7fe4443e4..1c1277c0d1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1072,3 +1072,10 @@ DEF_HELPER_6(vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vwredsumu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsumu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 878eeecb7e..b78fd8bc04 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -539,6 +539,8 @@ vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
 vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
 vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
 vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
+vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
+vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b4e3f904d3..91fc1fd059 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2342,3 +2342,7 @@ GEN_OPIVV_TRANS(vredmin_vs, reduction_check)
 GEN_OPIVV_TRANS(vredand_vs, reduction_check)
 GEN_OPIVV_TRANS(vredor_vs, reduction_check)
 GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
+
+/* Vector Widening Integer Reduction Instructions */
+GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
+GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 41564b3237..72b812c743 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4406,3 +4406,14 @@ GEN_VEXT_RED(vredxor_vs_b, int8_t, int8_t, H1, H1, DO_XOR, clearb)
 GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR, clearh)
 GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR, clearl)
 GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR, clearq)
+
+/* Vector Widening Integer Reduction Instructions */
+/* signed sum reduction into double-width accumulator */
+GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t, H2, H1, DO_ADD, clearh)
+GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD, clearl)
+GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
+
+/* Unsigned sum reduction into double-width accumulator */
+GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
+GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
+GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
-- 
2.27.0


