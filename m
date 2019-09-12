Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DCC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878BE208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878BE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Lf2-00064v-EQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i8LRu-0000P9-1Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i8LRs-0006rT-Gp
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61014
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i8LRs-0006rF-CK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:31:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8C9IAOo042112
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:31:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uyga7xeba-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:31:31 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 12 Sep 2019 10:31:29 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Sep 2019 10:31:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8C9VP6A52822020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2019 09:31:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1381AE053;
 Thu, 12 Sep 2019 09:31:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F863AE056;
 Thu, 12 Sep 2019 09:31:24 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.221])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2019 09:31:23 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 15:00:55 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190912093056.4516-1-bala24@linux.ibm.com>
References: <20190912093056.4516-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19091209-0020-0000-0000-0000036B5C3D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091209-0021-0000-0000-000021C0ED10
Message-Id: <20190912093056.4516-5-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-12_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120099
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8C9IAOo042112
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v3 4/4] hw/ppc/pnv: fix checkpatch.pl coding
 style warnings
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org,
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, clg@kaod.org, hari@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There were few trailing comments after `/*` instead in
new line and line more than 80 character, these fixes are
trivial and doesn't change any logic in code.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f249e72356..77a86c6a23 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -187,7 +187,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, v=
oid *fdt)
=20
     _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
     _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts=
->slb_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size",
+                           cpu->hash64_opts->slb_size)));
     _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
     _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
=20
@@ -200,19 +201,23 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
                            segs, sizeof(segs))));
     }
=20
-    /* Advertise VMX/VSX (vector extensions) if available
+    /*
+     * Advertise VMX/VSX (vector extensions) if available
      *   0 / no property =3D=3D no vector extensions
      *   1               =3D=3D VMX / Altivec available
-     *   2               =3D=3D VSX available */
+     *   2               =3D=3D VSX available
+     */
     if (env->insns_flags & PPC_ALTIVEC) {
         uint32_t vmx =3D (env->insns_flags2 & PPC2_VSX) ? 2 : 1;
=20
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", vmx)));
     }
=20
-    /* Advertise DFP (Decimal Floating Point) if available
+    /*
+     * Advertise DFP (Decimal Floating Point) if available
      *   0 / no property =3D=3D no DFP
-     *   1               =3D=3D DFP available */
+     *   1               =3D=3D DFP available
+     */
     if (env->insns_flags2 & PPC2_DFP) {
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
     }
@@ -424,7 +429,8 @@ static int pnv_dt_isa_device(DeviceState *dev, void *=
opaque)
     return 0;
 }
=20
-/* The default LPC bus of a multichip system is on chip 0. It's
+/*
+ * The default LPC bus of a multichip system is on chip 0. It's
  * recognized by the firmware (skiboot) using a "primary" property.
  */
 static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
@@ -442,8 +448,10 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
dt)
     assert(phandle > 0);
     _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
=20
-    /* ISA devices are not necessarily parented to the ISA bus so we
-     * can not use object_child_foreach() */
+    /*
+     * ISA devices are not necessarily parented to the ISA bus so we
+     * can not use object_child_foreach()
+     */
     qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NULL,=
 NULL,
                        &args);
 }
@@ -545,7 +553,8 @@ static void pnv_reset(MachineState *machine)
=20
     qemu_devices_reset();
=20
-    /* OpenPOWER systems have a BMC, which can be defined on the
+    /*
+     * OpenPOWER systems have a BMC, which can be defined on the
      * command line with:
      *
      *   -device ipmi-bmc-sim,id=3Dbmc0
@@ -705,7 +714,8 @@ static void pnv_init(MachineState *machine)
=20
         pnv->chips[i] =3D PNV_CHIP(chip);
=20
-        /* TODO: put all the memory in one node on chip 0 until we find =
a
+        /*
+         * TODO: put all the memory in one node on chip 0 until we find =
a
          * way to specify different ranges for each chip
          */
         if (i =3D=3D 0) {
@@ -732,8 +742,10 @@ static void pnv_init(MachineState *machine)
     /* Create an RTC ISA device too */
     mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
=20
-    /* OpenPOWER systems use a IPMI SEL Event message to notify the
-     * host to powerdown */
+    /*
+     * OpenPOWER systems use a IPMI SEL Event message to notify the
+     * host to powerdown
+     */
     pnv->powerdown_notifier.notify =3D pnv_powerdown_notify;
     qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
 }
@@ -803,7 +815,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
     pnv_cpu->intc =3D obj;
 }
=20
-/* Allowed core identifiers on a POWER8 Processor Chip :
+/*
+ * Allowed core identifiers on a POWER8 Processor Chip :
  *
  * <EX0 reserved>
  *  EX1  - Venice only
@@ -928,8 +941,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
                                             (uint64_t) PNV_XSCOM_BASE(ch=
ip),
                                             PNV_XSCOM_LPC_BASE);
=20
-    /* Interrupt Management Area. This is the memory region holding
-     * all the Interrupt Control Presenter (ICP) registers */
+    /*
+     * Interrupt Management Area. This is the memory region holding
+     * all the Interrupt Control Presenter (ICP) registers
+     */
     pnv_chip_icp_realize(chip8, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1442,8 +1457,8 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
     mc->init =3D pnv_init;
     mc->reset =3D pnv_reset;
     mc->max_cpus =3D MAX_CPUS;
-    mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
-                                      * storage */
+    /* Pnv provides a AHCI device for storage */
+    mc->block_default_type =3D IF_IDE;
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
     /*
--=20
2.14.5


