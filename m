Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D08C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B068205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k5wwnN+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B068205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNwx-00050y-1R
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbH-0007yp-9Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbF-0007iw-NB
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbE-0007hV-G3; Mon, 09 Dec 2019 13:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915479; x=1607451479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TJrzXhEpGgeMn97XoCLQX/Tta/uWmiHnLdAfNNidqPw=;
 b=k5wwnN+mOcuNkBeCo8d6f5QRJO6OlGSWUnJC8HXZGaKtO448av6cBx5/
 orf3YMdYxLJ+Lla03TLl9wRFQj7BagZvvBpN5IC6Bga0Xn97LZeftzfrW
 zEj0JRulXF3HB+SKklYEL1zzEpPuogKAve/nX7K7CTc5mMLyImqtjTVKO
 I3coLntpp0hv6eysjDwwWOuzWhf0hkXTkBKXqg1Koi9AbkER3gLcUq1Te
 f6Ek6WvoijitJZdKYsPgU91AKQKC48oRA0wQA2vM6n/72crN7LKa8wSJW
 pa13KlKi9jFbkxblcSpEgba0Ersr61UrCkB44LD21pjithjVvZRX9YJit g==;
IronPort-SDR: HGLNEUl1BSR49IUg1WecoWJ2Uyo9ej/Lf5Ml62fSZps2Hqf5lNxujbibIVCY9ZyD8CcycmirBN
 pfjLEJLjjgKZmrHZyRzHXuopZXRNF6LOuXNp6B3UsXLpoc+CFnEPmw+t2/MlcLwORgBlhx0rYG
 TkiICsekeSfIrMv+vNhJkUuNmy/joth8HJibQTxMna57czEASksNYnoy7en/b3EefCsdaA4O95
 wSQx1cKaWISidpQZhtbmSpYXPehJ2eNkbKnL5w4L/1SrCqDgChyyBqWRbhoUvkyNsihQuGXjso
 vpA=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412022"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:58 +0800
IronPort-SDR: ieR5GVHL3pKabVGNxHiW6PFxIev/H1C8zLNMnmk8tlRGItnC/F6q0jI4OqYXJxEelgmiMOoMRx
 Nr3hA9QezaDbKiR7lPUze9hoO8+871fb/egTC1yGDJVIwnrY5draYzrVYuXc93TqZHVkFi+9Rx
 EgHxFTj3cVY69ydND2BFnevNzOntanuLfKoYNIdIIxYmTWhH7LSvNfi/e+5F5Qp3duIbYIN4X0
 wdpfCZRc/TDboRdCKmwYt4tflfNpir4UwgkA4F3v9P0qlH5UghtMrRTG8TPD+gjMqM4BhlXWei
 A8W5eE8REzhnL/r6FrLvyRBi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:13 -0800
IronPort-SDR: 58zIKY9dZyaAVbskqjIn3JB0XUuId1yjuGH7JXPlcMSismj7tCNi2KPIVSkMJu5fzlucOK/dt2
 +h7nY0mG4C5ZcnaeF0p32HuGpMIY3XuAIgVVStLXeq0ZHGnVVEw/2z1/VtYEE0dxU1x3s92Aiy
 Fqmzs9KKWc8IuCb9J4l7wqp2LR9axTC+Ntlzo6JkxHMthvSJo7ivsWF4/v6HE3sbPxt4F61tN4
 0xudg4jbNv8ndDowlvue5EeK+VApMw87QjJrFj0P++Tkxc+suVf8atkhEG3IydorJopu4/GKwL
 Ow0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:35 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 28/36] target/riscv: Mark both sstatus and vsstatus as dirty
Date: Mon,  9 Dec 2019 10:11:53 -0800
Message-Id: <f53fa802d9bde05181749ee8480be88a736eb4b1.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1a379bd2ae..1d879b34db 100644
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
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+
+    if (ctx->virt_enabled) {
+        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, vsstatus));
+        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, vsstatus));
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
2.24.0


