Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC308C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7560B207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ex+D2ogw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7560B207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfjy-0005GY-Gg
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFc-0002iX-Pa
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:45383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFa-0005Sp-Ey
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id bh1so518757plb.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zQ9LiTwiYvU/OCqUdtOQYyrZ4M1sgpr0usqmybWZ6o4=;
 b=Ex+D2ogwLJMPuO5oFexWCKIPEJAFgy1CCQfilYMTWk2N8P2Cemj65W9Eya0OdTlhqU
 x3O73dRK4IUrejO1YH51YnbKjs26Rrxu1E2dxlUz52BMqR6Tmd9QgkgP0Ssr8hUMja5x
 b5hZz4B6rHIdNcyMKSE4jIfW8b854fsQkSdfDHq0rt9Y7RklZAATn/GSBgRuqZU83aXu
 qpYqCKBq/xveOVgbjtomg1vkh7/YWLKZ6TC9Z9Uij+iXvFotLxA6L2quo9X2fKRnU8de
 nMr/ieMeY5cPQH+V1P/BhaFOAWo6p6xoB80tpwjv0Ufb4v2VldJS3geIxjhq/jHbyuu2
 yx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zQ9LiTwiYvU/OCqUdtOQYyrZ4M1sgpr0usqmybWZ6o4=;
 b=eECGQVjGB+RAyhRO+QY6FZ154Qwj5BVJRYAgV29fOdpzMlXTJwnqLWfq1dYYxH5+hv
 LOyVaLMmBeWBduc84MO2rQkDPbeQaTlqLrSTMQi0ofweZrVol8h8JVDeIg/Xi1fSPvmU
 4h9H8m7B7psoAqVJlXoxsfR2yKhwxV7kBzIJ6EwEqoujsWHt+giXjTn/0eoGg+lHZhKx
 NGafgaU3jcxZ2ZGz2FwBozBZ9KWc92rOtwIUP+e0au6pkRWwSx/k2BfGe5W7VMec3qX3
 x7R+IL11LxJliIzpNceGZIEIyo2r18Bbr3tN9uiw1DsZsDNTd2k3HIqN4ZDxc3Ai3kR2
 Csrg==
X-Gm-Message-State: AOAM531e/EUWuY20UJa1q4/kVR0iW+Nzo69CNJ3W/CW0xJOFUVdDCLDy
 /VAcdtPn2VXpx0NeJIEkkpdkV5a8I/ZnPA==
X-Google-Smtp-Source: ABdhPJztQDavifwSEsBAkhZe5pWYPCK1wfHSwPFCAdsh5pf1kfwfPsKui11DBcQ3XARQv3C/VeBNAA==
X-Received: by 2002:a17:902:24c:: with SMTP id
 70mr1473884plc.284.1598624464645; 
 Fri, 28 Aug 2020 07:21:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:21:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 73/76] target/microblaze: Remove last of old decoder
Date: Fri, 28 Aug 2020 07:19:26 -0700
Message-Id: <20200828141929.77854-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All instructions have been convered.  Issue sigill if decodetree
does not match.  Remove argument decode from DisasContext.
Remove microblaze-decode.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/microblaze-decode.h | 59 ----------------------
 target/microblaze/translate.c         | 73 +--------------------------
 2 files changed, 1 insertion(+), 131 deletions(-)
 delete mode 100644 target/microblaze/microblaze-decode.h

diff --git a/target/microblaze/microblaze-decode.h b/target/microblaze/microblaze-decode.h
deleted file mode 100644
index 17b2f29fff..0000000000
--- a/target/microblaze/microblaze-decode.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- *  MicroBlaze insn decoding macros.
- *
- *  Copyright (c) 2009 Edgar E. Iglesias <edgar.iglesias@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef TARGET_MICROBLAZE_MICROBLAZE_DECODE_H
-#define TARGET_MICROBLAZE_MICROBLAZE_DECODE_H
-
-/* Convenient binary macros.  */
-#define HEX__(n) 0x##n##LU
-#define B8__(x) ((x&0x0000000FLU)?1:0) \
-                 + ((x&0x000000F0LU)?2:0) \
-                 + ((x&0x00000F00LU)?4:0) \
-                 + ((x&0x0000F000LU)?8:0) \
-                 + ((x&0x000F0000LU)?16:0) \
-                 + ((x&0x00F00000LU)?32:0) \
-                 + ((x&0x0F000000LU)?64:0) \
-                 + ((x&0xF0000000LU)?128:0)
-#define B8(d) ((unsigned char)B8__(HEX__(d)))
-
-/* Decode logic, value and mask.  */
-#define DEC_ADD     {B8(00000000), B8(00110001)}
-#define DEC_SUB     {B8(00000001), B8(00110001)}
-#define DEC_AND     {B8(00100001), B8(00110101)}
-#define DEC_XOR     {B8(00100010), B8(00110111)}
-#define DEC_OR      {B8(00100000), B8(00110111)}
-#define DEC_BIT     {B8(00100100), B8(00111111)}
-#define DEC_MSR     {B8(00100101), B8(00111111)}
-
-#define DEC_BARREL  {B8(00010001), B8(00110111)}
-#define DEC_MUL     {B8(00010000), B8(00110111)}
-#define DEC_DIV     {B8(00010010), B8(00110111)}
-#define DEC_FPU     {B8(00010110), B8(00111111)}
-
-#define DEC_LD      {B8(00110000), B8(00110100)}
-#define DEC_ST      {B8(00110100), B8(00110100)}
-#define DEC_IMM     {B8(00101100), B8(00111111)}
-
-#define DEC_BR      {B8(00100110), B8(00110111)}
-#define DEC_BCC     {B8(00100111), B8(00110111)}
-#define DEC_RTS     {B8(00101101), B8(00111111)}
-
-#define DEC_STREAM  {B8(00010011), B8(00110111)}
-
-#endif
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2c87d671ae..8f69ca50b2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -24,7 +24,6 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
-#include "microblaze-decode.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
@@ -65,13 +64,7 @@ typedef struct DisasContext {
     bool r0_set;
 
     /* Decoder.  */
-    int type_b;
-    uint32_t ir;
     uint32_t ext_imm;
-    uint8_t opcode;
-    uint8_t rd, ra, rb;
-    uint16_t imm;
-
     unsigned int cpustate_changed;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
@@ -82,8 +75,6 @@ typedef struct DisasContext {
 
     /* Immediate branch-taken destination, or -1 for indirect. */
     uint32_t jmp_dest;
-
-    int abort_at_next_insn;
 } DisasContext;
 
 static int typeb_imm(DisasContext *dc, int x)
@@ -184,21 +175,6 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     return cond_user;
 }
 
-static int32_t dec_alu_typeb_imm(DisasContext *dc)
-{
-    tcg_debug_assert(dc->type_b);
-    return typeb_imm(dc, (int16_t)dc->imm);
-}
-
-static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
-{
-    if (dc->type_b) {
-        tcg_gen_movi_i32(cpu_imm, dec_alu_typeb_imm(dc));
-        return &cpu_imm;
-    }
-    return &cpu_R[dc->rb];
-}
-
 static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
 {
     if (likely(reg != 0)) {
@@ -1549,16 +1525,6 @@ static void do_rte(DisasContext *dc)
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
-static void dec_null(DisasContext *dc)
-{
-    if (trap_illegal(dc, true)) {
-        return;
-    }
-    qemu_log_mask(LOG_GUEST_ERROR, "unknown insn pc=%x opc=%x\n",
-                  (uint32_t)dc->base.pc_next, dc->opcode);
-    dc->abort_at_next_insn = 1;
-}
-
 /* Insns connected to FSL or AXI stream attached devices.  */
 static bool do_get(DisasContext *dc, int rd, int rb, int imm, int ctrl)
 {
@@ -1624,40 +1590,6 @@ static bool trans_putd(DisasContext *dc, arg_putd *arg)
     return do_put(dc, arg->ra, arg->rb, 0, arg->ctrl);
 }
 
-static struct decoder_info {
-    struct {
-        uint32_t bits;
-        uint32_t mask;
-    };
-    void (*dec)(DisasContext *dc);
-} decinfo[] = {
-    {{0, 0}, dec_null}
-};
-
-static void old_decode(DisasContext *dc, uint32_t ir)
-{
-    int i;
-
-    dc->ir = ir;
-
-    /* bit 2 seems to indicate insn type.  */
-    dc->type_b = ir & (1 << 29);
-
-    dc->opcode = EXTRACT_FIELD(ir, 26, 31);
-    dc->rd = EXTRACT_FIELD(ir, 21, 25);
-    dc->ra = EXTRACT_FIELD(ir, 16, 20);
-    dc->rb = EXTRACT_FIELD(ir, 11, 15);
-    dc->imm = EXTRACT_FIELD(ir, 0, 15);
-
-    /* Large switch for all insns.  */
-    for (i = 0; i < ARRAY_SIZE(decinfo); i++) {
-        if ((dc->opcode & decinfo[i].mask) == decinfo[i].bits) {
-            decinfo[i].dec(dc);
-            break;
-        }
-    }
-}
-
 static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
@@ -1667,7 +1599,6 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
     dc->cpustate_changed = 0;
-    dc->abort_at_next_insn = 0;
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
@@ -1724,7 +1655,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     ir = cpu_ldl_code(env, dc->base.pc_next);
     if (!decode(dc, ir)) {
-        old_decode(dc, ir);
+        trap_illegal(dc, true);
     }
 
     if (dc->r0) {
@@ -1764,8 +1695,6 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
-    assert(!dc->abort_at_next_insn);
-
     if (dc->base.is_jmp == DISAS_NORETURN) {
         /* We have already exited the TB. */
         return;
-- 
2.25.1


