Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B9DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE962067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJAAoL5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE962067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgxah-0003RU-Pg
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 17:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgxZV-0002PO-56; Thu, 04 Jun 2020 17:38:45 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:40577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgxZT-00063B-Ux; Thu, 04 Jun 2020 17:38:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id s23so2544709pfh.7;
 Thu, 04 Jun 2020 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=CuW4J63C8BE1JA91uC4evX8zCx4/g3WjkquVO9xdzLM=;
 b=eJAAoL5S8gfag7rC9agZ2y4rcL4mvCDEQZudHIKYhAU+BZG2zgvVZeaAfUV9kSJTj5
 40nPsypJfpQdzs1PvVD8xLwmk/oAtynCsAenR9z/UQyvsRGgwmdn7lv+R+Wpr9bd8QFe
 TpLDw+J0rNVTsPUOCk81lgUIycoONNDcJf5jmahiIfe+x6nBe8lUqAKquTvQtug6MSU6
 3mt2uiaMsWHD3UrMZaCv2w4HS3D12QmlPP3ClPnxw7RzwF6YFZv50Z6oWPFK7zN3kiem
 COj4RtcQqK24/bUrE1NXK97yHGaebqOAqJBKIQZx2Gn9nIhz0VYP0x7yck4bYZaaN/+2
 Nhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=CuW4J63C8BE1JA91uC4evX8zCx4/g3WjkquVO9xdzLM=;
 b=dadPoFmXlygzUFiYQQuo6FSkHX38uXfsAurrGuwHRsaXspEK5Jvwb+n7nSid0NHv3m
 eYYK8KkfLGXrby/Xm0FqSlZlzkEC/x6WriCv1EMjdAyYZ6ahzKAjlVnZrffXXCklWsHe
 Q7gscACyYCsxDxkaQ4qPDxPuZxh8Lb88ba27DwYYPUHN3jWc3JUw+arZ5EHJzr2aqars
 wn74poRrrWHeaBsxdUsc6DFp8Eq+gTOVdciAVRhgEZl+5BVhEWZbl5kZ5u+De2oTZiNa
 ilBnae1s6d+2IyWCvi9zGMRA2BRBwBFdY7A2qEZnDNMvtllKRUbnqAPNwH6CmwSsRfYX
 n9sQ==
X-Gm-Message-State: AOAM530oAZgFwwyZxu3s3YP3C34aaKmbzMZ34LMv0G3F5T3LTyMtEpRf
 HXWMgXJ0XzR8SpN5boDp5Cc=
X-Google-Smtp-Source: ABdhPJy5udfh9qxLr2hOs0PQUMx15wqEQ8S3Zs/FMS7dCEkz/DyOMUbOIcv9oB99u9c5m8gT3h3s6A==
X-Received: by 2002:a63:f101:: with SMTP id f1mr6225985pgi.172.1591306721680; 
 Thu, 04 Jun 2020 14:38:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id ev20sm6636337pjb.8.2020.06.04.14.38.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Jun 2020 14:38:40 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH] pflash: cfi02: Convert debug log to tracing
Date: Thu,  4 Jun 2020 14:38:38 -0700
Message-Id: <20200604213838.232682-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When trying to track down problems such as failing unlock sequences
it is essential to have a complete trace log. Having part of it as debug
output and the rest as trace output is counter-productive. Convert all
debug logs to tracing.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/block/pflash_cfi02.c | 62 +++++++++++++++--------------------------
 hw/block/trace-events   | 18 ++++++++++++
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index ac7e34ecbf..4c6e8e3b9b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -47,14 +47,6 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
-#define PFLASH_DEBUG false
-#define DPRINTF(fmt, ...)                                  \
-do {                                                       \
-    if (PFLASH_DEBUG) {                                    \
-        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__);   \
-    }                                                      \
-} while (0)
-
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
 
 /*
@@ -232,11 +224,10 @@ static void pflash_timer(void *opaque)
             uint64_t timeout = pflash_erase_time(pfl);
             timer_mod(&pfl->timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
-            DPRINTF("%s: erase timeout fired; erasing %d sectors\n",
-                    __func__, pfl->sectors_to_erase);
+            trace_pflash_sector_erase_timeout(pfl->sectors_to_erase);
             return;
         }
-        DPRINTF("%s: sector erase complete\n", __func__);
+        trace_pflash_sector_erase_complete();
         bitmap_zero(pfl->sector_erase_map, pfl->total_sectors);
         pfl->sectors_to_erase = 0;
         reset_dq3(pfl);
@@ -324,7 +315,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read*/
-        DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
+        trace_pflash_unknown_command_state(pfl->cmd);
         pfl->wcycle = 0;
         pfl->cmd = 0;
         /* fall through to the read code */
@@ -337,7 +328,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
             toggle_dq2(pfl);
             /* Status register read */
             ret = pfl->status;
-            DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
+            trace_pflash_status(ret);
             break;
         }
         /* Flash area read */
@@ -362,7 +353,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         default:
             ret = pflash_data_read(pfl, offset, width);
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, boff, ret);
+        trace_pflash_flash_id(boff, ret);
         break;
     case 0x10: /* Chip Erase */
     case 0x30: /* Sector Erase */
@@ -374,7 +365,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         toggle_dq6(pfl);
         /* Status register read */
         ret = pfl->status;
-        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
+        trace_pflash_status(ret);
         break;
     case 0x98:
         /* CFI query mode */
@@ -414,9 +405,7 @@ static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
     SectorInfo sector_info = pflash_sector_info(pfl, offset);
     uint64_t sector_len = sector_info.len;
     offset &= ~(sector_len - 1);
-    DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
-            __func__, pfl->width * 2, offset,
-            pfl->width * 2, offset + sector_len - 1);
+    trace_pflash_sector_erase_start(offset, offset + sector_len - 1);
     if (!pfl->ro) {
         uint8_t *p = pfl->storage;
         memset(p + offset, 0xff, sector_len);
@@ -495,27 +484,24 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             return;
         }
         if (boff != pfl->unlock_addr0 || cmd != 0xAA) {
-            DPRINTF("%s: unlock0 failed " TARGET_FMT_plx " %02x %04x\n",
-                    __func__, boff, cmd, pfl->unlock_addr0);
+            trace_pflash_unlock0_failed(boff, cmd, pfl->unlock_addr0);
             goto reset_flash;
         }
-        DPRINTF("%s: unlock sequence started\n", __func__);
+        trace_pflash_unlock_sequence_started();
         break;
     case 1:
         /* We started an unlock sequence */
     check_unlock1:
         if (boff != pfl->unlock_addr1 || cmd != 0x55) {
-            DPRINTF("%s: unlock1 failed " TARGET_FMT_plx " %02x\n", __func__,
-                    boff, cmd);
+            trace_pflash_unlock1_failed(boff, cmd, pfl->unlock_addr1);
             goto reset_flash;
         }
-        DPRINTF("%s: unlock sequence done\n", __func__);
+        trace_pflash_unlock_sequence_done();
         break;
     case 2:
         /* We finished an unlock sequence */
         if (!pfl->bypass && boff != pfl->unlock_addr0) {
-            DPRINTF("%s: command failed " TARGET_FMT_plx " %02x\n", __func__,
-                    boff, cmd);
+            trace_pflash_command_failed(boff, cmd);
             goto reset_flash;
         }
         switch (cmd) {
@@ -526,10 +512,10 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         case 0x90: /* Autoselect */
         case 0xA0: /* Program */
             pfl->cmd = cmd;
-            DPRINTF("%s: starting command %02x\n", __func__, cmd);
+            trace_pflash_command_starting(cmd);
             break;
         default:
-            DPRINTF("%s: unknown command %02x\n", __func__, cmd);
+            trace_pflash_command_unknown(cmd);
             goto reset_flash;
         }
         break;
@@ -585,8 +571,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             }
             /* fall through */
         default:
-            DPRINTF("%s: invalid write for command %02x\n",
-                    __func__, pfl->cmd);
+            trace_pflash_invalid_write_state(pfl->cmd, 3);
             goto reset_flash;
         }
     case 4:
@@ -599,8 +584,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             goto check_unlock1;
         default:
             /* Should never happen */
-            DPRINTF("%s: invalid command state %02x (wc 4)\n",
-                    __func__, pfl->cmd);
+            trace_pflash_invalid_command_state(pfl->cmd, 4);
             goto reset_flash;
         }
         break;
@@ -612,12 +596,11 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         switch (cmd) {
         case 0x10: /* Chip Erase */
             if (boff != pfl->unlock_addr0) {
-                DPRINTF("%s: chip erase: invalid address " TARGET_FMT_plx "\n",
-                        __func__, offset);
+                trace_pflash_invalid_erase_adddress(offset);
                 goto reset_flash;
             }
             /* Chip erase */
-            DPRINTF("%s: start chip erase\n", __func__);
+            trace_pflash_chip_erase_start();
             if (!pfl->ro) {
                 memset(pfl->storage, 0xff, pfl->chip_len);
                 pflash_update(pfl, 0, pfl->chip_len);
@@ -631,7 +614,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             pflash_sector_erase(pfl, offset);
             break;
         default:
-            DPRINTF("%s: invalid command %02x (wc 5)\n", __func__, cmd);
+            trace_pflash_invalid_command_state(pfl->cmd, 5);
             goto reset_flash;
         }
         pfl->cmd = cmd;
@@ -682,19 +665,18 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             return;
         default:
             /* Should never happen */
-            DPRINTF("%s: invalid command state %02x (wc 6)\n",
-                    __func__, pfl->cmd);
+            trace_pflash_invalid_command_state(pfl->cmd, 6);
             goto reset_flash;
         }
         break;
     /* Special values for CFI queries */
     case WCYCLE_CFI:
     case WCYCLE_AUTOSELECT_CFI:
-        DPRINTF("%s: invalid write in CFI query mode\n", __func__);
+        trace_pflash_invalid_write_query();
         goto reset_flash;
     default:
         /* Should never happen */
-        DPRINTF("%s: invalid write state (wc 7)\n",  __func__);
+        trace_pflash_invalid_write_state(pfl->cmd, pfl->wcycle);
         goto reset_flash;
     }
     pfl->wcycle++;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index aca54bda14..46885c2047 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -15,6 +15,24 @@ pflash_data_write(uint64_t offset, unsigned size, uint32_t value, uint64_t count
 pflash_manufacturer_id(uint16_t id) "Read Manufacturer ID: 0x%04x"
 pflash_device_id(uint16_t id) "Read Device ID: 0x%04x"
 pflash_device_info(uint64_t offset) "Read Device Information offset:0x%04"PRIx64
+pflash_sector_erase_timeout(int sectors) "sector erase timeout fired; erasing %d sectors"
+pflash_sector_erase_complete(void) "sector erase complete"
+pflash_unknown_command_state(uint8_t cmd) "unknown command state: 0x%02x"
+pflash_status(uint64_t status) "status 0x%" PRIx64
+pflash_flash_id(uint64_t boff, uint64_t id) "ID 0x%" PRIx64 " 0x%" PRIx64
+pflash_sector_erase_start(uint64_t start, uint64_t end) "start sector erase at 0x%"PRIx64"-0x%"PRIx64
+pflash_unlock0_failed(uint64_t addr, uint8_t cmd, uint16_t expected) "unlock0 failed 0x%" PRIx64 " %02x %04x"
+pflash_unlock_sequence_started(void) "unlock sequence started"
+pflash_unlock1_failed(uint64_t addr, uint8_t cmd, uint16_t expected) "unlock0 failed 0x%" PRIx64 " %02x %04x"
+pflash_unlock_sequence_done(void) "unlock sequence done"
+pflash_command_failed(uint64_t addr, uint8_t cmd) "command failed addr 0x%" PRIx64 " cmd 0x%02x"
+pflash_command_starting(uint8_t cmd) "starting command 0x%02x"
+pflash_command_unknown(uint8_t cmd) "unknown command 0x%02x"
+pflash_invalid_write_state(uint8_t cmd, int state) "invalid write for command 0x%02x (wc %d)"
+pflash_invalid_command_state(uint8_t cmd, int state) "invalid command state 0x%02x (wc %d)"
+pflash_invalid_erase_adddress(uint64_t addr) "chip erase: invalid address 0x%" PRIx64
+pflash_chip_erase_start(void) "start chip erase"
+pflash_invalid_write_query(void) "invalid write in CFI query mode"
 
 # virtio-blk.c
 virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req %p status %d"
-- 
2.17.1


