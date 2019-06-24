Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78305C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496ED20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogSvtHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496ED20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX6G-0001eg-I4
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX27-0007s3-GI
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX25-00041w-IL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX23-000399-Nq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so15484413wrl.9
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GjTm6e+XgHIg/sbtKGfSEXk9pQub5okzFZZW+hOKTwI=;
 b=fogSvtHxzfn8cn6+I4eMwl1xIHtPxipedeqjcceUIE3ToDjF3aU9kltzQYGe4cbLI2
 oRmAbUMZHsPUl07jyrHLdiU6l//pAwbGesCc2EWQfqPCf6Os4RRlVSK7cDthLsIgp0Yn
 HEhG/dmD7GsIUjRxaSI2o0rVvHPZN+2K7wEvziunEaSkzKpry5Z4LloMVIK86kqvTbtL
 UV5/jIR243pNDzy0oZ64uqTsZJzUyNiKW39RZRi1Sd2+h8a5J0mkbBU9PkWM/py7L+dy
 ycfgWfHXfOYII2nMlNt4dWwYzfMPTgW7Ti2aDkZsJhMW3r/yRpNQDS1FXoVZbpIhq8/5
 +HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GjTm6e+XgHIg/sbtKGfSEXk9pQub5okzFZZW+hOKTwI=;
 b=ZCOoWR92gagfewmAmG+lZjFRwN430MTCq/Ly+dK6BgbQe1bPEGy7uSVwmTQfef3Fgt
 invcdjIRrtWTsf4fVhsMx/P0XJv55DP813Sv+fUt1Xwz2cEbL+Jj5jaQT6Xc/bwoW20M
 JrZPJKEoZ/7J+vDnBusgrp4U5VmTyND8rqSyx+sa3Myx+rq3L9ykw5BsB5tDoMACHS00
 IKVzdAGYtIRxFG3VyJO1jNqYvW0fWcz2jCKR14FLr7lGDnaDxJUtmTiHaXlkpYdqnHz2
 EWH5WGd4gTIqS9t6JGh4CSGayBbJV8aW++k0Ur02XLsgIXxFTV0Yus9egz92YUfQk6D7
 rKhQ==
X-Gm-Message-State: APjAAAUXimR8oDox6vf9c+eFdrxeWNa/oYkbo+l0XAG8bGy56lLLlwy0
 GAR/VBOIo4NYBFlXY/QIunaCxr4x
X-Google-Smtp-Source: APXvYqxkPE+K3nx4phbcqLSyRSw2KjLsG/GoBAhbKAiXpqG2XOYHiyXe6AJYYRxAL/vSruVqwCsuIA==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr55049953wrj.272.1561413666933; 
 Mon, 24 Jun 2019 15:01:06 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:53 +0200
Message-Id: <20190624220056.25861-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 6/9] hw/misc/empty_slot: Convert debug
 printf()s to trace events
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/empty_slot.c | 19 ++++++++-----------
 hw/misc/trace-events |  4 ++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index c32241a9e5..b810655554 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -15,15 +15,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/misc/empty_slot.h"
-
-//#define DEBUG_EMPTY_SLOT
-
-#ifdef DEBUG_EMPTY_SLOT
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("empty_slot: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#include "trace.h"
 
 #define TYPE_EMPTY_SLOT "empty_slot"
 #define EMPTY_SLOT(obj) OBJECT_CHECK(EmptySlot, (obj), TYPE_EMPTY_SLOT)
@@ -39,14 +31,19 @@ typedef struct EmptySlot {
 static uint64_t empty_slot_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    DPRINTF("read from " TARGET_FMT_plx "\n", addr);
+    EmptySlot *s = EMPTY_SLOT(opaque);
+
+    trace_empty_slot_write(addr, size << 1, 0, size, s->name);
+
     return 0;
 }
 
 static void empty_slot_write(void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
-    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
+    EmptySlot *s = EMPTY_SLOT(opaque);
+
+    trace_empty_slot_write(addr, size << 1, val, size, s->name);
 }
 
 static const MemoryRegionOps empty_slot_ops = {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 47e1bccf71..b81135ab1e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# empty_slot.c
+empty_slot_read(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "rd addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
+empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
-- 
2.19.1


