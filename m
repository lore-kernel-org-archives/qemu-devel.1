Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C0AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94158205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lK6TngkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94158205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNIS-0005qV-NH
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsu-00052u-AV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMss-0002VJ-OS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsr-0002KN-W9; Fri, 07 Jun 2019 17:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944730; x=1591480730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h4OgZoQXx6IFwm9jyDXJlm9YTYDfgQSDg3XxTJU9wNk=;
 b=lK6TngkN6SZwjm94h/dtfq75yfTqYi2fsTHHqYScJIgydyavIb8xLdhu
 aVVYbBrEhSZ3I19VUX6VBC3vgDkPaSkoELXLhAae+BrT5cZzqYCv6Kx0d
 Jx/AudBqDxs6b9/+1D2klFQaVG6cy7KJffTTd4lS4TMdn+rL2yooJ+Pgb
 xv5looXAaZZPk2MdqdqfuIqFR/yy5/1m8r5VNlKka+baMNJUwjiTHIIqU
 g7no2B54ZKvbZU3m5FqnViuP6KlCK9FuPvzcQRRwegGolE9k95G7FOgJh
 wD/7HYzNbATnuvhkmO064zW3zigfITT+icBB5N2Dz7+ap/BwszISy37rz A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059644"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:36 +0800
IronPort-SDR: H0t3a7X4OupLyZnnZ/4kO42uezdPlAzLuzewwLdXqcDbaV9Oriw6OaqnQrcU68Wl1/EzhV89oC
 9GRTyMqqZBY77daz17Vdot9qJU7PkiUp7wxVr7CxjiijTMBN/eCiGatrrPHNiM0qp667WyvAzh
 lZMKfzUTVtIZDMnssDba+8QhBVuq0+AX96FjfQWoH79FYl26QQSzgijP2tFc5Av28WXCMT/i8z
 91TakmTPpcOJ8/2sLBxarSwxwEQD4ZE0+s7IL2LbZ58VhoQUBGoynKghvuvDcYAatmLVyqe89A
 583NBeq14qcFmeN7SDTEFtnX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:28 -0700
IronPort-SDR: 9SYEs4p/zz5QVrwbIHVcJqXHHoHWhsr4sFfSo3K4irLN/RzzwLLI2tXyPk9GbjsQOepMtTLr5X
 GVLel5keEPUctnyFCU1hGZzQRObL9ZZz/G9ZdfFTCVDy+MFD9w+OvDOhdfoUFm96yONBLUOJmh
 X/sMzAM7t6f/kcDD1sWqUsXR5tL5DDQksfa0q23cBntcKovnoVj6UaR2GCfd2oAcKlNwIfmEXe
 eYQAZfU1UIKG2oH1Q+LpcLsWaycv6QS4w/fxfK3zuNbTgtyBgDWWa6N9M3eEsJ7Jfq37JogKCy
 kuE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:26 -0700
Message-Id: <6e4366911398500ebd5a6164d0415e26f6642d9d.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 21/27] target/riscv: Mark both sstatus and
 bsstatus as dirty
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark both sstatus and bsstatus as dirty (3).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 313c27b700..1c3cd1c94b 100644
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
@@ -397,6 +398,12 @@ static void mark_fs_dirty(DisasContext *ctx)
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+
+    if (ctx->virt_enabled) {
+        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, bsstatus));
+        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, bsstatus));
+    }
     tcg_temp_free(tmp);
 }
 #else
@@ -757,6 +764,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
 }
-- 
2.21.0


