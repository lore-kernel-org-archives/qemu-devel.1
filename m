Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A62C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2297E206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Blz7xEkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2297E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxOA-0006Gl-B7
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCa-0004PJ-OX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCY-00007R-Qh
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:56 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCY-000055-Hi
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:54 -0500
Received: by mail-pl1-x643.google.com with SMTP id t6so595099plj.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yyLBkIzg3b6uUXIEDUkUJBApQ91tFdR9Aafol2JnOhg=;
 b=Blz7xEkKkVaFznzMzDwHOBiOyHdXB0e/4Ov6hU/zzvcJRcrR84btmU8hfjRsOLDthE
 KmAYN/55+9BFu2c4JIGPCwHWyTss/NHX1pHo29DSFRwMH6ySGbX4M/fl+02RFddthAjy
 bJPq3uaFFo0z3VIPTNTH5CvfrPDi+l2QcJx2VGKTzI5q0WOgbDKKWAbPMuQ1+DFyPaLG
 cUnEVFOm1rJItOSnyfxUgsZrZfaGcR64ZafKz8spM0E+C6XyIt8tKsSUrh19NtvC0yIQ
 JjyZZcyROAjwn08WiAfQsgy7H0QEKHcYJ9YoqZXbAh9HLlKhcnGYTIib+/MH8Ngz3kto
 95lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yyLBkIzg3b6uUXIEDUkUJBApQ91tFdR9Aafol2JnOhg=;
 b=NlKZ30Hr5m7Fwtj0sEOz08DTpDe7KDCr709aNUxN2GxmI2cb6uXCK8qJfuTTR7E4q0
 yhKNODglkXceIpZotV9VUAn2ptUZzOOd8H5kvMyqJ03Z7N9R5Ne80eFpi2VZ8a4UMvID
 gBCzkDIZYvqpxYe6x5BcR/3wCtFw6E+XzSvuDCxu3TK3e+3FmB4AV9f9LY2e1iJYLZHS
 qK2wCuRON+lxzSzuqV92WUSmROpGdz5P+VJpLnpnIztVY2awlZn+rtUHz1ZND6qs15ok
 jdQG4nbkq93x8pFn/oBV5JuwEYL257KAJ9Ghz1S35YBYiw8Ppc5nYOfU28v6T8554ySb
 N8Ig==
X-Gm-Message-State: APjAAAW9/jLUH2bhy5LprEefCtVkk9/7Iybh6ltioZlfWqG6Sctsclj/
 PQFIs4yOOy7uAeEwFDUeA7r7VMFL2Qc=
X-Google-Smtp-Source: APXvYqx4+KHudBy5i2H94qdTqKUH+yiUnzFrom7DbwLCNucp4wTAuRggxFvS3LIIObVy9G5C5eZ3Bg==
X-Received: by 2002:a17:90a:8915:: with SMTP id
 u21mr2536657pjn.87.1580342213138; 
 Wed, 29 Jan 2020 15:56:53 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 29/41] target/arm: Add VHE timer register redirection and
 aliasing
Date: Wed, 29 Jan 2020 15:56:02 -0800
Message-Id: <20200129235614.29829-30-richard.henderson@linaro.org>
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

Apart from the wholesale redirection that HCR_EL2.E2H performs
for EL2, there's a separate redirection specific to the timers
that happens for EL0 when running in the EL2&0 regime.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 191 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 179 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a79aaa61de..0b67cefcbb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2695,6 +2695,70 @@ static void gt_phys_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_PHYS, value);
 }
 
+static int gt_phys_redir_timeridx(CPUARMState *env)
+{
+    switch (arm_mmu_idx(env)) {
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+        return GTIMER_HYP;
+    default:
+        return GTIMER_PHYS;
+    }
+}
+
+static int gt_virt_redir_timeridx(CPUARMState *env)
+{
+    switch (arm_mmu_idx(env)) {
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+        return GTIMER_HYPVIRT;
+    default:
+        return GTIMER_VIRT;
+    }
+}
+
+static uint64_t gt_phys_redir_cval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].cval;
+}
+
+static void gt_phys_redir_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    gt_cval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_phys_redir_tval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    return gt_tval_read(env, ri, timeridx);
+}
+
+static void gt_phys_redir_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    gt_tval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_phys_redir_ctl_read(CPUARMState *env,
+                                       const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].ctl;
+}
+
+static void gt_phys_redir_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    int timeridx = gt_phys_redir_timeridx(env);
+    gt_ctl_write(env, ri, timeridx, value);
+}
+
 static void gt_virt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_VIRT);
@@ -2733,6 +2797,48 @@ static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_recalc_timer(cpu, GTIMER_VIRT);
 }
 
+static uint64_t gt_virt_redir_cval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].cval;
+}
+
+static void gt_virt_redir_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    gt_cval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_virt_redir_tval_read(CPUARMState *env,
+                                        const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    return gt_tval_read(env, ri, timeridx);
+}
+
+static void gt_virt_redir_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     uint64_t value)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    gt_tval_write(env, ri, timeridx, value);
+}
+
+static uint64_t gt_virt_redir_ctl_read(CPUARMState *env,
+                                       const ARMCPRegInfo *ri)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    return env->cp15.c14_timer[timeridx].ctl;
+}
+
+static void gt_virt_redir_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    int timeridx = gt_virt_redir_timeridx(env);
+    gt_ctl_write(env, ri, timeridx, value);
+}
+
 static void gt_hyp_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     gt_timer_reset(env, ri, GTIMER_HYP);
@@ -2889,7 +2995,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_PHYS].ctl),
-      .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTP_CTL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
@@ -2906,14 +3013,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .resetvalue = 0,
-      .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CTL", .cp = 15, .crn = 14, .crm = 3, .opc1 = 0, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL0_RW,
       .accessfn = gt_vtimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_VIRT].ctl),
-      .writefn = gt_virt_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CTL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 1,
@@ -2921,14 +3030,15 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_vtimer_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .resetvalue = 0,
-      .writefn = gt_virt_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_ctl_write, .raw_writefn = raw_write,
     },
     /* TimerValue views: a 32 bit downcounting view of the underlying state */
     { .name = "CNTP_TVAL", .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
       .secure = ARM_CP_SECSTATE_NS,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_ptimer_access,
-      .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
+      .readfn = gt_phys_redir_tval_read, .writefn = gt_phys_redir_tval_write,
     },
     { .name = "CNTP_TVAL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
@@ -2941,18 +3051,18 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 0,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_ptimer_access, .resetfn = gt_phys_timer_reset,
-      .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
+      .readfn = gt_phys_redir_tval_read, .writefn = gt_phys_redir_tval_write,
     },
     { .name = "CNTV_TVAL", .cp = 15, .crn = 14, .crm = 3, .opc1 = 0, .opc2 = 0,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_vtimer_access,
-      .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
+      .readfn = gt_virt_redir_tval_read, .writefn = gt_virt_redir_tval_write,
     },
     { .name = "CNTV_TVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 0,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL0_RW,
       .accessfn = gt_vtimer_access, .resetfn = gt_virt_timer_reset,
-      .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
+      .readfn = gt_virt_redir_tval_read, .writefn = gt_virt_redir_tval_write,
     },
     /* The counter itself */
     { .name = "CNTPCT", .cp = 15, .crm = 14, .opc1 = 0,
@@ -2982,7 +3092,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .accessfn = gt_ptimer_access,
-      .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTP_CVAL_S", .cp = 15, .crm = 14, .opc1 = 2,
       .secure = ARM_CP_SECSTATE_S,
@@ -2998,14 +3109,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .resetvalue = 0, .accessfn = gt_ptimer_access,
-      .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CVAL", .cp = 15, .crm = 14, .opc1 = 3,
       .access = PL0_RW,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .accessfn = gt_vtimer_access,
-      .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 2,
@@ -3013,7 +3126,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .resetvalue = 0, .accessfn = gt_vtimer_access,
-      .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_cval_write, .raw_writefn = raw_write,
     },
     /* Secure timer -- this is actually restricted to only EL3
      * and configurably Secure-EL1 via the accessfn.
@@ -3044,6 +3158,15 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 #else
 
 /* In user-mode most of the generic timer registers are inaccessible
@@ -7396,6 +7519,50 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .fieldoffset =
                 offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].ctl),
               .writefn = gt_hv_ctl_write, .raw_writefn = raw_write },
+            { .name = "CNTP_CTL_EL02", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 1,
+              .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .access = PL2_RW, .accessfn = e2h_access,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
+              .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
+            },
+            { .name = "CNTV_CTL_EL02", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 1,
+              .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .access = PL2_RW, .accessfn = e2h_access,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
+              .writefn = gt_virt_ctl_write, .raw_writefn = raw_write,
+            },
+            { .name = "CNTP_TVAL_EL02", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 0,
+              .type = ARM_CP_NO_RAW | ARM_CP_IO | ARM_CP_ALIAS,
+              .access = PL2_RW, .accessfn = e2h_access,
+              .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
+            },
+            { .name = "CNTV_TVAL_EL02", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 0,
+              .type = ARM_CP_NO_RAW | ARM_CP_IO | ARM_CP_ALIAS,
+              .access = PL2_RW, .accessfn = e2h_access,
+              .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
+            },
+            { .name = "CNTP_CVAL_EL02", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 2,
+              .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
+              .access = PL2_RW, .accessfn = e2h_access,
+              .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
+            },
+            { .name = "CNTV_CVAL_EL02", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 2,
+              .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
+              .access = PL2_RW, .accessfn = e2h_access,
+              .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
+            },
 #endif
             REGINFO_SENTINEL
         };
-- 
2.20.1


