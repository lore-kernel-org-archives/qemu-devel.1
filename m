Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A5C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5C0218E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="Yo1RMer2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5C0218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbSc-0001sH-7i
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:05:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKW-00042a-Er
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKU-0007yO-2v
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:24 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:54290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKT-0007vc-Mo
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:21 -0400
Received: by mail-it1-x141.google.com with SMTP id a190so1436731ite.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hW95+dd0C2kldvBgtXgJL4ljKT17lL/a/6AqNhilg7o=;
	b=Yo1RMer2LNneWhtno1BKXVgtSmA0Tcf6re/zW4iM9l1yUPYABJjEkdsWm9GQS0l4iz
	ldDo820j5cJlztZ5MIaJcp19KQj07bCFMoAgXyMLhQIfLni2UDRJUw+RjJMhqmAfkGKp
	z5av7EdOujHoRGoXZYsbsQKG2/jrVtgW5BFNX1uqRXcsWVWKxfqz3Ai/+ZWcvWYeVino
	6E/ddPUzFO5RDPQbJkp+OAHs74N/d8RyMCWHY0EXRLIlZPh4MvIUHPrGlC6jiCdIeQRm
	7iu+8oITj2McAaj611GlI2T2jy52EH/0/tRF5QYhHkl0nwEyFVAR8adAWz0uInLd7STO
	xMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hW95+dd0C2kldvBgtXgJL4ljKT17lL/a/6AqNhilg7o=;
	b=lB5wU+awtUmdc/KUdm20AQMvEWwHy2IGowv8FzFGFo22aFbvYvpeUdYrgsNRru46Lj
	cWS5WQQzmNhSaxzbiN0uB9KRUXovyFeWxIyaOlZE1/6HdtnlhlDNtuXPXf38PaeTQCt4
	ZfddNJevmYm9MWWuuzDX9CSMx5REyxqnCaK7BzYDq5eqFMcaH+JPycoDx4NS0D58hQu9
	SxxIcHOk50+/l8go+EFVFwAIdCDng4gNpU306oWpGcPmPk6DTQFeGgOCKH4jVZANCLDs
	d6+E0cM+mzayUmb4GuAwk9qBje9CsHQQBy+Mey2mACHNX6LY/z4oCJoSqsaNpy2GqvcZ
	g25A==
X-Gm-Message-State: APjAAAUYOZNTE+KZQOv3KepFkO/kdOAi5a+B/C7mCWdsGiw9GtOoZ900
	9Kdl9RMAt3GrCC/D0SqPQSUlX1KDOlZr7A==
X-Google-Smtp-Source: APXvYqyttdRQjuP50W+bExDogLZQE8VmrpFN8HEz6DpUlcXmdYGYw9Cev5Vi3ppxtJL9nsUtCnCsRQ==
X-Received: by 2002:a02:950a:: with SMTP id y10mr806296jah.26.1554757037242;
	Mon, 08 Apr 2019 13:57:17 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:16 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:52 -0400
Message-Id:
 <431abaf842f7e8c41f0e06aee4d084c903f454b8.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::141
Subject: [Qemu-devel] [PATCH 09/10] block/pflash_cfi02: Implement erase
 suspend/resume
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408205552.PgA5lRkGWH4tQovD99EOsJzE9qCjxYKWAFc1OudvVho@z>

During a sector erase (but not a chip erase), the embeded erase program
can be suspended. Once suspended, the sectors not selected for erasure
may be read and programmed. Autoselect mode is allowed during erase
suspend mode. Presumably, CFI queries are similarly allowed so this
commit allows them as well.

Since guest firmware can use status bits DQ7, DQ6, DQ3, and DQ2 to
determine the current state of sector erasure, these bits are properly
implemented.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   | 153 ++++++++++++++++++++++++++++++++++----
 tests/pflash-cfi02-test.c | 102 +++++++++++++++++++++++++
 2 files changed, 241 insertions(+), 14 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4f773f9229..f8a7314dee 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -29,7 +29,6 @@
  * - CFI queries
  *
  * It does not implement software data protection as found in many real chips
- * It does not implement erase suspend/resume commands
  */
 
 #include "qemu/osdep.h"
@@ -37,6 +36,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "qapi/error.h"
+#include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
 #include "qemu/host-utils.h"
@@ -72,6 +72,7 @@ struct PFlashCFI02 {
     BlockBackend *blk;
     uint32_t uniform_nb_blocs;
     uint32_t uniform_sector_len;
+    uint32_t total_sectors;
     uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
     uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
     uint64_t total_len;
@@ -106,6 +107,8 @@ struct PFlashCFI02 {
     int rom_mode;
     int read_counter; /* used for lazy switch-back to rom mode */
     int sectors_to_erase;
+    uint64_t erase_time_remaining;
+    unsigned long *sector_erase_map;
     char *name;
     void *storage;
 };
@@ -152,6 +155,14 @@ static inline void reset_dq3(PFlashCFI02 *pfl)
     pfl->status &= ~(pfl->interleave_multiplier * 0x08);
 }
 
+/*
+ * Toggle status bit DQ2.
+ */
+static inline void toggle_dq2(PFlashCFI02 *pfl)
+{
+    pfl->status ^= pfl->interleave_multiplier * 0x04;
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -175,6 +186,29 @@ static void pflash_register_memory(PFlashCFI02 *pfl, int rom_mode)
     pfl->rom_mode = rom_mode;
 }
 
+/*
+ * Returns the time it takes to erase the number of sectors scheduled for
+ * erasure based on CFI address 0x21 which is "Typical timeout per individual
+ * block erase 2^N ms."
+ */
+static uint64_t pflash_erase_time(PFlashCFI02 *pfl)
+{
+    /*
+     * If there are no sectors to erase (which can happen if all of the sectors
+     * to be erased are protected), then erase takes 100 us. Protected sectors
+     * aren't supported so this should never happen.
+     */
+    return ((1ULL << pfl->cfi_table[0x21]) * pfl->sectors_to_erase) * SCALE_US;
+}
+
+/*
+ * Returns true if the device is currently in erase suspend mode.
+ */
+static inline bool pflash_erase_suspend_mode(PFlashCFI02 *pfl)
+{
+    return pfl->erase_time_remaining > 0;
+}
+
 static void pflash_timer(void *opaque)
 {
     PFlashCFI02 *pfl = opaque;
@@ -189,12 +223,7 @@ static void pflash_timer(void *opaque)
          */
         if ((pfl->status & 0x08) == 0) {
             assert_dq3(pfl);
-            /*
-             * CFI address 0x21 is "Typical timeout per individual block erase
-             * 2^N ms"
-             */
-            uint64_t timeout = ((1ULL << pfl->cfi_table[0x21]) *
-                                pfl->sectors_to_erase) * 1000000;
+            uint64_t timeout = pflash_erase_time(pfl);
             timer_mod(&pfl->timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
             DPRINTF("%s: erase timeout fired; erasing %d sectors\n",
@@ -202,6 +231,7 @@ static void pflash_timer(void *opaque)
             return;
         }
         DPRINTF("%s: sector erase complete\n", __func__);
+        bitmap_zero(pfl->sector_erase_map, pfl->total_sectors);
         pfl->sectors_to_erase = 0;
         reset_dq3(pfl);
     }
@@ -240,25 +270,45 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
     return ret;
 }
 
+typedef struct {
+    uint32_t len;
+    uint32_t num;
+} SectorInfo;
+
 /*
  * offset should be a byte offset of the QEMU device and _not_ a device
  * offset.
  */
-static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)
+static SectorInfo pflash_sector_info(PFlashCFI02 *pfl, hwaddr offset)
 {
     assert(offset < pfl->total_len);
     int nb_regions = pfl->cfi_table[0x2C];
     hwaddr addr = 0;
+    uint32_t sector_num = 0;
     for (int i = 0; i < nb_regions; ++i) {
         uint64_t region_size = (uint64_t)pfl->nb_blocs[i] * pfl->sector_len[i];
         if (addr <= offset && offset < addr + region_size) {
-            return pfl->sector_len[i];
+            return (SectorInfo) {
+                .len = pfl->sector_len[i],
+                .num = sector_num + (offset - addr) / pfl->sector_len[i],
+            };
         }
+        sector_num += pfl->nb_blocs[i];
         addr += region_size;
     }
     abort();
 }
 
+/*
+ * Returns true if the offset refers to a flash sector that is currently being
+ * erased.
+ */
+static bool pflash_sector_is_erasing(PFlashCFI02 *pfl, hwaddr offset)
+{
+    long sector_num = pflash_sector_info(pfl, offset).num;
+    return test_bit(sector_num, pfl->sector_erase_map);
+}
+
 static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
 {
     PFlashCFI02 *pfl = opaque;
@@ -285,6 +335,15 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
     case 0x80:
         /* We accept reads during second unlock sequence... */
     case 0x00:
+        if (pflash_erase_suspend_mode(pfl) &&
+            pflash_sector_is_erasing(pfl, offset)) {
+            /* Toggle bit 2, but not 6. */
+            toggle_dq2(pfl);
+            /* Status register read */
+            ret = pfl->status;
+            DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
+            break;
+        }
         /* Flash area read */
         return pflash_data_read(pfl, offset, width);
     case 0x90:
@@ -313,14 +372,16 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n",
                 __func__, device_addr & 0xFF, ret);
         break;
-    case 0xA0:
     case 0x10:
     case 0x30:
+        /* Toggle bit 2 during erase, but not program. */
+        toggle_dq2(pfl);
+    case 0xA0:
+        /* Toggle bit 6 */
+        toggle_dq6(pfl);
         /* Status register read */
         ret = pfl->status;
         DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
-        /* Toggle bit 6 */
-        toggle_dq6(pfl);
         break;
     case 0x98:
         /* CFI query mode */
@@ -351,7 +412,8 @@ static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
 
 static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
 {
-    uint64_t sector_len = pflash_sector_len(pfl, offset);
+    SectorInfo sector_info = pflash_sector_info(pfl, offset);
+    uint64_t sector_len = sector_info.len;
     offset &= ~(sector_len - 1);
     DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
             __func__, pfl->bank_width * 2, offset,
@@ -363,6 +425,7 @@ static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
     }
     set_dq7(pfl, 0x00);
     ++pfl->sectors_to_erase;
+    set_bit(sector_info.num, pfl->sector_erase_map);
     /* Set (or reset) the 50 us timer for additional erase commands.  */
     timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
 }
@@ -426,6 +489,25 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             pfl->cmd = 0x98;
             return;
         }
+        /* Handle erase resume in erase suspend mode, otherwise reset. */
+        if (cmd == 0x30) {
+            if (pflash_erase_suspend_mode(pfl)) {
+                /* Resume the erase. */
+                timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                          pfl->erase_time_remaining);
+                pfl->erase_time_remaining = 0;
+                pfl->wcycle = 6;
+                pfl->cmd = 0x30;
+                set_dq7(pfl, 0x00);
+                assert_dq3(pfl);
+                return;
+            }
+            goto reset_flash;
+        }
+        /* Ignore erase suspend. */
+        if (cmd == 0xB0) {
+            return;
+        }
         if (masked_addr != pfl->unlock_addr0 || cmd != 0xAA) {
             DPRINTF("%s: unlock0 failed %04x %02x %04x\n",
                     __func__, masked_addr, cmd, pfl->unlock_addr0);
@@ -471,6 +553,14 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             /* We need another unlock sequence */
             goto check_unlock0;
         case 0xA0:
+            if (pflash_erase_suspend_mode(pfl) &&
+                pflash_sector_is_erasing(pfl, offset)) {
+                /* Ignore writes to erasing sectors. */
+                if (pfl->bypass) {
+                    goto do_bypass;
+                }
+                goto reset_flash;
+            }
             trace_pflash_data_write(offset, value, width, 0);
             if (!pfl->ro) {
                 p = (uint8_t *)pfl->storage + offset;
@@ -529,6 +619,10 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case 5:
+        if (pflash_erase_suspend_mode(pfl)) {
+            /* Erasing is not supported in erase suspend mode. */
+            goto reset_flash;
+        }
         switch (cmd) {
         case 0x10:
             if (masked_addr != pfl->unlock_addr0) {
@@ -563,6 +657,30 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             /* Ignore writes during chip erase */
             return;
         case 0x30:
+            if (cmd == 0xB0) {
+                /*
+                 * If erase suspend happens during the erase timeout (so DQ3 is
+                 * 0), then the device suspends erasing immediately. Set the
+                 * remaining time to be the total time to erase. Otherwise,
+                 * there is a maximum amount of time it can take to enter
+                 * suspend mode. Let's ignore that and suspend immediately and
+                 * set the remaining time to the actual time remaining on the
+                 * timer.
+                 */
+                if ((pfl->status & 0x08) == 0) {
+                    pfl->erase_time_remaining = pflash_erase_time(pfl);
+                } else {
+                    int64_t delta = timer_expire_time_ns(&pfl->timer) -
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+                    /* Make sure we have a positive time remaining. */
+                    pfl->erase_time_remaining = delta <= 0 ? 1 : delta;
+                }
+                reset_dq3(pfl);
+                timer_del(&pfl->timer);
+                pfl->wcycle = 0;
+                pfl->cmd = 0;
+                return;
+            }
             /*
              * If DQ3 is 0, additional sector erase commands can be
              * written and anything else (other than an erase suspend) resets
@@ -727,10 +845,12 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     int num_devices = pfl->bank_width / pfl->device_width;
     int nb_regions;
     pfl->total_len = 0;
+    pfl->total_sectors = 0;
     for (nb_regions = 0; nb_regions < PFLASH_MAX_ERASE_REGIONS; ++nb_regions) {
         if (pfl->nb_blocs[nb_regions] == 0) {
             break;
         }
+        pfl->total_sectors += pfl->nb_blocs[nb_regions];
         uint64_t sector_len_per_device = pfl->sector_len[nb_regions] /
                                          num_devices;
 
@@ -765,6 +885,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         pfl->nb_blocs[0] = pfl->uniform_nb_blocs;
         pfl->sector_len[0] = pfl->uniform_sector_len;
         pfl->total_len = uniform_len;
+        pfl->total_sectors = pfl->uniform_nb_blocs;
     } else if (uniform_len != 0 && uniform_len != pfl->total_len) {
         error_setg(errp, "\"num-blocks\"*\"sector-length\" "
                    "different from \"num-blocks0\"*\'sector-length0\" + ... + "
@@ -789,6 +910,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->unlock_addr0 &= 0x7FF;
     pfl->unlock_addr1 &= 0x7FF;
 
+    /* Allocate memory for a bitmap for sectors being erased. */
+    pfl->sector_erase_map = bitmap_new(pfl->total_sectors);
+
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -896,7 +1020,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->cfi_table[0x44] = '0';
 
     pfl->cfi_table[0x45] = 0x00; /* Address sensitive unlock required. */
-    pfl->cfi_table[0x46] = 0x00; /* Erase suspend not supported. */
+    pfl->cfi_table[0x46] = 0x02; /* Erase suspend to read/write. */
     pfl->cfi_table[0x47] = 0x00; /* Sector protect not supported. */
     pfl->cfi_table[0x48] = 0x00; /* Temporary sector unprotect not supported. */
 
@@ -938,6 +1062,7 @@ static void pflash_cfi02_unrealize(DeviceState *dev, Error **errp)
 {
     PFlashCFI02 *pfl = PFLASH_CFI02(dev);
     timer_del(&pfl->timer);
+    g_free(pfl->sector_erase_map);
 }
 
 static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index dad16aaf52..67a639d888 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -45,6 +45,8 @@ typedef struct {
 #define CHIP_ERASE_CMD 0x10
 #define UNLOCK_BYPASS_CMD 0x20
 #define UNLOCK_BYPASS_RESET_CMD 0x00
+#define ERASE_SUSPEND_CMD 0xB0
+#define ERASE_RESUME_CMD SECTOR_ERASE_CMD
 
 typedef struct {
     /* Interleave configuration. */
@@ -267,6 +269,16 @@ static void chip_erase(const FlashConfig *c)
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
 
+static void erase_suspend(const FlashConfig *c)
+{
+    flash_cmd(c, FLASH_ADDR(0), ERASE_SUSPEND_CMD);
+}
+
+static void erase_resume(const FlashConfig *c)
+{
+    flash_cmd(c, FLASH_ADDR(0), ERASE_RESUME_CMD);
+}
+
 /*
  * Test flash commands with a variety of device geometry.
  */
@@ -345,6 +357,7 @@ static void test_geometry(const void *opaque)
     const uint64_t dq7 = replicate(c, 0x80);
     const uint64_t dq6 = replicate(c, 0x40);
     const uint64_t dq3 = replicate(c, 0x08);
+    const uint64_t dq2 = replicate(c, 0x04);
 
     uint64_t byte_addr = 0;
     for (int region = 0; region < nb_erase_regions; ++region) {
@@ -485,6 +498,95 @@ static void test_geometry(const void *opaque)
         }
     }
 
+    /* Test erase suspend/resume during erase timeout. */
+    sector_erase(c, 0);
+    /*
+     * Check that DQ 3 is 0 and DQ6 and DQ2 are toggling in the sector being
+     * erased as well as in a sector not being erased.
+     */
+    byte_addr = c->sector_len[0];
+    status0 = flash_read(c, 0);
+    status1 = flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, ==, 0);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    status0 = flash_read(c, byte_addr);
+    status1 = flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, ==, 0);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+
+    /*
+     * Check that after suspending, DQ6 does not toggle but DQ2 does toggle in
+     * an erase suspended sector but that neither toggle (we should be
+     * getting data) in a sector not being erased.
+     */
+    erase_suspend(c);
+    status0 = flash_read(c, 0);
+    status1 = flash_read(c, 0);
+    g_assert_cmpint(status0 & dq6, ==, status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    g_assert_cmpint(flash_read(c, byte_addr), ==, flash_read(c, byte_addr));
+
+    /* Check that after resuming, DQ3 is 1 and DQ6 and DQ2 toggle. */
+    erase_resume(c);
+    status0 = flash_read(c, 0);
+    status1 = flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, ==, dq3);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    status0 = flash_read(c, byte_addr);
+    status1 = flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, ==, dq3);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    wait_for_completion(c, 0);
+
+    /* Repeat this process but this time suspend after the timeout. */
+    sector_erase(c, 0);
+    clock_step_next();
+    /*
+     * Check that DQ 3 is 1 and DQ6 and DQ2 are toggling in the sector being
+     * erased as well as in a sector not being erased.
+     */
+    byte_addr = c->sector_len[0];
+    status0 = flash_read(c, 0);
+    status1 = flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, ==, dq3);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    status0 = flash_read(c, byte_addr);
+    status1 = flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, ==, dq3);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+
+    /*
+     * Check that after suspending, DQ6 does not toggle but DQ2 does toggle in
+     * an erase suspended sector but that neither toggle (we should be
+     * getting data) in a sector not being erased.
+     */
+    erase_suspend(c);
+    status0 = flash_read(c, 0);
+    status1 = flash_read(c, 0);
+    g_assert_cmpint(status0 & dq6, ==, status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    g_assert_cmpint(flash_read(c, byte_addr), ==, flash_read(c, byte_addr));
+
+    /* Check that after resuming, DQ3 is 1 and DQ6 and DQ2 toggle. */
+    erase_resume(c);
+    status0 = flash_read(c, 0);
+    status1 = flash_read(c, 0);
+    g_assert_cmpint(status0 & dq3, ==, dq3);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    status0 = flash_read(c, byte_addr);
+    status1 = flash_read(c, byte_addr);
+    g_assert_cmpint(status0 & dq3, ==, dq3);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+    g_assert_cmpint(status0 & dq2, ==, ~status1 & dq2);
+    wait_for_completion(c, 0);
+
     qtest_quit(global_qtest);
 }
 
-- 
2.20.1 (Apple Git-117)


