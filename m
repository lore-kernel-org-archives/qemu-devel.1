Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3EF222A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3EF222A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4L3-0003P4-ND
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4Fg-00062I-0B
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4Fe-0005Ia-8l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:07 -0500
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:60009)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4Fe-0005Hj-2V
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:06 -0500
Received: from player795.ha.ovh.net (unknown [10.108.54.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3581F22CCA3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:13:03 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 9C17CC18A976;
 Tue, 19 Nov 2019 14:12:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 05/17] aspeed/i2c: Add trace events
Date: Tue, 19 Nov 2019 15:11:59 +0100
Message-Id: <20191119141211.25716-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17901527044910648081
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedv
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.165.232
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 93 ++++++++++++++++++++++++++++++++++++++-------
 hw/i2c/trace-events |  9 +++++
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 030d9c56be65..2da04a4bff30 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -28,6 +28,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "trace.h"
=20
 /* I2C Global Register */
=20
@@ -158,6 +159,13 @@ static inline void aspeed_i2c_bus_raise_interrupt(As=
peedI2CBus *bus)
 {
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
=20
+    trace_aspeed_i2c_bus_raise_interrupt(bus->intr_status,
+          bus->intr_status & I2CD_INTR_TX_NAK ? "nak|" : "",
+          bus->intr_status & I2CD_INTR_TX_ACK ? "ack|" : "",
+          bus->intr_status & I2CD_INTR_RX_DONE ? "done|" : "",
+          bus->intr_status & I2CD_INTR_NORMAL_STOP ? "normal|" : "",
+          bus->intr_status & I2CD_INTR_ABNORMAL ? "abnormal" : "");
+
     bus->intr_status &=3D bus->intr_ctrl;
     if (bus->intr_status) {
         bus->controller->intr_status |=3D 1 << bus->id;
@@ -170,41 +178,57 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, h=
waddr offset,
 {
     AspeedI2CBus *bus =3D opaque;
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
+    uint64_t value =3D -1;
=20
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
-        return bus->ctrl;
+        value =3D bus->ctrl;
+        break;
     case I2CD_AC_TIMING_REG1:
-        return bus->timing[0];
+        value =3D bus->timing[0];
+        break;
     case I2CD_AC_TIMING_REG2:
-        return bus->timing[1];
+        value =3D bus->timing[1];
+        break;
     case I2CD_INTR_CTRL_REG:
-        return bus->intr_ctrl;
+        value =3D bus->intr_ctrl;
+        break;
     case I2CD_INTR_STS_REG:
-        return bus->intr_status;
+        value =3D bus->intr_status;
+        break;
     case I2CD_POOL_CTRL_REG:
-        return bus->pool_ctrl;
+        value =3D bus->pool_ctrl;
+        break;
     case I2CD_BYTE_BUF_REG:
-        return bus->buf;
+        value =3D bus->buf;
+        break;
     case I2CD_CMD_REG:
-        return bus->cmd | (i2c_bus_busy(bus->bus) << 16);
+        value =3D bus->cmd | (i2c_bus_busy(bus->bus) << 16);
+        break;
     case I2CD_DMA_ADDR:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
-            return -1;
+            break;
         }
-        return bus->dma_addr;
+        value =3D bus->dma_addr;
+        break;
     case I2CD_DMA_LEN:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
-            return -1;
+            break;
         }
-        return bus->dma_len;
+        value =3D bus->dma_len;
+        break;
+
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, o=
ffset);
-        return -1;
+        value =3D -1;
+        break;
     }
+
+    trace_aspeed_i2c_bus_read(bus->id, offset, size, value);
+    return value;
 }
=20
 static void aspeed_i2c_set_state(AspeedI2CBus *bus, uint8_t state)
@@ -246,6 +270,9 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uin=
t8_t pool_start)
         for (i =3D pool_start; i < I2CD_POOL_TX_COUNT(bus->pool_ctrl); i=
++) {
             uint8_t *pool_base =3D aic->bus_pool_base(bus);
=20
+            trace_aspeed_i2c_bus_send("BUF", i + 1,
+                                      I2CD_POOL_TX_COUNT(bus->pool_ctrl)=
,
+                                      pool_base[i]);
             ret =3D i2c_send(bus->bus, pool_base[i]);
             if (ret) {
                 break;
@@ -256,6 +283,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uin=
t8_t pool_start)
         while (bus->dma_len) {
             uint8_t data;
             aspeed_i2c_dma_read(bus, &data);
+            trace_aspeed_i2c_bus_send("DMA", bus->dma_len, bus->dma_len,=
 data);
             ret =3D i2c_send(bus->bus, data);
             if (ret) {
                 break;
@@ -263,6 +291,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uin=
t8_t pool_start)
         }
         bus->cmd &=3D ~I2CD_TX_DMA_ENABLE;
     } else {
+        trace_aspeed_i2c_bus_send("BYTE", pool_start, 1, bus->buf);
         ret =3D i2c_send(bus->bus, bus->buf);
     }
=20
@@ -281,6 +310,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
=20
         for (i =3D 0; i < I2CD_POOL_RX_SIZE(bus->pool_ctrl); i++) {
             pool_base[i] =3D i2c_recv(bus->bus);
+            trace_aspeed_i2c_bus_recv("BUF", i + 1,
+                                      I2CD_POOL_RX_SIZE(bus->pool_ctrl),
+                                      pool_base[i]);
         }
=20
         /* Update RX count */
@@ -294,6 +326,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
             MemTxResult result;
=20
             data =3D i2c_recv(bus->bus);
+            trace_aspeed_i2c_bus_recv("DMA", bus->dma_len, bus->dma_len,=
 data);
             result =3D address_space_write(&s->dram_as, bus->dma_addr,
                                          MEMTXATTRS_UNSPECIFIED, &data, =
1);
             if (result !=3D MEMTX_OK) {
@@ -307,6 +340,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         bus->cmd &=3D ~I2CD_RX_DMA_ENABLE;
     } else {
         data =3D i2c_recv(bus->bus);
+        trace_aspeed_i2c_bus_recv("BYTE", 1, 1, bus->buf);
         bus->buf =3D (data & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_=
SHIFT;
     }
 }
@@ -364,6 +398,33 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
     return true;
 }
=20
+static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
+{
+    g_autofree char *cmd_flags;
+    uint32_t count;
+
+    if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
+        count =3D I2CD_POOL_TX_COUNT(bus->pool_ctrl);
+    } else if (bus->cmd & (I2CD_RX_DMA_ENABLE | I2CD_RX_DMA_ENABLE)) {
+        count =3D bus->dma_len;
+    } else { /* BYTE mode */
+        count =3D 1;
+    }
+
+    cmd_flags =3D g_strdup_printf("%s%s%s%s%s%s%s%s%s",
+                                bus->cmd & I2CD_M_START_CMD ? "start|" :=
 "",
+                                bus->cmd & I2CD_RX_DMA_ENABLE ? "rxdma|"=
 : "",
+                                bus->cmd & I2CD_TX_DMA_ENABLE ? "txdma|"=
 : "",
+                                bus->cmd & I2CD_RX_BUFF_ENABLE ? "rxbuf|=
" : "",
+                                bus->cmd & I2CD_TX_BUFF_ENABLE ? "txbuf|=
" : "",
+                                bus->cmd & I2CD_M_TX_CMD ? "tx|" : "",
+                                bus->cmd & I2CD_M_RX_CMD ? "rx|" : "",
+                                bus->cmd & I2CD_M_S_RX_CMD_LAST ? "last|=
" : "",
+                                bus->cmd & I2CD_M_STOP_CMD ? "stop" : ""=
);
+
+    trace_aspeed_i2c_bus_cmd(bus->cmd, cmd_flags, count, bus->intr_statu=
s);
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -379,6 +440,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
         return;
     }
=20
+    if (trace_event_get_state_backends(TRACE_ASPEED_I2C_BUS_CMD)) {
+        aspeed_i2c_bus_cmd_dump(bus);
+    }
+
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state =3D aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
@@ -465,6 +530,8 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr=
 offset,
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
=20
+    trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
+
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
         if (value & I2CD_SLAVE_EN) {
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index e1c810d5bd08..08db8fa68924 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -5,3 +5,12 @@
 i2c_event(const char *event, uint8_t address) "%s(addr:0x%02x)"
 i2c_send(uint8_t address, uint8_t data) "send(addr:0x%02x) data:0x%02x"
 i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
+
+# aspeed_i2c.c
+
+aspeed_i2c_bus_cmd(uint32_t cmd, const char *cmd_flags, uint32_t count, =
uint32_t intr_status) "handling cmd=3D0x%x %s count=3D%d intr=3D0x%x"
+aspeed_i2c_bus_raise_interrupt(uint32_t intr_status, const char *str1, c=
onst char *str2, const char *str3, const char *str4, const char *str5) "h=
andled intr=3D0x%x %s%s%s%s%s"
+aspeed_i2c_bus_read(uint32_t busid, uint64_t offset, unsigned size, uint=
64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
+aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uin=
t64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
+aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%=
s send %d/%d 0x%02x"
+aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%=
s recv %d/%d 0x%02x"
--=20
2.21.0


