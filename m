Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42922C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129E32073B
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmxx7/09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129E32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctrF-0006ue-9R
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jctqV-0006IG-U9; Sun, 24 May 2020 12:51:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jctqV-0007gH-2l; Sun, 24 May 2020 12:51:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so10789988wru.12;
 Sun, 24 May 2020 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A5eA3fxA5I4ePu0JOBPPzSYvNnOc3wYRHkvM98rYLYw=;
 b=Wmxx7/09bXydbBHx2rl23xn3p3t8BsJdlIY73HQt026N03cq/wRW2ow0kARH82M2HT
 MCop+RWNZonu0gm+xfTUi/DDCAejsHmVGmZx518ru1daEpni9IOqV0TcplPTILdAxj4p
 2YpfPXR+4Iw5vrDj070O0wiqoyr78nKbRvQMzJVjvK7sxkG9OQmZ7m44lGc6NdHLXxqu
 oEIp0ab2xPr5deIKtuyQPNqEo3zq5kPNcwSXMXo6rfH9DhNxVh8mClR62SnA4EOijCDz
 FiaAttrBsYXzO5PYGPX0tRohjeq3ELQ16+gSii2Z0EoriSScId4ukJEWnEft9u5NIfhE
 Q9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=A5eA3fxA5I4ePu0JOBPPzSYvNnOc3wYRHkvM98rYLYw=;
 b=a7OJe3E1Y+SzEeKJWaWfOzyzmek0UDdWyvWc/K+RhX4P+SJZtMj2RImlIgGEFzj0fD
 vn9pwBWpT/+hh5nPOyYvMLIF8x5iASzke7SQUkJ56qeBc0MsoNaeoUshc4Olc0YqLH2c
 4iJplToBwwYh+wJmxYL4Qt4OWhsjpXCpq45Grrm7k0bxtgaGyrALXwS5/HHP5UDfpUYe
 SdhRdq6pxVPVM1fVj1gpF3PdWnjHxfsk52p18f8ZGbwAVLbz25BnwNAvrljFeS7InOcs
 o5pFf39XGXRkj2GJy7x02qOHUSfNB1otK94tSdqkqSR7YGGP3sAomDRteGqo7gmr/a/y
 IjTg==
X-Gm-Message-State: AOAM533LjK1vr7wGYoyybY8AF+JiYGUXEoPv3f7br3XzeA1L1oInLS7A
 ycF7npVSestINRnriQekUZMHZz3XkiA=
X-Google-Smtp-Source: ABdhPJzEF93AKx2SLN9aDAtEBZfewUfCrmOfY1csZ2oHTHijp2wuofJIP1EIGSit393fO7Y3db0VnA==
X-Received: by 2002:a05:6000:12c2:: with SMTP id
 l2mr11228431wrx.133.1590339088792; 
 Sun, 24 May 2020 09:51:28 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id z206sm3125552wmg.30.2020.05.24.09.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 09:51:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/nvram/mac_nvram: Convert debug printf()s to trace events
Date: Sun, 24 May 2020 18:51:26 +0200
Message-Id: <20200524165126.13920-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert NVR_DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/nvram/mac_nvram.c  | 17 +++--------------
 hw/nvram/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index ff5db03e6b..beec1c4e4d 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -30,18 +30,9 @@
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
+#include "trace.h"
 #include <zlib.h>
 
-/* debug NVR */
-//#define DEBUG_NVR
-
-#ifdef DEBUG_NVR
-#define NVR_DPRINTF(fmt, ...)                                   \
-    do { printf("NVR: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define NVR_DPRINTF(fmt, ...)
-#endif
-
 #define DEF_SYSTEM_SIZE 0xc10
 
 /* macio style NVRAM device */
@@ -51,9 +42,8 @@ static void macio_nvram_writeb(void *opaque, hwaddr addr,
     MacIONVRAMState *s = opaque;
 
     addr = (addr >> s->it_shift) & (s->size - 1);
+    trace_macio_nvram_write(addr, value);
     s->data[addr] = value;
-    NVR_DPRINTF("writeb addr %04" HWADDR_PRIx " val %" PRIx64 "\n",
-                addr, value);
 }
 
 static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
@@ -64,8 +54,7 @@ static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
 
     addr = (addr >> s->it_shift) & (s->size - 1);
     value = s->data[addr];
-    NVR_DPRINTF("readb addr %04" HWADDR_PRIx " val %" PRIx32 "\n",
-                addr, value);
+    trace_macio_nvram_read(addr, value);
 
     return value;
 }
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 0dea9260ce..e023193295 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -13,3 +13,7 @@ fw_cfg_add_string(uint16_t key_value, const char *key_name, const char *value) "
 fw_cfg_add_i16(uint16_t key_value, const char *key_name, uint16_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx16
 fw_cfg_add_i32(uint16_t key_value, const char *key_name, uint32_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx32
 fw_cfg_add_i64(uint16_t key_value, const char *key_name, uint64_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx64
+
+# mac_nvram.c
+macio_nvram_read(uint32_t addr, uint8_t val) "read addr=0x%04"PRIx32" val=0x%02x"
+macio_nvram_write(uint32_t addr, uint8_t val) "write addr=0x%04"PRIx32" val=0x%02x"
-- 
2.21.3


