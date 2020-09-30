Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C734C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540E6206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxI2r0mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540E6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNj8n-000272-8W
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj04-0003Qs-9j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:34830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizu-0006TW-OH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id y15so872127wmi.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nbGp1UvkeiUE59qdz9Q/r7UbD/0aSHhKjbYBGqm6xVE=;
 b=sxI2r0mpvBNj45GA/3zHCEqpwYxI7N6fDFCegtNCy2MSGeDz9dFUi4gaGXRkA6QMC0
 ShFEXO+zgUELNTakQER0XGiixK1w+sScH5cLnU5czUehoJtdonhH7cSvcAkewlQUMRsu
 mhMM/cdQ9N7Tynu2+Dehx++XirvLYiwjxa8IZv4G3sHwVxBMw1s1fZdd4zKKV8i3fL5a
 6exPQ2RFfE2o1sFFs5g42z8hBCZ95AmqFKDyOfGfyOe8pXZZBGXMI2TiEgZsiI2jhy0f
 ZBXGcefx48TI3OlFaNGG/TCrspa0RFiVRA8S9wI25IevXvbeFEpkvpv9C7eFDeIW2TgE
 R1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nbGp1UvkeiUE59qdz9Q/r7UbD/0aSHhKjbYBGqm6xVE=;
 b=W9YSHywp0yC6RVEjw4t0UvPY5OYJV/8TCCRWXF8zbpl2iKqf+pkiN53DArW93LWGNo
 cmIPgskkaWriuDkATm0aBHvy4tuUwDLVT/LJl7Ae4x8FiEW57pThimuXnrf2sjYd1hYb
 TXpdfd2hodZOSLkHKqCcw9mLBNWRG4HQiPMPMQnfTXpYNQ2U9Bs9D14Qk9cs0QqVdE26
 RbKAgKqC5hdCsy1bg3WLS4Un8BycwO8NTykUmqWh80YyySKhYZqX9p586CdoQBVoJqc7
 FCRIC7VTWnJUFfG2xTiHGi8A1RSfXW6EvjbUpZeSxS+j66LZWFeycVdc3bNU/OXu78c8
 ffVg==
X-Gm-Message-State: AOAM533gA/UbDvOiUNcqSYwYLOkPeQ7RU6Lz9CT8GcF7LKCWEBmy5rv9
 if2/uwOZShPiBnOQ65cngM9fpR4OUJ1nOg==
X-Google-Smtp-Source: ABdhPJzWFjMlalh+shttIjaW+493bDORNjXN257pvV2x7ut1G9CWfHYz3X/iqk0bjOT3btDh3Z1s/A==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr4950859wmh.56.1601498801915; 
 Wed, 30 Sep 2020 13:46:41 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:40 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 06/14] arc: TCG instruction definitions
Date: Wed, 30 Sep 2020 21:45:56 +0100
Message-Id: <20200930204604.20663-7-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cupertino Miranda <cmiranda@synopsys.com>

TCG definitions as defined by our domain-specific-language (DSL) ISA
infrastructure.

Signed-off-by: Cupertino Miranda <cmiranda@synopsys.com>
---
 target/arc/semfunc-helper.c |  492 ++
 target/arc/semfunc-helper.h |  280 ++
 target/arc/semfunc.c        | 8474 +++++++++++++++++++++++++++++++++++
 target/arc/semfunc.h        |   61 +
 4 files changed, 9307 insertions(+)
 create mode 100644 target/arc/semfunc-helper.c
 create mode 100644 target/arc/semfunc-helper.h
 create mode 100644 target/arc/semfunc.c
 create mode 100644 target/arc/semfunc.h

diff --git a/target/arc/semfunc-helper.c b/target/arc/semfunc-helper.c
new file mode 100644
index 0000000000..463759299e
--- /dev/null
+++ b/target/arc/semfunc-helper.c
@@ -0,0 +1,492 @@
+/*
+ *  QEMU ARC CPU
+ *
+ *  Copyright (C) 2016 Michael Rolnik
+ *  Copyright (c) 2019
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR dest PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, see
+ *  http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "translate.h"
+#include "qemu/bitops.h"
+#include "tcg/tcg.h"
+#include "semfunc-helper.h"
+#include "translate.h"
+
+void arc_gen_verifyCCFlag(const DisasCtxt *ctx, TCGv ret)
+{
+    TCGv c1 = tcg_temp_new_i32();
+
+    TCGv nZ = tcg_temp_new_i32();
+    TCGv nN = tcg_temp_new_i32();
+    TCGv nV = tcg_temp_new_i32();
+    TCGv nC = tcg_temp_new_i32();
+
+    switch (ctx->insn.cc) {
+    /* AL, RA */
+    case 0x00:
+        tcg_gen_movi_i32(ret, 1);
+        break;
+    /* EQ, Z */
+    case 0x01:
+        tcg_gen_mov_i32(ret, cpu_Zf);
+        break;
+    /* NE, NZ */
+    case 0x02:
+        tcg_gen_xori_tl(ret, cpu_Zf, 1);
+        break;
+    /* PL, P */
+    case 0x03:
+        tcg_gen_xori_tl(ret, cpu_Nf, 1);
+        break;
+    /* MI, N: */
+    case 0x04:
+        tcg_gen_mov_i32(ret, cpu_Nf);
+        break;
+    /* CS, C, LO */
+    case 0x05:
+        tcg_gen_mov_i32(ret, cpu_Cf);
+        break;
+    /* CC, NC, HS */
+    case 0x06:
+        tcg_gen_xori_tl(ret, cpu_Cf, 1);
+        break;
+    /* VS, V */
+    case 0x07:
+        tcg_gen_mov_i32(ret, cpu_Vf);
+        break;
+    /* VC, NV */
+    case 0x08:
+        tcg_gen_xori_tl(ret, cpu_Vf, 1);
+        break;
+    /* GT */
+    case 0x09:
+        /* (N & V & !Z) | (!N & !V & !Z) */
+        tcg_gen_xori_tl(nZ, cpu_Zf, 1);
+        tcg_gen_xori_tl(nN, cpu_Nf, 1);
+        tcg_gen_xori_tl(nV, cpu_Vf, 1);
+
+        tcg_gen_mov_tl(c1, cpu_Nf);
+        tcg_gen_and_tl(c1, c1, cpu_Vf);
+        tcg_gen_and_tl(c1, c1, nZ);
+
+        tcg_gen_mov_tl(ret, nN);
+        tcg_gen_and_tl(ret, ret, nV);
+        tcg_gen_and_tl(ret, ret, nZ);
+
+        tcg_gen_or_tl(ret, c1, ret);
+        break;
+    /* GE */
+    case 0x0A:
+        /* (N & V) | (!N & !V) */
+        tcg_gen_xori_tl(nN, cpu_Nf, 1);
+        tcg_gen_xori_tl(nV, cpu_Vf, 1);
+
+        tcg_gen_and_tl(c1, cpu_Nf, cpu_Vf);
+
+        tcg_gen_and_tl(ret, nN, nV);
+
+        tcg_gen_or_tl(ret, c1, ret);
+        break;
+    /* LT */
+    case 0x0B:
+        /* (N & !V) | (!N & V) */
+        tcg_gen_xori_tl(nN, cpu_Nf, 1);
+        tcg_gen_xori_tl(nV, cpu_Vf, 1);
+
+        tcg_gen_and_tl(c1, cpu_Nf, nV);
+
+        tcg_gen_and_tl(ret, nN, cpu_Vf);
+
+        tcg_gen_or_tl(ret, ret, c1);
+        break;
+    /* LE */
+    case 0x0C:
+        /* Z | (N & !V) | (!N & V) */
+        tcg_gen_xori_tl(nN, cpu_Nf, 1);
+        tcg_gen_xori_tl(nV, cpu_Vf, 1);
+
+        tcg_gen_and_tl(c1, cpu_Nf, nV);
+
+        tcg_gen_and_tl(ret, nN, cpu_Vf);
+
+        tcg_gen_or_tl(ret, ret, c1);
+
+        tcg_gen_or_tl(ret, ret, cpu_Zf);
+        break;
+    /* HI */
+    case 0x0D:
+        /* !C & !Z */
+        tcg_gen_xori_tl(nC, cpu_Cf, 1);
+        tcg_gen_xori_tl(nZ, cpu_Zf, 1);
+
+        tcg_gen_and_tl(ret, nC, nZ);
+        break;
+    /* LS */
+    case 0x0E:
+        /* C & Z */
+        tcg_gen_or_tl(ret, cpu_Cf, cpu_Zf);
+        break;
+    /* PNZ */
+    case 0x0F:
+        /* !N & !Z */
+        tcg_gen_xori_tl(nN, cpu_Nf, 1);
+        tcg_gen_xori_tl(nZ, cpu_Zf, 1);
+
+        tcg_gen_and_tl(ret, nN, nZ);
+        break;
+    }
+
+    tcg_temp_free_i32(c1);
+    tcg_temp_free_i32(nZ);
+    tcg_temp_free_i32(nN);
+    tcg_temp_free_i32(nV);
+    tcg_temp_free_i32(nC);
+}
+
+#define MEMIDX (ctx->mem_idx)
+
+void arc_gen_set_memory(DisasCtxt *ctx, TCGv vaddr, int size,
+        TCGv src, bool sign_extend)
+{
+    switch (size) {
+    case 0x00:
+        tcg_gen_qemu_st_tl(src, vaddr, MEMIDX, MO_UL);
+        break;
+
+    case 0x01:
+        if (sign_extend) {
+            tcg_gen_qemu_st_tl(src, vaddr, MEMIDX, MO_SB);
+        } else {
+            tcg_gen_qemu_st_tl(src, vaddr, MEMIDX, MO_UB);
+        }
+        break;
+
+    case 0x02:
+        if (sign_extend) {
+            tcg_gen_qemu_st_tl(src, vaddr, MEMIDX, MO_SW);
+        } else {
+            tcg_gen_qemu_st_tl(src, vaddr, MEMIDX, MO_UW);
+        }
+        break;
+
+    case 0x03:
+        assert(!"reserved");
+        break;
+    }
+}
+
+void arc_gen_get_memory(DisasCtxt *ctx, TCGv dest, TCGv vaddr,
+        int size, bool sign_extend)
+{
+    switch (size) {
+    case 0x00:
+        tcg_gen_qemu_ld_tl(dest, vaddr, MEMIDX, MO_UL);
+        break;
+
+    case 0x01:
+        if (sign_extend) {
+            tcg_gen_qemu_ld_tl(dest, vaddr, MEMIDX, MO_SB);
+        } else {
+            tcg_gen_qemu_ld_tl(dest, vaddr, MEMIDX, MO_UB);
+        }
+        break;
+
+    case 0x02:
+        if (sign_extend) {
+            tcg_gen_qemu_ld_tl(dest, vaddr, MEMIDX, MO_SW);
+        } else {
+            tcg_gen_qemu_ld_tl(dest, vaddr, MEMIDX, MO_UW);
+        }
+        break;
+
+    case 0x03:
+        assert(!"reserved");
+        break;
+    }
+}
+
+
+void arc_gen_no_further_loads_pending(DisasCtxt *ctx, TCGv ret)
+{
+    tcg_gen_movi_tl(ret, 1);
+}
+
+void arc_gen_set_debug(DisasCtxt *ctx, bool value)
+{
+    /* TODO: Could not find a reson to set this. */
+}
+
+extern bool enabled_interrupts;
+void
+arc_gen_execute_delayslot(DisasCtxt *ctx, TCGv bta, TCGv take_branch)
+{
+    static int in_delay_slot = false;
+
+    assert(ctx->insn.limm_p == 0 && !in_delay_slot);
+
+    if (ctx->insn.limm_p == 0 && !in_delay_slot) {
+        in_delay_slot = true;
+        uint32_t cpc = ctx->cpc;
+        uint32_t pcl = ctx->pcl;
+        insn_t insn = ctx->insn;
+
+        ctx->cpc = ctx->npc;
+        ctx->pcl = ctx->cpc & 0xfffffffc;
+
+        ++ctx->ds;
+
+        TCGLabel *do_not_set_bta_and_de = gen_new_label();
+        tcg_gen_brcondi_i32(TCG_COND_NE, take_branch, 1, do_not_set_bta_and_de);
+        /*
+         * In case an exception should be raised during the execution
+         * of delay slot, bta value is used to set erbta.
+         */
+        tcg_gen_mov_tl(cpu_bta, bta);
+        /* We are in a delay slot */
+        tcg_gen_mov_tl(cpu_DEf, take_branch);
+        gen_set_label(do_not_set_bta_and_de);
+
+        tcg_gen_movi_tl(cpu_is_delay_slot_instruction, 1);
+
+        /* Set the pc to the next pc */
+        tcg_gen_movi_tl(cpu_pc, ctx->npc);
+        /* Necessary for the likely call to restore_state_to_opc() */
+        tcg_gen_insn_start(ctx->npc);
+
+        DisasJumpType type = ctx->base.is_jmp;
+        enabled_interrupts = false;
+
+        /*
+         * In case we might be in a situation where the delayslot is in a
+         * different MMU page. Make a fake exception to interrupt
+         * delayslot execution in the context of the branch.
+         * The delayslot will then be re-executed in isolation after the
+         * branch code has set bta and DEf status flag.
+         */
+        if ((cpc & PAGE_MASK) < 0x80000000 &&
+            (cpc & PAGE_MASK) != (ctx->cpc & PAGE_MASK)) {
+            in_delay_slot = false;
+            TCGv dpc = tcg_const_local_i32(ctx->npc);
+            tcg_gen_mov_tl(cpu_pc, dpc);
+            gen_helper_fake_exception(cpu_env, dpc);
+            tcg_temp_free_i32(dpc);
+            return;
+        }
+
+        decode_opc(ctx->env, ctx);
+        enabled_interrupts = true;
+        ctx->base.is_jmp = type;
+
+        tcg_gen_movi_tl(cpu_DEf, 0);
+        tcg_gen_movi_tl(cpu_is_delay_slot_instruction, 0);
+
+        /* Restore the pc back */
+        tcg_gen_movi_tl(cpu_pc, cpc);
+        /* Again, restore_state_to_opc() must use recent value */
+        tcg_gen_insn_start(cpc);
+
+        assert(ctx->base.is_jmp == DISAS_NEXT);
+
+        --ctx->ds;
+
+        /* Restore old values.  */
+        ctx->cpc = cpc;
+        ctx->pcl = pcl;
+        ctx->insn = insn;
+        in_delay_slot = false;
+    }
+    return;
+}
+
+
+/* dest = src1 - src2. Compute C, N, V and Z flags */
+void arc_gen_sub_Cf(TCGv ret, TCGv dest, TCGv src1, TCGv src2)
+{
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv t2 = tcg_temp_new_i32();
+    TCGv t3 = tcg_temp_new_i32();
+
+    tcg_gen_not_tl(t1, src1);       /* t1 = ~src1                 */
+    tcg_gen_and_tl(t2, t1, src2);   /* t2 = ~src1 & src2          */
+    tcg_gen_or_tl(t3, t1, src2);    /* t3 = (~src1 | src2) & dest */
+    tcg_gen_and_tl(t3, t3, dest);
+    /* t2 = ~src1 & src2 | ~src1 & dest | dest & src2 */
+    tcg_gen_or_tl(t2, t2, t3);
+    tcg_gen_shri_tl(ret, t2, 31);   /* Cf = t2(31)                */
+
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
+
+void arc_gen_get_bit(TCGv ret, TCGv a, TCGv pos)
+{
+    tcg_gen_rotr_i32(ret, a, pos);
+    tcg_gen_andi_tl(ret, ret, 1);
+}
+
+/* accumulator += b32 * c32 */
+void arc_gen_mac(TCGv phi, TCGv_i32 b32, TCGv_i32 c32)
+{
+    TCGv_i32 plo = tcg_temp_new_i32();
+    tcg_gen_muls2_i32(plo, phi, b32, c32);
+
+    /* Adding the product to the accumulator */
+    tcg_gen_add2_i32(cpu_acclo, cpu_acchi, cpu_acclo, cpu_acchi, plo, phi);
+    tcg_temp_free(plo);
+}
+
+/* Unsigned version of mac */
+void arc_gen_macu(TCGv phi, TCGv_i32 b32, TCGv_i32 c32)
+{
+    TCGv_i32 plo = tcg_temp_new_i32();
+    tcg_gen_mulu2_i32(plo, phi, b32, c32);
+
+    /* Adding the product to the accumulator */
+    tcg_gen_add2_i32(cpu_acclo, cpu_acchi, cpu_acclo, cpu_acchi, plo, phi);
+    tcg_temp_free(plo);
+}
+
+/* TODO: A better name would be tcg_gen_shil_i32() */
+void tcg_gen_shlfi_i32(TCGv a, int b, TCGv c)
+{
+    TCGv tmp = tcg_temp_new_i32();
+    tcg_gen_movi_i32(tmp, b);
+    tcg_gen_shl_i32(a, tmp, c);
+    tcg_temp_free(tmp);
+}
+
+/* TODO: A gen_helper() would be better for this purpose */
+void arc_gen_extract_bits(TCGv ret, TCGv a, TCGv start, TCGv end)
+{
+    TCGv tmp1 = tcg_temp_new_i32();
+
+    tcg_gen_shr_i32(ret, a, end);
+
+    tcg_gen_sub_i32(tmp1, start, end);
+    tcg_gen_addi_i32(tmp1, tmp1, 1);
+    tcg_gen_shlfi_i32(tmp1, 1, tmp1);
+    tcg_gen_subi_i32(tmp1, tmp1, 1);
+
+    tcg_gen_and_i32(ret, ret, tmp1);
+
+    tcg_temp_free(tmp1);
+}
+
+
+void arc_gen_get_register(TCGv ret, enum arc_registers reg)
+{
+    switch (reg) {
+    case R_SP:
+        tcg_gen_mov_i32(ret, cpu_sp);
+        break;
+    case R_STATUS32:
+        gen_helper_get_status32(ret, cpu_env);
+        break;
+    case R_ACCLO:
+        tcg_gen_mov_i32(ret, cpu_acclo);
+        break;
+    case R_ACCHI:
+        tcg_gen_mov_i32(ret, cpu_acchi);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+
+void arc_gen_set_register(enum arc_registers reg, TCGv value)
+{
+    switch (reg) {
+    case R_SP:
+        tcg_gen_mov_i32(cpu_sp, value);
+        break;
+    case R_STATUS32:
+        gen_helper_set_status32(cpu_env, value);
+        break;
+    case R_ACCLO:
+        tcg_gen_mov_i32(cpu_acclo, value);
+        break;
+    case R_ACCHI:
+        tcg_gen_mov_i32(cpu_acchi, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+
+/* TODO: Get this from props ... */
+void arc_has_interrupts(DisasCtxt *ctx, TCGv ret)
+{
+    tcg_gen_movi_i32(ret, 1);
+}
+
+/*
+ ***************************************
+ * Statically inferred return function *
+ ***************************************
+ */
+
+TCGv arc_gen_next_reg(const DisasCtxt *ctx, TCGv reg)
+{
+    int i;
+    for (i = 0; i < 64; i += 2) {
+        if (reg == cpu_r[i]) {
+            return cpu_r[i + 1];
+        }
+    }
+    /* Check if REG is an odd register. */
+    for (i = 1; i < 64; i += 2) {
+        /* If so, that is unsanctioned. */
+        if (reg == cpu_r[i]) {
+            arc_gen_excp(ctx, EXCP_INST_ERROR, 0, 0);
+            return NULL;
+        }
+    }
+    /* REG was not a register after all. */
+    g_assert_not_reached();
+
+    /* We never get here, but to accommodate -Werror ... */
+    return NULL;
+}
+
+bool arc_target_has_option(enum target_options option)
+{
+    /* TODO: Fill with meaningful cases. */
+    switch (option) {
+    case LL64_OPTION:
+        return true;
+        break;
+    default:
+        break;
+    }
+    return false;
+}
+
+
+bool arc_is_instruction_operand_a_register(const DisasCtxt *ctx, int nop)
+{
+    assert(nop < ctx->insn.n_ops);
+    operand_t operand = ctx->insn.operands[nop];
+
+    return (operand.type & ARC_OPERAND_IR) != 0;
+}
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/semfunc-helper.h b/target/arc/semfunc-helper.h
new file mode 100644
index 0000000000..72a659a1f7
--- /dev/null
+++ b/target/arc/semfunc-helper.h
@@ -0,0 +1,280 @@
+/*
+ * QEMU ARC CPU
+ * Copyright (C) 2016 Michael Rolnik
+ * Copyright (C) 2019 Free Software Foundation, Inc.
+
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License
+ * along with GAS or GDB; see the file COPYING3.  If not, write to
+ * the Free Software Foundation, 51 Franklin Street - Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#ifndef TRANSLATE_INST_H_
+#define TRANSLATE_INST_H_
+
+#include "translate.h"
+#include "qemu/bitops.h"
+#include "tcg/tcg.h"
+#include "target/arc/regs.h"
+
+typedef enum ARC_COND {
+    ARC_COND_AL      = 0x00,
+    ARC_COND_RA      = 0x00,
+    ARC_COND_EQ      = 0x01,
+    ARC_COND_Z       = 0x01,
+    ARC_COND_NE      = 0x02,
+    ARC_COND_NZ      = 0x02,
+    ARC_COND_PL      = 0x03,
+    ARC_COND_P       = 0x03,
+    ARC_COND_MI      = 0x04,
+    ARC_COND_N       = 0x04,
+    ARC_COND_CS      = 0x05,
+    ARC_COND_C       = 0x05,
+    ARC_COND_LO      = 0x05,
+    ARC_COND_CC      = 0x06,
+    ARC_COND_NC      = 0x06,
+    ARC_COND_HS      = 0x06,
+    ARC_COND_VS      = 0x07,
+    ARC_COND_V       = 0x07,
+    ARC_COND_VC      = 0x08,
+    ARC_COND_NV      = 0x08,
+    ARC_COND_GT      = 0x09,
+    ARC_COND_GE      = 0x0a,
+    ARC_COND_LT      = 0x0b,
+    ARC_COND_LE      = 0x0c,
+    ARC_COND_HI      = 0x0d,
+    ARC_COND_LS      = 0x0e,
+    ARC_COND_PNZ     = 0x0f,
+} ARC_COND;
+
+#define ARC_HELPER(NAME, RET, ...) \
+    gen_helper_##NAME(RET, cpu_env, __VA_ARGS__)
+
+enum arc_registers {
+    R_SP = 0,
+    R_STATUS32,
+    R_ACCLO,
+    R_ACCHI
+};
+
+enum target_options {
+    INVALID_TARGET_OPTIONS = -1,
+    DIV_REM_OPTION,
+    STACK_CHECKING,
+    LL64_OPTION
+};
+
+/* TODO: Change this to allow something else then ARC HS. */
+#define LP_START    \
+    (arc_aux_reg_address_for(AUX_ID_lp_start, ARC_OPCODE_ARCv2HS))
+#define LP_END      \
+    (arc_aux_reg_address_for(AUX_ID_lp_end, ARC_OPCODE_ARCv2HS))
+
+#define ReplMask(DEST, SRC, MASK) \
+    gen_helper_repl_mask(DEST, DEST, SRC, MASK)
+
+void arc_gen_verifyCCFlag(const DisasCtxt *ctx, TCGv ret);
+#define getCCFlag(R)    arc_gen_verifyCCFlag(ctx, R)
+
+#define getFFlag(R) ((int) ctx->insn.f)
+
+void to_implement(DisasCtxt *ctx);
+void to_implement_wo_abort(DisasCtxt *ctx);
+
+#define killDelaySlot()
+void arc_gen_set_memory(
+        DisasCtxt *ctx, TCGv addr, int size, TCGv src, bool sign_extend);
+#define setMemory(ADDRESS, SIZE, VALUE) \
+    arc_gen_set_memory(ctx, ADDRESS, SIZE, VALUE, getFlagX())
+void arc_gen_get_memory(
+        DisasCtxt *ctx, TCGv ret, TCGv addr, int size, bool sign_extend);
+#define getMemory(R, ADDRESS, SIZE) \
+    arc_gen_get_memory(ctx, R, ADDRESS, SIZE, getFlagX())
+
+#define getFlagX()  (ctx->insn.x)
+#define getZZFlag() (ctx->insn.zz)
+#define getAAFlag() (ctx->insn.aa)
+
+#define SignExtend(VALUE, SIZE) VALUE
+void arc_gen_no_further_loads_pending(DisasCtxt *ctx, TCGv ret);
+#define NoFurtherLoadsPending(R)    arc_gen_no_further_loads_pending(ctx, R)
+void arc_gen_set_debug(DisasCtxt *ctx, bool value);
+#define setDebugLD(A)   arc_gen_set_debug(ctx, A)
+void arc_gen_execute_delayslot(DisasCtxt *ctx, TCGv bta, TCGv take_branch);
+#define executeDelaySlot(bta, take_branch) \
+    arc_gen_execute_delayslot(ctx, bta, take_branch)
+
+#define shouldExecuteDelaySlot()    (ctx->insn.d != 0)
+
+#define setNFlag(ELEM)  tcg_gen_shri_tl(cpu_Nf, ELEM, 31)
+#define getNFlag(R)     cpu_Nf
+
+#define setCFlag(ELEM)  tcg_gen_mov_tl(cpu_Cf, ELEM)
+#define getCFlag(R)     tcg_gen_mov_tl(R, cpu_Cf)
+
+#define setVFlag(ELEM)  tcg_gen_mov_tl(cpu_Vf, ELEM)
+
+#define setZFlag(ELEM)  \
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_Zf, ELEM, 0);
+
+#define nextInsnAddressAfterDelaySlot(R) \
+  { \
+    uint16_t delayslot_buffer[2]; \
+    uint8_t delayslot_length; \
+    ctx->env->pc = ctx->cpc; \
+    ctx->env->stat.is_delay_slot_instruction = 1; \
+    delayslot_buffer[0] = cpu_lduw_code(ctx->env, ctx->npc); \
+    delayslot_length = arc_insn_length(delayslot_buffer[0], ctx->env->family); \
+    tcg_gen_movi_tl(R, ctx->npc + delayslot_length); \
+  }
+
+#define nextInsnAddress(R)  tcg_gen_movi_tl(R, ctx->npc)
+#define getPCL(R)           tcg_gen_movi_tl(R, ctx->pcl)
+
+#define setPC(NEW_PC)                                   \
+    do {                                                \
+        gen_goto_tb(ctx, 1, NEW_PC);                    \
+        ret = ret == DISAS_NEXT ? DISAS_NORETURN : ret; \
+    } while (0)
+
+#define setBLINK(BLINK_ADDR) \
+  tcg_gen_mov_i32(cpu_blink, BLINK_ADDR);
+
+#define Carry(R, A)             tcg_gen_shri_tl(R, A, 31);
+
+#define CarryADD(R, A, B, C)    gen_helper_carry_add_flag(R, A, B, C)
+#define OverflowADD(R, A, B, C) gen_helper_overflow_add_flag(R, A, B, C)
+
+void arc_gen_sub_Cf(TCGv ret, TCGv dest, TCGv src1, TCGv src2);
+#define CarrySUB(R, A, B, C)    arc_gen_sub_Cf(R, A, B, C)
+#define OverflowSUB(R, A, B, C) gen_helper_overflow_sub_flag(R, A, B, C)
+
+#define unsignedLT(R, B, C)           tcg_gen_setcond_i32(TCG_COND_LTU, R, B, C)
+#define unsignedGE(R, B, C)           tcg_gen_setcond_i32(TCG_COND_GEU, R, B, C)
+#define logicalShiftRight(R, B, C)    tcg_gen_shr_i32(R, B, C)
+#define logicalShiftLeft(R, B, C)     tcg_gen_shl_i32(R, B, C)
+#define arithmeticShiftRight(R, B, C) tcg_gen_sar_i32(R, B, C)
+#define rotateLeft(R, B, C)           tcg_gen_rotl_i32(R, B, C)
+#define rotateRight(R, B, C)          tcg_gen_rotr_i32(R, B, C)
+
+void arc_gen_get_bit(TCGv ret, TCGv a, TCGv pos);
+#define getBit(R, A, POS)   arc_gen_get_bit(R, A, POS)
+
+#define getRegIndex(R, ID)  tcg_gen_movi_tl(R, (int) ID)
+
+#define readAuxReg(R, A)    gen_helper_lr(R, cpu_env, A)
+/*
+ * Here, by returning DISAS_UPDATE we are making SR the end
+ * of a Translation Block (TB). This is necessary because
+ * sometimes writing to control registers updates how a TB is
+ * handled, like enabling MMU/MPU. If SR is not marked as the
+ * end, the next instructions are fetched and generated and
+ * the updated outcome (page/region permissions) is not taken
+ * into account.
+ */
+#define writeAuxReg(NAME, B)             \
+    do {                                 \
+        gen_helper_sr(cpu_env, B, NAME); \
+        ret = DISAS_UPDATE;              \
+    } while (0)
+
+/*
+ * At the end of a SYNC instruction, it is guaranteed that
+ * handling the current interrupt is finished and the raising
+ * pulse signal (if any), is cleared. By marking SYNC as the
+ * end of a TB we gave a chance to interrupt threads to execute.
+ */
+#define syncReturnDisasUpdate()     (ret = DISAS_UPDATE)
+
+/*
+ * An enter_s may change code like below:
+ * ----
+ * r13 .. r26 <== shell opcodes
+ * sp <= pc+56
+ * enter_s
+ * ---
+ * It's not that we are promoting these type of instructions.
+ * nevertheless we must be able to emulate them. Hence, once
+ * again: ret = DISAS_UPDATE
+ */
+#define helperEnter(U6)                 \
+    do {                                \
+        gen_helper_enter(cpu_env, U6);  \
+        ret = DISAS_UPDATE;             \
+    } while (0)
+
+/* A leave_s may jump to blink, hence the DISAS_UPDATE */
+#define helperLeave(U7)                                           \
+    do {                                                          \
+        tcg_gen_movi_tl(cpu_pc, ctx->cpc);                        \
+        gen_helper_leave(cpu_env, U7);                            \
+        TCGv jump_to_blink = tcg_temp_local_new_i32();            \
+        TCGLabel *done = gen_new_label();                         \
+        tcg_gen_shri_i32(jump_to_blink, U7, 6);                   \
+        tcg_gen_brcondi_i32(TCG_COND_EQ, jump_to_blink, 0, done); \
+        gen_goto_tb(ctx, 1, cpu_pc);                              \
+        ret = DISAS_NORETURN;                                     \
+        gen_set_label(done);                                      \
+        tcg_temp_free(jump_to_blink);                             \
+    } while (0)
+
+void arc_gen_mac(TCGv phi, TCGv_i32 b, TCGv_i32 c);
+#define MAC(R, B, C)  arc_gen_mac(R, B, C)
+void arc_gen_macu(TCGv phi, TCGv_i32 b, TCGv_i32 c);
+#define MACU(R, B, C) arc_gen_macu(R, B, C)
+
+void arc_gen_extract_bits(TCGv ret, TCGv a, TCGv start, TCGv end);
+#define extractBits(R, ELEM, START, END) \
+    arc_gen_extract_bits(R, ELEM, START, END)
+void arc_gen_get_register(TCGv ret, enum arc_registers reg);
+#define getRegister(R, REG) arc_gen_get_register(R, REG)
+void arc_gen_set_register(enum arc_registers reg, TCGv value);
+#define setRegister(REG, VALUE) arc_gen_set_register(REG, VALUE)
+
+#define divSigned(R, SRC1, SRC2)            tcg_gen_div_i32(R, SRC1, SRC2)
+#define divUnsigned(R, SRC1, SRC2)          tcg_gen_divu_i32(R, SRC1, SRC2)
+#define divRemainingSigned(R, SRC1, SRC2)   tcg_gen_rem_i32(R, SRC1, SRC2)
+#define divRemainingUnsigned(R, SRC1, SRC2) tcg_gen_remu_i32(R, SRC1, SRC2)
+
+/* TODO: To implement */
+#define Halt()
+
+void arc_has_interrupts(DisasCtxt *ctx, TCGv ret);
+#define hasInterrupts(R)    arc_has_interrupts(ctx, R)
+#define doNothing()
+
+#define setLF(VALUE)    tcg_gen_mov_tl(cpu_lock_lf_var, VALUE)
+#define getLF(R)        tcg_gen_mov_tl(R, cpu_lock_lf_var)
+
+/* Statically inferred return function */
+
+TCGv arc_gen_next_reg(const DisasCtxt *ctx, TCGv reg);
+#define nextReg(A) arc_gen_next_reg(ctx, A)
+
+/* TODO (issue #62): This must be removed. */
+#define Zero()  (ctx->zero)
+
+bool arc_target_has_option(enum target_options option);
+#define targetHasOption(OPTION) arc_target_has_option(OPTION)
+
+bool arc_is_instruction_operand_a_register(const DisasCtxt *ctx, int nop);
+#define instructionHasRegisterOperandIn(NOP) \
+    arc_is_instruction_operand_a_register(ctx, NOP)
+
+void tcg_gen_shlfi_i32(TCGv a, int b, TCGv c);
+
+#endif /* TRANSLATE_INST_H_ */
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/semfunc.c b/target/arc/semfunc.c
new file mode 100644
index 0000000000..9a9a4b8e64
--- /dev/null
+++ b/target/arc/semfunc.c
@@ -0,0 +1,8474 @@
+/*
+ *  QEMU ARC CPU
+ *
+ *  Copyright (c) 2017 Cupertino Miranda
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, see
+ *  <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "translate.h"
+#include "target/arc/semfunc.h"
+
+
+
+
+/*
+ * FLAG
+ *    Variables: @src
+ *    Functions: getCCFlag, getRegister, getBit, hasInterrupts, Halt, ReplMask,
+ *               targetHasOption, setRegister
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       status32 = getRegister (R_STATUS32);
+ *       if(((getBit (@src, 0) == 1) && (getBit (status32, 7) == 0)))
+ *         {
+ *           if((hasInterrupts () > 0))
+ *             {
+ *               status32 = (status32 | 1);
+ *               Halt ();
+ *             };
+ *         }
+ *       else
+ *         {
+ *           ReplMask (status32, @src, 3840);
+ *           if(((getBit (status32, 7) == 0) && (hasInterrupts () > 0)))
+ *             {
+ *               ReplMask (status32, @src, 30);
+ *               if(targetHasOption (DIV_REM_OPTION))
+ *                 {
+ *                   ReplMask (status32, @src, 8192);
+ *                 };
+ *               if(targetHasOption (STACK_CHECKING))
+ *                 {
+ *                   ReplMask (status32, @src, 16384);
+ *                 };
+ *               if(targetHasOption (LL64_OPTION))
+ *                 {
+ *                   ReplMask (status32, @src, 524288);
+ *                 };
+ *               ReplMask (status32, @src, 1048576);
+ *             };
+ *         };
+ *       setRegister (R_STATUS32, status32);
+ *     };
+ * }
+ */
+
+int
+arc_gen_FLAG(DisasCtxt *ctx, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_14 = tcg_temp_local_new_i32();
+    TCGv status32 = tcg_temp_local_new_i32();
+    TCGv temp_16 = tcg_temp_local_new_i32();
+    TCGv temp_15 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_18 = tcg_temp_local_new_i32();
+    TCGv temp_17 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_19 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_20 = tcg_temp_local_new_i32();
+    TCGv temp_22 = tcg_temp_local_new_i32();
+    TCGv temp_21 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_23 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv temp_24 = tcg_temp_local_new_i32();
+    TCGv temp_25 = tcg_temp_local_new_i32();
+    TCGv temp_26 = tcg_temp_local_new_i32();
+    TCGv temp_27 = tcg_temp_local_new_i32();
+    TCGv temp_28 = tcg_temp_local_new_i32();
+    getCCFlag(temp_13);
+    tcg_gen_mov_i32(cc_flag, temp_13);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    getRegister(temp_14, R_STATUS32);
+    tcg_gen_mov_i32(status32, temp_14);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_movi_i32(temp_16, 0);
+    getBit(temp_15, src, temp_16);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, temp_15, 1);
+    tcg_gen_movi_i32(temp_18, 7);
+    getBit(temp_17, status32, temp_18);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_4, temp_17, 0);
+    tcg_gen_and_i32(temp_5, temp_3, temp_4);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_2);
+    TCGLabel *done_3 = gen_new_label();
+    hasInterrupts(temp_19);
+    tcg_gen_setcondi_i32(TCG_COND_GT, temp_7, temp_19, 0);
+    tcg_gen_xori_i32(temp_8, temp_7, 1);
+    tcg_gen_andi_i32(temp_8, temp_8, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_8, arc_true, done_3);
+    tcg_gen_ori_i32(status32, status32, 1);
+    Halt();
+    gen_set_label(done_3);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_movi_i32(temp_20, 3840);
+    ReplMask(status32, src, temp_20);
+    TCGLabel *done_4 = gen_new_label();
+    tcg_gen_movi_i32(temp_22, 7);
+    getBit(temp_21, status32, temp_22);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_9, temp_21, 0);
+    hasInterrupts(temp_23);
+    tcg_gen_setcondi_i32(TCG_COND_GT, temp_10, temp_23, 0);
+    tcg_gen_and_i32(temp_11, temp_9, temp_10);
+    tcg_gen_xori_i32(temp_12, temp_11, 1);
+    tcg_gen_andi_i32(temp_12, temp_12, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_12, arc_true, done_4);
+    tcg_gen_movi_i32(temp_24, 30);
+    ReplMask(status32, src, temp_24);
+    if (targetHasOption (DIV_REM_OPTION)) {
+        tcg_gen_movi_i32(temp_25, 8192);
+        ReplMask(status32, src, temp_25);
+    }
+    if (targetHasOption (STACK_CHECKING)) {
+        tcg_gen_movi_i32(temp_26, 16384);
+        ReplMask(status32, src, temp_26);
+    }
+    if (targetHasOption (LL64_OPTION)) {
+        tcg_gen_movi_i32(temp_27, 524288);
+        ReplMask(status32, src, temp_27);
+    }
+    tcg_gen_movi_i32(temp_28, 1048576);
+    ReplMask(status32, src, temp_28);
+    gen_set_label(done_4);
+    gen_set_label(done_2);
+    setRegister(R_STATUS32, status32);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_14);
+    tcg_temp_free(status32);
+    tcg_temp_free(temp_16);
+    tcg_temp_free(temp_15);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_18);
+    tcg_temp_free(temp_17);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_19);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_20);
+    tcg_temp_free(temp_22);
+    tcg_temp_free(temp_21);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_23);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(temp_24);
+    tcg_temp_free(temp_25);
+    tcg_temp_free(temp_26);
+    tcg_temp_free(temp_27);
+    tcg_temp_free(temp_28);
+
+    return ret;
+}
+
+
+/*
+ * KFLAG
+ *    Variables: @src
+ *    Functions: getCCFlag, getRegister, getBit, hasInterrupts, Halt, ReplMask,
+ *               targetHasOption, setRegister
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       status32 = getRegister (R_STATUS32);
+ *       if(((getBit (@src, 0) == 1) && (getBit (status32, 7) == 0)))
+ *         {
+ *           if((hasInterrupts () > 0))
+ *             {
+ *               status32 = (status32 | 1);
+ *               Halt ();
+ *             };
+ *         }
+ *       else
+ *         {
+ *           ReplMask (status32, @src, 3840);
+ *           if(((getBit (status32, 7) == 0) && (hasInterrupts () > 0)))
+ *             {
+ *               ReplMask (status32, @src, 62);
+ *               if(targetHasOption (DIV_REM_OPTION))
+ *                 {
+ *                   ReplMask (status32, @src, 8192);
+ *                 };
+ *               if(targetHasOption (STACK_CHECKING))
+ *                 {
+ *                   ReplMask (status32, @src, 16384);
+ *                 };
+ *               ReplMask (status32, @src, 65536);
+ *               if(targetHasOption (LL64_OPTION))
+ *                 {
+ *                   ReplMask (status32, @src, 524288);
+ *                 };
+ *               ReplMask (status32, @src, 1048576);
+ *               ReplMask (status32, @src, 2147483648);
+ *             };
+ *         };
+ *       setRegister (R_STATUS32, status32);
+ *     };
+ * }
+ */
+
+int
+arc_gen_KFLAG(DisasCtxt *ctx, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_14 = tcg_temp_local_new_i32();
+    TCGv status32 = tcg_temp_local_new_i32();
+    TCGv temp_16 = tcg_temp_local_new_i32();
+    TCGv temp_15 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_18 = tcg_temp_local_new_i32();
+    TCGv temp_17 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_19 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_20 = tcg_temp_local_new_i32();
+    TCGv temp_22 = tcg_temp_local_new_i32();
+    TCGv temp_21 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_23 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv temp_24 = tcg_temp_local_new_i32();
+    TCGv temp_25 = tcg_temp_local_new_i32();
+    TCGv temp_26 = tcg_temp_local_new_i32();
+    TCGv temp_27 = tcg_temp_local_new_i32();
+    TCGv temp_28 = tcg_temp_local_new_i32();
+    TCGv temp_29 = tcg_temp_local_new_i32();
+    TCGv temp_30 = tcg_temp_local_new_i32();
+    getCCFlag(temp_13);
+    tcg_gen_mov_i32(cc_flag, temp_13);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    getRegister(temp_14, R_STATUS32);
+    tcg_gen_mov_i32(status32, temp_14);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_movi_i32(temp_16, 0);
+    getBit(temp_15, src, temp_16);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, temp_15, 1);
+    tcg_gen_movi_i32(temp_18, 7);
+    getBit(temp_17, status32, temp_18);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_4, temp_17, 0);
+    tcg_gen_and_i32(temp_5, temp_3, temp_4);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_2);
+    TCGLabel *done_3 = gen_new_label();
+    hasInterrupts(temp_19);
+    tcg_gen_setcondi_i32(TCG_COND_GT, temp_7, temp_19, 0);
+    tcg_gen_xori_i32(temp_8, temp_7, 1);
+    tcg_gen_andi_i32(temp_8, temp_8, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_8, arc_true, done_3);
+    tcg_gen_ori_i32(status32, status32, 1);
+    Halt();
+    gen_set_label(done_3);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_movi_i32(temp_20, 3840);
+    ReplMask(status32, src, temp_20);
+    TCGLabel *done_4 = gen_new_label();
+    tcg_gen_movi_i32(temp_22, 7);
+    getBit(temp_21, status32, temp_22);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_9, temp_21, 0);
+    hasInterrupts(temp_23);
+    tcg_gen_setcondi_i32(TCG_COND_GT, temp_10, temp_23, 0);
+    tcg_gen_and_i32(temp_11, temp_9, temp_10);
+    tcg_gen_xori_i32(temp_12, temp_11, 1);
+    tcg_gen_andi_i32(temp_12, temp_12, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_12, arc_true, done_4);
+    tcg_gen_movi_i32(temp_24, 62);
+    ReplMask(status32, src, temp_24);
+    if (targetHasOption (DIV_REM_OPTION)) {
+        tcg_gen_movi_i32(temp_25, 8192);
+        ReplMask(status32, src, temp_25);
+    }
+    if (targetHasOption (STACK_CHECKING)) {
+        tcg_gen_movi_i32(temp_26, 16384);
+        ReplMask(status32, src, temp_26);
+    }
+    tcg_gen_movi_i32(temp_27, 65536);
+    ReplMask(status32, src, temp_27);
+    if (targetHasOption (LL64_OPTION)) {
+        tcg_gen_movi_i32(temp_28, 524288);
+        ReplMask(status32, src, temp_28);
+    }
+    tcg_gen_movi_i32(temp_29, 1048576);
+    ReplMask(status32, src, temp_29);
+    tcg_gen_movi_i32(temp_30, 2147483648);
+    ReplMask(status32, src, temp_30);
+    gen_set_label(done_4);
+    gen_set_label(done_2);
+    setRegister(R_STATUS32, status32);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_14);
+    tcg_temp_free(status32);
+    tcg_temp_free(temp_16);
+    tcg_temp_free(temp_15);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_18);
+    tcg_temp_free(temp_17);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_19);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_20);
+    tcg_temp_free(temp_22);
+    tcg_temp_free(temp_21);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_23);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(temp_24);
+    tcg_temp_free(temp_25);
+    tcg_temp_free(temp_26);
+    tcg_temp_free(temp_27);
+    tcg_temp_free(temp_28);
+    tcg_temp_free(temp_29);
+    tcg_temp_free(temp_30);
+
+    return ret;
+}
+
+
+/*
+ * ADD
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarryADD,
+ *               setVFlag, OverflowADD
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   lc = @c;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = (@b + @c);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarryADD (@a, lb, lc));
+ *           setVFlag (OverflowADD (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ADD(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_add_i32(a, b, c);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarryADD(temp_5, a, lb, lc);
+        tcg_gen_mov_i32(temp_4, temp_5);
+        setCFlag(temp_4);
+        OverflowADD(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setVFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * ADD1
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarryADD,
+ *               setVFlag, OverflowADD
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   lc = @c;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = (@b + (@c << 1));
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarryADD (@a, lb, lc));
+ *           setVFlag (OverflowADD (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ADD1(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_shli_i32(temp_4, c, 1);
+    tcg_gen_add_i32(a, b, temp_4);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarryADD(temp_6, a, lb, lc);
+        tcg_gen_mov_i32(temp_5, temp_6);
+        setCFlag(temp_5);
+        OverflowADD(temp_8, a, lb, lc);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setVFlag(temp_7);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * ADD2
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarryADD,
+ *               setVFlag, OverflowADD
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   lc = @c;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = (@b + (@c << 2));
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarryADD (@a, lb, lc));
+ *           setVFlag (OverflowADD (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ADD2(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_shli_i32(temp_4, c, 2);
+    tcg_gen_add_i32(a, b, temp_4);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarryADD(temp_6, a, lb, lc);
+        tcg_gen_mov_i32(temp_5, temp_6);
+        setCFlag(temp_5);
+        OverflowADD(temp_8, a, lb, lc);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setVFlag(temp_7);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * ADD3
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarryADD,
+ *               setVFlag, OverflowADD
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   lc = @c;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = (@b + (@c << 3));
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarryADD (@a, lb, lc));
+ *           setVFlag (OverflowADD (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ADD3(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_shli_i32(temp_4, c, 3);
+    tcg_gen_add_i32(a, b, temp_4);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarryADD(temp_6, a, lb, lc);
+        tcg_gen_mov_i32(temp_5, temp_6);
+        setCFlag(temp_5);
+        OverflowADD(temp_8, a, lb, lc);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setVFlag(temp_7);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * ADC
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getCFlag, getFFlag, setZFlag, setNFlag, setCFlag,
+ *               CarryADD, setVFlag, OverflowADD
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   lc = @c;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = ((@b + @c) + getCFlag ());
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarryADD (@a, lb, lc));
+ *           setVFlag (OverflowADD (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ADC(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_add_i32(temp_4, b, c);
+    getCFlag(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_add_i32(a, temp_4, temp_5);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarryADD(temp_8, a, lb, lc);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setCFlag(temp_7);
+        OverflowADD(temp_10, a, lb, lc);
+        tcg_gen_mov_i32(temp_9, temp_10);
+        setVFlag(temp_9);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+
+    return ret;
+}
+
+
+/*
+ * SBC
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getCFlag, getFFlag, setZFlag, setNFlag, setCFlag,
+ *               CarryADD, setVFlag, OverflowADD
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   lc = @c;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = ((@b - @c) - getCFlag ());
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarryADD (@a, lb, lc));
+ *           setVFlag (OverflowADD (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SBC(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_sub_i32(temp_4, b, c);
+    getCFlag(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_sub_i32(a, temp_4, temp_5);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarryADD(temp_8, a, lb, lc);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setCFlag(temp_7);
+        OverflowADD(temp_10, a, lb, lc);
+        tcg_gen_mov_i32(temp_9, temp_10);
+        setVFlag(temp_9);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+
+    return ret;
+}
+
+
+/*
+ * NEG
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       @a = (0 - @b);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarrySUB (@a, 0, lb));
+ *           setVFlag (OverflowSUB (@a, 0, lb));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_NEG(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_subfi_i32(a, 0, b);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        tcg_gen_movi_i32(temp_6, 0);
+        CarrySUB(temp_5, a, temp_6, lb);
+        tcg_gen_mov_i32(temp_4, temp_5);
+        setCFlag(temp_4);
+        tcg_gen_movi_i32(temp_9, 0);
+        OverflowSUB(temp_8, a, temp_9, lb);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setVFlag(temp_7);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * SUB
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       @a = (@b - @c);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarrySUB (@a, lb, lc));
+ *           setVFlag (OverflowSUB (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SUB(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_sub_i32(a, b, c);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarrySUB(temp_5, a, lb, lc);
+        tcg_gen_mov_i32(temp_4, temp_5);
+        setCFlag(temp_4);
+        OverflowSUB(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setVFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * SUB1
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = (@c << 1);
+ *       @a = (@b - lc);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarrySUB (@a, lb, lc));
+ *           setVFlag (OverflowSUB (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SUB1(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_shli_i32(lc, c, 1);
+    tcg_gen_sub_i32(a, b, lc);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarrySUB(temp_5, a, lb, lc);
+        tcg_gen_mov_i32(temp_4, temp_5);
+        setCFlag(temp_4);
+        OverflowSUB(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setVFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * SUB2
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = (@c << 2);
+ *       @a = (@b - lc);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarrySUB (@a, lb, lc));
+ *           setVFlag (OverflowSUB (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SUB2(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_shli_i32(lc, c, 2);
+    tcg_gen_sub_i32(a, b, lc);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarrySUB(temp_5, a, lb, lc);
+        tcg_gen_mov_i32(temp_4, temp_5);
+        setCFlag(temp_4);
+        OverflowSUB(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setVFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * SUB3
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = (@c << 3);
+ *       @a = (@b - lc);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setCFlag (CarrySUB (@a, lb, lc));
+ *           setVFlag (OverflowSUB (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SUB3(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_shli_i32(lc, c, 3);
+    tcg_gen_sub_i32(a, b, lc);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        CarrySUB(temp_5, a, lb, lc);
+        tcg_gen_mov_i32(temp_4, temp_5);
+        setCFlag(temp_4);
+        OverflowSUB(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setVFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * MAX
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       alu = (lb - lc);
+ *       if((lc >= lb))
+ *         {
+ *           @a = lc;
+ *         }
+ *       else
+ *         {
+ *           @a = lb;
+ *         };
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (alu);
+ *           setNFlag (alu);
+ *           setCFlag (CarrySUB (@a, lb, lc));
+ *           setVFlag (OverflowSUB (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MAX(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv alu = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_sub_i32(alu, lb, lc);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GE, temp_3, lc, lb);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_mov_i32(a, lc);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_mov_i32(a, lb);
+    gen_set_label(done_2);
+    if ((getFFlag () == true)) {
+        setZFlag(alu);
+        setNFlag(alu);
+        CarrySUB(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setCFlag(temp_6);
+        OverflowSUB(temp_9, a, lb, lc);
+        tcg_gen_mov_i32(temp_8, temp_9);
+        setVFlag(temp_8);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lc);
+    tcg_temp_free(alu);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+
+    return ret;
+}
+
+
+/*
+ * MIN
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, CarrySUB,
+ *               setVFlag, OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   lb = @b;
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = @c;
+ *       alu = (lb - lc);
+ *       if((lc <= lb))
+ *         {
+ *           @a = lc;
+ *         }
+ *       else
+ *         {
+ *           @a = lb;
+ *         };
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (alu);
+ *           setNFlag (alu);
+ *           setCFlag (CarrySUB (@a, lb, lc));
+ *           setVFlag (OverflowSUB (@a, lb, lc));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MIN(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv alu = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    tcg_gen_mov_i32(lb, b);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_mov_i32(lc, c);
+    tcg_gen_sub_i32(alu, lb, lc);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LE, temp_3, lc, lb);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_mov_i32(a, lc);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_mov_i32(a, lb);
+    gen_set_label(done_2);
+    if ((getFFlag () == true)) {
+        setZFlag(alu);
+        setNFlag(alu);
+        CarrySUB(temp_7, a, lb, lc);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setCFlag(temp_6);
+        OverflowSUB(temp_9, a, lb, lc);
+        tcg_gen_mov_i32(temp_8, temp_9);
+        setVFlag(temp_8);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lc);
+    tcg_temp_free(alu);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+
+    return ret;
+}
+
+
+/*
+ * CMP
+ *    Variables: @b, @c
+ *    Functions: getCCFlag, setZFlag, setNFlag, setCFlag, CarrySUB, setVFlag,
+ *               OverflowSUB
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       alu = (@b - @c);
+ *       setZFlag (alu);
+ *       setNFlag (alu);
+ *       setCFlag (CarrySUB (alu, @b, @c));
+ *       setVFlag (OverflowSUB (alu, @b, @c));
+ *     };
+ * }
+ */
+
+int
+arc_gen_CMP(DisasCtxt *ctx, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv alu = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_sub_i32(alu, b, c);
+    setZFlag(alu);
+    setNFlag(alu);
+    CarrySUB(temp_5, alu, b, c);
+    tcg_gen_mov_i32(temp_4, temp_5);
+    setCFlag(temp_4);
+    OverflowSUB(temp_7, alu, b, c);
+    tcg_gen_mov_i32(temp_6, temp_7);
+    setVFlag(temp_6);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(alu);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * AND
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = (@b & @c);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_AND(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_and_i32(la, b, c);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * OR
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = (@b | @c);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_OR(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_or_i32(la, b, c);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * XOR
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = (@b ^ @c);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_XOR(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_xor_i32(la, b, c);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * MOV
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = @b;
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MOV(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(la, b);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * ASL
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setCFlag, getBit,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = (@c & 31);
+ *       la = (lb << lc);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *           if((lc == 0))
+ *             {
+ *               setCFlag (0);
+ *             }
+ *           else
+ *             {
+ *               setCFlag (getBit (lb, (32 - lc)));
+ *             };
+ *           if((@c == 268435457))
+ *             {
+ *               t1 = getBit (la, 31);
+ *               t2 = getBit (lb, 31);
+ *               if((t1 == t2))
+ *                 {
+ *                   setVFlag (0);
+ *                 }
+ *               else
+ *                 {
+ *                   setVFlag (1);
+ *                 };
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ASL(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_15 = tcg_temp_local_new_i32();
+    TCGv temp_14 = tcg_temp_local_new_i32();
+    TCGv t1 = tcg_temp_local_new_i32();
+    TCGv temp_17 = tcg_temp_local_new_i32();
+    TCGv temp_16 = tcg_temp_local_new_i32();
+    TCGv t2 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_18 = tcg_temp_local_new_i32();
+    TCGv temp_19 = tcg_temp_local_new_i32();
+    getCCFlag(temp_9);
+    tcg_gen_mov_i32(cc_flag, temp_9);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_andi_i32(lc, c, 31);
+    tcg_gen_shl_i32(la, lb, lc);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+        TCGLabel *else_2 = gen_new_label();
+        TCGLabel *done_2 = gen_new_label();
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, lc, 0);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+        tcg_gen_movi_i32(temp_10, 0);
+        setCFlag(temp_10);
+        tcg_gen_br(done_2);
+        gen_set_label(else_2);
+        tcg_gen_subfi_i32(temp_13, 32, lc);
+        getBit(temp_12, lb, temp_13);
+        tcg_gen_mov_i32(temp_11, temp_12);
+        setCFlag(temp_11);
+        gen_set_label(done_2);
+        TCGLabel *done_3 = gen_new_label();
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp_5, c, 268435457);
+        tcg_gen_xori_i32(temp_6, temp_5, 1);
+        tcg_gen_andi_i32(temp_6, temp_6, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, done_3);
+        tcg_gen_movi_i32(temp_15, 31);
+        getBit(temp_14, la, temp_15);
+        tcg_gen_mov_i32(t1, temp_14);
+        tcg_gen_movi_i32(temp_17, 31);
+        getBit(temp_16, lb, temp_17);
+        tcg_gen_mov_i32(t2, temp_16);
+        TCGLabel *else_4 = gen_new_label();
+        TCGLabel *done_4 = gen_new_label();
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp_7, t1, t2);
+        tcg_gen_xori_i32(temp_8, temp_7, 1);
+        tcg_gen_andi_i32(temp_8, temp_8, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_8, arc_true, else_4);
+        tcg_gen_movi_i32(temp_18, 0);
+        setVFlag(temp_18);
+        tcg_gen_br(done_4);
+        gen_set_label(else_4);
+        tcg_gen_movi_i32(temp_19, 1);
+        setVFlag(temp_19);
+        gen_set_label(done_4);
+        gen_set_label(done_3);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(la);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_15);
+    tcg_temp_free(temp_14);
+    tcg_temp_free(t1);
+    tcg_temp_free(temp_17);
+    tcg_temp_free(temp_16);
+    tcg_temp_free(t2);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_18);
+    tcg_temp_free(temp_19);
+
+    return ret;
+}
+
+
+/*
+ * ASR
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, arithmeticShiftRight, getFFlag, setZFlag, setNFlag,
+ *               setCFlag, getBit
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = (@c & 31);
+ *       la = arithmeticShiftRight (lb, lc);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *           if((lc == 0))
+ *             {
+ *               setCFlag (0);
+ *             }
+ *           else
+ *             {
+ *               setCFlag (getBit (lb, (lc - 1)));
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ASR(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_andi_i32(lc, c, 31);
+    arithmeticShiftRight(temp_6, lb, lc);
+    tcg_gen_mov_i32(la, temp_6);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+        TCGLabel *else_2 = gen_new_label();
+        TCGLabel *done_2 = gen_new_label();
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, lc, 0);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+        tcg_gen_movi_i32(temp_7, 0);
+        setCFlag(temp_7);
+        tcg_gen_br(done_2);
+        gen_set_label(else_2);
+        tcg_gen_subi_i32(temp_10, lc, 1);
+        getBit(temp_9, lb, temp_10);
+        tcg_gen_mov_i32(temp_8, temp_9);
+        setCFlag(temp_8);
+        gen_set_label(done_2);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(la);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+
+    return ret;
+}
+
+
+/*
+ * ASR8
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, arithmeticShiftRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       la = arithmeticShiftRight (lb, 8);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ASR8(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_movi_i32(temp_5, 8);
+    arithmeticShiftRight(temp_4, lb, temp_5);
+    tcg_gen_mov_i32(la, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * ASR16
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, arithmeticShiftRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       la = arithmeticShiftRight (lb, 16);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ASR16(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_movi_i32(temp_5, 16);
+    arithmeticShiftRight(temp_4, lb, temp_5);
+    tcg_gen_mov_i32(la, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lb);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * LSL16
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, logicalShiftLeft, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = logicalShiftLeft (@b, 16);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_LSL16(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_5, 16);
+    logicalShiftLeft(temp_4, b, temp_5);
+    tcg_gen_mov_i32(la, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * LSL8
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, logicalShiftLeft, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = logicalShiftLeft (@b, 8);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_LSL8(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_5, 8);
+    logicalShiftLeft(temp_4, b, temp_5);
+    tcg_gen_mov_i32(la, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * LSR
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, logicalShiftRight, getFFlag, setZFlag, setNFlag,
+ *               setCFlag, getBit
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lb = @b;
+ *       lc = (@c & 31);
+ *       la = logicalShiftRight (lb, lc);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *           if((lc == 0))
+ *             {
+ *               setCFlag (0);
+ *             }
+ *           else
+ *             {
+ *               setCFlag (getBit (lb, (lc - 1)));
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_LSR(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lb = tcg_temp_local_new_i32();
+    TCGv lc = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lb, b);
+    tcg_gen_andi_i32(lc, c, 31);
+    logicalShiftRight(temp_6, lb, lc);
+    tcg_gen_mov_i32(la, temp_6);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+        TCGLabel *else_2 = gen_new_label();
+        TCGLabel *done_2 = gen_new_label();
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, lc, 0);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+        tcg_gen_movi_i32(temp_7, 0);
+        setCFlag(temp_7);
+        tcg_gen_br(done_2);
+        gen_set_label(else_2);
+        tcg_gen_subi_i32(temp_10, lc, 1);
+        getBit(temp_9, lb, temp_10);
+        tcg_gen_mov_i32(temp_8, temp_9);
+        setCFlag(temp_8);
+        gen_set_label(done_2);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lb);
+    tcg_temp_free(lc);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(la);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+
+    return ret;
+}
+
+
+/*
+ * LSR16
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, logicalShiftRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = logicalShiftRight (@b, 16);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_LSR16(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_5, 16);
+    logicalShiftRight(temp_4, b, temp_5);
+    tcg_gen_mov_i32(la, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * LSR8
+ *    Variables: @b, @a
+ *    Functions: getCCFlag, logicalShiftRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = logicalShiftRight (@b, 8);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_LSR8(DisasCtxt *ctx, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_5, 8);
+    logicalShiftRight(temp_4, b, temp_5);
+    tcg_gen_mov_i32(la, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * BIC
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       la = (@b & ~@c);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BIC(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_not_i32(temp_4, c);
+    tcg_gen_and_i32(la, b, temp_4);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * BCLR
+ *    Variables: @c, @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp = (1 << (@c & 31));
+ *       la = (@b & ~tmp);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BCLR(DisasCtxt *ctx, TCGv c, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(temp_4, c, 31);
+    tcg_gen_shlfi_i32(tmp, 1, temp_4);
+    tcg_gen_not_i32(temp_5, tmp);
+    tcg_gen_and_i32(la, b, temp_5);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * BMSK
+ *    Variables: @c, @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp1 = ((@c & 31) + 1);
+ *       if((tmp1 == 32))
+ *         {
+ *           tmp2 = 4294967295;
+ *         }
+ *       else
+ *         {
+ *           tmp2 = ((1 << tmp1) - 1);
+ *         };
+ *       la = (@b & tmp2);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BMSK(DisasCtxt *ctx, TCGv c, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv tmp1 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp2 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(temp_6, c, 31);
+    tcg_gen_addi_i32(tmp1, temp_6, 1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, tmp1, 32);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_movi_i32(tmp2, 4294967295);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_shlfi_i32(temp_7, 1, tmp1);
+    tcg_gen_subi_i32(tmp2, temp_7, 1);
+    gen_set_label(done_2);
+    tcg_gen_and_i32(la, b, tmp2);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp2);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * BMSKN
+ *    Variables: @c, @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp1 = ((@c & 31) + 1);
+ *       if((tmp1 == 32))
+ *         {
+ *           tmp2 = 4294967295;
+ *         }
+ *       else
+ *         {
+ *           tmp2 = ((1 << tmp1) - 1);
+ *         };
+ *       la = (@b & ~tmp2);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BMSKN(DisasCtxt *ctx, TCGv c, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv tmp1 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp2 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(temp_6, c, 31);
+    tcg_gen_addi_i32(tmp1, temp_6, 1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_3, tmp1, 32);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_movi_i32(tmp2, 4294967295);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_shlfi_i32(temp_7, 1, tmp1);
+    tcg_gen_subi_i32(tmp2, temp_7, 1);
+    gen_set_label(done_2);
+    tcg_gen_not_i32(temp_8, tmp2);
+    tcg_gen_and_i32(la, b, temp_8);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp2);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * BSET
+ *    Variables: @c, @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp = (1 << (@c & 31));
+ *       la = (@b | tmp);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BSET(DisasCtxt *ctx, TCGv c, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(temp_4, c, 31);
+    tcg_gen_shlfi_i32(tmp, 1, temp_4);
+    tcg_gen_or_i32(la, b, tmp);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * BXOR
+ *    Variables: @c, @b, @a
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp = (1 << @c);
+ *       la = (@b ^ tmp);
+ *       @a = la;
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (la);
+ *           setNFlag (la);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BXOR(DisasCtxt *ctx, TCGv c, TCGv b, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    TCGv la = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_shlfi_i32(tmp, 1, c);
+    tcg_gen_xor_i32(la, b, tmp);
+    tcg_gen_mov_i32(a, la);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(la);
+        setNFlag(la);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(tmp);
+    tcg_temp_free(la);
+
+    return ret;
+}
+
+
+/*
+ * ROL
+ *    Variables: @src, @dest
+ *    Functions: getCCFlag, rotateLeft, getFFlag, setZFlag, setNFlag, setCFlag,
+ *               extractBits
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lsrc = @src;
+ *       @dest = rotateLeft (lsrc, 1);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *           setCFlag (extractBits (lsrc, 31, 31));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ROL(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_movi_i32(temp_5, 1);
+    rotateLeft(temp_4, lsrc, temp_5);
+    tcg_gen_mov_i32(dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_movi_i32(temp_9, 31);
+        tcg_gen_movi_i32(temp_8, 31);
+        extractBits(temp_7, lsrc, temp_8, temp_9);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setCFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lsrc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * ROL8
+ *    Variables: @src, @dest
+ *    Functions: getCCFlag, rotateLeft, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lsrc = @src;
+ *       @dest = rotateLeft (lsrc, 8);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ROL8(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_movi_i32(temp_5, 8);
+    rotateLeft(temp_4, lsrc, temp_5);
+    tcg_gen_mov_i32(dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lsrc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * ROR
+ *    Variables: @src, @n, @dest
+ *    Functions: getCCFlag, rotateRight, getFFlag, setZFlag, setNFlag,
+ *               setCFlag, extractBits
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lsrc = @src;
+ *       ln = (@n & 31);
+ *       @dest = rotateRight (lsrc, ln);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *           setCFlag (extractBits (lsrc, (ln - 1), (ln - 1)));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ROR(DisasCtxt *ctx, TCGv src, TCGv n, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv ln = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_andi_i32(ln, n, 31);
+    rotateRight(temp_4, lsrc, ln);
+    tcg_gen_mov_i32(dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_subi_i32(temp_8, ln, 1);
+        tcg_gen_subi_i32(temp_7, ln, 1);
+        extractBits(temp_6, lsrc, temp_7, temp_8);
+        tcg_gen_mov_i32(temp_5, temp_6);
+        setCFlag(temp_5);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lsrc);
+    tcg_temp_free(ln);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+
+    return ret;
+}
+
+
+/*
+ * ROR8
+ *    Variables: @src, @dest
+ *    Functions: getCCFlag, rotateRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lsrc = @src;
+ *       @dest = rotateRight (lsrc, 8);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_ROR8(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_movi_i32(temp_5, 8);
+    rotateRight(temp_4, lsrc, temp_5);
+    tcg_gen_mov_i32(dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lsrc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * RLC
+ *    Variables: @src, @dest
+ *    Functions: getCCFlag, getCFlag, getFFlag, setZFlag, setNFlag, setCFlag,
+ *               extractBits
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lsrc = @src;
+ *       @dest = (lsrc << 1);
+ *       @dest = (@dest | getCFlag ());
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *           setCFlag (extractBits (lsrc, 31, 31));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_RLC(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_shli_i32(dest, lsrc, 1);
+    getCFlag(temp_5);
+    tcg_gen_mov_i32(temp_4, temp_5);
+    tcg_gen_or_i32(dest, dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_movi_i32(temp_9, 31);
+        tcg_gen_movi_i32(temp_8, 31);
+        extractBits(temp_7, lsrc, temp_8, temp_9);
+        tcg_gen_mov_i32(temp_6, temp_7);
+        setCFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lsrc);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * RRC
+ *    Variables: @src, @dest
+ *    Functions: getCCFlag, getCFlag, getFFlag, setZFlag, setNFlag, setCFlag,
+ *               extractBits
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       lsrc = @src;
+ *       @dest = (lsrc >> 1);
+ *       @dest = (@dest | (getCFlag () << 31));
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *           setCFlag (extractBits (lsrc, 0, 0));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_RRC(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_shri_i32(dest, lsrc, 1);
+    getCFlag(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_shli_i32(temp_4, temp_5, 31);
+    tcg_gen_or_i32(dest, dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_movi_i32(temp_10, 0);
+        tcg_gen_movi_i32(temp_9, 0);
+        extractBits(temp_8, lsrc, temp_9, temp_10);
+        tcg_gen_mov_i32(temp_7, temp_8);
+        setCFlag(temp_7);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(lsrc);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * SEXB
+ *    Variables: @dest, @src
+ *    Functions: getCCFlag, arithmeticShiftRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @dest = arithmeticShiftRight ((@src << 24), 24);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SEXB(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_6, 24);
+    tcg_gen_shli_i32(temp_5, src, 24);
+    arithmeticShiftRight(temp_4, temp_5, temp_6);
+    tcg_gen_mov_i32(dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * SEXH
+ *    Variables: @dest, @src
+ *    Functions: getCCFlag, arithmeticShiftRight, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @dest = arithmeticShiftRight ((@src << 16), 16);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SEXH(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_6, 16);
+    tcg_gen_shli_i32(temp_5, src, 16);
+    arithmeticShiftRight(temp_4, temp_5, temp_6);
+    tcg_gen_mov_i32(dest, temp_4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * EXTB
+ *    Variables: @dest, @src
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @dest = (@src & 255);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_EXTB(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(dest, src, 255);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * EXTH
+ *    Variables: @dest, @src
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @dest = (@src & 65535);
+ *       f_flag = getFFlag ();
+ *       if((f_flag == true))
+ *         {
+ *           setZFlag (@dest);
+ *           setNFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_EXTH(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    int f_flag;
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(dest, src, 65535);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * BTST
+ *    Variables: @c, @b
+ *    Functions: getCCFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp = (1 << (@c & 31));
+ *       alu = (@b & tmp);
+ *       setZFlag (alu);
+ *       setNFlag (alu);
+ *     };
+ * }
+ */
+
+int
+arc_gen_BTST(DisasCtxt *ctx, TCGv c, TCGv b)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    TCGv alu = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(temp_4, c, 31);
+    tcg_gen_shlfi_i32(tmp, 1, temp_4);
+    tcg_gen_and_i32(alu, b, tmp);
+    setZFlag(alu);
+    setNFlag(alu);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp);
+    tcg_temp_free(alu);
+
+    return ret;
+}
+
+
+/*
+ * TST
+ *    Variables: @b, @c
+ *    Functions: getCCFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       alu = (@b & @c);
+ *       setZFlag (alu);
+ *       setNFlag (alu);
+ *     };
+ * }
+ */
+
+int
+arc_gen_TST(DisasCtxt *ctx, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv alu = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_and_i32(alu, b, c);
+    setZFlag(alu);
+    setNFlag(alu);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(alu);
+
+    return ret;
+}
+
+
+/*
+ * XBFU
+ *    Variables: @src2, @src1, @dest
+ *    Functions: getCCFlag, extractBits, getFFlag, setZFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       N = extractBits (@src2, 4, 0);
+ *       M = (extractBits (@src2, 9, 5) + 1);
+ *       tmp1 = (@src1 >> N);
+ *       tmp2 = ((1 << M) - 1);
+ *       @dest = (tmp1 & tmp2);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@dest);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_XBFU(DisasCtxt *ctx, TCGv src2, TCGv src1, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv N = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv M = tcg_temp_local_new_i32();
+    TCGv tmp1 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv tmp2 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_6, 0);
+    tcg_gen_movi_i32(temp_5, 4);
+    extractBits(temp_4, src2, temp_5, temp_6);
+    tcg_gen_mov_i32(N, temp_4);
+    tcg_gen_movi_i32(temp_10, 5);
+    tcg_gen_movi_i32(temp_9, 9);
+    extractBits(temp_8, src2, temp_9, temp_10);
+    tcg_gen_mov_i32(temp_7, temp_8);
+    tcg_gen_addi_i32(M, temp_7, 1);
+    tcg_gen_shr_i32(tmp1, src1, N);
+    tcg_gen_shlfi_i32(temp_11, 1, M);
+    tcg_gen_subi_i32(tmp2, temp_11, 1);
+    tcg_gen_and_i32(dest, tmp1, tmp2);
+    if ((getFFlag () == true)) {
+        setZFlag(dest);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(N);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(M);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(tmp2);
+
+    return ret;
+}
+
+
+/*
+ * AEX
+ *    Variables: @src2, @b
+ *    Functions: getCCFlag, readAuxReg, writeAuxReg
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       tmp = readAuxReg (@src2);
+ *       writeAuxReg (@src2, @b);
+ *       @b = tmp;
+ *     };
+ * }
+ */
+
+int
+arc_gen_AEX(DisasCtxt *ctx, TCGv src2, TCGv b)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    readAuxReg(temp_4, src2);
+    tcg_gen_mov_i32(tmp, temp_4);
+    writeAuxReg(src2, b);
+    tcg_gen_mov_i32(b, tmp);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp);
+
+    return ret;
+}
+
+
+/*
+ * LR
+ *    Variables: @dest, @src
+ *    Functions: readAuxReg
+ * --- code ---
+ * {
+ *   @dest = readAuxReg (@src);
+ * }
+ */
+
+int
+arc_gen_LR(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    readAuxReg(temp_1, src);
+    tcg_gen_mov_i32(dest, temp_1);
+    tcg_temp_free(temp_1);
+
+    return ret;
+}
+
+
+/*
+ * SR
+ *    Variables: @src2, @src1
+ *    Functions: writeAuxReg
+ * --- code ---
+ * {
+ *   writeAuxReg (@src2, @src1);
+ * }
+ */
+
+int
+arc_gen_SR(DisasCtxt *ctx, TCGv src2, TCGv src1)
+{
+    int ret = DISAS_NEXT;
+
+    writeAuxReg(src2, src1);
+    return ret;
+}
+
+
+/*
+ * SYNC
+ *    Variables:
+ *    Functions: syncReturnDisasUpdate
+ * --- code ---
+ * {
+ *   syncReturnDisasUpdate ();
+ * }
+ */
+
+int
+arc_gen_SYNC(DisasCtxt *ctx)
+{
+    int ret = DISAS_NEXT;
+
+    syncReturnDisasUpdate();
+    return ret;
+}
+
+
+/*
+ * CLRI
+ *    Variables: @c
+ *    Functions: getRegister, setRegister
+ * --- code ---
+ * {
+ *   status32 = getRegister (R_STATUS32);
+ *   ie = (status32 & 2147483648);
+ *   ie = (ie >> 27);
+ *   e = ((status32 & 30) >> 1);
+ *   a = 32;
+ *   @c = ((ie | e) | a);
+ *   mask = 2147483648;
+ *   mask = ~mask;
+ *   status32 = (status32 & mask);
+ *   setRegister (R_STATUS32, status32);
+ * }
+ */
+
+int
+arc_gen_CLRI(DisasCtxt *ctx, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv status32 = tcg_temp_local_new_i32();
+    TCGv ie = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv e = tcg_temp_local_new_i32();
+    TCGv a = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv mask = tcg_temp_local_new_i32();
+    getRegister(temp_1, R_STATUS32);
+    tcg_gen_mov_i32(status32, temp_1);
+    tcg_gen_andi_i32(ie, status32, 2147483648);
+    tcg_gen_shri_i32(ie, ie, 27);
+    tcg_gen_andi_i32(temp_2, status32, 30);
+    tcg_gen_shri_i32(e, temp_2, 1);
+    tcg_gen_movi_i32(a, 32);
+    tcg_gen_or_i32(temp_3, ie, e);
+    tcg_gen_or_i32(c, temp_3, a);
+    tcg_gen_movi_i32(mask, 2147483648);
+    tcg_gen_not_i32(mask, mask);
+    tcg_gen_and_i32(status32, status32, mask);
+    setRegister(R_STATUS32, status32);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(status32);
+    tcg_temp_free(ie);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(e);
+    tcg_temp_free(a);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(mask);
+
+    return ret;
+}
+
+
+/*
+ * SETI
+ *    Variables: @c
+ *    Functions: getRegister, setRegister
+ * --- code ---
+ * {
+ *   status32 = getRegister (R_STATUS32);
+ *   e_mask = 30;
+ *   e_mask = ~e_mask;
+ *   e_value = ((@c & 15) << 1);
+ *   temp1 = (@c & 32);
+ *   if((temp1 != 0))
+ *     {
+ *       status32 = ((status32 & e_mask) | e_value);
+ *       ie_mask = 2147483648;
+ *       ie_mask = ~ie_mask;
+ *       ie_value = ((@c & 16) << 27);
+ *       status32 = ((status32 & ie_mask) | ie_value);
+ *     }
+ *   else
+ *     {
+ *       status32 = (status32 | 2147483648);
+ *       temp2 = (@c & 16);
+ *       if((temp2 != 0))
+ *         {
+ *           status32 = ((status32 & e_mask) | e_value);
+ *         };
+ *     };
+ *   setRegister (R_STATUS32, status32);
+ * }
+ */
+
+int
+arc_gen_SETI(DisasCtxt *ctx, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv status32 = tcg_temp_local_new_i32();
+    TCGv e_mask = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv e_value = tcg_temp_local_new_i32();
+    TCGv temp1 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv ie_mask = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv ie_value = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    getRegister(temp_5, R_STATUS32);
+    tcg_gen_mov_i32(status32, temp_5);
+    tcg_gen_movi_i32(e_mask, 30);
+    tcg_gen_not_i32(e_mask, e_mask);
+    tcg_gen_andi_i32(temp_6, c, 15);
+    tcg_gen_shli_i32(e_value, temp_6, 1);
+    tcg_gen_andi_i32(temp1, c, 32);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_1, temp1, 0);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    tcg_gen_and_i32(temp_7, status32, e_mask);
+    tcg_gen_or_i32(status32, temp_7, e_value);
+    tcg_gen_movi_i32(ie_mask, 2147483648);
+    tcg_gen_not_i32(ie_mask, ie_mask);
+    tcg_gen_andi_i32(temp_8, c, 16);
+    tcg_gen_shli_i32(ie_value, temp_8, 27);
+    tcg_gen_and_i32(temp_9, status32, ie_mask);
+    tcg_gen_or_i32(status32, temp_9, ie_value);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    tcg_gen_ori_i32(status32, status32, 2147483648);
+    tcg_gen_andi_i32(temp2, c, 16);
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_3, temp2, 0);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+    tcg_gen_and_i32(temp_10, status32, e_mask);
+    tcg_gen_or_i32(status32, temp_10, e_value);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    setRegister(R_STATUS32, status32);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(status32);
+    tcg_temp_free(e_mask);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(e_value);
+    tcg_temp_free(temp1);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(ie_mask);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(ie_value);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_10);
+
+    return ret;
+}
+
+
+/*
+ * NOP
+ *    Variables:
+ *    Functions: doNothing
+ * --- code ---
+ * {
+ *   doNothing ();
+ * }
+ */
+
+int
+arc_gen_NOP(DisasCtxt *ctx)
+{
+    int ret = DISAS_NEXT;
+
+    return ret;
+}
+
+
+/*
+ * PREALLOC
+ *    Variables:
+ *    Functions: doNothing
+ * --- code ---
+ * {
+ *   doNothing ();
+ * }
+ */
+
+int
+arc_gen_PREALLOC(DisasCtxt *ctx)
+{
+    int ret = DISAS_NEXT;
+
+    return ret;
+}
+
+
+/*
+ * PREFETCH
+ *    Variables: @src1, @src2
+ *    Functions: getAAFlag, doNothing
+ * --- code ---
+ * {
+ *   AA = getAAFlag ();
+ *   if(((AA == 1) || (AA == 2)))
+ *     {
+ *       @src1 = (@src1 + @src2);
+ *     }
+ *   else
+ *     {
+ *       doNothing ();
+ *     };
+ * }
+ */
+
+int
+arc_gen_PREFETCH(DisasCtxt *ctx, TCGv src1, TCGv src2)
+{
+    int ret = DISAS_NEXT;
+    int AA;
+    AA = getAAFlag ();
+    if (((AA == 1) || (AA == 2))) {
+        tcg_gen_add_i32(src1, src1, src2);
+    } else {
+        doNothing();
+    }
+
+
+    return ret;
+}
+
+
+/*
+ * MPY
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, HELPER, setZFlag, setNFlag, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       _b = @b;
+ *       _c = @c;
+ *       @a = ((_b * _c) & 4294967295);
+ *       if((getFFlag () == true))
+ *         {
+ *           high_part = HELPER (mpym, _b, _c);
+ *           tmp1 = (high_part & 2147483648);
+ *           tmp2 = (@a & 2147483648);
+ *           setZFlag (@a);
+ *           setNFlag (high_part);
+ *           setVFlag ((tmp1 != tmp2));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MPY(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv _b = tcg_temp_local_new_i32();
+    TCGv _c = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv high_part = tcg_temp_local_new_i32();
+    TCGv tmp1 = tcg_temp_local_new_i32();
+    TCGv tmp2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(_b, b);
+    tcg_gen_mov_i32(_c, c);
+    tcg_gen_mul_i32(temp_4, _b, _c);
+    tcg_gen_andi_i32(a, temp_4, 4294967295);
+    if ((getFFlag () == true)) {
+        ARC_HELPER(mpym, high_part, _b, _c);
+        tcg_gen_andi_i32(tmp1, high_part, 2147483648);
+        tcg_gen_andi_i32(tmp2, a, 2147483648);
+        setZFlag(a);
+        setNFlag(high_part);
+        tcg_gen_setcond_i32(TCG_COND_NE, temp_5, tmp1, tmp2);
+        setVFlag(temp_5);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(_b);
+    tcg_temp_free(_c);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(high_part);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(tmp2);
+    tcg_temp_free(temp_5);
+
+    return ret;
+}
+
+
+/*
+ * MPYMU
+ *    Variables: @a, @b, @c
+ *    Functions: getCCFlag, HELPER, getFFlag, setZFlag, setNFlag, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @a = HELPER (mpymu, @b, @c);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (0);
+ *           setVFlag (0);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MPYMU(DisasCtxt *ctx, TCGv a, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    ARC_HELPER(mpymu, a, b, c);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        tcg_gen_movi_i32(temp_4, 0);
+        setNFlag(temp_4);
+        tcg_gen_movi_i32(temp_5, 0);
+        setVFlag(temp_5);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+
+    return ret;
+}
+
+
+/*
+ * MPYM
+ *    Variables: @a, @b, @c
+ *    Functions: getCCFlag, HELPER, getFFlag, setZFlag, setNFlag, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @a = HELPER (mpym, @b, @c);
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setVFlag (0);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MPYM(DisasCtxt *ctx, TCGv a, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    ARC_HELPER(mpym, a, b, c);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        tcg_gen_movi_i32(temp_4, 0);
+        setVFlag(temp_4);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * MPYU
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getFFlag, HELPER, setZFlag, setNFlag, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       _b = @b;
+ *       _c = @c;
+ *       @a = ((_b * _c) & 4294967295);
+ *       if((getFFlag () == true))
+ *         {
+ *           high_part = HELPER (mpym, _b, _c);
+ *           setZFlag (@a);
+ *           setNFlag (0);
+ *           setVFlag ((high_part > 0));
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MPYU(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv _b = tcg_temp_local_new_i32();
+    TCGv _c = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv high_part = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(_b, b);
+    tcg_gen_mov_i32(_c, c);
+    tcg_gen_mul_i32(temp_4, _b, _c);
+    tcg_gen_andi_i32(a, temp_4, 4294967295);
+    if ((getFFlag () == true)) {
+        ARC_HELPER(mpym, high_part, _b, _c);
+        setZFlag(a);
+        tcg_gen_movi_i32(temp_5, 0);
+        setNFlag(temp_5);
+        tcg_gen_setcondi_i32(TCG_COND_GT, temp_6, high_part, 0);
+        setVFlag(temp_6);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(_b);
+    tcg_temp_free(_c);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(high_part);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * MPYUW
+ *    Variables: @a, @b, @c
+ *    Functions: getCCFlag, getFFlag, setZFlag, setNFlag, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @a = ((@b & 65535) * (@c & 65535));
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (0);
+ *           setVFlag (0);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MPYUW(DisasCtxt *ctx, TCGv a, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_andi_i32(temp_5, c, 65535);
+    tcg_gen_andi_i32(temp_4, b, 65535);
+    tcg_gen_mul_i32(a, temp_4, temp_5);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        tcg_gen_movi_i32(temp_6, 0);
+        setNFlag(temp_6);
+        tcg_gen_movi_i32(temp_7, 0);
+        setVFlag(temp_7);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * MPYW
+ *    Variables: @a, @b, @c
+ *    Functions: getCCFlag, arithmeticShiftRight, getFFlag, setZFlag, setNFlag,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       @a = (arithmeticShiftRight ((@b << 16), 16)
+ *            * arithmeticShiftRight ((@c << 16), 16));
+ *       if((getFFlag () == true))
+ *         {
+ *           setZFlag (@a);
+ *           setNFlag (@a);
+ *           setVFlag (0);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MPYW(DisasCtxt *ctx, TCGv a, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    getCCFlag(temp_3);
+    tcg_gen_mov_i32(cc_flag, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_movi_i32(temp_11, 16);
+    tcg_gen_shli_i32(temp_10, c, 16);
+    tcg_gen_movi_i32(temp_7, 16);
+    tcg_gen_shli_i32(temp_6, b, 16);
+    arithmeticShiftRight(temp_5, temp_6, temp_7);
+    tcg_gen_mov_i32(temp_4, temp_5);
+    arithmeticShiftRight(temp_9, temp_10, temp_11);
+    tcg_gen_mov_i32(temp_8, temp_9);
+    tcg_gen_mul_i32(a, temp_4, temp_8);
+    if ((getFFlag () == true)) {
+        setZFlag(a);
+        setNFlag(a);
+        tcg_gen_movi_i32(temp_12, 0);
+        setVFlag(temp_12);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_12);
+
+    return ret;
+}
+
+
+/*
+ * DIV
+ *    Variables: @src2, @src1, @dest
+ *    Functions: getCCFlag, divSigned, getFFlag, setZFlag, setNFlag, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       if(((@src2 != 0) && ((@src1 != 2147483648) || (@src2 != 4294967295))))
+ *         {
+ *           @dest = divSigned (@src1, @src2);
+ *           if((getFFlag () == true))
+ *             {
+ *               setZFlag (@dest);
+ *               setNFlag (@dest);
+ *               setVFlag (0);
+ *             };
+ *         }
+ *       else
+ *         {
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_DIV(DisasCtxt *ctx, TCGv src2, TCGv src1, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    getCCFlag(temp_9);
+    tcg_gen_mov_i32(cc_flag, temp_9);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_3, src2, 0);
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_4, src1, 2147483648);
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_5, src2, 4294967295);
+    tcg_gen_or_i32(temp_6, temp_4, temp_5);
+    tcg_gen_and_i32(temp_7, temp_3, temp_6);
+    tcg_gen_xori_i32(temp_8, temp_7, 1);
+    tcg_gen_andi_i32(temp_8, temp_8, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_8, arc_true, else_2);
+    divSigned(temp_10, src1, src2);
+    tcg_gen_mov_i32(dest, temp_10);
+    if ((getFFlag () == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_movi_i32(temp_11, 0);
+        setVFlag(temp_11);
+    }
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_11);
+
+    return ret;
+}
+
+
+/*
+ * DIVU
+ *    Variables: @src2, @dest, @src1
+ *    Functions: getCCFlag, divUnsigned, getFFlag, setZFlag, setNFlag,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       if((@src2 != 0))
+ *         {
+ *           @dest = divUnsigned (@src1, @src2);
+ *           if((getFFlag () == true))
+ *             {
+ *               setZFlag (@dest);
+ *               setNFlag (0);
+ *               setVFlag (0);
+ *             };
+ *         }
+ *       else
+ *         {
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_DIVU(DisasCtxt *ctx, TCGv src2, TCGv dest, TCGv src1)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_3, src2, 0);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    divUnsigned(temp_6, src1, src2);
+    tcg_gen_mov_i32(dest, temp_6);
+    if ((getFFlag () == true)) {
+        setZFlag(dest);
+        tcg_gen_movi_i32(temp_7, 0);
+        setNFlag(temp_7);
+        tcg_gen_movi_i32(temp_8, 0);
+        setVFlag(temp_8);
+    }
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+
+    return ret;
+}
+
+
+/*
+ * REM
+ *    Variables: @src2, @src1, @dest
+ *    Functions: getCCFlag, divRemainingSigned, getFFlag, setZFlag, setNFlag,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       if(((@src2 != 0) && ((@src1 != 2147483648) || (@src2 != 4294967295))))
+ *         {
+ *           @dest = divRemainingSigned (@src1, @src2);
+ *           if((getFFlag () == true))
+ *             {
+ *               setZFlag (@dest);
+ *               setNFlag (@dest);
+ *               setVFlag (0);
+ *             };
+ *         }
+ *       else
+ *         {
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_REM(DisasCtxt *ctx, TCGv src2, TCGv src1, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    getCCFlag(temp_9);
+    tcg_gen_mov_i32(cc_flag, temp_9);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_3, src2, 0);
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_4, src1, 2147483648);
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_5, src2, 4294967295);
+    tcg_gen_or_i32(temp_6, temp_4, temp_5);
+    tcg_gen_and_i32(temp_7, temp_3, temp_6);
+    tcg_gen_xori_i32(temp_8, temp_7, 1);
+    tcg_gen_andi_i32(temp_8, temp_8, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_8, arc_true, else_2);
+    divRemainingSigned(temp_10, src1, src2);
+    tcg_gen_mov_i32(dest, temp_10);
+    if ((getFFlag () == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_movi_i32(temp_11, 0);
+        setVFlag(temp_11);
+    }
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_11);
+
+    return ret;
+}
+
+
+/*
+ * REMU
+ *    Variables: @src2, @dest, @src1
+ *    Functions: getCCFlag, divRemainingUnsigned, getFFlag, setZFlag, setNFlag,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       if((@src2 != 0))
+ *         {
+ *           @dest = divRemainingUnsigned (@src1, @src2);
+ *           if((getFFlag () == true))
+ *             {
+ *               setZFlag (@dest);
+ *               setNFlag (0);
+ *               setVFlag (0);
+ *             };
+ *         }
+ *       else
+ *         {
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_REMU(DisasCtxt *ctx, TCGv src2, TCGv dest, TCGv src1)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_3, src2, 0);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    divRemainingUnsigned(temp_6, src1, src2);
+    tcg_gen_mov_i32(dest, temp_6);
+    if ((getFFlag () == true)) {
+        setZFlag(dest);
+        tcg_gen_movi_i32(temp_7, 0);
+        setNFlag(temp_7);
+        tcg_gen_movi_i32(temp_8, 0);
+        setVFlag(temp_8);
+    }
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+
+    return ret;
+}
+
+
+/*
+ * MAC
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getRegister, MAC, getFFlag, setNFlag, OverflowADD,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       old_acchi = getRegister (R_ACCHI);
+ *       high_mul = MAC (@b, @c);
+ *       @a = getRegister (R_ACCLO);
+ *       if((getFFlag () == true))
+ *         {
+ *           new_acchi = getRegister (R_ACCHI);
+ *           setNFlag (new_acchi);
+ *           if((OverflowADD (new_acchi, old_acchi, high_mul) == true))
+ *             {
+ *               setVFlag (1);
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MAC(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv old_acchi = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv high_mul = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv new_acchi = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    getRegister(temp_6, R_ACCHI);
+    tcg_gen_mov_i32(old_acchi, temp_6);
+    MAC(temp_7, b, c);
+    tcg_gen_mov_i32(high_mul, temp_7);
+    getRegister(temp_8, R_ACCLO);
+    tcg_gen_mov_i32(a, temp_8);
+    if ((getFFlag () == true)) {
+        getRegister(temp_9, R_ACCHI);
+        tcg_gen_mov_i32(new_acchi, temp_9);
+        setNFlag(new_acchi);
+        TCGLabel *done_2 = gen_new_label();
+        OverflowADD(temp_10, new_acchi, old_acchi, high_mul);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, temp_10, arc_true);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+        tcg_gen_movi_i32(temp_11, 1);
+        setVFlag(temp_11);
+        gen_set_label(done_2);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(old_acchi);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(high_mul);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(new_acchi);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_11);
+
+    return ret;
+}
+
+
+/*
+ * MACU
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getRegister, MACU, getFFlag, CarryADD, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       old_acchi = getRegister (R_ACCHI);
+ *       high_mul = MACU (@b, @c);
+ *       @a = getRegister (R_ACCLO);
+ *       if((getFFlag () == true))
+ *         {
+ *           new_acchi = getRegister (R_ACCHI);
+ *           if((CarryADD (new_acchi, old_acchi, high_mul) == true))
+ *             {
+ *               setVFlag (1);
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MACU(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv old_acchi = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv high_mul = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv new_acchi = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    getRegister(temp_6, R_ACCHI);
+    tcg_gen_mov_i32(old_acchi, temp_6);
+    MACU(temp_7, b, c);
+    tcg_gen_mov_i32(high_mul, temp_7);
+    getRegister(temp_8, R_ACCLO);
+    tcg_gen_mov_i32(a, temp_8);
+    if ((getFFlag () == true)) {
+        getRegister(temp_9, R_ACCHI);
+        tcg_gen_mov_i32(new_acchi, temp_9);
+        TCGLabel *done_2 = gen_new_label();
+        CarryADD(temp_10, new_acchi, old_acchi, high_mul);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, temp_10, arc_true);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+        tcg_gen_movi_i32(temp_11, 1);
+        setVFlag(temp_11);
+        gen_set_label(done_2);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(old_acchi);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(high_mul);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(new_acchi);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_11);
+
+    return ret;
+}
+
+
+/*
+ * MACD
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getRegister, MAC, nextReg, getFFlag, setNFlag,
+ *               OverflowADD, setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       old_acchi = getRegister (R_ACCHI);
+ *       high_mul = MAC (@b, @c);
+ *       @a = getRegister (R_ACCLO);
+ *       pair = nextReg (a);
+ *       pair = getRegister (R_ACCHI);
+ *       if((getFFlag () == true))
+ *         {
+ *           new_acchi = getRegister (R_ACCHI);
+ *           setNFlag (new_acchi);
+ *           if((OverflowADD (new_acchi, old_acchi, high_mul) == true))
+ *             {
+ *               setVFlag (1);
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MACD(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv old_acchi = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv high_mul = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv pair = NULL;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv new_acchi = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    getRegister(temp_6, R_ACCHI);
+    tcg_gen_mov_i32(old_acchi, temp_6);
+    MAC(temp_7, b, c);
+    tcg_gen_mov_i32(high_mul, temp_7);
+    getRegister(temp_8, R_ACCLO);
+    tcg_gen_mov_i32(a, temp_8);
+    pair = nextReg (a);
+    getRegister(temp_9, R_ACCHI);
+    tcg_gen_mov_i32(pair, temp_9);
+    if ((getFFlag () == true)) {
+        getRegister(temp_10, R_ACCHI);
+        tcg_gen_mov_i32(new_acchi, temp_10);
+        setNFlag(new_acchi);
+        TCGLabel *done_2 = gen_new_label();
+        OverflowADD(temp_11, new_acchi, old_acchi, high_mul);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, temp_11, arc_true);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+        tcg_gen_movi_i32(temp_12, 1);
+        setVFlag(temp_12);
+        gen_set_label(done_2);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(old_acchi);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(high_mul);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(new_acchi);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_12);
+
+    return ret;
+}
+
+
+/*
+ * MACDU
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag, getRegister, MACU, nextReg, getFFlag, CarryADD,
+ *               setVFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       old_acchi = getRegister (R_ACCHI);
+ *       high_mul = MACU (@b, @c);
+ *       @a = getRegister (R_ACCLO);
+ *       pair = nextReg (a);
+ *       pair = getRegister (R_ACCHI);
+ *       if((getFFlag () == true))
+ *         {
+ *           new_acchi = getRegister (R_ACCHI);
+ *           if((CarryADD (new_acchi, old_acchi, high_mul) == true))
+ *             {
+ *               setVFlag (1);
+ *             };
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_MACDU(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv old_acchi = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv high_mul = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv pair = NULL;
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv new_acchi = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    getRegister(temp_6, R_ACCHI);
+    tcg_gen_mov_i32(old_acchi, temp_6);
+    MACU(temp_7, b, c);
+    tcg_gen_mov_i32(high_mul, temp_7);
+    getRegister(temp_8, R_ACCLO);
+    tcg_gen_mov_i32(a, temp_8);
+    pair = nextReg (a);
+    getRegister(temp_9, R_ACCHI);
+    tcg_gen_mov_i32(pair, temp_9);
+    if ((getFFlag () == true)) {
+        getRegister(temp_10, R_ACCHI);
+        tcg_gen_mov_i32(new_acchi, temp_10);
+        TCGLabel *done_2 = gen_new_label();
+        CarryADD(temp_11, new_acchi, old_acchi, high_mul);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, temp_11, arc_true);
+        tcg_gen_xori_i32(temp_4, temp_3, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+        tcg_gen_movi_i32(temp_12, 1);
+        setVFlag(temp_12);
+        gen_set_label(done_2);
+    }
+    gen_set_label(done_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(old_acchi);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(high_mul);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(new_acchi);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_12);
+
+    return ret;
+}
+
+
+/*
+ * ABS
+ *    Variables: @src, @dest
+ *    Functions: Carry, getFFlag, setZFlag, setNFlag, setCFlag, Zero, setVFlag,
+ *               getNFlag
+ * --- code ---
+ * {
+ *   lsrc = @src;
+ *   alu = (0 - lsrc);
+ *   if((Carry (lsrc) == 1))
+ *     {
+ *       @dest = alu;
+ *     }
+ *   else
+ *     {
+ *       @dest = lsrc;
+ *     };
+ *   if((getFFlag () == true))
+ *     {
+ *       setZFlag (@dest);
+ *       setNFlag (@dest);
+ *       setCFlag (Zero ());
+ *       setVFlag (getNFlag ());
+ *     };
+ * }
+ */
+
+int
+arc_gen_ABS(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv alu = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(lsrc, src);
+    tcg_gen_subfi_i32(alu, 0, lsrc);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    Carry(temp_3, lsrc);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_1, temp_3, 1);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    tcg_gen_mov_i32(dest, alu);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    tcg_gen_mov_i32(dest, lsrc);
+    gen_set_label(done_1);
+    if ((getFFlag () == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+        tcg_gen_mov_i32(temp_4, Zero());
+        setCFlag(temp_4);
+        tcg_gen_mov_i32(temp_5, getNFlag());
+        setVFlag(temp_5);
+    }
+    tcg_temp_free(lsrc);
+    tcg_temp_free(alu);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+
+    return ret;
+}
+
+
+/*
+ * SWAP
+ *    Variables: @src, @dest
+ *    Functions: getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   tmp1 = (@src << 16);
+ *   tmp2 = ((@src >> 16) & 65535);
+ *   @dest = (tmp1 | tmp2);
+ *   f_flag = getFFlag ();
+ *   if((f_flag == true))
+ *     {
+ *       setZFlag (@dest);
+ *       setNFlag (@dest);
+ *     };
+ * }
+ */
+
+int
+arc_gen_SWAP(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv tmp1 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv tmp2 = tcg_temp_local_new_i32();
+    int f_flag;
+    tcg_gen_shli_i32(tmp1, src, 16);
+    tcg_gen_shri_i32(temp_1, src, 16);
+    tcg_gen_andi_i32(tmp2, temp_1, 65535);
+    tcg_gen_or_i32(dest, tmp1, tmp2);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    tcg_temp_free(tmp1);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(tmp2);
+
+    return ret;
+}
+
+
+/*
+ * SWAPE
+ *    Variables: @src, @dest
+ *    Functions: getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   tmp1 = ((@src << 24) & 4278190080);
+ *   tmp2 = ((@src << 8) & 16711680);
+ *   tmp3 = ((@src >> 8) & 65280);
+ *   tmp4 = ((@src >> 24) & 255);
+ *   @dest = (((tmp1 | tmp2) | tmp3) | tmp4);
+ *   f_flag = getFFlag ();
+ *   if((f_flag == true))
+ *     {
+ *       setZFlag (@dest);
+ *       setNFlag (@dest);
+ *     };
+ * }
+ */
+
+int
+arc_gen_SWAPE(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv tmp1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv tmp2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv tmp3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv tmp4 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    int f_flag;
+    tcg_gen_shli_i32(temp_1, src, 24);
+    tcg_gen_andi_i32(tmp1, temp_1, 4278190080);
+    tcg_gen_shli_i32(temp_2, src, 8);
+    tcg_gen_andi_i32(tmp2, temp_2, 16711680);
+    tcg_gen_shri_i32(temp_3, src, 8);
+    tcg_gen_andi_i32(tmp3, temp_3, 65280);
+    tcg_gen_shri_i32(temp_4, src, 24);
+    tcg_gen_andi_i32(tmp4, temp_4, 255);
+    tcg_gen_or_i32(temp_6, tmp1, tmp2);
+    tcg_gen_or_i32(temp_5, temp_6, tmp3);
+    tcg_gen_or_i32(dest, temp_5, tmp4);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+    tcg_temp_free(temp_1);
+    tcg_temp_free(tmp1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(tmp2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(tmp3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(tmp4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+
+    return ret;
+}
+
+
+/*
+ * NOT
+ *    Variables: @dest, @src
+ *    Functions: getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   @dest = ~@src;
+ *   f_flag = getFFlag ();
+ *   if((f_flag == true))
+ *     {
+ *       setZFlag (@dest);
+ *       setNFlag (@dest);
+ *     };
+ * }
+ */
+
+int
+arc_gen_NOT(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    int f_flag;
+    tcg_gen_not_i32(dest, src);
+    f_flag = getFFlag ();
+    if ((f_flag == true)) {
+        setZFlag(dest);
+        setNFlag(dest);
+    }
+
+    return ret;
+}
+
+
+/*
+ * BI
+ *    Variables: @c
+ *    Functions: setPC, getPCL
+ * --- code ---
+ * {
+ *   setPC ((getPCL () + (@c << 2)));
+ * }
+ */
+
+int
+arc_gen_BI(DisasCtxt *ctx, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    tcg_gen_shli_i32(temp_4, c, 2);
+    getPCL(temp_3);
+    tcg_gen_mov_i32(temp_2, temp_3);
+    tcg_gen_add_i32(temp_1, temp_2, temp_4);
+    setPC(temp_1);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_1);
+
+    return ret;
+}
+
+
+/*
+ * BIH
+ *    Variables: @c
+ *    Functions: setPC, getPCL
+ * --- code ---
+ * {
+ *   setPC ((getPCL () + (@c << 1)));
+ * }
+ */
+
+int
+arc_gen_BIH(DisasCtxt *ctx, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    tcg_gen_shli_i32(temp_4, c, 1);
+    getPCL(temp_3);
+    tcg_gen_mov_i32(temp_2, temp_3);
+    tcg_gen_add_i32(temp_1, temp_2, temp_4);
+    setPC(temp_1);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_1);
+
+    return ret;
+}
+
+
+/*
+ * B
+ *    Variables: @rd
+ *    Functions: getCCFlag, getPCL, shouldExecuteDelaySlot, executeDelaySlot,
+ *               setPC
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       take_branch = true;
+ *     };
+ *   bta = (getPCL () + @rd);
+ *   if((shouldExecuteDelaySlot () == true))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       setPC (bta);
+ *     };
+ * }
+ */
+
+int
+arc_gen_B(DisasCtxt *ctx, TCGv rd)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    gen_set_label(done_1);
+    getPCL(temp_7);
+    tcg_gen_mov_i32(temp_6, temp_7);
+    tcg_gen_add_i32(bta, temp_6, rd);
+    if ((shouldExecuteDelaySlot () == true)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+    setPC(bta);
+    gen_set_label(done_2);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * B_S
+ *    Variables: @rd
+ *    Functions: getCCFlag, killDelaySlot, setPC, getPCL
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       killDelaySlot ();
+ *       setPC ((getPCL () + @rd));
+ *     };
+ * }
+ */
+
+int
+arc_gen_B_S(DisasCtxt *ctx, TCGv rd)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    gen_set_label(done_1);
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+    killDelaySlot();
+    getPCL(temp_8);
+    tcg_gen_mov_i32(temp_7, temp_8);
+    tcg_gen_add_i32(temp_6, temp_7, rd);
+    setPC(temp_6);
+    gen_set_label(done_2);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * BBIT0
+ *    Variables: @b, @c, @rd
+ *    Functions: getCCFlag, getPCL, shouldExecuteDelaySlot, executeDelaySlot,
+ *               setPC
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   p_b = @b;
+ *   p_c = (@c & 31);
+ *   tmp = (1 << p_c);
+ *   if((cc_flag == true))
+ *     {
+ *       if(((p_b && tmp) == 0))
+ *         {
+ *           take_branch = true;
+ *         };
+ *     };
+ *   bta = (getPCL () + @rd);
+ *   if((shouldExecuteDelaySlot () == true))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       if(((p_b && tmp) == 0))
+ *         {
+ *           setPC (bta);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BBIT0(DisasCtxt *ctx, TCGv b, TCGv c, TCGv rd)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_11);
+    tcg_gen_mov_i32(cc_flag, temp_11);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_andi_i32(p_c, c, 31);
+    tcg_gen_shlfi_i32(tmp, 1, p_c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_and_i32(temp_3, p_b, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_4, temp_3, 0);
+    tcg_gen_xori_i32(temp_5, temp_4, 1);
+    tcg_gen_andi_i32(temp_5, temp_5, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_5, arc_true, done_2);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    getPCL(temp_13);
+    tcg_gen_mov_i32(temp_12, temp_13);
+    tcg_gen_add_i32(bta, temp_12, rd);
+    if ((shouldExecuteDelaySlot () == true)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_6, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_7, temp_6, 1);
+    tcg_gen_andi_i32(temp_7, temp_7, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_7, arc_true, done_3);
+    TCGLabel *done_4 = gen_new_label();
+    tcg_gen_and_i32(temp_8, p_b, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_9, temp_8, 0);
+    tcg_gen_xori_i32(temp_10, temp_9, 1);
+    tcg_gen_andi_i32(temp_10, temp_10, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_10, arc_true, done_4);
+    setPC(bta);
+    gen_set_label(done_4);
+    gen_set_label(done_3);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(tmp);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_10);
+
+    return ret;
+}
+
+
+/*
+ * BBIT1
+ *    Variables: @b, @c, @rd
+ *    Functions: getCCFlag, getPCL, shouldExecuteDelaySlot, executeDelaySlot,
+ *               setPC
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   p_b = @b;
+ *   p_c = (@c & 31);
+ *   tmp = (1 << p_c);
+ *   if((cc_flag == true))
+ *     {
+ *       if(((p_b && tmp) != 0))
+ *         {
+ *           take_branch = true;
+ *         };
+ *     };
+ *   bta = (getPCL () + @rd);
+ *   if((shouldExecuteDelaySlot () == true))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       if(((p_b && tmp) != 0))
+ *         {
+ *           setPC (bta);
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_BBIT1(DisasCtxt *ctx, TCGv b, TCGv c, TCGv rd)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv tmp = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_11);
+    tcg_gen_mov_i32(cc_flag, temp_11);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_andi_i32(p_c, c, 31);
+    tcg_gen_shlfi_i32(tmp, 1, p_c);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_and_i32(temp_3, p_b, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_4, temp_3, 0);
+    tcg_gen_xori_i32(temp_5, temp_4, 1);
+    tcg_gen_andi_i32(temp_5, temp_5, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_5, arc_true, done_2);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    gen_set_label(done_2);
+    gen_set_label(done_1);
+    getPCL(temp_13);
+    tcg_gen_mov_i32(temp_12, temp_13);
+    tcg_gen_add_i32(bta, temp_12, rd);
+    if ((shouldExecuteDelaySlot () == true)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_6, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_7, temp_6, 1);
+    tcg_gen_andi_i32(temp_7, temp_7, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_7, arc_true, done_3);
+    TCGLabel *done_4 = gen_new_label();
+    tcg_gen_and_i32(temp_8, p_b, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_NE, temp_9, temp_8, 0);
+    tcg_gen_xori_i32(temp_10, temp_9, 1);
+    tcg_gen_andi_i32(temp_10, temp_10, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_10, arc_true, done_4);
+    setPC(bta);
+    gen_set_label(done_4);
+    gen_set_label(done_3);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(tmp);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_10);
+
+    return ret;
+}
+
+
+/*
+ * BL
+ *    Variables: @rd
+ *    Functions: getCCFlag, getPCL, shouldExecuteDelaySlot, setBLINK,
+ *               nextInsnAddressAfterDelaySlot, executeDelaySlot,
+ *               nextInsnAddress, setPC
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       take_branch = true;
+ *     };
+ *   bta = (getPCL () + @rd);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       if(take_branch)
+ *         {
+ *           setBLINK (nextInsnAddressAfterDelaySlot ());
+ *         };
+ *       executeDelaySlot (bta, take_branch);
+ *     }
+ *   else
+ *     {
+ *       if(take_branch)
+ *         {
+ *           setBLINK (nextInsnAddress ());
+ *         };
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       setPC (bta);
+ *     };
+ * }
+ */
+
+int
+arc_gen_BL(DisasCtxt *ctx, TCGv rd)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    gen_set_label(done_1);
+    getPCL(temp_9);
+    tcg_gen_mov_i32(temp_8, temp_9);
+    tcg_gen_add_i32(bta, temp_8, rd);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        TCGLabel *done_2 = gen_new_label();
+        tcg_gen_xori_i32(temp_3, take_branch, 1);
+        tcg_gen_andi_i32(temp_3, temp_3, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_3, arc_true, done_2);
+        nextInsnAddressAfterDelaySlot(temp_11);
+        tcg_gen_mov_i32(temp_10, temp_11);
+        setBLINK(temp_10);
+        gen_set_label(done_2);
+        executeDelaySlot(bta, take_branch);
+    } else {
+        TCGLabel *done_3 = gen_new_label();
+        tcg_gen_xori_i32(temp_4, take_branch, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_3);
+        nextInsnAddress(temp_13);
+        tcg_gen_mov_i32(temp_12, temp_13);
+        setBLINK(temp_12);
+        gen_set_label(done_3);
+    }
+
+    TCGLabel *done_4 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_5, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, done_4);
+    setPC(bta);
+    gen_set_label(done_4);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * J
+ *    Variables: @src
+ *    Functions: getCCFlag, shouldExecuteDelaySlot, executeDelaySlot, setPC
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       take_branch = true;
+ *     };
+ *   bta = @src;
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       setPC (bta);
+ *     };
+ * }
+ */
+
+int
+arc_gen_J(DisasCtxt *ctx, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_5);
+    tcg_gen_mov_i32(cc_flag, temp_5);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    gen_set_label(done_1);
+    tcg_gen_mov_i32(bta, src);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_2);
+    setPC(bta);
+    gen_set_label(done_2);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * JL
+ *    Variables: @src
+ *    Functions: getCCFlag, shouldExecuteDelaySlot, setBLINK,
+ *               nextInsnAddressAfterDelaySlot, executeDelaySlot,
+ *               nextInsnAddress, setPC
+ * --- code ---
+ * {
+ *   take_branch = false;
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       take_branch = true;
+ *     };
+ *   bta = @src;
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       if(take_branch)
+ *         {
+ *           setBLINK (nextInsnAddressAfterDelaySlot ());
+ *         };
+ *       executeDelaySlot (bta, take_branch);
+ *     }
+ *   else
+ *     {
+ *       if(take_branch)
+ *         {
+ *           setBLINK (nextInsnAddress ());
+ *         };
+ *     };
+ *   if((cc_flag == true))
+ *     {
+ *       setPC (bta);
+ *     };
+ * }
+ */
+
+int
+arc_gen_JL(DisasCtxt *ctx, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(take_branch, arc_false);
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    gen_set_label(done_1);
+    tcg_gen_mov_i32(bta, src);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        TCGLabel *done_2 = gen_new_label();
+        tcg_gen_xori_i32(temp_3, take_branch, 1);
+        tcg_gen_andi_i32(temp_3, temp_3, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_3, arc_true, done_2);
+        nextInsnAddressAfterDelaySlot(temp_9);
+        tcg_gen_mov_i32(temp_8, temp_9);
+        setBLINK(temp_8);
+        gen_set_label(done_2);
+        executeDelaySlot(bta, take_branch);
+    } else {
+        TCGLabel *done_3 = gen_new_label();
+        tcg_gen_xori_i32(temp_4, take_branch, 1);
+        tcg_gen_andi_i32(temp_4, temp_4, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, done_3);
+        nextInsnAddress(temp_11);
+        tcg_gen_mov_i32(temp_10, temp_11);
+        setBLINK(temp_10);
+        gen_set_label(done_3);
+    }
+
+    TCGLabel *done_4 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_5, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, done_4);
+    setPC(bta);
+    gen_set_label(done_4);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_11);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * SETEQ
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       p_b = @b;
+ *       p_c = @c;
+ *       take_branch = false;
+ *       if((p_b == p_c))
+ *         {
+ *         }
+ *       else
+ *         {
+ *         };
+ *       if((p_b == p_c))
+ *         {
+ *           @a = true;
+ *         }
+ *       else
+ *         {
+ *           @a = false;
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETEQ(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    TCGLabel *else_3 = gen_new_label();
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_5, p_b, p_c);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_3);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_3);
+    gen_set_label(else_3);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_3);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * BREQ
+ *    Variables: @b, @c, @offset
+ *    Functions: getPCL, shouldExecuteDelaySlot, executeDelaySlot, setPC
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if((p_b == p_c))
+ *     {
+ *       take_branch = true;
+ *     }
+ *   else
+ *     {
+ *     };
+ *   bta = (getPCL () + @offset);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((p_b == p_c))
+ *     {
+ *       setPC (bta);
+ *     }
+ *   else
+ *     {
+ *     };
+ * }
+ */
+
+int
+arc_gen_BREQ(DisasCtxt *ctx, TCGv b, TCGv c, TCGv offset)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    getPCL(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_add_i32(bta, temp_5, offset);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    setPC(bta);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * SETNE
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       p_b = @b;
+ *       p_c = @c;
+ *       take_branch = false;
+ *       if((p_b != p_c))
+ *         {
+ *         }
+ *       else
+ *         {
+ *         };
+ *       if((p_b != p_c))
+ *         {
+ *           @a = true;
+ *         }
+ *       else
+ *         {
+ *           @a = false;
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETNE(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_NE, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    TCGLabel *else_3 = gen_new_label();
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_NE, temp_5, p_b, p_c);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_3);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_3);
+    gen_set_label(else_3);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_3);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * BRNE
+ *    Variables: @b, @c, @offset
+ *    Functions: getPCL, shouldExecuteDelaySlot, executeDelaySlot, setPC
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if((p_b != p_c))
+ *     {
+ *       take_branch = true;
+ *     }
+ *   else
+ *     {
+ *     };
+ *   bta = (getPCL () + @offset);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((p_b != p_c))
+ *     {
+ *       setPC (bta);
+ *     }
+ *   else
+ *     {
+ *     };
+ * }
+ */
+
+int
+arc_gen_BRNE(DisasCtxt *ctx, TCGv b, TCGv c, TCGv offset)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_NE, temp_1, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    getPCL(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_add_i32(bta, temp_5, offset);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_NE, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    setPC(bta);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * SETLT
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       p_b = @b;
+ *       p_c = @c;
+ *       take_branch = false;
+ *       if((p_b < p_c))
+ *         {
+ *         }
+ *       else
+ *         {
+ *         };
+ *       if((p_b < p_c))
+ *         {
+ *           @a = true;
+ *         }
+ *       else
+ *         {
+ *           @a = false;
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETLT(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LT, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    TCGLabel *else_3 = gen_new_label();
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LT, temp_5, p_b, p_c);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_3);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_3);
+    gen_set_label(else_3);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_3);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * BRLT
+ *    Variables: @b, @c, @offset
+ *    Functions: getPCL, shouldExecuteDelaySlot, executeDelaySlot, setPC
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if((p_b < p_c))
+ *     {
+ *       take_branch = true;
+ *     }
+ *   else
+ *     {
+ *     };
+ *   bta = (getPCL () + @offset);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((p_b < p_c))
+ *     {
+ *       setPC (bta);
+ *     }
+ *   else
+ *     {
+ *     };
+ * }
+ */
+
+int
+arc_gen_BRLT(DisasCtxt *ctx, TCGv b, TCGv c, TCGv offset)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LT, temp_1, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    getPCL(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_add_i32(bta, temp_5, offset);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LT, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    setPC(bta);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * SETGE
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       p_b = @b;
+ *       p_c = @c;
+ *       take_branch = false;
+ *       if((p_b >= p_c))
+ *         {
+ *         }
+ *       else
+ *         {
+ *         };
+ *       if((p_b >= p_c))
+ *         {
+ *           @a = true;
+ *         }
+ *       else
+ *         {
+ *           @a = false;
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETGE(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GE, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    TCGLabel *else_3 = gen_new_label();
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GE, temp_5, p_b, p_c);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_3);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_3);
+    gen_set_label(else_3);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_3);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * BRGE
+ *    Variables: @b, @c, @offset
+ *    Functions: getPCL, shouldExecuteDelaySlot, executeDelaySlot, setPC
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if((p_b >= p_c))
+ *     {
+ *       take_branch = true;
+ *     }
+ *   else
+ *     {
+ *     };
+ *   bta = (getPCL () + @offset);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if((p_b >= p_c))
+ *     {
+ *       setPC (bta);
+ *     }
+ *   else
+ *     {
+ *     };
+ * }
+ */
+
+int
+arc_gen_BRGE(DisasCtxt *ctx, TCGv b, TCGv c, TCGv offset)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GE, temp_1, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    getPCL(temp_6);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_add_i32(bta, temp_5, offset);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GE, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    setPC(bta);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * SETLE
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       p_b = @b;
+ *       p_c = @c;
+ *       take_branch = false;
+ *       if((p_b <= p_c))
+ *         {
+ *         }
+ *       else
+ *         {
+ *         };
+ *       if((p_b <= p_c))
+ *         {
+ *           @a = true;
+ *         }
+ *       else
+ *         {
+ *           @a = false;
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETLE(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LE, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    TCGLabel *else_3 = gen_new_label();
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_LE, temp_5, p_b, p_c);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_3);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_3);
+    gen_set_label(else_3);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_3);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * SETGT
+ *    Variables: @b, @c, @a
+ *    Functions: getCCFlag
+ * --- code ---
+ * {
+ *   cc_flag = getCCFlag ();
+ *   if((cc_flag == true))
+ *     {
+ *       p_b = @b;
+ *       p_c = @c;
+ *       take_branch = false;
+ *       if((p_b > p_c))
+ *         {
+ *         }
+ *       else
+ *         {
+ *         };
+ *       if((p_b > p_c))
+ *         {
+ *           @a = true;
+ *         }
+ *       else
+ *         {
+ *           @a = false;
+ *         };
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETGT(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv cc_flag = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getCCFlag(temp_7);
+    tcg_gen_mov_i32(cc_flag, temp_7);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, cc_flag, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GT, temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_4, temp_3, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_4, arc_true, else_2);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    TCGLabel *else_3 = gen_new_label();
+    TCGLabel *done_3 = gen_new_label();
+    tcg_gen_setcond_i32(TCG_COND_GT, temp_5, p_b, p_c);
+    tcg_gen_xori_i32(temp_6, temp_5, 1);
+    tcg_gen_andi_i32(temp_6, temp_6, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_6, arc_true, else_3);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_3);
+    gen_set_label(else_3);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_3);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(cc_flag);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * BRLO
+ *    Variables: @b, @c, @offset
+ *    Functions: unsignedLT, getPCL, shouldExecuteDelaySlot, executeDelaySlot,
+ *               setPC
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if(unsignedLT (p_b, p_c))
+ *     {
+ *       take_branch = true;
+ *     }
+ *   else
+ *     {
+ *     };
+ *   bta = (getPCL () + @offset);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if(unsignedLT (p_b, p_c))
+ *     {
+ *       setPC (bta);
+ *     }
+ *   else
+ *     {
+ *     };
+ * }
+ */
+
+int
+arc_gen_BRLO(DisasCtxt *ctx, TCGv b, TCGv c, TCGv offset)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    unsignedLT(temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_1, temp_3, 1);
+    tcg_gen_andi_i32(temp_1, temp_1, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_1, arc_true, else_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    getPCL(temp_5);
+    tcg_gen_mov_i32(temp_4, temp_5);
+    tcg_gen_add_i32(bta, temp_4, offset);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    unsignedLT(temp_6, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_6, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_2);
+    setPC(bta);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * SETLO
+ *    Variables: @b, @c, @a
+ *    Functions: unsignedLT
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if(unsignedLT (p_b, p_c))
+ *     {
+ *     }
+ *   else
+ *     {
+ *     };
+ *   if(unsignedLT (p_b, p_c))
+ *     {
+ *       @a = true;
+ *     }
+ *   else
+ *     {
+ *       @a = false;
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETLO(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    unsignedLT(temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_1, temp_3, 1);
+    tcg_gen_andi_i32(temp_1, temp_1, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_1, arc_true, else_1);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    unsignedLT(temp_4, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_4, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_2);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * BRHS
+ *    Variables: @b, @c, @offset
+ *    Functions: unsignedGE, getPCL, shouldExecuteDelaySlot, executeDelaySlot,
+ *               setPC
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if(unsignedGE (p_b, p_c))
+ *     {
+ *       take_branch = true;
+ *     }
+ *   else
+ *     {
+ *     };
+ *   bta = (getPCL () + @offset);
+ *   if((shouldExecuteDelaySlot () == 1))
+ *     {
+ *       executeDelaySlot (bta, take_branch);
+ *     };
+ *   if(unsignedGE (p_b, p_c))
+ *     {
+ *       setPC (bta);
+ *     }
+ *   else
+ *     {
+ *     };
+ * }
+ */
+
+int
+arc_gen_BRHS(DisasCtxt *ctx, TCGv b, TCGv c, TCGv offset)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv bta = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    unsignedGE(temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_1, temp_3, 1);
+    tcg_gen_andi_i32(temp_1, temp_1, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_1, arc_true, else_1);
+    tcg_gen_mov_i32(take_branch, arc_true);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    getPCL(temp_5);
+    tcg_gen_mov_i32(temp_4, temp_5);
+    tcg_gen_add_i32(bta, temp_4, offset);
+    if ((shouldExecuteDelaySlot () == 1)) {
+        executeDelaySlot(bta, take_branch);
+    }
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    unsignedGE(temp_6, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_6, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_2);
+    setPC(bta);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(bta);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * SETHS
+ *    Variables: @b, @c, @a
+ *    Functions: unsignedGE
+ * --- code ---
+ * {
+ *   p_b = @b;
+ *   p_c = @c;
+ *   take_branch = false;
+ *   if(unsignedGE (p_b, p_c))
+ *     {
+ *     }
+ *   else
+ *     {
+ *     };
+ *   if(unsignedGE (p_b, p_c))
+ *     {
+ *       @a = true;
+ *     }
+ *   else
+ *     {
+ *       @a = false;
+ *     };
+ * }
+ */
+
+int
+arc_gen_SETHS(DisasCtxt *ctx, TCGv b, TCGv c, TCGv a)
+{
+    int ret = DISAS_NEXT;
+    TCGv p_b = tcg_temp_local_new_i32();
+    TCGv p_c = tcg_temp_local_new_i32();
+    TCGv take_branch = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(p_b, b);
+    tcg_gen_mov_i32(p_c, c);
+    tcg_gen_mov_i32(take_branch, arc_false);
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    unsignedGE(temp_3, p_b, p_c);
+    tcg_gen_xori_i32(temp_1, temp_3, 1);
+    tcg_gen_andi_i32(temp_1, temp_1, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_1, arc_true, else_1);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    gen_set_label(done_1);
+    TCGLabel *else_2 = gen_new_label();
+    TCGLabel *done_2 = gen_new_label();
+    unsignedGE(temp_4, p_b, p_c);
+    tcg_gen_xori_i32(temp_2, temp_4, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_2);
+    tcg_gen_mov_i32(a, arc_true);
+    tcg_gen_br(done_2);
+    gen_set_label(else_2);
+    tcg_gen_mov_i32(a, arc_false);
+    gen_set_label(done_2);
+    tcg_temp_free(p_b);
+    tcg_temp_free(p_c);
+    tcg_temp_free(take_branch);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * EX
+ *    Variables: @b, @c
+ *    Functions: getMemory, setMemory
+ * --- code ---
+ * {
+ *   temp = @b;
+ *   @b = getMemory (@c, LONG);
+ *   setMemory (@c, LONG, temp);
+ * }
+ */
+
+int
+arc_gen_EX(DisasCtxt *ctx, TCGv b, TCGv c)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(temp, b);
+    getMemory(temp_1, c, LONG);
+    tcg_gen_mov_i32(b, temp_1);
+    setMemory(c, LONG, temp);
+    tcg_temp_free(temp);
+    tcg_temp_free(temp_1);
+
+    return ret;
+}
+
+
+/*
+ * LLOCK
+ *    Variables: @dest, @src
+ *    Functions: getMemory, setLF
+ * --- code ---
+ * {
+ *   @dest = getMemory (@src, LONG);
+ *   setLF (1);
+ * }
+ */
+
+int
+arc_gen_LLOCK(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    getMemory(temp_1, src, LONG);
+    tcg_gen_mov_i32(dest, temp_1);
+    tcg_gen_movi_i32(temp_2, 1);
+    setLF(temp_2);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * LLOCKD
+ *    Variables: @dest, @src
+ *    Functions: getMemory, nextReg, setLF
+ * --- code ---
+ * {
+ *   @dest = getMemory (@src, LONG);
+ *   pair = nextReg (dest);
+ *   pair = getMemory ((@src + 4), LONG);
+ *   setLF (1);
+ * }
+ */
+
+int
+arc_gen_LLOCKD(DisasCtxt *ctx, TCGv dest, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv pair = NULL;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    getMemory(temp_1, src, LONG);
+    tcg_gen_mov_i32(dest, temp_1);
+    pair = nextReg (dest);
+    tcg_gen_addi_i32(temp_3, src, 4);
+    getMemory(temp_2, temp_3, LONG);
+    tcg_gen_mov_i32(pair, temp_2);
+    tcg_gen_movi_i32(temp_4, 1);
+    setLF(temp_4);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * SCOND
+ *    Variables: @src, @dest
+ *    Functions: getLF, setMemory, setZFlag, setLF
+ * --- code ---
+ * {
+ *   lf = getLF ();
+ *   if((lf == 1))
+ *     {
+ *       setMemory (@src, LONG, @dest);
+ *     };
+ *   setZFlag (!lf);
+ *   setLF (0);
+ * }
+ */
+
+int
+arc_gen_SCOND(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv lf = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    getLF(temp_3);
+    tcg_gen_mov_i32(lf, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_1, lf, 1);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    setMemory(src, LONG, dest);
+    gen_set_label(done_1);
+    tcg_gen_xori_i32(temp_4, lf, 1);
+    tcg_gen_andi_i32(temp_4, temp_4, 1);
+    setZFlag(temp_4);
+    tcg_gen_movi_i32(temp_5, 0);
+    setLF(temp_5);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(lf);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+
+    return ret;
+}
+
+
+/*
+ * SCONDD
+ *    Variables: @src, @dest
+ *    Functions: getLF, setMemory, nextReg, setZFlag, setLF
+ * --- code ---
+ * {
+ *   lf = getLF ();
+ *   if((lf == 1))
+ *     {
+ *       setMemory (@src, LONG, @dest);
+ *       pair = nextReg (dest);
+ *       setMemory ((@src + 4), LONG, pair);
+ *     };
+ *   setZFlag (!lf);
+ *   setLF (0);
+ * }
+ */
+
+int
+arc_gen_SCONDD(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv lf = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv pair = NULL;
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    getLF(temp_3);
+    tcg_gen_mov_i32(lf, temp_3);
+    TCGLabel *done_1 = gen_new_label();
+    tcg_gen_setcondi_i32(TCG_COND_EQ, temp_1, lf, 1);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, done_1);
+    setMemory(src, LONG, dest);
+    pair = nextReg (dest);
+    tcg_gen_addi_i32(temp_4, src, 4);
+    setMemory(temp_4, LONG, pair);
+    gen_set_label(done_1);
+    tcg_gen_xori_i32(temp_5, lf, 1);
+    tcg_gen_andi_i32(temp_5, temp_5, 1);
+    setZFlag(temp_5);
+    tcg_gen_movi_i32(temp_6, 0);
+    setLF(temp_6);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(lf);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_6);
+
+    return ret;
+}
+
+
+/*
+ * DMB
+ *    Variables: @a
+ *    Functions:
+ * --- code ---
+ * {
+ *   @a = @a;
+ * }
+ */
+
+int
+arc_gen_DMB(DisasCtxt *ctx, TCGv a)
+{
+    int ret = DISAS_NEXT;
+
+    return ret;
+}
+
+
+/*
+ * LD
+ *    Variables: @src1, @src2, @dest
+ *    Functions: getAAFlag, getZZFlag, setDebugLD, getMemory, getFlagX,
+ *               SignExtend, NoFurtherLoadsPending
+ * --- code ---
+ * {
+ *   AA = getAAFlag ();
+ *   ZZ = getZZFlag ();
+ *   address = 0;
+ *   if(((AA == 0) || (AA == 1)))
+ *     {
+ *       address = (@src1 + @src2);
+ *     };
+ *   if((AA == 2))
+ *     {
+ *       address = @src1;
+ *     };
+ *   if(((AA == 3) && ((ZZ == 0) || (ZZ == 3))))
+ *     {
+ *       address = (@src1 + (@src2 << 2));
+ *     };
+ *   if(((AA == 3) && (ZZ == 2)))
+ *     {
+ *       address = (@src1 + (@src2 << 1));
+ *     };
+ *   l_src1 = @src1;
+ *   l_src2 = @src2;
+ *   setDebugLD (1);
+ *   new_dest = getMemory (address, ZZ);
+ *   if(((AA == 1) || (AA == 2)))
+ *     {
+ *       @src1 = (l_src1 + l_src2);
+ *     };
+ *   if((getFlagX () == 1))
+ *     {
+ *       new_dest = SignExtend (new_dest, ZZ);
+ *     };
+ *   if(NoFurtherLoadsPending ())
+ *     {
+ *       setDebugLD (0);
+ *     };
+ *   @dest = new_dest;
+ * }
+ */
+
+int
+arc_gen_LD(DisasCtxt *ctx, TCGv src1, TCGv src2, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    int AA;
+    int ZZ;
+    TCGv address = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv l_src1 = tcg_temp_local_new_i32();
+    TCGv l_src2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv new_dest = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    AA = getAAFlag ();
+    ZZ = getZZFlag ();
+    tcg_gen_movi_i32(address, 0);
+    if (((AA == 0) || (AA == 1))) {
+        tcg_gen_add_i32(address, src1, src2);
+    }
+    if ((AA == 2)) {
+        tcg_gen_mov_i32(address, src1);
+    }
+    if (((AA == 3) && ((ZZ == 0) || (ZZ == 3)))) {
+        tcg_gen_shli_i32(temp_2, src2, 2);
+        tcg_gen_add_i32(address, src1, temp_2);
+    }
+    if (((AA == 3) && (ZZ == 2))) {
+        tcg_gen_shli_i32(temp_3, src2, 1);
+        tcg_gen_add_i32(address, src1, temp_3);
+    }
+    tcg_gen_mov_i32(l_src1, src1);
+    tcg_gen_mov_i32(l_src2, src2);
+    tcg_gen_movi_i32(temp_4, 1);
+    setDebugLD(temp_4);
+    getMemory(temp_5, address, ZZ);
+    tcg_gen_mov_i32(new_dest, temp_5);
+    if (((AA == 1) || (AA == 2))) {
+        tcg_gen_add_i32(src1, l_src1, l_src2);
+    }
+    if ((getFlagX () == 1)) {
+        new_dest = SignExtend (new_dest, ZZ);
+    }
+    TCGLabel *done_1 = gen_new_label();
+    NoFurtherLoadsPending(temp_6);
+    tcg_gen_xori_i32(temp_1, temp_6, 1);
+    tcg_gen_andi_i32(temp_1, temp_1, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_1, arc_true, done_1);
+    tcg_gen_movi_i32(temp_7, 0);
+    setDebugLD(temp_7);
+    gen_set_label(done_1);
+    tcg_gen_mov_i32(dest, new_dest);
+    tcg_temp_free(address);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(l_src1);
+    tcg_temp_free(l_src2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(new_dest);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_7);
+
+    return ret;
+}
+
+
+/*
+ * LDD
+ *    Variables: @src1, @src2, @dest
+ *    Functions: getAAFlag, getZZFlag, setDebugLD, getMemory, nextReg,
+ *               NoFurtherLoadsPending
+ * --- code ---
+ * {
+ *   AA = getAAFlag ();
+ *   ZZ = getZZFlag ();
+ *   address = 0;
+ *   if(((AA == 0) || (AA == 1)))
+ *     {
+ *       address = (@src1 + @src2);
+ *     };
+ *   if((AA == 2))
+ *     {
+ *       address = @src1;
+ *     };
+ *   if(((AA == 3) && ((ZZ == 0) || (ZZ == 3))))
+ *     {
+ *       address = (@src1 + (@src2 << 2));
+ *     };
+ *   if(((AA == 3) && (ZZ == 2)))
+ *     {
+ *       address = (@src1 + (@src2 << 1));
+ *     };
+ *   l_src1 = @src1;
+ *   l_src2 = @src2;
+ *   setDebugLD (1);
+ *   new_dest = getMemory (address, LONG);
+ *   pair = nextReg (dest);
+ *   pair = getMemory ((address + 4), LONG);
+ *   if(((AA == 1) || (AA == 2)))
+ *     {
+ *       @src1 = (l_src1 + l_src2);
+ *     };
+ *   if(NoFurtherLoadsPending ())
+ *     {
+ *       setDebugLD (0);
+ *     };
+ *   @dest = new_dest;
+ * }
+ */
+
+int
+arc_gen_LDD(DisasCtxt *ctx, TCGv src1, TCGv src2, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    int AA;
+    int ZZ;
+    TCGv address = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv l_src1 = tcg_temp_local_new_i32();
+    TCGv l_src2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv new_dest = tcg_temp_local_new_i32();
+    TCGv pair = NULL;
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    AA = getAAFlag ();
+    ZZ = getZZFlag ();
+    tcg_gen_movi_i32(address, 0);
+    if (((AA == 0) || (AA == 1))) {
+        tcg_gen_add_i32(address, src1, src2);
+    }
+    if ((AA == 2)) {
+        tcg_gen_mov_i32(address, src1);
+    }
+    if (((AA == 3) && ((ZZ == 0) || (ZZ == 3)))) {
+        tcg_gen_shli_i32(temp_2, src2, 2);
+        tcg_gen_add_i32(address, src1, temp_2);
+    }
+    if (((AA == 3) && (ZZ == 2))) {
+        tcg_gen_shli_i32(temp_3, src2, 1);
+        tcg_gen_add_i32(address, src1, temp_3);
+    }
+    tcg_gen_mov_i32(l_src1, src1);
+    tcg_gen_mov_i32(l_src2, src2);
+    tcg_gen_movi_i32(temp_4, 1);
+    setDebugLD(temp_4);
+    getMemory(temp_5, address, LONG);
+    tcg_gen_mov_i32(new_dest, temp_5);
+    pair = nextReg (dest);
+    tcg_gen_addi_i32(temp_7, address, 4);
+    getMemory(temp_6, temp_7, LONG);
+    tcg_gen_mov_i32(pair, temp_6);
+    if (((AA == 1) || (AA == 2))) {
+        tcg_gen_add_i32(src1, l_src1, l_src2);
+    }
+    TCGLabel *done_1 = gen_new_label();
+    NoFurtherLoadsPending(temp_8);
+    tcg_gen_xori_i32(temp_1, temp_8, 1);
+    tcg_gen_andi_i32(temp_1, temp_1, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_1, arc_true, done_1);
+    tcg_gen_movi_i32(temp_9, 0);
+    setDebugLD(temp_9);
+    gen_set_label(done_1);
+    tcg_gen_mov_i32(dest, new_dest);
+    tcg_temp_free(address);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(l_src1);
+    tcg_temp_free(l_src2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(new_dest);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_9);
+
+    return ret;
+}
+
+
+/*
+ * ST
+ *    Variables: @src1, @src2, @dest
+ *    Functions: getAAFlag, getZZFlag, setMemory
+ * --- code ---
+ * {
+ *   AA = getAAFlag ();
+ *   ZZ = getZZFlag ();
+ *   address = 0;
+ *   if(((AA == 0) || (AA == 1)))
+ *     {
+ *       address = (@src1 + @src2);
+ *     };
+ *   if((AA == 2))
+ *     {
+ *       address = @src1;
+ *     };
+ *   if(((AA == 3) && ((ZZ == 0) || (ZZ == 3))))
+ *     {
+ *       address = (@src1 + (@src2 << 2));
+ *     };
+ *   if(((AA == 3) && (ZZ == 2)))
+ *     {
+ *       address = (@src1 + (@src2 << 1));
+ *     };
+ *   setMemory (address, ZZ, @dest);
+ *   if(((AA == 1) || (AA == 2)))
+ *     {
+ *       @src1 = (@src1 + @src2);
+ *     };
+ * }
+ */
+
+int
+arc_gen_ST(DisasCtxt *ctx, TCGv src1, TCGv src2, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    int AA;
+    int ZZ;
+    TCGv address = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    AA = getAAFlag ();
+    ZZ = getZZFlag ();
+    tcg_gen_movi_i32(address, 0);
+    if (((AA == 0) || (AA == 1))) {
+        tcg_gen_add_i32(address, src1, src2);
+    }
+    if ((AA == 2)) {
+        tcg_gen_mov_i32(address, src1);
+    }
+    if (((AA == 3) && ((ZZ == 0) || (ZZ == 3)))) {
+        tcg_gen_shli_i32(temp_1, src2, 2);
+        tcg_gen_add_i32(address, src1, temp_1);
+    }
+    if (((AA == 3) && (ZZ == 2))) {
+        tcg_gen_shli_i32(temp_2, src2, 1);
+        tcg_gen_add_i32(address, src1, temp_2);
+    }
+    setMemory(address, ZZ, dest);
+    if (((AA == 1) || (AA == 2))) {
+        tcg_gen_add_i32(src1, src1, src2);
+    }
+    tcg_temp_free(address);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+
+    return ret;
+}
+
+
+/*
+ * STD
+ *    Variables: @src1, @src2, @dest
+ *    Functions: getAAFlag, getZZFlag, setMemory,
+ *               instructionHasRegisterOperandIn, nextReg, getBit
+ * --- code ---
+ * {
+ *   AA = getAAFlag ();
+ *   ZZ = getZZFlag ();
+ *   address = 0;
+ *   if(((AA == 0) || (AA == 1)))
+ *     {
+ *       address = (@src1 + @src2);
+ *     };
+ *   if((AA == 2))
+ *     {
+ *       address = @src1;
+ *     };
+ *   if(((AA == 3) && ((ZZ == 0) || (ZZ == 3))))
+ *     {
+ *       address = (@src1 + (@src2 << 2));
+ *     };
+ *   if(((AA == 3) && (ZZ == 2)))
+ *     {
+ *       address = (@src1 + (@src2 << 1));
+ *     };
+ *   setMemory (address, LONG, @dest);
+ *   if(instructionHasRegisterOperandIn (0))
+ *     {
+ *       pair = nextReg (dest);
+ *     }
+ *   else
+ *     {
+ *       if((getBit (@dest, 31) == 1))
+ *         {
+ *           pair = 4294967295;
+ *         }
+ *       else
+ *         {
+ *           pair = 0;
+ *         };
+ *     };
+ *   setMemory ((address + 4), LONG, pair);
+ *   if(((AA == 1) || (AA == 2)))
+ *     {
+ *       @src1 = (@src1 + @src2);
+ *     };
+ * }
+ */
+
+int
+arc_gen_STD(DisasCtxt *ctx, TCGv src1, TCGv src2, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    int AA;
+    int ZZ;
+    TCGv address = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv pair = NULL;
+    bool pair_initialized = FALSE;
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    AA = getAAFlag ();
+    ZZ = getZZFlag ();
+    tcg_gen_movi_i32(address, 0);
+    if (((AA == 0) || (AA == 1))) {
+        tcg_gen_add_i32(address, src1, src2);
+    }
+    if ((AA == 2)) {
+        tcg_gen_mov_i32(address, src1);
+    }
+    if (((AA == 3) && ((ZZ == 0) || (ZZ == 3)))) {
+        tcg_gen_shli_i32(temp_3, src2, 2);
+        tcg_gen_add_i32(address, src1, temp_3);
+    }
+    if (((AA == 3) && (ZZ == 2))) {
+        tcg_gen_shli_i32(temp_4, src2, 1);
+        tcg_gen_add_i32(address, src1, temp_4);
+    }
+    setMemory(address, LONG, dest);
+    if (instructionHasRegisterOperandIn (0)) {
+        pair = nextReg (dest);
+    } else {
+        TCGLabel *else_1 = gen_new_label();
+        TCGLabel *done_1 = gen_new_label();
+        tcg_gen_movi_i32(temp_6, 31);
+        getBit(temp_5, dest, temp_6);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp_1, temp_5, 1);
+        tcg_gen_xori_i32(temp_2, temp_1, 1);
+        tcg_gen_andi_i32(temp_2, temp_2, 1);
+        tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+        pair = tcg_temp_local_new_i32();
+        pair_initialized = TRUE;
+        tcg_gen_movi_i32(pair, 4294967295);
+        tcg_gen_br(done_1);
+        gen_set_label(else_1);
+        tcg_gen_movi_i32(pair, 0);
+        gen_set_label(done_1);
+    }
+
+    tcg_gen_addi_i32(temp_7, address, 4);
+    setMemory(temp_7, LONG, pair);
+    if (((AA == 1) || (AA == 2))) {
+        tcg_gen_add_i32(src1, src1, src2);
+    }
+    tcg_temp_free(address);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_7);
+    if (pair_initialized) {
+        tcg_temp_free(pair);
+    }
+
+    return ret;
+}
+
+
+/*
+ * ENTER_S
+ *    Variables: @u6
+ *    Functions: helperEnter
+ * --- code ---
+ * {
+ *   helperEnter (@u6);
+ * }
+ */
+
+int
+arc_gen_ENTER_S(DisasCtxt *ctx, TCGv u6)
+{
+    int ret = DISAS_NEXT;
+
+    helperEnter(u6);
+    return ret;
+}
+
+
+/*
+ * LEAVE_S
+ *    Variables: @u7
+ *    Functions: helperLeave
+ * --- code ---
+ * {
+ *   helperLeave (@u7);
+ * }
+ */
+
+int
+arc_gen_LEAVE_S(DisasCtxt *ctx, TCGv u7)
+{
+    int ret = DISAS_NEXT;
+
+    helperLeave(u7);
+    return ret;
+}
+
+
+/*
+ * POP
+ *    Variables: @dest
+ *    Functions: getMemory, getRegister, setRegister
+ * --- code ---
+ * {
+ *   new_dest = getMemory (getRegister (R_SP), LONG);
+ *   setRegister (R_SP, (getRegister (R_SP) + 4));
+ *   @dest = new_dest;
+ * }
+ */
+
+int
+arc_gen_POP(DisasCtxt *ctx, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv new_dest = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    getRegister(temp_3, R_SP);
+    tcg_gen_mov_i32(temp_2, temp_3);
+    getMemory(temp_1, temp_2, LONG);
+    tcg_gen_mov_i32(new_dest, temp_1);
+    getRegister(temp_6, R_SP);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_addi_i32(temp_4, temp_5, 4);
+    setRegister(R_SP, temp_4);
+    tcg_gen_mov_i32(dest, new_dest);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(new_dest);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * PUSH
+ *    Variables: @src
+ *    Functions: setMemory, getRegister, setRegister
+ * --- code ---
+ * {
+ *   local_src = @src;
+ *   setMemory ((getRegister (R_SP) - 4), LONG, local_src);
+ *   setRegister (R_SP, (getRegister (R_SP) - 4));
+ * }
+ */
+
+int
+arc_gen_PUSH(DisasCtxt *ctx, TCGv src)
+{
+    int ret = DISAS_NEXT;
+    TCGv local_src = tcg_temp_local_new_i32();
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(local_src, src);
+    getRegister(temp_3, R_SP);
+    tcg_gen_mov_i32(temp_2, temp_3);
+    tcg_gen_subi_i32(temp_1, temp_2, 4);
+    setMemory(temp_1, LONG, local_src);
+    getRegister(temp_6, R_SP);
+    tcg_gen_mov_i32(temp_5, temp_6);
+    tcg_gen_subi_i32(temp_4, temp_5, 4);
+    setRegister(R_SP, temp_4);
+    tcg_temp_free(local_src);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(temp_4);
+
+    return ret;
+}
+
+
+/*
+ * LP
+ *    Variables: @rd
+ *    Functions: getCCFlag, getRegIndex, writeAuxReg, nextInsnAddress, getPCL,
+ *               setPC
+ * --- code ---
+ * {
+ *   if((getCCFlag () == true))
+ *     {
+ *       lp_start_index = getRegIndex (LP_START);
+ *       lp_end_index = getRegIndex (LP_END);
+ *       writeAuxReg (lp_start_index, nextInsnAddress ());
+ *       writeAuxReg (lp_end_index, (getPCL () + @rd));
+ *     }
+ *   else
+ *     {
+ *       setPC ((getPCL () + @rd));
+ *     };
+ * }
+ */
+
+int
+arc_gen_LP(DisasCtxt *ctx, TCGv rd)
+{
+    int ret = DISAS_NEXT;
+    TCGv temp_3 = tcg_temp_local_new_i32();
+    TCGv temp_1 = tcg_temp_local_new_i32();
+    TCGv temp_2 = tcg_temp_local_new_i32();
+    TCGv temp_4 = tcg_temp_local_new_i32();
+    TCGv lp_start_index = tcg_temp_local_new_i32();
+    TCGv temp_5 = tcg_temp_local_new_i32();
+    TCGv lp_end_index = tcg_temp_local_new_i32();
+    TCGv temp_7 = tcg_temp_local_new_i32();
+    TCGv temp_6 = tcg_temp_local_new_i32();
+    TCGv temp_10 = tcg_temp_local_new_i32();
+    TCGv temp_9 = tcg_temp_local_new_i32();
+    TCGv temp_8 = tcg_temp_local_new_i32();
+    TCGv temp_13 = tcg_temp_local_new_i32();
+    TCGv temp_12 = tcg_temp_local_new_i32();
+    TCGv temp_11 = tcg_temp_local_new_i32();
+    TCGLabel *else_1 = gen_new_label();
+    TCGLabel *done_1 = gen_new_label();
+    getCCFlag(temp_3);
+    tcg_gen_setcond_i32(TCG_COND_EQ, temp_1, temp_3, arc_true);
+    tcg_gen_xori_i32(temp_2, temp_1, 1);
+    tcg_gen_andi_i32(temp_2, temp_2, 1);
+    tcg_gen_brcond_i32(TCG_COND_EQ, temp_2, arc_true, else_1);
+    getRegIndex(temp_4, LP_START);
+    tcg_gen_mov_i32(lp_start_index, temp_4);
+    getRegIndex(temp_5, LP_END);
+    tcg_gen_mov_i32(lp_end_index, temp_5);
+    nextInsnAddress(temp_7);
+    tcg_gen_mov_i32(temp_6, temp_7);
+    writeAuxReg(lp_start_index, temp_6);
+    getPCL(temp_10);
+    tcg_gen_mov_i32(temp_9, temp_10);
+    tcg_gen_add_i32(temp_8, temp_9, rd);
+    writeAuxReg(lp_end_index, temp_8);
+    tcg_gen_br(done_1);
+    gen_set_label(else_1);
+    getPCL(temp_13);
+    tcg_gen_mov_i32(temp_12, temp_13);
+    tcg_gen_add_i32(temp_11, temp_12, rd);
+    setPC(temp_11);
+    gen_set_label(done_1);
+    tcg_temp_free(temp_3);
+    tcg_temp_free(temp_1);
+    tcg_temp_free(temp_2);
+    tcg_temp_free(temp_4);
+    tcg_temp_free(lp_start_index);
+    tcg_temp_free(temp_5);
+    tcg_temp_free(lp_end_index);
+    tcg_temp_free(temp_7);
+    tcg_temp_free(temp_6);
+    tcg_temp_free(temp_10);
+    tcg_temp_free(temp_9);
+    tcg_temp_free(temp_8);
+    tcg_temp_free(temp_13);
+    tcg_temp_free(temp_12);
+    tcg_temp_free(temp_11);
+
+    return ret;
+}
+
+
+/*
+ * NORM
+ *    Variables: @src, @dest
+ *    Functions: HELPER, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   psrc = @src;
+ *   i = HELPER (norm, psrc);
+ *   @dest = (31 - i);
+ *   if((getFFlag () == true))
+ *     {
+ *       setZFlag (psrc);
+ *       setNFlag (psrc);
+ *     };
+ * }
+ */
+
+int
+arc_gen_NORM(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv psrc = tcg_temp_local_new_i32();
+    TCGv i = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(psrc, src);
+    ARC_HELPER(norm, i, psrc);
+    tcg_gen_subfi_i32(dest, 31, i);
+    if ((getFFlag () == true)) {
+        setZFlag(psrc);
+        setNFlag(psrc);
+    }
+    tcg_temp_free(psrc);
+    tcg_temp_free(i);
+
+    return ret;
+}
+
+
+/*
+ * NORMH
+ *    Variables: @src, @dest
+ *    Functions: HELPER, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   lsrc = (@src & 65535);
+ *   i = HELPER (normh, lsrc);
+ *   @dest = (15 - i);
+ *   if((getFFlag () == true))
+ *     {
+ *       setZFlag (lsrc);
+ *       setNFlag (lsrc);
+ *     };
+ * }
+ */
+
+int
+arc_gen_NORMH(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv lsrc = tcg_temp_local_new_i32();
+    TCGv i = tcg_temp_local_new_i32();
+    tcg_gen_andi_i32(lsrc, src, 65535);
+    ARC_HELPER(normh, i, lsrc);
+    tcg_gen_subfi_i32(dest, 15, i);
+    if ((getFFlag () == true)) {
+        setZFlag(lsrc);
+        setNFlag(lsrc);
+    }
+    tcg_temp_free(lsrc);
+    tcg_temp_free(i);
+
+    return ret;
+}
+
+
+/*
+ * FLS
+ *    Variables: @src, @dest
+ *    Functions: HELPER, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   psrc = @src;
+ *   @dest = HELPER (fls, psrc);
+ *   if((getFFlag () == true))
+ *     {
+ *       setZFlag (psrc);
+ *       setNFlag (psrc);
+ *     };
+ * }
+ */
+
+int
+arc_gen_FLS(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv psrc = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(psrc, src);
+    ARC_HELPER(fls, dest, psrc);
+    if ((getFFlag () == true)) {
+        setZFlag(psrc);
+        setNFlag(psrc);
+    }
+    tcg_temp_free(psrc);
+
+    return ret;
+}
+
+
+/*
+ * FFS
+ *    Variables: @src, @dest
+ *    Functions: HELPER, getFFlag, setZFlag, setNFlag
+ * --- code ---
+ * {
+ *   psrc = @src;
+ *   @dest = HELPER (ffs, psrc);
+ *   if((getFFlag () == true))
+ *     {
+ *       setZFlag (psrc);
+ *       setNFlag (psrc);
+ *     };
+ * }
+ */
+
+int
+arc_gen_FFS(DisasCtxt *ctx, TCGv src, TCGv dest)
+{
+    int ret = DISAS_NEXT;
+    TCGv psrc = tcg_temp_local_new_i32();
+    tcg_gen_mov_i32(psrc, src);
+    ARC_HELPER(ffs, dest, psrc);
+    if ((getFFlag () == true)) {
+        setZFlag(psrc);
+        setNFlag(psrc);
+    }
+    tcg_temp_free(psrc);
+
+    return ret;
+}
diff --git a/target/arc/semfunc.h b/target/arc/semfunc.h
new file mode 100644
index 0000000000..14bcd21ce5
--- /dev/null
+++ b/target/arc/semfunc.h
@@ -0,0 +1,61 @@
+/*
+ *  QEMU ARC CPU
+ *
+ *  Copyright (c) 2017 Cupertino Miranda
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR dest PARTICULAR PURPOSE. See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, see
+ *  http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#ifndef __ARC_SEMFUNC_H__
+#define __ARC_SEMFUNC_H__
+
+#include "translate.h"
+#include "semfunc-helper.h"
+
+/* TODO (issue #62): these must be removed */
+#define arc_false   (ctx->zero)
+#define arc_true    (ctx->one)
+
+#define LONG 0
+#define BYTE 1
+#define WORD 2
+
+#define SEMANTIC_FUNCTION_PROTOTYPE_0(NAME) \
+    int arc_gen_##NAME(DisasCtxt *);
+#define SEMANTIC_FUNCTION_PROTOTYPE_1(NAME) \
+    int arc_gen_##NAME(DisasCtxt *, TCGv);
+#define SEMANTIC_FUNCTION_PROTOTYPE_2(NAME) \
+    int arc_gen_##NAME(DisasCtxt *, TCGv, TCGv);
+#define SEMANTIC_FUNCTION_PROTOTYPE_3(NAME) \
+    int arc_gen_##NAME(DisasCtxt *, TCGv, TCGv, TCGv);
+#define SEMANTIC_FUNCTION_PROTOTYPE_4(NAME) \
+    int arc_gen_##NAME(DisasCtxt *, TCGv, TCGv, TCGv, TCGv);
+
+#define MAPPING(MNEMONIC, NAME, NOPS, ...)
+#define CONSTANT(...)
+#define SEMANTIC_FUNCTION(NAME, NOPS) \
+    SEMANTIC_FUNCTION_PROTOTYPE_##NOPS(NAME)
+
+#include "target/arc/semfunc_mapping.def"
+
+#undef MAPPING
+#undef CONSTANT
+#undef SEMANTIC_FUNCTION_PROTOTYPE_0
+#undef SEMANTIC_FUNCTION_PROTOTYPE_1
+#undef SEMANTIC_FUNCTION_PROTOTYPE_2
+#undef SEMANTIC_FUNCTION_PROTOTYPE_3
+#undef SEMANTIC_FUNCTION
+
+#endif /* __ARC_SEMFUNC_H__ */
-- 
2.20.1


