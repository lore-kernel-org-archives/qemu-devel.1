Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A50C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CE92075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErCXmxJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CE92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32805 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA73-0005Fk-KY
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:30:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ew-0004yI-8s
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0006ng-8i
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9er-0006gT-Mq
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id v16so14714668wrp.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2DwQZ6cqfQHoMxgvU29bcGwE5/erOlHteqQaEyRX6QU=;
	b=ErCXmxJdDSYZsngtvofqo6MYNMXE7g550w26jOzcmleRnx1HuWCwPjuqGLb+ayxrt0
	hXH6j6vTzBTp7EHFXy8NxjVtMKK0OMcdO/QEHKg90LtFIlbto1z+M49ejzHuMM8Giq+W
	p1EUd4p0wLQIUEN46EPIPY+2h1oMRIZV7hJmXm8XLIPKFXwD0e8GZLt9q9oDKVEEXgQo
	UquvZVWk86oTmgwc7zODgspJCR5cK17W9kVUC2W7aqGygGLB/LLBlmwlOmbeXmYf8fE0
	SyCf79QSrrupeoTo7MPVxYbwZCln3lhwu1sU1bIZ0dnMHX/q8jnfpllIKw0xeZ0DhSLM
	NjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2DwQZ6cqfQHoMxgvU29bcGwE5/erOlHteqQaEyRX6QU=;
	b=GmOpc5rcVHaB2/GQ+ZHeiBJT9ICC/TrthFOis80pARaOyFJnlgz161DGR1SpD2UCca
	FZPj1FLSjnB7YeLQVCfNbl+v9CHzUtl+jrbyGuPkiWRnYHEXbDABwNMtrj8wDMmgoIsM
	PqXiSn4vgLPeAXgr2ciDZOmCAwF/Wicmh71CzLlH1JTS22U0d9HmKye4afZvk8otKBox
	97F0oALaMJqFTh0j7FhBB8joVWgLzFB0xNlOjsuN3Nie0EUdxj8L8BZIyCI0qC4t/WfH
	aZg2X/l3hJgKNJBclGOl5qAFMI9XzG3xAWjObmWHpbeiLJNZl2dgIbSPL1kCXDG3iuVD
	TtdA==
X-Gm-Message-State: APjAAAWPD+IVlTI3mu1EUUcS6SL6D+lAtebtM6UCTBh/Mp24YktjFlbb
	3mWtMzHhyff1RhzbChykLRC79Qu5hiE=
X-Google-Smtp-Source: APXvYqxENjmB3uQfGWAFKMrDGdSFJH1Xp3BX+QWfwYBKMC0UWBoZi/94Y4ce2ai50uFqk6WIqzdIfA==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr15337695wrs.5.1556557286401; 
	Mon, 29 Apr 2019 10:01:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:30 +0100
Message-Id: <20190429170030.11323-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 42/42] hw/devices: Move SMSC 91C111 declaration
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
Message-ID: <20190429170030.a3aMpHAXE2kZ8R82YAONmtZVu9dCtlmA7nUyhlHg69A@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit finally deletes "hw/devices.h".

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-13-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h       | 11 -----------
 include/hw/net/smc91c111.h | 19 +++++++++++++++++++
 hw/arm/gumstix.c           |  2 +-
 hw/arm/integratorcp.c      |  2 +-
 hw/arm/mainstone.c         |  2 +-
 hw/arm/realview.c          |  2 +-
 hw/arm/versatilepb.c       |  2 +-
 hw/net/smc91c111.c         |  2 +-
 8 files changed, 25 insertions(+), 17 deletions(-)
 delete mode 100644 include/hw/devices.h
 create mode 100644 include/hw/net/smc91c111.h

diff --git a/include/hw/devices.h b/include/hw/devices.h
deleted file mode 100644
index ebc45c87997..00000000000
--- a/include/hw/devices.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef QEMU_DEVICES_H
-#define QEMU_DEVICES_H
-
-/* Devices that have nowhere better to go.  */
-
-#include "hw/hw.h"
-
-/* smc91c111.c */
-void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
-
-#endif
diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
new file mode 100644
index 00000000000..a66ba4112f8
--- /dev/null
+++ b/include/hw/net/smc91c111.h
@@ -0,0 +1,19 @@
+/*
+ * SMSC 91C111 Ethernet interface emulation
+ *
+ * Copyright (c) 2005 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_NET_SMC91C111_H
+#define HW_NET_SMC91C111_H
+
+#include "hw/irq.h"
+#include "net/net.h"
+
+void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
+
+#endif
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 79886ce3787..343cbfd7da8 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -40,7 +40,7 @@
 #include "hw/arm/pxa.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 4eceebb9ea7..0b6f24465e4 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -12,10 +12,10 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "hw/misc/arm_integrator_debug.h"
+#include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index e96738ad267..c1cec590379 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -18,7 +18,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/arm/arm.h"
 #include "net/net.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "hw/boards.h"
 #include "hw/block/flash.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index e9983c87639..05a244df255 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -14,8 +14,8 @@
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
-#include "hw/devices.h"
 #include "hw/net/lan9118.h"
+#include "hw/net/smc91c111.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d67181810a6..25166e15171 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -13,7 +13,7 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 99da2d92973..d19ea0750d3 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "qemu/log.h"
 /* For crc32 */
 #include <zlib.h>
-- 
2.20.1


