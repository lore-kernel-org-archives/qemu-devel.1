Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B62C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B06214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B06214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkleR-0006lf-Co
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hkldT-0005UG-8n
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hkldS-0006zD-5b
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hkldR-0006xV-Si
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5423C05681F;
 Tue,  9 Jul 2019 08:37:59 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C99819C68;
 Tue,  9 Jul 2019 08:37:49 +0000 (UTC)
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org, mst@redhat.com,
 pbonzini@redhat.com, alex.williamson@redhat.com, peterx@redhat.com
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-9-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cac2a42e-c152-e715-451f-7a19ca3e19ca@redhat.com>
Date: Tue, 9 Jul 2019 10:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1562324511-2910-9-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 09 Jul 2019 08:37:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v1 08/18] vfio/pci: add vfio
 bind/unbind_gpasid implementation
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, jun.j.tian@intel.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Liu,

On 7/5/19 1:01 PM, Liu Yi L wrote:
> This patch adds vfio implementation PCIPASIDOps.bind_gpasid/unbind_pasid().
> These two functions are used to propagate guest pasid bind and unbind
> requests to host via vfio container ioctl.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/vfio/pci.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab184ad..892b46c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2744,9 +2744,63 @@ static int vfio_pci_device_request_pasid_free(PCIBus *bus,
>      return ret;
>  }
>  
> +static void vfio_pci_device_bind_gpasid(PCIBus *bus, int32_t devfn,
> +                                     struct gpasid_bind_data *g_bind_data)
> +{
> +    PCIDevice *pdev = bus->devices[devfn];
> +    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOContainer *container = vdev->vbasedev.group->container;
> +    struct vfio_iommu_type1_bind *bind;
> +    struct vfio_iommu_type1_bind_guest_pasid *bind_guest_pasid;
> +    unsigned long argsz;
> +
> +    argsz = sizeof(*bind) + sizeof(*bind_guest_pasid);
> +    bind = g_malloc0(argsz);
> +    bind->argsz = argsz;
> +    bind->bind_type = VFIO_IOMMU_BIND_GUEST_PASID;
> +    bind_guest_pasid = (struct vfio_iommu_type1_bind_guest_pasid *) &bind->data;
> +    bind_guest_pasid->bind_data = *g_bind_data;
> +
> +    rcu_read_lock();
why do you need the rcu_read_lock?
> +    if (ioctl(container->fd, VFIO_IOMMU_BIND, bind) != 0) {
> +        error_report("vfio_pci_device_bind_gpasid:"
> +                     " bind failed, contanier: %p", container);
container
> +    }
> +    rcu_read_unlock();
> +    g_free(bind);
> +}
> +
> +static void vfio_pci_device_unbind_gpasid(PCIBus *bus, int32_t devfn,
> +                                     struct gpasid_bind_data *g_bind_data)
> +{
> +    PCIDevice *pdev = bus->devices[devfn];
> +    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOContainer *container = vdev->vbasedev.group->container;
> +    struct vfio_iommu_type1_bind *bind;
> +    struct vfio_iommu_type1_bind_guest_pasid *bind_guest_pasid;
> +    unsigned long argsz;
> +
> +    argsz = sizeof(*bind) + sizeof(*bind_guest_pasid);
> +    bind = g_malloc0(argsz);
> +    bind->argsz = argsz;
> +    bind->bind_type = VFIO_IOMMU_BIND_GUEST_PASID;
> +    bind_guest_pasid = (struct vfio_iommu_type1_bind_guest_pasid *) &bind->data;
> +    bind_guest_pasid->bind_data = *g_bind_data;
> +
> +    rcu_read_lock();
> +    if (ioctl(container->fd, VFIO_IOMMU_UNBIND, bind) != 0) {
> +        error_report("vfio_pci_device_unbind_gpasid:"
> +                     " unbind failed, contanier: %p", container);
container
> +    }
> +    rcu_read_unlock();
> +    g_free(bind);
> +}
> +
>  static PCIPASIDOps vfio_pci_pasid_ops = {
>      .alloc_pasid = vfio_pci_device_request_pasid_alloc,
>      .free_pasid = vfio_pci_device_request_pasid_free,
> +    .bind_gpasid = vfio_pci_device_bind_gpasid,
> +    .unbind_gpasid = vfio_pci_device_unbind_gpasid,
>  };
>  
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
> 

Thanks

Eric

