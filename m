Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382ABC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E66B206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E66B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15rh-0001ht-6X
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i15qJ-0000GF-Cf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i15qH-0002xw-TR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:26:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i15qF-0002wt-Te
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4943A30655F5;
 Fri, 23 Aug 2019 09:26:42 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCF546092D;
 Fri, 23 Aug 2019 09:26:35 +0000 (UTC)
Date: Fri, 23 Aug 2019 10:26:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Message-ID: <20190823092633.GB2784@work-vm>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-5-git-send-email-kwankhede@nvidia.com>
 <20190711120713.GM3971@work-vm>
 <d6400fd9-5f86-b9f2-a10a-1ad53813a066@nvidia.com>
 <20190822093235.GC3277@work-vm>
 <092a9a37-d018-1d6e-7c61-7f8ada8819a7@nvidia.com>
 <20190822191303.GO3277@work-vm>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D543525@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D543525@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 23 Aug 2019 09:26:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 04/13] vfio: Add save and load functions
 for VFIO PCI devices
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
Cc: "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Tian, Kevin (kevin.tian@intel.com) wrote:
> > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> > Sent: Friday, August 23, 2019 3:13 AM
> > 
> > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > >
> > >
> > > On 8/22/2019 3:02 PM, Dr. David Alan Gilbert wrote:
> > > > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > >> Sorry for delay to respond.
> > > >>
> > > >> On 7/11/2019 5:37 PM, Dr. David Alan Gilbert wrote:
> > > >>> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > >>>> These functions save and restore PCI device specific data - config
> > > >>>> space of PCI device.
> > > >>>> Tested save and restore with MSI and MSIX type.
> > > >>>>
> > > >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > >>>> ---
> > > >>>>  hw/vfio/pci.c                 | 114
> > ++++++++++++++++++++++++++++++++++++++++++
> > > >>>>  include/hw/vfio/vfio-common.h |   2 +
> > > >>>>  2 files changed, 116 insertions(+)
> > > >>>>
> > > >>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > >>>> index de0d286fc9dd..5fe4f8076cac 100644
> > > >>>> --- a/hw/vfio/pci.c
> > > >>>> +++ b/hw/vfio/pci.c
> > > >>>> @@ -2395,11 +2395,125 @@ static Object
> > *vfio_pci_get_object(VFIODevice *vbasedev)
> > > >>>>      return OBJECT(vdev);
> > > >>>>  }
> > > >>>>
> > > >>>> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> > > >>>> +{
> > > >>>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice,
> > vbasedev);
> > > >>>> +    PCIDevice *pdev = &vdev->pdev;
> > > >>>> +    uint16_t pci_cmd;
> > > >>>> +    int i;
> > > >>>> +
> > > >>>> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > >>>> +        uint32_t bar;
> > > >>>> +
> > > >>>> +        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i *
> > 4, 4);
> > > >>>> +        qemu_put_be32(f, bar);
> > > >>>> +    }
> > > >>>> +
> > > >>>> +    qemu_put_be32(f, vdev->interrupt);
> > > >>>> +    if (vdev->interrupt == VFIO_INT_MSI) {
> > > >>>> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> > > >>>> +        bool msi_64bit;
> > > >>>> +
> > > >>>> +        msi_flags = pci_default_read_config(pdev, pdev->msi_cap +
> > PCI_MSI_FLAGS,
> > > >>>> +                                            2);
> > > >>>> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> > > >>>> +
> > > >>>> +        msi_addr_lo = pci_default_read_config(pdev,
> > > >>>> +                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> > > >>>> +        qemu_put_be32(f, msi_addr_lo);
> > > >>>> +
> > > >>>> +        if (msi_64bit) {
> > > >>>> +            msi_addr_hi = pci_default_read_config(pdev,
> > > >>>> +                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> > > >>>> +                                             4);
> > > >>>> +        }
> > > >>>> +        qemu_put_be32(f, msi_addr_hi);
> > > >>>> +
> > > >>>> +        msi_data = pci_default_read_config(pdev,
> > > >>>> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 :
> > PCI_MSI_DATA_32),
> > > >>>> +                2);
> > > >>>> +        qemu_put_be32(f, msi_data);
> > > >>>> +    } else if (vdev->interrupt == VFIO_INT_MSIX) {
> > > >>>> +        uint16_t offset;
> > > >>>> +
> > > >>>> +        /* save enable bit and maskall bit */
> > > >>>> +        offset = pci_default_read_config(pdev,
> > > >>>> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> > > >>>> +        qemu_put_be16(f, offset);
> > > >>>> +        msix_save(pdev, f);
> > > >>>> +    }
> > > >>>> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> > > >>>> +    qemu_put_be16(f, pci_cmd);
> > > >>>> +}
> > > >>>> +
> > > >>>> +static void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > > >>>> +{
> > > >>>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice,
> > vbasedev);
> > > >>>> +    PCIDevice *pdev = &vdev->pdev;
> > > >>>> +    uint32_t interrupt_type;
> > > >>>> +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> > > >>>> +    uint16_t pci_cmd;
> > > >>>> +    bool msi_64bit;
> > > >>>> +    int i;
> > > >>>> +
> > > >>>> +    /* retore pci bar configuration */
> > > >>>> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> > > >>>> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > > >>>> +                        pci_cmd & (!(PCI_COMMAND_IO |
> > PCI_COMMAND_MEMORY)), 2);
> > > >>>> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > >>>> +        uint32_t bar = qemu_get_be32(f);
> > > >>>> +
> > > >>>> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
> > > >>>> +    }
> > > >>>
> > > >>> Is it possible to validate the bar's at all?  We just had a bug on a
> > > >>> virtual device where one version was asking for a larger bar than the
> > > >>> other; our validation caught this in some cases so we could tell that
> > > >>> the guest had a BAR that was aligned at the wrong alignment.
> 
> I'm a bit confused here. Did you mean that src and dest include
> different versions of the virtual device which implements different
> BAR size? If that is the case, shouldn't the migration fail at the start
> when doing compatibility check?

It was a mistake where the destination had accidentally changed the BAR
size; checking the alignment was the only check that failed.

> > > >>>
> > > >>
> > > >> "Validate the bars" does that means validate size of bars?
> > > >
> > > > I meant validate the address programmed into the BAR against the size,
> > > > assuming you know the size; e.g. if it's a 128MB BAR, then make sure the
> > > > address programmed in is 128MB aligned.
> > > >
> > >
> > > If this validation fails, migration resume should fail, right?
> > 
> > Yes I think so; if you've got a device that wants 128MB alignment and
> > someone gives you a non-aligned address, who knows what will happen.
> 
> If misalignment is really caused by the guest, shouldn't we just follow
> the hardware behavior, i.e. hard-wiring the lower bits to 0 before
> updating the cfg space? 

That should already happen on the source; but when loading a migration
stream I try and be very untrusting; so it's good to check that the
destination devices idea of the BAR matches what the register has.

Dave

> Thanks
> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

