Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F461206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VN5mpTMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F461206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVmh-0004mY-Nf
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk2-0000Aq-D3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:10 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVjz-00056o-Sh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:09 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b16so72926pjp.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8ALbL72P3oKJR5lecnTpjjC92sUJPG1z3Lj3Tgfg1jE=;
 b=VN5mpTMV8FE9bOMPN0g1EubJbE35Prvn+lDnUJuNHppvJayOl9rXyjm7g81HiiAnbu
 zDdsdaKGDUX4t2kKtaQgIX2muVaAKefcIuGwxwAsf2UUYrwbWOKfeZvQFL0lkboqPhpX
 XCqfQ/WDOe9TQgTGEKjd008FLzV91hqOdWdvo7CKKp6qcQ4EJ/GBFCDbkEIuCuUejp5s
 A0Wl67iCo3lTXD6Z+gb4u19E8ZG3A2Wemnu+nyQdxjElBvE2BhodzFovyMw7hqNEHJZl
 tMNRWjnx0JpY7wWSIvAsKso1bipCtKtQlnbS6t1BPR+Fu6J904F7uvIrQio2N92bdDm5
 zuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ALbL72P3oKJR5lecnTpjjC92sUJPG1z3Lj3Tgfg1jE=;
 b=blpY1DPA9eGMEWpLv2a1k3IxBIsRRZj9YlJJJurt9vFWsrhPaQsRnSICv0F/gLtdOG
 ZzAFE8eElBwSYjFzwIRV0fsfc1PjaKPK3GSbacmcQNoHySvP1Da4HQjX0ZcbxPW/Diz1
 8eji60LTpZprViXIoUU5A6sJml+X7Et14p9HIq9zOegXeiKj3s4r95IusrzZuVr0r81G
 PJSq7U1xfJCefDA9cSaJzMpRSe0bVuue2EqMm+IfFXVIvh02YJLhl0nZXKKBw+jskmw0
 bSv/iRKMUH0+/xiXMSn6W2X1Q2Idj4NLubO6m/wyECaWosP130u5SWcAPG4hegk+Oe3x
 2A5g==
X-Gm-Message-State: AOAM530OfGDKBcbyUclEsxtDcsziUOkkqqDxLUdnog0CzkGpkKdpIKlU
 PwBnjp7lVXrV1f5a3DjXlEF9gDWGohYKBg==
X-Google-Smtp-Source: ABdhPJxs9QHictUDe65W83FYuUlmD/z2bDgnDMpHUaQFHVOqFJZpCKtG3VsYMGN0QwrYlENs/I+VUg==
X-Received: by 2002:a17:902:b194:: with SMTP id
 s20mr2745298plr.321.1599064565980; 
 Wed, 02 Sep 2020 09:36:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] target/microblaze: Handle DISAS_EXIT_NEXT in delay slot
Date: Wed,  2 Sep 2020 09:35:56 -0700
Message-Id: <20200902163559.1077728-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9c52448c06..459b25f8b9 100644
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


