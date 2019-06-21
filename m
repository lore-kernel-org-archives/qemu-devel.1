Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF39C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5842F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VzG0pRWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5842F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDRh-00065p-On
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:54:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1heDKv-0008Eu-67
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1heDI2-0000UX-1X
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:44:51 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1heDI1-0000NB-9i
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:44:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0c7ce00000>; Thu, 20 Jun 2019 23:44:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 23:44:47 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 23:44:47 -0700
Received: from [10.24.71.210] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 06:44:35 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-4-git-send-email-kwankhede@nvidia.com>
 <20190621001228.GE9303@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20a0f8c4-e555-6a4d-598a-b72beac6a62f@nvidia.com>
Date: Fri, 21 Jun 2019 12:14:30 +0530
MIME-Version: 1.0
In-Reply-To: <20190621001228.GE9303@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561099489; bh=ttEsADUXYr6aQeHpPG+ugVUie+6ZSbsA9GSH8lE5Ptg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=VzG0pRWh20ZTeETPVXmAsY/wtS3OhVhMfz5QjDzE7nR/U+JNdb9WANEcWhqFZA9NQ
 cQRHInjGcARDRKt/PoWOiiPp4S3M2NGSETvOcHuD2iee/ugoGdozuaBHvEM+ut39RC
 82s9KQGpitRJyZ1J/O539n88sqS/WK/YuTMl7L3iLPctJfI8wfj8nJ5bTSVr6Jey9b
 GUOeyj0YASHfW+IZcc2fpKS4fAi4vHFA7Y3xZQ35hYMmiza88D6iQhiKQItbfSeeAR
 4qbDKxp1a8V1Dbe45qP0AETn2hGJHoWzBFa36VdIm6MDavg8a8jMiuQ2TfnWWpougE
 zDJ0gJoc778nQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: Re: [Qemu-devel] [PATCH v4 03/13] vfio: Add save and load functions
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/21/2019 5:42 AM, Yan Zhao wrote:
> On Thu, Jun 20, 2019 at 10:37:31PM +0800, Kirti Wankhede wrote:
>> These functions save and restore PCI device specific data - config
>> space of PCI device.
>> Tested save and restore with MSI and MSIX type.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/pci.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/pci.h |  29 +++++++++++++++
>>  2 files changed, 141 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ce3fe96efe2c..09a0821a5b1c 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1187,6 +1187,118 @@ void vfio_pci_write_config(PCIDevice *pdev,
>>      }
>>  }
>>  
>> +void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    uint16_t pci_cmd;
>> +    int i;
>> +
>> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
>> +        uint32_t bar;
>> +
>> +        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
>> +        qemu_put_be32(f, bar);
>> +    }
>> +
>> +    qemu_put_be32(f, vdev->interrupt);
>> +    if (vdev->interrupt == VFIO_INT_MSI) {
>> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
>> +        bool msi_64bit;
>> +
>> +        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
>> +                                            2);
>> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
>> +
>> +        msi_addr_lo = pci_default_read_config(pdev,
>> +                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
>> +        qemu_put_be32(f, msi_addr_lo);
>> +
>> +        if (msi_64bit) {
>> +            msi_addr_hi = pci_default_read_config(pdev,
>> +                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
>> +                                             4);
>> +        }
>> +        qemu_put_be32(f, msi_addr_hi);
>> +
>> +        msi_data = pci_default_read_config(pdev,
>> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
>> +                2);
>> +        qemu_put_be32(f, msi_data);
>> +    } else if (vdev->interrupt == VFIO_INT_MSIX) {
>> +        uint16_t offset;
>> +
>> +        /* save enable bit and maskall bit */
>> +        offset = pci_default_read_config(pdev,
>> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
>> +        qemu_put_be16(f, offset);
>> +        msix_save(pdev, f);
>> +    }
>> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
>> +    qemu_put_be16(f, pci_cmd);
>> +}
>> +
>> +void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    uint32_t interrupt_type;
>> +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
>> +    uint16_t pci_cmd;
>> +    bool msi_64bit;
>> +    int i;
>> +
>> +    /* retore pci bar configuration */
>> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
>> +    vfio_pci_write_config(pdev, PCI_COMMAND,
>> +                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
>> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
>> +        uint32_t bar = qemu_get_be32(f);
>> +
>> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
>> +    }
>> +    vfio_pci_write_config(pdev, PCI_COMMAND,
>> +                          pci_cmd | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
>> +
>> +    interrupt_type = qemu_get_be32(f);
>> +
>> +    if (interrupt_type == VFIO_INT_MSI) {
>> +        /* restore msi configuration */
>> +        msi_flags = pci_default_read_config(pdev,
>> +                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
>> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
>> +
>> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
>> +                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
>> +
>> +        msi_addr_lo = qemu_get_be32(f);
>> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
>> +                              msi_addr_lo, 4);
>> +
>> +        msi_addr_hi = qemu_get_be32(f);
>> +        if (msi_64bit) {
>> +            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
>> +                                  msi_addr_hi, 4);
>> +        }
>> +        msi_data = qemu_get_be32(f);
>> +        vfio_pci_write_config(pdev,
>> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
>> +                msi_data, 2);
>> +
>> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
>> +                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
>> +    } else if (interrupt_type == VFIO_INT_MSIX) {
>> +        uint16_t offset = qemu_get_be16(f);
>> +
>> +        /* load enable bit and maskall bit */
>> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
>> +                              offset, 2);
>> +        msix_load(pdev, f);
>> +    }
>> +    pci_cmd = qemu_get_be16(f);
>> +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
>> +}
>> +
> per the previous discussion, pci config state save/restore are better
> defined in fileds of VMStateDescription.
> 
> 

With that route there is no pre-copy phase and we do want pre-copy phase
for VFIO devices. Vendor driver can skip pre-copy phase by doing nothing
on any read/write operation during pre-copy phase.

Thanks,
Kirti

>>  /*
>>   * Interrupt setup
>>   */
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 834a90d64686..847be5f56478 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -19,6 +19,7 @@
>>  #include "qemu/queue.h"
>>  #include "qemu/timer.h"
>>  
>> +#ifdef CONFIG_LINUX
>>  #define PCI_ANY_ID (~0)
>>  
>>  struct VFIOPCIDevice;
>> @@ -202,4 +203,32 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>>  void vfio_display_finalize(VFIOPCIDevice *vdev);
>>  
>> +void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f);
>> +void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
>> +
>> +static inline Object *vfio_pci_get_object(VFIODevice *vbasedev)
>> +{
>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +
>> +    return OBJECT(vdev);
>> +}
>> +
>> +#else
>> +static inline void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    g_assert(false);
>> +}
>> +
>> +static inline void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    g_assert(false);
>> +}
>> +
>> +static inline Object *vfio_pci_get_object(VFIODevice *vbasedev)
>> +{
>> +    return NULL;
>> +}
>> +
>> +#endif
>> +
>>  #endif /* HW_VFIO_VFIO_PCI_H */
>> -- 
>> 2.7.0
>>

