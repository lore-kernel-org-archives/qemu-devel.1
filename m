Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D38DC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4EF20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyaNFkO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4EF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9kG-0000jN-5Y
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:07:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004Db-SE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e7-0006Q2-D8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:54 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-0006BM-1r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id s18so17185001wrp.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=1k8OubluseiOjMnX2mdJEyw5Wu6DofneZe0/FVJDFj4=;
	b=RyaNFkO3i+FiFdDqs6OuQ4HwXsBDou5al9ol/sNJ1q0I+miV2nqr5t3n8sPYU9lI1h
	aId6Ga1tHvl380vEcAeTeMuzcBb16qrnUrZ75px0NNyZSOSm1sMr/kMVue/erSn8xI1O
	IZGSHsgjIIwrNo+Tbjs16zF2JM37sf3JWE3kjkh2TDEQJPzc73WiTbewjChSLVybs8gP
	93hwQXtZRvrvb7FL9DV0eDTQRl/0wf3KnjeJpZyTnBmZFm4azH6fDiFlrNCIy5wVaAOG
	KObisUgepfH+qaXKN8/A9nY4dEnbNSn78tyOXuMERk0/LymPKgqBOa2EUhGGwxBOTroz
	tEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1k8OubluseiOjMnX2mdJEyw5Wu6DofneZe0/FVJDFj4=;
	b=APairTc+w7szn2Ir5vWBc2zhtZOzHdgjQlRMDCSIwpKKyPHuUzsv92fgrE0zeB6Qb+
	/QoTRZgvoKXS2r6+TSMxNHipRp9YfNlu6JXRuRAsTzZF3N7RTZlqjQVTtm6z1Z2H3cey
	/cv0zKdPyJCdmq6GE360hrLStHnnkIQLOVnTjLBq8apeDIBiVVSLNN8feZQZX0go9VYz
	SURydcnQ1Kt4ybLbHMUWQZWN8rRliiXalRKX9NiuhItEBBXU2mNenqgv5AJutUaZ6RSr
	84HSchX4E9Tnt0bZOG7VZ3bghaRLCZrOZxTRdKC7F+NyHlgBMnO+8NLtSji5ebhTnva0
	abig==
X-Gm-Message-State: APjAAAUrWXjNcrMPBrlEMb6JOmBo6D22m66bIfyu6WXCKuyk+HEnOd7h
	pJdID7o2ld0Uxrl5vg4i87aLZh/tFnk=
X-Google-Smtp-Source: APXvYqz8zrNOb2w/aVJiynp1EQnyMXLixLHySnTnri+O50NhDXs2O0H1bKXz/3Pckemqp+1+rYaCPg==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr26088258wrq.330.1556557240699;
	Mon, 29 Apr 2019 10:00:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:54 +0100
Message-Id: <20190429170030.11323-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 06/42] target/arm: Implement dummy versions of
 M-profile FP-related registers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165954.Fe22HNP5BEulK8b44C9H3locX19iMhzR_MHj7BO5FCY@z>

The M-profile floating point support has three associated config
registers: FPCAR, FPCCR and FPDSCR. It also makes the registers
CPACR and NSACR have behaviour other than reads-as-zero.
Add support for all of these as simple reads-as-written registers.
We will hook up actual functionality later.

The main complexity here is handling the FPCCR register, which
has a mix of banked and unbanked bits.

Note that we don't share storage with the A-profile
cpu->cp15.nsacr and cpu->cp15.cpacr_el1, though the behaviour
is quite similar, for two reasons:
 * the M profile CPACR is banked between security states
 * it preserves the invariant that M profile uses no state
   inside the cp15 substruct

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-4-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  34 ++++++++++++
 hw/intc/armv7m_nvic.c | 125 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c      |   5 ++
 target/arm/machine.c  |  16 ++++++
 4 files changed, 180 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f7f2f5a99c8..67e4e95d440 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -533,6 +533,11 @@ typedef struct CPUARMState {
         uint32_t scr[M_REG_NUM_BANKS];
         uint32_t msplim[M_REG_NUM_BANKS];
         uint32_t psplim[M_REG_NUM_BANKS];
+        uint32_t fpcar[M_REG_NUM_BANKS];
+        uint32_t fpccr[M_REG_NUM_BANKS];
+        uint32_t fpdscr[M_REG_NUM_BANKS];
+        uint32_t cpacr[M_REG_NUM_BANKS];
+        uint32_t nsacr;
     } v7m;
 
     /* Information associated with an exception about to be taken:
@@ -1576,6 +1581,35 @@ FIELD(V7M_CSSELR, LEVEL, 1, 3)
  */
 FIELD(V7M_CSSELR, INDEX, 0, 4)
 
+/* v7M FPCCR bits */
+FIELD(V7M_FPCCR, LSPACT, 0, 1)
+FIELD(V7M_FPCCR, USER, 1, 1)
+FIELD(V7M_FPCCR, S, 2, 1)
+FIELD(V7M_FPCCR, THREAD, 3, 1)
+FIELD(V7M_FPCCR, HFRDY, 4, 1)
+FIELD(V7M_FPCCR, MMRDY, 5, 1)
+FIELD(V7M_FPCCR, BFRDY, 6, 1)
+FIELD(V7M_FPCCR, SFRDY, 7, 1)
+FIELD(V7M_FPCCR, MONRDY, 8, 1)
+FIELD(V7M_FPCCR, SPLIMVIOL, 9, 1)
+FIELD(V7M_FPCCR, UFRDY, 10, 1)
+FIELD(V7M_FPCCR, RES0, 11, 15)
+FIELD(V7M_FPCCR, TS, 26, 1)
+FIELD(V7M_FPCCR, CLRONRETS, 27, 1)
+FIELD(V7M_FPCCR, CLRONRET, 28, 1)
+FIELD(V7M_FPCCR, LSPENS, 29, 1)
+FIELD(V7M_FPCCR, LSPEN, 30, 1)
+FIELD(V7M_FPCCR, ASPEN, 31, 1)
+/* These bits are banked. Others are non-banked and live in the M_REG_S bank */
+#define R_V7M_FPCCR_BANKED_MASK                 \
+    (R_V7M_FPCCR_LSPACT_MASK |                  \
+     R_V7M_FPCCR_USER_MASK |                    \
+     R_V7M_FPCCR_THREAD_MASK |                  \
+     R_V7M_FPCCR_MMRDY_MASK |                   \
+     R_V7M_FPCCR_SPLIMVIOL_MASK |               \
+     R_V7M_FPCCR_UFRDY_MASK |                   \
+     R_V7M_FPCCR_ASPEN_MASK)
+
 /*
  * System register ID fields.
  */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 45d72f86bdf..5eb438f5409 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1077,6 +1077,16 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     }
     case 0xd84: /* CSSELR */
         return cpu->env.v7m.csselr[attrs.secure];
+    case 0xd88: /* CPACR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            return 0;
+        }
+        return cpu->env.v7m.cpacr[attrs.secure];
+    case 0xd8c: /* NSACR */
+        if (!attrs.secure || !arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            return 0;
+        }
+        return cpu->env.v7m.nsacr;
     /* TODO: Implement debug registers.  */
     case 0xd90: /* MPU_TYPE */
         /* Unified MPU; if the MPU is not present this value is zero */
@@ -1222,6 +1232,43 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return 0;
         }
         return cpu->env.v7m.sfar;
+    case 0xf34: /* FPCCR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            return 0;
+        }
+        if (attrs.secure) {
+            return cpu->env.v7m.fpccr[M_REG_S];
+        } else {
+            /*
+             * NS can read LSPEN, CLRONRET and MONRDY. It can read
+             * BFRDY and HFRDY if AIRCR.BFHFNMINS != 0;
+             * other non-banked bits RAZ.
+             * TODO: MONRDY should RAZ/WI if DEMCR.SDME is set.
+             */
+            uint32_t value = cpu->env.v7m.fpccr[M_REG_S];
+            uint32_t mask = R_V7M_FPCCR_LSPEN_MASK |
+                R_V7M_FPCCR_CLRONRET_MASK |
+                R_V7M_FPCCR_MONRDY_MASK;
+
+            if (s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+                mask |= R_V7M_FPCCR_BFRDY_MASK | R_V7M_FPCCR_HFRDY_MASK;
+            }
+
+            value &= mask;
+
+            value |= cpu->env.v7m.fpccr[M_REG_NS];
+            return value;
+        }
+    case 0xf38: /* FPCAR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            return 0;
+        }
+        return cpu->env.v7m.fpcar[attrs.secure];
+    case 0xf3c: /* FPDSCR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            return 0;
+        }
+        return cpu->env.v7m.fpdscr[attrs.secure];
     case 0xf40: /* MVFR0 */
         return cpu->isar.mvfr0;
     case 0xf44: /* MVFR1 */
@@ -1475,6 +1522,18 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             cpu->env.v7m.csselr[attrs.secure] = value & R_V7M_CSSELR_INDEX_MASK;
         }
         break;
+    case 0xd88: /* CPACR */
+        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            /* We implement only the Floating Point extension's CP10/CP11 */
+            cpu->env.v7m.cpacr[attrs.secure] = value & (0xf << 20);
+        }
+        break;
+    case 0xd8c: /* NSACR */
+        if (attrs.secure && arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            /* We implement only the Floating Point extension's CP10/CP11 */
+            cpu->env.v7m.nsacr = value & (3 << 10);
+        }
+        break;
     case 0xd90: /* MPU_TYPE */
         return; /* RO */
     case 0xd94: /* MPU_CTRL */
@@ -1703,6 +1762,72 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     }
+    case 0xf34: /* FPCCR */
+        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            /* Not all bits here are banked. */
+            uint32_t fpccr_s;
+
+            if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+                /* Don't allow setting of bits not present in v7M */
+                value &= (R_V7M_FPCCR_LSPACT_MASK |
+                          R_V7M_FPCCR_USER_MASK |
+                          R_V7M_FPCCR_THREAD_MASK |
+                          R_V7M_FPCCR_HFRDY_MASK |
+                          R_V7M_FPCCR_MMRDY_MASK |
+                          R_V7M_FPCCR_BFRDY_MASK |
+                          R_V7M_FPCCR_MONRDY_MASK |
+                          R_V7M_FPCCR_LSPEN_MASK |
+                          R_V7M_FPCCR_ASPEN_MASK);
+            }
+            value &= ~R_V7M_FPCCR_RES0_MASK;
+
+            if (!attrs.secure) {
+                /* Some non-banked bits are configurably writable by NS */
+                fpccr_s = cpu->env.v7m.fpccr[M_REG_S];
+                if (!(fpccr_s & R_V7M_FPCCR_LSPENS_MASK)) {
+                    uint32_t lspen = FIELD_EX32(value, V7M_FPCCR, LSPEN);
+                    fpccr_s = FIELD_DP32(fpccr_s, V7M_FPCCR, LSPEN, lspen);
+                }
+                if (!(fpccr_s & R_V7M_FPCCR_CLRONRETS_MASK)) {
+                    uint32_t cor = FIELD_EX32(value, V7M_FPCCR, CLRONRET);
+                    fpccr_s = FIELD_DP32(fpccr_s, V7M_FPCCR, CLRONRET, cor);
+                }
+                if ((s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+                    uint32_t hfrdy = FIELD_EX32(value, V7M_FPCCR, HFRDY);
+                    uint32_t bfrdy = FIELD_EX32(value, V7M_FPCCR, BFRDY);
+                    fpccr_s = FIELD_DP32(fpccr_s, V7M_FPCCR, HFRDY, hfrdy);
+                    fpccr_s = FIELD_DP32(fpccr_s, V7M_FPCCR, BFRDY, bfrdy);
+                }
+                /* TODO MONRDY should RAZ/WI if DEMCR.SDME is set */
+                {
+                    uint32_t monrdy = FIELD_EX32(value, V7M_FPCCR, MONRDY);
+                    fpccr_s = FIELD_DP32(fpccr_s, V7M_FPCCR, MONRDY, monrdy);
+                }
+
+                /*
+                 * All other non-banked bits are RAZ/WI from NS; write
+                 * just the banked bits to fpccr[M_REG_NS].
+                 */
+                value &= R_V7M_FPCCR_BANKED_MASK;
+                cpu->env.v7m.fpccr[M_REG_NS] = value;
+            } else {
+                fpccr_s = value;
+            }
+            cpu->env.v7m.fpccr[M_REG_S] = fpccr_s;
+        }
+        break;
+    case 0xf38: /* FPCAR */
+        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            value &= ~7;
+            cpu->env.v7m.fpcar[attrs.secure] = value;
+        }
+        break;
+    case 0xf3c: /* FPDSCR */
+        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+            value &= 0x07c00000;
+            cpu->env.v7m.fpdscr[attrs.secure] = value;
+        }
+        break;
     case 0xf50: /* ICIALLU */
     case 0xf58: /* ICIMVAU */
     case 0xf5c: /* DCIMVAC */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bb9fdc6304f..be81e197ee9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -281,6 +281,11 @@ static void arm_cpu_reset(CPUState *s)
             env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
         }
 
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            env->v7m.fpccr[M_REG_NS] = R_V7M_FPCCR_ASPEN_MASK;
+            env->v7m.fpccr[M_REG_S] = R_V7M_FPCCR_ASPEN_MASK |
+                R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK;
+        }
         /* Unlike A/R profile, M profile defines the reset LR value */
         env->regs[14] = 0xffffffff;
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b2925496148..09567d4fc66 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -305,6 +305,21 @@ static const VMStateDescription vmstate_m_v8m = {
     }
 };
 
+static const VMStateDescription vmstate_m_fp = {
+    .name = "cpu/m/fp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vfp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(env.v7m.fpcar, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_UINT32_ARRAY(env.v7m.fpccr, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_UINT32_ARRAY(env.v7m.fpdscr, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_UINT32_ARRAY(env.v7m.cpacr, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_UINT32(env.v7m.nsacr, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -330,6 +345,7 @@ static const VMStateDescription vmstate_m = {
         &vmstate_m_scr,
         &vmstate_m_other_sp,
         &vmstate_m_v8m,
+        &vmstate_m_fp,
         NULL
     }
 };
-- 
2.20.1


