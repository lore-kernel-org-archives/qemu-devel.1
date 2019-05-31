Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B465C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D072521D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D072521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWk8q-0007ZN-D6
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:12:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWk4q-0004JG-4I
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWjqJ-0004q2-5Q
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hWjlQ-0002z9-98; Fri, 31 May 2019 11:48:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F5467E43D;
	Fri, 31 May 2019 15:48:07 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-73.brq.redhat.com [10.40.204.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB151001E6F;
	Fri, 31 May 2019 15:47:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 17:47:35 +0200
Message-Id: <20190531154735.20809-3-philmd@redhat.com>
In-Reply-To: <20190531154735.20809-1-philmd@redhat.com>
References: <20190531154735.20809-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 31 May 2019 15:48:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 2/2] target/mips: Add stubs to build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Miroslav Rezanina <mrezanin@redhat.com>,
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
checkpatch ERROR: externs should be avoided in .c files
---
 target/mips/Makefile.objs     |  3 ++-
 target/mips/mips-semi-stubs.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 target/mips/mips-semi-stubs.c

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
index 0000000000..f5b13b9153
--- /dev/null
+++ b/target/mips/mips-semi-stubs.c
@@ -0,0 +1,23 @@
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
+
+extern void helper_do_semihosting(CPUMIPSState *env);
+
+void helper_do_semihosting(CPUMIPSState *env)
+{
+    g_assert_not_reached();
+}
--=20
2.20.1


