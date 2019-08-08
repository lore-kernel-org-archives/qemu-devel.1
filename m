Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9743C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 03:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65C6216C8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 03:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65C6216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvYml-0004ab-10
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 23:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hvYmK-0003qM-4X
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 23:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hvYmJ-00067e-1I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 23:07:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hvYmG-00065U-Lf; Wed, 07 Aug 2019 23:07:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DE443001A6C;
 Thu,  8 Aug 2019 03:07:43 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 214585D71C;
 Thu,  8 Aug 2019 03:07:37 +0000 (UTC)
Date: Wed, 7 Aug 2019 21:07:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190807210736.7703cdfd@x1.home>
In-Reply-To: <20190711061857.13086-3-eric.auger@redhat.com>
References: <20190711061857.13086-1-eric.auger@redhat.com>
 <20190711061857.13086-3-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 08 Aug 2019 03:07:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v3 2/5] memory: Add
 IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, peterx@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 08:18:54 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> We introduce a new IOMMU Memory Region attribute,
> IOMMU_ATTR_VFIO_NESTED that tells whether the virtual IOMMU
> requires HW nested paging for VFIO integration.
> 
> Current Intel virtual IOMMU device supports "Caching
> Mode" and does not require 2 stages at physical level to be
> integrated with VFIO. However SMMUv3 does not implement such
> "caching mode" and requires to use HW nested paging.
> 
> As such SMMUv3 is the first IOMMU device to advertise this
> attribute.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c       | 12 ++++++++++++
>  include/exec/memory.h |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e96d5beb9a..384c02cb91 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1490,6 +1490,17 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      }
>  }
>  
> +static int smmuv3_get_attr(IOMMUMemoryRegion *iommu,
> +                           enum IOMMUMemoryRegionAttr attr,
> +                           void *data)
> +{
> +    if (attr == IOMMU_ATTR_VFIO_NESTED) {
> +        *(bool *) data = true;
> +        return 0;
> +    }
> +    return -EINVAL;
> +}
> +
>  static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>                                                    void *data)
>  {
> @@ -1497,6 +1508,7 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>  
>      imrc->translate = smmuv3_translate;
>      imrc->notify_flag_changed = smmuv3_notify_flag_changed;
> +    imrc->get_attr = smmuv3_get_attr;
>  }
>  
>  static const TypeInfo smmuv3_type_info = {
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index a078cd033f..e477a630a8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -204,7 +204,8 @@ struct MemoryRegionOps {
>  };
>  
>  enum IOMMUMemoryRegionAttr {
> -    IOMMU_ATTR_SPAPR_TCE_FD
> +    IOMMU_ATTR_SPAPR_TCE_FD,
> +    IOMMU_ATTR_VFIO_NESTED,
>  };
>  
>  /**

Why VFIO_NESTED vs simply NESTED?  I figure any time we need to include
"VFIO" in the descriptions of something, we're probably not describing
the requirement correctly and it just becomes a meaningless tag that
gets ignored outside of VFIO related things.  If we're trying to
describe an IOMMU MemoryRegion that supports dynamic faulting rather
than requiring a replay to pre-populate it, then simply define that
semantic rather than hand waving some vfio specific interaction.
Thanks,

Alex

