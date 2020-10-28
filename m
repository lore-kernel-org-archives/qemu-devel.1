Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DBFC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390302242F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="reizS/99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390302242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcK9-0001zM-8V
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7S-00065e-HL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:26 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7Q-0005s0-Gc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:26 -0400
Received: by mail-pj1-x1041.google.com with SMTP id h4so1788355pjk.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pq1quEEZ7i20Esg7262druvuILVuWDN9u6fa6Cr8HCw=;
 b=reizS/99RjdBccqfoiG7xNyGGiXBccDhMG6sdRcdl7cmLmPLxSWxS0/bzU56r5w+/J
 wrxKsq8prZR5YP02Ac3+XHx2EQcE43ybIBv0oW34rBhhDIXgnTxl4sAH1quvoL3GMAmk
 /6HsHWByUS89q9KvW8snhy0kXz2aSXkGIa4xYIsk4MwFJ5n0ZRUpZDkNqeagjbvBQA5i
 IRwkWT5ctLwh5RRyYmNE8OTzn0f9dNzsL/5Wt98fqtUY92Gr7NVDA6STKwh/S7HwQYnI
 mTGdFWYQjo0rnkOH2Exw4bLWOPookVkdh78jxIksDGB2qsxJzItVx3ePyyU/J28xvtuA
 ECvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pq1quEEZ7i20Esg7262druvuILVuWDN9u6fa6Cr8HCw=;
 b=VmIoPKPSth+42hMX8uu9beWJsqTM9wdXbEoyF7DcadZRF4Hns2rTaiGgx+sLC77DhL
 LKRIiTW5JN2imN+piNYvIsTNfpN0LEzREV+Nyp5FxBHS+hVqB3FHNNxkmxRQX2YBBL4l
 mXXwYPM4O5hpDRHAH41GlL7F5ko1zbfr2iB8w4EswSlCnjw/GNolG5/M5R78X+L3Zigw
 FHRS07SVUieJxTRWAOh0wVd9d8LnAeF7dQopxKw/0JatmEyJ2MZIhbWb57H9e/XK2yIA
 MYDgMF1n4+SToX8trByNCuEn2PMq2db5547NXUts4boCbKSpK3XgnWsy3nq0PqC4uU5v
 QMqA==
X-Gm-Message-State: AOAM532GP10YcG0rvM9DQ1x3pJ2eAS2k006SHsqmMtwM7JtxYjttD8ru
 LWoYGauff35+mpgVJSrUzCMVPH/txwUCcw==
X-Google-Smtp-Source: ABdhPJxeVf27/jvCi9ZHkw3nAXykDRfBmfTGLzZ4PtfmYoZY1ktxnydNk+BcPpD96e0r/4XGZL//FA==
X-Received: by 2002:a17:90a:aa91:: with SMTP id
 l17mr4756168pjq.198.1603855642741; 
 Tue, 27 Oct 2020 20:27:22 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] target/arm: Simplify do_long_3d and do_2scalar_long
Date: Tue, 27 Oct 2020 20:27:02 -0700
Message-Id: <20201028032703.201526-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In both cases, we can sink the write-back and perform
the accumulate into the normal destination temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-neon.c.inc | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 7a0269970c..7cd41c79ec 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2037,17 +2037,14 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
     if (accfn) {
         tmp = tcg_temp_new_i64();
         read_neon_element64(tmp, a->vd, 0, MO_64);
-        accfn(tmp, tmp, rd0);
-        write_neon_element64(tmp, a->vd, 0, MO_64);
+        accfn(rd0, tmp, rd0);
         read_neon_element64(tmp, a->vd, 1, MO_64);
-        accfn(tmp, tmp, rd1);
-        write_neon_element64(tmp, a->vd, 1, MO_64);
+        accfn(rd1, tmp, rd1);
         tcg_temp_free_i64(tmp);
-    } else {
-        write_neon_element64(rd0, a->vd, 0, MO_64);
-        write_neon_element64(rd1, a->vd, 1, MO_64);
     }
 
+    write_neon_element64(rd0, a->vd, 0, MO_64);
+    write_neon_element64(rd1, a->vd, 1, MO_64);
     tcg_temp_free_i64(rd0);
     tcg_temp_free_i64(rd1);
 
@@ -2670,16 +2667,14 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
     if (accfn) {
         TCGv_i64 t64 = tcg_temp_new_i64();
         read_neon_element64(t64, a->vd, 0, MO_64);
-        accfn(t64, t64, rn0_64);
-        write_neon_element64(t64, a->vd, 0, MO_64);
+        accfn(rn0_64, t64, rn0_64);
         read_neon_element64(t64, a->vd, 1, MO_64);
-        accfn(t64, t64, rn1_64);
-        write_neon_element64(t64, a->vd, 1, MO_64);
+        accfn(rn1_64, t64, rn1_64);
         tcg_temp_free_i64(t64);
-    } else {
-        write_neon_element64(rn0_64, a->vd, 0, MO_64);
-        write_neon_element64(rn1_64, a->vd, 1, MO_64);
     }
+
+    write_neon_element64(rn0_64, a->vd, 0, MO_64);
+    write_neon_element64(rn1_64, a->vd, 1, MO_64);
     tcg_temp_free_i64(rn0_64);
     tcg_temp_free_i64(rn1_64);
     return true;
-- 
2.25.1


