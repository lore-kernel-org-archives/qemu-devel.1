Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DDC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 17:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BD720870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 17:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BD720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcYs6-0004iq-OO
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 13:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44688)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcYra-0004E3-5B
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 13:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcYrY-0008CE-Ta
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 13:22:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35226
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcYrY-000873-Og
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 13:22:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5GHGw5g126400
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 13:22:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t5drs8h3g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 13:22:28 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sun, 16 Jun 2019 18:22:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 16 Jun 2019 18:22:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5GHMOqE34144442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Jun 2019 17:22:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1752AE055;
 Sun, 16 Jun 2019 17:22:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1DD8AE045;
 Sun, 16 Jun 2019 17:22:23 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Jun 2019 17:22:23 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 16 Jun 2019 19:22:23 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061617-0012-0000-0000-000003299BD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061617-0013-0000-0000-00002162B085
Message-Id: <156070574343.343123.16772707632470400458.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160167
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] spapr/xive: Add proper rollback to
 kvmppc_xive_connect()
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make kvmppc_xive_disconnect() able to undo the changes of a partial
execution of kvmppc_xive_connect() and use it to perform rollback.

Based-on: <20190614165920.12670-2-clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive_kvm.c |   48 ++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5559f8bce5ef..3bf8e7a20e14 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -724,8 +724,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
     xsrc->esb_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
                                       &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto fail;
     }
 
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
@@ -743,8 +742,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
     xive->tm_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
                                      &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto fail;
     }
     memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
                                       "xive.tima", tima_len, xive->tm_mmap);
@@ -760,21 +758,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
 
         kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
         if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+            goto fail;
         }
     }
 
     /* Update the KVM sources */
     kvmppc_xive_source_reset(xsrc, &local_err);
     if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+        goto fail;
     }
 
     kvm_kernel_irqchip = true;
     kvm_msi_via_irqfd_allowed = true;
     kvm_gsi_direct_mapping = true;
+    return;
+
+fail:
+    error_propagate(errp, local_err);
+    kvmppc_xive_disconnect(xive, NULL);
 }
 
 void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
@@ -796,23 +797,29 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
     xsrc = &xive->source;
     esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
 
-    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
-    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
-    munmap(xsrc->esb_mmap, esb_len);
-    xsrc->esb_mmap = NULL;
+    if (xsrc->esb_mmap) {
+        memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
+        object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
+        munmap(xsrc->esb_mmap, esb_len);
+        xsrc->esb_mmap = NULL;
+    }
 
-    memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
-    object_unparent(OBJECT(&xive->tm_mmio_kvm));
-    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
-    xive->tm_mmap = NULL;
+    if (xive->tm_mmap) {
+        memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
+        object_unparent(OBJECT(&xive->tm_mmio_kvm));
+        munmap(xive->tm_mmap, 4ull << TM_SHIFT);
+        xive->tm_mmap = NULL;
+    }
 
     /*
      * When the KVM device fd is closed, the KVM device is destroyed
      * and removed from the list of devices of the VM. The VCPU
      * presenters are also detached from the device.
      */
-    close(xive->fd);
-    xive->fd = -1;
+    if (xive->fd != -1) {
+        close(xive->fd);
+        xive->fd = -1;
+    }
 
     kvm_kernel_irqchip = false;
     kvm_msi_via_irqfd_allowed = false;
@@ -822,5 +829,8 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
     kvm_cpu_disable_all();
 
     /* VM Change state handler is not needed anymore */
-    qemu_del_vm_change_state_handler(xive->change);
+    if (xive->change) {
+        qemu_del_vm_change_state_handler(xive->change);
+        xive->change = NULL;
+    }
 }


