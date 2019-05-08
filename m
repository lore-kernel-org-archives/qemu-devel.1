Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03204C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE51E20656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyC3EDDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE51E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAYv-00084E-TV
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:35:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7W-00080o-6Z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7V-00088F-7q
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:38 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:42913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7V-00081f-29
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id p6so9105913pgh.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=/VisHp15wmByWPI9wrDoIYVzQ1fadCpZ+X3Fx4ON5aw=;
	b=uyC3EDDxkaYnDjrjZFoYjidue6lNiQiawjkOzkgFjBiYdqU6HhgkvKQolHFs2P0sRp
	D8FTg3u70ocU4Ce7kbX2cl5ubevigBd42AHcmC5KtDImk8tDk5QLf2Xj8Z+5bxe+tSsz
	GFiik9/m+2F6A5KPDAYBnaLa6+qO4DZ1VfPumMUcZjCzvWG7eoHDUBv0xPOAqMHvU8zN
	XpIufTkdsHZX7Z6jvEvIGYroOkHWsGB/so8rnBaz38e9hQnU0YCS7mLtrhiXoYz9QR8l
	EsaQd97J9iOE4tz4kOu5ReCpi5Nbhe9dyCVY66J9Qi2QH2RNmziwEjmglu0PaqWBze+6
	vlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=/VisHp15wmByWPI9wrDoIYVzQ1fadCpZ+X3Fx4ON5aw=;
	b=NGBPdApXKGmyIYdnRLPVY6B6Sl96yHCGMMLK2OLvwoGlpUlUlauOf2lJZMcN3Xo3Ur
	mp9STZ7OiS8pjBPrG/4OFfys5ZtukeqG/7Gqt0R65oH98GiX4c4gZQxK9W0WO88wB+Eo
	CQKuBBnshZ2/FEYLX+QoxBwTqSEPYuE+zRqSOKbC3NfzyiD9jScemlotDt22gjtswAyk
	Bk8DhI0wJESYM1q8sayvDyuIaxb57KqHeB4+XG8pvRD6S3D5uPwG/DOdbUK4fh6mJC9g
	RaJH+araRbSh6M6i/aUN0fHAPp6lj/Ux/CxqPcayAEKx+AA2aFkBwNHha3rWqAFom2D1
	tVwg==
X-Gm-Message-State: APjAAAUZIv2wIPP0H45hnn9BXJKH+eg8XokE9EPImPrJysIO2snI7CZU
	otNm4LSKdn44868P2lHvFANdHpYa36I=
X-Google-Smtp-Source: APXvYqynF4/Q5zj9EY3PV3JpbSTpLaM44chT3weQZ4nLF2fVN8KBigD2hRIsEEMx+F+g2cl+uCzHOg==
X-Received: by 2002:a62:5915:: with SMTP id n21mr43602164pfb.180.1557274054723;
	Tue, 07 May 2019 17:07:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:41 -0700
Message-Id: <20190508000641.19090-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH v3 39/39] tcg/arm: Remove mostly unreachable
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index ac813abfb8..e0fcc1d990 100644
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


