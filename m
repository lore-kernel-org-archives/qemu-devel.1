Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F86C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F50C222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3nW2W36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F50C222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXkH-0007Pf-Qs
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgE-0004Q7-BR
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgC-0002rx-Vm
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgC-0002rP-OA; Thu, 26 Sep 2019 13:35:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so3731578wrd.3;
 Thu, 26 Sep 2019 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dVltp39xedbrgwUOXng2QOxtQsY5AQIYkr6iGsnYDUQ=;
 b=T3nW2W361fb7P5FZGKelLc273F0cI5MaxE/REmvYNSaMrzoFNlRHj3S1cNoZcF92c1
 mYhbUaqJFMbpz9DTf3ugarlinTeRjT+JgjGt3z4LEP1ff6nV3L4awGG5HiXXkrEvSwo2
 BXr4ISCsNNULgUqo6QsEL6WKtpmyGjP92O8oeuhAi0Qn63gr1e72pGXWCIIhmBIb3C1H
 RWbFA6oIteF8PYAKKKtf/rGXia7ASsrjOjm/v4Afzu1AN3KHfvw6Lw42Z5WLa02YNRE8
 PLJV6aW5o5YAio8C/iNuL9gz8kW9WODmnJtJ5BoNGPEP/6BHwyB3+LzeafQecjSuoaz/
 endg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dVltp39xedbrgwUOXng2QOxtQsY5AQIYkr6iGsnYDUQ=;
 b=gzr7Hf/yWX3bOBbRH8fI1uLu1dBnkRwgmiFjujZWVMSBDU53/Ht0NSJY7G2GZ1NRT1
 yLZvLhzvdobCHByRfGPs0hCmX02Tvo8JCD0qD4rRxoKxgGYcoLQpIRnCt8f0OYdM0uac
 e/3DfE7eLCR1NhzQu8hquLkfj3VV8FhafHSGq/HJ2a+MUIe2KZsHteik9blgyprGurMB
 E7XqzTAlL3CLQZS3X3DsQG1LwoooWSUEpUrxQGci1BB8MiCr9/3WKKPYwMlTFwlqn5WY
 oudpOsthO1LFk9UhThH8vnaeg8rQGtxlHJ/AelTWWg10f8CFRS4PnHcjLMXB9t2jcaPr
 ea1w==
X-Gm-Message-State: APjAAAUA8PivrQspkxyjeU6OKRHpiZWqFf3IqcwS/+SNWcfJHR83CoEd
 dX2Fb5hzqgNRMEHVME1GE2EtBzoJLLg=
X-Google-Smtp-Source: APXvYqxJMeRJndPfiMPXmJdb+S2LWH51uPBCOJlbrLtKCy6882NxelxmqSMpmRoQhYwX9ZIpg7R2fQ==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr3917973wrn.307.1569519287489; 
 Thu, 26 Sep 2019 10:34:47 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/19] hw/misc/bcm2835_mbox: Add trace events
Date: Thu, 26 Sep 2019 19:34:15 +0200
Message-Id: <20190926173428.10713-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events for read/write accesses and IRQ.

Properties are structures used for the ARM particular MBOX.
Since one call in bcm2835_property.c concerns the mbox block,
name this trace event in the same bcm2835_mbox* namespace.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/bcm2835_mbox.c     | 5 +++++
 hw/misc/bcm2835_property.c | 2 ++
 hw/misc/trace-events       | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 77285624c9..77d2d80706 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -15,6 +15,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #define MAIL0_PEEK   0x90
 #define MAIL0_SENDER 0x94
@@ -123,6 +124,7 @@ static void bcm2835_mbox_update(BCM2835MboxState *s)
             set = true;
         }
     }
+    trace_bcm2835_mbox_irq(set);
     qemu_set_irq(s->arm_irq, set);
 }
 
@@ -178,8 +180,10 @@ static uint64_t bcm2835_mbox_read(void *opaque, hwaddr offset, unsigned size)
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
+        trace_bcm2835_mbox_read(size, offset, res);
         return 0;
     }
+    trace_bcm2835_mbox_read(size, offset, res);
 
     bcm2835_mbox_update(s);
 
@@ -195,6 +199,7 @@ static void bcm2835_mbox_write(void *opaque, hwaddr offset,
 
     offset &= 0xff;
 
+    trace_bcm2835_mbox_write(size, offset, value);
     switch (offset) {
     case MAIL0_SENDER:
         break;
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 43a5465c5d..0eea2e20f7 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -13,6 +13,7 @@
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
@@ -283,6 +284,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         }
 
+        trace_bcm2835_mbox_property(tag, bufsize, resplen);
         if (tag == 0) {
             break;
         }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 74276225f8..1deb1d08c1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -143,3 +143,9 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
 
 # aspeed_xdma.c
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
+# bcm2835_mbox.c
+bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
+bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
+bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
+bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
-- 
2.20.1


