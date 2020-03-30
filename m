Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0803DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 18:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD82D20714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 18:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIaguF3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD82D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIzOj-00062s-UT
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 14:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jIzNr-00057Z-DO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 14:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jIzNq-00022h-6r
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 14:43:39 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jIzNp-00020Q-PN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 14:43:38 -0400
Received: by mail-pg1-x543.google.com with SMTP id a32so9087092pga.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1qFoEnRP59bn9KPnaesHADAuwvvkoBPpPEfqGhyETA0=;
 b=eIaguF3ar0LhhHgVdKVv+3K7eZA2GoVWhrG0r3uLoWcwxuy3zlz2qD63rxqBTTj+i8
 3Q6UWjNpyVVHkJXYYn7e4LfLh+2iGtoLur1z6iFkNWwnHqZ4PSesjcj0lO34B0ykKZDb
 tWBi4XLPh1mMthC1eGBzFZNmp39TpY56GtvPQ03X1UH2HJsJevWY8RQrxXGy8ulsqFDo
 0sGqPFUfborsqMpfxHAa5qttfpVGijTOuj20EkYEu2EM8DxmDp2OR5RaOQmIuqmg7YJ1
 BXBH5KtCJ+j2SEr3s/boPxeYcpofWWcAWx3HPCL5YjUGNQEYpN/ZrGicYx9UTTwVjgC5
 5zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1qFoEnRP59bn9KPnaesHADAuwvvkoBPpPEfqGhyETA0=;
 b=QkEnaJRSoX2JPthKBONRJryukJtAa5uoLggMKY2Rwd1PFSUObBryAkPa4p6XWp4LkX
 6qXAZAYHI6Ns/8D2rnPb5zGVaW7R/EdnfkjQ4+LgK/Df6mq1h//OTQU6JgKybjyRpdjY
 8f+oQ+ws6nz9LDEtUW8fHNGqhoy6FAlcXBKeUjB2ZzH3df0B7IEXpdC6FsT1o9LerL2M
 C5W+MSmDBPtLyuL5HGM/Ie/5jSONPfZFClFqeQhEDe8HoWa7deR2091Y8aBzOLNbC40R
 dHYBqYnplX8LOWdrjBypwtZFFIHMiIZsL7PX6HFQbWQ+Gdjdvj1xcZlQeoJrZmwOLhEq
 qfgQ==
X-Gm-Message-State: AGi0PuYEJ7ls6xLp7pFgTA5ptPhWOE3a6omD3HLBZHtd9xwLhKKgRcye
 q7N/Btp2ukEOtOinO3XjnmTKJUFD19c=
X-Google-Smtp-Source: APiQypLcIoX61OgltW/qahZHbPHpXg9Vzjq/HzsVD7jhWYQEn8hyRGrAyuCsgDZHvFqwwsOUHWXzMw==
X-Received: by 2002:a63:fd4f:: with SMTP id m15mr7179947pgj.323.1585593815874; 
 Mon, 30 Mar 2020 11:43:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z15sm10816196pfg.152.2020.03.30.11.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 11:43:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] tcg/i386: Fix INDEX_op_dup2_vec
Date: Mon, 30 Mar 2020 11:43:34 -0700
Message-Id: <20200330184334.1129-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were only constructing the 64-bit element, and not
replicating the 64-bit element across the rest of the vector.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

This bug is visible running RISU for aarch64 on x86_32.


r~

---
 tcg/i386/tcg-target.inc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 223dba9c8c..7f61eeedd0 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2855,9 +2855,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
 #if TCG_TARGET_REG_BITS == 32
     case INDEX_op_dup2_vec:
-        /* Constraints have already placed both 32-bit inputs in xmm regs.  */
-        insn = OPC_PUNPCKLDQ;
-        goto gen_simd;
+        /* First merge the two 32-bit inputs to a single 64-bit element. */
+        tcg_out_vex_modrm(s, OPC_PUNPCKLDQ, a0, a1, a2);
+        /* Then replicate the 64-bit elements across the rest of the vector. */
+        if (type != TCG_TYPE_V64) {
+            tcg_out_dup_vec(s, type, MO_64, a0, a0);
+        }
+        break;
 #endif
     case INDEX_op_abs_vec:
         insn = abs_insn[vece];
-- 
2.20.1


