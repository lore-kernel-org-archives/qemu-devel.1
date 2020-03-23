Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C0C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BF120722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vp+8G5hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BF120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR6i-00014d-BZ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3i-0004Ow-Q5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3g-0003hj-Iq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGR3g-0003f9-6F
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id a9so436315wmj.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5a3auB4qdgqdR6eDWJTA8UcdAj8hCoHOLQiKnN1qJ3s=;
 b=Vp+8G5hjhwcLmg45ndXc1a15tvj3fS3ERCXQleJKSJYnbG8CVmdi4abPiZGkGJrlR6
 0GBodwWFJkiBTcIuiKNj/puiJ7cW+uJ/vVs+cqlGZqjGEkXy1h3PxRNuxCGmgD7e1Yow
 HAGg9MrpvRjEHoJOh7xkDfjmXL0Rd2r351ps9hefRzMRyQ+HoDjEmbs96jBhzCyJKeUq
 7gtgw3yovHq/mHJNeXYQqArpRCs2FxCMnmessaQV59tuERX+9iggVkX/G5FsCaTswGYT
 Mnl1sIJp7v/2Tu/Fw99y8WNCbBqaXiQU7TqeAaY/728OKqJoCma2xEfY5ud3kfKtguLd
 JrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5a3auB4qdgqdR6eDWJTA8UcdAj8hCoHOLQiKnN1qJ3s=;
 b=s7qUbOf4lpWANMGKT1HLilKcFvRmEyuiHDdhjSfnl0sdlKm0AleymnkRWT6Q8AdXMt
 0M0UhtxQlqeeU9frpT96ak4anwBWjsxyJbZzHR2l/sMyAYJ2EPC1C4C4p1+tE2P8KtgN
 AXOsd4/NNIP0JOwxRQ/2ojEpBc8CJwXE1KdqFT6Tn+M5hyzgfLT4AL6Mv8SeCq29uwHZ
 PUL9/tMoBytquZD1xeezHkN4DmGc+qf4JYDbA9ILt/6qWe0NixYbwGBF7sxl/X98pNmQ
 Fe5Bp0H+18+w589OJyPGxE+lLx/CSlTtrfBQEBZqrFiSUroG89nme8jFEx218N0eME8Z
 6REw==
X-Gm-Message-State: ANhLgQ2WnL6mhPm1xy9mJzLh1Jy+OdJfPWqH1dO2S1wQe8bwCXafcoHc
 +jV1WgaV2+YZV9NB6tDUaz1/iqV2mGujQw==
X-Google-Smtp-Source: ADFU+vsGssyD+5BkntBb/TNcIbgdPgxiqmuU/oiKD1RyBdNOU6IQDll7gPt0pXUtZFjGOj1QuTU8CQ==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr440975wmj.170.1584985210885;
 Mon, 23 Mar 2020 10:40:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm25145282wrw.20.2020.03.23.10.40.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 10:40:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] hw/arm/bcm283x: Correct the license text
Date: Mon, 23 Mar 2020 17:40:02 +0000
Message-Id: <20200323174006.8468-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323174006.8468-1-peter.maydell@linaro.org>
References: <20200323174006.8468-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The license is the 'GNU General Public License v2.0 or later',
not 'and':

  This program is free software; you can redistribute it and/ori
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

Fix the license comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200312213455.15854-1-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h | 3 ++-
 include/hw/arm/bcm2836.h             | 3 ++-
 include/hw/char/bcm2835_aux.h        | 3 ++-
 include/hw/display/bcm2835_fb.h      | 3 ++-
 include/hw/dma/bcm2835_dma.h         | 4 +++-
 include/hw/intc/bcm2835_ic.h         | 4 +++-
 include/hw/intc/bcm2836_control.h    | 3 ++-
 include/hw/misc/bcm2835_mbox.h       | 4 +++-
 include/hw/misc/bcm2835_mbox_defs.h  | 4 +++-
 include/hw/misc/bcm2835_property.h   | 4 +++-
 hw/arm/bcm2835_peripherals.c         | 3 ++-
 hw/arm/bcm2836.c                     | 3 ++-
 hw/arm/raspi.c                       | 3 ++-
 hw/display/bcm2835_fb.c              | 1 -
 hw/dma/bcm2835_dma.c                 | 4 +++-
 hw/intc/bcm2835_ic.c                 | 4 ++--
 hw/intc/bcm2836_control.c            | 4 +++-
 hw/misc/bcm2835_mbox.c               | 4 +++-
 hw/misc/bcm2835_property.c           | 4 +++-
 19 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7859281e11b..2e8655a7c2d 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -5,7 +5,8 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_PERIPHERALS_H
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 92a6544816b..024af8aae4f 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -5,7 +5,8 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2836_H
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index cdbf7e3e37e..934acf9c813 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -2,7 +2,8 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_AUX_H
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 228988ba056..2246be74d83 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -5,7 +5,8 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_FB_H
diff --git a/include/hw/dma/bcm2835_dma.h b/include/hw/dma/bcm2835_dma.h
index 91ed8d05d16..a6747842b76 100644
--- a/include/hw/dma/bcm2835_dma.h
+++ b/include/hw/dma/bcm2835_dma.h
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_DMA_H
diff --git a/include/hw/intc/bcm2835_ic.h b/include/hw/intc/bcm2835_ic.h
index fb75fa0064e..392ded1cb33 100644
--- a/include/hw/intc/bcm2835_ic.h
+++ b/include/hw/intc/bcm2835_ic.h
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_IC_H
diff --git a/include/hw/intc/bcm2836_control.h b/include/hw/intc/bcm2836_control.h
index de061b8929a..2c22405686b 100644
--- a/include/hw/intc/bcm2836_control.h
+++ b/include/hw/intc/bcm2836_control.h
@@ -8,7 +8,8 @@
  * ARM Local Timer IRQ Copyright (c) 2019. Zoltán Baldaszti
  * Added basic IRQ_TIMER interrupt support
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2836_CONTROL_H
diff --git a/include/hw/misc/bcm2835_mbox.h b/include/hw/misc/bcm2835_mbox.h
index 7e8f3ce86de..57f95cc35ea 100644
--- a/include/hw/misc/bcm2835_mbox.h
+++ b/include/hw/misc/bcm2835_mbox.h
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_MBOX_H
diff --git a/include/hw/misc/bcm2835_mbox_defs.h b/include/hw/misc/bcm2835_mbox_defs.h
index a18e520b22f..9670bf33a03 100644
--- a/include/hw/misc/bcm2835_mbox_defs.h
+++ b/include/hw/misc/bcm2835_mbox_defs.h
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_MBOX_DEFS_H
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835_property.h
index 11be0dbeac7..b321f224990 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #ifndef BCM2835_PROPERTY_H
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 17207ae07e3..edcaa4916d0 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -5,7 +5,8 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 38e2941baba..43022b83f5f 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -5,7 +5,8 @@
  * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index acd2bb794d1..fe3b9bc78bb 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -8,7 +8,8 @@
  * Raspberry Pi 3 emulation Copyright (c) 2018 Zoltán Baldaszti
  * Upstream code cleanup (c) 2018 Pekka Enberg
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index d6bf3374a67..c6263808a27 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -1,7 +1,6 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
  * Refactoring for Pi2 Copyright (c) 2015, Microsoft. Written by Andrew Baumann.
- * This code is licensed under the GNU GPLv2 and later.
  *
  * Heavily based on milkymist-vgafb.c, copyright terms below:
  *  QEMU model of the Milkymist VGA framebuffer.
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index ccff5ed55b2..4cd9dab745a 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 05bd28e4f9d..53ab8f58810 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -1,7 +1,6 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
  * Refactoring for Pi2 Copyright (c) 2015, Microsoft. Written by Andrew Baumann.
- * This code is licensed under the GNU GPLv2 and later.
  * Heavily based on pl190.c, copyright terms below:
  *
  * Arm PrimeCell PL190 Vector Interrupt Controller
@@ -9,7 +8,8 @@
  * Copyright (c) 2006 CodeSourcery.
  * Written by Paul Brook
  *
- * This code is licensed under the GPL.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 61f884ff9e7..53dba0080ca 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -4,7 +4,6 @@
  * Written by Andrew Baumann
  *
  * Based on bcm2835_ic.c (Raspberry Pi emulation) (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
  *
  * At present, only implements interrupt routing, and mailboxes (i.e.,
  * not PMU interrupt, or AXI counters).
@@ -13,6 +12,9 @@
  *
  * Ref:
  * https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 77d2d80706c..2afa06a7464 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -1,11 +1,13 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
  *
  * This file models the system mailboxes, which are used for
  * communication with low-bandwidth GPU peripherals. Refs:
  *   https://github.com/raspberrypi/firmware/wiki/Mailboxes
  *   https://github.com/raspberrypi/firmware/wiki/Accessing-mailboxes
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index df91280dfcc..3e228ca0ae4 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -1,6 +1,8 @@
 /*
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
- * This code is licensed under the GNU GPLv2 and later.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  */
 
 #include "qemu/osdep.h"
-- 
2.20.1


