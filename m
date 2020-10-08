Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3E1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F5821D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwtKfjCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F5821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYhu-00047m-2o
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgL-0002Uv-2B
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:17 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQYgC-0007eS-VQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:22:12 -0400
Received: by mail-oi1-x244.google.com with SMTP id m7so6921509oie.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QyvlAwVml9YHe9kwFtSW/ZPwkyIj+P8DM/oa1e0Xc6w=;
 b=rwtKfjCK8hje9Jvfy+6vADhrgbNjBCbTVp2UQ4VX5jGFO0aLke+PVfEOoZvLcvEeFr
 D8shsBeyQMPc/nmwiD5jv/2iU83PioDcTHNPrgGRmMcvxPaqsZOG4bAv3SV6nAD/fLXl
 2uOV+mMJ8o93WZwQsOwRC8GdPC0o2nFO4fC4X+Fe1x6A1KfJ3Wxr/SJSgqBNjAiLUP10
 FUyriBOzSwUi1k9QkPSq2SsR44oi+JpmXGbvz/UEsCwfYWARtbpsSTlIQUgtoP1h5H0H
 zRXzWA90Z4XINVKxhxpkzeH90+iygLpoUuTRmOXviOuVUdOAPylm2Z11pKkDFdVnUGKl
 6L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QyvlAwVml9YHe9kwFtSW/ZPwkyIj+P8DM/oa1e0Xc6w=;
 b=ucj8hm05D/jCzavwzCmzCRYp0jSPe3B8tHLhuz2p09+9kx13YVCbFDxOwZPvFvsklh
 0KradD43Xf1aszhFVM0jbZZnQddxelRXepPF4djT4pCB25KAO/YT0/JKmeNViQ3dzn8v
 d+k37MfDND1VshTlu+nhu9wleH5prw8/0byXKBBuZ0ioSl65P+PawtLBDnlqtSAbqUOa
 djfnL0DTHAI1LGw6ZuC6tb6TNTOYf9nEegDOQuzGVdmuk2ulLv+WJrdk9FwQq3TK+RBp
 HaWfdjIulpXzHMyPGvaPWVfIqTwe+0V7rDvqgvB5xzdsOiNTDCP42IS8x+9i0c8AwcFW
 gUCQ==
X-Gm-Message-State: AOAM533vdvhcctN+Od5m/VD0h/0+Ma4VshFCujdbimoBMfAbaUe38lG+
 d2guSUtkG52Jex3UFPNr8DzVHZq4gAprWRzO
X-Google-Smtp-Source: ABdhPJzQhkhsRl3XSjyTXcGrDBvYwzxtMZRN+TGpTJnBcfXLl8XaPUKM4ojnrMpLcnxYwp4ojgwcyg==
X-Received: by 2002:aca:38c1:: with SMTP id f184mr5219577oia.145.1602174123111; 
 Thu, 08 Oct 2020 09:22:03 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id l138sm5076218oih.32.2020.10.08.09.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 09:22:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11
Date: Thu,  8 Oct 2020 11:21:55 -0500
Message-Id: <20201008162155.161886-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008162155.161886-1-richard.henderson@linaro.org>
References: <20201008162155.161886-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike many other bits in HCR_EL2, the description for this
bit does not contain the phrase "if ... this field behaves
as 0 for all purposes other than", so do not squash the bit
in arm_hcr_el2_eff.

Instead, replicate the E2H+TGE test in the two places that
require it.

Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 9 +++++----
 target/arm/helper.c    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae99725d2b..5460678756 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1252,10 +1252,11 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
         && !(env->cp15.scr_el3 & SCR_ATA)) {
         return false;
     }
-    if (el < 2
-        && arm_feature(env, ARM_FEATURE_EL2)
-        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
-        return false;
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
+            return false;
+        }
     }
     sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
     return sctlr != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd0779ff5f..0620572e44 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6874,10 +6874,11 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     int el = arm_current_el(env);
 
-    if (el < 2 &&
-        arm_feature(env, ARM_FEATURE_EL2) &&
-        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
-        return CP_ACCESS_TRAP_EL2;
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     if (el < 3 &&
         arm_feature(env, ARM_FEATURE_EL3) &&
-- 
2.25.1


