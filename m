Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4099C282E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 07:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CAF20857
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 07:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CAF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIT21-0000Ty-OP
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 03:06:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISyz-0006cV-Gs
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hISyx-0005BD-M9
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hISyw-00056b-MN
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:03:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M6rmLX020347
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s188ts797-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:03:06 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:03:05 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
	by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 22 Apr 2019 08:03:02 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x3M731Nn29687896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 22 Apr 2019 07:03:02 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD880AE066;
	Mon, 22 Apr 2019 07:03:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69289AE063;
	Mon, 22 Apr 2019 07:02:59 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.199.63.199])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2019 07:02:59 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	david@gibson.dropbear.id.au
Date: Mon, 22 Apr 2019 12:32:58 +0530
In-Reply-To: <155591636364.20338.844048953355207313.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042207-0064-0000-0000-000003CE47B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010972; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01192628; UDB=6.00625138;
	IPR=6.00973446; 
	MB=3.00026542; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-22 07:03:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042207-0065-0000-0000-00003D27FF52
Message-Id: <155591657807.20338.12115795588476734752.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-21_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904220052
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v8 1/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422070258.tO_R2aEnyc-o4MMcV_Ve3NZkuvwZO0lQF8sTH67XClg@z>

This patch adds support in QEMU to handle "ibm,nmi-register"
and "ibm,nmi-interlock" RTAS calls.

The machine check notification address is saved when the
OS issues "ibm,nmi-register" RTAS call.

This patch also handles the case when multiple processors
experience machine check at or about the same time by
handling "ibm,nmi-interlock" call. In such cases, as per
PAPR, subsequent processors serialize waiting for the first
processor to issue the "ibm,nmi-interlock" call. The second
processor that also received a machine check error waits
till the first processor is done reading the error log.
The first processor issues "ibm,nmi-interlock" call
when the error log is consumed. This patch implements the
releasing part of the error-log while subsequent patch
(which builds error log) handles the locking part.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |   18 ++++++++++++++
 hw/ppc/spapr_rtas.c    |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    9 ++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c56939a..6642cb5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1805,6 +1805,11 @@ static void spapr_machine_reset(void)
     first_ppc_cpu->env.gpr[5] = 0;
 
     spapr->cas_reboot = false;
+
+    spapr->guest_machine_check_addr = -1;
+
+    /* Signal all vCPUs waiting on this condition */
+    qemu_cond_broadcast(&spapr->mc_delivery_cond);
 }
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
@@ -2095,6 +2100,16 @@ static const VMStateDescription vmstate_spapr_dtb = {
     },
 };
 
+static const VMStateDescription vmstate_spapr_machine_check = {
+    .name = "spapr_machine_check",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -2127,6 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
+        &vmstate_spapr_machine_check,
         NULL
     }
 };
@@ -3068,6 +3084,8 @@ static void spapr_machine_init(MachineState *machine)
 
         kvmppc_spapr_enable_inkernel_multitce();
     }
+
+    qemu_cond_init(&spapr->mc_delivery_cond);
 }
 
 static int spapr_kvm_type(MachineState *machine, const char *vm_type)
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index ee24212..c2f3991 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -348,6 +348,39 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
+static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
+                                  SpaprMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args,
+                                  uint32_t nret, target_ulong rets)
+{
+    uint64_t rtas_addr = spapr_get_rtas_addr();
+
+    if (!rtas_addr) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    spapr->guest_machine_check_addr = rtas_ld(args, 1);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret, target_ulong rets)
+{
+    if (!spapr->guest_machine_check_addr) {
+        /* NMI register not called */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+    } else {
+        qemu_cond_signal(&spapr->mc_delivery_cond);
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    }
+}
+
+
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -466,6 +499,30 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
     }
 }
 
+uint64_t spapr_get_rtas_addr(void)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    int rtas_node;
+    const struct fdt_property *rtas_addr_prop;
+    void *fdt = spapr->fdt_blob;
+    uint32_t rtas_addr;
+
+    /* fetch rtas addr from fdt */
+    rtas_node = fdt_path_offset(fdt, "/rtas");
+    if (rtas_node == 0) {
+        return 0;
+    }
+
+    rtas_addr_prop = fdt_get_property(fdt, rtas_node, "linux,rtas-base", NULL);
+    if (!rtas_addr_prop) {
+        return 0;
+    }
+
+    rtas_addr = fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
+    return (uint64_t)rtas_addr;
+}
+
+
 static void core_rtas_register_types(void)
 {
     spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
@@ -489,6 +546,10 @@ static void core_rtas_register_types(void)
                         rtas_set_power_level);
     spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
                         rtas_get_power_level);
+    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
+                        rtas_ibm_nmi_register);
+    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
+                        rtas_ibm_nmi_interlock);
 }
 
 type_init(core_rtas_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7e32f30..ec6f33e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -187,6 +187,10 @@ struct SpaprMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
 
+    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
+    target_ulong guest_machine_check_addr;
+    QemuCond mc_delivery_cond;
+
     /*< public >*/
     char *kvm_type;
     char *host_model;
@@ -623,8 +627,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
@@ -874,4 +880,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
+uint64_t spapr_get_rtas_addr(void);
 #endif /* HW_SPAPR_H */


