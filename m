Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F5C20674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvfODTQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F5C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyHx-0004ES-VW
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxI-0003M3-S1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxD-00006P-MJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:21 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxC-0008Oy-BQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:18 -0500
Received: by mail-pg1-x542.google.com with SMTP id k25so867394pgt.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CRgvlrlUUYPKRy0Fi2/c+Pxx/S2Xg9uvm303hT3/JXo=;
 b=JvfODTQVkDi4aSQe1TvmxViIdOG0XAUQ0jLOv3rrfl8CZmkWDRjvwtQJIiYYmk5Kkz
 HBi/F+3BO8zSsgu96Evz3rCkKnO3MwD0rYqVi7bDckbSt0aKWAuJtwP1kdbvub9kJFnt
 kzB0gWzUUXVp9q07/e2idwDxqvFbdTn2GltSkFPbwS2vmgcwtMOi9DfDtjp39CzitBoN
 /6k2BwFJz11n+i4Zi4Pffb26eg/x1y1HY+aT+IoRc4snLEGXJdCTp0EQBDlUXY1N7Fn6
 ZcdofPl/qIzj6Zs65aePhBv3/+bNAMnl+fE4ABk49AYA7u8zKXITN/oBFBytzhePa+Ha
 tA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CRgvlrlUUYPKRy0Fi2/c+Pxx/S2Xg9uvm303hT3/JXo=;
 b=hjpvtDr3Jk6/W2HZ5iwfj7le4FfoA/LGjFjBaX3Q9kt3Nqj51RkNDAmTCfuEvsQ8QO
 8Iz/JqZhn1lsYR4pI6a/t67cK/7qgjYAihURWRJ+f4TddcEv6GSAL5e2h5eqcxxOjG8p
 pNxvzCSbgkk89awZngniv9S0ANsXVQkcZTjRACmXeP3PldY5N8vw3fhAMNqugoSelcw1
 MJboV3XkxjGB+RPkJVc+LNFA4yakOaW4cmAD5p8gD/bTRspkrh7hQTLZB7tTN37UDzIr
 N0rVVwaLCuh4SJlWMmispq4C28iW29VOzzpX+LaB9mLzAlQV9d9cjjGysaMblOJNYhrY
 TSuA==
X-Gm-Message-State: APjAAAUIBHL6MbgO0DmPi2R08yFADk0biZ0gkIBoZYlprkwzJm6jJWK5
 Qu5Tz3rSTZ6Nxg8nTt81n8WmYAVVWsQ=
X-Google-Smtp-Source: APXvYqxElsad0L9BUuASZGgVuhpbabsbN8jgMLH80mIo7wsQszvZGAulGiy8qV0FOOwBo6CrWPgotQ==
X-Received: by 2002:a63:b49:: with SMTP id a9mr2843753pgl.386.1575340215205;
 Mon, 02 Dec 2019 18:30:15 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 28/40] target/arm: Add VHE timer register redirection and
 aliasing
Date: Mon,  2 Dec 2019 18:29:25 -0800
Message-Id: <20191203022937.1474-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 191 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 179 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0baf188078..9df55a8d6b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2655,6 +2655,70 @@ static void gt_phys_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_PHYS, value);
 }
 
+static int gt_phys_redir_timeridx(CPUARMState *env)
+{
+    switch (arm_mmu_idx(env)) {
+    case ARMMMUIdx_EL20_0:
+    case ARMMMUIdx_EL20_2:
+        return GTIMER_HYP;
+    default:
+        return GTIMER_PHYS;
+    }
+}
+
+static int gt_virt_redir_timeridx(CPUARMState *env)
+{
+    switch (arm_mmu_idx(env)) {
+    case ARMMMUIdx_EL20_0:
+    case ARMMMUIdx_EL20_2:
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
@@ -2693,6 +2757,48 @@ static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -2842,7 +2948,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_PHYS].ctl),
-      .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_ctl_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTP_CTL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
@@ -2859,14 +2966,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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
@@ -2874,14 +2983,15 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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
@@ -2894,18 +3004,18 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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
@@ -2935,7 +3045,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .accessfn = gt_ptimer_access,
-      .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_phys_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_phys_redir_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTP_CVAL_S", .cp = 15, .crm = 14, .opc1 = 2,
       .secure = ARM_CP_SECSTATE_S,
@@ -2951,14 +3062,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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
@@ -2966,7 +3079,8 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .resetvalue = 0, .accessfn = gt_vtimer_access,
-      .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
+      .readfn = gt_virt_redir_cval_read, .raw_readfn = raw_read,
+      .writefn = gt_virt_redir_cval_write, .raw_writefn = raw_write,
     },
     /* Secure timer -- this is actually restricted to only EL3
      * and configurably Secure-EL1 via the accessfn.
@@ -2997,6 +3111,15 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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
@@ -7257,6 +7380,50 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
2.17.1


