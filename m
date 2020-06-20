Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3D1246B6
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3D1246B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkj3-0003kk-Of
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmkfR-0005OK-U1
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:04:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:54116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmkfO-0001mc-Q8
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:04:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A94AE748DD1;
 Sat, 20 Jun 2020 23:04:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DF0B9748DDD; Sat, 20 Jun 2020 23:04:32 +0200 (CEST)
Message-Id: <caf97bf0c84a440896ddf020e84c312fa5c15076.1592686588.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592686588.git.balaton@eik.bme.hu>
References: <cover.1592686588.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 8/9] sm501: Convert debug printfs to traces
Date: Sat, 20 Jun 2020 22:56:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 17:04:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c      | 50 +++++++++++------------------------------
 hw/display/trace-events | 12 ++++++++++
 2 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 7e4c042d52..2db347dcbc 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -39,15 +39,7 @@
 #include "qemu/range.h"
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
-
-/*#define DEBUG_SM501*/
-/*#define DEBUG_BITBLT*/
-
-#ifdef DEBUG_SM501
-#define SM501_DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define SM501_DPRINTF(fmt, ...) do {} while (0)
-#endif
+#include "trace.h"
 
 #define MMIO_BASE_OFFSET 0x3e00000
 #define MMIO_SIZE 0x200000
@@ -871,7 +863,6 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
 {
     SM501State *s = (SM501State *)opaque;
     uint32_t ret = 0;
-    SM501_DPRINTF("sm501 system config regs : read addr=%x\n", (int)addr);
 
     switch (addr) {
     case SM501_SYSTEM_CONTROL:
@@ -923,7 +914,7 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP, "sm501: not implemented system config"
                       "register read. addr=%" HWADDR_PRIx "\n", addr);
     }
-
+    trace_sm501_system_config_read(addr, ret);
     return ret;
 }
 
@@ -931,9 +922,8 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
                                       uint64_t value, unsigned size)
 {
     SM501State *s = (SM501State *)opaque;
-    SM501_DPRINTF("sm501 system config regs : write addr=%x, val=%x\n",
-                  (uint32_t)addr, (uint32_t)value);
 
+    trace_sm501_system_config_write((uint32_t)addr, (uint32_t)value);
     switch (addr) {
     case SM501_SYSTEM_CONTROL:
         s->system_control &= 0x10DB0000;
@@ -1019,9 +1009,7 @@ static uint64_t sm501_i2c_read(void *opaque, hwaddr addr, unsigned size)
         qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register read."
                       " addr=0x%" HWADDR_PRIx "\n", addr);
     }
-
-    SM501_DPRINTF("sm501 i2c regs : read addr=%" HWADDR_PRIx " val=%x\n",
-                  addr, ret);
+    trace_sm501_i2c_read((uint32_t)addr, ret);
     return ret;
 }
 
@@ -1029,9 +1017,8 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
                             unsigned size)
 {
     SM501State *s = (SM501State *)opaque;
-    SM501_DPRINTF("sm501 i2c regs : write addr=%" HWADDR_PRIx
-                  " val=%" PRIx64 "\n", addr, value);
 
+    trace_sm501_i2c_write((uint32_t)addr, (uint32_t)value);
     switch (addr) {
     case SM501_I2C_BYTE_COUNT:
         s->i2c_byte_count = value & 0xf;
@@ -1045,25 +1032,19 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
                 s->i2c_status |= (res ? SM501_I2C_STATUS_ERROR : 0);
                 if (!res) {
                     int i;
-                    SM501_DPRINTF("sm501 i2c : transferring %d bytes to 0x%x\n",
-                                  s->i2c_byte_count + 1, s->i2c_addr >> 1);
                     for (i = 0; i <= s->i2c_byte_count; i++) {
                         res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
                                             !(s->i2c_addr & 1));
                         if (res) {
-                            SM501_DPRINTF("sm501 i2c : transfer failed"
-                                          " i=%d, res=%d\n", i, res);
                             s->i2c_status |= SM501_I2C_STATUS_ERROR;
                             return;
                         }
                     }
                     if (i) {
-                        SM501_DPRINTF("sm501 i2c : transferred %d bytes\n", i);
                         s->i2c_status = SM501_I2C_STATUS_COMPLETE;
                     }
                 }
             } else {
-                SM501_DPRINTF("sm501 i2c : end transfer\n");
                 i2c_end_transfer(s->i2c_bus);
                 s->i2c_status &= ~SM501_I2C_STATUS_ERROR;
             }
@@ -1103,7 +1084,8 @@ static const MemoryRegionOps sm501_i2c_ops = {
 static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
 {
     SM501State *s = (SM501State *)opaque;
-    SM501_DPRINTF("sm501 palette read addr=%x\n", (int)addr);
+
+    trace_sm501_palette_read((uint32_t)addr);
 
     /* TODO : consider BYTE/WORD access */
     /* TODO : consider endian */
@@ -1116,8 +1098,8 @@ static void sm501_palette_write(void *opaque, hwaddr addr,
                                 uint32_t value)
 {
     SM501State *s = (SM501State *)opaque;
-    SM501_DPRINTF("sm501 palette write addr=%x, val=%x\n",
-                  (int)addr, value);
+
+    trace_sm501_palette_write((uint32_t)addr, value);
 
     /* TODO : consider BYTE/WORD access */
     /* TODO : consider endian */
@@ -1132,7 +1114,6 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
 {
     SM501State *s = (SM501State *)opaque;
     uint32_t ret = 0;
-    SM501_DPRINTF("sm501 disp ctrl regs : read addr=%x\n", (int)addr);
 
     switch (addr) {
 
@@ -1237,7 +1218,7 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP, "sm501: not implemented disp ctrl register "
                       "read. addr=%" HWADDR_PRIx "\n", addr);
     }
-
+    trace_sm501_disp_ctrl_read((uint32_t)addr, ret);
     return ret;
 }
 
@@ -1245,9 +1226,8 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
                                   uint64_t value, unsigned size)
 {
     SM501State *s = (SM501State *)opaque;
-    SM501_DPRINTF("sm501 disp ctrl regs : write addr=%x, val=%x\n",
-                  (unsigned)addr, (unsigned)value);
 
+    trace_sm501_disp_ctrl_write((uint32_t)addr, (uint32_t)value);
     switch (addr) {
     case SM501_DC_PANEL_CONTROL:
         s->dc_panel_control = value & 0x0FFF73FF;
@@ -1392,7 +1372,6 @@ static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
 {
     SM501State *s = (SM501State *)opaque;
     uint32_t ret = 0;
-    SM501_DPRINTF("sm501 2d engine regs : read addr=%x\n", (int)addr);
 
     switch (addr) {
     case SM501_2D_SOURCE:
@@ -1462,7 +1441,7 @@ static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP, "sm501: not implemented disp ctrl register "
                       "read. addr=%" HWADDR_PRIx "\n", addr);
     }
-
+    trace_sm501_2d_engine_read((uint32_t)addr, ret);
     return ret;
 }
 
@@ -1470,9 +1449,8 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
                                   uint64_t value, unsigned size)
 {
     SM501State *s = (SM501State *)opaque;
-    SM501_DPRINTF("sm501 2d engine regs : write addr=%x, val=%x\n",
-                  (unsigned)addr, (unsigned)value);
 
+    trace_sm501_2d_engine_write((uint32_t)addr, (uint32_t)value);
     switch (addr) {
     case SM501_2D_SOURCE:
         s->twoD_source = value;
@@ -1830,8 +1808,6 @@ static void sm501_init(SM501State *s, DeviceState *dev,
                        uint32_t local_mem_bytes)
 {
     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
-    SM501_DPRINTF("sm501 local mem size=%x. index=%d\n", get_local_mem_size(s),
-                  s->local_mem_size_index);
 
     /* local memory */
     memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 72d4c9812c..970d6bac5d 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -161,3 +161,15 @@ cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"PRIx32"
 # dpcd.c
 dpcd_read(uint32_t addr, uint8_t val) "read addr:0x%"PRIx32" val:0x%02x"
 dpcd_write(uint32_t addr, uint8_t val) "write addr:0x%"PRIx32" val:0x%02x"
+
+# sm501.c
+sm501_system_config_read(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_system_config_write(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_i2c_read(uint32_t addr, uint8_t val) "addr=0x%x, val=0x%x"
+sm501_i2c_write(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_palette_read(uint32_t addr) "addr=0x%x"
+sm501_palette_write(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_disp_ctrl_read(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_disp_ctrl_write(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_2d_engine_read(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
+sm501_2d_engine_write(uint32_t addr, uint32_t val) "addr=0x%x, val=0x%x"
-- 
2.21.3


