Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85104C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2E3221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2XZ1IAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2E3221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLzx-0007lf-6Y
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIB-00014P-Np
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0007Gs-0x
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id j7so3419555plk.11
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l4iKSLJO0P4KO8p8doEML+s4OAJMNAjz9gFYt+6w6ZQ=;
 b=e2XZ1IAREOy6JNtBbiXfnWHxRtlwD7gdk3vfeHa1GJiHYrd+O6YFppKneZybOYQVdq
 D3JAhCi2gaJxtxbnvabW2dH2k/Ej/l4l3AlrmcPr67Ea2cQ3EJAinE31G0KfFf2ERmld
 jV3shRXJW1ak0ParjhynMjyKRblJRVt0okwAk5li/vbOSKLm0XSItpLVv9o7i5XFNQAd
 m2D9Aq273ojekoMTUqQETrx+zCqr7n6Gplr0cx07W9zUweLpJaPG0tzBVjBIjPQdRcnS
 uQr5FVy/MnjeVcWyCkUqHDZukYugJVjY1HByd7kt6C0DrFwxPfbab1kzqi0TxOkgxs3T
 fcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l4iKSLJO0P4KO8p8doEML+s4OAJMNAjz9gFYt+6w6ZQ=;
 b=pS5iNy0cz7OguZCgJVoUpRscev7hAscsBxtCPRka+reDVWGEfr/v4eBcRx2ilBhjGt
 Hni3SmB9VKRsUeJW46lhFjlYuDgubBZ/2OrxLS3QA92Q/l2q/1adxgTIbzD1SMLsixXq
 ROOvNmskhB9HAr2wpWHbHbRqv/Sl6OPW6I8iYSji4Ck+969IdlSV9PhCCdeGlIM+CwjO
 reZySWDmk6uIRp/Ml5xmIfLhImVxo+kQ+M9OteFvvYz3hL0yq/8IExml3EyLxbP3AiTy
 JPsrSct0fxClQ8rg025CnMVGnOg+9C7fuxA14GMrN1qTKQjlo9ztJtA9u81EDiRTzZ9g
 SjlA==
X-Gm-Message-State: AOAM530gmuXEjs16vQOnMJuxsBKgqutqcTmzwMPrGEKBxNmfI2k5SgwK
 EOQ8wTxaE2/px2q1LDFQc/ml4N03VIIItQ==
X-Google-Smtp-Source: ABdhPJzYzRXP61hGoe44hLUsEliGZGI3iUQ0IaHSb0QyQjTr4mAjJVGjzbDRmxL3wYomBCKPzg+B8g==
X-Received: by 2002:a17:90a:c501:: with SMTP id
 k1mr12830330pjt.170.1600454364474; 
 Fri, 18 Sep 2020 11:39:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 69/81] target/arm: Implement SVE2 crypto constructive
 binary operations
Date: Fri, 18 Sep 2020 11:37:39 -0700
Message-Id: <20200918183751.2787647-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 +++++
 target/arm/sve.decode      |  4 ++++
 target/arm/translate-sve.c | 16 ++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f5052a58a4..67b2834035 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3917,6 +3917,11 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SHA3) != 0;
+}
+
 static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 2ebf65f376..5f2fad4754 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1564,3 +1564,7 @@ AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
 AESE            01000101 00 10001 0 11100 0 ..... .....  @rdn_rm_e0
 AESD            01000101 00 10001 0 11100 1 ..... .....  @rdn_rm_e0
 SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
+
+# SVE2 crypto constructive binary operations
+SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
+RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index aa459ed30a..cb493d838d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8176,3 +8176,19 @@ static bool trans_SM4E(DisasContext *s, arg_rrr_esz *a)
 {
     return do_sm4(s, a, gen_helper_crypto_sm4e);
 }
+
+static bool trans_SM4EKEY(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sm4(s, a, gen_helper_crypto_sm4ekey);
+}
+
+static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzz(s, gen_gvec_rax1, MO_64, a->rd, a->rn, a->rm);
+    }
+    return true;
+}
-- 
2.25.1


