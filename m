Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B02C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B2B20645
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTWy-0006bK-7O
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbSqj-0001sB-NJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbSqi-000869-0A
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35990
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbSqh-00085j-Hj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DGi1mh164545
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:45:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t3rv6m0q3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:45:10 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 13 Jun 2019 17:45:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 17:45:06 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5DGj51339190780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 16:45:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92076A4062;
 Thu, 13 Jun 2019 16:45:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A698A4054;
 Thu, 13 Jun 2019 16:45:05 +0000 (GMT)
Received: from bahia.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.41])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2019 16:45:05 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Jun 2019 18:45:05 +0200
In-Reply-To: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061316-4275-0000-0000-00000342132B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061316-4276-0000-0000-000038522E0D
Message-Id: <156044430517.125694.6207865998817342638.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 3/3] xics/spapr: Detect old KVM XICS on POWER9
 hosts
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

Older KVMs on POWER9 don't support destroying/recreating a KVM XICS
device, which is required by 'dual' interrupt controller mode. This
causes QEMU to emit a warning when the guest is rebooted and to fall
back on XICS emulation:

qemu-system-ppc64: warning: kernel_irqchip allowed but unavailable:
 Error on KVM_CREATE_DEVICE for XICS: File exists

If kernel irqchip is required, QEMU will thus exit when the guest is
first rebooted. Failing QEMU this late may be a painful experience
for the user.

Detect that and exit at machine init instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 docs/specs/ppc-spapr-xive.rst |    4 ++--
 hw/intc/xics_kvm.c            |   30 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_irq.c            |   13 +++++++++++++
 include/hw/ppc/xics_spapr.h   |    1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
index 7a64c9d04951..6159bc6eed62 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -142,8 +142,8 @@ xics            XICS KVM       XICS emul.     XICS KVM
 (3) QEMU fails at CAS with ``Guest requested unavailable interrupt
     mode (XICS), either don't set the ic-mode machine property or try
     ic-mode=xics or ic-mode=dual``
-(4) QEMU/KVM incompatibility due to device destruction in reset. This
-    needs to be addressed more cleanly with an error.
+(4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fails
+    with ``KVM is too old to support ic-mode=dual,kernel-irqchip=on``
 
 
 XIVE Device tree properties
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 5c4208f43008..c7f8f5edd257 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -452,3 +452,33 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
     /* Clear the presenter from the VCPUs */
     kvm_disable_icps();
 }
+
+/*
+ * This is a heuristic to detect older KVMs on POWER9 hosts that don't
+ * support destruction of a KVM XICS device while the VM is running.
+ * Required to start a spapr machine with ic-mode=dual,kernel-irqchip=on.
+ */
+bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr)
+{
+    int rc;
+
+    rc = kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
+    if (rc < 0) {
+        /*
+         * The error is ignored on purpose. The KVM XICS setup code
+         * will catch it again anyway. The goal here is to see if
+         * close() actually destroys the device or not.
+         */
+        return false;
+    }
+
+    close(rc);
+
+    rc = kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
+    if (rc >= 0) {
+        close(rc);
+        return false;
+    }
+
+    return errno == EEXIST;
+}
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index dfb99f35ea00..75654fc67aba 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -669,6 +669,19 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
             return;
         }
     }
+
+    /*
+     * On a POWER9 host, some older KVM XICS devices cannot be destroyed and
+     * re-created. Detect that early to avoid QEMU to exit later when the
+     * guest reboots.
+     */
+    if (kvm_enabled() &&
+        spapr->irq == &spapr_irq_dual &&
+        machine_kernel_irqchip_required(machine) &&
+        xics_kvm_has_broken_disconnect(spapr)) {
+        error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
+        return;
+    }
 }
 
 /*
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 6c1d9ee55945..d968f2499ca7 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -35,6 +35,7 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle);
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
+bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
 void xics_spapr_init(SpaprMachineState *spapr);
 void xics_spapr_connect(SpaprMachineState *spapr);
 


