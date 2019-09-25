Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13304C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D750F2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D750F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6nl-00074v-GH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iD6gd-0001GR-QT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iD6gc-0002Eo-1W
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:27 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56081 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iD6gb-0002DE-Js
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:46:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 88C8F1A23B8;
 Wed, 25 Sep 2019 14:46:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 60EDD1A2060;
 Wed, 25 Sep 2019 14:46:21 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/20] target/mips: Clean up internal.h
Date: Wed, 25 Sep 2019 14:45:54 +0200
Message-Id: <1569415572-19635-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Mostly fix errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/internal.h | 60 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 685e8d6..3f435b5 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -1,4 +1,5 @@
-/* mips internal definitions and helpers
+/*
+ * MIPS internal definitions and helpers
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -9,8 +10,10 @@
 
 #include "fpu/softfloat-helpers.h"
 
-/* MMU types, the first four entries have the same layout as the
-   CP0C0_MT field.  */
+/*
+ * MMU types, the first four entries have the same layout as the
+ * CP0C0_MT field.
+ */
 enum mips_mmu_types {
     MMU_TYPE_NONE,
     MMU_TYPE_R4000,
@@ -160,9 +163,11 @@ static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
         !(env->CP0_Status & (1 << CP0St_EXL)) &&
         !(env->CP0_Status & (1 << CP0St_ERL)) &&
         !(env->hflags & MIPS_HFLAG_DM) &&
-        /* Note that the TCStatus IXMT field is initialized to zero,
-           and only MT capable cores can set it to one. So we don't
-           need to check for MT capabilities here.  */
+        /*
+         * Note that the TCStatus IXMT field is initialized to zero,
+         * and only MT capable cores can set it to one. So we don't
+         * need to check for MT capabilities here.
+         */
         !(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_IXMT));
 }
 
@@ -177,14 +182,18 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
     status = env->CP0_Status & CP0Ca_IP_mask;
 
     if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
-        /* A MIPS configured with a vectorizing external interrupt controller
-           will feed a vector into the Cause pending lines. The core treats
-           the status lines as a vector level, not as indiviual masks.  */
+        /*
+         * A MIPS configured with a vectorizing external interrupt controller
+         * will feed a vector into the Cause pending lines. The core treats
+         * the status lines as a vector level, not as indiviual masks.
+         */
         r = pending > status;
     } else {
-        /* A MIPS configured with compatibility or VInt (Vectored Interrupts)
-           treats the pending lines as individual interrupt lines, the status
-           lines are individual masks.  */
+        /*
+         * A MIPS configured with compatibility or VInt (Vectored Interrupts)
+         * treats the pending lines as individual interrupt lines, the status
+         * lines are individual masks.
+         */
         r = (pending & status) != 0;
     }
     return r;
@@ -275,12 +284,14 @@ static inline int mips_vpe_active(CPUMIPSState *env)
         active = 0;
     }
 
-    /* Now verify that there are active thread contexts in the VPE.
-
-       This assumes the CPU model will internally reschedule threads
-       if the active one goes to sleep. If there are no threads available
-       the active one will be in a sleeping state, and we can turn off
-       the entire VPE.  */
+    /*
+     * Now verify that there are active thread contexts in the VPE.
+     *
+     * This assumes the CPU model will internally reschedule threads
+     * if the active one goes to sleep. If there are no threads available
+     * the active one will be in a sleeping state, and we can turn off
+     * the entire VPE.
+     */
     if (!(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_A))) {
         /* TC is not activated.  */
         active = 0;
@@ -326,7 +337,8 @@ static inline void compute_hflags(CPUMIPSState *env)
     if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
         !(env->CP0_Status & (1 << CP0St_ERL)) &&
         !(env->hflags & MIPS_HFLAG_DM)) {
-        env->hflags |= (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU;
+        env->hflags |= (env->CP0_Status >> CP0St_KSU) &
+                       MIPS_HFLAG_KSU;
     }
 #if defined(TARGET_MIPS64)
     if ((env->insn_flags & ISA_MIPS3) &&
@@ -403,10 +415,12 @@ static inline void compute_hflags(CPUMIPSState *env)
             env->hflags |= MIPS_HFLAG_COP1X;
         }
     } else if (env->insn_flags & ISA_MIPS4) {
-        /* All supported MIPS IV CPUs use the XX (CU3) to enable
-           and disable the MIPS IV extensions to the MIPS III ISA.
-           Some other MIPS IV CPUs ignore the bit, so the check here
-           would be too restrictive for them.  */
+        /*
+         * All supported MIPS IV CPUs use the XX (CU3) to enable
+         * and disable the MIPS IV extensions to the MIPS III ISA.
+         * Some other MIPS IV CPUs ignore the bit, so the check here
+         * would be too restrictive for them.
+         */
         if (env->CP0_Status & (1U << CP0St_CU3)) {
             env->hflags |= MIPS_HFLAG_COP1X;
         }
-- 
2.7.4


