Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B4EC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CC32075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CC32075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXo7-0006Tc-Sy
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjd-0000kv-Np
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjb-0001DG-A0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:29 -0400
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:34532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jRXja-0001Bg-2N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:26 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:89cc:efc7:85ce:4669])
 by andre.telenet-ops.be with bizsmtp
 id W91L2200i1RvcFS0191LLp; Thu, 23 Apr 2020 11:01:21 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0006kB-Al; Thu, 23 Apr 2020 11:01:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0002vU-8q; Thu, 23 Apr 2020 11:01:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartekgola@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH QEMU v2 1/5] ARM: PL061: Move TYPE_PL061 to hw/gpio/pl061.h
Date: Thu, 23 Apr 2020 11:01:14 +0200
Message-Id: <20200423090118.11199-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
References: <20200423090118.11199-1-geert+renesas@glider.be>
Received-SPF: none client-ip=2a02:1800:120:4::f00:15;
 envelope-from=geert@linux-m68k.org; helo=andre.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:1800:120:4::f00:15
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
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the definition of TYPE_PL061 to a new header file, so it can be
used outside the driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 MAINTAINERS             |  1 +
 hw/gpio/pl061.c         |  2 +-
 include/hw/gpio/pl061.h | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/gpio/pl061.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2bfcec86..e760f65270d29d5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -538,6 +538,7 @@ F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
 F: hw/gpio/pl061.c
+F: include/hw/gpio/pl061.h
 F: hw/input/pl050.c
 F: hw/intc/pl190.c
 F: hw/sd/pl181.c
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 2a828260bdb0b946..e776c09e474216ef 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/gpio/pl061.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -33,7 +34,6 @@ static const uint8_t pl061_id[12] =
 static const uint8_t pl061_id_luminary[12] =
   { 0x00, 0x00, 0x00, 0x00, 0x61, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1 };
 
-#define TYPE_PL061 "pl061"
 #define PL061(obj) OBJECT_CHECK(PL061State, (obj), TYPE_PL061)
 
 typedef struct PL061State {
diff --git a/include/hw/gpio/pl061.h b/include/hw/gpio/pl061.h
new file mode 100644
index 0000000000000000..78cc40c52679dc4e
--- /dev/null
+++ b/include/hw/gpio/pl061.h
@@ -0,0 +1,16 @@
+/*
+ * Arm PrimeCell PL061 General Purpose IO with additional Luminary Micro
+ * Stellaris bits.
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GPL.
+ */
+
+#ifndef PL061_GPIO_H
+#define PL061_GPIO_H
+
+#define TYPE_PL061 "pl061"
+
+#endif /* PL061_GPIO_H */
-- 
2.17.1


