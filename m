Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E735C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98D7206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="wBpq5My1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98D7206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3mB-0008Tv-GR
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:32:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gu-00045x-IM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gq-0000v6-QG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:12 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:52294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3gq-0000te-AQ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:08 -0400
Received: by mail-it1-x143.google.com with SMTP id x132so6799259itf.2
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Jv0E8JtBAEhamTwvz2jAbN/sxL4NNiW4E2UIqBfaHx8=;
	b=wBpq5My1YhYS3rJ0tWofNmDhbicWHNc5AS/vjdNRPTRYWCKLQNAxV6bPnqvCX68XhM
	ayOm2dr7yPtP5s6+MGDS6VpTjSPoKg9wSWczTK30UQbIsv9SG8AtLrZLLKgJ6BZtt3q/
	i1KhgoGwNamCizyTiISkFRGr6/vLyltuIvHqh7tYaOk2WrxUG7G7bVXU1E3zOGORxUKK
	tvAVee/SrazSyFWtM4ZnpDaCEK3zb4j1Z2yOMG6NlVAG9q1+cqy5sn/xcYHJH/YpRHiM
	rew3A2sWCSnUJP//AU2rPctrnL0gzSpN0kYOWjvmc4YWwq9BPycyowmYeKL00KvRJ1fx
	k0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Jv0E8JtBAEhamTwvz2jAbN/sxL4NNiW4E2UIqBfaHx8=;
	b=VaThOo121qRNQ7NahDAynQlfVrDqUzL3MszrdGXc2SmVTT/zVP9fWZFQ10LHutpDd4
	6W0YzOnVK4pTsYh1AGKVmSvqUvNApZuLbTQZ4RYSbF2NymVn2VUdhq8YvqevF7VGl4Il
	tpaj+8NLBSSb00fMWFkMM7TazsRXNC6D6VbEzGKKb2g+VTt7kAFuRnhupFEi7TvXMPOF
	BwYb52YI2F1bP++h4V4Nzr6RuIvwl8nX8MKuf5GvAFS7js2x9Wv3AyS5MM54Z78w/RG6
	6uInV6X8SwYXWrvRagGaUvPe6NrWMPHXquM95IOL8AI6V7os0+2+fTjP4xyZI0wk+QoF
	pN8w==
X-Gm-Message-State: APjAAAXT9XdF2vOg1E7F7WB7oxYAyRCnfoT6A5tFQQA0lxo3i6M71zew
	LCgNq8yBfF+dW0KTqxPECnqEJQA3Fhh4nQ==
X-Google-Smtp-Source: APXvYqyVmns6Y0rIN2ceyjdaf/M1qufAhLHybItqCH3h11HCk7AP+tTf5RujeFdBFK65WATr+qrgkQ==
X-Received: by 2002:a24:76d5:: with SMTP id z204mr8736614itb.44.1556296025805; 
	Fri, 26 Apr 2019 09:27:05 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	c7sm7548700ioc.63.2019.04.26.09.27.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 26 Apr 2019 09:27:05 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 12:26:16 -0400
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH v4 02/10] block/pflash_cfi02: Refactor,
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
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426162616.Ce42AD_LMj4NXH9pY0TYmqcGP68RPq-V102nO0BZPBo@z>

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
index f2c6201f81..4b7af71806 100644
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
+    uint64_t ret = pfl->be ? ldn_be_p(p, width) : ldn_le_p(p, width);
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


