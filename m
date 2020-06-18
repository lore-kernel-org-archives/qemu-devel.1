Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0586EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49C021852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVbZu+Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49C021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmGX-0000tx-0p
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8g-0001sf-Gf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8e-0002HF-Rj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id v14so2346385pgl.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ZmOpNN8xzx/C7OZZcIwUO8we6yz96THNL4bVhzwYm8=;
 b=HVbZu+XoGZ73X+iF5qB6aEZD2Gyjb0PJz4GLoKGjgr33olMT9x7/fhLp5KQ8Ks/m0x
 BXHloKWfln5cB7rRmt3+0fcuezgILsbxcXV4jf27uXRXgsrQgvKdqC1Fd9ybBc1QSsz1
 eoCXMU2GQYeNgFDmc77uii97xmHO4zmrLjkSAK1TZbmeC+DwLU1+AV1Bwl//Vmq4IvVj
 lSORALFCmHzwWHW8tTcugwXX4jzCtQ9bbP4Q0nehh9Ap21PTUy/5F8Q5ZfoRnt5xpJ1o
 4nyJ+YmJ9+GXx3f1wxzxN+yiWfyL0XpaS6RtEC5n8lZDPKJ4wvMNJ9j2JK19iwqWaens
 z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ZmOpNN8xzx/C7OZZcIwUO8we6yz96THNL4bVhzwYm8=;
 b=Te1q2P8c/u1aca1xhqIyGr+hEXvzVsFvGXcyOxeRCu02opF+wifJLn9S5/eErzkC+F
 lAgbJqrIgTU1eHjdQ5mKSzLbphy801Dab6PWb4J6LBG1PJW4Ms9lggS/XNYYaf09TA+6
 wJ4rY+Dmrt0dhzazc1jGzjNysYSnBe3k/kwsP5wmBpzDAbKoq1BrIWmmo1/4pIJTM1vl
 RHF+PVCOmvZtiflGwAuu7xxml34f5BzeM9c6dKP87IZlwf8TDHv6jbu06liQ0aAPlQ4O
 W06PsNU2paAxWAsE+FkdW7qcchnkPh8dtsrg2yPEth60wwydTSUAvXc0N/WNCQSGL/Sm
 K1gQ==
X-Gm-Message-State: AOAM530HOgr4Quk5Y3SLqmOgycFaU/5BezVescxtbQsX92ck5JNJRJUp
 QgbLoSpqus854NSGP/rLDLWdTvWtpYw=
X-Google-Smtp-Source: ABdhPJz7Nl498YV8U8NTdfeydmIdbOw8QTtUIeuBjAEHmZlarEqkkYzgfhptNZkEoo0+d3NJY9cplQ==
X-Received: by 2002:a63:6bc5:: with SMTP id g188mr1734209pgc.395.1592454415186; 
 Wed, 17 Jun 2020 21:26:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 006/100] target/arm: Merge do_vector2_p into do_mov_p
Date: Wed, 17 Jun 2020 21:25:10 -0700
Message-Id: <20200618042644.1685561-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the only user of the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8d5c7421d..b649b9d0b5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -178,18 +178,6 @@ static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
     tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), vsz, vsz, word);
 }
 
-/* Invoke a vector expander on two Pregs.  */
-static bool do_vector2_p(DisasContext *s, GVecGen2Fn *gvec_fn,
-                         int esz, int rd, int rn)
-{
-    if (sve_access_check(s)) {
-        unsigned psz = pred_gvec_reg_size(s);
-        gvec_fn(esz, pred_full_reg_offset(s, rd),
-                pred_full_reg_offset(s, rn), psz, psz);
-    }
-    return true;
-}
-
 /* Invoke a vector expander on three Pregs.  */
 static bool do_vector3_p(DisasContext *s, GVecGen3Fn *gvec_fn,
                          int esz, int rd, int rn, int rm)
@@ -221,7 +209,12 @@ static bool do_vecop4_p(DisasContext *s, const GVecGen4 *gvec_op,
 /* Invoke a vector move on two Pregs.  */
 static bool do_mov_p(DisasContext *s, int rd, int rn)
 {
-    return do_vector2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        tcg_gen_gvec_mov(MO_8, pred_full_reg_offset(s, rd),
+                         pred_full_reg_offset(s, rn), psz, psz);
+    }
+    return true;
 }
 
 /* Set the cpu flags as per a return from an SVE helper.  */
-- 
2.25.1


