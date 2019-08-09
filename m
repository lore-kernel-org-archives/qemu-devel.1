Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256FBC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA33A214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA33A214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4MP-0006rp-2k
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jp-0001kC-48
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jn-00018v-Kr
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52478 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hw4Jn-00017y-Ay
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id DDB781A20D8;
 Fri,  9 Aug 2019 14:48:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 90B101A206F;
 Fri,  9 Aug 2019 14:48:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 14:46:39 +0200
Message-Id: <1565354819-1495-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v7 06/26] target/mips: Style
 improvements in cp0_timer.c
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/mips/cp0_timer.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index f471639..b5f3560 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -29,7 +29,7 @@
 #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
=20
 /* XXX: do not use a global */
-uint32_t cpu_mips_get_random (CPUMIPSState *env)
+uint32_t cpu_mips_get_random(CPUMIPSState *env)
 {
     static uint32_t seed =3D 1;
     static uint32_t prev_idx =3D 0;
@@ -42,8 +42,10 @@ uint32_t cpu_mips_get_random (CPUMIPSState *env)
=20
     /* Don't return same value twice, so get another value */
     do {
-        /* Use a simple algorithm of Linear Congruential Generator
-         * from ISO/IEC 9899 standard. */
+        /*
+         * Use a simple algorithm of Linear Congruential Generator
+         * from ISO/IEC 9899 standard.
+         */
         seed =3D 1103515245 * seed + 12345;
         idx =3D (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
     } while (idx =3D=3D prev_idx);
@@ -73,7 +75,7 @@ static void cpu_mips_timer_expire(CPUMIPSState *env)
     qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
=20
-uint32_t cpu_mips_get_count (CPUMIPSState *env)
+uint32_t cpu_mips_get_count(CPUMIPSState *env)
 {
     if (env->CP0_Cause & (1 << CP0Ca_DC)) {
         return env->CP0_Count;
@@ -91,16 +93,16 @@ uint32_t cpu_mips_get_count (CPUMIPSState *env)
     }
 }
=20
-void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
+void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
 {
     /*
      * This gets called from cpu_state_reset(), potentially before timer=
 init.
      * So env->timer may be NULL, which is also the case with KVM enable=
d so
      * treat timer as disabled in that case.
      */
-    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer)
+    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
         env->CP0_Count =3D count;
-    else {
+    } else {
         /* Store new count register */
         env->CP0_Count =3D count -
                (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_=
PERIOD);
@@ -109,13 +111,15 @@ void cpu_mips_store_count (CPUMIPSState *env, uint3=
2_t count)
     }
 }
=20
-void cpu_mips_store_compare (CPUMIPSState *env, uint32_t value)
+void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value)
 {
     env->CP0_Compare =3D value;
-    if (!(env->CP0_Cause & (1 << CP0Ca_DC)))
+    if (!(env->CP0_Cause & (1 << CP0Ca_DC))) {
         cpu_mips_timer_update(env);
-    if (env->insn_flags & ISA_MIPS32R2)
+    }
+    if (env->insn_flags & ISA_MIPS32R2) {
         env->CP0_Cause &=3D ~(1 << CP0Ca_TI);
+    }
     qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
=20
@@ -131,27 +135,27 @@ void cpu_mips_stop_count(CPUMIPSState *env)
                                  TIMER_PERIOD);
 }
=20
-static void mips_timer_cb (void *opaque)
+static void mips_timer_cb(void *opaque)
 {
     CPUMIPSState *env;
=20
     env =3D opaque;
-#if 0
-    qemu_log("%s\n", __func__);
-#endif
=20
-    if (env->CP0_Cause & (1 << CP0Ca_DC))
+    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
         return;
+    }
=20
-    /* ??? This callback should occur when the counter is exactly equal =
to
-       the comparator value.  Offset the count by one to avoid immediate=
ly
-       retriggering the callback before any virtual time has passed.  */
+    /*
+     * ??? This callback should occur when the counter is exactly equal =
to
+     * the comparator value.  Offset the count by one to avoid immediate=
ly
+     * retriggering the callback before any virtual time has passed.
+     */
     env->CP0_Count++;
     cpu_mips_timer_expire(env);
     env->CP0_Count--;
 }
=20
-void cpu_mips_clock_init (MIPSCPU *cpu)
+void cpu_mips_clock_init(MIPSCPU *cpu)
 {
     CPUMIPSState *env =3D &cpu->env;
=20
--=20
2.7.4


