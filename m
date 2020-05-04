Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DAEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6FF206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSQMTWM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6FF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVagI-0001rZ-0i
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIH-0001Ld-6y
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIG-0001JB-8H
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id e16so15591510wra.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0hy7GkOuTpkkXixImY0LEXOiXHSMsLSHNhjhUFJjdC8=;
 b=VSQMTWM/ZatTDfpIGSyaOGA6/BegPKWXr7tVqbkC8J+M6KYPIxqHyceJcSy5sz/8sj
 tzUlBajrQbSE07gf9QsntLuOth0F7P19NPHklKOA3nkJ0oNPA7WO/PL2IeO972+VOC7A
 tP0K6LyHZVqlbAZcGKFeBEKoHSZvLJD8XOe2o9LOBn6gbJ9T+tu9fccWcN/UGSUqJzHa
 mSDzDn0J8dm6CCdgMbWypghbrhyBVIGyZuYR4M3MOgHgup7cHuKKS5AUo3jre7IxmSHB
 R0/CVz3urKLUa0l4yLgmk/Un27yEjiRqEsNMUVg79RXLm5gRkall1Ik2A8IZ+1gYHaq2
 B59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0hy7GkOuTpkkXixImY0LEXOiXHSMsLSHNhjhUFJjdC8=;
 b=JuBvU7jluM0DNx4Mcs7ryNKquo/kF05Vy3JHRJ/KVWQ/JO6ZQwPUVD39UGTWn5kT7a
 Qbp0hRR8BqXVdkyQrcbQS9XQHvwcIQ/7Ari5QDFFA6Hqzx/IZ6bJ7JCE55Qj4rvs5hvN
 vXEC2fVAx5H8p5VN8fkQry1N0tJ82+dwisYblE2H9xM0Nu+oKap9CDWDT6Fns+rM09NX
 oQ7giu1pWcgih4sgWC72YYXq6go1XOYQuTztgbMPOqeeZyRlbWFeGorrj6Y7iijAOys+
 ULt5L3OPTLc9NfncSgUebh3BqcmBHgAdE9A6QVufNwDyNqf684uE5i2zsVXM+SShcR6i
 kewA==
X-Gm-Message-State: AGi0PuYhoRQN3UrXoj1yXq4Xw1hrqvCg/SiK+5hnfxXn1Zf9pEJ2z6XL
 FIeR4gHtd5v9upw0GNsQ5nHjFESd3DI1Ug==
X-Google-Smtp-Source: APiQypI89NZsywOKmIva/duRYRMVp5PQ5A/+97GKg2Cfv9SUMufdBl+AwSev4+l3AvO4eCt91ABvag==
X-Received: by 2002:adf:f342:: with SMTP id e2mr17973282wrp.146.1588595634776; 
 Mon, 04 May 2020 05:33:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/39] target/arm: Move gen_ function typedefs to translate.h
Date: Mon,  4 May 2020 13:33:09 +0100
Message-Id: <20200504123309.3808-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're going to want at least some of the NeonGen* typedefs
for the refactored 32-bit Neon decoder, so move them all
to translate.h since it makes more sense to keep them in
one group.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-23-peter.maydell@linaro.org
---
 target/arm/translate.h     | 17 +++++++++++++++++
 target/arm/translate-a64.c | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 95b43e7ab65..cb7925ea461 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -314,4 +314,21 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
+/* Function prototype for gen_ functions for calling Neon helpers */
+typedef void NeonGenOneOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32);
+typedef void NeonGenTwoOpFn(TCGv_i32, TCGv_i32, TCGv_i32);
+typedef void NeonGenTwoOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
+typedef void NeonGenTwo64OpFn(TCGv_i64, TCGv_i64, TCGv_i64);
+typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
+typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
+typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
+typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
+typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
+typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
+typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
+typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index efb1c4adc4e..a896f9c4b83 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -70,23 +70,6 @@ typedef struct AArch64DecodeTable {
     AArch64DecodeFn *disas_fn;
 } AArch64DecodeTable;
 
-/* Function prototype for gen_ functions for calling Neon helpers */
-typedef void NeonGenOneOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32);
-typedef void NeonGenTwoOpFn(TCGv_i32, TCGv_i32, TCGv_i32);
-typedef void NeonGenTwoOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
-typedef void NeonGenTwo64OpFn(TCGv_i64, TCGv_i64, TCGv_i64);
-typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
-typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
-typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
-typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
-typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
-typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
-typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
-typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
-typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
-typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
-typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);
-
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
-- 
2.20.1


