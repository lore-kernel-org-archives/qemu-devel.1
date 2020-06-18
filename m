Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA13C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676B121852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQxNxuLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmE3-0004tj-LO
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8c-0001i1-K1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8a-0002Fz-Cf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id 10so2185893pfx.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b3K+zIM1Nh7bQpMoCRdNNiakP69Zq16vTWuZo+DM7NE=;
 b=EQxNxuLMUVLpSKljQbbj/LFwkmPkawLgGeHmeEy0Q3tRdJsXR68E383Q+mPRUGMVAk
 7/T85EA2JIxwHY0o++KAeReI/8x0htVgo3A8umD0IPkNEvjQbJlpdNc1KGK1wLxfceG9
 rpgIkt9jGh5VMcG5Pdt1eF3ioZFrJTBWYkxToLqaZv82o8N2R8A0uv4T4SH2aYV8tQWg
 0DXN6JOkwLHfuwZywfIoxpQrkpHQ9fH4zx7Drj5oZnjJx//Fp1PA0d6NsWuwh+5JU3/z
 TAm2q0NMfQSN67QBlREJH+HXOUvzM3LQPoEzr5PTEoCrNDWPOuOGCOo8DUQvDeVFu8g/
 4CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b3K+zIM1Nh7bQpMoCRdNNiakP69Zq16vTWuZo+DM7NE=;
 b=LVgfVUhU/5QKUlLcemFO/GskXWkT9IbJLaxNhHN8LmeouQmSdffXbmuKjramHaVZRd
 oEFwIsdBK69njDu0237CsgbWzjP9u7PhRfZdCv8sf1RtinkCNW3zYFC/Nt8yd41GuwHF
 LsZCS8tEk5y/wAU3ewcV5S49c84oq5BTJVQztZsoRNSx4e9zgMfA8u9V3J8RsUtXAZrB
 izbGCo7JAN9alXamK41VNW1gaxBmeQCTSaTMbeLxMjKl0AXE4i9Od/jwSvFaQZq2kB2k
 VIBJyQCMvkDUVIlVxO+4HVYjoqjhn0Q90uOPjXRTHnYUEr7AbW1GtPgpSu1CVnU9VYxT
 hIiQ==
X-Gm-Message-State: AOAM531AYLcbekpD57VIKQv3Dmb0HTsggkILQNTJXgSEFY0EWOjFBmsj
 dbC8IFTtm/UfYtySo88mbkLk0APwDWo=
X-Google-Smtp-Source: ABdhPJz0IhfwLcUJpwEJnb+PUTW7r1q07FVT9HtBxxizOpQs7wt+Qpxqzv6Jpf8vEbnBwQA5xzm/yA==
X-Received: by 2002:a62:1917:: with SMTP id 23mr1935522pfz.272.1592454410476; 
 Wed, 17 Jun 2020 21:26:50 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 003/100] target/arm: Split out gen_gvec_fn_zz
Date: Wed, 17 Jun 2020 21:25:07 -0700
Message-Id: <20200618042644.1685561-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

Model the new function on gen_gvec_fn2 in translate-a64.c, but
indicating which kind of register and in which order.  Since there
is only one user of do_vector2_z, fold it into do_mov_z.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ac7b3119e5..bc286331cb 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -143,15 +143,13 @@ static int pred_gvec_reg_size(DisasContext *s)
 }
 
 /* Invoke a vector expander on two Zregs.  */
-static bool do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
-                         int esz, int rd, int rn)
+
+static void gen_gvec_fn_zz(DisasContext *s, GVecGen2Fn *gvec_fn,
+                           int esz, int rd, int rn)
 {
-    if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        gvec_fn(esz, vec_full_reg_offset(s, rd),
-                vec_full_reg_offset(s, rn), vsz, vsz);
-    }
-    return true;
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn), vsz, vsz);
 }
 
 /* Invoke a vector expander on three Zregs.  */
@@ -170,7 +168,10 @@ static bool do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
 /* Invoke a vector move on two Zregs.  */
 static bool do_mov_z(DisasContext *s, int rd, int rn)
 {
-    return do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zz(s, tcg_gen_gvec_mov, MO_8, rd, rn);
+    }
+    return true;
 }
 
 /* Initialize a Zreg with replications of a 64-bit immediate.  */
-- 
2.25.1


