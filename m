Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA09C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC49320879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="uapE0Yon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC49320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbTc-0002gb-WC
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:06:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKK-0003nF-4v
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKI-0007iD-5h
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:12 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:50199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKH-0007h3-R6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:10 -0400
Received: by mail-it1-x142.google.com with SMTP id q14so1480166itk.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EuGpHwitFW2M7w/MOUJXqI+ifEHoOddMJKg2HLN0er0=;
	b=uapE0YonspScx6dlLfnPATsdh0uQY/qjQMI5AOB8Kqrfi5kIi5nLVqev0CJTFPU/M+
	kmd2qKs3dIxVePXQvq8L4nwiA9OjbZZ2LBnQc5t9glZJGqaW4PNkQbnEqU8wUhyHaHXs
	H72Ts98wfi+KmXl8FENr1DJW4988LsplwQiO/RoxXL398CrLGAStZUGgJTSlSMSVoMbX
	b8WC1xTTDs0DArH9MyBn/GWTHKnYw2u600vPCghiwt3VscDdieMh1KGsajFNlpbSr55f
	DMF1o5mvx8SJBD9zoVosFc4G2JxMGIkCZwKjl+jR8Zab/fmnfDadRFvF054CTv3MYuFN
	OfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EuGpHwitFW2M7w/MOUJXqI+ifEHoOddMJKg2HLN0er0=;
	b=Dm4nlWIG0rcwH1BofcjKLqd9SKL+GDOL9xFdO2bDqZtJYF5DdKqmANDMwnIiEdsSiO
	VDTG7Tt4NVkFRiIHjC0A8bEcW3zx5dbBiCoGk8SL/iJ0LzxhZ5PmUX98ER+9w3ORbnGR
	ciZsCZ4C+STGfvX66mIZr6NMPDujJB/ZrNmejs0+m7R0MBa4fWbinNwqR9Uca29EXksh
	ctoxFn1ynBwCLUFkj2Npd7v1qAngdFLX9paGafx5InyrGtPgQDSDE5MAE5u8XcIx0W7u
	t6G+QABAnuuusOuxuW8NE64LJK+IFz+xRQdq3ytldbYQSTdcP9tCIZz8M0d4n3A9y5T+
	fyrw==
X-Gm-Message-State: APjAAAU05y/ycE9moIFiNWplRriq1HBbSCbsWwbKku5yUNcP7pCa7pJO
	1V++LsPuOfuzebMLZobvlfLsRPR5Wgh3cw==
X-Google-Smtp-Source: APXvYqztwjGvBW/TWgI6lPD73JOAV79xlv7ezEKoICUscQMiwBDGND6ecjVIr018eEyezoSaZx0nXA==
X-Received: by 2002:a24:2458:: with SMTP id f85mr22430674ita.83.1554757028992; 
	Mon, 08 Apr 2019 13:57:08 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:08 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:45 -0400
Message-Id:
 <f76b0245ccc8625f901e4caeb04446d757d3d19e.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
Subject: [Qemu-devel] [PATCH 02/10] block/pflash_cfi02: Refactor,
 NFC intended
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stephen Checkoway <s@pahtak.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408205545.MUvBiGH7ks0M-QYRYal5gDp04IBjSxfLx6utBe0Jvpw@z>

From: Stephen Checkoway <s@pahtak.org>

Simplify and refactor for upcoming commits. In particular, pull out all
of the code to modify the status into simple helper functions. Status
handling becomes more complex once multiple chips are interleaved to
produce a single device.

No change in functionality is intended with this commit.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 221 +++++++++++++++++-----------------------
 1 file changed, 95 insertions(+), 126 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f2c6201f81..53db3fd09f 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -46,18 +46,19 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 
-//#define PFLASH_DEBUG
-#ifdef PFLASH_DEBUG
+#define PFLASH_DEBUG false
 #define DPRINTF(fmt, ...)                                  \
 do {                                                       \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
+    if (PFLASH_DEBUG) {                                    \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__);   \
+    }                                                      \
 } while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
 
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
 
+/* Special write cycle for CFI queries. */
+#define WCYCLE_CFI 7
+
 struct PFlashCFI02 {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -97,6 +98,31 @@ struct PFlashCFI02 {
     void *storage;
 };
 
+/*
+ * Toggle status bit DQ7.
+ */
+static inline void toggle_dq7(PFlashCFI02 *pfl)
+{
+    pfl->status ^= 0x80;
+}
+
+/*
+ * Set status bit DQ7 to bit 7 of value.
+ */
+static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
+{
+    pfl->status &= 0x7F;
+    pfl->status |= value & 0x80;
+}
+
+/*
+ * Toggle status bit DQ6.
+ */
+static inline void toggle_dq6(PFlashCFI02 *pfl)
+{
+    pfl->status ^= 0x40;
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -126,7 +152,7 @@ static void pflash_timer (void *opaque)
 
     trace_pflash_timer_expired(pfl->cmd);
     /* Reset flash */
-    pfl->status ^= 0x80;
+    toggle_dq7(pfl);
     if (pfl->bypass) {
         pfl->wcycle = 2;
     } else {
@@ -136,12 +162,34 @@ static void pflash_timer (void *opaque)
     pfl->cmd = 0;
 }
 
-static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
-                            int width, int be)
+/*
+ * Read data from flash.
+ */
+static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
+                                 unsigned int width)
 {
+    uint8_t *p = (uint8_t *)pfl->storage + offset;
+    uint64_t ret = pfl->be? ldn_be_p(p, width) : ldn_le_p(p, width);
+    /* XXX: Need a trace_pflash_data_read(offset, ret, width) */
+    switch (width) {
+    case 1:
+        trace_pflash_data_read8(offset, ret);
+        break;
+    case 2:
+        trace_pflash_data_read16(offset, ret);
+        break;
+    case 4:
+        trace_pflash_data_read32(offset, ret);
+        break;
+    }
+    return ret;
+}
+
+static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
+{
+    PFlashCFI02 *pfl = opaque;
     hwaddr boff;
-    uint32_t ret;
-    uint8_t *p;
+    uint64_t ret;
 
     ret = -1;
     trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
@@ -166,39 +214,8 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
     case 0x80:
         /* We accept reads during second unlock sequence... */
     case 0x00:
-    flash_read:
         /* Flash area read */
-        p = pfl->storage;
-        switch (width) {
-        case 1:
-            ret = p[offset];
-            trace_pflash_data_read8(offset, ret);
-            break;
-        case 2:
-            if (be) {
-                ret = p[offset] << 8;
-                ret |= p[offset + 1];
-            } else {
-                ret = p[offset];
-                ret |= p[offset + 1] << 8;
-            }
-            trace_pflash_data_read16(offset, ret);
-            break;
-        case 4:
-            if (be) {
-                ret = p[offset] << 24;
-                ret |= p[offset + 1] << 16;
-                ret |= p[offset + 2] << 8;
-                ret |= p[offset + 3];
-            } else {
-                ret = p[offset];
-                ret |= p[offset + 1] << 8;
-                ret |= p[offset + 2] << 16;
-                ret |= p[offset + 3] << 24;
-            }
-            trace_pflash_data_read32(offset, ret);
-            break;
-        }
+        ret = pflash_data_read(pfl, offset, width);
         break;
     case 0x90:
         /* flash ID read */
@@ -213,23 +230,23 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
         case 0x0E:
         case 0x0F:
             ret = boff & 0x01 ? pfl->ident3 : pfl->ident2;
-            if (ret == (uint8_t)-1) {
-                goto flash_read;
+            if (ret != (uint8_t)-1) {
+                break;
             }
-            break;
+            /* Fall through to data read. */
         default:
-            goto flash_read;
+            ret = pflash_data_read(pfl, offset, width);
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %x\n", __func__, boff, ret);
+        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, boff, ret);
         break;
     case 0xA0:
     case 0x10:
     case 0x30:
         /* Status register read */
         ret = pfl->status;
-        DPRINTF("%s: status %x\n", __func__, ret);
+        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
         /* Toggle bit 6 */
-        pfl->status ^= 0x40;
+        toggle_dq6(pfl);
         break;
     case 0x98:
         /* CFI query mode */
@@ -245,8 +262,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
 }
 
 /* update flash content on disk */
-static void pflash_update(PFlashCFI02 *pfl, int offset,
-                          int size)
+static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
 {
     int offset_end;
     if (pfl->blk) {
@@ -259,9 +275,10 @@ static void pflash_update(PFlashCFI02 *pfl, int offset,
     }
 }
 
-static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
-                         uint32_t value, int width, int be)
+static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned int width)
 {
+    PFlashCFI02 *pfl = opaque;
     hwaddr boff;
     uint8_t *p;
     uint8_t cmd;
@@ -277,7 +294,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
     trace_pflash_write(offset, value, width, pfl->wcycle);
     offset &= pfl->chip_len - 1;
 
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
+    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__,
             offset, value, width);
     boff = offset & (pfl->sector_len - 1);
     if (pfl->width == 2)
@@ -295,7 +312,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
         if (boff == 0x55 && cmd == 0x98) {
         enter_CFI_mode:
             /* Enter CFI query mode */
-            pfl->wcycle = 7;
+            pfl->wcycle = WCYCLE_CFI;
             pfl->cmd = 0x98;
             return;
         }
@@ -345,40 +362,22 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
             goto check_unlock0;
         case 0xA0:
             trace_pflash_data_write(offset, value, width, 0);
-            p = pfl->storage;
             if (!pfl->ro) {
-                switch (width) {
-                case 1:
-                    p[offset] &= value;
-                    pflash_update(pfl, offset, 1);
-                    break;
-                case 2:
-                    if (be) {
-                        p[offset] &= value >> 8;
-                        p[offset + 1] &= value;
-                    } else {
-                        p[offset] &= value;
-                        p[offset + 1] &= value >> 8;
-                    }
-                    pflash_update(pfl, offset, 2);
-                    break;
-                case 4:
-                    if (be) {
-                        p[offset] &= value >> 24;
-                        p[offset + 1] &= value >> 16;
-                        p[offset + 2] &= value >> 8;
-                        p[offset + 3] &= value;
-                    } else {
-                        p[offset] &= value;
-                        p[offset + 1] &= value >> 8;
-                        p[offset + 2] &= value >> 16;
-                        p[offset + 3] &= value >> 24;
-                    }
-                    pflash_update(pfl, offset, 4);
-                    break;
+                p = (uint8_t *)pfl->storage + offset;
+                if (pfl->be) {
+                    uint64_t current = ldn_be_p(p, width);
+                    stn_be_p(p, width, current & value);
+                } else {
+                    uint64_t current = ldn_le_p(p, width);
+                    stn_le_p(p, width, current & value);
                 }
+                pflash_update(pfl, offset, width);
             }
-            pfl->status = 0x00 | ~(value & 0x80);
+            /*
+             * While programming, status bit DQ7 should hold the opposite
+             * value from how it was programmed.
+             */
+            set_dq7(pfl, ~value);
             /* Let's pretend write is immediate */
             if (pfl->bypass)
                 goto do_bypass;
@@ -426,7 +425,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
                 memset(pfl->storage, 0xFF, pfl->chip_len);
                 pflash_update(pfl, 0, pfl->chip_len);
             }
-            pfl->status = 0x00;
+            set_dq7(pfl, 0x00);
             /* Let's wait 5 seconds before chip erase is done */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                       (NANOSECONDS_PER_SECOND * 5));
@@ -441,7 +440,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
                 memset(p + offset, 0xFF, pfl->sector_len);
                 pflash_update(pfl, offset, pfl->sector_len);
             }
-            pfl->status = 0x00;
+            set_dq7(pfl, 0x00);
             /* Let's wait 1/2 second before sector erase is done */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                       (NANOSECONDS_PER_SECOND / 2));
@@ -467,7 +466,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
             goto reset_flash;
         }
         break;
-    case 7: /* Special value for CFI queries */
+    case WCYCLE_CFI: /* Special value for CFI queries */
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
@@ -492,39 +491,9 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
     pfl->cmd = 0;
 }
 
-static uint64_t pflash_be_readfn(void *opaque, hwaddr addr, unsigned size)
-{
-    return pflash_read(opaque, addr, size, 1);
-}
-
-static void pflash_be_writefn(void *opaque, hwaddr addr,
-                              uint64_t value, unsigned size)
-{
-    pflash_write(opaque, addr, value, size, 1);
-}
-
-static uint64_t pflash_le_readfn(void *opaque, hwaddr addr, unsigned size)
-{
-    return pflash_read(opaque, addr, size, 0);
-}
-
-static void pflash_le_writefn(void *opaque, hwaddr addr,
-                              uint64_t value, unsigned size)
-{
-    pflash_write(opaque, addr, value, size, 0);
-}
-
-static const MemoryRegionOps pflash_cfi02_ops_be = {
-    .read = pflash_be_readfn,
-    .write = pflash_be_writefn,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static const MemoryRegionOps pflash_cfi02_ops_le = {
-    .read = pflash_le_readfn,
-    .write = pflash_le_writefn,
+static const MemoryRegionOps pflash_cfi02_ops = {
+    .read = pflash_read,
+    .write = pflash_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
@@ -552,9 +521,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 
     chip_len = pfl->sector_len * pfl->nb_blocs;
 
-    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
-                                  &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
-                                  pfl, pfl->name, chip_len, &local_err);
+    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
+                                  &pflash_cfi02_ops, pfl, pfl->name,
+                                  chip_len, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
-- 
2.20.1 (Apple Git-117)


