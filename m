Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3964C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 18:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572AA208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 18:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572AA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcwD-00009F-Oc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hlcup-0003Ym-N0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hlcuo-0003lg-2C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hlcuk-0003gn-TQ; Thu, 11 Jul 2019 13:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EF505AFF8;
 Thu, 11 Jul 2019 17:31:26 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9715C1B4;
 Thu, 11 Jul 2019 17:31:20 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Thu, 11 Jul 2019 19:28:34 +0200
Message-Id: <20190711172845.31035-19-eric.auger@redhat.com>
In-Reply-To: <20190711172845.31035-1-eric.auger@redhat.com>
References: <20190711172845.31035-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 11 Jul 2019 17:31:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 18/29] vfio: Pass stage 1 MSI bindings to the
 host
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
 jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com, peterx@redhat.com,
 alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We register the stage1 MSI bindings when enabling the vectors
and we unregister them on container disconnection.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- use VFIO_IOMMU_SET_MSI_BINDING

v2 -> v3:
- only register the notifier if the IOMMU translates MSIs
- record the msi bindings in a container list and unregister on
  container release
---
 hw/vfio/common.c              | 52 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 51 +++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events          |  2 ++
 include/hw/vfio/vfio-common.h |  9 ++++++
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index bd975c5b83..4bbce6a43a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -490,6 +490,56 @@ static void vfio_iommu_unmap_notify(IOMMUNotifier *n=
, IOMMUTLBEntry *iotlb)
     }
 }
=20
+int vfio_iommu_set_msi_binding(VFIOContainer *container,
+                               IOMMUTLBEntry *iotlb)
+{
+    struct vfio_iommu_type1_set_msi_binding ustruct;
+    VFIOMSIBinding *binding;
+    int ret;
+
+    QLIST_FOREACH(binding, &container->msibinding_list, next) {
+        if (binding->iova =3D=3D iotlb->iova) {
+            return 0;
+        }
+    }
+
+    ustruct.argsz =3D sizeof(struct vfio_iommu_type1_set_msi_binding);
+    ustruct.iova =3D iotlb->iova;
+    ustruct.flags =3D VFIO_IOMMU_BIND_MSI;
+    ustruct.gpa =3D iotlb->translated_addr;
+    ustruct.size =3D iotlb->addr_mask + 1;
+    ret =3D ioctl(container->fd, VFIO_IOMMU_SET_MSI_BINDING , &ustruct);
+    if (ret) {
+        error_report("%s: failed to register the stage1 MSI binding (%m)=
",
+                     __func__);
+        return ret;
+    }
+    binding =3D  g_new0(VFIOMSIBinding, 1);
+    binding->iova =3D ustruct.iova;
+    binding->gpa =3D ustruct.gpa;
+    binding->size =3D ustruct.size;
+
+    QLIST_INSERT_HEAD(&container->msibinding_list, binding, next);
+    return 0;
+}
+
+static void vfio_container_unbind_msis(VFIOContainer *container)
+{
+    VFIOMSIBinding *binding, *tmp;
+
+    QLIST_FOREACH_SAFE(binding, &container->msibinding_list, next, tmp) =
{
+        struct vfio_iommu_type1_set_msi_binding ustruct;
+
+        /* the MSI doorbell is not used anymore, unregister it */
+        ustruct.argsz =3D sizeof(struct vfio_iommu_type1_set_msi_binding=
);
+        ustruct.flags =3D VFIO_IOMMU_UNBIND_MSI;
+        ustruct.iova =3D binding->iova;
+        ioctl(container->fd, VFIO_IOMMU_SET_MSI_BINDING , &ustruct);
+        QLIST_REMOVE(binding, next);
+        g_free(binding);
+    }
+}
+
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb=
)
 {
     VFIOGuestIOMMU *giommu =3D container_of(n, VFIOGuestIOMMU, n);
@@ -1589,6 +1639,8 @@ static void vfio_disconnect_container(VFIOGroup *gr=
oup)
             g_free(giommu);
         }
=20
+        vfio_container_unbind_msis(container);
+
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         g_free(container);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 729f1f353e..45e007575e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -359,6 +359,49 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
=20
+static int vfio_register_msi_binding(VFIOPCIDevice *vdev, int vector_n)
+{
+    VFIOContainer *container =3D vdev->vbasedev.group->container;
+    PCIDevice *dev =3D &vdev->pdev;
+    AddressSpace *as =3D pci_device_iommu_address_space(dev);
+    MSIMessage msg =3D pci_get_msi_message(dev, vector_n);
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUMemoryRegion *iommu_mr;
+    bool msi_translate =3D false, nested =3D false;;
+    IOMMUTLBEntry entry;
+
+    if (as =3D=3D &address_space_memory) {
+        return 0;
+    }
+
+    iommu_mr =3D IOMMU_MEMORY_REGION(as->root);
+    memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_MSI_TRANSLATE,
+                                 (void *)&msi_translate);
+    memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
+                                 (void *)&nested);
+    imrc =3D memory_region_get_iommu_class_nocheck(iommu_mr);
+
+    if (!nested || !msi_translate) {
+        return 0;
+    }
+
+    /* MSI doorbell address is translated by an IOMMU */
+
+    rcu_read_lock();
+    entry =3D imrc->translate(iommu_mr, msg.address, IOMMU_WO, 0);
+    rcu_read_unlock();
+
+    if (entry.perm =3D=3D IOMMU_NONE) {
+        return -ENOENT;
+    }
+
+    trace_vfio_register_msi_binding(vdev->vbasedev.name, vector_n,
+                                    msg.address, entry.translated_addr);
+
+    vfio_iommu_set_msi_binding(container, &entry);
+    return 0;
+}
+
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 {
     struct vfio_irq_set *irq_set;
@@ -376,7 +419,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, b=
ool msix)
     fds =3D (int32_t *)&irq_set->data;
=20
     for (i =3D 0; i < vdev->nr_vectors; i++) {
-        int fd =3D -1;
+        int ret, fd =3D -1;
=20
         /*
          * MSI vs MSI-X - The guest has direct access to MSI mask and pe=
nding
@@ -391,6 +434,12 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, =
bool msix)
             } else {
                 fd =3D event_notifier_get_fd(&vdev->msi_vectors[i].kvm_i=
nterrupt);
             }
+            ret =3D vfio_register_msi_binding(vdev, i);
+            if (ret) {
+                error_report("%s failed to register S1 MSI binding "
+                             "for vector %d(%d)", __func__, i, ret);
+                return ret;
+            }
         }
=20
         fds[i] =3D fd;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9f1868af2d..5de97a8882 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -117,6 +117,8 @@ vfio_get_dev_region(const char *name, int index, uint=
32_t type, uint32_t subtype
 vfio_dma_unmap_overflow_workaround(void) ""
 vfio_iommu_addr_inv_iotlb(int asid, uint64_t addr, uint64_t size, uint64=
_t nb_granules, bool leaf) "nested IOTLB invalidate asid=3D%d, addr=3D0x%=
"PRIx64" granule_size=3D0x%"PRIx64" nb_granules=3D0x%"PRIx64" leaf=3D%d"
 vfio_iommu_asid_inv_iotlb(int asid) "nested IOTLB invalidate asid=3D%d"
+vfio_register_msi_binding(const char *name, int vector, uint64_t giova, =
uint64_t gdb) "%s: register vector %d gIOVA=3D0x%"PRIx64 "-> gDB=3D0x%"PR=
Ix64" stage 1 mapping"
+vfio_unregister_msi_binding(const char *name, int vector, uint64_t giova=
) "%s: unregister vector %d gIOVA=3D0x%"PRIx64 " stage 1 mapping"
=20
 # platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to g=
roup #%d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 9107bd41c0..a88b4dd986 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -63,6 +63,13 @@ typedef struct VFIOAddressSpace {
     QLIST_ENTRY(VFIOAddressSpace) list;
 } VFIOAddressSpace;
=20
+typedef struct VFIOMSIBinding {
+    hwaddr iova;
+    hwaddr gpa;
+    hwaddr size;
+    QLIST_ENTRY(VFIOMSIBinding) next;
+} VFIOMSIBinding;
+
 struct VFIOGroup;
=20
 typedef struct VFIOContainer {
@@ -77,6 +84,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
+    QLIST_HEAD(, VFIOMSIBinding) msibinding_list;
     QLIST_ENTRY(VFIOContainer) next;
 } VFIOContainer;
=20
@@ -178,6 +186,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *=
as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
+int vfio_iommu_set_msi_binding(VFIOContainer *container, IOMMUTLBEntry *=
entry);
=20
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
--=20
2.20.1


