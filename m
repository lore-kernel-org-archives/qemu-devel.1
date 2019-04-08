Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEDC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22842148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmonOzZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22842148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVxJ-00006X-5o
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:13:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDVr4-0004Nd-AS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDVr3-0006du-7I
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:06:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sohailalvi2236@gmail.com>)
	id 1hDVr1-0006aR-CZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:06:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id 85so7492533pgc.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=t3MMun1BLhqIl8wkTU3nOq12qX+bujfqL3LT4yJBdfY=;
	b=DmonOzZoiMo62R53unBX3bk5Y2hl8mQAOjsKODdMXMVHjLnchijgOoFMw14UAeqz3c
	qoiJvXOHUePtcL9LYl5AXdKjDF/KmANZO+idG8KJslF7TXrTmDW/TJxYkCupS6bIs8yT
	isIa0+ccTscJKpYcH9OgWPnuoQKRqAxW8KWxJ3f+Z+tqNsunyeBuxEFAoUt98CALHhHt
	25GEA+Nb4FBIRjWPmAC9choA/OniQdKfnKOMCuNmiWw3c/tqTiWI+EGWMAUwjm+abLtE
	OmX6m4G874c+immlwiE6mFWvgqzUKA8oBuiMl+ds6OgFTjxXwAjBklEjUqWHMyr6+Gpa
	3X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=t3MMun1BLhqIl8wkTU3nOq12qX+bujfqL3LT4yJBdfY=;
	b=UADY8jdxuZhrljt/6pjTIpirmWu9oLwkdJl8KQjfo03r9Q9mBCG1pribp1MRxspL7m
	gYKtT0WPAc72KqLHCKZ5qUbV7XJyqp+NkJsc6ecVGFWmo6EGLY6IdVMrnEM36nrKMNNQ
	W4iPw5uHxe4PURwLgVgayqAZgoGDoL057i9b4KEVAh98jdHJX5No9OhcT1KDZ17hv2e6
	fXEz6NhFFvbFREwGDBLsfuy86V3DVpEbCfqQjxso0TX2lzcnMqE7QcpZ8AQ88xF8ZK/3
	JlrndcnE/c2mrEE4KVD4YuYqN8RS4TgjA/sq+PLhPe7OL2c71+4Fn0cbqtJuGSMebnGS
	f+1g==
X-Gm-Message-State: APjAAAWmWanGLy3hk254Jjuox3ScNdtUEWLHX/G0ZIamJ3yzXqWhplfU
	+2SmaMSxO/SKx9xR44Q3EnQe2kk8EptlRA==
X-Google-Smtp-Source: APXvYqw1Fhj89Cvr39d3LXrDmoEyRlmXfAoywIn0GM/l6K+yEg76qpDWRAc261UV0VlZVnz6ggLXOw==
X-Received: by 2002:a65:5383:: with SMTP id x3mr11472824pgq.60.1554735993174; 
	Mon, 08 Apr 2019 08:06:33 -0700 (PDT)
Received: from localhost.localdomain ([157.50.37.23])
	by smtp.gmail.com with ESMTPSA id
	v1sm46676901pff.81.2019.04.08.08.06.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 08:06:32 -0700 (PDT)
From: sohailalvi2236@gmail.com
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 20:36:25 +0530
Message-Id: <20190408150625.16280-1-sohailalvi2236@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [Resend  PATCH 2/5] Device models
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
Message-ID: <20190408150625.l2hE93Uc8tij7sXlrWjdf1Jw8qHKQksskA0B1ZAspuQ@z>

From: Sohail Alvi <sohailalvi2236@gmail.com>

Signed-off-by: SohailAlvi <sohailalvi2236@gmail.com>

 qemu_system_reset_request() in hw/ corresponding to watchdog
 that has triggered replaced by watchdog_perform_action().

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


