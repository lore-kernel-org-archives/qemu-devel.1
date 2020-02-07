Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D6C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A36C2465D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2WmCj33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A36C2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05JQ-0004G5-6U
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j058J-0000uF-Rj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j058I-000470-DI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:27 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j058I-00040s-50
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:26 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so2881177wmh.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U6Am3X6OQTZ1x+tf20LucVI7jeDaV7FG5H5GI7lV8EE=;
 b=w2WmCj33W1pPjplq1vkGvP4r1LLm/qIZk/PhWqJ2Ao2pD2xj1LPBVu1ZAdDEC0C5DY
 YSKINVK4XvBick/c6PVD+n0aS729CVzuF+EaMguiB3oV3SVr2cUsNBHsfKg4X3am0xWu
 0SNDwohlhnz72jbGkdz8/1TGMuO7NynmCQFEvjm/I/n9cMSybW/+ptVslwkXo86GEZJe
 mBv9yqp29GLdn4Da4ty9P3Ugw4R+2tFsADBU59s4WKiORfC1aaLw8jD/CHMOqR1VV+HL
 vZS3q1Dh5BtWtgB9SRwUs8SPiF/z2MhezuehcCB/sV3USuaqRSLTIMckwR86PqYuiouP
 Nd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U6Am3X6OQTZ1x+tf20LucVI7jeDaV7FG5H5GI7lV8EE=;
 b=VihXl8fffGRU1hx6+iybggOt6H8T81gVTt0FL4kNpXbhBcA1FKyd2+ZDqGzmQe81Mr
 m8+I4gHjnPS0mGCcSkm9xwknDhMui3dbknzpi3V0w9rpu8l4Bz5HWPcjxMm4Wx7IjUM1
 TqzlfQXqLJLkeFUYZMlL4MVUIqCPilzeiaxUL6MdCfXuTDQKFdSWY63cC4RPFjt3EDmI
 KKVMrknEwohqahHWBwuwWhUtQ6Viao3uCH2leqhg+S5VgGViiI6Qg+kpBefDs7FKSwWc
 Ot8IULb7NAOpKLJuwgzdGeA6jcYoFEKzvbebUTmxm1R5sDDOa29rKoeFFypKF7+HwygC
 eMpw==
X-Gm-Message-State: APjAAAWMINohVM4GMYO0zndUn3v+CQu5WAv+zA0mpgTVR88HzBUgrFS1
 8V21kiqbnCdbjUeJ2rKi7LE3yw==
X-Google-Smtp-Source: APXvYqxOMp8kveOFWUrZwYWQwbPSBkD6s7EKiNuV1LixsgOVeUhIHRE1vmd+9Be0JLtXQNSSaTScZw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr4652088wme.37.1581087685087;
 Fri, 07 Feb 2020 07:01:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d23sm3790469wra.30.2020.02.07.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:01:22 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4621E1FF91;
 Fri,  7 Feb 2020 15:01:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] target/riscv: progressively load the instruction
 during decode
Date: Fri,  7 Feb 2020 15:01:17 +0000
Message-Id: <20200207150118.23007-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207150118.23007-1-alex.bennee@linaro.org>
References: <20200207150118.23007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, robert.foley@linaro.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Palmer Dabbelt <palmer@dabbelt.com>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The plugin system would throw up a harmless warning when it detected
that a disassembly of an instruction didn't use all it's bytes. Fix
the riscv decoder to only load the instruction bytes it needs as it
needs them.

This drops opcode from the ctx in favour if passing the appropriately
sized opcode down a few levels of the decode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/translate.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 14dc71156be..99f2bcf177c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,7 +44,6 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     target_ulong priv_ver;
-    uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t misa;
     uint32_t mem_idx;
@@ -492,45 +491,45 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     tcg_temp_free_i32(t0);
 }
 
-static void decode_RV32_64C0(DisasContext *ctx)
+static void decode_RV32_64C0(DisasContext *ctx, uint16_t opcode)
 {
-    uint8_t funct3 = extract32(ctx->opcode, 13, 3);
-    uint8_t rd_rs2 = GET_C_RS2S(ctx->opcode);
-    uint8_t rs1s = GET_C_RS1S(ctx->opcode);
+    uint8_t funct3 = extract32(opcode, 13, 3);
+    uint8_t rd_rs2 = GET_C_RS2S(opcode);
+    uint8_t rs1s = GET_C_RS1S(opcode);
 
     switch (funct3) {
     case 3:
 #if defined(TARGET_RISCV64)
         /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
         gen_load_c(ctx, OPC_RISC_LD, rd_rs2, rs1s,
-                 GET_C_LD_IMM(ctx->opcode));
+                 GET_C_LD_IMM(opcode));
 #else
         /* C.FLW (RV32) -> flw rd', offset[6:2](rs1')*/
         gen_fp_load(ctx, OPC_RISC_FLW, rd_rs2, rs1s,
-                    GET_C_LW_IMM(ctx->opcode));
+                    GET_C_LW_IMM(opcode));
 #endif
         break;
     case 7:
 #if defined(TARGET_RISCV64)
         /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
         gen_store_c(ctx, OPC_RISC_SD, rs1s, rd_rs2,
-                  GET_C_LD_IMM(ctx->opcode));
+                  GET_C_LD_IMM(opcode));
 #else
         /* C.FSW (RV32) -> fsw rs2', offset[6:2](rs1')*/
         gen_fp_store(ctx, OPC_RISC_FSW, rs1s, rd_rs2,
-                     GET_C_LW_IMM(ctx->opcode));
+                     GET_C_LW_IMM(opcode));
 #endif
         break;
     }
 }
 
-static void decode_RV32_64C(DisasContext *ctx)
+static void decode_RV32_64C(DisasContext *ctx, uint16_t opcode)
 {
-    uint8_t op = extract32(ctx->opcode, 0, 2);
+    uint8_t op = extract32(opcode, 0, 2);
 
     switch (op) {
     case 0:
-        decode_RV32_64C0(ctx);
+        decode_RV32_64C0(ctx, opcode);
         break;
     }
 }
@@ -709,22 +708,24 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode_insn16.inc.c"
 
-static void decode_opc(DisasContext *ctx)
+static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
     /* check for compressed insn */
-    if (extract32(ctx->opcode, 0, 2) != 3) {
+    if (extract32(opcode, 0, 2) != 3) {
         if (!has_ext(ctx, RVC)) {
             gen_exception_illegal(ctx);
         } else {
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
-            if (!decode_insn16(ctx, ctx->opcode)) {
+            if (!decode_insn16(ctx, opcode)) {
                 /* fall back to old decoder */
-                decode_RV32_64C(ctx);
+                decode_RV32_64C(ctx, opcode);
             }
         }
     } else {
+        uint32_t opcode32 = opcode;
+        opcode32 = deposit32(opcode32, 16, 16, translator_lduw(env, ctx->base.pc_next + 2));
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        if (!decode_insn32(ctx, ctx->opcode)) {
+        if (!decode_insn32(ctx, opcode32)) {
             gen_exception_illegal(ctx);
         }
     }
@@ -776,9 +777,9 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu->env_ptr;
+    uint16_t opcode16 = translator_lduw(env, ctx->base.pc_next);
 
-    ctx->opcode = translator_ldl(env, ctx->base.pc_next);
-    decode_opc(ctx);
+    decode_opc(env, ctx, opcode16);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-- 
2.20.1


