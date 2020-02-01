Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F2C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A96120663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gBcXI7N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A96120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhav-00067e-DQ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIj-0004Xh-42
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIg-0006nT-7H
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:10:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIf-0006KL-Tq; Fri, 31 Jan 2020 20:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519417; x=1612055417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xBgnkFUW0YkZMofPsLKnr8zpj0tzMXK4oTfv3kMsaGk=;
 b=gBcXI7N8yWItdG3HNxWSitc08m4WK01cHnVZ4NmBnT4JsIHbyHo+SP/X
 qyOBIV3tfpBzHOefu2rwHdSl/GjtV0Zm7DCl3LK9xRgRiv70Vrbb5ZrjN
 d4JnEZ8gKhrDWE7ow0MtFwyDNdpjHwQF4cX8dlqXOi9CTPncIkjwU7qG7
 ULKGEqnO60+nCJ9l2upN6TDPAkZ81ObxtRjHQzOUPcmEnlRfi2KpF2Ofw
 t4GkP6Fb3Thio3xZT+QU/n7tKficr/2wNI2Ius+OS2kxU6DExmkFzbnuF
 hGQCt8dXZrPAhfGpXI7PK2PybQmbaLyka6p/Cvh2iAuUBG4rKuKQulNQP w==;
IronPort-SDR: yTwDtJ2GCmeOHghD89QIICvbvao9LjBfTbHxITFFFKLMhdIwfeefVboFDerY/56lkWTILR0IZL
 DDHBYKmVkZmLWs4Anr/iBjRqlH5E5TtBxaSwUCnln4KIPdOkkIfDo7ukcv3Td2gLVjpiCooV6F
 +2+g7G+7NAcCIazJQQ2VyXjX5fAXut6et/YSIPJyb4XCQMxxwxxlg9WsrfaZgZIS1fmQpN/WFb
 85C1iMC0vJnXJXZ7ywlmdJORQY5CJQ/q10xUHLsE9WxMHqk6SRpcCED5AQ4qoIY+14ISEVIeYM
 GAQ=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872487"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:23 +0800
IronPort-SDR: nVUMd2iwZrcFG1Mss0OQwccr/1sHwGpfD6nm4ao24hKfM3vxXdBSUeNsUPw5SZH56smAH7urVR
 vUwv9Ygu0cs4DTm4Nks0dVzIFTzV7C2YSOj9+Gw4m0L5hLORXTrwdWOnfA4fHqLOgkcJW1k2XY
 5kVhcfJXxSRguavEkshNczu/qpwqkecAMjtSIdjt0MAaahYLd8NTdn3ScI0KPC8I4B+P9veRVQ
 tNF1WTwR5VG+Xrc2t0JNeGw4tr3f4qwXJAgpn8tfJtDxEBxTYvItgLOXG0agV6OQhoo/2QUA74
 C/nCn5/jc7MW3H8LW7rEbVj4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:32 -0800
IronPort-SDR: bv13Jda6InYd8lAhpCH3DKwvtQZwXOCA4wOn7jwq+y1ZbfCmAiC39vzsqM/mUkD7pSRNK9O+IK
 9EEDi4tj8dzLQAv7QIlN8VpZ+JOTbmxiwMFbjlO4vi2tao7oLlww1jMr++ucQYgmUsjzjmwzxU
 z89I4Ldq7W2dVwuOzKOt5VSqpnBh72AvSf2/uW9/uPwewP7CgOe7j6Rw2zMKxuMaPVjH2Vm12B
 KAAsF+Bmv6ZnD1ZUu9hQ7wQuMhUjC05pVFzAV1THf7tu2NmS3Ui0NJs6n9t/ZVfmCZaTFbw6Jb
 ReQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:09:23 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 27/35] target/riscv: Mark both sstatus and msstatus_hs as
 dirty
Date: Fri, 31 Jan 2020 17:02:46 -0800
Message-Id: <5f3b8fd9e9743c13fd9e40bf811303bc2937667a.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark both sstatus and vsstatus as dirty (3).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index afa2d6eea2..61fe9f03be 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,6 +44,7 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     target_ulong priv_ver;
+    bool virt_enabled;
     uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t misa;
@@ -396,6 +397,12 @@ static void mark_fs_dirty(DisasContext *ctx)
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+
+    if (ctx->virt_enabled) {
+        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
+        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
+    }
     tcg_temp_free(tmp);
 }
 #else
@@ -740,6 +747,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
+#if !defined(CONFIG_USER_ONLY)
+    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+#else
+    ctx->virt_enabled = false;
+#endif
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
-- 
2.25.0


