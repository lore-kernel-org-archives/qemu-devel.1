Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94727C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 19:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F63722B45
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7OmZzjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F63722B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k32ms-0008Qf-9O
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 15:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k32mG-0007ss-0O
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 15:39:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k32mC-0008RM-7f
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 15:39:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id c19so2850797wmd.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HqGbC8FUGCeQi5R5J6OQwzhAXNsqzsV2csRohNKrHYc=;
 b=T7OmZzjsZOt2UJirFFWl2tuE85uH9Z1J5MLHCIpJYroWA1nXXFm4zS4iNudk7+dL5W
 uXpuFbe1zm8RF9FHAYBsgeHOSvrPv8AJ7mFqzyZYp9vKjex/3zvONSle9h+oBg5RJLom
 XZ9b8co57pSnQ2CVt7yFbTCBvV3c/2Q3KxTjXYLWMD69STwiqOZQ/vgHr/IAre2Af/4Z
 7IGK3rGf2RJYk7FbxdKavZ02ab4HDlHlSD1f6kDPNM3TYFVymR9Dn1QmdE0GchNHNQ88
 +D3VbGpUQYfN3QUN4IWSqDNmXiJ017EKfDUh6C+Kd9PLP8QT2u3ija0XXhppKa3la54Q
 DUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HqGbC8FUGCeQi5R5J6OQwzhAXNsqzsV2csRohNKrHYc=;
 b=XmeMzDe4VCRGJdQYVBz7NEXhGOPgNPVLuKpJgzvzVU/XZrTXUYheg6fGdOuurYEABE
 rhlNMfiqFHAosjEAXe0BxvPP9Bi7xdKJoh6hlmvJkLBtWHA/mDU4/H9u0jaP8rHo5yNt
 /tQNqYsPEkjKXufkvUGs16+hMe8M9USTfx80czrm5M/vxYzivSyvUOKd0EYNq5/1sWcd
 L1ZambMhnkEjGQoef6R3dUtMzsEhzjLkCApibsZjisk3A6VKRpOeA/NU0EtFG6UXOOKD
 J2jJk4frlTTxTnbyrH0Bc7pzq1ezyz35Oz/Q9BU+/lzZ36POShpSXQRIOwFA62itv6mo
 udig==
X-Gm-Message-State: AOAM530kGIKrMkHjKGJohVS5MJ7sA/FRl+tJdrWpJhfF6t768rCoDvf3
 OJ9o+Y53U6Ci0NHezUySjvzS1g==
X-Google-Smtp-Source: ABdhPJy0nJVyZ9FAOmcFWXxG8qQu7dodNKu3HEh3mNnmnrf7c6tZbTNzPqir9pyHk+I8OjJA3mzSiA==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr52220wmn.6.1596569945632;
 Tue, 04 Aug 2020 12:39:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b203sm6023388wmc.22.2020.08.04.12.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 12:39:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 for-5.1?] target/arm: Fix Rt/Rt2 in ESR_ELx for copro traps
 from AArch32 to 64
Date: Tue,  4 Aug 2020 20:39:03 +0100
Message-Id: <20200804193903.31240-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Marc Zyngier <maz@kernel.org>, Julien Freche <julien@bedrocksystems.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a coprocessor instruction in an  AArch32 guest traps to AArch32
Hyp mode, the syndrome register (HSR) includes Rt and Rt2 fields
which are simply copies of the Rt and Rt2 fields from the trapped
instruction.  However, if the instruction is trapped from AArch32 to
an AArch64 higher exception level, the Rt and Rt2 fields in the
syndrome register (ESR_ELx) must be the AArch64 view of the register.
This makes a difference if the AArch32 guest was in a mode other than
User or System and it was using r13 or r14, or if it was in FIQ mode
and using r8-r14.

We don't know at translate time which AArch32 CPU mode we are in, so
we leave the values we generate in our prototype syndrome register
value at translate time as the raw Rt/Rt2 from the instruction, and
instead correct them to the AArch64 view when we find we need to take
an exception from AArch32 to AArch64 with one of these syndrome
values.

Fixes: https://bugs.launchpad.net/qemu/+bug/1879587
Reported-by: Julien Freche <julien@bedrocksystems.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2: fixed the register mapping for LR (thanks to
Julien for testing v1, diagnosing the bug in it, and suggesting
the fix to LR handling)

Marc: Cc'd you just in case you're interested, given that I'd
expect running Linux aarch64 KVM in QEMU emulation with a 32-bit
guest to hit this bug...
---
 target/arm/helper.c | 92 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ef0fb478f4..455c92b8915 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9581,6 +9581,66 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     take_aarch32_exception(env, new_mode, mask, offset, addr);
 }
 
+static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
+{
+    /*
+     * Return the register number of the AArch64 view of the AArch32
+     * register @aarch32_reg. The CPUARMState CPSR is assumed to still
+     * be that of the AArch32 mode the exception came from.
+     */
+    int mode = env->uncached_cpsr & CPSR_M;
+
+    switch (aarch32_reg) {
+    case 0 ... 7:
+        return aarch32_reg;
+    case 8 ... 12:
+        return mode == ARM_CPU_MODE_FIQ ? aarch32_reg + 16 : aarch32_reg;
+    case 13:
+        switch (mode) {
+        case ARM_CPU_MODE_USR:
+        case ARM_CPU_MODE_SYS:
+            return 13;
+        case ARM_CPU_MODE_HYP:
+            return 15;
+        case ARM_CPU_MODE_IRQ:
+            return 17;
+        case ARM_CPU_MODE_SVC:
+            return 19;
+        case ARM_CPU_MODE_ABT:
+            return 21;
+        case ARM_CPU_MODE_UND:
+            return 23;
+        case ARM_CPU_MODE_FIQ:
+            return 29;
+        default:
+            g_assert_not_reached();
+        }
+    case 14:
+        switch (mode) {
+        case ARM_CPU_MODE_USR:
+        case ARM_CPU_MODE_SYS:
+        case ARM_CPU_MODE_HYP:
+            return 14;
+        case ARM_CPU_MODE_IRQ:
+            return 16;
+        case ARM_CPU_MODE_SVC:
+            return 18;
+        case ARM_CPU_MODE_ABT:
+            return 20;
+        case ARM_CPU_MODE_UND:
+            return 22;
+        case ARM_CPU_MODE_FIQ:
+            return 30;
+        default:
+            g_assert_not_reached();
+        }
+    case 15:
+        return 31;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Handle exception entry to a target EL which is using AArch64 */
 static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 {
@@ -9591,6 +9651,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
+    int rt;
 
     /*
      * Note that new_el can never be 0.  If cur_el is 0, then
@@ -9645,7 +9706,8 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_HVC:
     case EXCP_HYP_TRAP:
     case EXCP_SMC:
-        if (syn_get_ec(env->exception.syndrome) == EC_ADVSIMDFPACCESSTRAP) {
+        switch (syn_get_ec(env->exception.syndrome)) {
+        case EC_ADVSIMDFPACCESSTRAP:
             /*
              * QEMU internal FP/SIMD syndromes from AArch32 include the
              * TA and coproc fields which are only exposed if the exception
@@ -9653,6 +9715,34 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
              * AArch64 format syndrome.
              */
             env->exception.syndrome &= ~MAKE_64BIT_MASK(0, 20);
+            break;
+        case EC_CP14RTTRAP:
+        case EC_CP15RTTRAP:
+        case EC_CP14DTTRAP:
+            /*
+             * For a trap on AArch32 MRC/MCR/LDC/STC the Rt field is currently
+             * the raw register field from the insn; when taking this to
+             * AArch64 we must convert it to the AArch64 view of the register
+             * number. Notice that we read a 4-bit AArch32 register number and
+             * write back a 5-bit AArch64 one.
+             */
+            rt = extract32(env->exception.syndrome, 5, 4);
+            rt = aarch64_regnum(env, rt);
+            env->exception.syndrome = deposit32(env->exception.syndrome,
+                                                5, 5, rt);
+            break;
+        case EC_CP15RRTTRAP:
+        case EC_CP14RRTTRAP:
+            /* Similarly for MRRC/MCRR traps for Rt and Rt2 fields */
+            rt = extract32(env->exception.syndrome, 5, 4);
+            rt = aarch64_regnum(env, rt);
+            env->exception.syndrome = deposit32(env->exception.syndrome,
+                                                5, 5, rt);
+            rt = extract32(env->exception.syndrome, 10, 4);
+            rt = aarch64_regnum(env, rt);
+            env->exception.syndrome = deposit32(env->exception.syndrome,
+                                                10, 5, rt);
+            break;
         }
         env->cp15.esr_el[new_el] = env->exception.syndrome;
         break;
-- 
2.20.1


