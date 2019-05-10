Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2498C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A788920989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhIOPxWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A788920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3Q7-000385-T5
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:10:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP3Jx-0006mr-5Q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP3Jr-0007Y6-UZ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:04:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP3Jq-0007WR-HF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:04:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id g26so5167712wmh.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=UTmgSX3YsyDWEgPgMU0oX1llXMLo7/qNT1U4uupCMLM=;
	b=BhIOPxWkX9rNrRiwgC5jphJezvVFyZonp4r5Jh+gGXEFFpUCLzKUACOLZOgGMvaHWk
	dhGnrNctd/qvxnLl4ZoeEmy7dsK9hty/ecWc0ZyjkcBVxnWkKB+KxALHlRO7XuacxvaT
	cC+H7N79eq0+UlR98Cdpq1MpuZh6MJZxPkdk4orW5IKnopojBiwQCrUb3uYocx0tdH3p
	rt/Z/j4DFnuIATqXD8fnOLiZ9B9KsgCJ313lYpGFBUhDwx4t9LX6vluptPzcQTZ9rCe5
	FKXLyMJLWF/o9yHNWtGYjA4eR84oSLZ1c/C2FcNmKmPx1qXxagdn+0UhynZMXMFwCjz4
	baAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=UTmgSX3YsyDWEgPgMU0oX1llXMLo7/qNT1U4uupCMLM=;
	b=fMPa2zP0KRxvW1ZH7Om6lYzXT8VerSZdHxoTLZMiR0oVKB1SuTw8+QowNmmOQTcYIL
	9lJCxHUSx/k+syjaf0RDchJonhuzuyYRjgBlsjegwoLflYh7DJ+2ParBuJm7O9ucKh6Z
	MJFbOYfJvMKUJkDvKFsGw2SpRCLlcfJ2J3QIRRps0u60KGOLFMCtozvmBgIhoeAMDn0g
	7HGfPqW6NN2oxL4N9G0zOSGNEUftY0HXy+VYTHxJ0YkJAVNmOwpffdkLXD3XNjoJ5IvB
	n1i7D/Nny0fnplow1nQMPNwEsz5h7ic2pJtaiqmotGlo0bE84iMB6WEwOY1RO1NB2Sd3
	jBLw==
X-Gm-Message-State: APjAAAXz23OgJTlkt2V+jbzsePPxBtAsECX01x7xOf/AoEf+YI8+RS1O
	CEmWWC8OxKW6Qr5UEStYzP3USw==
X-Google-Smtp-Source: APXvYqzEbu+zPuVXyTcO4L9G4MazQNVAjghqENvFyOklPqwNEeJO8pmLo4KRBj4D9ldmISMLKgelkA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr6653589wmc.15.1557486240207; 
	Fri, 10 May 2019 04:04:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id o8sm9849074wra.4.2019.05.10.04.03.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 04:03:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:03:57 +0100
Message-Id: <20190510110357.18825-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2] target/arm: Implement NSACR gating of
 floating point
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NSACR register allows secure code to configure the FPU
to be inaccessible to non-secure code. If the NSACR.CP10
bit is set then:
 * NS accesses to the FPU trap as UNDEF (ie to NS EL1 or EL2)
 * CPACR.{CP10,CP11} behave as if RAZ/WI
 * HCPTR.{TCP11,TCP10} behave as if RAO/WI

Note that we do not implement the NSACR.NSASEDIS bit which
gates only access to Advanced SIMD, in the same way that
we don't implement the equivalent CPACR.ASEDIS and HCPTR.TASE.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * fixed bug in cptr_el2_read() that meant we were forcing
   HCPTR.{TCP11,TCP10} to 0 when they should be 1
---
 target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e6eb0d0f36..f1fcce0313b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -928,9 +928,36 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         value &= mask;
     }
+
+    /*
+     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
+     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0xf << 20);
+        value |= env->cp15.cpacr_el1 & (0xf << 20);
+    }
+
     env->cp15.cpacr_el1 = value;
 }
 
+static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
+     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     */
+    uint64_t value = env->cp15.cpacr_el1;
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0xf << 20);
+    }
+    return value;
+}
+
+
 static void cpacr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Call cpacr_write() so that we reset with the correct RAO bits set
@@ -996,7 +1023,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
-      .resetfn = cpacr_reset, .writefn = cpacr_write },
+      .resetfn = cpacr_reset, .writefn = cpacr_write, .readfn = cpacr_read },
     REGINFO_SENTINEL
 };
 
@@ -4681,6 +4708,36 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     return ret;
 }
 
+static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /*
+     * For A-profile AArch32 EL3, if NSACR.CP10
+     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0x3 << 10);
+        value |= env->cp15.cptr_el[2] & (0x3 << 10);
+    }
+    env->cp15.cptr_el[2] = value;
+}
+
+static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * For A-profile AArch32 EL3, if NSACR.CP10
+     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     */
+    uint64_t value = env->cp15.cptr_el[2];
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value |= 0x3 << 10;
+    }
+    return value;
+}
+
 static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_IO,
@@ -4728,7 +4785,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "CPTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 2,
       .access = PL2_RW, .accessfn = cptr_access, .resetvalue = 0,
-      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]) },
+      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]),
+      .readfn = cptr_el2_read, .writefn = cptr_el2_write },
     { .name = "MAIR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[2]),
@@ -13527,6 +13585,19 @@ int fp_exception_el(CPUARMState *env, int cur_el)
         break;
     }
 
+    /*
+     * The NSACR allows A-profile AArch32 EL3 and M-profile secure mode
+     * to control non-secure access to the FPU. It doesn't have any
+     * effect if EL3 is AArch64 or if EL3 doesn't exist at all.
+     */
+    if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+         cur_el <= 2 && !arm_is_secure_below_el3(env))) {
+        if (!extract32(env->cp15.nsacr, 10, 1)) {
+            /* FP insns act as UNDEF */
+            return cur_el == 2 ? 2 : 1;
+        }
+    }
+
     /* For the CPTR registers we don't need to guard with an ARM_FEATURE
      * check because zero bits in the registers mean "don't trap".
      */
-- 
2.20.1


