Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3416C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BEC2242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyYiNtpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BEC2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcDU-0003xb-5L
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7I-0005nh-3R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:16 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7G-0005o4-Il
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:15 -0400
Received: by mail-pj1-x1044.google.com with SMTP id p21so1851120pju.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h4nXGEfFKdYYxAxVCeZfgKCWCHDlbl0aB+zYefgN5rQ=;
 b=PyYiNtpijz7wMq4HYzU5qdF96xEJtzQk3tGL+6IPM1IsUfgJnHWrAQsnvIXmwd3yDI
 fnyP/0wo+NZY8AJsaSQa58A2Z9XIDJj7Z+HOPRqfLh/oGWpivGJUqSH6gBB8fmpaHap0
 F1iWBju8kLfRHcfi+IJl1IFYVx62fHiGlks1hl+l/DBxxHjnNnKqnqiDFoySClTC8gwG
 bGhniQ0SyT3fPFxeLvhbELt0xXFwHPUrlvz5iQAeOLaK9p6CIwO+DzmPovAQnY9orQjn
 LtacQ9M/VmRTmbp+raEvxeabkPs5GYOLO4v18Sh1Qvwzi2kMrmQk5WDqQcvxN7Xvqj1c
 zfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h4nXGEfFKdYYxAxVCeZfgKCWCHDlbl0aB+zYefgN5rQ=;
 b=dAKKIEdDovBReKYJ48d5QN8q0m8WJDb4wMf7smJEVQq46kHSCOvrpfDIwmTOgAQA7F
 U7kN7ixAe/FkhJ0X1m6bRj04Alk3UnOcR47b4AVRVTim0A0TXLZQWR216m66HGPLvhN3
 RLRnwXA9opf6bzBEa4qTooxOm61tCmL8Fh9WpJkcD4Vbn3BHMTwFufglrs6yjv1dBvkj
 uI4m3FzrAFA8HaAFwnqoo9tlsAa/zsudD/VvT8LmZB1TL90sMy6W6CZBihLvetZo+fww
 wuYy8EkcHJUmck67i9PyCsQIfRHpma4IOolIPDujSxkkp4TzGKOlRTgOTSNc5iHeeyMr
 OARw==
X-Gm-Message-State: AOAM532ABffBRdiZ+Kz5pa0/7tq7mRf0MsJrNcUDYyX+ye9VYKlOkSyu
 xsUjYzl8259OPsFirJZIJF4eXB4suGxg9g==
X-Google-Smtp-Source: ABdhPJwT6X2otPFypp+dQDOwRfMzfol41PIIJ3cM+9vOwh10Bm23u1VhW38ndWkHCPygfQbHiiMCAQ==
X-Received: by 2002:a17:902:7d90:b029:d6:3192:2bd3 with SMTP id
 a16-20020a1709027d90b02900d631922bd3mr5480370plm.72.1603855632911; 
 Tue, 27 Oct 2020 20:27:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] target/arm: Use neon_element_offset in vfp_reg_offset
Date: Tue, 27 Oct 2020 20:26:56 -0700
Message-Id: <20201028032703.201526-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
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

This seems a bit more readable than using offsetof CPU_DoubleU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 88a926d1df..88ded4ac2c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1122,18 +1122,13 @@ static long neon_element_offset(int reg, int element, MemOp size)
     return neon_full_reg_offset(reg) + ofs;
 }
 
-static inline long vfp_reg_offset(bool dp, unsigned reg)
+/* Return the offset of a VFP Dreg (dp = true) or VFP Sreg (dp = false). */
+static long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-        return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
+        return neon_element_offset(reg, 0, MO_64);
     } else {
-        long ofs = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
-        if (reg & 1) {
-            ofs += offsetof(CPU_DoubleU, l.upper);
-        } else {
-            ofs += offsetof(CPU_DoubleU, l.lower);
-        }
-        return ofs;
+        return neon_element_offset(reg >> 1, reg & 1, MO_32);
     }
 }
 
-- 
2.25.1


