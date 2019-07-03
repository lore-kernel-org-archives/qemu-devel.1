Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0DC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDB52187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDB52187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYA0-0003On-8f
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 01:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hiY2m-0007cO-Vw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hiY2l-0000VU-W2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>)
 id 1hiY2h-0000LF-1q; Wed, 03 Jul 2019 01:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE6F44E938;
 Wed,  3 Jul 2019 05:42:45 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.60.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53FF817480;
 Wed,  3 Jul 2019 05:42:38 +0000 (UTC)
Date: Wed, 3 Jul 2019 13:42:36 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190703054236.GF10408@xz-x1>
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701093034.18873-3-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 03 Jul 2019 05:42:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] memory: Add IOMMU_ATTR_VFIO_NESTED
 IOMMU memory region attribute
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

On Mon, Jul 01, 2019 at 11:30:30AM +0200, Eric Auger wrote:
> We introduce a new IOMMU Memory Region attribute,
> IOMMU_ATTR_VFIO_NESTED that tells whether the virtual IOMMU
> requires physical nested stages for VFIO integration.
> 
> Current Intel virtual IOMMU device supports "Caching
> Mode" and does not require 2 stages at physical level to be
> integrated with VFIO. However SMMUv3 does not implement such
> "caching mode" and requires to use physical stage 1 for VFIO
> integration.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/exec/memory.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bdd76653a8..dd7ef23f96 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -204,7 +204,8 @@ struct MemoryRegionOps {
>  };
>  
>  enum IOMMUMemoryRegionAttr {
> -    IOMMU_ATTR_SPAPR_TCE_FD
> +    IOMMU_ATTR_SPAPR_TCE_FD,
> +    IOMMU_ATTR_VFIO_NESTED,

IMHO it'll be better if this patch can be squashed into the first user
of the new flag to better clarify itself on why it will be needed (if
finally we still would like to have this flag).

Regards,

-- 
Peter Xu

