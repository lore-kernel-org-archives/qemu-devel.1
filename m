Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17247C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D13206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5lLuU86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D13206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwoy-0003xH-Ph
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLG-0003yT-RB; Thu, 03 Sep 2020 17:00:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLE-0007cz-SJ; Thu, 03 Sep 2020 17:00:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id e23so4013768otk.7;
 Thu, 03 Sep 2020 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qTh31Rf/r01rqa9kv/3Kv1y/l40RMHvXG4921rSK/Vs=;
 b=F5lLuU86NBNOJXSwTxkeLFpMXiJkG0hav4FZB3TnChTvRFMaQMraUSDoOu0x3F65Xj
 Lg++2yXEAnJ6KZI3mJq04c5eBdhVep9/iGGS3Ce5q9JfEd9UKtdM2Tx+twK8+p9lDQ3T
 3pLdTUSduK26/IapUFMjYJRkQIzJ+d8TLHe+15byIkg7Fhx4Ff0MSHZ9YBuf4T1v5z3q
 jirXrV7PjOrNi3CT3fMTXF0JadcSqIos4s0WskEW9Gh85GilP1qRXp+hf0pUBQ68jAvm
 TZCekJIVWL/dkZe2y6l5goNG272KgGTQU+OdsppdTNL5axDHnFKJVksPhL7wEGs9jfTG
 FdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=qTh31Rf/r01rqa9kv/3Kv1y/l40RMHvXG4921rSK/Vs=;
 b=lpwTHOd7S07XHyuZSXvO1evhcLA3aGsxCR2h/3l9FoRU8ibYCNrKx2oaWYcOdDlWEi
 octFBek+0AmcOG5v9HzWhUD0273bpvXWKW210O9HrNtzaSd4YI9vPNEzD/+yx1GCoW4S
 XjQiUg60ZTTZ/ht7zju36FrVQnj9MTEBFKQYS+/Oqw/c30aBPVt6Iph+zm+43qJCtAm7
 U5tS4wakajz3rXKbYk+LDDYtI7Udpl0W7KxmiEkeXctiOvLPUve2shkNMdNR1DKSq/l2
 0fBKXjuDexCFMFUPUyTUHIVpOlRye9am15FizbmGPEZ/9Hcr6AFdQpUZO/UfVSVyzV3N
 ORGQ==
X-Gm-Message-State: AOAM532yTMXA2xEnBwfrdoc5L8EKZ5gf6a3gYeEgnzrenFK1UDBst99f
 ca9ka3BfjN8ec9yoPOEPK0O93KsJh3s=
X-Google-Smtp-Source: ABdhPJwnXs/a36zSYU2IRuxKnj2zUGliKwnIAFe8ex8OxCKS+g75naWsnkm1hC5IJ17De+bmeNP/Gw==
X-Received: by 2002:a9d:6e1:: with SMTP id 88mr3073463otx.178.1599166819269;
 Thu, 03 Sep 2020 14:00:19 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id n186sm831721oob.11.2020.09.03.14.00.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:18 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/77] target/arm: Clear tail in gvec_fmul_idx_*,
 gvec_fmla_idx_*
Date: Thu,  3 Sep 2020 15:58:20 -0500
Message-Id: <20200903205935.27832-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Must clear the tail for AdvSIMD when SVE is enabled.

Fixes: ca40a6e6e39
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 525d9b6d42844e187211d25b69be8b378785bc24)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 8017bd88c4..5ce111b286 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -737,6 +737,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
             d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
@@ -761,6 +762,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-- 
2.17.1


