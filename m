Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596FEC35246
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABE4205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4Glt6es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABE4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyjm-0001gx-Bc
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySf-0007am-GF
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySe-0006rI-Ig
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:45 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySe-0006qv-D7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:44 -0500
Received: by mail-pf1-x443.google.com with SMTP id j9so2187513pfa.8
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OKxQq943wt4uroP1gZYZ49QNE9fpaRpfrXYqhLFIHks=;
 b=T4Glt6esKqFhEf5eWsJCZ/SWx+H8jJOtN0e6mOd5SuC2gObiNffJO+dYha7h6xH+py
 6vv+4XpIrNwYNS1GSO/AzDDSYQPeMVOjmxY4PmiuQRaNLylcWJOWNLy9SV9cw3iZ5PzD
 ESsLotjjT97BN/u3w1LBfgXjONxqran8dgmwwpgSGBtkHniYLdQMg8SBWgyJw35T8V/a
 0dxW6kAOIcRoBtcyO+ZUPb3Po/cPbogkPN8No2H0/g2I0FV13SpGry+JIphmBsAlnoRj
 hf31NCxw2Iz1M9aT0apgkMDKi4hLOghL2WI1kW2vjcCjtYHbEC4rberTbmjs7CT8ACFY
 gvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OKxQq943wt4uroP1gZYZ49QNE9fpaRpfrXYqhLFIHks=;
 b=Gb7/n/khuJ8wxOg2VA1D91h+BLeUHMNz9MTOSX+n3xEja+/KoyFFase1FtFlj7lfPZ
 YondyPcl+5Nm1MOA1Fi85NpzZtDpwcxNqcpWKyivjWybNLvPPuB+1rv8ad6XX+TKcxoG
 1CMYMZNWJpbmQqyuoSz4zDHExbhBXofzK2ezF9e4t9yUQ9uo16Egyp233G3omgwaYCeY
 z/bIY88rA8JrFHAUtyBjKnFvMWLimLL+Ch2xhvMZ3xGTavouoPK+htJ7ECwvP6vmY8YR
 s9TXieiM7mgOr9oVZIfQLcgxj5//L9VpM0TFmusdrcRsC47Tse/Do3wnZNkclYX3Dnqs
 MN6w==
X-Gm-Message-State: APjAAAWr5Lads3a2T7R6HD5MD+WxVb9wiDyoyAoGs+gXRjSAHr3zgJLQ
 8//kfovHzKqTzGcitIlTCepjm3kvkn4=
X-Google-Smtp-Source: APXvYqyjlACDbkuUhY5ZV0Y+vXweSM48RZP39HKel5NY7Q+2uDQbtRrcP2QFMqcf89mRtbSIaxvqfw==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr1701626pgn.275.1580585383218; 
 Sat, 01 Feb 2020 11:29:43 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 21/41] target/arm: Update arm_mmu_idx for VHE
Date: Sat,  1 Feb 2020 11:28:56 -0800
Message-Id: <20200201192916.31796-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Return the indexes for the EL2&0 regime when the appropriate bits
are set within HCR_EL2.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v4: Consistently check E2H & TGE & ELUsingAArch32(EL2).
    Do not apply TGE at EL2.
---
 target/arm/helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f7bc7f1a8d..9f8d7ca1f3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11318,12 +11318,16 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    /* See ARM pseudo-function ELIsInHost.  */
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
         if (arm_is_secure_below_el3(env)) {
             return ARMMMUIdx_SE10_0;
         }
+        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+            && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_0;
+        }
         return ARMMMUIdx_E10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
@@ -11331,8 +11335,11 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         }
         return ARMMMUIdx_E10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
+        /* Note that TGE does not apply at EL2.  */
+        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_2;
+        }
         return ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
-- 
2.20.1


