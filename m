Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD61C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D62206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axYov1R8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D62206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoRK-00054E-4V
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFa-0007Xp-5X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFY-0007ea-2W
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFX-0007dS-RD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:16 -0500
Received: by mail-wr1-x42a.google.com with SMTP id b6so6755346wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aPucyTu35BZg4N9KmO26YmX+t5sHuLkag3CqvOlVE04=;
 b=axYov1R8/NI+yKHDH1XvqKiMeiD5024DedaqZnjUxVk/w6A46Butd6sIJRA1ybno64
 Y3Jn5U0RK78wAdRsrWKMVXsCR+KVvpmTaiJjIZFfJj29Qe2p7QHIk6QBuai/DzrWdCJ2
 EL/cM9qGWZCzJ1zY54DnyZcbvio7MXnT24uTt537snhleb5R/IYPSff+40Bx1cmscNTQ
 XI4ySZxgGZNl6kcwOurQHKelmvcpU8p3gQDeULtFZBPGIIK4UcvHkiZO2WwuFMlNnVpg
 kZMmxa1DDk+/xrId/c3rLstf6EDLtaM6L9mFb34Nvhx52uW4NSHIUTMjUfOMx6wQe42W
 Aj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aPucyTu35BZg4N9KmO26YmX+t5sHuLkag3CqvOlVE04=;
 b=bPFo0BIOlqa7r8X+yJjt9ln5CAl66JCogLNWQewJw58twgdca5FdxcwJXOgWZ3xC7o
 WRZ9tu+UevHTkhU3PbR3FKoh+uGi1y/RO137P9tJsDbtuP8c0KONSduoq4SWyb0xSkeH
 vR1/JEgEFga/nqTxyhFs9+Hc3+cHefPxjEEHUJhQSIFYiFiTxciX/89FRS4osd88EEfI
 1qO5y2cvTFXbucjElTEVOdeeXx10/5ZD8OI9cZVQVHAjGPgl+/zm4dE6O5/tGnKprQD8
 BFzGW2QLRT67F4KNtgZi/1HWv0lwXlIGrSU3Bhz1iIdM/F3EGSXCTDqrGqzN32iQigfe
 4wJg==
X-Gm-Message-State: APjAAAU1NxfoXKUd10FAzpg75ndiBfHaBDfJyOz4gS8tlLhHPLGriIo8
 xFhB4ssXrGEqaTGv6uT1TaPcMj3GtcPajw==
X-Google-Smtp-Source: APXvYqw2mOlJmnjUB+2W5nfW7/Ii3nJfCv7F7udgZO9tNN8ksMQujK8bsPcZs0d337cKEpaIXTH9YQ==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr31221339wrr.265.1576494554552; 
 Mon, 16 Dec 2019 03:09:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] aspeed/i2c: Add support for DMA transfers
Date: Mon, 16 Dec 2019 11:08:36 +0000
Message-Id: <20191216110904.30815-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The I2C controller of the Aspeed AST2500 and AST2600 SoCs supports DMA
transfers to and from DRAM.

A pair of registers defines the buffer address and the length of the
DMA transfer. The address should be aligned on 4 bytes and the maximum
length should not exceed 4K. The receive or transmit DMA transfer can
then be initiated with specific bits in the Command/Status register of
the controller.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-5-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/aspeed_i2c.h |   5 ++
 hw/arm/aspeed_ast2600.c     |   5 ++
 hw/arm/aspeed_soc.c         |   5 ++
 hw/i2c/aspeed_i2c.c         | 126 +++++++++++++++++++++++++++++++++++-
 4 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 7a555072dfb..f1b9e5bf91e 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -52,6 +52,8 @@ typedef struct AspeedI2CBus {
     uint32_t cmd;
     uint32_t buf;
     uint32_t pool_ctrl;
+    uint32_t dma_addr;
+    uint32_t dma_len;
 } AspeedI2CBus;
 
 typedef struct AspeedI2CState {
@@ -66,6 +68,8 @@ typedef struct AspeedI2CState {
     uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
 
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
+    MemoryRegion *dram_mr;
+    AddressSpace dram_as;
 } AspeedI2CState;
 
 #define ASPEED_I2C_CLASS(klass) \
@@ -85,6 +89,7 @@ typedef struct AspeedI2CClass {
     hwaddr pool_base;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
     bool check_sram;
+    bool has_dma;
 
 } AspeedI2CClass;
 
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a403c2aae06..0881eb25983 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -343,6 +343,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index dd1ee0e3336..b01c9774419 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -311,6 +311,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index c7929aa2850..030d9c56be6 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -23,8 +23,11 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 
 /* I2C Global Register */
 
@@ -138,7 +141,8 @@
 #define   I2CD_BYTE_BUF_TX_MASK            0xff
 #define   I2CD_BYTE_BUF_RX_SHIFT           8
 #define   I2CD_BYTE_BUF_RX_MASK            0xff
-
+#define I2CD_DMA_ADDR           0x24       /* DMA Buffer Address */
+#define I2CD_DMA_LEN            0x28       /* DMA Transfer Length < 4KB */
 
 static inline bool aspeed_i2c_bus_is_master(AspeedI2CBus *bus)
 {
@@ -165,6 +169,7 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
     AspeedI2CBus *bus = opaque;
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
 
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
@@ -183,6 +188,18 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwaddr offset,
         return bus->buf;
     case I2CD_CMD_REG:
         return bus->cmd | (i2c_bus_busy(bus->bus) << 16);
+    case I2CD_DMA_ADDR:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
+            return -1;
+        }
+        return bus->dma_addr;
+    case I2CD_DMA_LEN:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
+            return -1;
+        }
+        return bus->dma_len;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
@@ -201,6 +218,24 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
     return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
 }
 
+static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
+{
+    MemTxResult result;
+    AspeedI2CState *s = bus->controller;
+
+    result = address_space_read(&s->dram_as, bus->dma_addr,
+                                MEMTXATTRS_UNSPECIFIED, data, 1);
+    if (result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed @%08x\n",
+                      __func__, bus->dma_addr);
+        return -1;
+    }
+
+    bus->dma_addr++;
+    bus->dma_len--;
+    return 0;
+}
+
 static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
@@ -217,6 +252,16 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
             }
         }
         bus->cmd &= ~I2CD_TX_BUFF_ENABLE;
+    } else if (bus->cmd & I2CD_TX_DMA_ENABLE) {
+        while (bus->dma_len) {
+            uint8_t data;
+            aspeed_i2c_dma_read(bus, &data);
+            ret = i2c_send(bus->bus, data);
+            if (ret) {
+                break;
+            }
+        }
+        bus->cmd &= ~I2CD_TX_DMA_ENABLE;
     } else {
         ret = i2c_send(bus->bus, bus->buf);
     }
@@ -242,6 +287,24 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         bus->pool_ctrl &= ~(0xff << 24);
         bus->pool_ctrl |= (i & 0xff) << 24;
         bus->cmd &= ~I2CD_RX_BUFF_ENABLE;
+    } else if (bus->cmd & I2CD_RX_DMA_ENABLE) {
+        uint8_t data;
+
+        while (bus->dma_len) {
+            MemTxResult result;
+
+            data = i2c_recv(bus->bus);
+            result = address_space_write(&s->dram_as, bus->dma_addr,
+                                         MEMTXATTRS_UNSPECIFIED, &data, 1);
+            if (result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM write failed @%08x\n",
+                              __func__, bus->dma_addr);
+                return;
+            }
+            bus->dma_addr++;
+            bus->dma_len--;
+        }
+        bus->cmd &= ~I2CD_RX_DMA_ENABLE;
     } else {
         data = i2c_recv(bus->bus);
         bus->buf = (data & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
@@ -268,6 +331,11 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)
         uint8_t *pool_base = aic->bus_pool_base(bus);
 
         return pool_base[0];
+    } else if (bus->cmd & I2CD_TX_DMA_ENABLE) {
+        uint8_t data;
+
+        aspeed_i2c_dma_read(bus, &data);
+        return data;
     } else {
         return bus->buf;
     }
@@ -344,6 +412,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
                  */
                 pool_start++;
             }
+        } else if (bus->cmd & I2CD_TX_DMA_ENABLE) {
+            if (bus->dma_len == 0) {
+                bus->cmd &= ~I2CD_M_TX_CMD;
+            }
         } else {
             bus->cmd &= ~I2CD_M_TX_CMD;
         }
@@ -447,9 +519,35 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
             break;
         }
 
+        if (!aic->has_dma &&
+            value & (I2CD_RX_DMA_ENABLE | I2CD_TX_DMA_ENABLE)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
+            break;
+        }
+
         aspeed_i2c_bus_handle_cmd(bus, value);
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
+    case I2CD_DMA_ADDR:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
+            break;
+        }
+
+        bus->dma_addr = value & 0xfffffffc;
+        break;
+
+    case I2CD_DMA_LEN:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
+            break;
+        }
+
+        bus->dma_len = value & 0xfff;
+        if (!bus->dma_len) {
+            qemu_log_mask(LOG_UNIMP, "%s: invalid DMA length\n",  __func__);
+        }
+        break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
@@ -542,8 +640,8 @@ static const MemoryRegionOps aspeed_i2c_pool_ops = {
 
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(id, AspeedI2CBus),
         VMSTATE_UINT32(ctrl, AspeedI2CBus),
@@ -553,6 +651,8 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
         VMSTATE_UINT32(cmd, AspeedI2CBus),
         VMSTATE_UINT32(buf, AspeedI2CBus),
         VMSTATE_UINT32(pool_ctrl, AspeedI2CBus),
+        VMSTATE_UINT32(dma_addr, AspeedI2CBus),
+        VMSTATE_UINT32(dma_len, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -584,6 +684,8 @@ static void aspeed_i2c_reset(DeviceState *dev)
         s->busses[i].intr_status = 0;
         s->busses[i].cmd = 0;
         s->busses[i].buf = 0;
+        s->busses[i].dma_addr = 0;
+        s->busses[i].dma_len = 0;
         i2c_end_transfer(s->busses[i].bus);
     }
 }
@@ -640,14 +742,30 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->pool_iomem, OBJECT(s), &aspeed_i2c_pool_ops, s,
                           "aspeed.i2c-pool", aic->pool_size);
     memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iomem);
+
+    if (aic->has_dma) {
+        if (!s->dram_mr) {
+            error_setg(errp, TYPE_ASPEED_I2C ": 'dram' link not set");
+            return;
+        }
+
+        address_space_init(&s->dram_as, s->dram_mr, "dma-dram");
+    }
 }
 
+static Property aspeed_i2c_properties[] = {
+    DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &aspeed_i2c_vmstate;
     dc->reset = aspeed_i2c_reset;
+    dc->props = aspeed_i2c_properties;
     dc->realize = aspeed_i2c_realize;
     dc->desc = "Aspeed I2C Controller";
 }
@@ -721,6 +839,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
     aic->pool_base = 0x200;
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->check_sram = true;
+    aic->has_dma = true;
 }
 
 static const TypeInfo aspeed_2500_i2c_info = {
@@ -753,6 +872,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
     aic->pool_size = 0x200;
     aic->pool_base = 0xC00;
     aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
+    aic->has_dma = true;
 }
 
 static const TypeInfo aspeed_2600_i2c_info = {
-- 
2.20.1


