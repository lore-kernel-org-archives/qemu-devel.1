Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE27C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1D92075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4G3l++D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1D92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGcb-0001aO-U3
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 17:05:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG95-0001j2-SS
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG94-00051U-5b
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:59 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG93-0004wI-W2
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id t76so1581677oih.4
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=8wDpuqt2tvKadOymhMpkkiKWS+EHs0ZcemyyrplJ7bs=;
	b=b4G3l++DM5lY5nFvXhNgyNVJdSJiP2fPobYejXCrWikvLRamBtiHVfz6uOm74JSxhv
	R7IaeprCyybU+WzZ1cExVhgKfoTmYqlUU9EjDtd8IEbnhSRtGnswnhtcE/qehpbKeD0R
	eqTn7Qj8oAg2zw9xK9+bcCmJOtHhrINCnQ+nkayj+d/r+LBs4GyosIrmFdKK+eVmi6YJ
	MGlx/HeNaMIfmJBmi9SNNGR7c0vrMeEmLeLgIH5Vuvddm2RfrmzH3Gmg1pAhnOyT7yY1
	PlnYymO9H6Wtcb9igKbU1a7PiIWbt/7MCnIbkI3IJxqFWOXHIDJ7vDCqN911InkEJXaq
	qK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=8wDpuqt2tvKadOymhMpkkiKWS+EHs0ZcemyyrplJ7bs=;
	b=sNO2vfsgHVqyQjZ0hMQQSJa6OPecS/J9MQjbUidunuuy2LrKfxk53HRy9mE+YzmSLm
	itYHZClmoh63n12dsYTwXAdCRg7f0g2mrHj4gGl1ThgZx9N2n6dZCTg9FnsiRTShGthn
	s05P3EawJEco73y2E5RZpCERvAo2Gm/YVtmys23Iz0FSzrNaBBJSXHSpf582z1ll6F9z
	iNVPcaFyzFmLjbXQ7pG1yG6sUE54uaIatFIp8uYHpG7C5wPGRNwYUiGQBT1LRncvavCM
	nkPkTb80nuUhsBqlojgVHIM5C+KwTUt3YY+sDMH32tFHx2WK0YuM8Y0NRNC1Th2sVwK5
	PMFw==
X-Gm-Message-State: APjAAAW4kJ50DIeviy0bcbPq1qJRWGgEXzt2Fs64ePdfDl/a4su9oLZW
	aQ8VCc7VsxMqxgHyvcMFF8ryAm15b1nIjw==
X-Google-Smtp-Source: APXvYqx0obfITlNBpwOqhgqWqUkaiiaI0Dm4MVBeqeu/pvXuDFg8Dr2AmPThwZf8y9ulAqkepg0rbg==
X-Received: by 2002:aca:5d45:: with SMTP id r66mr1036453oib.143.1559680493992; 
	Tue, 04 Jun 2019 13:34:53 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.52
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:51 -0500
Message-Id: <20190604203351.27778-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH v4 39/39] tcg/arm: Remove mostly unreachable
 tlb special case
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
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


