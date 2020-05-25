Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE52C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96ECC20787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HreIQBAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96ECC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBL0-0003M7-K1
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBHZ-0007z4-UM; Mon, 25 May 2020 07:28:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBHY-0001h5-DE; Mon, 25 May 2020 07:28:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id l26so856008wme.3;
 Mon, 25 May 2020 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8or0Jt1EOa4HRL3qYrPJ2szYMkUXx13MFz/tHwUyMew=;
 b=HreIQBAyjC1oLr2Saez0nDxlNXi7c4/ZQ8T3xKZWIbsER2nkpxL7iHenvN4n9vAUi+
 GwdkHvmhXrFswoYgYwC2cBdMSOdNGlx4BTUmVLtUuo2RVbJe8TjdT1ZGsGpEd+CQkuAu
 IBbd+luJHCUQHAI/0UNyS0TgksHmZVV6eSow+Q7T1Jy6ubWIAC07eGKp1mqHLCPc2FPd
 bdG5r+jl6PmnnQX1PPMAQY/zYSrY4Qo27BDgOcdeHUd0ZUdzXH6leuu7//jtzs3cLCZ7
 0MU2gH4vwYx4q/KLWEjJoo+FrRuIY4TW8PR27J4lahNVyaK2I6t1OjHGTcLqKoJ+jmTo
 YF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8or0Jt1EOa4HRL3qYrPJ2szYMkUXx13MFz/tHwUyMew=;
 b=Wbg1B9sopvybiR1PEgmZi60zqIgov1CrMgtjaTvRIhKoIhzyqHAWu7ItCZ3EUUxiyI
 m6s8EEaHHaWXC5TGcbJYhc3w7buBAGfLIctl0orv83BO0me81J7EgpRbs0KQzSOS6EBW
 qU8MS0xOeUMecSZksSAauCPvxxHUMfNflEetVZ9lp/s8EExHn9efvtecqu0vyrsS0gVL
 /7JHRK80LKzx+aHqEyohw0M3t5e/ejShqrGC3sf+z+wXJgSwU5zPdt5zy5VQn4Dmo2sW
 uPdsn5M15paq4CNTG50QT6TsERoGSfztcA31Z/FvJxQHGfv0hfvz92SbdkH4o7A27M04
 VHgQ==
X-Gm-Message-State: AOAM531g6f5A8p21Xxr98a/ZW+KenOtnf9Vs9q/7JxpofZI9HoO0/WmS
 4alQGD4zfOqsJbPndOIOiwgyBy2RJdQ=
X-Google-Smtp-Source: ABdhPJw4ufyliGA5gLQfdRqqMe3yVfyCvCUfmsqVg+rkFA3i9+vyvMk8YZyrpwhiet9S8PlRx5p2fw==
X-Received: by 2002:a1c:dc05:: with SMTP id t5mr26061736wmg.112.1590406114001; 
 Mon, 25 May 2020 04:28:34 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id x17sm17849039wrp.71.2020.05.25.04.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:28:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/display/cg3: Convert debug printf()s to trace events
Date: Mon, 25 May 2020 13:28:31 +0200
Message-Id: <20200525112831.12697-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Order addr/val/size (Mark review)
---
 hw/display/cg3.c        | 14 ++++----------
 hw/display/trace-events |  4 ++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f7f1c199ce..7cbe6e56ff 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 /* Change to 1 to enable debugging */
 #define DEBUG_CG3 0
@@ -63,12 +64,6 @@
 #define CG3_VRAM_SIZE 0x100000
 #define CG3_VRAM_OFFSET 0x800000
 
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_CG3) { \
-        printf("CG3: " fmt , ## __VA_ARGS__); \
-    } \
-} while (0)
-
 #define TYPE_CG3 "cgthree"
 #define CG3(obj) OBJECT_CHECK(CG3State, (obj), TYPE_CG3)
 
@@ -195,7 +190,8 @@ static uint64_t cg3_reg_read(void *opaque, hwaddr addr, unsigned size)
         val = 0;
         break;
     }
-    DPRINTF("read %02x from reg %" HWADDR_PRIx "\n", val, addr);
+    trace_cg3_read(addr, val, size);
+
     return val;
 }
 
@@ -206,9 +202,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t regval;
     int i;
 
-    DPRINTF("write %" PRIx64 " to reg %" HWADDR_PRIx " size %d\n",
-            val, addr, size);
-
+    trace_cg3_write(addr, val, size);
     switch (addr) {
     case CG3_REG_BT458_ADDR:
         s->dac_index = val;
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e6e22bef88..47b2b168ae 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -151,3 +151,7 @@ artist_vram_write(unsigned int size, uint64_t addr, uint64_t val) "%u 0x%"PRIx64
 artist_fill_window(unsigned int start_x, unsigned int start_y, unsigned int width, unsigned int height, uint32_t op, uint32_t ctlpln) "start=%ux%u length=%ux%u op=0x%08x ctlpln=0x%08x"
 artist_block_move(unsigned int start_x, unsigned int start_y, unsigned int dest_x, unsigned int dest_y, unsigned int width, unsigned int height) "source %ux%u -> dest %ux%u size %ux%u"
 artist_draw_line(unsigned int start_x, unsigned int start_y, unsigned int end_x, unsigned int end_y) "%ux%u %ux%u"
+
+# cg3.c
+cg3_read(uint32_t addr, uint32_t val, unsigned size) "read addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
+cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
-- 
2.21.3


