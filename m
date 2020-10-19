Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14882C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCBC2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XO/pELET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCBC2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUX4c-0007f3-8W
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqf-00070H-Hs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqZ-0002la-2T
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id n6so74605wrm.13
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6hKic17i51H/7+th1/P5umqhoIFiqn2jr04cBxU9UUU=;
 b=XO/pELETpBfePYzggX2WerIDXKceQabShhBSBsEq+UtA//1x/7mx6XFoGSmpHtEpIY
 fYVOjvtUpzEWyyS+ZNP6Z8hQjvuY6kEUfMXJUv7o0f1g6KReHTgio8+9w7xxtUdaOYPa
 PJr7Ho/0IGO8lca9gLnAmhJG/tK0IjBUnWStzJ5Q/YMUy/elxGLxVTVZ3zbADPeIQwrv
 JqPeb7n6NiJiRKoWG7ItUZXuJBtCAHyK4uxnQT2sYcCIz4dcTPtw4PTvYr0/Ve6jXUjH
 wWQOANOZzdpu4UMvYlRdrdI4lSG++qufwTuHiAPOxASxP/R5R21oJ2g2vZc4WRF11VJ2
 F/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6hKic17i51H/7+th1/P5umqhoIFiqn2jr04cBxU9UUU=;
 b=gjXdzqwMIDb3CT0dSRU3SK1sdt9KGAZx5Pej39wimBnD4rOIM/njycgP+y2HvF7GrP
 sHoJGQrW2VbLmX+yfLp3W8olHcb0PCw4d6UL3UMLZpGSArQuCzltX/DWC2UV4TxURjXz
 ulq0UI3zu419C67ke9Dn1Q1eSpZwRA/DWIXmnpDIJ34oC76y0+fo7RCaH69/NCsO3W93
 5Ut7zQU4MCkQkqlR74Qjupc83tQa1Kv7tZGasjdjDeZD/KNjDD/w+V5agC/Nd0olCY0l
 h9Hobhh7d32rTqsPKcodk2QA/o/ktM+FvIh8LRNU/l22JL8XI9l4zqaIR9e7eSFm2hut
 7gCQ==
X-Gm-Message-State: AOAM5315iN6V3ggizHUBmdPZxPJdrwNC94rtMnHfkTETbSoeiI5cRLer
 /2W17OIKJcbjsjgGrevx3BRKyA==
X-Google-Smtp-Source: ABdhPJxMd9qOVmibbgB1FDhEnrEoza+fbugjVPKFZaOCwTdMBwemcb/rBW6+X/91QfOTAgGwMQzL8g==
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr20242969wra.391.1603120393234; 
 Mon, 19 Oct 2020 08:13:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/10] target/arm: Fix has_vfp/has_neon ID reg squashing
 for M-profile
Date: Mon, 19 Oct 2020 16:12:59 +0100
Message-Id: <20201019151301.2046-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019151301.2046-1-peter.maydell@linaro.org>
References: <20201019151301.2046-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In arm_cpu_realizefn(), if the CPU has VFP or Neon disabled then we
squash the ID register fields so that we don't advertise it to the
guest.  This code was written for A-profile and needs some tweaks to
work correctly on M-profile:

 * A-profile only fields should not be zeroed on M-profile:
   - MVFR0.FPSHVEC,FPTRAP
   - MVFR1.SIMDLS,SIMDINT,SIMDSP,SIMDHP
   - MVFR2.SIMDMISC
 * M-profile only fields should be zeroed on M-profile:
   - MVFR1.FP16

In particular, because MVFR1.SIMDHP on A-profile is the same field as
MVFR1.FP16 on M-profile this code was incorrectly disabling FP16
support on an M-profile CPU (where has_neon is always false).  This
isn't a visible bug yet because we don't have any M-profile CPUs with
FP16 support, but the change is necessary before we introduce any.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 056319859fb..186ee621a65 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1429,17 +1429,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, FPSP, 0);
         u = FIELD_DP32(u, MVFR0, FPDP, 0);
-        u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
         u = FIELD_DP32(u, MVFR0, FPDIVIDE, 0);
         u = FIELD_DP32(u, MVFR0, FPSQRT, 0);
-        u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
         u = FIELD_DP32(u, MVFR0, FPROUND, 0);
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
+            u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
+        }
         cpu->isar.mvfr0 = u;
 
         u = cpu->isar.mvfr1;
         u = FIELD_DP32(u, MVFR1, FPFTZ, 0);
         u = FIELD_DP32(u, MVFR1, FPDNAN, 0);
         u = FIELD_DP32(u, MVFR1, FPHP, 0);
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            u = FIELD_DP32(u, MVFR1, FP16, 0);
+        }
         cpu->isar.mvfr1 = u;
 
         u = cpu->isar.mvfr2;
@@ -1475,16 +1480,18 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
         cpu->isar.id_isar6 = u;
 
-        u = cpu->isar.mvfr1;
-        u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
-        u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
-        cpu->isar.mvfr1 = u;
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            u = cpu->isar.mvfr1;
+            u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
+            u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
+            u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
+            u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
+            cpu->isar.mvfr1 = u;
 
-        u = cpu->isar.mvfr2;
-        u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
-        cpu->isar.mvfr2 = u;
+            u = cpu->isar.mvfr2;
+            u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
+            cpu->isar.mvfr2 = u;
+        }
     }
 
     if (!cpu->has_neon && !cpu->has_vfp) {
-- 
2.20.1


