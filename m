Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52979C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A11320665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A11320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwJ5-0000Iw-Ej
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hhwHF-0006zC-Eo
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hhwHE-0007pn-9L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:23:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61544
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hhwHE-0007pB-4I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:23:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x61DNGu5121534
 for <qemu-devel@nongnu.org>; Mon, 1 Jul 2019 09:23:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tfhnmwgtm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 09:23:20 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 1 Jul 2019 14:22:39 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Jul 2019 14:22:38 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x61DMbCu46989500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jul 2019 13:22:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 367CDA405B;
 Mon,  1 Jul 2019 13:22:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07324A4054;
 Mon,  1 Jul 2019 13:22:37 +0000 (GMT)
Received: from [9.208.6.17] (unknown [9.145.83.142])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jul 2019 13:22:36 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Mon, 01 Jul 2019 15:22:36 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 19070113-4275-0000-0000-000003480DBD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070113-4276-0000-0000-00003858210C
Message-Id: <156198735673.293938.7313195993600841641.stgit@bahia>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-01_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010165
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x61DNGu5121534
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [REPOST PATCH for-4.1] spapr/xive: Add proper rollback
 to kvmppc_xive_connect()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make kvmppc_xive_disconnect() able to undo the changes of a partial
execution of kvmppc_xive_connect() and use it to perform rollback.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

David,

This is the only pending fix for XIVE, rebased on ppc-for-4.1.

SHA1 d6923ffa0748af614e7d2c82d6cb76b8078dfaf5
---
 hw/intc/spapr_xive_kvm.c |   48 ++++++++++++++++++++++++++++------------=
------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5559f8bce5ef..3bf8e7a20e14 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -724,8 +724,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
     xsrc->esb_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, =
esb_len,
                                       &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto fail;
     }
=20
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
@@ -743,8 +742,7 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
     xive->tm_mmap =3D kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, =
tima_len,
                                      &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto fail;
     }
     memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
                                       "xive.tima", tima_len, xive->tm_mm=
ap);
@@ -760,21 +758,24 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
=20
         kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
         if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+            goto fail;
         }
     }
=20
     /* Update the KVM sources */
     kvmppc_xive_source_reset(xsrc, &local_err);
     if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+        goto fail;
     }
=20
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
+    return;
+
+fail:
+    error_propagate(errp, local_err);
+    kvmppc_xive_disconnect(xive, NULL);
 }
=20
 void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
@@ -796,23 +797,29 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error =
**errp)
     xsrc =3D &xive->source;
     esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
=20
-    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
-    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
-    munmap(xsrc->esb_mmap, esb_len);
-    xsrc->esb_mmap =3D NULL;
+    if (xsrc->esb_mmap) {
+        memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm=
);
+        object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
+        munmap(xsrc->esb_mmap, esb_len);
+        xsrc->esb_mmap =3D NULL;
+    }
=20
-    memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
-    object_unparent(OBJECT(&xive->tm_mmio_kvm));
-    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
-    xive->tm_mmap =3D NULL;
+    if (xive->tm_mmap) {
+        memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
+        object_unparent(OBJECT(&xive->tm_mmio_kvm));
+        munmap(xive->tm_mmap, 4ull << TM_SHIFT);
+        xive->tm_mmap =3D NULL;
+    }
=20
     /*
      * When the KVM device fd is closed, the KVM device is destroyed
      * and removed from the list of devices of the VM. The VCPU
      * presenters are also detached from the device.
      */
-    close(xive->fd);
-    xive->fd =3D -1;
+    if (xive->fd !=3D -1) {
+        close(xive->fd);
+        xive->fd =3D -1;
+    }
=20
     kvm_kernel_irqchip =3D false;
     kvm_msi_via_irqfd_allowed =3D false;
@@ -822,5 +829,8 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **=
errp)
     kvm_cpu_disable_all();
=20
     /* VM Change state handler is not needed anymore */
-    qemu_del_vm_change_state_handler(xive->change);
+    if (xive->change) {
+        qemu_del_vm_change_state_handler(xive->change);
+        xive->change =3D NULL;
+    }
 }


