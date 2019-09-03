Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90848C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6672B2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6672B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57Li-0001b6-C0
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i57Ht-0005A5-HX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i57Hs-00061l-Fg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i57Hq-0005zk-8d; Tue, 03 Sep 2019 07:47:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F43A30832EA;
 Tue,  3 Sep 2019 11:47:49 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-102.brq.redhat.com [10.40.204.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAFAF67600;
 Tue,  3 Sep 2019 11:47:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 13:47:28 +0200
Message-Id: <20190903114729.3400-5-philmd@redhat.com>
In-Reply-To: <20190903114729.3400-1-philmd@redhat.com>
References: <20190903114729.3400-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 03 Sep 2019 11:47:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/5] target/arm: Restrict R and M profiles
 to TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM is only able to run on CPUs based on the A-Profile architecture.

The following CPUs are disabled:

* M-Profile Architecture

  - Cortex-M3
  - Cortex-M4
  - Cortex-M33

* R-Profile Architecture

  - Cortex-R5
  - Cortex-R5F

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: list cpus
---
 target/arm/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f69780147c..299c59fde4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -462,7 +462,9 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
     return ret;
 }
=20
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+/* CPU models. These are not needed for the AArch64 linux-user build. */
+#if (!defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)) \
+    && defined(CONFIG_TCG)
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_reque=
st)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cs);
@@ -1902,8 +1904,6 @@ static void cortex_m0_initfn(Object *obj)
     cpu->midr =3D 0x410cc200;
 }
=20
-#endif
-
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -2057,6 +2057,8 @@ static void cortex_r5f_initfn(Object *obj)
     cpu->isar.mvfr1 =3D 0x00000011;
 }
=20
+#endif
+
 static const ARMCPRegInfo cortexa8_cp_reginfo[] =3D {
     { .name =3D "L2LOCKDOWN", .cp =3D 15, .crn =3D 9, .crm =3D 0, .opc1 =
=3D 1, .opc2 =3D 0,
       .access =3D PL1_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
@@ -2545,7 +2547,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
     { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
                              .class_init =3D arm_v7m_class_init },
-#endif
     { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
                              .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
@@ -2554,6 +2555,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
                              .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-r5",   .initfn =3D cortex_r5_initfn },
     { .name =3D "cortex-r5f",  .initfn =3D cortex_r5f_initfn },
+#endif
     { .name =3D "cortex-a7",   .initfn =3D cortex_a7_initfn },
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
--=20
2.20.1


