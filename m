Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FDC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2582071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUAJ6LrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2582071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaQa-0000x2-8y
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI0-0000cm-ED
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:40 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHz-00017o-IY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id x4so8238188wmj.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8dAcnSfr5sUHRwiXoBAzSe47pKA2tc++F2fTPLGKuZc=;
 b=KUAJ6LrQIc/3hRb7Q5ezT5UdYRXNEI6+mGwtE/D62DShNRH4cj2moHETCcNW/fiDcv
 XG3LzMfOu+dhsWXCkoMQQRU7Se5tPK8M5q4XOM3mPnNOMYr798Vj50vnYc8nFtyUYQeQ
 DEm+S9BkGIRvxuk6tHZluR7prfWewVqBe98UiHlIS2VbbdPpiCCeIoP8biN+m1xVd1wH
 S1mYliiVDf49YUPw8I8jpUCyfzpC+2knouN18Z+Ejfdiq4He50R3bSXrlrHJG6BI0AM8
 +Sy9mnwNFHabI1H2GtE/M/2BZaD4gyJMfQcQBIiQ9PQ2eshQ2ArPQjGX6Snh1+NMUfbO
 LqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8dAcnSfr5sUHRwiXoBAzSe47pKA2tc++F2fTPLGKuZc=;
 b=iQRBkcOa77UNp1ZRwYQ9/tdaUUZ0AeuMv48XNuqetAdd7F4gZCvGyIbySoLUb7E3DF
 g9HW26DkiVEAhS+46n2R4g+w6ddbajZoMakt6R4CfTZAJR4KzCkiAhz053V+lC/kQbal
 XouacnXtOBZQPqYHga6I69m/VfEfqU6TSO3hoglwOgrKVvwGBma8+NRVvMF3bpHbnLkS
 uobg3bEYJL2RcLEFU9tgl3f6u+WpZ9gIb1kI3slCC9bOGF8rggUQJPaLtWGn2/VdSCiY
 oeqLiG8HD7Odu5uO9vfple6IIOddruK5SD9XSze19uCkd5dDRGIGbnEQxhugz8s3aYKa
 zJSQ==
X-Gm-Message-State: AGi0PuYzCDnoDelmaOya6igkGJwyZGKGsY46lYtOzna6U2VTEKO+mjBc
 28ZgsqE5PydTEsBZBmu7XCw2dUMTTeZ0Fg==
X-Google-Smtp-Source: APiQypKG7wUF3wsbfOBigr5F2AFbZZiNTNUHPIjKLlaaWkvw7JQsrBzNrEYmnHrV/M9Gx4Y9WJU3BQ==
X-Received: by 2002:a1c:a794:: with SMTP id q142mr14327206wme.4.1588595615024; 
 Mon, 04 May 2020 05:33:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/39] target/arm: Don't allow Thumb Neon insns without
 FEATURE_NEON
Date: Mon,  4 May 2020 13:32:51 +0100
Message-Id: <20200504123309.3808-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

We were accidentally permitting decode of Thumb Neon insns even if
the CPU didn't have the FEATURE_NEON bit set, because the feature
check was being done before the call to disas_neon_data_insn() and
disas_neon_ls_insn() in the Arm decoder but was omitted from the
Thumb decoder.  Push the feature bit check down into the called
functions so it is done for both Arm and Thumb encodings.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200430181003.21682-3-peter.maydell@linaro.org
---
 target/arm/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e3fc7924428..4cf5267be00 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3258,6 +3258,10 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 tmp2;
     TCGv_i64 tmp64;
 
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return 1;
+    }
+
     /* FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
@@ -5002,6 +5006,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     TCGv_ptr ptr1, ptr2, ptr3;
     TCGv_i64 tmp64;
 
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return 1;
+    }
+
     /* FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
@@ -10948,10 +10956,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
 
         if (((insn >> 25) & 7) == 1) {
             /* NEON Data processing.  */
-            if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-                goto illegal_op;
-            }
-
             if (disas_neon_data_insn(s, insn)) {
                 goto illegal_op;
             }
@@ -10959,10 +10963,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         }
         if ((insn & 0x0f100000) == 0x04000000) {
             /* NEON load/store.  */
-            if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-                goto illegal_op;
-            }
-
             if (disas_neon_ls_insn(s, insn)) {
                 goto illegal_op;
             }
-- 
2.20.1


