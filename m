Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCB0C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C066820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rirS6Cd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlyN-0001Xm-3M
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izlx1-0000Hi-CU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izlwz-0002pq-Kx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:31 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izlwv-0002JV-Vp; Thu, 06 Feb 2020 13:32:26 -0500
Received: by mail-pg1-x544.google.com with SMTP id k3so3167489pgc.3;
 Thu, 06 Feb 2020 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=ALuZTuN5DfhXqsi8y55rZh7eLMFrbBhU4HDPNxMYbKY=;
 b=rirS6Cd5G3uxOCsFgXy9CdpIl/E8oFnxeCmQCOCVRMTl5YY0EvIPiQ0Y82YtgJfxg1
 O4qb/iX+cU4ah1COUQtieL/oykPycBuzgOy6SeMqy+sRz5uhfScA3V0MpGOhmHiOtchF
 Y4Nm7eERHOSK7DnAm/SUXAraqKJHCjK3mAh2FZAsmdsQd90y/ymsEqaFCHlqQfqUCYfV
 x1vFHnNlm2Y1Bmocpmh63gB4OoJzpKyEqR5oMVtdTXQXmp/vE3nMyRDU0WryycFLchvs
 di3SwFey45cs+/9Hu+/cY5mXNrsQdtyEVOw9tYcRzs0Y2/b2sTu/D98BxKGo/YnwhHP6
 Xvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=ALuZTuN5DfhXqsi8y55rZh7eLMFrbBhU4HDPNxMYbKY=;
 b=L1F5lvUs8ur+ouferdEIm7HXUn6gi0V2RFDUOaDZ9BcDJKphpqI/R4Bkppe3Ctiy5a
 Xcg4EHIjm7I99EOsrkVTwIgTDHGLVTDsvbrD/3BwuNp+eZSNwxw+DGO/Bdr8jUR2jTOw
 v98MABfJ+uN77lRBf94XYxLwTXaG4DCXCK64lR8lmhzN+tKizQ27UXk4Sac5eGJoM5Z2
 n/olh+/ckQ7U0WIPbecnCNGB02e9W+4XDSuVsFnO5LFAYecP5hnLSv+8oYTbzS5tN7ow
 0muM7IwHn1nUbeQImi0Z1z90TW5CzkQxOE2Dave8CrHwfJ64qZKRgLYpN3SR9gsfRgGj
 9pNg==
X-Gm-Message-State: APjAAAXZ8JNYFfTISv2F8hZzXvorIEegfnhSuhE+hTE/jkNxN+ETXfAA
 XCUZwyb4/LCSAIGSwNzRMNo=
X-Google-Smtp-Source: APXvYqzCwh2Bjh1FVDQs0HKAVXqvjJQtHPrrd6Ae8gj6X6/M7JDCmvH1ScwZ7Yhkukpal5pDG8fzag==
X-Received: by 2002:a63:f648:: with SMTP id u8mr5236001pgj.148.1581013944579; 
 Thu, 06 Feb 2020 10:32:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c15sm94514pfo.137.2020.02.06.10.32.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Feb 2020 10:32:23 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 1/4] m25p80: Convert to support tracing
Date: Thu,  6 Feb 2020 10:32:16 -0800
Message-Id: <20200206183219.3756-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While at it, add some trace messages to help debug problems
seen when running the latest Linux kernel.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Print pointer to Flash data structure as flash ID with each trace
    message to support systems with more than one instantiated flash.

 hw/block/m25p80.c     | 48 ++++++++++++++++++++-----------------------
 hw/block/trace-events | 16 +++++++++++++++
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 61f2fb8f8f..5ff8d270c4 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -32,17 +32,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-
-#ifndef M25P80_ERR_DEBUG
-#define M25P80_ERR_DEBUG 0
-#endif
-
-#define DB_PRINT_L(level, ...) do { \
-    if (M25P80_ERR_DEBUG > (level)) { \
-        fprintf(stderr,  ": %s: ", __func__); \
-        fprintf(stderr, ## __VA_ARGS__); \
-    } \
-} while (0)
+#include "trace.h"
 
 /* Fields for FlashPartInfo->flags */
 
@@ -574,7 +564,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
         abort();
     }
 
-    DB_PRINT_L(0, "offset = %#x, len = %d\n", offset, len);
+    trace_m25p80_flash_erase(s, offset, len);
+
     if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d erase size not supported by"
                       " device\n", len);
@@ -607,8 +598,7 @@ void flash_write8(Flash *s, uint32_t addr, uint8_t data)
     }
 
     if ((prev ^ data) & data) {
-        DB_PRINT_L(1, "programming zero to one! addr=%" PRIx32 "  %" PRIx8
-                   " -> %" PRIx8 "\n", addr, prev, data);
+        trace_m25p80_programming_zero_to_one(s, addr, prev, data);
     }
 
     if (s->pi->flags & EEPROM) {
@@ -662,6 +652,9 @@ static void complete_collecting_data(Flash *s)
 
     s->state = STATE_IDLE;
 
+    trace_m25p80_complete_collecting(s, s->cmd_in_progress, n, s->ear,
+                                     s->cur_addr);
+
     switch (s->cmd_in_progress) {
     case DPP:
     case QPP:
@@ -825,7 +818,7 @@ static void reset_memory(Flash *s)
         break;
     }
 
-    DB_PRINT_L(0, "Reset done.\n");
+    trace_m25p80_reset_done(s);
 }
 
 static void decode_fast_read_cmd(Flash *s)
@@ -941,9 +934,10 @@ static void decode_qio_read_cmd(Flash *s)
 
 static void decode_new_cmd(Flash *s, uint32_t value)
 {
-    s->cmd_in_progress = value;
     int i;
-    DB_PRINT_L(0, "decoded new command:%x\n", value);
+
+    s->cmd_in_progress = value;
+    trace_m25p80_command_decoded(s, value);
 
     if (value != RESET_MEMORY) {
         s->reset_enable = false;
@@ -1042,7 +1036,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         break;
 
     case JEDEC_READ:
-        DB_PRINT_L(0, "populated jedec code\n");
+        trace_m25p80_populated_jedec(s);
         for (i = 0; i < s->pi->id_len; i++) {
             s->data[i] = s->pi->id[i];
         }
@@ -1063,7 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case BULK_ERASE_60:
     case BULK_ERASE:
         if (s->write_enable) {
-            DB_PRINT_L(0, "chip erase\n");
+            trace_m25p80_chip_erase(s);
             flash_erase(s, 0, BULK_ERASE);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR, "M25P80: chip erase with write "
@@ -1184,7 +1178,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
         s->data_read_loop = false;
     }
 
-    DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
+    trace_m25p80_select(s, select ? "de" : "");
 
     return 0;
 }
@@ -1194,19 +1188,20 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
     Flash *s = M25P80(ss);
     uint32_t r = 0;
 
+    trace_m25p80_transfer(s, s->state, s->len, s->needed_bytes, s->pos,
+                          s->cur_addr, (uint8_t)tx);
+
     switch (s->state) {
 
     case STATE_PAGE_PROGRAM:
-        DB_PRINT_L(1, "page program cur_addr=%#" PRIx32 " data=%" PRIx8 "\n",
-                   s->cur_addr, (uint8_t)tx);
+        trace_m25p80_page_program(s, s->cur_addr, (uint8_t)tx);
         flash_write8(s, s->cur_addr, (uint8_t)tx);
         s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
         break;
 
     case STATE_READ:
         r = s->storage[s->cur_addr];
-        DB_PRINT_L(1, "READ 0x%" PRIx32 "=%" PRIx8 "\n", s->cur_addr,
-                   (uint8_t)r);
+        trace_m25p80_read_byte(s, s->cur_addr, (uint8_t)r);
         s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
         break;
 
@@ -1244,6 +1239,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
         }
 
         r = s->data[s->pos];
+        trace_m25p80_read_data(s, s->pos, (uint8_t)r);
         s->pos++;
         if (s->pos == s->len) {
             s->pos = 0;
@@ -1281,7 +1277,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
             return;
         }
 
-        DB_PRINT_L(0, "Binding to IF_MTD drive\n");
+        trace_m25p80_binding(s);
         s->storage = blk_blockalign(s->blk, s->size);
 
         if (blk_pread(s->blk, 0, s->storage, s->size) != s->size) {
@@ -1289,7 +1285,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
             return;
         }
     } else {
-        DB_PRINT_L(0, "No BDRV - binding to RAM\n");
+        trace_m25p80_binding_no_bdrv(s);
         s->storage = blk_blockalign(NULL, s->size);
         memset(s->storage, 0xFF, s->size);
     }
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c03e80c2c9..f78939fa9d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -134,3 +134,19 @@ xen_block_blockdev_add(char *str) "%s"
 xen_block_blockdev_del(const char *node_name) "%s"
 xen_block_device_create(unsigned int number) "%u"
 xen_block_device_destroy(unsigned int number) "%u"
+
+# m25p80.c
+m25p80_flash_erase(void *s, int offset, uint32_t len) "[%p] offset = 0x%"PRIx32", len = %u"
+m25p80_programming_zero_to_one(void *s, uint32_t addr, uint8_t prev, uint8_t data) "[%p] programming zero to one! addr=0x%"PRIx32"  0x%"PRIx8" -> 0x%"PRIx8
+m25p80_reset_done(void *s) "[%p] Reset done."
+m25p80_command_decoded(void *s, uint32_t cmd) "[%p] new command:0x%"PRIx32
+m25p80_complete_collecting(void *s, uint32_t cmd, int n, uint8_t ear, uint32_t cur_addr) "[%p] decode cmd: 0x%"PRIx32" len %d ear 0x%"PRIx8" addr 0x%"PRIx32
+m25p80_populated_jedec(void *s) "[%p] populated jedec code"
+m25p80_chip_erase(void *s) "[%p] chip erase"
+m25p80_select(void *s, const char *what) "[%p] %sselect"
+m25p80_page_program(void *s, uint32_t addr, uint8_t tx) "[%p] page program cur_addr=0x%"PRIx32" data=0x%"PRIx8
+m25p80_transfer(void *s, uint8_t state, uint32_t len, uint8_t needed, uint32_t pos, uint32_t cur_addr, uint8_t t) "[%p] Transfer state 0x%"PRIx8" len 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
+m25p80_read_byte(void *s, uint32_t addr, uint8_t v) "[%p] Read byte 0x%"PRIx32"=0x%"PRIx8
+m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0x%"PRIx8
+m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
+m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
-- 
2.17.1


