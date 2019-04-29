Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98967C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FF22075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWFRK2G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FF22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA40-00020I-L9
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:27:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ew-0004yJ-96
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0006o5-Bi
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9er-0006f8-Nv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id s18so17188172wrp.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=e6cX6fnSzBtaurvS4e29cr5VA7TdSpTfD1NyQiLf/7M=;
	b=rWFRK2G/5uqhuxn77SyShKkdIykaLClZYB5eDyJRo/DtXcL3p63cVBaUjEtPlOJssB
	AI/udNnicsi3zQ8HEjRNFpHMSiurroOOK6D341CNeQkCpqqKfpwAMiPFRITuTEdRi/BG
	GXnIVIdg+UTzLcB/3Kkc2az+bFHae42R0QLMMajXeeTKzfS8gZNqusnUEZxK8RZM0aoh
	1nDG5cKBr9d8MAySOFCA4GR4PemiJxW0/Urxbecrrvgh3E22gRYI7BE0Z8vjBRkINJqc
	zwPZVR8QEPHrV7GImtKGsID1TcwHSJdgNGNXhBPiH6v1vcWW+51d3vv4eXhMm8GdCrH2
	Purw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=e6cX6fnSzBtaurvS4e29cr5VA7TdSpTfD1NyQiLf/7M=;
	b=k4u5VqgEXBDxHvvHNs8YbMlbm2tQ5PULcpnr86TzorcqYHZ88ymwNR5+oa8i33Xv8x
	s6DghFecTRIqs4Qc38/w5E2YcPCw01w7fQeEAMkwQE5XtYz2E8uSIVUENoDmdy8UdESv
	MSoML50FwkpCUWCBc3Nw1ziXNCT1Y1RBDhrxaGnkslMrt1fRyE33gP5t2LXa2pp+Lb1g
	MPSBQFDdOmMjsoQxF+HriI6qcRmlhBxX0BEvy4mGTn7mCho+XILEgLsA6qFnCD7UkZwP
	caSBImm5+uktA7fi2/BHJUYCDp/Zq/0dzCfMXC37UZSlbkCz+1UIzSeYqWrchRpbF+fx
	/HLA==
X-Gm-Message-State: APjAAAXASLJSsYiJpPkzM5YeAXbwhmpyExzt+qzOdJ9xtXfNkPJw/AaH
	r8sK+jC8ZteVKalkEMqQh9rude73e5Y=
X-Google-Smtp-Source: APXvYqy3A+j6hv+NMPBgBlIkqLPHVs0vBgJ1HMhmhmezZbUWhp+BHUipJovEgWJns4dq4a3Pfy77VA==
X-Received: by 2002:a5d:4e86:: with SMTP id e6mr4845305wru.59.1556557282488;
	Mon, 29 Apr 2019 10:01:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:27 +0100
Message-Id: <20190429170030.11323-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 39/42] hw/devices: Move LAN9118 declarations
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
Message-ID: <20190429170027.lR5G-mPtqwlANo8HtCzBXEJFRop00LULpJdHxCzQQ58@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-10-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h     |  3 ---
 include/hw/net/lan9118.h | 19 +++++++++++++++++++
 hw/arm/kzm.c             |  2 +-
 hw/arm/mps2.c            |  2 +-
 hw/arm/realview.c        |  1 +
 hw/arm/vexpress.c        |  2 +-
 hw/net/lan9118.c         |  2 +-
 7 files changed, 24 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/net/lan9118.h

diff --git a/include/hw/devices.h b/include/hw/devices.h
index ba9034050b4..ebc45c87997 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -8,7 +8,4 @@
 /* smc91c111.c */
 void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
 
-/* lan9118.c */
-void lan9118_init(NICInfo *, uint32_t, qemu_irq);
-
 #endif
diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
new file mode 100644
index 00000000000..d13d8cd3d22
--- /dev/null
+++ b/include/hw/net/lan9118.h
@@ -0,0 +1,19 @@
+/*
+ * SMSC LAN9118 Ethernet interface emulation
+ *
+ * Copyright (c) 2009 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_NET_LAN9118_H
+#define HW_NET_LAN9118_H
+
+#include "hw/irq.h"
+#include "net/net.h"
+
+void lan9118_init(NICInfo *, uint32_t, qemu_irq);
+
+#endif
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 864c7bd4114..139934c4ecf 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "net/net.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "hw/char/serial.h"
 #include "sysemu/qtest.h"
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e3d698ba6c4..54b7395849f 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -36,7 +36,7 @@
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "net/net.h"
 
 typedef enum MPS2FPGAType {
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 242f5a87b6a..e9983c87639 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -15,6 +15,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
 #include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f07134c4245..d8634f3dd29 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a6269d9463b..a428b16eda5 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -14,7 +14,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
-- 
2.20.1


