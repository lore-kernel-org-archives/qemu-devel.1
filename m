Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A8C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBBF207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pa5sXyyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBBF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haALc-0001k8-CP
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eT-0006z3-FR
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eR-00028B-GM
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eQ-00025L-El
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:11 -0400
Received: by mail-pl1-x644.google.com with SMTP id t7so372726plr.11
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8wDpuqt2tvKadOymhMpkkiKWS+EHs0ZcemyyrplJ7bs=;
 b=Pa5sXyyUli+7bcoMZwYI6ygYrsVmEagluOG/GkVNE9asG5yEHoe6fDsjkyL0wp7ujV
 AZlQHT1VStnhfIOyj96dbjmYOvpIv4Igt/V7nE4IL7Fz2HvUSZBFK462dWiFHeRLJbiT
 OOSKkrdOscSA5Sh1Pu8UMejgCOEYQHx6HhZnIje5jKM/wV1pV0akgZRVdV7YDvs8UUco
 3HZyW+5iDSpq7edhX489/AAOyJMAXn0qVAmGy38umhSWs+gBpiN0tWBVpiivjx/teOL/
 IEDlpmhMLVavmhEFtad8DL8yZIhRSgGozuXeEOip0LGKxcqH70+DU3WdPuIyWO63BqUN
 pKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8wDpuqt2tvKadOymhMpkkiKWS+EHs0ZcemyyrplJ7bs=;
 b=FBHVT2WIPxuyxdKyNmbIcnmmMFElz7wT8XyWhl6s6PSIII+8+AVowsYzqu/WIbXqh5
 hs9PrHHHsqJ+dpzLQ0g22WrA12dLLtCFLNh4RZsrDXWLSjkq+gwPXAFFDtSYbLZVo6Np
 5iN5SQLpR9NEATdxHW3iv5FUJWVsBiogB0PaWxMUe0uM9aqWnxnxrcuU8LlHHLyFh1hb
 +HTQuk+0KTxw2QnL8g54F7Ivbk10reT6KZrkSgbZvdetxj0yHtuxw6vqnOFfiJvaeJ8K
 WeuIy/tX1wEZolzG39BjSye2R6ynAykCN9Jb7ysM4Dx92bxNuMy3iPoJ0R17qyAZecws
 nBBg==
X-Gm-Message-State: APjAAAWKSonep2gpi4NB+tEOBRorCZMLcTTOt6yxaonWs+zlyEFx9Zh+
 ///ru+pOcV3G2kUU6hW94JmlH1wNDhU=
X-Google-Smtp-Source: APXvYqxLbdbiH9/ywhrhSwHrEBr3YnxFbyc4TYfcd74MfddA4mJSibxUPok9L/SfdY9856T/nOMNZQ==
X-Received: by 2002:a17:902:70c4:: with SMTP id
 l4mr32326368plt.171.1560132187540; 
 Sun, 09 Jun 2019 19:03:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.03.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:03:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:18 -0700
Message-Id: <20190610020218.9228-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 39/39] tcg/arm: Remove mostly unreachable tlb
 special case
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There was nothing armv7 specific about the bic+cmp sequence, however
looking at the set of guests more closely shows that the 8-bit immediate
operand for the bic can only be satisfied with one guest in tree:
baseline m-profile -- 10-bit pages with aligned 4-byte memory ops.
Therefore it does not seem useful to keep this path.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 276e843627..ece88dc2eb 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1290,19 +1290,20 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R1,
                     offsetof(CPUTLBEntry, addend));
 
-    /* Check alignment, check comparators.  */
-    if (use_armv7_instructions) {
+    /*
+     * Check alignment, check comparators.
+     * Do this in no more than 3 insns.  Use MOVW for v7, if possible,
+     * to reduce the number of sequential conditional instructions.
+     * Almost all guests have at least 4k pages, which means that we need
+     * to clear at least 9 bits even for an 8-byte memory, which means it
+     * isn't worth checking for an immediate operand for BIC.
+     */
+    if (use_armv7_instructions && TARGET_PAGE_BITS <= 16) {
         tcg_target_ulong mask = ~(TARGET_PAGE_MASK | ((1 << a_bits) - 1));
-        int rot = encode_imm(mask);
 
-        if (rot >= 0) { 
-            tcg_out_dat_imm(s, COND_AL, ARITH_BIC, TCG_REG_TMP, addrlo,
-                            rotl(mask, rot) | (rot << 7));
-        } else {
-            tcg_out_movi32(s, COND_AL, TCG_REG_TMP, mask);
-            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
-                            addrlo, TCG_REG_TMP, 0);
-        }
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, mask);
+        tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
+                        addrlo, TCG_REG_TMP, 0);
         tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R2, TCG_REG_TMP, 0);
     } else {
         if (a_bits) {
-- 
2.17.1


