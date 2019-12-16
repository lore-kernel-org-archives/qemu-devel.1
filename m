Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94AEC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B65206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAvOZsW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B65206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoXw-0006z0-2n
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFZ-0007Wg-HZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFX-0007dO-8v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFX-0007a8-18
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id b72so4200149wme.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oNLgQ7/WJxX1ZKmY5Vt3oSTTDEYqnkdhsC8/NLTg2u4=;
 b=nAvOZsW/ASe8CvNJ0LmwLT/YRXsbGLALWX4+vO7GGjz+VrGtStxf89dlH8wa12rWEG
 crbZiCV7mSmiTjK7oF3BLvgZF78EJlb7n7pVdeoQ/4HBegVmNKJrqxSnWbH7m8O0SPN8
 KDZIF53aKbHDS4U8VQF0Zwuokq69mHNJUDUb7QsDXTVYeY4VdpVhg2NZEriCdBYso8nE
 3OJ3f1tx02/qPKtGGkB5+Hq+9RNBFsabLvcyg3VawPWMvXhCV5TXYm1ZsDC52GLGabww
 mTdsxKxy0GraANOalN5K1Ab026NTMZjwLGBFkU+tkvRgpR/uKlpSyEeYVF6N0yaXDJv3
 ypMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oNLgQ7/WJxX1ZKmY5Vt3oSTTDEYqnkdhsC8/NLTg2u4=;
 b=LU7kAXWdAssb3Uh8zvG+2271yTPgCtbuQV7VHkdvdJ1Fi7MQoTlwJ4eMaqu0WRrY1d
 pIHpJ7vZB7/FhvQdMiHBz04yPcZXa1RloB0NXd8NFmjs36CBtZcXejZMXbEStn1UKvCz
 0kK8AnAjss0Fq71grKaiPmK/XaKw/ULTA3DGYaeeSn2WTky3pmELB4+AzPcDItLOHZZb
 vog2hUXq9bRAg2kbg5KT44zMqZ7lzHOkyHcdRLA0x+FOg5Q1VpEeykKVyyKxZwXYsm1z
 WzTkAQkfuLhtPHnEOZPhCAXLt+DCyuOsNnSHjvoQOxKOzflnx7NV13YGdjwB0LKM0fD5
 w0rg==
X-Gm-Message-State: APjAAAXvCL2KOIJ/dV+d+28//4sQfbCc/2TL+gi3Sw4WbA1XBB/6B95Q
 FNeOv9U3gsceQ9dPdguvbOUyocHuxTXWQg==
X-Google-Smtp-Source: APXvYqxc6ha9ps4vqtw6RzAllJBpIa7FJz9E/fyh6Qq3dTb90bShrFgpPLzjcKSqrXleyqaxdHSmRw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr29980939wmc.21.1576494550963; 
 Mon, 16 Dec 2019 03:09:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/34] aspeed/i2c: Add support for pool buffer transfers
Date: Mon, 16 Dec 2019 11:08:33 +0000
Message-Id: <20191216110904.30815-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

The Aspeed I2C controller can operate in different transfer modes :

  - Byte Buffer mode, using a dedicated register to transfer a
    byte. This is what the model supports today.

  - Pool Buffer mode, using an internal SRAM to transfer multiple
    bytes in the same command sequence.

Each SoC has different SRAM characteristics. On the AST2400, 2048
bytes of SRAM are available at offset 0x800 of the controller AHB
window. The pool buffer can be configured from 1 to 256 bytes per bus.

On the AST2500, the SRAM is at offset 0x200 and the pool buffer is of
16 bytes per bus.

On the AST2600, the SRAM is at offset 0xC00 and the pool buffer is of
32 bytes per bus. It can be splitted in two for TX and RX but the
current model does not add support for it as it it unused by known
drivers.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-2-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/aspeed_i2c.h |   8 ++
 hw/i2c/aspeed_i2c.c         | 197 ++++++++++++++++++++++++++++++++----
 2 files changed, 186 insertions(+), 19 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 13e01059189..5313d07aa72 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -32,6 +32,7 @@
     OBJECT_CHECK(AspeedI2CState, (obj), TYPE_ASPEED_I2C)
 
 #define ASPEED_I2C_NR_BUSSES 16
+#define ASPEED_I2C_MAX_POOL_SIZE 0x800
 
 struct AspeedI2CState;
 
@@ -50,6 +51,7 @@ typedef struct AspeedI2CBus {
     uint32_t intr_status;
     uint32_t cmd;
     uint32_t buf;
+    uint32_t pool_ctrl;
 } AspeedI2CBus;
 
 typedef struct AspeedI2CState {
@@ -59,6 +61,8 @@ typedef struct AspeedI2CState {
     qemu_irq irq;
 
     uint32_t intr_status;
+    MemoryRegion pool_iomem;
+    uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
 
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
 } AspeedI2CState;
@@ -75,6 +79,10 @@ typedef struct AspeedI2CClass {
     uint8_t reg_size;
     uint8_t gap;
     qemu_irq (*bus_get_irq)(AspeedI2CBus *);
+
+    uint64_t pool_size;
+    hwaddr pool_base;
+    uint8_t *(*bus_pool_base)(AspeedI2CBus *);
 } AspeedI2CClass;
 
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 06c119f385b..e21f45d9686 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -35,8 +35,7 @@
 /* I2C Device (Bus) Register */
 
 #define I2CD_FUN_CTRL_REG       0x00       /* I2CD Function Control  */
-#define   I2CD_BUFF_SEL_MASK               (0x7 << 20)
-#define   I2CD_BUFF_SEL(x)                 (x << 20)
+#define   I2CD_POOL_PAGE_SEL(x)            (((x) >> 20) & 0x7)  /* AST2400 */
 #define   I2CD_M_SDA_LOCK_EN               (0x1 << 16)
 #define   I2CD_MULTI_MASTER_DIS            (0x1 << 15)
 #define   I2CD_M_SCL_DRIVE_EN              (0x1 << 14)
@@ -113,10 +112,12 @@
 #define   I2CD_SCL_O_OUT_DIR               (0x1 << 12)
 #define   I2CD_BUS_RECOVER_CMD_EN          (0x1 << 11)
 #define   I2CD_S_ALT_EN                    (0x1 << 10)
-#define   I2CD_RX_DMA_ENABLE               (0x1 << 9)
-#define   I2CD_TX_DMA_ENABLE               (0x1 << 8)
 
 /* Command Bit */
+#define   I2CD_RX_DMA_ENABLE               (0x1 << 9)
+#define   I2CD_TX_DMA_ENABLE               (0x1 << 8)
+#define   I2CD_RX_BUFF_ENABLE              (0x1 << 7)
+#define   I2CD_TX_BUFF_ENABLE              (0x1 << 6)
 #define   I2CD_M_STOP_CMD                  (0x1 << 5)
 #define   I2CD_M_S_RX_CMD_LAST             (0x1 << 4)
 #define   I2CD_M_RX_CMD                    (0x1 << 3)
@@ -125,7 +126,11 @@
 #define   I2CD_M_START_CMD                 (0x1)
 
 #define I2CD_DEV_ADDR_REG       0x18       /* Slave Device Address */
-#define I2CD_BUF_CTRL_REG       0x1c       /* Pool Buffer Control */
+#define I2CD_POOL_CTRL_REG      0x1c       /* Pool Buffer Control */
+#define   I2CD_POOL_RX_COUNT(x)            (((x) >> 24) & 0xff)
+#define   I2CD_POOL_RX_SIZE(x)             ((((x) >> 16) & 0xff) + 1)
+#define   I2CD_POOL_TX_COUNT(x)            ((((x) >> 8) & 0xff) + 1)
+#define   I2CD_POOL_OFFSET(x)              (((x) & 0x3f) << 2)  /* AST2400 */
 #define I2CD_BYTE_BUF_REG       0x20       /* Transmit/Receive Byte Buffer */
 #define   I2CD_BYTE_BUF_TX_SHIFT           0
 #define   I2CD_BYTE_BUF_TX_MASK            0xff
@@ -170,6 +175,8 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwaddr offset,
         return bus->intr_ctrl;
     case I2CD_INTR_STS_REG:
         return bus->intr_status;
+    case I2CD_POOL_CTRL_REG:
+        return bus->pool_ctrl;
     case I2CD_BYTE_BUF_REG:
         return bus->buf;
     case I2CD_CMD_REG:
@@ -192,14 +199,58 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
     return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
 }
 
+static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    int ret = -1;
+    int i;
+
+    if (bus->cmd & I2CD_TX_BUFF_ENABLE) {
+        for (i = pool_start; i < I2CD_POOL_TX_COUNT(bus->pool_ctrl); i++) {
+            uint8_t *pool_base = aic->bus_pool_base(bus);
+
+            ret = i2c_send(bus->bus, pool_base[i]);
+            if (ret) {
+                break;
+            }
+        }
+        bus->cmd &= ~I2CD_TX_BUFF_ENABLE;
+    } else {
+        ret = i2c_send(bus->bus, bus->buf);
+    }
+
+    return ret;
+}
+
+static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
+{
+    AspeedI2CState *s = bus->controller;
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
+    uint8_t data;
+    int i;
+
+    if (bus->cmd & I2CD_RX_BUFF_ENABLE) {
+        uint8_t *pool_base = aic->bus_pool_base(bus);
+
+        for (i = 0; i < I2CD_POOL_RX_SIZE(bus->pool_ctrl); i++) {
+            pool_base[i] = i2c_recv(bus->bus);
+        }
+
+        /* Update RX count */
+        bus->pool_ctrl &= ~(0xff << 24);
+        bus->pool_ctrl |= (i & 0xff) << 24;
+        bus->cmd &= ~I2CD_RX_BUFF_ENABLE;
+    } else {
+        data = i2c_recv(bus->bus);
+        bus->buf = (data & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
+    }
+}
+
 static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
 {
-    uint8_t ret;
-
     aspeed_i2c_set_state(bus, I2CD_MRXD);
-    ret = i2c_recv(bus->bus);
+    aspeed_i2c_bus_recv(bus);
     bus->intr_status |= I2CD_INTR_RX_DONE;
-    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
     if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
         i2c_nack(bus->bus);
     }
@@ -207,31 +258,66 @@ static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
     aspeed_i2c_set_state(bus, I2CD_MACTIVE);
 }
 
+static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+
+    if (bus->cmd & I2CD_TX_BUFF_ENABLE) {
+        uint8_t *pool_base = aic->bus_pool_base(bus);
+
+        return pool_base[0];
+    } else {
+        return bus->buf;
+    }
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
  */
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
+    uint8_t pool_start = 0;
+
     bus->cmd &= ~0xFFFF;
     bus->cmd |= value & 0xFFFF;
 
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
+        uint8_t addr;
 
         aspeed_i2c_set_state(bus, state);
 
-        if (i2c_start_transfer(bus->bus, extract32(bus->buf, 1, 7),
-                               extract32(bus->buf, 0, 1))) {
+        addr = aspeed_i2c_get_addr(bus);
+
+        if (i2c_start_transfer(bus->bus, extract32(addr, 1, 7),
+                               extract32(addr, 0, 1))) {
             bus->intr_status |= I2CD_INTR_TX_NAK;
         } else {
             bus->intr_status |= I2CD_INTR_TX_ACK;
         }
 
-        /* START command is also a TX command, as the slave address is
-         * sent on the bus */
-        bus->cmd &= ~(I2CD_M_START_CMD | I2CD_M_TX_CMD);
+        bus->cmd &= ~I2CD_M_START_CMD;
+
+        /*
+         * The START command is also a TX command, as the slave
+         * address is sent on the bus. Drop the TX flag if nothing
+         * else needs to be sent in this sequence.
+         */
+        if (bus->cmd & I2CD_TX_BUFF_ENABLE) {
+            if (I2CD_POOL_TX_COUNT(bus->pool_ctrl) == 1) {
+                bus->cmd &= ~I2CD_M_TX_CMD;
+            } else {
+                /*
+                 * Increase the start index in the TX pool buffer to
+                 * skip the address byte.
+                 */
+                pool_start++;
+            }
+        } else {
+            bus->cmd &= ~I2CD_M_TX_CMD;
+        }
 
         /* No slave found */
         if (!i2c_bus_busy(bus->bus)) {
@@ -242,7 +328,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 
     if (bus->cmd & I2CD_M_TX_CMD) {
         aspeed_i2c_set_state(bus, I2CD_MTXD);
-        if (i2c_send(bus->bus, bus->buf)) {
+        if (aspeed_i2c_bus_send(bus, pool_start)) {
             bus->intr_status |= (I2CD_INTR_TX_NAK);
             i2c_end_transfer(bus->bus);
         } else {
@@ -313,6 +399,11 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
         qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
                       __func__);
         break;
+    case I2CD_POOL_CTRL_REG:
+        bus->pool_ctrl &= ~0xffffff;
+        bus->pool_ctrl |= (value & 0xffffff);
+        break;
+
     case I2CD_BYTE_BUF_REG:
         bus->buf = (value & I2CD_BYTE_BUF_TX_MASK) << I2CD_BYTE_BUF_TX_SHIFT;
         break;
@@ -378,10 +469,45 @@ static const MemoryRegionOps aspeed_i2c_ctrl_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static uint64_t aspeed_i2c_pool_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    AspeedI2CState *s = opaque;
+    uint64_t ret = 0;
+    int i;
+
+    for (i = 0; i < size; i++) {
+        ret |= (uint64_t) s->pool[offset + i] << (8 * i);
+    }
+
+    return ret;
+}
+
+static void aspeed_i2c_pool_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    AspeedI2CState *s = opaque;
+    int i;
+
+    for (i = 0; i < size; i++) {
+        s->pool[offset + i] = (value >> (8 * i)) & 0xFF;
+    }
+}
+
+static const MemoryRegionOps aspeed_i2c_pool_ops = {
+    .read = aspeed_i2c_pool_read,
+    .write = aspeed_i2c_pool_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(id, AspeedI2CBus),
         VMSTATE_UINT32(ctrl, AspeedI2CBus),
@@ -390,19 +516,21 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
         VMSTATE_UINT32(intr_status, AspeedI2CBus),
         VMSTATE_UINT32(cmd, AspeedI2CBus),
         VMSTATE_UINT32(buf, AspeedI2CBus),
+        VMSTATE_UINT32(pool_ctrl, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static const VMStateDescription aspeed_i2c_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(intr_status, AspeedI2CState),
         VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
                              ASPEED_I2C_NR_BUSSES, 1, aspeed_i2c_bus_vmstate,
                              AspeedI2CBus),
+        VMSTATE_UINT8_ARRAY(pool, AspeedI2CState, ASPEED_I2C_MAX_POOL_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -472,6 +600,10 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
         memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offset),
                                     &s->busses[i].mr);
     }
+
+    memory_region_init_io(&s->pool_iomem, OBJECT(s), &aspeed_i2c_pool_ops, s,
+                          "aspeed.i2c-pool", aic->pool_size);
+    memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iomem);
 }
 
 static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
@@ -498,6 +630,14 @@ static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)
     return bus->controller->irq;
 }
 
+static uint8_t *aspeed_2400_i2c_bus_pool_base(AspeedI2CBus *bus)
+{
+    uint8_t *pool_page =
+        &bus->controller->pool[I2CD_POOL_PAGE_SEL(bus->ctrl) * 0x100];
+
+    return &pool_page[I2CD_POOL_OFFSET(bus->pool_ctrl)];
+}
+
 static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -509,6 +649,9 @@ static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x40;
     aic->gap = 7;
     aic->bus_get_irq = aspeed_2400_i2c_bus_get_irq;
+    aic->pool_size = 0x800;
+    aic->pool_base = 0x800;
+    aic->bus_pool_base = aspeed_2400_i2c_bus_pool_base;
 }
 
 static const TypeInfo aspeed_2400_i2c_info = {
@@ -522,6 +665,11 @@ static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
     return bus->controller->irq;
 }
 
+static uint8_t *aspeed_2500_i2c_bus_pool_base(AspeedI2CBus *bus)
+{
+    return &bus->controller->pool[bus->id * 0x10];
+}
+
 static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -533,6 +681,9 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x40;
     aic->gap = 7;
     aic->bus_get_irq = aspeed_2500_i2c_bus_get_irq;
+    aic->pool_size = 0x100;
+    aic->pool_base = 0x200;
+    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
 }
 
 static const TypeInfo aspeed_2500_i2c_info = {
@@ -546,6 +697,11 @@ static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
     return bus->irq;
 }
 
+static uint8_t *aspeed_2600_i2c_bus_pool_base(AspeedI2CBus *bus)
+{
+   return &bus->controller->pool[bus->id * 0x20];
+}
+
 static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -557,6 +713,9 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x80;
     aic->gap = -1; /* no gap */
     aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
+    aic->pool_size = 0x200;
+    aic->pool_base = 0xC00;
+    aic->bus_pool_base = aspeed_2600_i2c_bus_pool_base;
 }
 
 static const TypeInfo aspeed_2600_i2c_info = {
-- 
2.20.1


