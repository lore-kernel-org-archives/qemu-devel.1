Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF27EC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621C1217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w93VzOhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621C1217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbqu-0003Zi-F3
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:43:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbnn-0001Iv-QA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbnm-0008Ef-Gv
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEbnm-0008E2-5w
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so7932348wra.12
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DCRADAn52YQB0i1Vcag5VquhM34iiUI7ee/x7IVTB+I=;
	b=w93VzOhjHNXoT40RlJkosHDhMfGSasHqeNuNb1iQ47/8o3D9mWd5aQktuA1FBfqTEX
	02CK4EMU5HiW4hOi3OYFVbezZWea8HueruYgLo5Fk76TxhuKhGtpKnbr/Sn1OedSCJ0x
	SalAIq0brIfMWylnXK+K9pRkJl4xPgRCiehFB8Ci5NC2QfQyUhBPeq3CZ6a9ZTNkkY6g
	/pKjXKRak0fVNlMM9/hpgt5p+ngxYWuTdrf71yI0XqRgLTZ12LsCAOlsMFQi4KzH3Y0C
	TqwbYtgfeyueWCQwnzsAc8r3Vn7D7p2UBy3dwsNreqIi3y27HQWDGj0CvIRNn4uENni1
	OTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DCRADAn52YQB0i1Vcag5VquhM34iiUI7ee/x7IVTB+I=;
	b=s22dNceMb7V8On/93vt7pZUt1ACvjRJbjJLk3cUzrWa1n9ialwXRJRmc/SVvA7DyK/
	mAJqVypqWbwp6t5/Lm8va5Xy4q1KUgZVnlvcdzyAA9/Z74oSwOiW8bOqvig86W+iAqTD
	VfftUodJemZ/am+R/yNA/xFhG4fGYv9/fb/yFKODpeSoyn27Bvi0lYqBHNwiHUwYvjbq
	BZFYdidV3C+O+OcnOBV98i1xWJ060IxUZGf5biGwmVjfv5uY966+gdbesLoJFEM21dGs
	3J4VcVU8CESZPOvyYyMZ4c8Ru+1rjZUOcMs3Ysi1t4GtlydfR23g55QpaUK5n18GkLBn
	GizA==
X-Gm-Message-State: APjAAAVsUBBo2rFaW8iUMV5JhzR26XQVVXMOrzb2MLOArsJquD7X9ZQB
	7smkfjf4N5z0IgsGx2nVblIL1A==
X-Google-Smtp-Source: APXvYqwHBa4OBkdWxoeL2q/kLerwbXsxIU6+xK9/x11RsjjTGYqHgXkNWH7yNut/e9JpLzgJWz7gEQ==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr31103487wrp.6.1554997184884; 
	Thu, 11 Apr 2019 08:39:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y132sm6932581wmg.38.2019.04.11.08.39.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 08:39:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 16:39:42 +0100
Message-Id: <20190411153942.4533-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of floating
 point
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
Message-ID: <20190411153942.E84MI3TQTdwS2dD87MebXm1la9sEOpjJZpxiHoXsQ4c@z>

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
I noticed we were missing NSACR handling here while looking at
M profile floating point, but it turns out that M profile NSACR
isn't really the same, so the two don't share code. This patch
fixes the A-profile NSACR handling. Note that this only affects
CPUs with an AArch32 EL3.

 target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a0dd1f99974..26105f13e70 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -903,9 +903,36 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -971,7 +998,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
-      .resetfn = cpacr_reset, .writefn = cpacr_write },
+      .resetfn = cpacr_reset, .writefn = cpacr_write, .readfn = cpacr_read },
     REGINFO_SENTINEL
 };
 
@@ -4656,6 +4683,36 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
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
+        value &= ~(0x3 << 10);
+    }
+    return value;
+}
+
 static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_IO,
@@ -4703,7 +4760,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "CPTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 2,
       .access = PL2_RW, .accessfn = cptr_access, .resetvalue = 0,
-      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]) },
+      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]),
+      .readfn = cptr_el2_read, .writefn = cptr_el2_write },
     { .name = "MAIR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[2]),
@@ -12804,6 +12862,19 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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


