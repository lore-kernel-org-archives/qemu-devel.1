Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95A0C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF3A2177B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjX4YVFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF3A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLJJ-0006XY-F9
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIR-0004q2-0b
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:15 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:46822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIP-0000lB-Bo
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id 31so8298240pgy.13
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5SlIcFIM68w880BR4Kxx0NdCPJqMQrugFoEKlxU3Dhc=;
 b=bjX4YVFrxtUbjnPvtOS2WCIhlHxp8FEjfy6BP+O28pqXDqtnCZcQ2Yp7goNnSKP3r0
 VYiWgplKRHJ4L5jXZxLGBpZwem8MXhLzrXR62ePbUy8xuJoyLKPMhCNpkVnyBhx/Ydgj
 s+paOadB50oSOrO5Rcqh3zRKiQO7kHMUA28NKhNDjf6VD7jQrk1qKxTrEqKjiYaTH7FW
 esD/QfvPbXspq1H36p7u9Pb0XyEWKMHdkWbaSCama2nHjfU20j948WOQVbskEJjtRV2a
 eWnM0ecLZ3Piyo1MOj1z3nFVe/PySX/DtMFnAn6trzf1muj63jkRfQB5K3YF38NoE3Pi
 Jn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5SlIcFIM68w880BR4Kxx0NdCPJqMQrugFoEKlxU3Dhc=;
 b=X/LEJDV88TaRo9fHGob6o9lhS9BxtOVc4Q78lS17EtOOJBZ8yyKps+NMnYGBybPygH
 AlHrUYAmAhyjMBhHV02l1BGLZKVkfKgXKCkB/RvOhcrgQ3dy/p6gnHmplN5Zmn4bZ7un
 PcZM1SZcBBZtylXASbQcdPnddY2QFKLyfdWDqrhpQQkmzgrv5nBULBeGVc5eTt3XFu/I
 cHNMwXXbDT9URr32fY6HKZFrF5ssGXi/YzDBt87ieLsIQGQP9wzechx1O0HZ32jXLSXt
 u6HcxHzza80bTDgWuqbptaj3jxSCiDpk2Dgs5sWfXJ18N6o66Bv7o7HS/kdgO7FAZzxX
 8ACg==
X-Gm-Message-State: AOAM533ODfPCcDGdMBdG6EzGRJkT8mFotO2qj1qvQz+kCeG5nBD3sDNZ
 12J2wINlfZoWmhFfwRyrsjKzWcs24kNkqg==
X-Google-Smtp-Source: ABdhPJzt25uRw9FoQzBM95zcJGHIKzXVArgjRcHnWxiU+D/RRB5mf0BPyNGLSP3sKb5UhxkA3Cj5xQ==
X-Received: by 2002:a62:e108:: with SMTP id q8mr3975683pfh.214.1599501071683; 
 Mon, 07 Sep 2020 10:51:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ga3sm1651496pjb.18.2020.09.07.10.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:51:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] target/microblaze: Rename DISAS_UPDATE to DISAS_EXIT
Date: Mon,  7 Sep 2020 10:50:48 -0700
Message-Id: <20200907175102.28027-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907175102.28027-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The name "update" suggests that something needs updating, but
this is not the case.  Use "exit" to emphasize that nothing
needs doing except to exit.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a8a3249185..8ceb04f4f0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -37,7 +37,7 @@
 
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
-#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_EXIT    DISAS_TARGET_1 /* all cpu state modified dynamically */
 
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
@@ -1161,7 +1161,7 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
     tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_BIP);
     tcg_gen_movi_tl(cpu_res_addr, -1);
 
-    dc->base.is_jmp = DISAS_UPDATE;
+    dc->base.is_jmp = DISAS_EXIT;
     return true;
 }
 
@@ -1202,7 +1202,7 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
                          ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM));
     }
     tcg_gen_ori_i32(cpu_msr, cpu_msr, msr_to_set);
-    dc->base.is_jmp = DISAS_UPDATE;
+    dc->base.is_jmp = DISAS_EXIT;
 #endif
 
     return true;
@@ -1712,7 +1712,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     /* Force an exit if the per-tb cpu state has changed.  */
     if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
-        dc->base.is_jmp = DISAS_UPDATE;
+        dc->base.is_jmp = DISAS_EXIT;
         tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     }
 }
@@ -1733,7 +1733,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         gen_goto_tb(dc, 0, dc->base.pc_next);
         return;
 
-    case DISAS_UPDATE:
+    case DISAS_EXIT:
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-- 
2.25.1


