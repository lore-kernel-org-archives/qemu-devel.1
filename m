Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B3CC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EC621852
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EC621852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiY3h-0008Vc-0J
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 01:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hiY1i-0006vp-Pm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hiY1g-00089V-JG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>)
 id 1hiY1S-0007n7-QK; Wed, 03 Jul 2019 01:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2E2630820DD;
 Wed,  3 Jul 2019 05:41:25 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.60.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AD887857F;
 Wed,  3 Jul 2019 05:41:18 +0000 (UTC)
Date: Wed, 3 Jul 2019 13:41:16 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190703054116.GD10408@xz-x1>
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701093034.18873-4-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 03 Jul 2019 05:41:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/vfio/common: Do not replay IOMMU
 mappings in nested case
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 11:30:31AM +0200, Eric Auger wrote:
> In nested mode, the stage 1 translation tables are owned by
> the guest and there is no caching on host side. So there is
> no need to replay the mappings.
> 
> As of today, the SMMUv3 nested mode is not yet implemented
> and there is no functional VFIO integration without. But
> keeping the replay call would execute the default implementation
> of memory_region_iommu_replay and attempt to translate the whole
> address range, completely stalling qemu. Keeping the MAP/UNMAP
> notifier registration allows to hit a warning message in the
> SMMUv3 device that tells the user which VFIO device will not
> function properly:
> 
> "qemu-system-aarch64: -device vfio-pci,host=0000:89:00.0: warning:
> SMMUv3 does not support notification on MAP: device vfio-pci will not
> function properly"
> 
> Besides, removing the replay call now allows the guest to boot.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index a859298fda..9ea58df67a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -604,6 +604,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      if (memory_region_is_iommu(section->mr)) {
>          VFIOGuestIOMMU *giommu;
>          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> +        bool nested = false;
>          int iommu_idx;
>  
>          trace_vfio_listener_region_add_iommu(iova, end);
> @@ -631,8 +632,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
>  
>          memory_region_register_iommu_notifier(section->mr, &giommu->n);
> -        memory_region_iommu_replay(giommu->iommu, &giommu->n);
>  
> +        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
> +                                     (void *)&nested);
> +        if (!nested) {
> +            memory_region_iommu_replay(iommu_mr, &giommu->n);
> +        }

For nested, do we need these IOMMU notifiers after all?

I'm asking because the no-IOMMU case of vfio_listener_region_add()
seems to suite very well for nested page tables to me.  For example,
vfio does not need to listen to MAP events any more because we'll
simply share the guest IOMMU page table to be the 1st level page table
of the host SMMU IIUC.  And if we have 2nd page table changes (like
memory hotplug) then IMHO vfio_listener_region_add() will do this for
us as well just like when there's no SMMU.

Another thing is that IOMMU_ATTR_VFIO_NESTED will be the same for all
the memory regions, so it also seems a bit awkward to make it per
memory region.  If you see the other real user of this flag (which is
IOMMU_ATTR_SPAPR_TCE_FD) it's per memory region.

Regards,

-- 
Peter Xu

