Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3943EC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A5720863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="lXPGJDPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A5720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbPj-00082J-U2
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:02:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKP-0003t5-NX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKL-0007p2-90
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:17 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:38274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKK-0007np-VV
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:13 -0400
Received: by mail-it1-x143.google.com with SMTP id f22so1454066ita.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=5xFWaZlIMrCaNd1NGPN7f74UMfbQtZEmv6DU2mNjAqo=;
	b=lXPGJDPVet399QzEV5xzO/Rju1wWMEA9+HQsZlsh3FZvPB3sMVLQkP0Dkl1sGGqJwc
	aLhJ9Qpuj6++jmCWP9Z8l6cQbI4X/UuJUOMhzybV0AEGFaiYGCiElM5ARwQE6COYkF+L
	q6XeBXZ62EeJXQI4s/mzhU6j0jUKoGjaTY7Hczm/6fdCO2a4uKUdUUCjsw7kPvPl7ftC
	NoUmEAXxcRJSRI3YYgBy2wiLjgF7X33qwxELuT1c2RDanj58cat4rzmohn+InLw60ILq
	kkJErS+TIMG9B4AIQkUe3sEjdvCah3Y8h6c5BIcFX4caEFZL7LlNwVDa7zsrjQfddhfN
	IS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5xFWaZlIMrCaNd1NGPN7f74UMfbQtZEmv6DU2mNjAqo=;
	b=lEgjKAdrblyR2d8sURTr/cDj/0CyhkrEfPUuJ1MBZgqY/7/UaTCiGQJ/Eek1sgaA9r
	3icB/sRO7Ao1PgankvILsIy2Pa1COSA9hzvhn5qed8UerB+2/bXx9INuEZZ/afgVSIyG
	VXMDl/fOO8qsu9e8C1N4KUJklFUK9C7gKC/WUIm3MhaetPPHZYEP4wbNb5HgL0EBy76j
	sj27c1HlfyE+WAsQ+/LpPdjVI3USAT3Ox0wvG6iBC7wqmpd757esutshGtcmaq24ZCoo
	aN9NuyYiaU3AmxpRHZHubwgm0/jSZp2x6VcxScqSmHb4dYBqAQo6Y8doebDZ1auzu4Ck
	AQNw==
X-Gm-Message-State: APjAAAUlkSWZkj1rwisMGtINxc0y3Mp+51kiK3BjwQd0g4zpDQg7e+I+
	+Yy7SSJZqYrYb6GkyS9gUvdgIV6JhcGz2MA1
X-Google-Smtp-Source: APXvYqwRMV7+k0XAFSdMbjvjvfGkutlnnFtZ6nACTtZ1z1OvApMEa86mCWzVXcgj5obHjqkP2KoxnQ==
X-Received: by 2002:a24:65c8:: with SMTP id
	u191mr22293143itb.137.1554757031531; 
	Mon, 08 Apr 2019 13:57:11 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:10 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:47 -0400
Message-Id:
 <bd133a194d554f74ee0f8768c6634928adf089af.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH 04/10] block/pflash_cfi02: Implement
 intereleaved flash devices
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
Message-ID: <20190408205547.xW9QonNqE-UIWyEAmrZrE1AZYVPdGVbjVLvFN_c5_mU@z>

It's common for multiple narrow flash chips to be hooked up in parallel
to support wider buses. For example, four 8-bit wide flash chips (x8)
may be combined in parallel to produce a 32-bit wide device. Similarly,
two 16-bit wide chips (x16) may be combined.

This commit introduces `device-width` and `max-device-width` properties,
similar to pflash_cfi01, with the following meanings:
- `width`: The width of the logical, qemu device (same as before);
- `device-width`: The width of an individual flash chip, defaulting to
  `width`; and
- `max-device-width`: The maximum width of an individual flash chip,
  defaulting to `device-width`.

Nothing needs to change to support reading such interleaved devices but
commands (e.g., erase and programming) must be sent to all devices at
the same time or else the various chips will be in different states.

For example, a 4-byte wide logical device can be composed of four x8/x16
devices in x8 mode. That is, each device supports both x8 or x16 and
they're being used in the byte, rather than word, mode. This
configuration would have `width=4`, `device-width=1`, and
`max-device-width=2`.

In addition to commands being sent to all devices, guest firmware
expects the status and CFI queries to be replicated for each device.
(The one exception to the response replication is that each device gets
to report its own status bit DQ7 while programming because its value
depends on the value being programmed which will usually differ for each
device.)

Testing is limited to 16-bit wide devices due to the current inability
to override the properties set by `pflash_cfi02_register`, but multiple
configurations are tested.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   | 270 +++++++++++++++++-------
 tests/pflash-cfi02-test.c | 419 +++++++++++++++++++++++++++++---------
 2 files changed, 526 insertions(+), 163 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index cb102739d6..c7e568d6e0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -28,7 +28,6 @@
  * - unlock bypass command
  * - CFI queries
  *
- * It does not support flash interleaving.
  * It does not implement boot blocs with reduced size
  * It does not implement software data protection as found in many real chips
  * It does not implement erase suspend/resume commands
@@ -67,15 +66,19 @@ struct PFlashCFI02 {
     BlockBackend *blk;
     uint32_t sector_len;
     uint32_t nb_blocs;
-    uint32_t chip_len;
+    uint64_t total_len;
+    uint64_t interleave_multiplier;
     uint8_t mappings;
-    uint8_t width;
+    uint8_t bank_width; /* Width of the QEMU device in bytes. */
+    uint8_t device_width; /* Width of individual pflash chip. */
+    uint8_t max_device_width; /* Maximum width of individual pflash chip. */
     uint8_t be;
+    int device_shift; /* Amount to shift an offset to get a device address. */
     int wcycle; /* if 0, the flash is read normally */
     int bypass;
     int ro;
     uint8_t cmd;
-    uint8_t status;
+    uint64_t status;
     /* FIXME: implement array device properties */
     uint16_t ident0;
     uint16_t ident1;
@@ -103,16 +106,17 @@ struct PFlashCFI02 {
  */
 static inline void toggle_dq7(PFlashCFI02 *pfl)
 {
-    pfl->status ^= 0x80;
+    pfl->status ^= pfl->interleave_multiplier * 0x80;
 }
 
 /*
  * Set status bit DQ7 to bit 7 of value.
  */
-static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
+static inline void set_dq7(PFlashCFI02 *pfl, uint64_t value)
 {
-    pfl->status &= 0x7F;
-    pfl->status |= value & 0x80;
+    uint64_t mask = pfl->interleave_multiplier * 0x80;
+    pfl->status &= ~mask;
+    pfl->status |= value & mask;
 }
 
 /*
@@ -120,7 +124,7 @@ static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
  */
 static inline void toggle_dq6(PFlashCFI02 *pfl)
 {
-    pfl->status ^= 0x40;
+    pfl->status ^= pfl->interleave_multiplier * 0x40;
 }
 
 /*
@@ -188,7 +192,6 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
 static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
 {
     PFlashCFI02 *pfl = opaque;
-    hwaddr boff;
     uint64_t ret;
 
     ret = -1;
@@ -198,12 +201,10 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
         pflash_register_memory(pfl, 1);
     }
-    offset &= pfl->chip_len - 1;
-    boff = offset & 0xFF;
-    if (pfl->width == 2)
-        boff = boff >> 1;
-    else if (pfl->width == 4)
-        boff = boff >> 2;
+    /* Mask by the total length of the chip to account for alias mappings. */
+    offset &= pfl->total_len - 1;
+    hwaddr device_addr = offset >> pfl->device_shift;
+
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read*/
@@ -215,29 +216,32 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         /* We accept reads during second unlock sequence... */
     case 0x00:
         /* Flash area read */
-        ret = pflash_data_read(pfl, offset, width);
-        break;
+        return pflash_data_read(pfl, offset, width);
     case 0x90:
         /* flash ID read */
-        switch (boff) {
+        switch (device_addr & 0xFF) {
         case 0x00:
+            ret = pfl->ident0;
+            break;
         case 0x01:
-            ret = boff & 0x01 ? pfl->ident1 : pfl->ident0;
+            ret = pfl->ident1;
             break;
         case 0x02:
             ret = 0x00; /* Pretend all sectors are unprotected */
             break;
         case 0x0E:
         case 0x0F:
-            ret = boff & 0x01 ? pfl->ident3 : pfl->ident2;
+            ret = device_addr & 0x01 ? pfl->ident3 : pfl->ident2;
             if (ret != (uint8_t)-1) {
                 break;
             }
             /* Fall through to data read. */
         default:
-            ret = pflash_data_read(pfl, offset, width);
+            return pflash_data_read(pfl, offset, width);
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, boff, ret);
+        ret *= pfl->interleave_multiplier;
+        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n",
+                __func__, device_addr & 0xFF, ret);
         break;
     case 0xA0:
     case 0x10:
@@ -250,8 +254,8 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         break;
     case 0x98:
         /* CFI query mode */
-        if (boff < sizeof(pfl->cfi_table)) {
-            ret = pfl->cfi_table[boff];
+        if (device_addr < sizeof(pfl->cfi_table)) {
+            ret = pfl->interleave_multiplier * pfl->cfi_table[device_addr];
         } else {
             ret = 0;
         }
@@ -279,30 +283,40 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                          unsigned int width)
 {
     PFlashCFI02 *pfl = opaque;
-    hwaddr boff;
     uint8_t *p;
     uint8_t cmd;
 
     cmd = value;
-    if (pfl->cmd != 0xA0 && cmd == 0xF0) {
+    if (pfl->cmd != 0xA0) {
+        if (value != pfl->interleave_multiplier * cmd) {
+            DPRINTF("%s: cmd 0x%02x not sent to all devices: expected="
+                    "0x%0*" PRIx64 " actual=0x%0*" PRIx64 "\n",
+                    __func__, cmd,
+                    pfl->bank_width * 2, pfl->interleave_multiplier * cmd,
+                    pfl->bank_width * 2, value);
+        }
+
+        if (cmd == 0xF0) {
 #if 0
-        DPRINTF("%s: flash reset asked (%02x %02x)\n",
-                __func__, pfl->cmd, cmd);
+            DPRINTF("%s: flash reset asked (%02x %02x)\n",
+                    __func__, pfl->cmd, cmd);
 #endif
-        goto reset_flash;
+            goto reset_flash;
+        }
     }
+
     trace_pflash_write(offset, value, width, pfl->wcycle);
-    offset &= pfl->chip_len - 1;
-
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__,
-            offset, value, width);
-    boff = offset;
-    if (pfl->width == 2)
-        boff = boff >> 1;
-    else if (pfl->width == 4)
-        boff = boff >> 2;
-    /* Only the least-significant 11 bits are used in most cases. */
-    boff &= 0x7FF;
+
+    /* Mask by the total length of the chip to account for alias mappings. */
+    offset &= pfl->total_len - 1;
+
+    DPRINTF("%s: offset " TARGET_FMT_plx " 0x%0*" PRIx64 "\n",
+            __func__, offset, width * 2, value);
+
+    hwaddr device_addr = (offset >> pfl->device_shift);
+    /* Address bits A11 and greater are don't cares for most commands. */
+    unsigned int masked_addr = device_addr & 0x7FF;
+
     switch (pfl->wcycle) {
     case 0:
         /* Set the device in I/O access mode if required */
@@ -311,16 +325,16 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         pfl->read_counter = 0;
         /* We're in read mode */
     check_unlock0:
-        if (boff == 0x55 && cmd == 0x98) {
+        if (masked_addr == 0x55 && cmd == 0x98) {
         enter_CFI_mode:
             /* Enter CFI query mode */
             pfl->wcycle = WCYCLE_CFI;
             pfl->cmd = 0x98;
             return;
         }
-        if (boff != pfl->unlock_addr0 || cmd != 0xAA) {
-            DPRINTF("%s: unlock0 failed " TARGET_FMT_plx " %02x %04x\n",
-                    __func__, boff, cmd, pfl->unlock_addr0);
+        if (masked_addr != pfl->unlock_addr0 || cmd != 0xAA) {
+            DPRINTF("%s: unlock0 failed %04x %02x %04x\n",
+                    __func__, masked_addr, cmd, pfl->unlock_addr0);
             goto reset_flash;
         }
         DPRINTF("%s: unlock sequence started\n", __func__);
@@ -328,18 +342,18 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
     case 1:
         /* We started an unlock sequence */
     check_unlock1:
-        if (boff != pfl->unlock_addr1 || cmd != 0x55) {
-            DPRINTF("%s: unlock1 failed " TARGET_FMT_plx " %02x\n", __func__,
-                    boff, cmd);
+        if (masked_addr != pfl->unlock_addr1 || cmd != 0x55) {
+            DPRINTF("%s: unlock1 failed %03x %02x\n", __func__,
+                    masked_addr, cmd);
             goto reset_flash;
         }
         DPRINTF("%s: unlock sequence done\n", __func__);
         break;
     case 2:
         /* We finished an unlock sequence */
-        if (!pfl->bypass && boff != pfl->unlock_addr0) {
-            DPRINTF("%s: command failed " TARGET_FMT_plx " %02x\n", __func__,
-                    boff, cmd);
+        if (!pfl->bypass && masked_addr != pfl->unlock_addr0) {
+            DPRINTF("%s: command failed %03x %02x\n", __func__,
+                    masked_addr, cmd);
             goto reset_flash;
         }
         switch (cmd) {
@@ -390,8 +404,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 goto reset_flash;
             }
             /* We can enter CFI query mode from autoselect mode */
-            if (boff == 0x55 && cmd == 0x98)
+            if (masked_addr == 0x55 && cmd == 0x98) {
                 goto enter_CFI_mode;
+            }
             /* No break here */
         default:
             DPRINTF("%s: invalid write for command %02x\n",
@@ -416,7 +431,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
     case 5:
         switch (cmd) {
         case 0x10:
-            if (boff != pfl->unlock_addr0) {
+            if (masked_addr != pfl->unlock_addr0) {
                 DPRINTF("%s: chip erase: invalid address " TARGET_FMT_plx "\n",
                         __func__, offset);
                 goto reset_flash;
@@ -424,8 +439,8 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             /* Chip erase */
             DPRINTF("%s: start chip erase\n", __func__);
             if (!pfl->ro) {
-                memset(pfl->storage, 0xFF, pfl->chip_len);
-                pflash_update(pfl, 0, pfl->chip_len);
+                memset(pfl->storage, 0xFF, pfl->total_len);
+                pflash_update(pfl, 0, pfl->total_len);
             }
             set_dq7(pfl, 0x00);
             /* Let's wait 5 seconds before chip erase is done */
@@ -521,22 +536,132 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (pfl->bank_width == 0) {
+        error_setg(errp, "attribute \"width\" not specified or zero.");
+        return;
+    }
+
+    /*
+     * device-width defaults to width and max-device-width defaults to
+     * device-width. Check that the device-width and max-device-width
+     * configurations are supported.
+     */
+    if (pfl->device_width == 0) {
+        pfl->device_width = pfl->bank_width;
+    }
+    if (pfl->max_device_width == 0) {
+        pfl->max_device_width = pfl->device_width;
+    }
+    if (pfl->bank_width % pfl->device_width != 0) {
+        error_setg(errp,
+                   "attribute \"width\" (%u) not a multiple of attribute "
+                   "\"device-width\" (%u).",
+                   pfl->bank_width, pfl->device_width);
+        return;
+    }
+
+    /*
+     * Writing commands to the flash device and reading CFI responses or
+     * status values requires transforming a QEMU device offset into a
+     * flash device address given in terms of the device's maximum width. We
+     * can do this by shifting a QEMU device offset right a constant number of
+     * bits depending on the bank_width, device_width, and max_device_width.
+     *
+     * num_devices = bank_width / device_width is the number of interleaved
+     * flash devices. To compute a device byte address, we need to divide
+     * offset by num_devices (equivalently shift right by log2(num_devices)).
+     * To turn a device byte address into a device word address, we need to
+     * divide by max_device_width (equivalently shift right by
+     * log2(max_device_width)).
+     *
+     * In tabular form.
+     * ==================================================================
+     * bank_width   device_width    max_device_width    num_devices shift
+     * ------------------------------------------------------------------
+     * 1            1               1                   1           0
+     * 1            1               2                   1           1
+     * 2            1               1                   2           1
+     * 2            1               2                   2           2
+     * 2            2               2                   1           1
+     * 4            1               1                   4           2
+     * 4            1               2                   4           3
+     * 4            1               4                   4           4
+     * 4            2               2                   2           2
+     * 4            2               4                   2           3
+     * 4            4               4                   1           2
+     * ==================================================================
+     */
+    pfl->device_shift = ctz32(pfl->bank_width) - ctz32(pfl->device_width) +
+                        ctz32(pfl->max_device_width);
+    pfl->interleave_multiplier = 0;
+    for (unsigned int shift = 0; shift < pfl->bank_width;
+         shift += pfl->device_width) {
+        pfl->interleave_multiplier |= 1 << (shift * 8);
+    }
+
+    uint16_t device_interface_code;
+    if (pfl->max_device_width == 1 && pfl->device_width == 1) {
+        device_interface_code = 0; /* x8 only. */
+    } else if (pfl->max_device_width == 2 &&
+               (pfl->device_width == 1 || pfl->device_width == 2)) {
+        /* XXX: Some devices only support x16, this code doesn't model them. */
+        device_interface_code = 2; /* Supports x8 or x16. */
+    } else if (pfl->max_device_width == 4 && pfl->device_width == 1) {
+        /*
+         * XXX: this is x32-only. The standards I've seen don't specify a value
+         * for x8/x32 but do mention them.
+         */
+        device_interface_code = 3; /* x32 only. */
+    } else if (pfl->max_device_width == 4 &&
+               (pfl->device_width == 2 || pfl->device_width == 4)) {
+        device_interface_code = 4; /* Supports x16 or x32. */
+    } else {
+        error_setg(errp,
+                   "unsupported configuration: \"device-width\"=%u "
+                   "\"max-device-width\"=%u.",
+                   pfl->device_width, pfl->max_device_width);
+        return;
+    }
+
+    pfl->total_len = pfl->sector_len * pfl->nb_blocs;
+
+    /*
+     * If the flash is not a power of 2, then the code for handling multiple
+     * mappings will not work correctly.
+     */
+    if (!is_power_of_2(pfl->total_len)) {
+        error_setg(errp, "total pflash length (%" PRIx64 ") not a power of 2.",
+                   pfl->total_len);
+        return;
+    }
+
+    int num_devices = pfl->bank_width / pfl->device_width;
+    uint64_t sector_len_per_device = pfl->sector_len / num_devices;
+    uint64_t device_len = sector_len_per_device * pfl->nb_blocs;
+
+    if (sector_len_per_device & 0xff || sector_len_per_device >= (1 << 24)) {
+        error_setg(errp,
+                   "unsupported configuration: sector length per device = "
+                   "%" PRIx64 ".",
+                   sector_len_per_device);
+        return;
+    }
+
+    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
+                                  &pflash_cfi02_ops, pfl, pfl->name,
+                                  pfl->total_len, &local_err);
     /* Only 11 bits are used in the comparison. */
     pfl->unlock_addr0 &= 0x7FF;
     pfl->unlock_addr1 &= 0x7FF;
 
     chip_len = pfl->sector_len * pfl->nb_blocs;
 
-    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
-                                  &pflash_cfi02_ops, pfl, pfl->name,
-                                  chip_len, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
     pfl->storage = memory_region_get_ram_ptr(&pfl->orig_mem);
-    pfl->chip_len = chip_len;
 
     if (pfl->blk) {
         uint64_t perm;
@@ -566,6 +691,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->wcycle = 0;
     pfl->cmd = 0;
     pfl->status = 0;
+
     /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] = 'Q';
@@ -591,8 +717,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->cfi_table[0x1D] = 0x00;
     /* Vpp max (no Vpp pin) */
     pfl->cfi_table[0x1E] = 0x00;
-    /* Reserved */
-    pfl->cfi_table[0x1F] = 0x07;
+    /* Timeout per single byte/word write (16 us) */
+    pfl->cfi_table[0x1F] = 0x04;
     /* Timeout for min size buffer write (NA) */
     pfl->cfi_table[0x20] = 0x00;
     /* Typical timeout for block erase (512 ms) */
@@ -608,13 +734,13 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     /* Max timeout for chip erase */
     pfl->cfi_table[0x26] = 0x0D;
     /* Device size */
-    pfl->cfi_table[0x27] = ctz32(chip_len);
-    /* Flash device interface (8 & 16 bits) */
-    pfl->cfi_table[0x28] = 0x02;
-    pfl->cfi_table[0x29] = 0x00;
+    pfl->cfi_table[0x27] = ctz32(device_len);
+    /* Flash device interface  */
+    pfl->cfi_table[0x28] = device_interface_code;
+    pfl->cfi_table[0x29] = device_interface_code >> 8;
     /* Max number of bytes in multi-bytes write */
     /* XXX: disable buffered write as it's not supported */
-    //    pfl->cfi_table[0x2A] = 0x05;
+    /*    pfl->cfi_table[0x2A] = 0x05; */
     pfl->cfi_table[0x2A] = 0x00;
     pfl->cfi_table[0x2B] = 0x00;
     /* Number of erase block regions (uniform) */
@@ -622,8 +748,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     /* Erase block region 1 */
     pfl->cfi_table[0x2D] = pfl->nb_blocs - 1;
     pfl->cfi_table[0x2E] = (pfl->nb_blocs - 1) >> 8;
-    pfl->cfi_table[0x2F] = pfl->sector_len >> 8;
-    pfl->cfi_table[0x30] = pfl->sector_len >> 16;
+    pfl->cfi_table[0x2F] = sector_len_per_device >> 8;
+    pfl->cfi_table[0x30] = sector_len_per_device >> 16;
 
     /* Extended */
     pfl->cfi_table[0x31] = 'P';
@@ -648,7 +774,9 @@ static Property pflash_cfi02_properties[] = {
     DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
     DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
     DEFINE_PROP_UINT32("sector-length", PFlashCFI02, sector_len, 0),
-    DEFINE_PROP_UINT8("width", PFlashCFI02, width, 0),
+    DEFINE_PROP_UINT8("width", PFlashCFI02, bank_width, 0),
+    DEFINE_PROP_UINT8("device-width", PFlashCFI02, device_width, 0),
+    DEFINE_PROP_UINT8("max-device-width", PFlashCFI02, max_device_width, 0),
     DEFINE_PROP_UINT8("mappings", PFlashCFI02, mappings, 0),
     DEFINE_PROP_UINT8("big-endian", PFlashCFI02, be, 0),
     DEFINE_PROP_UINT16("id0", PFlashCFI02, ident0, 0),
@@ -696,7 +824,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    hwaddr size,
                                    BlockBackend *blk,
                                    uint32_t sector_len,
-                                   int nb_mappings, int width,
+                                   int nb_mappings, int bank_width,
                                    uint16_t id0, uint16_t id1,
                                    uint16_t id2, uint16_t id3,
                                    uint16_t unlock_addr0,
@@ -711,7 +839,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     assert(size % sector_len == 0);
     qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
     qdev_prop_set_uint32(dev, "sector-length", sector_len);
-    qdev_prop_set_uint8(dev, "width", width);
+    qdev_prop_set_uint8(dev, "width", bank_width);
     qdev_prop_set_uint8(dev, "mappings", nb_mappings);
     qdev_prop_set_uint8(dev, "big-endian", !!be);
     qdev_prop_set_uint16(dev, "id0", id0);
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 57484c1585..0b996d871c 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -21,10 +21,15 @@
 #define MP_FLASH_SIZE_MAX (32*1024*1024)
 #define BASE_ADDR (0x100000000ULL-MP_FLASH_SIZE_MAX)
 
-#define FLASH_WIDTH 2
-#define CFI_ADDR (FLASH_WIDTH*0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH*0x555)
-#define UNLOCK1_ADDR (FLASH_WIDTH*0x2AA)
+/* Use a newtype to keep flash addresses separate from byte addresses. */
+typedef struct {
+    uint64_t addr;
+} faddr;
+#define FLASH_ADDR(x) ((faddr) { .addr = (x) })
+
+#define CFI_ADDR FLASH_ADDR(0x55)
+#define UNLOCK0_ADDR FLASH_ADDR(0x555)
+#define UNLOCK1_ADDR FLASH_ADDR(0x2AA)
 
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -37,167 +42,332 @@
 #define UNLOCK_BYPASS_CMD 0x20
 #define UNLOCK_BYPASS_RESET_CMD 0x00
 
+typedef struct {
+    int bank_width;
+    int device_width;
+    int max_device_width;
+} FlashConfig;
+
 static char image_path[] = "/tmp/qtest.XXXXXX";
 
-static inline void flash_write(uint64_t byte_addr, uint16_t data)
+/*
+ * The pflash implementation allows some parameters to be unspecified. We want
+ * to test those configurations but we also need to know the real values in
+ * our testing code. So after we launch qemu, we'll need a new FlashConfig
+ * with the correct values filled in.
+ */
+static FlashConfig expand_config_defaults(const FlashConfig *c)
 {
-    qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
+    FlashConfig ret = *c;
+
+    if (ret.device_width == 0) {
+        ret.device_width = ret.bank_width;
+    }
+    if (ret.max_device_width == 0) {
+        ret.max_device_width = ret.device_width;
+    }
+    return ret;
+}
+
+/*
+ * Return a bit mask suitable for extracting the least significant
+ * status/query response from an interleaved response.
+ */
+static inline uint64_t device_mask(const FlashConfig *c)
+{
+    if (c->device_width == 8) {
+        return (uint64_t)-1;
+    }
+    return (1ULL << (c->device_width * 8)) - 1ULL;
+}
+
+/*
+ * Return a bit mask exactly as long as the bank_width.
+ */
+static inline uint64_t bank_mask(const FlashConfig *c)
+{
+    if (c->bank_width == 8) {
+        return (uint64_t)-1;
+    }
+    return (1ULL << (c->bank_width * 8)) - 1ULL;
+}
+
+static inline void flash_write(const FlashConfig *c, uint64_t byte_addr,
+                               uint64_t data)
+{
+    /* Sanity check our tests. */
+    assert((data & ~bank_mask(c)) == 0);
+    uint64_t addr = BASE_ADDR + byte_addr;
+    switch (c->bank_width) {
+    case 1:
+        qtest_writeb(global_qtest, addr, data);
+        break;
+    case 2:
+        qtest_writew(global_qtest, addr, data);
+        break;
+    case 4:
+        qtest_writel(global_qtest, addr, data);
+        break;
+    case 8:
+        qtest_writeq(global_qtest, addr, data);
+        break;
+    default:
+        abort();
+    }
+}
+
+static inline uint64_t flash_read(const FlashConfig *c, uint64_t byte_addr)
+{
+    uint64_t addr = BASE_ADDR + byte_addr;
+    switch (c->bank_width) {
+    case 1:
+        return qtest_readb(global_qtest, addr);
+    case 2:
+        return qtest_readw(global_qtest, addr);
+    case 4:
+        return qtest_readl(global_qtest, addr);
+    case 8:
+        return qtest_readq(global_qtest, addr);
+    default:
+        abort();
+    }
+}
+
+/*
+ * Convert a flash address expressed in the maximum width of the device as a
+ * byte address.
+ */
+static inline uint64_t as_byte_addr(const FlashConfig *c, faddr flash_addr)
+{
+    /*
+     * Command addresses are always given as addresses in the maximum
+     * supported bus size for the flash chip. So an x8/x16 chip in x8 mode
+     * uses addresses 0xAAA and 0x555 to unlock because the least significant
+     * bit is ignored. (0x555 rather than 0x554 is traditional.)
+     *
+     * Interleaving flash chips use the least significant bits of a byte
+     * address to refer to data from the individual chips. Two interleaved x8
+     * devices would use command addresses 0xAAA and 0x554. Two interleaved
+     * x16 devices would use 0x1554 and 0xAA8.
+     *
+     * More exotic configurations are possible. Two interleaved x8/x16 devices
+     * in x8 mode would also use 0x1554 and 0xAA8.
+     *
+     * In general we need to multiply an address by the number of devices,
+     * which is bank_width / device_width, and multiply that by the maximum
+     * device width.
+     */
+    int num_devices = c->bank_width / c->device_width;
+    return flash_addr.addr * (num_devices * c->max_device_width);
+}
+
+/*
+ * Return the command value or expected status replicated across all devices.
+ */
+static inline uint64_t replicate(const FlashConfig *c, uint64_t data)
+{
+    /* Sanity check our tests. */
+    assert((data & ~device_mask(c)) == 0);
+    for (int i = c->device_width; i < c->bank_width; i += c->device_width) {
+        data |= data << (c->device_width * 8);
+    }
+    return data;
+}
+
+static inline void flash_cmd(const FlashConfig *c, faddr cmd_addr,
+                             uint8_t cmd)
+{
+    flash_write(c, as_byte_addr(c, cmd_addr), replicate(c, cmd));
+}
+
+static inline uint64_t flash_query(const FlashConfig *c, faddr query_addr)
+{
+    return flash_read(c, as_byte_addr(c, query_addr));
 }
 
-static inline uint16_t flash_read(uint64_t byte_addr)
+static inline uint64_t flash_query_1(const FlashConfig *c, faddr query_addr)
 {
-    return qtest_readw(global_qtest, BASE_ADDR + byte_addr);
+    return flash_query(c, query_addr) & device_mask(c);
 }
 
-static void unlock(void)
+static void unlock(const FlashConfig *c)
 {
-    flash_write(UNLOCK0_ADDR, UNLOCK0_CMD);
-    flash_write(UNLOCK1_ADDR, UNLOCK1_CMD);
+    flash_cmd(c, UNLOCK0_ADDR, UNLOCK0_CMD);
+    flash_cmd(c, UNLOCK1_ADDR, UNLOCK1_CMD);
 }
 
-static void reset(void)
+static void reset(const FlashConfig *c)
 {
-    flash_write(0, RESET_CMD);
+    flash_cmd(c, FLASH_ADDR(0), RESET_CMD);
 }
 
-static void sector_erase(uint64_t byte_addr)
+static void sector_erase(const FlashConfig *c, uint64_t byte_addr)
 {
-    unlock();
-    flash_write(UNLOCK0_ADDR, 0x80);
-    unlock();
-    flash_write(byte_addr, SECTOR_ERASE_CMD);
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    unlock(c);
+    flash_write(c, byte_addr, replicate(c, SECTOR_ERASE_CMD));
 }
 
-static void wait_for_completion(uint64_t byte_addr)
+static void wait_for_completion(const FlashConfig *c, uint64_t byte_addr)
 {
     /* If DQ6 is toggling, step the clock and ensure the toggle stops. */
-    if ((flash_read(byte_addr) & 0x40) ^ (flash_read(byte_addr) & 0x40)) {
+    const uint64_t dq6 = replicate(c, 0x40);
+    if ((flash_read(c, byte_addr) & dq6) ^ (flash_read(c, byte_addr) & dq6)) {
         /* Wait for erase or program to finish. */
         clock_step_next();
         /* Ensure that DQ6 has stopped toggling. */
-        g_assert_cmpint(flash_read(byte_addr), ==, flash_read(byte_addr));
+        g_assert_cmpint(flash_read(c, byte_addr), ==, flash_read(c, byte_addr));
     }
 }
 
-static void bypass_program(uint64_t byte_addr, uint16_t data)
+static void bypass_program(const FlashConfig *c, uint64_t byte_addr,
+                           uint16_t data)
 {
-    flash_write(UNLOCK0_ADDR, PROGRAM_CMD);
-    flash_write(byte_addr, data);
+    flash_cmd(c, UNLOCK0_ADDR, PROGRAM_CMD);
+    flash_write(c, byte_addr, data);
     /*
      * Data isn't valid until DQ6 stops toggling. We don't model this as
      * writes are immediate, but if this changes in the future, we can wait
      * until the program is complete.
      */
-    wait_for_completion(byte_addr);
+    wait_for_completion(c, byte_addr);
 }
 
-static void program(uint64_t byte_addr, uint16_t data)
+static void program(const FlashConfig *c, uint64_t byte_addr, uint16_t data)
 {
-    unlock();
-    bypass_program(byte_addr, data);
+    unlock(c);
+    bypass_program(c, byte_addr, data);
 }
 
-static void chip_erase(void)
+static void chip_erase(const FlashConfig *c)
 {
-    unlock();
-    flash_write(UNLOCK0_ADDR, 0x80);
-    unlock();
-    flash_write(UNLOCK0_ADDR, SECTOR_ERASE_CMD);
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
 
-static void test_flash(void)
+static void test_flash(const void *opaque)
 {
-    global_qtest = qtest_initf("-M musicpal,accel=qtest "
-                               "-drive if=pflash,file=%s,format=raw,copy-on-read",
-                               image_path);
+    const FlashConfig *config = opaque;
+    global_qtest = qtest_initf("-M musicpal,accel=qtest"
+                               " -drive if=pflash,file=%s,format=raw,"
+                               "copy-on-read"
+                               " -global driver=cfi.pflash02,"
+                               "property=device-width,value=%d"
+                               " -global driver=cfi.pflash02,"
+                               "property=max-device-width,value=%d",
+                               image_path,
+                               config->device_width,
+                               config->max_device_width);
+
+    const FlashConfig explicit_config = expand_config_defaults(config);
+    const FlashConfig *c = &explicit_config;
+
     /* Check the IDs. */
-    unlock();
-    flash_write(UNLOCK0_ADDR, AUTOSELECT_CMD);
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0000), ==, 0x00BF);
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0001), ==, 0x236D);
-    reset();
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+    if (c->device_width >= 2) {
+        /*
+         * XXX: The ID returned by the musicpal flash chip is 16 bits which
+         * wouldn't happen with an 8-bit device. It would probably be best to
+         * prohibit addresses larger than the device width in pflash_cfi02.c,
+         * but then we couldn't test smaller device widths at all.
+         */
+        g_assert_cmpint(flash_query(c, FLASH_ADDR(1)), ==,
+                        replicate(c, 0x236D));
+    }
+    reset(c);
 
     /* Check the erase blocks. */
-    flash_write(CFI_ADDR, CFI_CMD);
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x10), ==, 'Q');
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x11), ==, 'R');
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x12), ==, 'Y');
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x2C), >=, 1); /* Num erase regions. */
-    uint32_t nb_sectors = flash_read(FLASH_WIDTH*0x2D) +
-                          (flash_read(FLASH_WIDTH*0x2E) << 8) + 1;
-    uint32_t sector_len = (flash_read(FLASH_WIDTH*0x2F) << 8) +
-                          (flash_read(FLASH_WIDTH*0x30) << 16);
-    reset();
+    flash_cmd(c, CFI_ADDR, CFI_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x10)), ==, replicate(c, 'Q'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), ==, replicate(c, 'R'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), ==, replicate(c, 'Y'));
+    /* Num erase regions. */
+    g_assert_cmpint(flash_query_1(c, FLASH_ADDR(0x2C)), >=, 1);
+    uint32_t nb_sectors = flash_query_1(c, FLASH_ADDR(0x2D)) +
+                          (flash_query_1(c, FLASH_ADDR(0x2E)) << 8) + 1;
+    uint32_t sector_len = (flash_query_1(c, FLASH_ADDR(0x2F)) << 8) +
+                          (flash_query_1(c, FLASH_ADDR(0x30)) << 16);
+    reset(c);
 
+    const uint64_t dq7 = replicate(c, 0x80);
+    const uint64_t dq6 = replicate(c, 0x40);
     /* Erase and program sector. */
     for (uint32_t i = 0; i < nb_sectors; ++i) {
         uint64_t byte_addr = i * sector_len;
-        sector_erase(byte_addr);
+        sector_erase(c, byte_addr);
         /* Read toggle. */
-        uint16_t status0 = flash_read(byte_addr);
+        uint64_t status0 = flash_read(c, byte_addr);
         /* DQ7 is 0 during an erase. */
-        g_assert_cmpint(status0 & 0x80, ==, 0);
-        uint16_t status1 = flash_read(byte_addr);
+        g_assert_cmpint(status0 & dq7, ==, 0);
+        uint64_t status1 = flash_read(c, byte_addr);
         /* DQ6 toggles during an erase. */
-        g_assert_cmpint(status0 & 0x40, !=, status1 & 0x40);
+        g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
         /* Wait for erase to complete. */
         clock_step_next();
         /* Ensure DQ6 has stopped toggling. */
-        g_assert_cmpint(flash_read(byte_addr), ==, flash_read(byte_addr));
+        g_assert_cmpint(flash_read(c, byte_addr), ==, flash_read(c, byte_addr));
         /* Now the data should be valid. */
-        g_assert_cmpint(flash_read(byte_addr), ==, 0xFFFF);
+        g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
 
         /* Program a bit pattern. */
-        program(byte_addr, 0x5555);
-        g_assert_cmpint(flash_read(byte_addr), ==, 0x5555);
-        program(byte_addr, 0xAA55);
-        g_assert_cmpint(flash_read(byte_addr), ==, 0x0055);
+        program(c, byte_addr, 0x55);
+        g_assert_cmpint(flash_read(c, byte_addr) & 0xFF, ==, 0x55);
+        program(c, byte_addr, 0xA5);
+        g_assert_cmpint(flash_read(c, byte_addr) & 0xFF, ==, 0x05);
     }
 
     /* Erase the chip. */
-    chip_erase();
+    chip_erase(c);
     /* Read toggle. */
-    uint16_t status0 = flash_read(0);
+    uint64_t status0 = flash_read(c, 0);
     /* DQ7 is 0 during an erase. */
-    g_assert_cmpint(status0 & 0x80, ==, 0);
-    uint16_t status1 = flash_read(0);
+    g_assert_cmpint(status0 & dq7, ==, 0);
+    uint64_t status1 = flash_read(c, 0);
     /* DQ6 toggles during an erase. */
-    g_assert_cmpint(status0 & 0x40, !=, status1 & 0x40);
+    g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
     /* Wait for erase to complete. */
     clock_step_next();
     /* Ensure DQ6 has stopped toggling. */
-    g_assert_cmpint(flash_read(0), ==, flash_read(0));
+    g_assert_cmpint(flash_read(c, 0), ==, flash_read(c, 0));
     /* Now the data should be valid. */
-    g_assert_cmpint(flash_read(0), ==, 0xFFFF);
+
+    for (uint32_t i = 0; i < nb_sectors; ++i) {
+        uint64_t byte_addr = i * sector_len;
+        g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
+    }
 
     /* Unlock bypass */
-    unlock();
-    flash_write(UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
-    bypass_program(0, 0x0123);
-    bypass_program(2, 0x4567);
-    bypass_program(4, 0x89AB);
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
+    bypass_program(c, 0 * c->bank_width, 0x01);
+    bypass_program(c, 1 * c->bank_width, 0x23);
+    bypass_program(c, 2 * c->bank_width, 0x45);
     /*
      * Test that bypass programming, unlike normal programming can use any
      * address for the PROGRAM_CMD.
      */
-    flash_write(6, PROGRAM_CMD);
-    flash_write(6, 0xCDEF);
-    wait_for_completion(6);
-    flash_write(0, UNLOCK_BYPASS_RESET_CMD);
-    bypass_program(8, 0x55AA); /* Should fail. */
-    g_assert_cmpint(flash_read(0), ==, 0x0123);
-    g_assert_cmpint(flash_read(2), ==, 0x4567);
-    g_assert_cmpint(flash_read(4), ==, 0x89AB);
-    g_assert_cmpint(flash_read(6), ==, 0xCDEF);
-    g_assert_cmpint(flash_read(8), ==, 0xFFFF);
+    flash_cmd(c, FLASH_ADDR(3 * c->bank_width), PROGRAM_CMD);
+    flash_write(c, 3 * c->bank_width, 0x67);
+    wait_for_completion(c, 3 * c->bank_width);
+    flash_cmd(c, FLASH_ADDR(0), UNLOCK_BYPASS_RESET_CMD);
+    bypass_program(c, 4 * c->bank_width, 0x89); /* Should fail. */
+    g_assert_cmpint(flash_read(c, 0 * c->bank_width), ==, 0x01);
+    g_assert_cmpint(flash_read(c, 1 * c->bank_width), ==, 0x23);
+    g_assert_cmpint(flash_read(c, 2 * c->bank_width), ==, 0x45);
+    g_assert_cmpint(flash_read(c, 3 * c->bank_width), ==, 0x67);
+    g_assert_cmpint(flash_read(c, 4 * c->bank_width), ==, bank_mask(c));
 
     /* Test ignored high order bits of address. */
-    flash_write(FLASH_WIDTH*0x5555, UNLOCK0_CMD);
-    flash_write(FLASH_WIDTH*0x2AAA, UNLOCK1_CMD);
-    flash_write(FLASH_WIDTH*0x5555, AUTOSELECT_CMD);
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0000), ==, 0x00BF);
-    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0001), ==, 0x236D);
-    reset();
+    flash_cmd(c, FLASH_ADDR(0x5555), UNLOCK0_CMD);
+    flash_cmd(c, FLASH_ADDR(0x2AAA), UNLOCK1_CMD);
+    flash_cmd(c, FLASH_ADDR(0x5555), AUTOSELECT_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+    reset(c);
 
     qtest_quit(global_qtest);
 }
@@ -207,6 +377,61 @@ static void cleanup(void *opaque)
     unlink(image_path);
 }
 
+/*
+ * XXX: Tests are limited to bank_width = 2 for now because that's what
+ * hw/arm/musicpal.c has.
+ */
+static const FlashConfig configuration[] = {
+    /* One x16 device. */
+    {
+        .bank_width = 2,
+        .device_width = 2,
+        .max_device_width = 2,
+    },
+    /* Implicitly one x16 device. */
+    {
+        .bank_width = 2,
+        .device_width = 0,
+        .max_device_width = 0,
+    },
+    /* Implicitly one x16 device. */
+    {
+        .bank_width = 2,
+        .device_width = 2,
+        .max_device_width = 0,
+    },
+    /* Interleave two x8 devices. */
+    {
+        .bank_width = 2,
+        .device_width = 1,
+        .max_device_width = 1,
+    },
+    /* Interleave two implicit x8 devices. */
+    {
+        .bank_width = 2,
+        .device_width = 1,
+        .max_device_width = 0,
+    },
+    /* Interleave two x8/x16 devices in x8 mode. */
+    {
+        .bank_width = 2,
+        .device_width = 1,
+        .max_device_width = 2,
+    },
+    /* One x16/x32 device in x16 mode. */
+    {
+        .bank_width = 2,
+        .device_width = 2,
+        .max_device_width = 4,
+    },
+    /* Two x8/x32 devices in x8 mode; I am not sure if such devices exist. */
+    {
+        .bank_width = 2,
+        .device_width = 1,
+        .max_device_width = 4,
+    },
+};
+
 int main(int argc, char **argv)
 {
     int fd = mkstemp(image_path);
@@ -223,7 +448,17 @@ int main(int argc, char **argv)
 
     qtest_add_abrt_handler(cleanup, NULL);
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("pflash-cfi02", test_flash);
+
+    size_t nb_configurations = sizeof configuration / sizeof configuration[0];
+    for (size_t i = 0; i < nb_configurations; ++i) {
+        const FlashConfig *config = &configuration[i];
+        char *path = g_strdup_printf("pflash-cfi02/%d-%d-%d",
+                                     config->bank_width,
+                                     config->device_width,
+                                     config->max_device_width);
+        qtest_add_data_func(path, config, test_flash);
+        g_free(path);
+    }
     int result = g_test_run();
     cleanup(NULL);
     return result;
-- 
2.20.1 (Apple Git-117)


