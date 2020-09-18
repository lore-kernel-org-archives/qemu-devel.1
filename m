Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F772C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83D321534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLcsD7Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83D321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLLc-0004Ul-Nm
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGj-0007LL-7n
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGh-00072h-Ju
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id n14so3987321pff.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VmRUb+25uU2BYgui1TfG+LmGUzhUne41PY164owiyR4=;
 b=XLcsD7WgzUlsqrCiVEvXnH66HGB35YC5t/YGz1osG45DA4qNpkArIMRwfQJ0gkK4XJ
 gO9KBXPOsjZzuLGGkdTBRng1oLzhlfumnfeIm9HIOc+CTsWmE0vk0zleYXRBIMbJZyYB
 fXbPOG1S89tadiUgECStbuO9c8Qtd+1usUsJFH54+soBdpPNCoCvNy2RNCIOlkqTFl1b
 cIbCCsIY1LYYY/dUW0M3ElDW/moOaQHRumr057BBWd3enFXD4hiYvV5s+sWYueRNiGOx
 YSqSQ15MZuz9oVs80pl+QvImGottaFoqQKUdcYYRuKrpovtmSICzkzzj/1O/x0mwRpyi
 zTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VmRUb+25uU2BYgui1TfG+LmGUzhUne41PY164owiyR4=;
 b=abpOldztRVVzuNvqYhSzOlyVTztrIo6eYEZA/BSKhTfl12JGI+JT6A19KfNeIjZeD6
 y8rHVVAv7ATzmjXw9m9nyxjRqsTGCis8WWh+6r+X/LPZB7rXhyRVJP1wj6abWyJGSzhR
 9fxO6VWuxuAtKRlT/95aHfo3gj77VDtMxipKS5D+sYC/9PKzuOxfpXkkvTCI0/tXv+0X
 LBVUEJqIigNq9itTfAK1nZz6hRpGKNBUBFFv7R/dtKDuw3UftbIBeUqb5lNBnaFpEimA
 ApPLk0t7h/hPL0fVwsv6VC09zfdbBXxLt2y+Dbc8f+AOCpv1FWxc2us2YEkvQgS8VL39
 jRHg==
X-Gm-Message-State: AOAM533c/CRRplv6rI8tiFj/IgK/ruALXFnii5h7xg19NkqLh+7CrLeT
 4p7PZPKSp5IUlCDnWaP/SVc+WTvSX6q7XQ==
X-Google-Smtp-Source: ABdhPJxSgL/GUqEgJtUeKXgNql7hOOb8Q21mBa3p7fQX4ZCMKBzcm9O/lg0AOerTI4PeJEB4nnbTug==
X-Received: by 2002:aa7:869a:0:b029:142:2501:34d1 with SMTP id
 d26-20020aa7869a0000b0290142250134d1mr17692667pfo.42.1600454277893; 
 Fri, 18 Sep 2020 11:37:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/81] target/arm: Fix sve_punpk_p vs odd vector lengths
Date: Fri, 18 Sep 2020 11:36:33 -0700
Message-Id: <20200918183751.2787647-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, peter.maydell@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrote too much with punpk1 with vl % 512 != 0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b8651ae173..c983cd4356 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2104,11 +2104,11 @@ void HELPER(sve_punpk_p)(void *vd, void *vn, uint32_t pred_desc)
             high = oprsz >> 1;
         }
 
-        if ((high & 3) == 0) {
+        if ((oprsz & 7) == 0) {
             uint32_t *n = vn;
             high >>= 2;
 
-            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+            for (i = 0; i < oprsz / 8; i++) {
                 uint64_t nn = n[H4(high + i)];
                 d[i] = expand_bits(nn, 0);
             }
-- 
2.25.1


