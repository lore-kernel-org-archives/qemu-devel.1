Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC49C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DA020716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apKe758o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxHM-0003I3-Ua
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC1-0003Y4-63
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC0-0006hc-5b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:21 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxBz-0006fE-W8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:20 -0500
Received: by mail-pl1-x644.google.com with SMTP id t6so594597plj.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rTQU923fsMMcx9+LorcmqOCU1SgJ9njP17/lCw46c9M=;
 b=apKe758o243LhK53nTuGC6pehIvt5b8F40bu31M6disFBX3YKI4TYlgm89Ph7yxl3U
 ZWy7vPMqVl16Gs2wNLZY3DEmcCSNuDXI47WY/0hblvD2WeqwkmWKDZi2bXgRRihKRlEr
 Q941w1jKfx2zNnfRGUKuGhSaPoJguv53jy+/DA2yEcYaI8ja70ODtSeC5/JHS7+Hqhji
 Pam/6ZfXmxyFaWyW7qwX8K1vunWOG9alF2Sr91LWj5/350iqAB5VhVVmkx+JcKOM1cJf
 Q46UgxgVUF2N0fN8ipKEXWF/147n/FsMLzAwQZ8ym/kD+G/NBGVnifKO2tLa2HILC4+z
 uiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rTQU923fsMMcx9+LorcmqOCU1SgJ9njP17/lCw46c9M=;
 b=C1m6sb8geMlNwRVySybDPdyod0z8c3auTMui+Z1BiDmHN7C1r8UIZVOQc4A0htrHbg
 ryo7m19WOUpkfGOem+y5TdOKvXKHh/8EfkyFT5yPSVhjMNu6+5tfJe8FOIik6dEPAdEl
 E6dj5L+lh2GZH642lettppMOI/uquFr2HfkvllxOccJYu6do/eoXrG/M7F6/wOy5n5v3
 mfqAwe1Vtr3H/hRpUaZid1xwbp1yCaeHTcTEOjXL5YslcwKz6lrAgNHtx4Xc363F5STn
 wx8VR2UNQhvRZ7eWIB/WYWYyV0/GVVuhZt6I45oPesBcHDcwhE1gakQEG/5GmuGSn/aM
 QeOg==
X-Gm-Message-State: APjAAAVoAs2+1UdABt4ekehD2EoaXAy76na2eyCEEgSrsDZ3rtpfo788
 nZ8I62TjxQNUWw6c4e+JFRhAIhbiTv4=
X-Google-Smtp-Source: APXvYqwkgqYNgJgCsvzjiIIinw/Fe0CwIs7Y9Ln/djELn1zMxNVxYx6kV3q0HDpnK8JssNnyOqETUw==
X-Received: by 2002:a17:902:7e4b:: with SMTP id
 a11mr1913208pln.61.1580342178678; 
 Wed, 29 Jan 2020 15:56:18 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/41] target/arm: Enable HCR_E2H for VHE
Date: Wed, 29 Jan 2020 15:55:35 -0800
Message-Id: <20200129235614.29829-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 -------
 target/arm/helper.c | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0477cef1ea..239c9eb783 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1417,13 +1417,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_ATA       (1ULL << 56)
 #define HCR_DCT       (1ULL << 57)
 
-/*
- * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
- * HCR_MASK and then clear it again if the feature bit is not set in
- * hcr_write().
- */
-#define HCR_MASK      ((1ULL << 34) - 1)
-
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
 #define SCR_FIQ               (1U << 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a57a17da..f5ce05fdf3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4721,7 +4721,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t valid_mask = HCR_MASK;
+    /* Begin with bits defined in base ARMv8.0.  */
+    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4735,6 +4736,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
          */
         valid_mask &= ~HCR_TSC;
     }
+    if (cpu_isar_feature(aa64_vh, cpu)) {
+        valid_mask |= HCR_E2H;
+    }
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= HCR_TLOR;
     }
-- 
2.20.1


