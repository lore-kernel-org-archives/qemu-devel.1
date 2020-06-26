Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9562053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GY1hZqsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9562053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jof6o-0001IT-D3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5j-0007fi-C3
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:35890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5h-0001gr-JV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:31:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id 207so3866178pfu.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wq85XPdwWHXx5G5Rb/Fdn/pZNR+DRC8JYM81MVGPwCQ=;
 b=GY1hZqsZ2Uhq6t5lk+3tsRrGIU09JoB+OlWnLtzuphtZuv57jzvyclJFz7R1QiJ54D
 G3hWszSHfLONCC0+nPFMWelAlh7ibX1U9m2yTZh5KFSSa3AxjxOy9v690IPBe+bl3dPZ
 pylSdNsejgEg2Yj7k1zA94E+YJXxhm7C7uHyCVikNEaxaCxYLIlvHc51ZUJ5mlShH1on
 b0EV81n8siF7Z1ICRwHnHRUVleXAi8uUaPgwl4wYsr3lGUX6+J3XE19TL42LFFUQw68Q
 XX8uhs1RFqJJ8Sn9hAfbao6iozgZBCj1IHziSlxuwAo8ro2pcv7u5K4GUM9XUBREKYab
 H3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wq85XPdwWHXx5G5Rb/Fdn/pZNR+DRC8JYM81MVGPwCQ=;
 b=JapPfHFLGiPxEooRpkn0mvkcNpe6QOvdbWF2iA8g03IbYTHduTihdCLiNs7XgFvMf8
 DH0GIyBtTxQpRPKzNm4e/gowrUpILy1H6tiXDGC9cn2Oj9riFtonvgCw4SMajzaJIeij
 1ReT+6yvNP6ugHN9kT0HFGcXF61qycVyQgzecu9vkv6c4KAFUKGZtiZeUmMn7+iTXGwd
 u0cgBAdJmdDx317mFhu+XA+4L8xh099DUCX2uIO9ahIw6XP4/PWsCq//ZU8I2u+N/ld3
 JmVF/vgBu8GLoDiELLDZyoBlSwVwI/5V7sevub9zM92ghGtVJ8N5fKX7JJfZbfmqjozx
 8XAg==
X-Gm-Message-State: AOAM530qKCM74sgA04AzxKnEpTQxWhpcKoKqHzwN9rYnA09CCRMRgHvt
 nr4th4t8FcA040qvIe6aBYMHFPh9elA=
X-Google-Smtp-Source: ABdhPJyyrhtIooWJePQxPmtZRTkatgUuVUk/5aaCeM9H9Y0z+fIgRa4Mawook9uZnJ5IddKX3hNMMg==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr898001pgn.127.1593142307849; 
 Thu, 25 Jun 2020 20:31:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 01/46] target/arm: Add isar tests for mte
Date: Thu, 25 Jun 2020 20:30:59 -0700
Message-Id: <20200626033144.790098-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cf66b8c7fb..ff70115801 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3814,6 +3814,16 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
 static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.25.1


