Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45091C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1683A20869
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1683A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzcU-00023s-6i
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:05:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRz-00017P-UB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRy-0007Ki-Gy
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hEzRs-00075N-Jk; Fri, 12 Apr 2019 12:54:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2DF0C0495BF;
	Fri, 12 Apr 2019 16:54:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DA7460BEC;
	Fri, 12 Apr 2019 16:54:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Date: Fri, 12 Apr 2019 18:54:10 +0200
Message-Id: <20190412165416.7977-7-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 12 Apr 2019 16:54:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 06/12] hw/devices: Move CBus declarations
 into a new header
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412165410.l2bHnULY1GSxSay1PPNuaCbMBmiSd8lr3NfW56fAgwM@z>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS            |  1 +
 hw/arm/nseries.c       |  1 +
 hw/misc/cbus.c         |  2 +-
 include/hw/devices.h   | 14 --------------
 include/hw/misc/cbus.h | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/misc/cbus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e1e30b071ee..041c939952f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -669,6 +669,7 @@ F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
 F: hw/timer/twl92230.c
 F: include/hw/display/blizzard.h
+F: include/hw/misc/cbus.h
=20
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index ef09b3bf79f..6889f13d699 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -32,6 +32,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/devices.h"
 #include "hw/display/blizzard.h"
+#include "hw/misc/cbus.h"
 #include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
index 25e337ea77a..16ee704bcaa 100644
--- a/hw/misc/cbus.c
+++ b/hw/misc/cbus.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
-#include "hw/devices.h"
+#include "hw/misc/cbus.h"
 #include "sysemu/sysemu.h"
=20
 //#define DEBUG
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 77d66113021..e400f9eac09 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -29,18 +29,4 @@ void tsc2005_set_transform(void *opaque, MouseTransfor=
mInfo *info);
 /* stellaris_input.c */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
=20
-/* cbus.c */
-typedef struct {
-    qemu_irq clk;
-    qemu_irq dat;
-    qemu_irq sel;
-} CBus;
-CBus *cbus_init(qemu_irq dat_out);
-void cbus_attach(CBus *bus, void *slave_opaque);
-
-void *retu_init(qemu_irq irq, int vilma);
-void *tahvo_init(qemu_irq irq, int betty);
-
-void retu_key_event(void *retu, int state);
-
 #endif
diff --git a/include/hw/misc/cbus.h b/include/hw/misc/cbus.h
new file mode 100644
index 00000000000..c899943e035
--- /dev/null
+++ b/include/hw/misc/cbus.h
@@ -0,0 +1,32 @@
+/*
+ * CBUS three-pin bus and the Retu / Betty / Tahvo / Vilma / Avilma /
+ * Hinku / Vinku / Ahne / Pihi chips used in various Nokia platforms.
+ * Based on reverse-engineering of a linux driver.
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Andrzej Zaborowski
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_MISC_CBUS_H
+#define HW_MISC_CBUS_H
+
+#include "hw/irq.h"
+
+typedef struct {
+    qemu_irq clk;
+    qemu_irq dat;
+    qemu_irq sel;
+} CBus;
+
+CBus *cbus_init(qemu_irq dat_out);
+void cbus_attach(CBus *bus, void *slave_opaque);
+
+void *retu_init(qemu_irq irq, int vilma);
+void *tahvo_init(qemu_irq irq, int betty);
+
+void retu_key_event(void *retu, int state);
+
+#endif
--=20
2.20.1


