Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D5C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F181B2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181B2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFre-0000ca-4N
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45746)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1heFpr-0007Si-4N
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1heFpo-0001gB-1A
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:27:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1heFpn-0001cV-NP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:27:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5L9ODNm032710
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 05:27:41 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t8tq8530r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 05:27:41 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 21 Jun 2019 10:27:38 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Jun 2019 10:27:35 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x5L9RPhI38470076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 09:27:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 535BD11C069;
 Fri, 21 Jun 2019 09:27:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DDE211C05E;
 Fri, 21 Jun 2019 09:27:34 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.7.212])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2019 09:27:34 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 21 Jun 2019 11:27:33 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062109-0016-0000-0000-0000028B1E77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062109-0017-0000-0000-000032E880BD
Message-Id: <156110925375.92514.11649846071216864570.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-21_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] spapr_pci: Unregister listeners before
 destroying the IOMMU address space
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hot-unplugging a PHB with a VFIO device connected to it crashes QEMU:

-device spapr-pci-host-bridge,index=1,id=phb1 \
-device vfio-pci,host=0034:01:00.3,id=vfio0

(qemu) device_del phb1
[  357.207183] iommu: Removing device 0001:00:00.0 from group 1
[  360.375523] rpadlpar_io: slot PHB 1 removed
qemu-system-ppc64: memory.c:2742:
 do_address_space_destroy: Assertion `QTAILQ_EMPTY(&as->listeners)' failed.

'as' is the IOMMU address space, which indeed has a listener registered
to by vfio_connect_container() when the VFIO device is realized. This
listener is supposed to be unregistered by vfio_disconnect_container()
when the VFIO device is finalized. Unfortunately, the VFIO device hasn't
reached finalize yet at the time the PHB unrealize function is called,
and address_space_destroy() gets called with the VFIO listener still
being registered.

All regions have just been unmapped from the address space. Listeners
aren't needed anymore at this point. Remove them before destroying the
address space.

The VFIO code will try to remove them _again_ at device finalize,
but it is okay since memory_listener_unregister() is idempotent.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c    |    6 ++++++
 include/exec/memory.h |   10 ++++++++++
 memory.c              |    7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 2dca1e57f36c..eee92b102d5c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1788,6 +1788,12 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
 
     memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
 
+    /*
+     * An attached PCI device may have memory listeners, eg. VFIO PCI. We have
+     * unmapped all sections. Remove the listeners now, before destroying the
+     * address space.
+     */
+    address_space_remove_listeners(&sphb->iommu_as);
     address_space_destroy(&sphb->iommu_as);
 
     qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e6140e8a0489..1ba2e89aa8ce 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1757,6 +1757,16 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
  */
 void address_space_destroy(AddressSpace *as);
 
+/**
+ * address_space_remove_listeners: unregister all listerners of an address space
+ *
+ * Removes all callbacks previously registered with memory_listener_register()
+ * for @as.
+ *
+ * @as: an initialized #AddressSpace
+ */
+void address_space_remove_listeners(AddressSpace *as);
+
 /**
  * address_space_rw: read from or write to an address space.
  *
diff --git a/memory.c b/memory.c
index 0a089a73ae1a..480f3d989b4f 100644
--- a/memory.c
+++ b/memory.c
@@ -2723,6 +2723,13 @@ void memory_listener_unregister(MemoryListener *listener)
     listener->address_space = NULL;
 }
 
+void address_space_remove_listeners(AddressSpace *as)
+{
+    while (!QTAILQ_EMPTY(&as->listeners)) {
+        memory_listener_unregister(QTAILQ_FIRST(&as->listeners));
+    }
+}
+
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);


