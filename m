Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D497C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD002071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jic9JBiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD002071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kColP-0006DO-Fm
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojF-0001hn-25
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojD-0007Cz-BC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id i10so1121774pgk.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U7yp2n/JUrjfieIBpVMpGQbkxL1zH7j0vbNKXz+5yps=;
 b=jic9JBiK2HYHktU3ZE+UQbPQiTarhyAIJdl3XstsLHifi4Fas4d42QkDRpykUHTsPj
 sMA5MhnvoPfn+naGbGHj2NPufFAS3cBOMGHCYtB4KKtT+USYGlOH0i2W5NwbYTbTQUA7
 1ziy1FhhomTq/9/RYiZcD9+cf4ghWGlZphDqPNmqRNl3wOmLCBCg7nkeo10iCze+biIh
 P/NVjWRLQZItbS0bpIE27CtTBTRTFGyb4FhCXQEWIuEnxRjkalU0CZtVgHxdP3usxFI5
 D0zdnNYQmBGVrINdY3YbsaIhX3vpcxVmEN/3BfTuNnYUpOkEU4ibjtvmCeMaxtBjIqjx
 /JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U7yp2n/JUrjfieIBpVMpGQbkxL1zH7j0vbNKXz+5yps=;
 b=rvNOmhaCPyWKe9EwqPsi1LG4PfRXYvHXLuSZMAM0OAsetoFKhYrSkfEQNm56yx3eMm
 lzd+dylVchWDLeUC4oHGuF+7HgVtzPF8cQhKooEMSv+eSMeOBB2qh4ibnC1o9G1t/gFA
 KwOVINrNuGO1iSEjoQO4FepsN0S/1pPJnhYjkSropnyOPu5uouFjHqhfuZ9Cl1GOSACQ
 Gz80yZpWFVs3zTgzShhTSMscQ2IttmDnO0DvqUF/Ve2BmayA/gAmRZwhhCJSUUiKVoyE
 APjnF9ueIJoi5eqnB5yKrT2laGIk4FZ+hrWkagC2GKj0wUvfry8/rdBgPWNS6Bk1JFSG
 jEBw==
X-Gm-Message-State: AOAM531is1nT+3qOwsY2HtyiumYUKBAc6RMxPHDD/Snm0O/rigd9nCxU
 GZKSJWJO61xQBifSEfsoVcBKpeGgCSbYDA==
X-Google-Smtp-Source: ABdhPJyLSQm/2pdN5sO9nskAU43wyksARLzAXbFVeJ1af86P+sPP4b61DM4FyWIiug6luQa6eFounw==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr2176661pga.56.1598899225433; 
 Mon, 31 Aug 2020 11:40:25 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y195sm5757580pfc.137.2020.08.31.11.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 11:40:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/microblaze: Handle DISAS_EXIT_NEXT in delay slot
Date: Mon, 31 Aug 2020 11:40:16 -0700
Message-Id: <20200831184018.839906-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831184018.839906-1-richard.henderson@linaro.org>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

It is legal to put an mts instruction into a delay slot.
We should continue to return to the main loop in that
case so that we recognize any pending interrupts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9c52448c06..b116a0ce4f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1696,6 +1696,10 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     dc->base.pc_next += 4;
 
     if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
+        /*
+         * Finish finish any return-from branch.
+         * TODO: Diagnose rtXd in delay slot of rtYd earlier.
+         */
         if (dc->tb_flags & DRTI_FLAG) {
             do_rti(dc);
         } else if (dc->tb_flags & DRTB_FLAG) {
@@ -1703,7 +1707,35 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         } else if (dc->tb_flags & DRTE_FLAG) {
             do_rte(dc);
         }
-        dc->base.is_jmp = DISAS_JUMP;
+
+        /* Complete the branch, ending the TB. */
+        switch (dc->base.is_jmp) {
+        case DISAS_NORETURN:
+            /*
+             * E.g. illegal insn in a delay slot.  We've already exited
+             * and will handle D_FLAG in mb_cpu_do_interrupt.
+             */
+            break;
+        case DISAS_EXIT:
+            /*
+             * TODO: diagnose brk/brki in delay slot earlier.
+             * This would then fold into the illegal insn case above.
+             */
+            break;
+        case DISAS_NEXT:
+            /* Normal insn a delay slot.  */
+            dc->base.is_jmp = DISAS_JUMP;
+            break;
+        case DISAS_EXIT_NEXT:
+            /*
+             * E.g. mts insn in a delay slot.  Continue with btarget,
+             * but still return to the main loop.
+             */
+            dc->base.is_jmp = DISAS_EXIT_JUMP;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
-- 
2.25.1


