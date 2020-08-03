Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92FDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E8D207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieY3a3v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E8D207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2dji-0007RQ-1D
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2dj6-0006tI-Ab
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:54:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2dj4-0000NA-7b
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:54:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id r2so29788078wrs.8
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ffmPWDKlcsY1Gus8c/E/7lJXRNv40LcZuh9AmRMWtMw=;
 b=ieY3a3v7tNOp2BgqXXcqOCuL9mCEctUpdzvQ68kwPsvGz/Gc6kUu1JvaaUf0tGbs0G
 rpxh/AHGoK/RsyPHVwBmlb6ueo1nXra4EBc4yp0d0h646EWQfH66g3YPWy0+F9lYsXw4
 YK2j/8ivFmho9b07LltpnS4sBa1qal0RAGoQcVChl3VDatenD2WgEeFBGNUrHdai7a6T
 Lu6FuyKiDTRWLVvX+p/+Joo29rquYx+Xwc1W422oBfkhu+vOVBKNrFPX/aropHXXR+89
 BTMdFza4YIxOPxx+rl+qAeVzg7dvo96nsQytjW9Ncjuqap4ZSoCjrhXoSEuV2pbGhJtD
 W3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ffmPWDKlcsY1Gus8c/E/7lJXRNv40LcZuh9AmRMWtMw=;
 b=j/A5dSZGZV87IGbOKD+ibBHVTEw495fUkDuYaRVlFCyJ8yZxFn5KQc6rw7jM/vUXK7
 fDbJNF9MIXMUyYCZhJ7r837zALJZavAnKFr4w8y11sLcRA/pERdPs17VJcLRACaJjWT4
 Xaa8v1/rnxDDCgyn19YZUYQ0cMIPTeO9L2lKUpUAeWmsVuobUsEEZnubHJzv/HY81AcK
 AGK0auSZ9n9+DWP+Higk/cLLFsA9UGFPJBwOLp4Trv4juNw6djndTHxnXP/hO2h3L9a+
 sui5DGxnKDcpP70oOVBe7fMNJuh+WeItB5/icFT7nQTnU2a5ojBRP5QWqZ8VBFtWOYaV
 NtpQ==
X-Gm-Message-State: AOAM533mPIB1wjSq8kozm/I6u9Phbl2vNEdxme6q8E0wS1keiNbX7MgD
 LYTwknEf7W7wQ8Y9EuJAlwGv/Q==
X-Google-Smtp-Source: ABdhPJz2gyinSvTIY4ddkTKr2KbbVl4hJyI4gqvoKjmjXYpkF8ZQwrEX6kph9rLDDTJf5pVWAhoqCA==
X-Received: by 2002:a05:6000:8b:: with SMTP id
 m11mr15777292wrx.245.1596473652060; 
 Mon, 03 Aug 2020 09:54:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i14sm31560564wrc.19.2020.08.03.09.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 09:54:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix Rt/Rt2 in ESR_ELx for copro traps from
 AArch32 to 64
Date: Mon,  3 Aug 2020 17:54:09 +0100
Message-Id: <20200803165409.15099-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: I don't have a test case for this so am hoping the bug
submitter will test it for me :-)
---
 target/arm/helper.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ef0fb478f4..60b80228fd7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9581,6 +9581,67 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
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
+            return 14;
+        case ARM_CPU_MODE_HYP:
+            return 16;
+        case ARM_CPU_MODE_IRQ:
+            return 18;
+        case ARM_CPU_MODE_SVC:
+            return 20;
+        case ARM_CPU_MODE_ABT:
+            return 22;
+        case ARM_CPU_MODE_UND:
+            return 24;
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
@@ -9591,6 +9652,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
+    int rt;
 
     /*
      * Note that new_el can never be 0.  If cur_el is 0, then
@@ -9645,7 +9707,8 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_HVC:
     case EXCP_HYP_TRAP:
     case EXCP_SMC:
-        if (syn_get_ec(env->exception.syndrome) == EC_ADVSIMDFPACCESSTRAP) {
+        switch (syn_get_ec(env->exception.syndrome)) {
+        case EC_ADVSIMDFPACCESSTRAP:
             /*
              * QEMU internal FP/SIMD syndromes from AArch32 include the
              * TA and coproc fields which are only exposed if the exception
@@ -9653,6 +9716,34 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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


