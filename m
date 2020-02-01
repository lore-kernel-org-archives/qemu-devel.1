Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4BDC35246
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFAD20723
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVqusxt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFAD20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyTY-0000Cn-QH
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySI-0006z7-Ro
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySH-0006PG-PR
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:22 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySH-0006Ob-Js
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:21 -0500
Received: by mail-pl1-x643.google.com with SMTP id t6so4179475plj.5
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oFV70oqbuZ/Iy95AzfvjMyE40zNVPl8rlhZhKbOLyGc=;
 b=KVqusxt925s5xNMtWuBNbTLVSFlutSBAabOba8Xe8V0Jz4eRdkxjxCxFnzAdASqprw
 j8mW2kj4YNj2rJINMNjECS6CQdTukkGnZmcyjYYu/vmVKeaEodoisfrs7mKV20zveS3a
 nq2ikw/Ro6b5XzjsDseoGF2TZTojLWONKNhYZnfTQyOVD2LZV5ejFiyEn7oIJUwAJub2
 XZdrV0dAvwY/igu7n6RRkU+FYN46HzcAdynf7tV/W5dO/bbZqjhepanUyGbI5/WfxO6P
 tEdSZHdyMBakYRGOZQYM7pu/osl+hGcfSk7rPBFvhbi58628eA+zK2v9T5Bv6rir3uLT
 w+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oFV70oqbuZ/Iy95AzfvjMyE40zNVPl8rlhZhKbOLyGc=;
 b=o2CIP8PFV64fKSK76mXYo2gnld3i+dnKK0cikjeuoWPFhk7v7Thy5FGW9CxWRBiGxh
 DKLKD/8fManTx1NGYMQDP8OwgT/q3+mOtL3jXa8RzcMh2BIFJMle+nLWRReRVXEdWSgE
 1RMf+2sVV+JO9Daz8E8d6O3i9bjKHpfSyiOQrD3KIaJ7sRtoXjizIn2dctWSPXuC3uRZ
 /ibJqDhiuOWV+yh/8XH+nHG2Py4cQGQ1mNeS/rQHbbowk3xfirrNWyLxh4i0nPt5dmsd
 W7me6Un3sujqL8Zx6XmBTm0rRCpJFqRVO+JYDNICGLf38ft/DLQ1JZW1y4hPzUBUwrdN
 fgAQ==
X-Gm-Message-State: APjAAAWN2fFEC7iGYu1MP9Y/5EDGvtlyhrXeLsy517PISDqgO2eromQ4
 dwHBkiSaRK3VUteNox+2Y0+Aoz3Y3lw=
X-Google-Smtp-Source: APXvYqzUtk9y8n1yj/y4sM5bC955jHFlNU1yovEKYK8CTfE3oGc2uPsyNwsb+84HWp8yxrb0Zib9oQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id
 p14mr16190961plo.28.1580585360262; 
 Sat, 01 Feb 2020 11:29:20 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/41] target/arm: Enable HCR_E2H for VHE
Date: Sat,  1 Feb 2020 11:28:37 -0800
Message-Id: <20200201192916.31796-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 2a53f5d09b..0e68704a90 100644
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


