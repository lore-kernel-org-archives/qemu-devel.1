Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305ACC5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870CF21707
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTbF7YLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870CF21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6KK-0005wu-By
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66c-0000kg-Dd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66a-0005kz-LT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id h6so744480pgk.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TfVzROnVk/LIs9F3h/EHjDTQFqlTOcJcv8JLX8XmIrg=;
 b=oTbF7YLYyGQT7HTihCopuxq3YAptobgTXtGYMPsYm3LKDJMAHiS0FwdSG2XVBtlVt3
 G5sBB1+rQb2wNfFf06qj/9qmEPXZh4EAK+iCZZtjJqB3u4PDjHk50uVth56MUOWhPRpk
 6xYQqeosg8aIGRY48aVtZS5Lp1okKyOdrvnK6JQksFJLAKgsHvn41smr5NfbsVWOQgLr
 o0wzumgZqK6fJxFSJ1fq+U8UfvI/Io86iJQJcJDYEUlkOkEowLq5laty6Ycj3ezdy4M9
 0lF21UPObbfaKqz28cntCSHyj37cAJoW4mThL38DHFBbZsGfHQmC+2GZ33DmopjOEzmk
 f6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TfVzROnVk/LIs9F3h/EHjDTQFqlTOcJcv8JLX8XmIrg=;
 b=FbmA/x4q/dzh2X2bsTRzKE4RhCXUpU/dSSi3xdxUEIxRkAaltZUVU797Ynk31LVdX8
 /FhoDdTKaL6cOtKBPegE54G3ItCeKFUP792cTsv6uQZQIkR13zrs4LTLVq0rsF2ZAG4C
 F/dthi6FF1pBIkXSm0OqgEiTO2rmkqfs9oGdqMgj7+yET6IWdc8wOTURWO/BMIcJGGpF
 TlFQMTBqgjLEmk8IRxtAMrzzNUgZ3jhANh8xOWgIPRiuaNm6q+zUYa/fhsS7iEIwm9qu
 XWQ2cb4JRv/PV5ZHH5aLm0OXCIIC1sPp32HDbUHlnvESh7imWNHh20/FaajT0nNEqJYx
 mHUg==
X-Gm-Message-State: AOAM531JCH2oB2V8QUePPDWfAEuIPBUZ1k47XmVivchvqTh00+r1LrbG
 5W+JTfh1uSj89NurRYZh8v0zAz04nwsFQg==
X-Google-Smtp-Source: ABdhPJyRyryYjAE3m4z2Z8Npb8QNYnXCcrd+GAB2IVh4iZOrvbDZV3hIzo74ogCDBAzv0JgrLmZ96A==
X-Received: by 2002:a63:1542:: with SMTP id 2mr1646767pgv.248.1603255927019;
 Tue, 20 Oct 2020 21:52:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/15] softfloat: Streamline FloatFmt
Date: Tue, 20 Oct 2020 21:51:46 -0700
Message-Id: <20201021045149.1582203-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fields being removed are now computed in round_canonical.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3651f4525d..1bd21435e7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -527,10 +527,6 @@ typedef struct {
  *   exp_max: the maximum normalised exponent
  *   frac_size: the size of the fraction field
  *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
- * The following are computed based the size of fraction
- *   frac_lsb: least significant bit of fraction
- *   frac_lsbm1: the bit below the least significant bit (for rounding)
- *   round_mask/roundeven_mask: masks used for rounding
  * The following optional modifiers are available:
  *   arm_althp: handle ARM Alternative Half Precision
  */
@@ -540,10 +536,6 @@ typedef struct {
     int exp_max;
     int frac_size;
     int frac_shift;
-    uint64_t frac_lsb;
-    uint64_t frac_lsbm1;
-    uint64_t round_mask;
-    uint64_t roundeven_mask;
     bool arm_althp;
 } FloatFmt;
 
@@ -553,11 +545,7 @@ typedef struct {
     .exp_bias       = ((1 << E) - 1) >> 1,                           \
     .exp_max        = (1 << E) - 1,                                  \
     .frac_size      = F,                                             \
-    .frac_shift     = DECOMPOSED_BINARY_POINT - F,                   \
-    .frac_lsb       = 1ull << (DECOMPOSED_BINARY_POINT - F),         \
-    .frac_lsbm1     = 1ull << ((DECOMPOSED_BINARY_POINT - F) - 1),   \
-    .round_mask     = (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,   \
-    .roundeven_mask = (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1
+    .frac_shift     = DECOMPOSED_BINARY_POINT - F
 
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
-- 
2.25.1


