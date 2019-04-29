Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA23BC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835E22075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtvtmgie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835E22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAAD-0007zo-Ln
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:34:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f8-00058q-N4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f3-0006tm-AV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9ey-0006dc-Ti
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id w15so171782wmc.3
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=jYLkzbonDQxvT0W1x+t6S0N7WJMb4KWntTYWFTkmg9A=;
	b=vtvtmgie/WKEoEh9zohH3M1WJtRSslNEQfddcFe/DZQBiPl0MjWMzTtd7LTqdrHH4N
	AVDguiC1R/VAG8zu4HAfiIetQKUbhEq09VruaB4tDiY6LW02WPYx7M9MnGU8nyycWNI5
	9MWsPFK6AwiLHHBoFHGqf1rn4gicUWT8hb9hxXzT5mw+i5ZtmRPWGYgJo6n6rzDqycgg
	NJbQyrRO8U6nQw6xxf0Xi4JfcpJuNk+CandALJuMIn92Lrk2CYtQtEoahI52IaPYpwxz
	qV98MpcZ+Kq0seyPBNjIkW7IzUVtiiJ/D39YuJyTltjYUjo9JUo3TvLSPFrZ0A8q71rs
	OLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jYLkzbonDQxvT0W1x+t6S0N7WJMb4KWntTYWFTkmg9A=;
	b=paLQQmH4PqUIPzTnJow1aeMtzEfPQjLi8vLjCUhlF9UN7Wc8oVCJTFym0Qk9HryAUK
	JurG5YuTP5Nhm0ORjUMnhJI/cPFCHdeYIUxK8RIBbb851AeCCUXmIuCx1Dw55zjavosc
	IvKw78FyJBSydeKU6zg2v5aAQa28UzPyHRm3+GG78HWh1z1O1UYLSR4Ob2T9DFwzVugh
	px3ObTVnwJGMpifnMXCbfhBbzITB5cCJ/6esxoL6OnNMDXViv31DlbxkdfEY3tEypM/q
	vl/FJYT1VDe8O2UP+Jv37fv3JZkwgZ5TVxGnpkPFK8wZmtn8A/9IWo4T6FFKowZuim8i
	Qw8g==
X-Gm-Message-State: APjAAAU/CAS6VhOHi8nC2q1nV0s80qeeRYqgvmhLrBn/J1MNcoHVPYWG
	lN/fnWzVtyYTvOkadg+5K/iXAxdfmF4=
X-Google-Smtp-Source: APXvYqx4KeJ0G3vNf7WmT96KuYW1bShvXGO0PoDIFVByFHDeo+dvoiKGygUSQBg3BO+REJcaqxpi4g==
X-Received: by 2002:a1c:2350:: with SMTP id j77mr53988wmj.84.1556557278763;
	Mon, 29 Apr 2019 10:01:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:24 +0100
Message-Id: <20190429170030.11323-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 36/42] hw/devices: Move CBus declarations into a
 new header
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
Message-ID: <20190429170024.qigywsJCKoApCL7IItW3n9UJ-XeQXH63FU9ouv2sGjY@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-7-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h   | 14 --------------
 include/hw/misc/cbus.h | 32 ++++++++++++++++++++++++++++++++
 hw/arm/nseries.c       |  1 +
 hw/misc/cbus.c         |  2 +-
 MAINTAINERS            |  1 +
 5 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/misc/cbus.h

diff --git a/include/hw/devices.h b/include/hw/devices.h
index 77d66113021..e400f9eac09 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -29,18 +29,4 @@ void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
 /* stellaris_input.c */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
 
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
 
 //#define DEBUG
diff --git a/MAINTAINERS b/MAINTAINERS
index c069c274ec0..4e6fd82c664 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -669,6 +669,7 @@ F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
 F: hw/timer/twl92230.c
 F: include/hw/display/blizzard.h
+F: include/hw/misc/cbus.h
 
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
-- 
2.20.1


