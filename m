Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B553C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC532075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2pam2AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC532075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA8u-0006rv-10
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:32:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f0-00051m-MS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ew-0006q4-8L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eu-0006e7-38
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id r6so17129580wrm.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=g5HKQFfTMD1ezkdR00l6pHrV/C/KHIBl0/6EieG5feg=;
	b=E2pam2AFxd1hSrxjVPjVoKpwarLSKlo1Gvi11W7XKTSwmD7s0KcC+T/+b+IBlXhfxY
	c8COn+TxJg8xSQYSOjvSHb3HTvIWo248CutcEqL37D/4C1ulVyilXyGM9Ia4MIl672QF
	JzH3Skh7mXBRJyC+6Q+Luuf4372GKssmedq0Xj+Vgj8ukDNMee5U9bbJX13rbDM/EMal
	6IjoDItsO8KMmCnTkzl+ejvn53TFR/ILtqFwTBwayL6jYw0mb6az9/t0Aj/NQAtY5mym
	iWSPEMMDP3JUjSbkb0+teKkrWvM8YY9C+gBZclF9E3oPs4zvr+6WitWyr4Rl+3Blw4Lr
	SjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=g5HKQFfTMD1ezkdR00l6pHrV/C/KHIBl0/6EieG5feg=;
	b=pdxxsvgaXwZIHaZu/UhKimT0++GBt1VAX4TtvEW6O0Sw9Z/Q+3lw425klF3TnynpmD
	XRqF5upRc64ZZTBqpZhu0MhoI67OTqFgVQlDIEqeXW4ZBxhvaYN7fAWamT1MQfHR6El2
	vqbowN5BfYpfzRJ1e94KPCij+0Va61NFGKmcAzpwyd8uz9s6rmiykdj8DfSRfQDeBhNk
	9KDoQuxC2MUCN4HJyKO6zCM69cfzGNxZvWNr2yu1jRnrA+FtXzTsJeBqgRUXtq6MsnNa
	mZXTCALez8Xr8Y5BLO3mRLza4KWH9sJcYpSuhrra+vW0iUqD3U4b/eR0Ei2NgZVyjafi
	37Mw==
X-Gm-Message-State: APjAAAWgLWWNg0TscLMNqagmJXyHGKhqnf2HJG73nBT18OZYbyn+gMN9
	C6coFcWuRuoHZbOymMPWkj5PtCCLTII=
X-Google-Smtp-Source: APXvYqz1rG3qPDf0m3OrxjhLvdYK3/uCSSBkLTB/Pg4O/nMgTYLZKB4rz0OlQda4rEJj+thKCzDqnw==
X-Received: by 2002:a5d:4308:: with SMTP id h8mr30659199wrq.22.1556557280138; 
	Mon, 29 Apr 2019 10:01:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:25 +0100
Message-Id: <20190429170030.11323-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 37/42] hw/devices: Move Gamepad declarations
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170025.dE_vZuGtztCPWq6eIM9qr-oE5fP7YGFweh0eFoREEQA@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-8-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h       |  3 ---
 include/hw/input/gamepad.h | 19 +++++++++++++++++++
 hw/arm/stellaris.c         |  2 +-
 hw/input/stellaris_input.c |  2 +-
 MAINTAINERS                |  1 +
 5 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/input/gamepad.h

diff --git a/include/hw/devices.h b/include/hw/devices.h
index e400f9eac09..7a630da47f7 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -26,7 +26,4 @@ void *tsc2005_init(qemu_irq pintdav);
 uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
 void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
 
-/* stellaris_input.c */
-void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
-
 #endif
diff --git a/include/hw/input/gamepad.h b/include/hw/input/gamepad.h
new file mode 100644
index 00000000000..e20211baef8
--- /dev/null
+++ b/include/hw/input/gamepad.h
@@ -0,0 +1,19 @@
+/*
+ * Gamepad style buttons connected to IRQ/GPIO lines
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_INPUT_GAMEPAD_H
+#define HW_INPUT_GAMEPAD_H
+
+#include "hw/irq.h"
+
+/* stellaris_input.c */
+void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
+
+#endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 05f86749f40..5059aedbaa2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -12,7 +12,6 @@
 #include "hw/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
@@ -22,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
+#include "hw/input/gamepad.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/misc/unimp.h"
 #include "cpu.h"
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 99168bfeef1..20c87d86f40 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -8,7 +8,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
+#include "hw/input/gamepad.h"
 #include "ui/console.h"
 
 typedef struct {
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e6fd82c664..39a3216e1c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -744,6 +744,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/stellaris*
+F: include/hw/input/gamepad.h
 
 Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


