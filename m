Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DECDC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC79E2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdLsvJqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC79E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLKk-0001E9-Qe
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIU-0004zm-Ho
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:18 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:39501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIS-0000lc-SK
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:18 -0400
Received: by mail-pj1-x1034.google.com with SMTP id s2so6763594pjr.4
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C+qOEnrO4mdVdydo87qRuF3WglkeUY/A8QOfETainjE=;
 b=tdLsvJqXp/Xu8rTmum/Uf/FR6Dftv88FR5qERNIjM1oc4Q61ZLcx+Ojn3gHS49XdeB
 gphKaI2S4E7UEixjn68ze33TaaX5A6ldrQIY2Zy1HIEOPx/GyZbxifBoludRPM5oX9Nv
 EM8B6lPYiuO6xozcZ0qToyQWGNc+yuF2sRNN2ivKyZrblgpOhF7+sm3XfNVHkOhwyIjQ
 vjmqOQ1wo2Tn2aUPgqcCXr2rf+/ClixULpUXhoBHXGwKxqqlUqKVT09LMI4F4IcXHCDh
 kZmD8H8aNPdNfQGlET11cdfo7lpaIKb0SXdtepNL6XqeaqgobGiE2N2E5EQssjASeLxC
 SO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C+qOEnrO4mdVdydo87qRuF3WglkeUY/A8QOfETainjE=;
 b=eHHYMnqMpl3dzLOF2IphT6FYXvRzh9xH/ahAGft7ctTnWGLufEje3tOW1bDMHjGwXK
 OUF3SpWxByTlP9gXhAx88kdKJ6H11HHOe96ClA3S3r83U61QvZjhCNnyJmMO4QI/a9Ap
 s23/M6tXb61kIbeNnjTfc6pN4A1hoKslxXQPhNECjYXwKGZE79KvUY/G/L2+NwVBIxu9
 XbbAam47Wkg6wHSSaJIhKyWyhRhknu24sFaTPVMBBeX4WcObpTThqiyTRPSPQR/8AL44
 KYZc0SzrLrLK1SczVROUaNLOAb/JrggB9dgpkhjbPLu4+qMNDWYcwi+oHD/zk7A4lr75
 GMlQ==
X-Gm-Message-State: AOAM533TP0VGz9sBpdfg35ml5CTtY8p1H4z8hsEKG/NW2Xgun3Tvkp8c
 MhbAvSVZasR84/uErh5wt+RR62h+bI4F1g==
X-Google-Smtp-Source: ABdhPJyziALQlmUGIpYhvEmeGycvuFaPsrS/rJNiPJkzNIftbNBw0HyhdyAlunT27esd+1qfffCisg==
X-Received: by 2002:a17:90a:aa90:: with SMTP id
 l16mr367270pjq.210.1599501075271; 
 Mon, 07 Sep 2020 10:51:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ga3sm1651496pjb.18.2020.09.07.10.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:51:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] target/microblaze: Handle DISAS_EXIT_NEXT in delay slot
Date: Mon,  7 Sep 2020 10:50:51 -0700
Message-Id: <20200907175102.28027-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907175102.28027-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is legal to put an mts instruction into a delay slot.
We should continue to return to the main loop in that
case so that we recognize any pending interrupts.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6bf299a826..608d413c83 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1696,6 +1696,10 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     dc->base.pc_next += 4;
 
     if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
+        /*
+         * Finish any return-from branch.
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


