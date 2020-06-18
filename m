Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEE2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F67206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjudeb6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F67206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmxt-0004IP-DB
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEP-0006Dc-Ng
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:36656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEM-0003cN-3s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id j4so1918828plk.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=goCEuAkdLVUC4u1fLVEAfW8QjjUtS9gz8iEgnW8LE80=;
 b=bjudeb6NlxVEtSJ6/QyQ52hu4M0bfyFGIee/5LvUlTte5TN45JFy5E72/sQsav7wmF
 3iTEdUimTErk/iZjJs7FSGPwV5WxRx/ko6Fl2rA1OreJ87wnhXNtthuFXjkTJ5b7k79D
 eqFHefV4UWmjx8EsnwtfkzQlXrnOIWfv97tb1tbGSVsUvrjew+zzOiQ6bSjuyenUb31+
 ZilruYHxouuGT+qIJ3AHsEwON9lRro2xrFUYW/1Zh08XThOikQE9cPzhS8mJOH6nVVLx
 H/G187hPb3Bv7MKANHtvghM4SsxEVm5xHVT7nCL8bozY2JB+8hR/Q9iwtzi7UOeOk/Fd
 JGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=goCEuAkdLVUC4u1fLVEAfW8QjjUtS9gz8iEgnW8LE80=;
 b=UUO78zoyX70/DPNVMO1V1wEmfzkXeJ8ebF4NacenGG8n2B+BfBKiABTSW8nObarXxR
 KCO57p9/5QLEjz74Exn7qf8yKG6I9iP+VNyijOqGSLkwnf7b4Yqo04pxYktIVP+cTP/q
 mgK0HF+syJ3ST6q/cIXAEvOao+Upah7EDn48R6xsB/RTzct2LkZ7u5V6HX8rzJNjgZBG
 dnxoHsjWP0tgqFAYIaB3Z9s2MUo9hOj/edmCxEpYZAFgBytlDBW4/BsIuikeqZMwWpiG
 xp2ti9cEXyArRynmUYfzzH6gIMtmj8joxedG5TlLT/Efd2ZJu1a8T7Dq4WMzc3oS//iL
 4CzQ==
X-Gm-Message-State: AOAM532RCn/gPqxdcWmmIlBjW+paNGjdEZQlVYs0YeRTfbCGSgEP6YKn
 aq7pwlV4QmQynjmFJlvIi6RsrwvHw2E=
X-Google-Smtp-Source: ABdhPJzs++I7lBqMMJdsjk2AGlZwR70Rs+ljSMBJhyKpQjxxOkOq7RV0J+wltYYWc5YKMWCE6f8Gvg==
X-Received: by 2002:a17:90a:20a3:: with SMTP id
 f32mr2373887pjg.171.1592454767389; 
 Wed, 17 Jun 2020 21:32:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d2sm1165766pgp.56.2020.06.17.21.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 086/100] target/arm: Implement SVE2 crypto unary operations
Date: Wed, 17 Jun 2020 21:26:30 -0700
Message-Id: <20200618042644.1685561-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  6 ++++++
 target/arm/translate-sve.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0be8a020f6..9b0d0f3a5d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1551,3 +1551,9 @@ STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
 # SVE2 32-bit scatter non-temporal store (vector plus scalar)
 STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
+
+### SVE2 Crypto Extensions
+
+# SVE2 crypto unary operations
+# AESMC and AESIMC
+AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 152b0b605d..bc65b3e367 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7682,3 +7682,14 @@ static bool trans_USDOT_zzzz(DisasContext *s, arg_USDOT_zzzz *a)
     }
     return true;
 }
+
+static bool trans_AESMC(DisasContext *s, arg_AESMC *a)
+{
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zz(s, gen_helper_crypto_aesmc, a->rd, a->rd, a->decrypt);
+    }
+    return true;
+}
-- 
2.25.1


