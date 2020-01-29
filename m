Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C775BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9207E206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buj+sgy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9207E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxMC-0002ru-OL
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCb-0004Pb-0X
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCZ-00008w-Tx
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:56 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCZ-00007q-Nf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:55 -0500
Received: by mail-pl1-x643.google.com with SMTP id c23so595843plz.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZB06Shgv2j1FRBq5HjNXTeQOLhUJt6Hevx1CrdU4jBA=;
 b=buj+sgy+Z53/A6qYagSYIqcfl4lhr7T1L56tlEYDi3LkFnf99tr6J+VLDNxriyd2Gd
 4eZzrm3n1UUkwQXzYul87HYq6FwLySD4vTsdEwsLUq/TQfw6y4uOXvz2fneL4UKdUnyk
 IgDgQVJ5PzU4WshXuTaE/W5OIuKDWR/DSbMpQWx2TJUXMCBf9ZV4QmEpiicfL9cYZim1
 GhwIBKrUOolVy2/wcwNo3lRw7tSm2ERzgZqTiVrw3Dihfu+2Wxja8g0dIhU4Ux8ouH7Z
 vY/sEUDQPOdR37/zhPZ69Glx5Wb0+iS/O7DKv0H18MbqLd3NpluhdMGgafnj2QemieBU
 53nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZB06Shgv2j1FRBq5HjNXTeQOLhUJt6Hevx1CrdU4jBA=;
 b=uHqEp6g9HUcM1IzTbbdyK3JKqI9RA8+8Xb4bLG1uv3x5nl/Z7BHF4aNUisCXX9bS5x
 y9dP+T+TWz4GINPXVPaobXAqpvUZc5DU8lch9yYgtonhWFz0JWzE2w7Cilvw5qJQM0Df
 Otja5Rd3BOccslVg5IUhylijKBMfykqOf956iMydvTsvE5eayoADj/VomQDViLdE9oT1
 9NoYeIqiJKsTUKLdhhOmez8LTZ5wjZByqR/AlG8P9AUBWovyj8kmqzDP8TluK/mGsT1M
 +HaulfamYJKz5cz+ZNgIXRYV87ab54r9X9zu+1/xXf67CFF4XfC9GMMTsKDEn8AFR5B1
 HpOg==
X-Gm-Message-State: APjAAAVVTmaL/j7IYWftPS6ZT6vMim2FFhUz9lsHZcCmipTq+qWVnXNN
 vmulRYXVgXamp6hD0aBsC6zbPdLIQ9Y=
X-Google-Smtp-Source: APXvYqzjJ4q5kOmH1EEvM5GfN3x3pvUlf428pagJzzrKsHqDqhd/AaiCQeheJmWWtHMoO0+Q1T8T5A==
X-Received: by 2002:a17:90a:8d81:: with SMTP id
 d1mr2532857pjo.63.1580342214417; 
 Wed, 29 Jan 2020 15:56:54 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
Date: Wed, 29 Jan 2020 15:56:03 -0800
Message-Id: <20200129235614.29829-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we only support a single ASID, flush the tlb when it changes.

Note that TCR_EL2, like TCR_EL1, has the A1 bit that chooses between
the two TTBR* registers for the location of the ASID.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b67cefcbb..708a2ecf91 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3763,7 +3763,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     tcr->base_mask = 0xffffc000u;
 }
 
-static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3789,7 +3789,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
+    /*
+     * If we are running with E2&0 regime, then an ASID is active.
+     * Flush if that might be changing.  Note we're not checking
+     * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
+     * holds the active ASID, only checking the field that might.
+     */
+    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
+        (arm_hcr_el2_eff(env) & HCR_E2H)) {
+        tlb_flush_by_mmuidx(env_cpu(env),
+                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
+    }
     raw_write(env, ri, value);
 }
 
@@ -3849,7 +3859,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .writefn = vmsa_tcr_el1_write,
+      .access = PL1_RW, .writefn = vmsa_tcr_el12_write,
       .resetfn = vmsa_ttbcr_reset, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[1]) },
     { .name = "TTBCR", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
@@ -5175,10 +5185,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
-- 
2.20.1


