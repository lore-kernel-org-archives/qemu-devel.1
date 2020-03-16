Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43FDC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F918205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSG72dvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F918205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtkS-0001tK-W8
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsME-0006TI-20
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsMB-0000Wc-VH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:12:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsMB-0000Ua-R0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584375167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bev69B8UQo4K2rDxR5YSrNIDlGaBvtKUt0JmYj+W6cM=;
 b=fSG72dvjhenKG5ofuczfpjETTanNmTQTyTEZWe8LJ1zi9h6a0hdzuWqflFIoomMCCt5cyH
 9MYWQ0XGR5eMqFk1GTnBY7Vra7tmTL0XQICBjqOvHITHU+7pLfBfYOOZFKTgwgv69myu7X
 MAACXcgQXgzttkw6SDlDW9kWjcU0ygM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-tkO4lIOdMyygnQ2TsPg9yQ-1; Mon, 16 Mar 2020 12:12:45 -0400
X-MC-Unique: tkO4lIOdMyygnQ2TsPg9yQ-1
Received: by mail-wm1-f71.google.com with SMTP id a13so6011968wme.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wL60xHob88fQ7VIPeFS5XLuacMMTzsdimp2PvDIHEac=;
 b=C4/6YJpCNrkCEwvXaiZYE9nIzbS8KoL8HXDPSc32ZOiBberrMCwdIxLkUJ5JBH0cOU
 DZ683YEX/dXjTWPbC2VytRktiSSO0JbD3JL9LenksRdeLdp+rq8AfPvN9eFTB7I0cb4o
 U+5hGzDOFscA3CwNlmxPmmA/XXZpo/ULwn62957/tNybaIPYWmwWjcFTSeQpRF/w1mt4
 487y4tPhTa9Kb0yNVhFJ83ZFc2Jd0NaB45HhC2rjajbmbAwYTLsiSNA48MfqXpqybmEU
 iTxxWL4bFBaaoJlKnqWT0/i+scyQsfceXwpKgTFv2p+TAODjyR34YfPaSUVXTHKtHklm
 vwzA==
X-Gm-Message-State: ANhLgQ1rGrVP1x93iCe6aH8XRMlfLthEhDCn18sOwzAOi/3JmDAWhiup
 axjLNaF5ddL3cBeIgOLVUd/Sv7Yt13tjH77IRRf1El7fei5g+v3Ng5y9KI2gW9gzMMiW9iX0bIc
 /SgW8mgXc9JrNmHM=
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr27973263wmc.148.1584374863911; 
 Mon, 16 Mar 2020 09:07:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuel+IgN0ODwNbK6ZFzKt+p1vYcd4ktsX8FiFd1ybGIsy2EPitjEqzcxIwOwndB4N0aPiXAg==
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr27973218wmc.148.1584374863467; 
 Mon, 16 Mar 2020 09:07:43 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id 96sm549814wrm.63.2020.03.16.09.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/19] target/arm: Restrict ARMv6 cpus to TCG accel
Date: Mon, 16 Mar 2020 17:06:27 +0100
Message-Id: <20200316160634.3386-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM requires a cpu based on (at least) the ARMv7 architecture.

Only enable the following ARMv6 CPUs when TCG is available:

  - ARM1136
  - ARM1176
  - ARM11MPCore
  - Cortex-M0

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |   2 -
 target/arm/cpu.c                | 137 -------------------------
 target/arm/cpu_v6.c             | 171 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   2 +
 target/arm/Kconfig              |   4 +
 target/arm/Makefile.objs        |   1 +
 6 files changed, 178 insertions(+), 139 deletions(-)
 create mode 100644 target/arm/cpu_v6.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index f176a98296..3aa27f3b40 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -13,9 +13,7 @@ CONFIG_ARM_VIRT=3Dy
 CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
-CONFIG_FSL_IMX31=3Dy
 CONFIG_MUSCA=3Dy
-CONFIG_NSERIES=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
 CONFIG_VEXPRESS=3Dy
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f1d1ba8451..34908828a0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1834,135 +1834,6 @@ static ObjectClass *arm_cpu_class_by_name(const cha=
r *cpu_model)
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
=20
-static void arm1136_r2_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-    /* What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
-     * older core than plain "arm1136". In particular this does not
-     * have the v6K features.
-     * These ID register values are correct for 1136 but may be wrong
-     * for 1136_r2 (in particular r0p2 does not actually implement most
-     * of the ID registers).
-     */
-
-    cpu->dtb_compatible =3D "arm,arm1136";
-    set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
-    cpu->midr =3D 0x4107b362;
-    cpu->reset_fpsid =3D 0x410120b4;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00050078;
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x1;
-    cpu->isar.id_dfr0 =3D 0x2;
-    cpu->id_afr0 =3D 0x3;
-    cpu->isar.id_mmfr0 =3D 0x01130003;
-    cpu->isar.id_mmfr1 =3D 0x10030302;
-    cpu->isar.id_mmfr2 =3D 0x01222110;
-    cpu->isar.id_isar0 =3D 0x00140011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11231111;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x141;
-    cpu->reset_auxcr =3D 7;
-}
-
-static void arm1136_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm1136";
-    set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
-    cpu->midr =3D 0x4117b363;
-    cpu->reset_fpsid =3D 0x410120b4;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00050078;
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x1;
-    cpu->isar.id_dfr0 =3D 0x2;
-    cpu->id_afr0 =3D 0x3;
-    cpu->isar.id_mmfr0 =3D 0x01130003;
-    cpu->isar.id_mmfr1 =3D 0x10030302;
-    cpu->isar.id_mmfr2 =3D 0x01222110;
-    cpu->isar.id_isar0 =3D 0x00140011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11231111;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x141;
-    cpu->reset_auxcr =3D 7;
-}
-
-static void arm1176_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm1176";
-    set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VAPA);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
-    set_feature(&cpu->env, ARM_FEATURE_EL3);
-    cpu->midr =3D 0x410fb767;
-    cpu->reset_fpsid =3D 0x410120b5;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00050078;
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x11;
-    cpu->isar.id_dfr0 =3D 0x33;
-    cpu->id_afr0 =3D 0;
-    cpu->isar.id_mmfr0 =3D 0x01130003;
-    cpu->isar.id_mmfr1 =3D 0x10030302;
-    cpu->isar.id_mmfr2 =3D 0x01222100;
-    cpu->isar.id_isar0 =3D 0x0140011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11231121;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x01141;
-    cpu->reset_auxcr =3D 7;
-}
-
-static void arm11mpcore_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm11mpcore";
-    set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VAPA);
-    set_feature(&cpu->env, ARM_FEATURE_MPIDR);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    cpu->midr =3D 0x410fb022;
-    cpu->reset_fpsid =3D 0x410120b4;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1d192992; /* 32K icache 32K dcache */
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x1;
-    cpu->isar.id_dfr0 =3D 0;
-    cpu->id_afr0 =3D 0x2;
-    cpu->isar.id_mmfr0 =3D 0x01100103;
-    cpu->isar.id_mmfr1 =3D 0x10020302;
-    cpu->isar.id_mmfr2 =3D 0x01222000;
-    cpu->isar.id_isar0 =3D 0x00100011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11221011;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x141;
-    cpu->reset_auxcr =3D 1;
-}
-
 static void cortex_m0_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -2452,14 +2323,6 @@ static void arm_max_initfn(Object *obj)
=20
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-    /* What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
-     * older core than plain "arm1136". In particular this does not
-     * have the v6K features.
-     */
-    { .name =3D "arm1136-r2",  .initfn =3D arm1136_r2_initfn },
-    { .name =3D "arm1136",     .initfn =3D arm1136_initfn },
-    { .name =3D "arm1176",     .initfn =3D arm1176_initfn },
-    { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
     { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
                              .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
diff --git a/target/arm/cpu_v6.c b/target/arm/cpu_v6.c
new file mode 100644
index 0000000000..1c73c881f3
--- /dev/null
+++ b/target/arm/cpu_v6.c
@@ -0,0 +1,171 @@
+/*
+ * ARM generic helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+
+/* CPU models. These are not needed for the AArch64 linux-user build. */
+#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+
+static void arm1136_r2_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    /*
+     * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
+     * older core than plain "arm1136". In particular this does not
+     * have the v6K features.
+     * These ID register values are correct for 1136 but may be wrong
+     * for 1136_r2 (in particular r0p2 does not actually implement most
+     * of the ID registers).
+     */
+
+    cpu->dtb_compatible =3D "arm,arm1136";
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    cpu->midr =3D 0x4107b362;
+    cpu->reset_fpsid =3D 0x410120b4;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00050078;
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x1;
+    cpu->isar.id_dfr0 =3D 0x2;
+    cpu->id_afr0 =3D 0x3;
+    cpu->isar.id_mmfr0 =3D 0x01130003;
+    cpu->isar.id_mmfr1 =3D 0x10030302;
+    cpu->isar.id_mmfr2 =3D 0x01222110;
+    cpu->isar.id_isar0 =3D 0x00140011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11231111;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x141;
+    cpu->reset_auxcr =3D 7;
+}
+
+static void arm1136_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm1136";
+    set_feature(&cpu->env, ARM_FEATURE_V6K);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    cpu->midr =3D 0x4117b363;
+    cpu->reset_fpsid =3D 0x410120b4;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00050078;
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x1;
+    cpu->isar.id_dfr0 =3D 0x2;
+    cpu->id_afr0 =3D 0x3;
+    cpu->isar.id_mmfr0 =3D 0x01130003;
+    cpu->isar.id_mmfr1 =3D 0x10030302;
+    cpu->isar.id_mmfr2 =3D 0x01222110;
+    cpu->isar.id_isar0 =3D 0x00140011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11231111;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x141;
+    cpu->reset_auxcr =3D 7;
+}
+
+static void arm1176_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm1176";
+    set_feature(&cpu->env, ARM_FEATURE_V6K);
+    set_feature(&cpu->env, ARM_FEATURE_VAPA);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    cpu->midr =3D 0x410fb767;
+    cpu->reset_fpsid =3D 0x410120b5;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00050078;
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x11;
+    cpu->isar.id_dfr0 =3D 0x33;
+    cpu->id_afr0 =3D 0;
+    cpu->isar.id_mmfr0 =3D 0x01130003;
+    cpu->isar.id_mmfr1 =3D 0x10030302;
+    cpu->isar.id_mmfr2 =3D 0x01222100;
+    cpu->isar.id_isar0 =3D 0x0140011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11231121;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x01141;
+    cpu->reset_auxcr =3D 7;
+}
+
+static void arm11mpcore_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm11mpcore";
+    set_feature(&cpu->env, ARM_FEATURE_V6K);
+    set_feature(&cpu->env, ARM_FEATURE_VAPA);
+    set_feature(&cpu->env, ARM_FEATURE_MPIDR);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    cpu->midr =3D 0x410fb022;
+    cpu->reset_fpsid =3D 0x410120b4;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1d192992; /* 32K icache 32K dcache */
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x1;
+    cpu->isar.id_dfr0 =3D 0;
+    cpu->id_afr0 =3D 0x2;
+    cpu->isar.id_mmfr0 =3D 0x01100103;
+    cpu->isar.id_mmfr1 =3D 0x10020302;
+    cpu->isar.id_mmfr2 =3D 0x01222000;
+    cpu->isar.id_isar0 =3D 0x00100011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11221011;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x141;
+    cpu->reset_auxcr =3D 1;
+}
+
+static const ARMCPUInfo arm_v6_cpus[] =3D {
+    /*
+     * What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e.
+     * an older core than plain "arm1136". In particular this does
+     * not have the v6K features.
+     */
+    { .name =3D "arm1136-r2",  .initfn =3D arm1136_r2_initfn },
+    { .name =3D "arm1136",     .initfn =3D arm1136_initfn },
+    { .name =3D "arm1176",     .initfn =3D arm1176_initfn },
+    { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
+    { .name =3D NULL }
+};
+
+static void arm_v6_cpu_register_types(void)
+{
+    const ARMCPUInfo *info =3D arm_v6_cpus;
+
+    while (info->name) {
+        arm_cpu_register(info);
+        info++;
+    }
+}
+
+type_init(arm_v6_cpu_register_types)
+
+#endif
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3b78471de0..e87dd611f2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -113,6 +113,7 @@ config NETDUINOPLUS2
=20
 config NSERIES
     bool
+    select ARM_V6
     select OMAP
     select TMP105   # tempature sensor
     select BLIZZARD # LCD/TV controller
@@ -367,6 +368,7 @@ config FSL_IMX25
=20
 config FSL_IMX31
     bool
+    select ARM_V6
     select SERIAL
     select IMX
     select IMX_I2C
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index 028d8382fe..df5f8dff42 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -6,5 +6,9 @@ config ARM_V5
     depends on TCG
     bool
=20
+config ARM_V6
+    depends on TCG
+    bool
+
 config ARM_V7M
     bool
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index f66f7f1158..0473c559c6 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -70,6 +70,7 @@ obj-y +=3D m_helper.o
=20
 obj-$(CONFIG_ARM_V4) +=3D cpu_v4.o
 obj-$(CONFIG_ARM_V5) +=3D cpu_v5.o
+obj-$(CONFIG_ARM_V6) +=3D cpu_v6.o
=20
 obj-$(CONFIG_SOFTMMU) +=3D psci.o
=20
--=20
2.21.1


