Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4812082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4812082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxr1-0002F1-4M
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzxmf-0004ol-Hw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzxmd-0006UX-Ck
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:38:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39284 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzxmd-0006Nj-5C
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:38:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 83A621A1FB1;
 Tue, 20 Aug 2019 08:38:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 52DCF1A1151;
 Tue, 20 Aug 2019 08:38:15 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:37:54 +0200
Message-Id: <1566283083-21838-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566283083-21838-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566283083-21838-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 02/11] target/mips: Style improvements in cpu.c
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

Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1566216496-17375-8-git-send-email-aleksandar.markovic@rt-rk.=
com>
---
 target/mips/cpu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 39eafaf..3ffa342 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -57,9 +57,11 @@ static bool mips_cpu_has_work(CPUState *cs)
     CPUMIPSState *env =3D &cpu->env;
     bool has_work =3D false;
=20
-    /* Prior to MIPS Release 6 it is implementation dependent if non-ena=
bled
-       interrupts wake-up the CPU, however most of the implementations o=
nly
-       check for interrupts that can be taken. */
+    /*
+     * Prior to MIPS Release 6 it is implementation dependent if non-ena=
bled
+     * interrupts wake-up the CPU, however most of the implementations o=
nly
+     * check for interrupts that can be taken.
+     */
     if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
         cpu_mips_hw_interrupts_pending(env)) {
         if (cpu_mips_hw_interrupts_enabled(env) ||
@@ -70,8 +72,10 @@ static bool mips_cpu_has_work(CPUState *cs)
=20
     /* MIPS-MT has the ability to halt the CPU.  */
     if (env->CP0_Config3 & (1 << CP0C3_MT)) {
-        /* The QEMU model will issue an _WAKE request whenever the CPUs
-           should be woken up.  */
+        /*
+         * The QEMU model will issue an _WAKE request whenever the CPUs
+         * should be woken up.
+         */
         if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work =3D true;
         }
@@ -112,7 +116,8 @@ static void mips_cpu_reset(CPUState *s)
 #endif
 }
=20
-static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)=
 {
+static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+{
     MIPSCPU *cpu =3D MIPS_CPU(s);
     CPUMIPSState *env =3D &cpu->env;
=20
--=20
2.7.4


