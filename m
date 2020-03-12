Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B06C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B24205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlOZmQFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B24205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU10-000356-As
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjU-0006G7-6J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjT-0002Ig-33
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjS-0002II-Tz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:03 -0400
Received: by mail-pg1-x541.google.com with SMTP id h8so3564110pgs.9
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tHPURWIXRjblQZ58gS3vbMqtD53IcLCIb5jBh5LhEBk=;
 b=MlOZmQFoWQ4BcERTNAds4uxhqMuCO/enNBCMxm2iuR8i7FsWL3S/cxT5f036TcYZ4U
 HlSa2YxwlY+FlemkiBU8CJAN04Na0ofH+05kOPESp9gLLSqKCd0wweaTX6B2nvXrUbpS
 csnTHbWzOkQG56KC4/uNjqPbzo3hDbQFIvid7/bjK0hEXABkJgd2fDqLLKufrjdC51Z7
 3zPyoGEjzj/b3wUap8rs1ENOrdztnzAzTgTSRSb3Ssk0oODPn/BHF26a+lDUVawMUj68
 QNZ8xzLe95x6rqTL3QFN5xiEh+/qQvV0nARGhMxSPpTvle81ANNwUJgIqpS41svM8Gzm
 vHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tHPURWIXRjblQZ58gS3vbMqtD53IcLCIb5jBh5LhEBk=;
 b=SKglMUmMRly3fB31+uyOIx4sUmqpX1CRhjr2GBMNLXWI9BUmf8enVVFs0nwtvLx8gc
 vMT/9Ccrytb7z9bi18RoVj8vOInALFpXyGLnGV120LNqFbNaSgJm315lJa2IePihQnfp
 s4bmXi8U6+PcOorHENC55y4pAv596/rqgM/OvHzzC4e7YciIf6u0+2WO0cQBh+dzQR5M
 ux+jpUm15c9oBjuO53JVnaCDU6zjPWwuWvwpHIDA0+wMHCIJTcqKkrrfhUrcpVgqAQXP
 H7idk70LRBnagcaZUu7fuHrtC3Vy0RiaoNjXi7db80pKGH/nYupmhgkg8SeOjHJgTNYU
 cChA==
X-Gm-Message-State: ANhLgQ3joiLx0P8zCOijQ8yRG7PkZH99jHZOcCUbSsc08A21/+6S7MzP
 VtwcMKMIMiBzab7pw5KIn7rNb8f1JRE=
X-Google-Smtp-Source: ADFU+vtFMWclMd3YoRHlJ5cMw94ueR6YapU3t7zRcDypGwQNnxaRfVG+nygU5ZXL3NfEgaeZhMbB4Q==
X-Received: by 2002:a63:330f:: with SMTP id z15mr9534986pgz.104.1584042181608; 
 Thu, 12 Mar 2020 12:43:01 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 30/42] target/arm: Use mte_check1 for sve LD1R
Date: Thu, 12 Mar 2020 12:42:07 -0700
Message-Id: <20200312194219.24406-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 49d2e68564..e5d12edd55 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4850,16 +4850,16 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
 /* Load and broadcast element.  */
 static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    if (!sve_access_check(s)) {
-        return true;
-    }
-
     unsigned vsz = vec_full_reg_size(s);
     unsigned psz = pred_full_reg_size(s);
     unsigned esz = dtype_esz[a->dtype];
     unsigned msz = dtype_msz(a->dtype);
     TCGLabel *over = gen_new_label();
-    TCGv_i64 temp;
+    TCGv_i64 temp, clean_addr;
+
+    if (!sve_access_check(s)) {
+        return true;
+    }
 
     /* If the guarding predicate has no bits set, no load occurs.  */
     if (psz <= 8) {
@@ -4880,9 +4880,11 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     }
 
     /* Load the data.  */
-    temp = tcg_temp_new_i64();
-    tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << msz);
-    tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
+    temp = read_cpu_reg_sp(s, a->rn, true);
+    tcg_gen_addi_i64(temp, temp, a->imm << msz);
+    clean_addr = gen_mte_check1(s, temp, false, true, msz);
+
+    tcg_gen_qemu_ld_i64(temp, clean_addr, get_mem_index(s),
                         s->be_data | dtype_mop[a->dtype]);
 
     /* Broadcast to *all* elements.  */
-- 
2.20.1


