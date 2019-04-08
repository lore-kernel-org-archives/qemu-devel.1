Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB96FC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751B520879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ow/Sk3Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751B520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54319 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVjt-0007wk-K5
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:59:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDViI-0006sO-4e
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDViG-0006dl-SH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:57:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:38971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sohailalvi2236@gmail.com>)
	id 1hDViG-0006d3-J9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:57:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id i17so4647289pfo.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=5xqxa0Eoqy5Fldc4bDwFq7A3NFTmsytIqN47XYjPmn4=;
	b=ow/Sk3Q/c/9c83yBI1YU+FraqwqvAOgHLHeWzpse3kGFNCcxlmE9CtLHaIiUEIoxTg
	VuBz1JmMKiTZ8qcl7ar4MyAIg3QD0NbOJfRteImcCFrmAWO6HuMxYQwYOiWf+TV7ZxHJ
	7KlMOr0+xTaXGjV8CWAHkLkdZtkAVSka8N9YmZX0bICDTBjeCUagRVHNV+Q2vKLqOo2H
	D9H2N18SwHoL71AYN8x141QIwNkNc1W5Ow6BIBkoOtNgZDwUEdJgSlXod6qnTkG7kBTg
	rGa+HcjDvyKK+q66lW23shnymefnEMoDI4GFObhcaHNiq4AYn4ss7BgGD8pPOmaOSP/Z
	uxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=5xqxa0Eoqy5Fldc4bDwFq7A3NFTmsytIqN47XYjPmn4=;
	b=p6Au1A31PLsNut1i8gYGKy4s0OqNkCmcd3vmNquM1cZefUnNYbxTRkPEZ2enBTg1pW
	tVOAPD0lyXRMuQTvpOmhMpRaOeVe8O5ReYg7BrCAArUT4x/cQxOCv/K3705NLF5GqAH8
	5JfrVC9MvUB3h6fXDl2gxACJiWZjlBrVudKON+Sj16FjCfKh+Oqb8pujhsiLmo3/JLo9
	6Ceu5MQzh80Cdk7sw68x8I8FG+0zp5PMVG8pPdoEW1Z00XdX/Mo1Th5ywb5biqu12iiQ
	ASQPRofZ/vaIFurC38cOSvbTbyGJhNvcguP7Gxac4j2WpMa/SFFenFfEyxt1MbZlp8Fx
	q03Q==
X-Gm-Message-State: APjAAAWcbgpM1v6x6UKcM4S21iP0Xi1UdHCvobkGd7VnCvznSh5zniBU
	rFQ9R1eET7+eeM26OFxE6VZsxDZVbo+tkg==
X-Google-Smtp-Source: APXvYqywBauzvXr7ieYGiKDJ+JXAMYHNTuVDrTmcWnztWEBu+vOCD0cFjOO2LYuo2YvxhjULebPhlg==
X-Received: by 2002:a63:2208:: with SMTP id i8mr28376180pgi.223.1554735451191; 
	Mon, 08 Apr 2019 07:57:31 -0700 (PDT)
Received: from localhost.localdomain ([157.50.37.23])
	by smtp.gmail.com with ESMTPSA id
	f63sm47768647pfc.180.2019.04.08.07.57.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 07:57:30 -0700 (PDT)
From: sohailalvi2236@gmail.com
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 20:27:21 +0530
Message-Id: <20190408145721.15881-1-sohailalvi2236@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] [PATCH] qemu_system_reset_request() in hw/
 corresponding to watchdog that has triggered replaced by
 watchdog_perform_action().
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
Cc: Sohail Alvi <sohailalvi2236@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408145721.p-cygR7AsKRNqhFRZuc7hFijZoCGMFQs6ZRDZdlqIzg@z>

From: Sohail Alvi <sohailalvi2236@gmail.com>

---
 hw/arm/musicpal.c        | 3 ++-
 hw/ppc/ppc.c             | 3 ++-
 hw/s390x/ipl.c           | 3 ++-
 hw/timer/etraxfs_timer.c | 3 ++-
 hw/timer/m48t59.c        | 3 ++-
 hw/timer/pxa2xx_timer.c  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 93ec3c5698..84593e61cc 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -28,6 +28,7 @@
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "ui/pixel_ops.h"
+#include "sysemu/watchdog.h"
 
 #define MP_MISC_BASE            0x80002000
 #define MP_MISC_SIZE            0x00001000
@@ -898,7 +899,7 @@ static void mv88w8618_pit_write(void *opaque, hwaddr offset,
 
     case MP_BOARD_RESET:
         if (value == MP_BOARD_RESET_MAGIC) {
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            watchdog_perform_action();
         }
         break;
     }
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ad20584f26..636d2046f8 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "trace.h"
+#include "sysemu/watchdog.h"
 
 //#define PPC_DEBUG_IRQ
 //#define PPC_DEBUG_TB
@@ -380,7 +381,7 @@ void ppc40x_chip_reset(PowerPCCPU *cpu)
 void ppc40x_system_reset(PowerPCCPU *cpu)
 {
     qemu_log_mask(CPU_LOG_RESET, "Reset PowerPC system\n");
-    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    watchdog_perform_action();
 }
 
 void store_40x_dbcr0(CPUPPCState *env, uint32_t val)
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 51b272e190..4783b41c57 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -27,6 +27,7 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "exec/exec-all.h"
+#include "sysemu/watchdog.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -547,7 +548,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
         /* ignore -no-reboot, send no event  */
         qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
     } else {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
     }
     /* as this is triggered by a CPU, make sure to exit the loop */
     if (tcg_enabled()) {
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2280914b1d..9561113d0e 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "sysemu/watchdog.h"
 
 #define D(x)
 
@@ -207,7 +208,7 @@ static void watchdog_hit(void *opaque)
         qemu_irq_raise(t->nmi);
     }
     else
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
 
     t->wd_hits++;
 }
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index ca3ed445de..ebe58e8dc7 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
+#include "sysemu/watchdog.h"
 
 #include "m48t59-internal.h"
 
@@ -158,7 +159,7 @@ static void watchdog_cb (void *opaque)
 	NVRAM->buffer[0x1FF7] = 0x00;
 	NVRAM->buffer[0x1FFC] &= ~0x40;
         /* May it be a hw CPU Reset instead ? */
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
     } else {
 	qemu_set_irq(NVRAM->IRQ, 1);
 	qemu_set_irq(NVRAM->IRQ, 0);
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index a489bf5159..2be680b5df 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -14,6 +14,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "sysemu/watchdog.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
@@ -414,7 +415,7 @@ static void pxa2xx_timer_tick(void *opaque)
     if (t->num == 3)
         if (i->reset3 & 1) {
             i->reset3 = 0;
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            watchdog_perform_action();
         }
 }
 
-- 
2.17.1


