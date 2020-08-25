Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50D6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD2D206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8+p6R/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD2D206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgdp-00046H-VD
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4B-0000Ju-Ky
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:15 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg49-00021D-N3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:15 -0400
Received: by mail-pj1-x1042.google.com with SMTP id g6so130612pjl.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ifoPB2xrefiphamrfMAWhJL0YX7DJDQgoCM7PfPYN9w=;
 b=L8+p6R/NrJWjvoevG8i0efGK/CaF+nLXFjUrd+5bGITCdM8i2ZMWHVfrMHQeHyyYrA
 GqRp8pcBH0lawSum/RiwvgwFLZjfjuf5a3UlovS+R8bpFiUazFH2erecDWmaxA3zuVzp
 cn16Q/dnA4IEaF4h4CIyCGf/udMkD/eWGwgYn66Ok5JtetdGCsAzCQLMzawHkQLquZ83
 aae+zYDIqdcZfs3rFGvz0M3MfSJt31jdlXu2BT5hpPt5+W6sOGfSfTeEDdEVAVY7veD7
 kbkFUjNTnbRVmuZFhpT5UVGH8gb5f2lQbwqwK3xGaz260nMk+hKrQXGjEwRzHL7gnTeM
 gZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ifoPB2xrefiphamrfMAWhJL0YX7DJDQgoCM7PfPYN9w=;
 b=S424+0vNCVpN3F++RLaOdLpe9gZEtAPCPJZomGHAZVX4xLNj5R/twmuc0QZAjqON4T
 K8/vnAbvGz9J1lWxMDb7KfFN9OrhX7KzWdxAN5ByrJGQjwsCOQGjvCFX5vtC6jOboSLT
 IyaSiYd3rQd9KNxLt1PfAfs4bSfMWr5pr55guxbM0OxpeBFJoqTurFyxsHU+IWR6jr7t
 JGasIZwmB+GcB0PBjSIY8AypCbuxRPwyIRcGuGloce3oqUMiwt0CFioSQaVqMBlpkP4V
 f35BxAojFe0Hgeva6UwNO71gQoLyXkwnHRvoIxXPmQuMhiLaWgrp8bOYvR9DuRmFGOvM
 cfXg==
X-Gm-Message-State: AOAM533jtoL/yEMmC+VbvtnTLhqdCw7h1b9ccClvRp0ioSCl0KIQRIYX
 D8hu4HiNVTQjA759Sm1BtTfk4/tV4ILL/Q==
X-Google-Smtp-Source: ABdhPJxcRwetxRYTk7PAppPF4pkrJZvL1MQI+ljU4lI6tdyG5ny1/tJiuk0SG2VK5JmniLU1RfaKJQ==
X-Received: by 2002:a17:90b:2394:: with SMTP id
 mr20mr47671pjb.56.1598389272047; 
 Tue, 25 Aug 2020 14:01:12 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/77] target/microblaze: Replace delayed_branch with
 tb_flags_to_set
Date: Tue, 25 Aug 2020 13:59:33 -0700
Message-Id: <20200825205950.730499-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The multi-stage counter can be replaced by clearing D_FLAG,
the or'ing in tb_flags_to_set.  The jump then happens when
D_FLAG is finally cleared.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 18009103c7..3ba2dc1800 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -73,7 +73,6 @@ typedef struct DisasContext {
     uint16_t imm;
 
     unsigned int cpustate_changed;
-    unsigned int delayed_branch;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
     int mem_index;
@@ -1314,10 +1313,9 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 
 static void dec_setup_dslot(DisasContext *dc)
 {
-    dc->delayed_branch = 2;
-    dc->tb_flags |= D_FLAG;
+    dc->tb_flags_to_set |= D_FLAG;
     if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags |= BIMM_FLAG;
+        dc->tb_flags_to_set |= BIMM_FLAG;
     }
 }
 
@@ -1329,7 +1327,6 @@ static void dec_bcc(DisasContext *dc)
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
 
-    dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
@@ -1405,7 +1402,6 @@ static void dec_br(DisasContext *dc)
         }
     }
 
-    dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
@@ -1625,8 +1621,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
-    dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
-    dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
+    dc->jmp = dc->tb_flags & D_FLAG ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
     dc->ext_imm = dc->base.tb->cs_base;
@@ -1697,11 +1692,11 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         tcg_gen_discard_i32(cpu_imm);
     }
 
-    dc->tb_flags &= ~IMM_FLAG;
+    dc->tb_flags &= ~(IMM_FLAG | BIMM_FLAG | D_FLAG);
     dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
-    if (dc->delayed_branch && --dc->delayed_branch == 0) {
+    if (dc->jmp != JMP_NOJMP && !(dc->tb_flags & D_FLAG)) {
         if (dc->tb_flags & DRTI_FLAG) {
             do_rti(dc);
         }
@@ -1711,8 +1706,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         if (dc->tb_flags & DRTE_FLAG) {
             do_rte(dc);
         }
-        /* Clear the delay slot flag.  */
-        dc->tb_flags &= ~D_FLAG;
         dc->base.is_jmp = DISAS_JUMP;
     }
 
-- 
2.25.1


