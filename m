Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD62CC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A102067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A102067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2pN-0000on-RG
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn2ox-0007c0-43
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn2ow-0001ez-0t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:23:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn2ot-0001c2-Gs; Mon, 15 Jul 2019 11:23:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA401C057F3D;
 Mon, 15 Jul 2019 15:23:14 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEA5A608C6;
 Mon, 15 Jul 2019 15:23:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 17:22:25 +0200
Message-Id: <20190715152225.26135-6-philmd@redhat.com>
In-Reply-To: <20190715152225.26135-1-philmd@redhat.com>
References: <20190715152225.26135-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 15 Jul 2019 15:23:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1? v2 5/5] target/mips: Add stubs to
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
 Paolo Bonzini <pbonzini@redhat.com>, James Hogan <james.hogan@mips.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a distribution wants to build QEMU without semihosting support,
it currently gets this build failure:

  $ ./configure --target-list=3Dmips64el-softmmu --without-default-device=
s
  $ sed -i s/CONFIG_SEMIHOSTING=3Dy/CONFIG_SEMIHOSTING=3Dn/ default-confi=
gs/mips-softmmu-common.mak
  $ make subdir-mips64el-softmmu
  [...]
    LINK    mips64el-softmmu/qemu-system-mips64el
  /usr/bin/ld: target/mips/mips-semi.o: in function `helper_do_semihostin=
g':
  ./target/mips/mips-semi.c:335: undefined reference to `qemu_semihosting=
_log_out'
  /usr/bin/ld: ./target/mips/mips-semi.c:338: undefined reference to `qem=
u_semihosting_log_out'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-mips64el] Error 1
  make: *** [Makefile:472: subdir-mips64el-softmmu] Error 2

Fix it by providing a stub when semihosting is disabled.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak |  2 +-
 target/mips/Makefile.objs               |  3 ++-
 target/mips/mips-semi-stubs.c           | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 target/mips/mips-semi-stubs.c

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index da29c6c0b2..08fa16191f 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,6 +1,6 @@
 # Common mips*-softmmu CONFIG defines
=20
-# CONFIG_SEMIHOSTING is always required on this architecture
+# CONFIG_SEMIHOSTING is probably not required on KVM only builds
 CONFIG_SEMIHOSTING=3Dy
=20
 CONFIG_ISA_BUS=3Dy
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index 3448ad5e19..3f4d566a35 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,5 +1,6 @@
 obj-y +=3D translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cp=
u.o
 obj-y +=3D gdbstub.o msa_helper.o
-obj-$(CONFIG_SOFTMMU) +=3D mips-semi.o
+obj-$(CONFIG_SEMIHOSTING) +=3D mips-semi.o
+obj-$(call lnot,$(CONFIG_SEMIHOSTING)) +=3D mips-semi-stubs.o
 obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
 obj-$(CONFIG_KVM) +=3D kvm.o
diff --git a/target/mips/mips-semi-stubs.c b/target/mips/mips-semi-stubs.=
c
new file mode 100644
index 0000000000..b1d3f88edc
--- /dev/null
+++ b/target/mips/mips-semi-stubs.c
@@ -0,0 +1,22 @@
+/*
+ * Unified Hosting Interface syscalls stubs
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
+#include "exec/helper-proto.h"
+
+void helper_do_semihosting(CPUMIPSState *env)
+{
+    g_assert_not_reached();
+}
--=20
2.20.1


