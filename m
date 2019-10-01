Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC4C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AB52133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AB52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJwN-0006SC-G4
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJte-0004gs-Ci
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iFJtc-0001sc-Mv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53431 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iFJtc-0000zH-Av
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A75C81A2397;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.55])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6579D1A22D4;
 Tue,  1 Oct 2019 17:15:54 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] target/mips: Clean up internal.h
Date: Tue,  1 Oct 2019 17:15:27 +0200
Message-Id: <1569942944-10381-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Mostly fix errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1569331602-2586-3-git-send-email-aleksandar.markovic@rt-rk.c=
om>
---
 target/mips/internal.h | 60 +++++++++++++++++++++++++++++++-------------=
------
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
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -9,8 +10,10 @@
=20
 #include "fpu/softfloat-helpers.h"
=20
-/* MMU types, the first four entries have the same layout as the
-   CP0C0_MT field.  */
+/*
+ * MMU types, the first four entries have the same layout as the
+ * CP0C0_MT field.
+ */
 enum mips_mmu_types {
     MMU_TYPE_NONE,
     MMU_TYPE_R4000,
@@ -160,9 +163,11 @@ static inline bool cpu_mips_hw_interrupts_enabled(CP=
UMIPSState *env)
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
=20
@@ -177,14 +182,18 @@ static inline bool cpu_mips_hw_interrupts_pending(C=
PUMIPSState *env)
     status =3D env->CP0_Status & CP0Ca_IP_mask;
=20
     if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
-        /* A MIPS configured with a vectorizing external interrupt contr=
oller
-           will feed a vector into the Cause pending lines. The core tre=
ats
-           the status lines as a vector level, not as indiviual masks.  =
*/
+        /*
+         * A MIPS configured with a vectorizing external interrupt contr=
oller
+         * will feed a vector into the Cause pending lines. The core tre=
ats
+         * the status lines as a vector level, not as indiviual masks.
+         */
         r =3D pending > status;
     } else {
-        /* A MIPS configured with compatibility or VInt (Vectored Interr=
upts)
-           treats the pending lines as individual interrupt lines, the s=
tatus
-           lines are individual masks.  */
+        /*
+         * A MIPS configured with compatibility or VInt (Vectored Interr=
upts)
+         * treats the pending lines as individual interrupt lines, the s=
tatus
+         * lines are individual masks.
+         */
         r =3D (pending & status) !=3D 0;
     }
     return r;
@@ -275,12 +284,14 @@ static inline int mips_vpe_active(CPUMIPSState *env=
)
         active =3D 0;
     }
=20
-    /* Now verify that there are active thread contexts in the VPE.
-
-       This assumes the CPU model will internally reschedule threads
-       if the active one goes to sleep. If there are no threads availabl=
e
-       the active one will be in a sleeping state, and we can turn off
-       the entire VPE.  */
+    /*
+     * Now verify that there are active thread contexts in the VPE.
+     *
+     * This assumes the CPU model will internally reschedule threads
+     * if the active one goes to sleep. If there are no threads availabl=
e
+     * the active one will be in a sleeping state, and we can turn off
+     * the entire VPE.
+     */
     if (!(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_A))) {
         /* TC is not activated.  */
         active =3D 0;
@@ -326,7 +337,8 @@ static inline void compute_hflags(CPUMIPSState *env)
     if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
         !(env->CP0_Status & (1 << CP0St_ERL)) &&
         !(env->hflags & MIPS_HFLAG_DM)) {
-        env->hflags |=3D (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU=
;
+        env->hflags |=3D (env->CP0_Status >> CP0St_KSU) &
+                       MIPS_HFLAG_KSU;
     }
 #if defined(TARGET_MIPS64)
     if ((env->insn_flags & ISA_MIPS3) &&
@@ -403,10 +415,12 @@ static inline void compute_hflags(CPUMIPSState *env=
)
             env->hflags |=3D MIPS_HFLAG_COP1X;
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
             env->hflags |=3D MIPS_HFLAG_COP1X;
         }
--=20
2.7.4


