Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A2C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE76520879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="1J6kjY1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE76520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbUt-0003IV-2q
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:08:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKT-0003zK-Lc
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKQ-0007u9-0U
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:21 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:40276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKP-0007so-Ja
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:17 -0400
Received: by mail-it1-x143.google.com with SMTP id k64so1428867itb.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3THaHSWEylYySKmgh3f4xH1bdO8Ha+TvgLUYvmPOH8s=;
	b=1J6kjY1gH2AnePN085FjjZQhbr0cETiGbl+8/QXY2ptg31K2395/ibSCp+HItuyZuJ
	bZ0Dez/lIfHEMf2qlW1sNUBuTjZ1navGCi2lsispjeVT3MDd7zqPjpMCKGMjMtAw3Vuk
	oPEAlT5Jz53BvPnzi9T+/gz6grQp6WFK9GEnEwwTkVU/CwRv6AsFhKoDX5xX0P7Z9XYf
	GofwXVtxk7jTyeYkvi0VVnoOzpa5TVyTnQtBvDpRRdmSWTgRcICBczRzZrnSieTP2GYQ
	9VIppdd0hOfWNJ8ybJVkSqxxo0SZ0Lg14ahtKEBJZTTFxOgYap28+o2Ql+aq2BTZ7wFx
	IVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3THaHSWEylYySKmgh3f4xH1bdO8Ha+TvgLUYvmPOH8s=;
	b=QVzZ3JoJYktqGi8YErHO5p+rPu5yTiS3QFXSGs1t97XRWtLA+burr/b0MMUiByqDYp
	9NBguGoi5YN0oQb4Qr3AaiQE/Mb0XM98yGEabx7EfljH6JIPsJQTCarEBGer8ch2wqjY
	/uL51Xw6U6eCIUVrpFPc+7ATnIkkzDDXGe2CjQrgdCqKr6ySjYK4HAjnbkZ3fB6CnUsv
	DT1U+bIP9q8qt7lfZp2sFGZpbYRXL/bxV+WZ+H6aTKUmk1MAaU8LCcd3hstE+QKetc6p
	bGNIh3AngD3FfWySlen22eBH370FW+bH2ueYl3tcGTw2jACJUZvHbiNQPWF3L5QIdgWa
	Zg8Q==
X-Gm-Message-State: APjAAAVE7G4qxtlA0dwGHk48WamGQzVdVl6yVjZAh0o6lnTn34OlB0qW
	X/IPDgY6Qftzcnjv2uYxe3yhi+jXaPYbYA==
X-Google-Smtp-Source: APXvYqwf4phytjMCBCXK2Z+KtAvxA3VcLu7FhimCuX/8IIMbLRWBR4KYnQInZLlV06N0g5SZye9v7A==
X-Received: by 2002:a05:660c:40d:: with SMTP id
	c13mr22029572itk.115.1554757035992; 
	Mon, 08 Apr 2019 13:57:15 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:15 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:51 -0400
Message-Id:
 <9a10d7067dee911b144d253b0b5bf69b980285f7.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH 08/10] block/pflash_cfi02: Implement
 multi-sector erase
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
Message-ID: <20190408205551.Qqunt0OVhYBHd_DGu4rVtYo8Vxa4g8T-zSFnsbLCQwI@z>

After two unlock cycles and a sector erase command, the AMD flash chips
start a 50 us erase time out. Any additional sector erase commands add a
sector to be erased and restart the 50 us timeout. During the timeout,
status bit DQ3 is cleared. After the time out, DQ3 is asserted during
erasure.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   | 94 +++++++++++++++++++++++++++++++--------
 tests/pflash-cfi02-test.c | 59 ++++++++++++++++++++++--
 2 files changed, 131 insertions(+), 22 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index fa6929b9b6..4f773f9229 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -30,7 +30,6 @@
  *
  * It does not implement software data protection as found in many real chips
  * It does not implement erase suspend/resume commands
- * It does not implement multiple sectors erase
  */
 
 #include "qemu/osdep.h"
@@ -106,6 +105,7 @@ struct PFlashCFI02 {
     MemoryRegion orig_mem;
     int rom_mode;
     int read_counter; /* used for lazy switch-back to rom mode */
+    int sectors_to_erase;
     char *name;
     void *storage;
 };
@@ -136,6 +136,22 @@ static inline void toggle_dq6(PFlashCFI02 *pfl)
     pfl->status ^= pfl->interleave_multiplier * 0x40;
 }
 
+/*
+ * Turn on DQ3.
+ */
+static inline void assert_dq3(PFlashCFI02 *pfl)
+{
+    pfl->status |= pfl->interleave_multiplier * 0x08;
+}
+
+/*
+ * Turn off DQ3.
+ */
+static inline void reset_dq3(PFlashCFI02 *pfl)
+{
+    pfl->status &= ~(pfl->interleave_multiplier * 0x08);
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -159,11 +175,37 @@ static void pflash_register_memory(PFlashCFI02 *pfl, int rom_mode)
     pfl->rom_mode = rom_mode;
 }
 
-static void pflash_timer (void *opaque)
+static void pflash_timer(void *opaque)
 {
     PFlashCFI02 *pfl = opaque;
 
     trace_pflash_timer_expired(pfl->cmd);
+    if (pfl->cmd == 0x30) {
+        /*
+         * Sector erase. If DQ3 is 0 when the timer expires, then the 50
+         * us erase timeout has expired so we need to start the timer for the
+         * sector erase algorithm. Otherwise, the erase completed and we should
+         * go back to read array mode.
+         */
+        if ((pfl->status & 0x08) == 0) {
+            assert_dq3(pfl);
+            /*
+             * CFI address 0x21 is "Typical timeout per individual block erase
+             * 2^N ms"
+             */
+            uint64_t timeout = ((1ULL << pfl->cfi_table[0x21]) *
+                                pfl->sectors_to_erase) * 1000000;
+            timer_mod(&pfl->timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
+            DPRINTF("%s: erase timeout fired; erasing %d sectors\n",
+                    __func__, pfl->sectors_to_erase);
+            return;
+        }
+        DPRINTF("%s: sector erase complete\n", __func__);
+        pfl->sectors_to_erase = 0;
+        reset_dq3(pfl);
+    }
+
     /* Reset flash */
     toggle_dq7(pfl);
     if (pfl->bypass) {
@@ -307,13 +349,30 @@ static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
     }
 }
 
+static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
+{
+    uint64_t sector_len = pflash_sector_len(pfl, offset);
+    offset &= ~(sector_len - 1);
+    DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
+            __func__, pfl->bank_width * 2, offset,
+            pfl->bank_width * 2, offset + sector_len - 1);
+    if (!pfl->ro) {
+        uint8_t *p = pfl->storage;
+        memset(p + offset, 0xFF, sector_len);
+        pflash_update(pfl, offset, sector_len);
+    }
+    set_dq7(pfl, 0x00);
+    ++pfl->sectors_to_erase;
+    /* Set (or reset) the 50 us timer for additional erase commands.  */
+    timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
+}
+
 static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                          unsigned int width)
 {
     PFlashCFI02 *pfl = opaque;
     uint8_t *p;
     uint8_t cmd;
-    uint32_t sector_len;
 
     cmd = value;
     if (pfl->cmd != 0xA0) {
@@ -490,20 +549,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             break;
         case 0x30:
             /* Sector erase */
-            p = pfl->storage;
-            sector_len = pflash_sector_len(pfl, offset);
-            offset &= ~(sector_len - 1);
-            DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
-                    __func__, pfl->bank_width * 2, offset,
-                    pfl->bank_width * 2, offset + sector_len - 1);
-            if (!pfl->ro) {
-                memset(p + offset, 0xFF, sector_len);
-                pflash_update(pfl, offset, sector_len);
-            }
-            set_dq7(pfl, 0x00);
-            /* Let's wait 1/2 second before sector erase is done */
-            timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (NANOSECONDS_PER_SECOND / 2));
+            pflash_sector_erase(pfl, offset);
             break;
         default:
             DPRINTF("%s: invalid command %02x (wc 5)\n", __func__, cmd);
@@ -517,7 +563,19 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             /* Ignore writes during chip erase */
             return;
         case 0x30:
-            /* Ignore writes during sector erase */
+            /*
+             * If DQ3 is 0, additional sector erase commands can be
+             * written and anything else (other than an erase suspend) resets
+             * the device.
+             */
+            if ((pfl->status & 0x08) == 0) {
+                if (cmd == 0x30) {
+                    pflash_sector_erase(pfl, offset);
+                } else {
+                    goto reset_flash;
+                }
+            }
+            /* Ignore writes during the actual erase. */
             return;
         default:
             /* Should never happen */
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index c984295167..dad16aaf52 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -37,6 +37,7 @@ typedef struct {
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
 #define UNLOCK1_CMD 0x55
+#define SECOND_UNLOCK_CMD 0x80
 #define AUTOSELECT_CMD 0x90
 #define RESET_CMD 0xF0
 #define PROGRAM_CMD 0xA0
@@ -222,7 +223,7 @@ static void reset(const FlashConfig *c)
 static void sector_erase(const FlashConfig *c, uint64_t byte_addr)
 {
     unlock(c);
-    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
     unlock(c);
     flash_write(c, byte_addr, replicate(c, SECTOR_ERASE_CMD));
 }
@@ -261,7 +262,7 @@ static void program(const FlashConfig *c, uint64_t byte_addr, uint16_t data)
 static void chip_erase(const FlashConfig *c)
 {
     unlock(c);
-    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
     unlock(c);
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
@@ -343,6 +344,7 @@ static void test_geometry(const void *opaque)
     reset(c);
     const uint64_t dq7 = replicate(c, 0x80);
     const uint64_t dq6 = replicate(c, 0x40);
+    const uint64_t dq3 = replicate(c, 0x08);
 
     uint64_t byte_addr = 0;
     for (int region = 0; region < nb_erase_regions; ++region) {
@@ -360,18 +362,29 @@ static void test_geometry(const void *opaque)
         /* Erase and program sector. */
         for (uint32_t i = 0; i < nb_sectors; ++i) {
             sector_erase(c, byte_addr);
-            /* Read toggle. */
+
+            /* Check that DQ3 is 0. */
+            g_assert_cmpint(flash_read(c, byte_addr) & dq3, ==, 0);
+            clock_step_next(); /* Step over the 50 us timeout. */
+
+            /* Check that DQ3 is 1. */
             uint64_t status0 = flash_read(c, byte_addr);
+            g_assert_cmpint(status0 & dq3, ==, dq3);
+
             /* DQ7 is 0 during an erase. */
             g_assert_cmpint(status0 & dq7, ==, 0);
             uint64_t status1 = flash_read(c, byte_addr);
+
             /* DQ6 toggles during an erase. */
             g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+
             /* Wait for erase to complete. */
-            clock_step_next();
+            wait_for_completion(c, byte_addr);
+
             /* Ensure DQ6 has stopped toggling. */
             g_assert_cmpint(flash_read(c, byte_addr), ==,
                             flash_read(c, byte_addr));
+
             /* Now the data should be valid. */
             g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
 
@@ -434,6 +447,44 @@ static void test_geometry(const void *opaque)
     g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
     reset(c);
 
+    /*
+     * Program a word on each sector, erase one or two sectors per region, and
+     * verify that all of those, and only those, are erased.
+     */
+    byte_addr = 0;
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        for (int i = 0; i < config->nb_blocs[region]; ++i) {
+            program(c, byte_addr, 0);
+            byte_addr += config->sector_len[region];
+        }
+    }
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
+    unlock(c);
+    byte_addr = 0;
+    const uint64_t erase_cmd = replicate(c, SECTOR_ERASE_CMD);
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        flash_write(c, byte_addr, erase_cmd);
+        if (c->nb_blocs[region] > 1) {
+            flash_write(c, byte_addr + c->sector_len[region], erase_cmd);
+        }
+        byte_addr += c->sector_len[region] * c->nb_blocs[region];
+    }
+
+    clock_step_next(); /* Step over the 50 us timeout. */
+    wait_for_completion(c, 0);
+    byte_addr = 0;
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        for (int i = 0; i < config->nb_blocs[region]; ++i) {
+            if (i < 2) {
+                g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
+            } else {
+                g_assert_cmpint(flash_read(c, byte_addr), ==, 0);
+            }
+            byte_addr += config->sector_len[region];
+        }
+    }
+
     qtest_quit(global_qtest);
 }
 
-- 
2.20.1 (Apple Git-117)


