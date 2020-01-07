Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0486C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF8621744
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ig+J8yro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF8621744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopoB-0003QQ-C9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iooNm-0003SU-OL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iooNl-0000ri-Cx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:43037)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iooNk-0000q3-V6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578401683;
 bh=eNuBNnxJHzrGSGh2b0nw38wxbBQv+W8/M0AHAXoAGfI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ig+J8yro9ouUOZWQ7+z60n7kxPT2qeydkt/eUskNTBGwZCS0RasDk8VsHfcGf/vuV
 8jMU+c8Kdu3MoHsx8ywBw+J0MFkBTILSHc7Vk/Yo7bZFPRsK89odwZEP2v3PpYn1lH
 zKO9qhluRGbmXLVHZTN1QIN4jMaFw96aEz9hXNqw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MGQjH-1iuWLu2UO5-00GrT2; Tue, 07 Jan 2020 13:54:43 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] Add the NVMM vcpu API
Date: Tue,  7 Jan 2020 13:53:58 +0100
Message-Id: <20200107125401.18126-2-n54@gmx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200107125401.18126-1-n54@gmx.com>
References: <20200107125401.18126-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q78W7+Nh/tS5mATSSNafgTjei8zku2qFw1wmn9izQX2pCirF4bd
 2f6RoAZBOPFeBXhvETFpjy0BAuNhtZrGn6mFeEFXeQgC5tIsMZKOrt2y9lDNAn/f0+DkgSn
 5Dkq2qVPGb62LbDSegWa5+ngC05H2txWzc0mLRQVeGacM6ccYD/DvDH27PTX9O1id7fCUh8
 HOeKtqW+XRBgNkZEAIeZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KSEg4hHAqDA=:naNWZVKx8X4B/Qq9wWDEan
 VjoO47gFLwyotVOqZtUw9gjANpXHUyD6QM9vkS8gGoa/pPG9WW3RXKfAX1ErOk9nQKjLJxxoJ
 GsPIW79FrvRJ6USP7Sl8SAPodtDcF/CeapWIH56LnutwTe9EFhtABdWViobxkErsYIdcBEDj5
 YJ1YGN2ZaTB71lRSgheXMuxDqdZgZDnpxAQONLj+qqbJmbkuq+B2arsFs8DUrb7QLuodi4zjZ
 LuaoovgrM9/Z84+hGi8cB6CT8w7XgG2IBBWfNNZ1X4ADUuoULGKKvDehu14GxSfJbNEp5m1Sz
 PJW7K9nY86YuBmlpASdKaR8WbfV15xlB6ySWAjxtF3/pVnz8cfXxFM9FC6OllRfUpstXydmHR
 Eyg8beMsy726gRxRGjxbZyAD+X3BzvDVcbgz/AZbdMhh85U1Z15gP59ouOo+GvtvRqSWyuZny
 3XpuBm8GpcL2vKm+poKrbe6CJ/T9f6cfISgrwzj65dmbuMi41s1GqkC1dt71kbXcfoZhaMTML
 6sYPCu9zmtS75ZW00wwWobBx6C5l0aSdcP88FtetpzB/zY1qtNgc1pAX9EfwqhvnhF7J/DNgl
 Y7euLzfujYVIesfYjOArKupRmb+PiX2oDZ26Eh4aPp76IQr9RQLT/H2UbtxBqiXvrSWdtS8Id
 VGwmhc7fn93MQMQLleOL2Lc7orQ9CbM6VH/HVWnq5q3bJBlqp7PrN3Qgl8F+X/7T4dyY3wshH
 c6Rm0O3Id55vTgavXPeyliwQIZ8ZT/VZbJl07jKXqich7UibxtaIsjijZ0bUIN8IID6IPLsmC
 TNhz6nztS+uOKXroc3loy4f1EaOxmOBtnyyYIAWPbNOEQ4Vkp/oWYVkY2ZNlYJs0LqS4m+Vil
 JbQ/3kncyqi/Mb5UNM/V7PVKhlkEMDNmyOISrmC6KoXtpAs5gaDTrdnhH3yi3KPBB8uZO5jhP
 zJuYIAejlU2ZNtabt5XIK7r2uMO+s/21GBE9cCZxcA2lU9Z5y+ezDGQQRntK1nbUG0Ow9yrZv
 p+oMIdocBrxLcJcOLbEz6zcOPxtVog1Fxs3BoxrVbWWVfr2uWOUsvDva9MUV10UVP4FHiVGos
 WcZbBL988zK+CG/kOWSiJ01dP6BgioytSbuC6ZlyqvAPK48OpdPJwgfPgwyQ6tlvhalapQxJt
 vnfU9KNreawJiXQ0kABwByC9jSiEnHh4v+YPJhaiPLOOWwf9asC3ft3jyO/byl8k/E3h4w5Vs
 UQCiPhxyIb9j7AHzeoCJ2XWR3RBi7aU85tHwzhw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>,
 Maxime Villard <max@m00nbsd.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
introduces the nvmm.h sysemu API for managing the vcpu scheduling and
management.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
=2D--
 accel/stubs/Makefile.objs |  1 +
 accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index 3894caf95d..09f2d3e1dd 100644
=2D-- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
 obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
 obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
+obj-$(call lnot,$(CONFIG_NVMM)) +=3D nvmm-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 0000000000..c2208b84a3
=2D-- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator stub.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "sysemu/nvmm.h"
+
+int nvmm_init_vcpu(CPUState *cpu)
+{
+    return -1;
+}
+
+int nvmm_vcpu_exec(CPUState *cpu)
+{
+    return -1;
+}
+
+void nvmm_destroy_vcpu(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_state(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
new file mode 100644
index 0000000000..10496f3980
=2D-- /dev/null
+++ b/include/sysemu/nvmm.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator support.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_NVMM_H
+#define QEMU_NVMM_H
+
+#include "config-host.h"
+#include "qemu-common.h"
+
+int nvmm_init_vcpu(CPUState *);
+int nvmm_vcpu_exec(CPUState *);
+void nvmm_destroy_vcpu(CPUState *);
+
+void nvmm_cpu_synchronize_state(CPUState *);
+void nvmm_cpu_synchronize_post_reset(CPUState *);
+void nvmm_cpu_synchronize_post_init(CPUState *);
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *);
+
+#ifdef CONFIG_NVMM
+
+int nvmm_enabled(void);
+
+#else /* CONFIG_NVMM */
+
+#define nvmm_enabled() (0)
+
+#endif /* CONFIG_NVMM */
+
+#endif /* CONFIG_NVMM */
=2D-
2.24.0


