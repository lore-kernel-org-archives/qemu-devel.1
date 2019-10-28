Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0AFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E101F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E101F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOz3D-0000Tr-Hm
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iOz1H-0006op-6n
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iOz1F-0006gw-J2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:00:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iOz1F-0006Zw-BO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:00:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9S6r4rG077628
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 03:00:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vwtk19a1v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 03:00:41 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 28 Oct 2019 07:00:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Oct 2019 07:00:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9S70YRc46268508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Oct 2019 07:00:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC1DD5205F;
 Mon, 28 Oct 2019 07:00:34 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9958A52051;
 Mon, 28 Oct 2019 07:00:34 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-44-156.uk.ibm.com [9.145.44.156])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id F1976220062;
 Mon, 28 Oct 2019 08:00:33 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 2/2] ppc/pnv: Add HIOMAP commands
Date: Mon, 28 Oct 2019 08:00:27 +0100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028070027.22752-1-clg@kaod.org>
References: <20191028070027.22752-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102807-0012-0000-0000-0000035E458F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102807-0013-0000-0000-000021998131
Message-Id: <20191028070027.22752-3-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-28_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280068
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9S6r4rG077628
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
Cc: Joel Stanley <joel@jms.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This activates HIOMAP support on the QEMU PowerNV machine. The PnvPnor
model is used to access the flash contents. The model simply maps the
contents at a fix offset and enables or disables the mapping.

HIOMAP Protocol description :

  https://github.com/openbmc/hiomapd/blob/master/Documentation/protocol.m=
d

Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h      |   1 +
 include/hw/ppc/pnv_pnor.h |   5 ++
 hw/ppc/pnv.c              |   1 +
 hw/ppc/pnv_bmc.c          | 102 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c          |  13 +++++
 5 files changed, 122 insertions(+)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 5ecd3ba6ed24..07c56c05ad30 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -198,6 +198,7 @@ static inline bool pnv_is_power9(PnvMachineState *pnv=
)
  */
 void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
 void pnv_bmc_powerdown(IPMIBmc *bmc);
+int pnv_bmc_hiomap(IPMIBmc *bmc);
=20
 /*
  * POWER8 MMIO base addresses
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index dec811695c8d..c3dd28643cae 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -9,6 +9,11 @@
 #ifndef _PPC_PNV_PNOR_H
 #define _PPC_PNV_PNOR_H
=20
+/*
+ * PNOR offset on the LPC FW address space
+ */
+#define PNOR_SPI_OFFSET         0x0c000000UL
+
 #define TYPE_PNV_PNOR  "pnv-pnor"
 #define PNV_PNOR(obj)  OBJECT_CHECK(PnvPnor, (obj), TYPE_PNV_PNOR)
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d0c1d4227784..ef0c83b28742 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -566,6 +566,7 @@ static void pnv_reset(MachineState *machine)
     obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
     if (obj) {
         pnv->bmc =3D IPMI_BMC(obj);
+        pnv_bmc_hiomap(pnv->bmc);
     }
=20
     fdt =3D pnv_dt_create(machine);
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index dc5e918cb79e..aa5c89586c63 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -114,3 +114,105 @@ void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt)
                                sdr->sensor_type)));
     }
 }
+
+/*
+ * HIOMAP protocol handler
+ */
+#define HIOMAP_C_RESET                  1
+#define HIOMAP_C_GET_INFO               2
+#define HIOMAP_C_GET_FLASH_INFO         3
+#define HIOMAP_C_CREATE_READ_WINDOW     4
+#define HIOMAP_C_CLOSE_WINDOW           5
+#define HIOMAP_C_CREATE_WRITE_WINDOW    6
+#define HIOMAP_C_MARK_DIRTY             7
+#define HIOMAP_C_FLUSH                  8
+#define HIOMAP_C_ACK                    9
+#define HIOMAP_C_ERASE                  10
+#define HIOMAP_C_DEVICE_NAME            11
+#define HIOMAP_C_LOCK                   12
+
+#define BLOCK_SHIFT                     12 /* 4K */
+
+static uint16_t bytes_to_blocks(uint32_t bytes)
+{
+    return bytes >> BLOCK_SHIFT;
+}
+
+static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_l=
en,
+                       RspBuffer *rsp)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    PnvPnor *pnor =3D pnv->pnor;
+    uint32_t pnor_size =3D pnor->size;
+    uint32_t pnor_addr =3D PNOR_SPI_OFFSET;
+    bool readonly =3D false;
+
+    rsp_buffer_push(rsp, cmd[2]);
+    rsp_buffer_push(rsp, cmd[3]);
+
+    switch (cmd[2]) {
+    case HIOMAP_C_MARK_DIRTY:
+    case HIOMAP_C_FLUSH:
+    case HIOMAP_C_ERASE:
+    case HIOMAP_C_ACK:
+        break;
+
+    case HIOMAP_C_GET_INFO:
+        rsp_buffer_push(rsp, 2);  /* Version 2 */
+        rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
+        rsp_buffer_push(rsp, 0);  /* Timeout */
+        rsp_buffer_push(rsp, 0);  /* Timeout */
+        break;
+
+    case HIOMAP_C_GET_FLASH_INFO:
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
+        rsp_buffer_push(rsp, 0x01);  /* erase size */
+        rsp_buffer_push(rsp, 0x00);  /* erase size */
+        break;
+
+    case HIOMAP_C_CREATE_READ_WINDOW:
+        readonly =3D true;
+        /* Fall through */
+
+    case HIOMAP_C_CREATE_WRITE_WINDOW:
+        memory_region_set_readonly(&pnor->mmio, readonly);
+        memory_region_set_enabled(&pnor->mmio, true);
+
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) & 0xFF);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) >> 8);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
+        rsp_buffer_push(rsp, 0x00); /* offset */
+        rsp_buffer_push(rsp, 0x00); /* offset */
+        break;
+
+    case HIOMAP_C_CLOSE_WINDOW:
+        memory_region_set_enabled(&pnor->mmio, false);
+        break;
+
+    case HIOMAP_C_DEVICE_NAME:
+    case HIOMAP_C_RESET:
+    case HIOMAP_C_LOCK:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "HIOMAP: unknow command %02X\n", =
cmd[2]);
+        break;
+    }
+}
+
+#define HIOMAP   0x5a
+
+static const IPMICmdHandler hiomap_cmds[] =3D {
+    [HIOMAP] =3D { hiomap_cmd, 3 },
+};
+
+static const IPMINetfn hiomap_netfn =3D {
+    .cmd_nums =3D ARRAY_SIZE(hiomap_cmds),
+    .cmd_handlers =3D hiomap_cmds
+};
+
+int pnv_bmc_hiomap(IPMIBmc *bmc)
+{
+    return ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc),
+                                   IPMI_NETFN_OEM, &hiomap_netfn);
+}
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 9466d4a1be3b..287fa8ab091b 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -801,6 +801,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, boo=
l use_cpld, Error **errp)
     ISABus *isa_bus;
     qemu_irq *irqs;
     qemu_irq_handler handler;
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
=20
     /* let isa_bus_new() create its own bridge on SysBus otherwise
      * devices speficied on the command line won't find the bus and
@@ -825,5 +826,17 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bo=
ol use_cpld, Error **errp)
     irqs =3D qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
=20
     isa_bus_irqs(isa_bus, irqs);
+
+    /*
+     * TODO: Map PNOR on the LPC FW address space on demand ?
+     */
+    memory_region_add_subregion(&lpc->isa_fw, PNOR_SPI_OFFSET,
+                                &pnv->pnor->mmio);
+    /*
+     * Start disabled. The HIOMAP protocol will activate the mapping
+     * with HIOMAP_C_CREATE_WRITE_WINDOW
+     */
+    memory_region_set_enabled(&pnv->pnor->mmio, false);
+
     return isa_bus;
 }
--=20
2.21.0


