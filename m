Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C3BC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D63B20735
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRL5funx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D63B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXo1e-0008Td-MD
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnss-0006JH-Um
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnss-0000zF-9b
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id n5so1171643wmd.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JZAHSZ9/RMyf7zmTq4LzX8Lv/0TSeN7lgrmPTggBXqs=;
 b=NRL5funxvIR+mwEtIZiowPP+soIu5SGLOtHPcDKMfHP70XokVySO9O2gQh1m/39F17
 yN4lI8wJMSwxt30AVojmpTrz2RusfVLHlYSCW1c+d2CkoadbcYMbGO/QI+9OlZ3Q7Gvn
 jjJ9NfTkOD6IMKtkUAQvWKwZXNd7gCSjkYC1VdUxPQ7i5nDwRXYq+GLVEbw6QvOCxjOR
 1B60bHhKpfLOjjiER54NBvrtgUBCkiur2edYM+VHluxIBItiGkAH3fXKBES6MkPUIjqN
 RqXlSmmaP59BxPpmWp4eojlVat3vTbF3DKTmn//N2oVTUdH5mZkXnBBikyFQ85P8vxnQ
 3pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JZAHSZ9/RMyf7zmTq4LzX8Lv/0TSeN7lgrmPTggBXqs=;
 b=OhxTFV7uiklfQKDAKF7Nxfkc4Rrx0rgRXFMvu5btnvan1Rw64PLA6tuwMYW1r2ua09
 HRuR+Hx8oVzcTWIyFJAprWE9XVslvyPDJtsSxe9MCJeh7xxvrWogkTYiUUqUr6k3D565
 6G4SXWi/+d1Wl5BGY4FxWIp9UxybFRE0BefBHRf0mLepI3+posJGboso5XizdJTVjMuw
 FgyqAe5JcGj1MK+Jt+gRK0JIzSa3J1d+lM8lSYiNMPOiU30Ux1ggiXIJwpNkWeJBNNXo
 1Pk8x36ILcTf4nIiORxnS9G4ff4tFej0gNkKCJaBry1BFRlV7y2jnPIt3v6JE1y401rr
 +GAQ==
X-Gm-Message-State: AGi0PuZ5eLJsQNNf/ubNAw9cThZ1n5Bs5f9m5CgMIBpATfXHo7KNq8X2
 +6cyh1RfgjCGRSh7mkiYLI6IhTGrwMo=
X-Google-Smtp-Source: APiQypIl/8NFotEUeOhN7zQSLmjcsU2xY2JrpUpw6dFhOp8vuiNFPoN38lGFtfb3kxj76GWHuSOwuw==
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr25486101wmg.167.1589124532669; 
 Sun, 10 May 2020 08:28:52 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/misc/empty_slot: Convert debug printf() to trace event
Date: Sun, 10 May 2020 17:28:38 +0200
Message-Id: <20200510152840.13558-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
References: <20200510152840.13558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/empty_slot.c | 19 ++++++++-----------
 hw/core/trace-events |  4 ++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 576b276c4b..d28f7f99c9 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -14,15 +14,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "hw/empty_slot.h"
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
@@ -38,14 +30,19 @@ typedef struct EmptySlot {
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
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 1ac60ede6b..bbb68fb6f0 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -34,3 +34,7 @@ clock_disconnect(const char *clk) "'%s'"
 clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
 clock_propagate(const char *clk) "'%s'"
 clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
+
+# empty_slot.c
+empty_slot_read(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "rd addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
+empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
-- 
2.21.3


