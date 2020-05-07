Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F3FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C236820A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPamNmxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C236820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkJm-0000fN-Vk
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkFe-0002ZO-ES
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:24:02 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkFd-0005h5-I2
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:24:02 -0400
Received: by mail-pj1-x1044.google.com with SMTP id mq3so2932815pjb.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JDlFiCjVr5xHxciN5joXRaUK1WSJQwdyA4WuZ989PgM=;
 b=jPamNmxOcXpYg9gdWJg1gmYijQWrOlp48jjB8HSlbYTN9B1K6rQHL2FRECq1sINIeX
 /JWTsTF3FRthwOHIKW9Pqwj4g2Nly+U2peT5C3GzJHnAEQ7WWST1Ozf/Nar6SF5bR9aR
 /JsTjIUoAxrmlT62X+cdIHzWeiSNSa7F6fLxWWKhcWttP8fYR7Oh0y9UI1INvloMIPZw
 BreWkQVLBwVh7m0Dc9/fEZroupZ7dIbczqwJVEnpiYrGGCkRgYKKshWM89NDa4vTo6E7
 HAYij2bPCvq84JAtuN4/He+YGbX+s5yI7opgzZxrjVAIf6TUoSIqS2kHA6ZLONTrXyG+
 q1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JDlFiCjVr5xHxciN5joXRaUK1WSJQwdyA4WuZ989PgM=;
 b=TQv7Fcx3cHckUYcjZ//U//YX296j+GoGIcgvxN9MI4sx1bMPJzeCAd8PmOudMWHBY1
 rf56w5LDZA7G1hcYEflMYeI0Un6BLdERXTA61yUMKw5NlEb54e1OK5yg0eM+Ro0tYcr9
 mPtoP0LtlruLMLmhQq+Rl8TJ5j9oiEKUBkTgNs0blohuc4e3q/ekDUFlMzp/lBsEVCxC
 IXzZ9vpfUl9T8fMuinVEnJC0VRloC7E7e+1/f42TAh0/Cy+z8nhvnhk+WAbUb4NLuCqY
 L+DEoClacSpwj8GLmoOkvjunZWPrLs6A2SLrYki+2FmsuLD8LRay0/ShkleClyxC2zRD
 RyZw==
X-Gm-Message-State: AGi0Puaeo/u0GRzeAtqFrudACYZ0IEPwM3KiocFEGKNiIbWETo82CIIr
 a2c2fsjSa2hn8POahoUNyGX8PoXyy6c=
X-Google-Smtp-Source: APiQypK3j2oV23f6kwFGM3rOxkYG2/S/NybkJ2uW8VHvx+OFd6F+YL07RJqSDP6cr3QffcxkL6ACUQ==
X-Received: by 2002:a17:90a:8815:: with SMTP id
 s21mr1244170pjn.154.1588872239509; 
 Thu, 07 May 2020 10:23:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 19sm312228pjl.52.2020.05.07.10.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:23:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)
Date: Thu,  7 May 2020 10:23:52 -0700
Message-Id: <20200507172352.15418-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507172352.15418-1-richard.henderson@linaro.org>
References: <20200507172352.15418-1-richard.henderson@linaro.org>
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DUP (indexed) can duplicate 128-bit elements, so using esz
unconditionally can assert in tcg_gen_gvec_dup_imm.

Fixes: 8711e71f9cbb
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c8649283be..83614e9e70 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2044,7 +2044,11 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
             unsigned nofs = vec_reg_offset(s, a->rn, index, esz);
             tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
         } else {
-            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
+            /*
+             * While dup_mem handles 128-bit elements, dup_imm does not.
+             * Thankfully element size doesn't matter for splatting zero.
+             */
+            tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
         }
     }
     return true;
-- 
2.20.1


