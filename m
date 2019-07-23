Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE3C76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB185218B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB185218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyYi-0005o8-1c
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51735)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hpyYW-0005PC-Um
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hpyYV-0000UA-FZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hpyYV-0000Th-7i
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A80B3C938;
 Tue, 23 Jul 2019 17:26:26 +0000 (UTC)
Received: from x1.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3055D60A9F;
 Tue, 23 Jul 2019 17:26:19 +0000 (UTC)
Date: Tue, 23 Jul 2019 11:26:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190723112618.0efafa8d@x1.home>
In-Reply-To: <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 23 Jul 2019 17:26:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Apr 2019 13:41:39 +0000
"Singh, Brijesh" <brijesh.singh@amd.com> wrote:

> Thanks for adding Alex.
> 
> Adding Suravee.
> 
> 
> On 3/29/19 11:49 AM, Alex Williamson wrote:
> > [Cc +Brijesh]
> > 
> > Hi Brijesh, will the change below require the IVRS to be updated to
> > include aliases for all BDF ranges behind a conventional bridge?  I
> > think the Linux code handles this regardless of the firmware provided
> > aliases, but is it required per spec for the ACPI tables to include
> > bridge aliases?  Thanks,
> >   
> 
> We do need to includes aliases in ACPI table. We need to populate the
> IVHD type 0x43 and 0x4 for alias range start and end. I believe host
> IVRS would contain similar information.
> 
> Suravee, please correct me if I am missing something?

I finally found some time to investigate this a little further, yes the
types mentioned are correct for defining start and end of an alias
range.  The challenge here is that these entries require a DeviceID,
which is defined as a BDF, AIUI.  The IVRS is created in QEMU, but bus
numbers are defined by the guest firmware, and potentially redefined by
the guest OS.  This makes it non-trivial to insert a few IVHDs into the
IVRS to describe alias ranges.  I'm wondering if the solution here is
to define a new linker-loader command that would instruct the guest to
write a bus number byte to a given offset for a described device.
These commands would be inserted before the checksum command, such that
these bus number updates are calculated as part of the checksum.

I'm imagining the command format would need to be able to distinguish
between the actual bus number of a described device, the secondary bus
number of the device, and the subordinate bus number of the device.
For describing the device, I'm envisioning stealing from the DMAR
definition, which already includes a bus number invariant mechanism to
describe a device, starting with a segment and root bus, follow a chain
of devfns to get to the target device.  Therefore the guest firmware
would follow the path to the described device, pick the desired bus
number, and write it to the indicated table offset.

Does this seem like a reasonable approach?  Better ideas?  I'm not
thrilled with the increased scope demanded by IVRS support, but so long
as we have an AMD IOMMU model, I don't see how to avoid it.  Thanks,

Alex

> > On Tue, 26 Mar 2019 16:55:19 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> >> Conventional PCI buses pre-date requester IDs.  An IOMMU cannot
> >> distinguish by devfn & bus between devices in a conventional PCI
> >> topology and therefore we cannot assign them separate AddressSpaces.
> >> By taking this requester ID aliasing into account, QEMU better matches
> >> the bare metal behavior and restrictions, and enables shared
> >> AddressSpace configurations that are otherwise not possible with
> >> guest IOMMU support.
> >>
> >> For the latter case, given any example where an IOMMU group on the
> >> host includes multiple devices:
> >>
> >>    $ ls  /sys/kernel/iommu_groups/1/devices/
> >>    0000:00:01.0  0000:01:00.0  0000:01:00.1
> >>
> >> If we incorporate a vIOMMU into the VM configuration, we're restricted
> >> that we can only assign one of the endpoints to the guest because a
> >> second endpoint will attempt to use a different AddressSpace.  VFIO
> >> only supports IOMMU group level granularity at the container level,
> >> preventing this second endpoint from being assigned:
> >>
> >> qemu-system-x86_64 -machine q35... \
> >>    -device intel-iommu,intremap=on \
> >>    -device pcie-root-port,addr=1e.0,id=pcie.1 \
> >>    -device vfio-pci,host=1:00.0,bus=pcie.1,addr=0.0,multifunction=on \
> >>    -device vfio-pci,host=1:00.1,bus=pcie.1,addr=0.1
> >>
> >> qemu-system-x86_64: -device vfio-pci,host=1:00.1,bus=pcie.1,addr=0.1: vfio \
> >> 0000:01:00.1: group 1 used in multiple address spaces
> >>
> >> However, when QEMU incorporates proper aliasing, we can make use of a
> >> PCIe-to-PCI bridge to mask the requester ID, resulting in a hack that
> >> provides the downstream devices with the same AddressSpace, ex:
> >>
> >> qemu-system-x86_64 -machine q35... \
> >>    -device intel-iommu,intremap=on \
> >>    -device pcie-pci-bridge,addr=1e.0,id=pci.1 \
> >>    -device vfio-pci,host=1:00.0,bus=pci.1,addr=1.0,multifunction=on \
> >>    -device vfio-pci,host=1:00.1,bus=pci.1,addr=1.1
> >>
> >> While the utility of this hack may be limited, this AddressSpace
> >> aliasing is the correct behavior for QEMU to emulate bare metal.
> >>
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>   hw/pci/pci.c |   33 +++++++++++++++++++++++++++++++--
> >>   1 file changed, 31 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 35451c1e9987..38467e676f1f 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -2594,12 +2594,41 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> >>   {
> >>       PCIBus *bus = pci_get_bus(dev);
> >>       PCIBus *iommu_bus = bus;
> >> +    uint8_t devfn = dev->devfn;
> >>   
> >>       while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> >> -        iommu_bus = pci_get_bus(iommu_bus->parent_dev);
> >> +        PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> >> +
> >> +        /*
> >> +         * Determine which requester ID alias should be used for the device
> >> +         * based on the PCI topology.  There are no requester IDs on convetional
> >> +         * PCI buses, therefore we push the alias up to the parent on each non-
> >> +         * express bus.  Which alias we use depends on whether this is a legacy
> >> +         * PCI bridge or PCIe-to-PCI/X bridge as in chapter 2.3 of the PCIe-to-
> >> +         * PCI bridge spec.  Note that we cannot use pci_requester_id() here
> >> +         * because the resulting BDF depends on the secondary bridge register
> >> +         * programming.  We also cannot lookup the PCIBus from the bus number
> >> +         * at this point for the iommu_fn.  Also, requester_id_cache is the
> >> +         * alias to the root bus, which is usually, but not necessarily always
> >> +         * where we'll find our iommu_fn.
> >> +         */
> >> +        if (!pci_bus_is_express(iommu_bus)) {
> >> +            PCIDevice *parent = iommu_bus->parent_dev;
> >> +
> >> +            if (pci_is_express(parent) &&
> >> +                pcie_cap_get_type(parent) == PCI_EXP_TYPE_PCI_BRIDGE) {
> >> +                devfn = PCI_DEVFN(0, 0);
> >> +                bus = iommu_bus;
> >> +            } else {
> >> +                devfn = parent->devfn;
> >> +                bus = parent_bus;
> >> +            }
> >> +        }
> >> +
> >> +        iommu_bus = parent_bus;
> >>       }
> >>       if (iommu_bus && iommu_bus->iommu_fn) {
> >> -        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devfn);
> >> +        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
> >>       }
> >>       return &address_space_memory;
> >>   }
> >>  
> >   


