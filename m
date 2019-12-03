Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E3120684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sE+KrcDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E3120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyFq-0000qG-8u
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxI-0003M7-SS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxB-0008S0-58
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:21 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008MG-LN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:16 -0500
Received: by mail-pg1-x542.google.com with SMTP id x7so856061pgl.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E8yk4OTb4DM68OtMu/yGYISogJYWI7EJZxpxxXSYsqE=;
 b=sE+KrcDlU+6nT18OIC8EFUiq/+P7tYlBURoB6x/qOKo+PsbTTV2mVzfDAJvyfI8Dgx
 DVeQztNveHI2/tqoS9ln9OMmnn3vd/5C6sjTuwnJpavys0kzqirKzEROYmqWkEiMrxsj
 2S+VoFh5bp0xiIcRtK5mjbBpQUb953BczmSe+zXx7m2zRed1NYL8JWVsmsWfPvWH7fyG
 VswyB8X31AqVaDoO2R20QzAhmV0p/ddllbv5LIuZY2s3opzAA8+OMKdgX61Jn7Px89hz
 uCmk4x1X8uloZzNKuSyTNfIrpqFKh+pQaVIC1glY2SVTBkMPVXUkfIbkWEyfj28EW1Gq
 dSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E8yk4OTb4DM68OtMu/yGYISogJYWI7EJZxpxxXSYsqE=;
 b=dOnE15Zr3ogT2ArRNanixsq6iMbLtP3UfNlAwkd9YwMCJNxq3Up1+W2+CaLo3ngwaI
 bwup1QcuUjlwzuusyx024Pq9LeRITfJW1fIrbW27zh75u9x4tVjIGNGeqGsI7qBoUBzU
 9jZgVmFt0oJJqFBwI35lkT2LA6JvlnMQLXAf55QuccCpHdSlxsshZjXH267gYo/l2j7B
 cmOfi5CZs+5Och0MMXYt246MW/delVmmx1x6l5MElKut+4Q2rpY+NKLFoJLPuaRagfet
 a8Rzzdz8RkQx0TbcpXnzNp7KRiqtsNhP+y6e/gegXLXKtmnY9Y1NAHV9mzf1xRJ3CnIJ
 EXWw==
X-Gm-Message-State: APjAAAWGxz4N3hNAywXdxX6X6xyWNe/SfrEpxsjHLBW1jZAn+0yMuqO6
 E/foAIxhhmZJA0tiTqinIwHjYVlOVOw=
X-Google-Smtp-Source: APXvYqweSP5BWNjqvubWqdFgg373QPHkltVWC/m/Fmr0n/FR9LEntZIGt7LDSjtsugOINVnTNEhzsQ==
X-Received: by 2002:a63:36c4:: with SMTP id d187mr2859006pga.108.1575340210716; 
 Mon, 02 Dec 2019 18:30:10 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 24/40] target/arm: Add the hypervisor virtual counter
Date: Mon,  2 Dec 2019 18:29:21 -0800
Message-Id: <20191203022937.1474-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-qom.h |  1 +
 target/arm/cpu.h     | 11 +++++----
 target/arm/cpu.c     |  2 ++
 target/arm/helper.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 7f5b244bde..3a9d31ea9d 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -76,6 +76,7 @@ void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
 void arm_gt_htimer_cb(void *opaque);
 void arm_gt_stimer_cb(void *opaque);
+void arm_gt_hvtimer_cb(void *opaque);
 
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8aa625734f..4bd1bf915c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -144,11 +144,12 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-#define GTIMER_PHYS 0
-#define GTIMER_VIRT 1
-#define GTIMER_HYP  2
-#define GTIMER_SEC  3
-#define NUM_GTIMERS 4
+#define GTIMER_PHYS     0
+#define GTIMER_VIRT     1
+#define GTIMER_HYP      2
+#define GTIMER_SEC      3
+#define GTIMER_HYPVIRT  4
+#define NUM_GTIMERS     5
 
 typedef struct {
     uint64_t raw_tcr;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339b..81c33221f7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1259,6 +1259,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                           arm_gt_htimer_cb, cpu);
     cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
                                           arm_gt_stimer_cb, cpu);
+    cpu->gt_timer[GTIMER_HYPVIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
+                                              arm_gt_hvtimer_cb, cpu);
 #endif
 
     cpu_exec_realizefn(cs, &local_err);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9ad5015d5c..a4a7f82661 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2516,6 +2516,7 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
+    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     }
@@ -2532,6 +2533,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
+    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     }
@@ -2687,6 +2689,34 @@ static void gt_sec_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_ctl_write(env, ri, GTIMER_SEC, value);
 }
 
+static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    gt_timer_reset(env, ri, GTIMER_HYPVIRT);
+}
+
+static void gt_hv_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    gt_cval_write(env, ri, GTIMER_HYPVIRT, value);
+}
+
+static uint64_t gt_hv_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return gt_tval_read(env, ri, GTIMER_HYPVIRT);
+}
+
+static void gt_hv_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    gt_tval_write(env, ri, GTIMER_HYPVIRT, value);
+}
+
+static void gt_hv_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    gt_ctl_write(env, ri, GTIMER_HYPVIRT, value);
+}
+
 void arm_gt_ptimer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -2715,6 +2745,13 @@ void arm_gt_stimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_SEC);
 }
 
+void arm_gt_hvtimer_cb(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    gt_recalc_timer(cpu, GTIMER_HYPVIRT);
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* Note that CNTFRQ is purely reads-as-written for the benefit
      * of software; writing it doesn't actually change the timer frequency.
@@ -6989,6 +7026,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
               .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
               .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
+#ifndef CONFIG_USER_ONLY
+            { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].cval),
+              .type = ARM_CP_IO, .access = PL2_RW,
+              .writefn = gt_hv_cval_write, .raw_writefn = raw_write },
+            { .name = "CNTHV_TVAL_EL2", .state = ARM_CP_STATE_BOTH,
+              .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 0,
+              .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL2_RW,
+              .resetfn = gt_hv_timer_reset,
+              .readfn = gt_hv_tval_read, .writefn = gt_hv_tval_write },
+            { .name = "CNTHV_CTL_EL2", .state = ARM_CP_STATE_BOTH,
+              .type = ARM_CP_IO,
+              .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 1,
+              .access = PL2_RW,
+              .fieldoffset =
+                offsetof(CPUARMState, cp15.c14_timer[GTIMER_HYPVIRT].ctl),
+              .writefn = gt_hv_ctl_write, .raw_writefn = raw_write },
+#endif
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.17.1


