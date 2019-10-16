Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA543ECE588
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E37220872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E37220872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKf7L-0004fg-7w
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iKf1C-0005du-Ov
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iKf1A-0004lf-RP
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iKf1A-0004l9-Ip
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9G8lVLA034244
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:50:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vnyevhh5r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:50:51 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 16 Oct 2019 09:50:49 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Oct 2019 09:50:45 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9G8oj4Z46924102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2019 08:50:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E33FF42045;
 Wed, 16 Oct 2019 08:50:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C463E42042;
 Wed, 16 Oct 2019 08:50:44 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2019 08:50:44 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-54-117.uk.ibm.com [9.145.54.117])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 158842201ED;
 Wed, 16 Oct 2019 10:50:44 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/5] aspeed/i2c: Add support for DMA transfers
Date: Wed, 16 Oct 2019 10:50:34 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016085035.12136-1-clg@kaod.org>
References: <20191016085035.12136-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19101608-0020-0000-0000-000003798143
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101608-0021-0000-0000-000021CFA3CB
Message-Id: <20191016085035.12136-5-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160079
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9G8lVLA034244
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
 Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The I2C controller of the Aspeed AST2500 and AST2600 SoCs supports DMA
transfers to and from DRAM.

A pair of registers defines the buffer address and the length of the
DMA transfer. The address should be aligned on 4 bytes and the maximum
length should not exceed 4K. The receive or transmit DMA transfer can
then be initiated with specific bits in the Command/Status register of
the controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/i2c/aspeed_i2c.h |   5 ++
 hw/arm/aspeed_ast2600.c     |   5 ++
 hw/arm/aspeed_soc.c         |   5 ++
 hw/i2c/aspeed_i2c.c         | 126 +++++++++++++++++++++++++++++++++++-
 4 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 7a555072dfbf..f1b9e5bf91e2 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -52,6 +52,8 @@ typedef struct AspeedI2CBus {
     uint32_t cmd;
     uint32_t buf;
     uint32_t pool_ctrl;
+    uint32_t dma_addr;
+    uint32_t dma_len;
 } AspeedI2CBus;
=20
 typedef struct AspeedI2CState {
@@ -66,6 +68,8 @@ typedef struct AspeedI2CState {
     uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
=20
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
+    MemoryRegion *dram_mr;
+    AddressSpace dram_as;
 } AspeedI2CState;
=20
 #define ASPEED_I2C_CLASS(klass) \
@@ -85,6 +89,7 @@ typedef struct AspeedI2CClass {
     hwaddr pool_base;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
     bool check_sram;
+    bool has_dma;
=20
 } AspeedI2CClass;
=20
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a403c2aae067..0881eb25983e 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -343,6 +343,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
     }
=20
     /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram"=
, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index dd1ee0e3336d..b01c97744196 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -311,6 +311,11 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     }
=20
     /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram"=
, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index c7929aa2850f..030d9c56be65 100644
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
=20
 /* I2C Global Register */
=20
@@ -138,7 +141,8 @@
 #define   I2CD_BYTE_BUF_TX_MASK            0xff
 #define   I2CD_BYTE_BUF_RX_SHIFT           8
 #define   I2CD_BYTE_BUF_RX_MASK            0xff
-
+#define I2CD_DMA_ADDR           0x24       /* DMA Buffer Address */
+#define I2CD_DMA_LEN            0x28       /* DMA Transfer Length < 4KB =
*/
=20
 static inline bool aspeed_i2c_bus_is_master(AspeedI2CBus *bus)
 {
@@ -165,6 +169,7 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwa=
ddr offset,
                                     unsigned size)
 {
     AspeedI2CBus *bus =3D opaque;
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
=20
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
@@ -183,6 +188,18 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hw=
addr offset,
         return bus->buf;
     case I2CD_CMD_REG:
         return bus->cmd | (i2c_bus_busy(bus->bus) << 16);
+    case I2CD_DMA_ADDR:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
+            return -1;
+        }
+        return bus->dma_addr;
+    case I2CD_DMA_LEN:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
+            return -1;
+        }
+        return bus->dma_len;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, o=
ffset);
@@ -201,6 +218,24 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bu=
s)
     return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
 }
=20
+static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
+{
+    MemTxResult result;
+    AspeedI2CState *s =3D bus->controller;
+
+    result =3D address_space_read(&s->dram_as, bus->dma_addr,
+                                MEMTXATTRS_UNSPECIFIED, data, 1);
+    if (result !=3D MEMTX_OK) {
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
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
@@ -217,6 +252,16 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, ui=
nt8_t pool_start)
             }
         }
         bus->cmd &=3D ~I2CD_TX_BUFF_ENABLE;
+    } else if (bus->cmd & I2CD_TX_DMA_ENABLE) {
+        while (bus->dma_len) {
+            uint8_t data;
+            aspeed_i2c_dma_read(bus, &data);
+            ret =3D i2c_send(bus->bus, data);
+            if (ret) {
+                break;
+            }
+        }
+        bus->cmd &=3D ~I2CD_TX_DMA_ENABLE;
     } else {
         ret =3D i2c_send(bus->bus, bus->buf);
     }
@@ -242,6 +287,24 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         bus->pool_ctrl &=3D ~(0xff << 24);
         bus->pool_ctrl |=3D (i & 0xff) << 24;
         bus->cmd &=3D ~I2CD_RX_BUFF_ENABLE;
+    } else if (bus->cmd & I2CD_RX_DMA_ENABLE) {
+        uint8_t data;
+
+        while (bus->dma_len) {
+            MemTxResult result;
+
+            data =3D i2c_recv(bus->bus);
+            result =3D address_space_write(&s->dram_as, bus->dma_addr,
+                                         MEMTXATTRS_UNSPECIFIED, &data, =
1);
+            if (result !=3D MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM write failed @%=
08x\n",
+                              __func__, bus->dma_addr);
+                return;
+            }
+            bus->dma_addr++;
+            bus->dma_len--;
+        }
+        bus->cmd &=3D ~I2CD_RX_DMA_ENABLE;
     } else {
         data =3D i2c_recv(bus->bus);
         bus->buf =3D (data & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_=
SHIFT;
@@ -268,6 +331,11 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus=
)
         uint8_t *pool_base =3D aic->bus_pool_base(bus);
=20
         return pool_base[0];
+    } else if (bus->cmd & I2CD_TX_DMA_ENABLE) {
+        uint8_t data;
+
+        aspeed_i2c_dma_read(bus, &data);
+        return data;
     } else {
         return bus->buf;
     }
@@ -344,6 +412,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
                  */
                 pool_start++;
             }
+        } else if (bus->cmd & I2CD_TX_DMA_ENABLE) {
+            if (bus->dma_len =3D=3D 0) {
+                bus->cmd &=3D ~I2CD_M_TX_CMD;
+            }
         } else {
             bus->cmd &=3D ~I2CD_M_TX_CMD;
         }
@@ -447,9 +519,35 @@ static void aspeed_i2c_bus_write(void *opaque, hwadd=
r offset,
             break;
         }
=20
+        if (!aic->has_dma &&
+            value & (I2CD_RX_DMA_ENABLE | I2CD_TX_DMA_ENABLE)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
+            break;
+        }
+
         aspeed_i2c_bus_handle_cmd(bus, value);
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
+    case I2CD_DMA_ADDR:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
+            break;
+        }
+
+        bus->dma_addr =3D value & 0xfffffffc;
+        break;
+
+    case I2CD_DMA_LEN:
+        if (!aic->has_dma) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __fu=
nc__);
+            break;
+        }
+
+        bus->dma_len =3D value & 0xfff;
+        if (!bus->dma_len) {
+            qemu_log_mask(LOG_UNIMP, "%s: invalid DMA length\n",  __func=
__);
+        }
+        break;
=20
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
@@ -542,8 +640,8 @@ static const MemoryRegionOps aspeed_i2c_pool_ops =3D =
{
=20
 static const VMStateDescription aspeed_i2c_bus_vmstate =3D {
     .name =3D TYPE_ASPEED_I2C,
-    .version_id =3D 2,
-    .minimum_version_id =3D 2,
+    .version_id =3D 3,
+    .minimum_version_id =3D 3,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT8(id, AspeedI2CBus),
         VMSTATE_UINT32(ctrl, AspeedI2CBus),
@@ -553,6 +651,8 @@ static const VMStateDescription aspeed_i2c_bus_vmstat=
e =3D {
         VMSTATE_UINT32(cmd, AspeedI2CBus),
         VMSTATE_UINT32(buf, AspeedI2CBus),
         VMSTATE_UINT32(pool_ctrl, AspeedI2CBus),
+        VMSTATE_UINT32(dma_addr, AspeedI2CBus),
+        VMSTATE_UINT32(dma_len, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -584,6 +684,8 @@ static void aspeed_i2c_reset(DeviceState *dev)
         s->busses[i].intr_status =3D 0;
         s->busses[i].cmd =3D 0;
         s->busses[i].buf =3D 0;
+        s->busses[i].dma_addr =3D 0;
+        s->busses[i].dma_len =3D 0;
         i2c_end_transfer(s->busses[i].bus);
     }
 }
@@ -640,14 +742,30 @@ static void aspeed_i2c_realize(DeviceState *dev, Er=
ror **errp)
     memory_region_init_io(&s->pool_iomem, OBJECT(s), &aspeed_i2c_pool_op=
s, s,
                           "aspeed.i2c-pool", aic->pool_size);
     memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iome=
m);
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
=20
+static Property aspeed_i2c_properties[] =3D {
+    DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->vmsd =3D &aspeed_i2c_vmstate;
     dc->reset =3D aspeed_i2c_reset;
+    dc->props =3D aspeed_i2c_properties;
     dc->realize =3D aspeed_i2c_realize;
     dc->desc =3D "Aspeed I2C Controller";
 }
@@ -721,6 +839,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->pool_base =3D 0x200;
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;
     aic->check_sram =3D true;
+    aic->has_dma =3D true;
 }
=20
 static const TypeInfo aspeed_2500_i2c_info =3D {
@@ -753,6 +872,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->pool_size =3D 0x200;
     aic->pool_base =3D 0xC00;
     aic->bus_pool_base =3D aspeed_2600_i2c_bus_pool_base;
+    aic->has_dma =3D true;
 }
=20
 static const TypeInfo aspeed_2600_i2c_info =3D {
--=20
2.21.0


