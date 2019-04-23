Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95882C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CF32077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CF32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItjV-0005uG-Me
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:37:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001d2-7u
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005W7-5h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41183 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004B6-TN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 770E01A2434;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 4A2E81A243B;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:37 +0200
Message-Id: <1556018982-3715-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 3/8] target/mips: Remove a space before open
 parenthesis to fix checkpatch errors
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423112937.zVjp5TCR2_UqMgznUGZzzjSgE8XjkCuVDJhB8A-Wm1I@z>

From: Jules Irenge <jbi.octave@gmail.com>

Remove a space before open parenthesis to fix errors reported by
checkpatch.pl tool "ERROR: space prohibited between function name
and open parenthesis" within the file target/mips/cp0_timer.c.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190327145308.17838-1-jbi.octave@gmail.com>
---
 target/mips/cp0_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index f471639..742f4b2 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -29,7 +29,7 @@
 #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
 
 /* XXX: do not use a global */
-uint32_t cpu_mips_get_random (CPUMIPSState *env)
+uint32_t cpu_mips_get_random(CPUMIPSState *env)
 {
     static uint32_t seed = 1;
     static uint32_t prev_idx = 0;
@@ -73,7 +73,7 @@ static void cpu_mips_timer_expire(CPUMIPSState *env)
     qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
 
-uint32_t cpu_mips_get_count (CPUMIPSState *env)
+uint32_t cpu_mips_get_count(CPUMIPSState *env)
 {
     if (env->CP0_Cause & (1 << CP0Ca_DC)) {
         return env->CP0_Count;
@@ -91,7 +91,7 @@ uint32_t cpu_mips_get_count (CPUMIPSState *env)
     }
 }
 
-void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
+void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
 {
     /*
      * This gets called from cpu_state_reset(), potentially before timer init.
@@ -109,7 +109,7 @@ void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
     }
 }
 
-void cpu_mips_store_compare (CPUMIPSState *env, uint32_t value)
+void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value)
 {
     env->CP0_Compare = value;
     if (!(env->CP0_Cause & (1 << CP0Ca_DC)))
@@ -131,7 +131,7 @@ void cpu_mips_stop_count(CPUMIPSState *env)
                                  TIMER_PERIOD);
 }
 
-static void mips_timer_cb (void *opaque)
+static void mips_timer_cb(void *opaque)
 {
     CPUMIPSState *env;
 
@@ -151,7 +151,7 @@ static void mips_timer_cb (void *opaque)
     env->CP0_Count--;
 }
 
-void cpu_mips_clock_init (MIPSCPU *cpu)
+void cpu_mips_clock_init(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-- 
2.7.4


