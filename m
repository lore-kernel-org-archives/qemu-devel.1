Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3633CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1032084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1032084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNXz0-0007P4-OE
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 03:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iNXnH-00079M-I5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iNXnD-0007dg-Qj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28830
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1iNXnD-0007dA-KZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9O7glwO066108
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:44:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vu5qtm70g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:44:21 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Thu, 24 Oct 2019 08:44:19 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 08:44:16 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9O7hgLA36110836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 07:43:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 144D042047;
 Thu, 24 Oct 2019 07:44:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF98A42041;
 Thu, 24 Oct 2019 07:44:12 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 07:44:12 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v17 5/7] ppc: spapr: Handle "ibm, nmi-register" and "ibm,
 nmi-interlock" RTAS calls
Date: Thu, 24 Oct 2019 13:13:05 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19102407-0020-0000-0000-0000037DAADF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102407-0021-0000-0000-000021D3EFE7
Message-Id: <20191024074307.22821-6-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240074
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
Cc: paulus@ozlabs.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 arawinda.p@gmail.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aravinda Prasad <arawinda.p@gmail.com>

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
when the error log is consumed.

[Move fwnmi registeration to .apply hook]
Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
---
 hw/ppc/spapr_caps.c    |  9 +++++--
 hw/ppc/spapr_rtas.c    | 57 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 +++-
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 976d709210..1675ebd45e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -509,9 +509,14 @@ static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
          * of software injected faults like duplicate SLBs).
          */
         warn_report("Firmware Assisted Non-Maskable Interrupts not supported in TCG");
-    } else if (kvm_enabled() && (kvmppc_set_fwnmi() != 0)) {
-        error_setg(errp,
+    } else if (kvm_enabled()) {
+        if (!kvmppc_set_fwnmi()) {
+            /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
+            spapr_fwnmi_register();
+        } else {
+            error_setg(errp,
 "Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap-fwnmi-mce=off");
+        }
     }
 }
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 2c066a372d..0328b1f341 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -400,6 +400,55 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
+static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
+                                  SpaprMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args,
+                                  uint32_t nret, target_ulong rets)
+{
+    hwaddr rtas_addr = spapr_get_rtas_addr();
+
+    if (!rtas_addr) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
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
+    if (spapr->guest_machine_check_addr == -1) {
+        /* NMI register not called */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    if (spapr->mc_status != cpu->vcpu_id) {
+        /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    /*
+     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
+     * hence unset mc_status.
+     */
+    spapr->mc_status = -1;
+    qemu_cond_signal(&spapr->mc_delivery_cond);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -503,6 +552,14 @@ hwaddr spapr_get_rtas_addr(void)
     return (hwaddr)fdt32_to_cpu(*rtas_data);
 }
 
+void spapr_fwnmi_register(void)
+{
+    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
+                        rtas_ibm_nmi_register);
+    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
+                        rtas_ibm_nmi_interlock);
+}
+
 static void core_rtas_register_types(void)
 {
     spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4afa8d4d09..86f0fc8fdd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -653,8 +653,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
 #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
+#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
@@ -907,4 +909,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
+void spapr_fwnmi_register(void);
 #endif /* HW_SPAPR_H */
-- 
2.17.2


