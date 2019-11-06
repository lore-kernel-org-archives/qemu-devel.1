Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B16C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E20217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E20217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKa0-0003Rq-B5
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSKWx-0007qe-Si
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSKWv-0005Kp-1d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSKWu-0005Jw-MC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:20 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D78D83F3F
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 12:35:19 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id s3so24587521qkd.6
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ayKbAFLuOylXFx4QOvYTwafMKFK8Oyh1afctsP3WaJg=;
 b=o1ZZa1kMF9rI+HdQSBZZEnGpZOOYInly9aZvAWm40p3r+ypaeyX7wrwaPS/AD0pWi8
 +gFpBR9ChDu3JhV92+SK6yUNMMGFH7TpZbHaVoOpAbLeoSuvXJk3vWsnCJcm/MCgBrkw
 tT3TdTDJ1YVFDZHNasWQm3ytutT6mZWpnCXHZwktXFWnARcZoYC5Y1gNmLKOEaMj4ag6
 +Kiv4L091aFN3jybROxSD29w39+//217+w8I3d7KYj70CRpWUcukF2h1Mgq4J/ioDydU
 xQZooQfWLPoKjaomAjcXJ3rMpOxbgJspdWmiXiGbO9bdf/A9FEkyz8xqiYfLVZqiZ58Z
 4CLg==
X-Gm-Message-State: APjAAAWYfBlqmqD0CwVUXIVdRno/xhZy9IpwLxtf6GY19xQGX/Yfm66T
 IMxHa/7SXO4AqM+ijNVM66ccvJAPV71AeEPdE+qUZkufHe5srBDkGm/AoBr0csMFjUD5yir0dmV
 JFJ1B4M8yDjTXDTY=
X-Received: by 2002:ad4:408d:: with SMTP id l13mr2002133qvp.49.1573043718159; 
 Wed, 06 Nov 2019 04:35:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2p5mjethekeHAIvITy6WstnadxAQrepg7DHKnB3pRjzlm5ddWghBB0TiQw1Lc/Z8r3pF5bg==
X-Received: by 2002:ad4:408d:: with SMTP id l13mr2002099qvp.49.1573043717801; 
 Wed, 06 Nov 2019 04:35:17 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id o2sm12431070qkf.68.2019.11.06.04.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 04:35:17 -0800 (PST)
Date: Wed, 6 Nov 2019 07:35:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] pci: Use PCI aliases when determining device IOMMU
 address space
Message-ID: <20191106123407.20997-2-mst@redhat.com>
References: <20191106123407.20997-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106123407.20997-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Williamson <alex.williamson@redhat.com>

PCIe requester IDs are used by modern IOMMUs to differentiate devices
in order to provide a unique IOVA address space per device.  These
requester IDs are composed of the bus/device/function (BDF) of the
requesting device.  Conventional PCI pre-dates this concept and is
simply a shared parallel bus where transactions are claimed by
decoding target ranges rather than the packetized, point-to-point
mechanisms of PCI-express.  In order to interface conventional PCI
to PCIe, the PCIe-to-PCI bridge creates and accepts packetized
transactions on behalf of all downstream devices, using one of two
potential forms of a requester ID relating to the bridge itself or its
subordinate bus.  All downstream devices are therefore aliased by the
bridge's requester ID and it's not possible for the IOMMU to create
unique IOVA spaces for devices downstream of such buses.

At least that's how it works on bare metal.  Until now point we've
ignored this nuance of vIOMMU support in QEMU, creating a unique
AddressSpace per device regardless of the virtual bus topology.

Aside from simply being true to bare metal behavior, there are aspects
of a shared address space that we can use to our advantage when
designing a VM.  For instance, a PCI device assignment scenario where
we have the following IOMMU group on the host system:

  $ ls  /sys/kernel/iommu_groups/1/devices/
  0000:00:01.0  0000:01:00.0  0000:01:00.1

An IOMMU group is considered the smallest set of devices which are
fully DMA isolated from other devices by the IOMMU.  In this case the
root port at 00:01.0 does not guarantee that it prevents peer to peer
traffic between the endpoints on bus 01: and the devices are therefore
grouped together.  VFIO considers an IOMMU group to be the smallest
unit of device ownership and allows only a single shared IOVA space
per group due to the limitations of the isolation.

Therefore, if we attempt to create the following VM, we get an error:

qemu-system-x86_64 -machine q35... \
  -device intel-iommu,intremap=on \
  -device pcie-root-port,addr=1e.0,id=pcie.1 \
  -device vfio-pci,host=1:00.0,bus=pcie.1,addr=0.0,multifunction=on \
  -device vfio-pci,host=1:00.1,bus=pcie.1,addr=0.1

qemu-system-x86_64: -device vfio-pci,host=1:00.1,bus=pcie.1,addr=0.1: vfio \
0000:01:00.1: group 1 used in multiple address spaces

VFIO only allows a single IOVA space (AddressSpace) for both devices,
but we've placed them into a topology where the vIOMMU expects a
separate AddressSpace for each device.  On bare metal we know that
a conventional PCI bus would provide the sort of aliasing we need
here, forcing the IOMMU to consider these devices to be part of a
single shared IOVA space.  The support provided here does the same
for QEMU, such that we can create a conventional PCI topology to
expose equivalent AddressSpace sharing requirements to the VM:

qemu-system-x86_64 -machine q35... \
  -device intel-iommu,intremap=on \
  -device pcie-pci-bridge,addr=1e.0,id=pci.1 \
  -device vfio-pci,host=1:00.0,bus=pci.1,addr=1.0,multifunction=on \
  -device vfio-pci,host=1:00.1,bus=pci.1,addr=1.1

There are pros and cons to this configuration; it's not necessarily
recommended, it's simply a tool we can use to create configurations
which may provide additional functionality in spite of host hardware
limitations or as a benefit to the guest configuration or resource
usage.  An incomplete list of pros and cons:

Cons:
 a) Extended PCI configuration space is unavailable to devices
    downstream of a conventional PCI bus.  The degree to which this
    is a drawback depends on the device and guest drivers.
 b) Applying this topology to devices which are already isolated by
    the host IOMMU (singleton IOMMU groups) will result in devices
    which appear to be non-isolated to the VM (non-singleton groups).
    This can limit configurations within the guest, such as userspace
    drivers or nested device assignment.

Pros:
 a) QEMU better emulates bare metal.
 b) Configurations as above are now possible.
 c) Host IOMMU resources and VM locked memory requirements are reduced
    in vIOMMU configurations due to shared IOMMU domains on the host
    and avoidance of duplicate locked memory accounting.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <157187083548.5439.14747141504058604843.stgit@gimli.home>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c68498c0de..cbc7a32568 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2646,12 +2646,49 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
+    uint8_t devfn = dev->devfn;
 
-    while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
-        iommu_bus = pci_get_bus(iommu_bus->parent_dev);
+    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
+        PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
+
+        /*
+         * The requester ID of the provided device may be aliased, as seen from
+         * the IOMMU, due to topology limitations.  The IOMMU relies on a
+         * requester ID to provide a unique AddressSpace for devices, but
+         * conventional PCI buses pre-date such concepts.  Instead, the PCIe-
+         * to-PCI bridge creates and accepts transactions on behalf of down-
+         * stream devices.  When doing so, all downstream devices are masked
+         * (aliased) behind a single requester ID.  The requester ID used
+         * depends on the format of the bridge devices.  Proper PCIe-to-PCI
+         * bridges, with a PCIe capability indicating such, follow the
+         * guidelines of chapter 2.3 of the PCIe-to-PCI/X bridge specification,
+         * where the bridge uses the seconary bus as the bridge portion of the
+         * requester ID and devfn of 00.0.  For other bridges, typically those
+         * found on the root complex such as the dmi-to-pci-bridge, we follow
+         * the convention of typical bare-metal hardware, which uses the
+         * requester ID of the bridge itself.  There are device specific
+         * exceptions to these rules, but these are the defaults that the
+         * Linux kernel uses when determining DMA aliases itself and believed
+         * to be true for the bare metal equivalents of the devices emulated
+         * in QEMU.
+         */
+        if (!pci_bus_is_express(iommu_bus)) {
+            PCIDevice *parent = iommu_bus->parent_dev;
+
+            if (pci_is_express(parent) &&
+                pcie_cap_get_type(parent) == PCI_EXP_TYPE_PCI_BRIDGE) {
+                devfn = PCI_DEVFN(0, 0);
+                bus = iommu_bus;
+            } else {
+                devfn = parent->devfn;
+                bus = parent_bus;
+            }
+        }
+
+        iommu_bus = parent_bus;
     }
     if (iommu_bus && iommu_bus->iommu_fn) {
-        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devfn);
+        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
     }
     return &address_space_memory;
 }
-- 
MST


