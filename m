Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A58CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAFA20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZ+vNWj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAFA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgCD-0008Te-BH
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxh-0007Cv-50
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxf-0000k2-Vy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxf-0000jU-PU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id 11so68825wmk.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0MGAigKQQJD7cJXlO5y60b4rzDCDAg5e78HpKgtRa3w=;
 b=LZ+vNWj/BJfxz9mI3hKgvf6n5hrg8oPyhZbNbpQ34O670N+KLXCD7K6qRTjWuFJlbc
 G/4vT3El4dH6Y6UDEUmOdEgX5w/pf+WtmKWH3plgyyJPvPsYF1MIbnzlbXPHTlZrvLd4
 bYxe4XTUPzV9ScQOC48kBHvN3UU3lOPs53Lx/iqHiB5V91HEWsuURLxEjzJ9i4E61NqD
 AQ7I259Yl4IWVzeM+hDWDh+EPUrt78lDRt2KTKvmAyeQBRMaSsB5gh/t6rFtRTqswS4m
 0lsAAamj5se+pD5rJ3iSb4/EZqMDaBiOXSM1TX+VWVvIv43q3Se0y/J6g83rWL1uEDaA
 Cpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0MGAigKQQJD7cJXlO5y60b4rzDCDAg5e78HpKgtRa3w=;
 b=OBcQnfmtnbYbG6KuFlhYAVxRfFDHjVtgrDPYyqhtZEk61T9/CH+LSJFWCcPzJcFeaK
 C8nuqUljx4JGolUsqEvZwZ0eNZOK6KAwFg/EGWBjU+lxjD7HpiCXTbDfy0wcYXJqEajj
 Wv/b2LAOk12qi3XhivciluCY068HDqaOi2/NrwFszMqnvMZotEsxQB4pGV0jWRBi8Y7K
 AWMlG9Zu5zmzIe6DjJc5Auo+ExlCiMV99srJ5tnPJm2n+CFRzbJXcbELjMcaeBfTg8Ot
 LvbNjy6IKKtW3b8k2R0182kDUOcCLBHAfD7xQTKV/jNcj3MEQybrICrcJH3bfMSYKOf9
 4/Kg==
X-Gm-Message-State: APjAAAX0jOOl02ScYLpflUvreOAI+CuBtspZ8J4rtj39XgUr8qrlOpGA
 AO/SZ58ojcIcZjojQbCSPvlbiOZzGvg=
X-Google-Smtp-Source: APXvYqxkWzTPXGHkmJlrDBhwhsJXO8s4V5LL0ReXu+Xcj8aPfvW98r59dGfnTusXJ+N2keO8zAb8Hg==
X-Received: by 2002:a05:600c:2948:: with SMTP id
 n8mr5497183wmd.128.1571934462548; 
 Thu, 24 Oct 2019 09:27:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/51] target/arm: Simplify set of PSTATE_SS in
 cpu_get_tb_cpu_state
Date: Thu, 24 Oct 2019 17:26:45 +0100
Message-Id: <20191024162724.31675-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Hoist the variable load for PSTATE into the existing test vs is_a64.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2a62cf19a0..398e5f5d6df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11197,7 +11197,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags;
+    uint32_t flags, pstate_for_ss;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11205,6 +11205,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+        pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
 
@@ -11257,9 +11258,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
+        pstate_for_ss = env->uncached_cpsr;
     }
 
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+    /*
+     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
      *     0            x       Inactive (the TB flag for SS is always 0)
@@ -11267,16 +11270,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
      */
-    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)) {
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        }
+    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE) &&
+        (pstate_for_ss & PSTATE_SS)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
     }
 
     *pflags = flags;
-- 
2.20.1


