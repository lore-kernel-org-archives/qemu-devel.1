Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88CECE588
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8379820872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8379820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKf34-0007NG-3V
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iKf1B-0005dM-4k
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iKf19-0004kZ-PT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37318
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iKf19-0004kE-KI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:50:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9G8lUYB089452
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:50:49 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vnxjhufcu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:50:49 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 16 Oct 2019 09:50:47 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Oct 2019 09:50:44 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9G8ohX533947770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2019 08:50:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8183211C04C;
 Wed, 16 Oct 2019 08:50:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F3C011C05B;
 Wed, 16 Oct 2019 08:50:43 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2019 08:50:43 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-54-117.uk.ibm.com [9.145.54.117])
 by smtp.tls.ibm.com (Postfix) with ESMTP id B3F452201ED;
 Wed, 16 Oct 2019 10:50:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/5] aspeed/i2c: Check SRAM enablement on A2500
Date: Wed, 16 Oct 2019 10:50:32 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016085035.12136-1-clg@kaod.org>
References: <20191016085035.12136-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19101608-0012-0000-0000-00000358819D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101608-0013-0000-0000-000021939A25
Message-Id: <20191016085035.12136-3-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160079
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x9G8lUYB089452
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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

The SRAM must be enabled before using the Buffer Pool mode or the DMA
mode. This is not required on other SoCs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/i2c/aspeed_i2c.h |  3 +++
 hw/i2c/aspeed_i2c.c         | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 5313d07aa72f..7a555072dfbf 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -61,6 +61,7 @@ typedef struct AspeedI2CState {
     qemu_irq irq;
=20
     uint32_t intr_status;
+    uint32_t ctrl_global;
     MemoryRegion pool_iomem;
     uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
=20
@@ -83,6 +84,8 @@ typedef struct AspeedI2CClass {
     uint64_t pool_size;
     hwaddr pool_base;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
+    bool check_sram;
+
 } AspeedI2CClass;
=20
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index e21f45d96868..c7929aa2850f 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -31,6 +31,8 @@
 #define I2C_CTRL_STATUS         0x00        /* Device Interrupt Status *=
/
 #define I2C_CTRL_ASSIGN         0x08        /* Device Interrupt Target
                                                Assignment */
+#define I2C_CTRL_GLOBAL         0x0C        /* Global Control Register *=
/
+#define   I2C_CTRL_SRAM_EN                 BIT(0)
=20
 /* I2C Device (Bus) Register */
=20
@@ -271,6 +273,29 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus=
)
     }
 }
=20
+static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
+{
+    AspeedI2CState *s =3D bus->controller;
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s);
+
+    if (!aic->check_sram) {
+        return true;
+    }
+
+    /*
+     * AST2500: SRAM must be enabled before using the Buffer Pool or
+     * DMA mode.
+     */
+    if (!(s->ctrl_global & I2C_CTRL_SRAM_EN) &&
+        (bus->cmd & (I2CD_RX_DMA_ENABLE | I2CD_TX_DMA_ENABLE |
+                     I2CD_RX_BUFF_ENABLE | I2CD_TX_BUFF_ENABLE))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SRAM is not enabled\n", __fu=
nc__);
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -282,6 +307,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
     bus->cmd &=3D ~0xFFFF;
     bus->cmd |=3D value & 0xFFFF;
=20
+    if (!aspeed_i2c_check_sram(bus)) {
+        return;
+    }
+
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state =3D aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
@@ -436,6 +465,8 @@ static uint64_t aspeed_i2c_ctrl_read(void *opaque, hw=
addr offset,
     switch (offset) {
     case I2C_CTRL_STATUS:
         return s->intr_status;
+    case I2C_CTRL_GLOBAL:
+        return s->ctrl_global;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
                       __func__, offset);
@@ -448,7 +479,12 @@ static uint64_t aspeed_i2c_ctrl_read(void *opaque, h=
waddr offset,
 static void aspeed_i2c_ctrl_write(void *opaque, hwaddr offset,
                                   uint64_t value, unsigned size)
 {
+    AspeedI2CState *s =3D opaque;
+
     switch (offset) {
+    case I2C_CTRL_GLOBAL:
+        s->ctrl_global =3D value;
+        break;
     case I2C_CTRL_STATUS:
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
@@ -684,6 +720,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->pool_size =3D 0x100;
     aic->pool_base =3D 0x200;
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;
+    aic->check_sram =3D true;
 }
=20
 static const TypeInfo aspeed_2500_i2c_info =3D {
--=20
2.21.0


