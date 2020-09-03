Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A14C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2202E20737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbeOhAxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2202E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjgQ-0007Zk-5T
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeG-00028n-5y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeE-0001mT-4V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id 31so1390902pgy.13
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C+qOEnrO4mdVdydo87qRuF3WglkeUY/A8QOfETainjE=;
 b=PbeOhAxGhAYN28XupQwjntOi3c+d1SK2ceEUHlooQmxOCkMZeTIbCKRjwL2uPZzXZK
 b6YqFdknm0U+nw87V7X3YGXSmV7im86mWS/k3W0OVZxzWNs7SaqqJ569g33oFKcFb5iO
 tiR1yYb93DpfPwvOWcjEbq3r5v15zieQncRferdKLgOKDQg7cmSQlt5hJ7WICPO1oBwZ
 Wqy+H1HnSHb4yLK13OjmwRoBdKvagrJwzq1WJSS1v42CAq30GV3TV4pSBPQXl5fvXUWx
 hhshlz6B3cZi7/Ia15ByveXYDxTkZeyE5dXGuDHWd1GoUmsXY7pAzX/5OFxOjoVKYoXL
 vsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C+qOEnrO4mdVdydo87qRuF3WglkeUY/A8QOfETainjE=;
 b=pr0D8l9AXelwPSRg9XhVxGPbHwzhzo5rnCs2NCB8lXl1dF31p/7ZWteZn/96+nHj0u
 28ndwUydZpkMIjpl7vkK7l/Umps2yDdUX0LdpgZYQDSA4QphXDpiFwcIUHRnUfVZHmzE
 ArdrLDKZC5YswqV/F8VX9bUNrqG7MB81ff9pLYiXypVM6HYGvcV9eI91rz+dkdRDy7PJ
 ZgQLLz/tZfPbY3DHHPXQwCb2E61Lmcso/4ZZWwbD41+j2jPuavslTCq4+vXIVfJvKO3S
 nEr9Dv+Idl/oV5/Fcv23pRcSPguilE1NlftVTKLc9Q9BVJQ0XCatgbsweDEFPcSqHWWw
 4bAA==
X-Gm-Message-State: AOAM532whUatCyavnP/TsqgHS1IaEj4dIs/Lh9FROBSUZG/DWN1LFL8X
 8A2GmWbOExgBXuhzo+eMyLxvQ7zpCa1FAQ==
X-Google-Smtp-Source: ABdhPJzm8IO0Qrp5UaSmN6DIAbIWTS6DvM01VUFkpU5Yv+j+/TExM0Ld677nXvMcYDkGVlunlrSNdw==
X-Received: by 2002:aa7:9569:: with SMTP id x9mr2565919pfq.16.1599118024395;
 Thu, 03 Sep 2020 00:27:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:27:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] target/microblaze: Handle DISAS_EXIT_NEXT in delay
 slot
Date: Thu,  3 Sep 2020 00:26:47 -0700
Message-Id: <20200903072650.1360454-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903072650.1360454-1-richard.henderson@linaro.org>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
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


