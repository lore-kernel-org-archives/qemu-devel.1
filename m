Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686CC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AC320B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AC320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbV3l-0001IV-Cn
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbSqc-0001aw-H0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbSqa-0007c8-OZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbSqa-0007VO-AI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DGgeTI101833
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:45:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t3sdujhw5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:45:06 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 13 Jun 2019 17:45:03 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 17:45:01 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5DGj0U052166802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 16:45:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F3F1A404D;
 Thu, 13 Jun 2019 16:45:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE1B1A4040;
 Thu, 13 Jun 2019 16:44:59 +0000 (GMT)
Received: from bahia.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.41])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2019 16:44:59 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Jun 2019 18:44:59 +0200
In-Reply-To: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061316-0008-0000-0000-000002F38424
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061316-0009-0000-0000-000022608B4A
Message-Id: <156044429963.125694.13710679451927268758.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 2/3] xics/spapr: Register RTAS/hypercalls once
 at machine init
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU may crash when running a spapr machine in 'dual' interrupt controller
mode on some older (but not that old, eg. ubuntu 18.04.2) KVMs with partial
XIVE support:

qemu-system-ppc64: hw/ppc/spapr_rtas.c:411: spapr_rtas_register:
 Assertion `!name || !rtas_table[token].name' failed.

XICS is controlled by the guest thanks to a set of RTAS calls. Depending
on whether KVM XICS is used or not, the RTAS calls are handled by KVM or
QEMU. In both cases, QEMU needs to expose the RTAS calls to the guest
through the "rtas" node of the device tree.

The spapr_rtas_register() helper takes care of all of that: it adds the
RTAS call token to the "rtas" node and registers a QEMU callback to be
invoked when the guest issues the RTAS call. In the KVM XICS case, QEMU
registers a dummy callback that just prints an error since it isn't
supposed to be invoked, ever.

Historically, the XICS controller was setup during machine init and
released during final teardown. This changed when the 'dual' interrupt
controller mode was added to the spapr machine: in this case we need
to tear the XICS down and set it up again during machine reset. The
crash happens because we indeed have an incompatibility with older
KVMs that forces QEMU to fallback on emulated XICS, which tries to
re-registers the same RTAS calls.

This could be fixed by adding proper rollback that would unregister
RTAS calls on error. But since the emulated RTAS calls in QEMU can
now detect when they are mistakenly called while KVM XICS is in
use, it seems simpler to register them once and for all at machine
init. This fixes the crash and allows to remove some now useless
lines of code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c          |   19 -------------------
 hw/intc/xics_spapr.c        |    8 --------
 hw/ppc/spapr_irq.c          |    3 ++-
 include/hw/ppc/spapr.h      |    4 ----
 include/hw/ppc/xics.h       |    1 -
 include/hw/ppc/xics_spapr.h |    1 +
 6 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 5ba5b775615e..5c4208f43008 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -331,15 +331,6 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
     }
 }
 
-static void rtas_dummy(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                       uint32_t token,
-                       uint32_t nargs, target_ulong args,
-                       uint32_t nret, target_ulong rets)
-{
-    error_report("pseries: %s must never be called for in-kernel XICS",
-                 __func__);
-}
-
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
 {
     int rc;
@@ -360,11 +351,6 @@ int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
         goto fail;
     }
 
-    spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_dummy);
-    spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_dummy);
-    spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_dummy);
-    spapr_rtas_register(RTAS_IBM_INT_ON, "ibm,int-on", rtas_dummy);
-
     rc = kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-xive");
     if (rc < 0) {
         error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xive");
@@ -454,11 +440,6 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
     close(kernel_xics_fd);
     kernel_xics_fd = -1;
 
-    spapr_rtas_unregister(RTAS_IBM_SET_XIVE);
-    spapr_rtas_unregister(RTAS_IBM_GET_XIVE);
-    spapr_rtas_unregister(RTAS_IBM_INT_OFF);
-    spapr_rtas_unregister(RTAS_IBM_INT_ON);
-
     kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index d470ab5f7a2a..8d605b68a7a0 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -285,14 +285,6 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
 void xics_spapr_init(SpaprMachineState *spapr)
 {
-    /* Emulated mode can only be initialized once. */
-    if (spapr->ics->init) {
-        return;
-    }
-
-    spapr->ics->init = true;
-
-    /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive);
     spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive);
     spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 3156daf09381..dfb99f35ea00 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -114,6 +114,8 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
     }
 
     spapr->ics = ICS_BASE(obj);
+
+    xics_spapr_init(spapr);
 }
 
 #define ICS_IRQ_FREE(ics, srcno)   \
@@ -236,7 +238,6 @@ static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spapr)
 
 static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **errp)
 {
-    xics_spapr_init(spapr);
 }
 
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4f5becf1f3cc..60553d32c4fa 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -676,10 +676,6 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                               uint32_t nargs, target_ulong args,
                               uint32_t nret, target_ulong rets);
 void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
-static inline void spapr_rtas_unregister(int token)
-{
-    spapr_rtas_register(token, NULL, NULL);
-}
 target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *sm,
                              uint32_t token, uint32_t nargs, target_ulong args,
                              uint32_t nret, target_ulong rets);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index d6f8e4c4c282..eb65ad7e43b7 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -119,7 +119,6 @@ struct ICSState {
     uint32_t offset;
     ICSIRQState *irqs;
     XICSFabric *xics;
-    bool init; /* sPAPR ICS device initialized */
 };
 
 #define ICS_PROP_XICS "xics"
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 2476b540edfa..6c1d9ee55945 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -36,5 +36,6 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 void xics_spapr_init(SpaprMachineState *spapr);
+void xics_spapr_connect(SpaprMachineState *spapr);
 
 #endif /* XICS_SPAPR_H */


