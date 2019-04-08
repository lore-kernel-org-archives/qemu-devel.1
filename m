Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC88FC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE972084F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpNgJvIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE972084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDawv-0007g3-2O
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 16:33:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDaiH-0003PP-M3
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDaiG-0005yK-Np
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:17:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sohailalvi2236@gmail.com>)
	id 1hDaiF-0005w5-S2
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:17:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id k3so7929140pga.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QQNA4o7ceLLF/Nd3pgEBJN3EQU1Swd1DbQdYCUhQMsc=;
	b=SpNgJvIj2qYl0wb/wPfXg7WvMFxZe2wjnb6imE90hgLMS6fF2J1m4J2L3k2VhRT0vC
	qG57TqokoZzNsGl7OITHt4gd4Y38uZf8O3MDvsqOvxoQtCDMbXksgYJjYL6udkdW4NE/
	yvMF9oV50mEpGwHTPdyGMCQQXGv0FeT9SyePakHomz50CzbXRB8Hu/5+AVdGOjRG2j9S
	np+tBhpvYFuWUxGU69Lc6XjIXvB/eZ8ZpavBoRVSyI4FdsYbskbZmrcxbqikSR8noFYO
	pikt57ibgQAddA7QzPb4X+Qeh8SGXHgYrRZ5+q5VCJEURyWQIGa89g66Ye0IlHdR5vH1
	mHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QQNA4o7ceLLF/Nd3pgEBJN3EQU1Swd1DbQdYCUhQMsc=;
	b=DqktOiSuWfgsSzY6wyTt2r5rGKXa7jcBCn7LLKm0IZvKcupqCsU1JZKiA0xVdCCcgs
	AB3jyZJ1TzV7u8jfOdIzps6xTneiV8zvKy2395MEHf9H9TQrnaz22nTiwhnR5WuEyWJl
	jsiYskp9yEbGCZ2DSUg/xaHERTck+DosIlVEoVO83L5EYakNnk9RvDkE72JTAtuEDklJ
	IQj8NlHBcKmoG0mnhmLbW3BgaB0EV4XWVqiqI2XKyVj3VuKt8UEV9XIjb05ELuKL6TRc
	aksSFw+qVs4llUjRI3cR7jdWTTaNDoc3KuHhegbf5Kg4jtMToOfecN4TZdCU0DfBkPFa
	3qRQ==
X-Gm-Message-State: APjAAAVpYzjMmyHNvzJhQkUyzFo1LDGaKrs12JPIXjGxLT9VvBF8TFhs
	oShmSBsSa22q4fSD9fx4qDLKMN57Nl0=
X-Google-Smtp-Source: APXvYqwRujCAbwlzz2JQJ/ioSe6fP3BZmCtUsyi8mDpfqXxnk60wHosEJW7YfzdGiJgvX3i+dkoW+A==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr30214491pgi.123.1554754667039;
	Mon, 08 Apr 2019 13:17:47 -0700 (PDT)
Received: from localhost.localdomain ([42.111.131.133])
	by smtp.gmail.com with ESMTPSA id
	d187sm35866783pgc.43.2019.04.08.13.17.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 13:17:46 -0700 (PDT)
From: sohailalvi2236@gmail.com
To: 
Date: Tue,  9 Apr 2019 01:47:41 +0530
Message-Id: <20190408201741.8042-1-sohailalvi2236@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFEAcA-D0MK_eEs+tvPsdp+2s9YuC=qS=uyhzNtqy3DW9-=rNQ@mail.gmail.com>
References: <CAFEAcA-D0MK_eEs+tvPsdp+2s9YuC=qS=uyhzNtqy3DW9-=rNQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
X-Mailman-Approved-At: Mon, 08 Apr 2019 16:32:00 -0400
Subject: [Qemu-devel] [PATCH 02/5] hw/timer: qemu_system_reset() replaced by
 watchdog_perform_action()
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
Cc: Sohail Alvi <sohailalvi2236@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408201741.IOD1MXFoIJIOilNO_vPccwqUHj9nEkR4dPnRhosOfP0@z>

From: Sohail Alvi <sohailalvi2236@gmail.com>

Signed-off-by: SohailAlvi <sohailalvi2236@gmail.com>

The watchdog_perform_action() function has been added in place of qemu_system_reset where watchdog was triggered.
Changes have been made according to the previous suggestions given by Peter
Maydell.

The patch was tested with scripts/checkpatch.pl and no style errors were
found.
---
 hw/timer/etraxfs_timer.c | 3 ++-
 hw/timer/m48t59.c        | 3 ++-
 hw/timer/pxa2xx_timer.c  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

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


