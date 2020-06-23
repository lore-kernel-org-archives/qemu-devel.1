Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE16C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1677F206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAipURx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1677F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpBI-0004JP-BK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojr-0004gf-N8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojp-0005r8-3v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id z63so10571843pfb.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SDD847ond76J9XGL5A29cRd+o3rpRZsV5UU2znfqmjI=;
 b=FAipURx3opxuS5QOjkETUoEEAZDBqFgjjCdMSYWZIKcz7hy4p7wyqt50wqZNYJwvoH
 TPJQ+TbzM72E/8nHmdX4xblHnQmrt30kb98r34zDxv8AuvHUWjZlYPdkYlkX/SaapZyn
 dpTG8PjCqCTO7cZRgEi1zDNrnDS61DrgqpF6k0tSuqdVRwZR3ehQtieA1GrVxaXYOytG
 mI723qM8CNPYVKRLbfjo/powfJ6LkamP54otVfSyhjQAzp+YzVYQHfnjzvfHLNfsCiiG
 wuHPUcEMbHnnTHwnir05eAfOU9Q4BlytgHU9aOgOLhjm379/Oo9Xs5VXFk9gYuqtBpcY
 UMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SDD847ond76J9XGL5A29cRd+o3rpRZsV5UU2znfqmjI=;
 b=WeXLoHhkElWzRI1o9Y1Sx7QXEZ8sOJFu12a4sur87ZIvHpuWbBrixGlsIGBWRAIJRY
 7Nl3cxbKkab1GE3V0pQSPpzVC+jXuysT0x/oVI3acEC+nAfYrbTQN3M5onoEWatIOlVk
 etvkHVq99FU/yatOW6HXoKlRGdurn/gyrf5R6mhsfColfdt2mcjNRx5wvO6HkSLnxjLR
 moLjS1zO+6HLlMXLYpWSg+VPVeDLMeh+utqJxtl776IQddZtn8ou6ho8nlE85auGzSTi
 pVW0I7MRw3U6DExA/7w0lC8i0yVUL32TzQvkRYOXFeToJxAIznL7/F51hFsqMuJT5wyf
 JjIw==
X-Gm-Message-State: AOAM531IjrWFJlzwz15zLtc6Ks+oCI+sIz3pd2K871FjBAdYX1kk1eTn
 qBNY6BSbbOw8ADvn3rzcQ6134mzo8ac=
X-Google-Smtp-Source: ABdhPJzRLoYTKEl5Gq59KsNMoSgo0bLIgGjSYRmOomF3WEjq1YEL10QsmByv94weZHv1pq9+H03WPA==
X-Received: by 2002:aa7:9d9a:: with SMTP id f26mr25575927pfq.229.1592941063433; 
 Tue, 23 Jun 2020 12:37:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 31/45] target/arm: Tidy trans_LD1R_zpri
Date: Tue, 23 Jun 2020 12:36:44 -0700
Message-Id: <20200623193658.623279-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the variable declarations to the top of the function,
but do not create a new label before sve_access_check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v8: Split out from previous patch (pmm).
---
 target/arm/translate-sve.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4fa521989d..a3a0b98fbc 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4883,17 +4883,19 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
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
-    TCGLabel *over = gen_new_label();
+    TCGLabel *over;
     TCGv_i64 temp, clean_addr;
 
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    over = gen_new_label();
+
     /* If the guarding predicate has no bits set, no load occurs.  */
     if (psz <= 8) {
         /* Reduce the pred_esz_masks value simply to reduce the
-- 
2.25.1


