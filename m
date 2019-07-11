Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE3AC74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944E120665
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944E120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXs9-0003BG-Gd
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlXrF-0002io-82
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlXrB-0001ao-2l
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlXrA-0001Y5-Qm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:07:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F14F93082131;
 Thu, 11 Jul 2019 12:07:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1280D60603;
 Thu, 11 Jul 2019 12:07:15 +0000 (UTC)
Date: Thu, 11 Jul 2019 13:07:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190711120713.GM3971@work-vm>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-5-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562665760-26158-5-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 12:07:24 +0000 (UTC)
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> These functions save and restore PCI device specific data - config
> space of PCI device.
> Tested save and restore with MSI and MSIX type.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c                 | 114 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |   2 +
>  2 files changed, 116 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index de0d286fc9dd..5fe4f8076cac 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2395,11 +2395,125 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>      return OBJECT(vdev);
>  }
>  
> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint16_t pci_cmd;
> +    int i;
> +
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar;
> +
> +        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> +        qemu_put_be32(f, bar);
> +    }
> +
> +    qemu_put_be32(f, vdev->interrupt);
> +    if (vdev->interrupt == VFIO_INT_MSI) {
> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> +        bool msi_64bit;
> +
> +        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                                            2);
> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        msi_addr_lo = pci_default_read_config(pdev,
> +                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> +        qemu_put_be32(f, msi_addr_lo);
> +
> +        if (msi_64bit) {
> +            msi_addr_hi = pci_default_read_config(pdev,
> +                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                             4);
> +        }
> +        qemu_put_be32(f, msi_addr_hi);
> +
> +        msi_data = pci_default_read_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                2);
> +        qemu_put_be32(f, msi_data);
> +    } else if (vdev->interrupt == VFIO_INT_MSIX) {
> +        uint16_t offset;
> +
> +        /* save enable bit and maskall bit */
> +        offset = pci_default_read_config(pdev,
> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> +        qemu_put_be16(f, offset);
> +        msix_save(pdev, f);
> +    }
> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    qemu_put_be16(f, pci_cmd);
> +}
> +
> +static void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint32_t interrupt_type;
> +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> +    uint16_t pci_cmd;
> +    bool msi_64bit;
> +    int i;
> +
> +    /* retore pci bar configuration */
> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar = qemu_get_be32(f);
> +
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
> +    }

Is it possible to validate the bar's at all?  We just had a bug on a
virtual device where one version was asking for a larger bar than the
other; our validation caught this in some cases so we could tell that
the guest had a BAR that was aligned at the wrong alignment.

> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          pci_cmd | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);

Can you explain what this is for?  You write the command register at the
end of the function with the original value; there's no guarantee that
the device is using IO for example, so ORing it seems odd.

Also, are the other flags in COMMAND safe at this point - e.g. what
about interrupts and stuff?

> +    interrupt_type = qemu_get_be32(f);
> +
> +    if (interrupt_type == VFIO_INT_MSI) {
> +        /* restore msi configuration */
> +        msi_flags = pci_default_read_config(pdev,
> +                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
> +
> +        msi_addr_lo = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
> +                              msi_addr_lo, 4);
> +
> +        msi_addr_hi = qemu_get_be32(f);
> +        if (msi_64bit) {
> +            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                  msi_addr_hi, 4);
> +        }
> +        msi_data = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                msi_data, 2);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
> +    } else if (interrupt_type == VFIO_INT_MSIX) {
> +        uint16_t offset = qemu_get_be16(f);
> +
> +        /* load enable bit and maskall bit */
> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> +                              offset, 2);
> +        msix_load(pdev, f);
> +    }
> +    pci_cmd = qemu_get_be16(f);
> +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> +}
> +
>  static VFIODeviceOps vfio_pci_ops = {
>      .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>      .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
>      .vfio_eoi = vfio_intx_eoi,
>      .vfio_get_object = vfio_pci_get_object,
> +    .vfio_save_config = vfio_pci_save_config,
> +    .vfio_load_config = vfio_pci_load_config,
>  };
>  
>  int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 771b6d59a3db..ee72bd984a36 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -120,6 +120,8 @@ struct VFIODeviceOps {
>      int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>      void (*vfio_eoi)(VFIODevice *vdev);
>      Object *(*vfio_get_object)(VFIODevice *vdev);
> +    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +    void (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>  };
>  
>  typedef struct VFIOGroup {
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

