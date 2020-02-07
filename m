Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36773C35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BCC20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPLGpvX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BCC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04kG-0005IT-68
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hb-00086J-Iw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04ha-0002HT-E5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04ha-0002ER-7j
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:50 -0500
Received: by mail-wr1-x432.google.com with SMTP id u6so2985012wrt.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=80J78t2XuOP/qHYw6VsV0YcPao+P7Of2KkB0sDJy0gY=;
 b=pPLGpvX1qr1IRkgrx3okUHGvnIWpmRdJsPZBDn9IawlT2NbS26mIfZTzhm/coB2kgP
 BsavQ30CEaTNsEzHDAHP5SyVr0VghF6TMNpcxrngq6A+63DXjMRYpyiHSaqX09NIfmeN
 tlCsILdUSUC5rFmEIe7mh1D2mZxVH5uBl5N1qlK98oPGnhLlE47Cz+zeoahU0bo21MIq
 W5YnxCz/HRn9RwImWqOqmMnEuEs67JQfqVqOFKMl5LOKqSOHUc+JLExHtaJ08Dv5wNVL
 ITlV5YXX7aQVFQGhL7KlwKzKmlufHS8DoEbXxjPnwkrtOdqwBS+xEcbZWTtAMpJeCN8g
 V3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=80J78t2XuOP/qHYw6VsV0YcPao+P7Of2KkB0sDJy0gY=;
 b=Tg7yE05pNOHHLc8oy6Nx5/71nTFclDt+D5D10kAYISm5IRmraNVVBs0w9gcxQe9Dju
 ixKs7P6LXuST+AwvilMUC02nVwgGb8qYoEbo1og6ZBw0GDy0mblVOgN20n2JRBvFXU7z
 zJ2MQeYhNPJEJaRzYvcTl9J4ve5TWNL8fu7WiqLYHGNR7u/0gJxc5lxiadzoooHEmLeO
 wpSyRNnGeB2SzNzR+BRHBHoJ76Zz0+1c0rdk1I/Cj6+9KLU30O2cs4QPDtKc1Htxci0G
 CAb6DMY6CTH6IIL8F5S8ILlwaEADqklL8WcKBDWtN2qsQo7DX2leqABxERCRvmWLrlA6
 ofQQ==
X-Gm-Message-State: APjAAAWMJcTj3YDE/qEH7+t58YDxhXYcgx3iK7ivPFEMpMESCNCkONIb
 vLtdQ6Yl29SoegR92PQZQLQYG1CwR9E=
X-Google-Smtp-Source: APXvYqxYzmsGaFSB39ayd8WzgFtEPPl+dC9x3sZAa5SNvq97lg3USYySCdmztjWnFX29FVuTV+y6fg==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr5138489wro.104.1581086028929; 
 Fri, 07 Feb 2020 06:33:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/48] target/arm: Enable HCR_E2H for VHE
Date: Fri,  7 Feb 2020 14:32:58 +0000
Message-Id: <20200207143343.30322-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 7 -------
 target/arm/helper.c | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2a53f5d09be..0e68704a908 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1424,13 +1424,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
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
index 19a57a17da5..f5ce05fdf33 100644
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


