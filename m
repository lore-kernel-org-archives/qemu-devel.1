Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8529C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CDB214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CDB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hklec-0006qM-3m
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hkldT-0005UP-B0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hkldS-0006z7-5Q
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hkldR-0006y0-Sx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A1493084027;
 Tue,  9 Jul 2019 08:38:00 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99D055D9E5;
 Tue,  9 Jul 2019 08:37:46 +0000 (UTC)
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org, mst@redhat.com,
 pbonzini@redhat.com, alex.williamson@redhat.com, peterx@redhat.com
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-8-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1dbeec81-8fa6-4e5c-fc62-4a999387bd12@redhat.com>
Date: Tue, 9 Jul 2019 10:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1562324511-2910-8-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 09 Jul 2019 08:38:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v1 07/18] hw/pci: add
 pci_device_bind/unbind_gpasid
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
> This patch adds two callbacks pci_device_bind/unbind_gpasid() to
> PCIPASIDOps. These two callbacks are used to propagate guest pasid
> bind/unbind to host. The implementations of the callbacks would be
> device passthru modules like vfio.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/pci/pci.c         | 30 ++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h |  9 +++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 710f9e9..2229229 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2676,6 +2676,36 @@ int pci_device_request_pasid_free(PCIBus *bus, int32_t devfn,
>      return -1;
>  }
>  
> +void pci_device_bind_gpasid(PCIBus *bus, int32_t devfn,
> +                                struct gpasid_bind_data *g_bind_data)
struct gpasid_bind_data is defined in linux headers so I think you would
need: #ifdef __linux__
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return;
> +    }
> +
> +    dev = bus->devices[devfn];
> +    if (dev && dev->pasid_ops) {
> +        dev->pasid_ops->bind_gpasid(bus, devfn, g_bind_data);
> +    }
> +}
> +
> +void pci_device_unbind_gpasid(PCIBus *bus, int32_t devfn,
> +                                struct gpasid_bind_data *g_bind_data)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return;
> +    }
> +
> +    dev = bus->devices[devfn];
> +    if (dev && dev->pasid_ops) {
> +        dev->pasid_ops->unbind_gpasid(bus, devfn, g_bind_data);
> +    }
> +}
> +
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>  {
>      Range *range = opaque;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 16e5b8e..8d849e6 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -9,6 +9,7 @@
>  #include "hw/isa/isa.h"
>  
>  #include "hw/pci/pcie.h"
> +#include <linux/iommu.h>
>  
>  extern bool pci_available;
>  
> @@ -267,6 +268,10 @@ struct PCIPASIDOps {
>      int (*alloc_pasid)(PCIBus *bus, int32_t devfn,
>                           uint32_t min_pasid, uint32_t max_pasid);
>      int (*free_pasid)(PCIBus *bus, int32_t devfn, uint32_t pasid);
> +    void (*bind_gpasid)(PCIBus *bus, int32_t devfn,
> +                            struct gpasid_bind_data *g_bind_data);
> +    void (*unbind_gpasid)(PCIBus *bus, int32_t devfn,
> +                            struct gpasid_bind_data *g_bind_data);
>  };
>  
>  struct PCIDevice {
> @@ -497,6 +502,10 @@ bool pci_device_is_ops_set(PCIBus *bus, int32_t devfn);
>  int pci_device_request_pasid_alloc(PCIBus *bus, int32_t devfn,
>                                     uint32_t min_pasid, uint32_t max_pasid);
>  int pci_device_request_pasid_free(PCIBus *bus, int32_t devfn, uint32_t pasid);
> +void pci_device_bind_gpasid(PCIBus *bus, int32_t devfn,
> +                            struct gpasid_bind_data *g_bind_data);
> +void pci_device_unbind_gpasid(PCIBus *bus, int32_t devfn,
> +                            struct gpasid_bind_data *g_bind_data);
>  
>  static inline void
>  pci_set_byte(uint8_t *config, uint8_t val)
> 
Thanks

Eric

