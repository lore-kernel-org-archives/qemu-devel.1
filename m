Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08649C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D105F2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D105F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2pb-0001ss-4f
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47374)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn2oq-00078z-Cb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn2op-0001Ya-7L
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn2om-0001WK-OO; Mon, 15 Jul 2019 11:23:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1910307D851;
 Mon, 15 Jul 2019 15:23:07 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53539608E4;
 Mon, 15 Jul 2019 15:22:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 17:22:24 +0200
Message-Id: <20190715152225.26135-5-philmd@redhat.com>
In-Reply-To: <20190715152225.26135-1-philmd@redhat.com>
References: <20190715152225.26135-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 15 Jul 2019 15:23:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1? v2 4/5] target/arm: Add stubs to
 build with CONFIG_SEMIHOSTING disabled
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 James Hogan <james.hogan@mips.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a distribution wants to build QEMU without semihosting support,
it currently gets this build failure:

  $ ./configure --target-list=3Daarch64-softmmu --without-default-devices
  $ sed -i s/CONFIG_SEMIHOSTING=3Dy/CONFIG_SEMIHOSTING=3Dn/ default-confi=
gs/arm-softmmu.mak
  $ make subdir-aarch64-softmmu
  [...]
    LINK    aarch64-softmmu/qemu-system-aarch64
  /usr/bin/ld: target/arm/arm-semi.o: in function `do_arm_semihosting':
  ./target/arm/arm-semi.c:321: undefined reference to `qemu_semihosting_c=
onsole_out'
  /usr/bin/ld: ./target/arm/arm-semi.c:318: undefined reference to `qemu_=
semihosting_console_out'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-aarch64] Error 1
  make: *** [Makefile:472: subdir-aarch64-softmmu] Error 2

Fix it by providing a stub when semihosting is disabled.

Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 +-
 target/arm/Makefile.objs        |  3 ++-
 target/arm/arm-semi-stubs.c     | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/arm-semi-stubs.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index ad2debf543..bf34bcb137 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,6 +1,6 @@
 # Default configuration for arm-softmmu
=20
-# CONFIG_SEMIHOSTING is always required on this architecture
+# CONFIG_SEMIHOSTING is not required on KVM only builds
 CONFIG_SEMIHOSTING=3Dy
=20
 # TODO: ARM_V7M is currently always required - make this more flexible!
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 5cafc1eb6c..4afaf82bbe 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-$(CONFIG_TCG) +=3D arm-semi.o
+obj-$(CONFIG_SEMIHOSTING) +=3D arm-semi.o
+obj-$(call lnot,$(CONFIG_SEMIHOSTING)) +=3D arm-semi-stubs.o
 obj-y +=3D helper.o vfp_helper.o
 obj-y +=3D cpu.o gdbstub.o
 obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
diff --git a/target/arm/arm-semi-stubs.c b/target/arm/arm-semi-stubs.c
new file mode 100644
index 0000000000..a91ecbd9d5
--- /dev/null
+++ b/target/arm/arm-semi-stubs.c
@@ -0,0 +1,21 @@
+/*
+ *  Arm "Angel" semihosting stubs
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+target_ulong do_arm_semihosting(CPUARMState *env)
+{
+    g_assert_not_reached();
+}
--=20
2.20.1


