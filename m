Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19788C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33D320675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCCTAaRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33D320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9pj-0005tP-UU
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:12:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r4-3J
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kA-1z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9em-0006cV-Rc
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id c5so17086369wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2w1w44sHa+uGj5LPkXGrx5V7+QcLrNYXNtLTn7rWBUg=;
	b=wCCTAaRBwxllhOkltURIAQRY0ESCgvD21au8gnkNMCuvo31ypW1FimSakFu2zamD2L
	+aKQzv0VTGsc5bMhiw49Da2hXLGYmdN+EmApeEKuzI93YBkx/26X96mPRLtHRvkooKMZ
	OrlDEpyuY2zHp7ErM7buNpARisgPzMZjOTfYVYE9RRU/n8rxQgL6tLf8Ku8vYxrszapL
	ffg7heLgc3wHUUy2cRNimMeaMcf0c9WKdP09L92rFQ3XH9SyLjBrkPKeyaIAP1ApHpdu
	Gh8VON4DqfN+zy6tCxEBiR1CbJqWVcz5O/2vRS8Jwwj51Fp5kTdz42iV+YFHa+EKBCE/
	Fr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2w1w44sHa+uGj5LPkXGrx5V7+QcLrNYXNtLTn7rWBUg=;
	b=Xu8EVohGvxwNKCEgqVvOB1lXV8/qiwmn7TaUey4HYv9HtsQt1sYK0gvb6YNGL3O9zq
	fNyT6DV54XvOdGHxWLVKqZE46unmmLCrV3nIQxIY0sTZtOnNYZ7NeLrSrdV5oAjGFqRB
	SXqD57g16iurQ9SXmtx8KluSjji3ytvwjOHh2oWC1gi2kKo/HoPWNd+o5ijAXRptIXqM
	QkNxxMdJnKwd/Xk6k5npCHe8TXReqPa76zJ5gUFlbet3UIzNlUYizR6AY9jZNjzPy1Ev
	a0qLstVbuUxFwKEsC4IZyop2kOzKl0A6r5UCuXpxpOw389yLRdrR3Mg8Qikacl05WAAS
	Q9SQ==
X-Gm-Message-State: APjAAAUYnWiOPbHZDW2H5jC7mOITDM2Ccu/wSioJWZUB81u7KcLPg8xt
	CEg4ZnWfUl3Bkqyh67oXQ+IOSyWzuoE=
X-Google-Smtp-Source: APXvYqwqq17zDjXVIiweWdAykw64lKdyLDPBcM2IFqR/Lt6u3w45UIZxynbJZgHvBOu05oyNiPvYmA==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr5832383wrw.104.1556557276407; 
	Mon, 29 Apr 2019 10:01:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:22 +0100
Message-Id: <20190429170030.11323-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 34/42] hw/devices: Move TC6393XB declarations
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
Message-ID: <20190429170022.grKyAtV7D37xgKQMkrGWq8fE6CJfFhX7oKNcMDRlq_c@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h          |  6 ------
 include/hw/display/tc6393xb.h | 24 ++++++++++++++++++++++++
 hw/arm/tosa.c                 |  2 +-
 hw/display/tc6393xb.c         |  2 +-
 MAINTAINERS                   |  1 +
 5 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/display/tc6393xb.h

diff --git a/include/hw/devices.h b/include/hw/devices.h
index 0850f697451..1e2141caad1 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -50,10 +50,4 @@ void *tahvo_init(qemu_irq irq, int betty);
 
 void retu_key_event(void *retu, int state);
 
-/* tc6393xb.c */
-typedef struct TC6393xbState TC6393xbState;
-TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
-                             uint32_t base, qemu_irq irq);
-qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
-
 #endif
diff --git a/include/hw/display/tc6393xb.h b/include/hw/display/tc6393xb.h
new file mode 100644
index 00000000000..5c4da91f80d
--- /dev/null
+++ b/include/hw/display/tc6393xb.h
@@ -0,0 +1,24 @@
+/*
+ * Toshiba TC6393XB I/O Controller.
+ * Found in Sharp Zaurus SL-6000 (tosa) or some
+ * Toshiba e-Series PDAs.
+ *
+ * Copyright (c) 2007 Hervé Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_DISPLAY_TC6393XB_H
+#define HW_DISPLAY_TC6393XB_H
+
+#include "exec/memory.h"
+#include "hw/irq.h"
+
+typedef struct TC6393xbState TC6393xbState;
+
+TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
+                             uint32_t base, qemu_irq irq);
+qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
+
+#endif
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index eef9d427e76..9a1247797fe 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -16,10 +16,10 @@
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/pcmcia.h"
 #include "hw/boards.h"
+#include "hw/display/tc6393xb.h"
 #include "hw/i2c/i2c.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 6d133d9a66c..0b7c59cde7d 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
+#include "hw/display/tc6393xb.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index dabbfccf9c5..51eecd0ac19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -714,6 +714,7 @@ F: hw/misc/mst_fpga.c
 F: hw/misc/max111x.c
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
+F: include/hw/display/tc6393xb.h
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


