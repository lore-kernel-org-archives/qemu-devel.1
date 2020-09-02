Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0135020709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6Bdl5uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0135020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOiW-0005BM-44
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kDOhm-0004Wt-NE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:05:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39874
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kDOhk-00013Q-7e
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599037518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axE/fs2aZuurUhl2Q5ehpYdYBvUCAyYy+9CW8OCvSyo=;
 b=F6Bdl5uOvSswOQmCxY0jUv8+MvDpOWt0R/dW0BuSj6OgZRDM8BetBxxKe9IiazVfTf94yS
 Ep09vHQ4MKJpSu+lzFz26RzZrI1RsCG1Z/rva+DK18ZSOYGEC9aOs2J/ZpqmKFXSdcD5Az
 COsllIxmKI4ZUYdIQY+eNcX6HVFzHms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-7i1HXHRHM_CbVFWVS7GtvA-1; Wed, 02 Sep 2020 05:05:16 -0400
X-MC-Unique: 7i1HXHRHM_CbVFWVS7GtvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A5118B9ED1;
 Wed,  2 Sep 2020 09:05:14 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B105C1C4;
 Wed,  2 Sep 2020 09:04:56 +0000 (UTC)
Subject: Re: [RFC v8 1/5] memory: Rename memory_region_notify_one to
 memory_region_notify_iommu_one
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-2-eperezma@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b3471660-74c6-b0d2-c08a-d21919a92347@redhat.com>
Date: Wed, 2 Sep 2020 11:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-2-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eugenio,

On 9/1/20 4:26 PM, Eugenio Pérez wrote:
> Previous name didn't reflect the iommu operation.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  hw/arm/smmu-common.c  | 2 +-
>  hw/arm/smmuv3.c       | 2 +-
>  hw/i386/intel_iommu.c | 4 ++--
>  include/exec/memory.h | 6 +++---
>  softmmu/memory.c      | 6 +++---
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3838db1395..88d2c454f0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -472,7 +472,7 @@ static void smmu_unmap_notifier_range(IOMMUNotifier *n)
>      entry.perm = IOMMU_NONE;
>      entry.addr_mask = n->end - n->start;
>  
> -    memory_region_notify_one(n, &entry);
> +    memory_region_notify_iommu_one(n, &entry);
>  }
>  
>  /* Unmap all notifiers attached to @mr */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0122700e72..0a893ae918 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -827,7 +827,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      entry.addr_mask = num_pages * (1 << granule) - 1;
>      entry.perm = IOMMU_NONE;
>  
> -    memory_region_notify_one(n, &entry);
> +    memory_region_notify_iommu_one(n, &entry);
>  }
>  
>  /* invalidate an asid/iova range tuple in all mr's */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5284bb68b6..2ad6b9d796 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3498,7 +3498,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>          /* This field is meaningless for unmap */
>          entry.translated_addr = 0;
>  
> -        memory_region_notify_one(n, &entry);
> +        memory_region_notify_iommu_one(n, &entry);
>  
>          start += mask;
>          remain -= mask;
> @@ -3536,7 +3536,7 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s)
>  
>  static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
>  {
> -    memory_region_notify_one((IOMMUNotifier *)private, entry);
> +    memory_region_notify_iommu_one((IOMMUNotifier *)private, entry);
>      return 0;
>  }
>  
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 0cfe987ab4..22c5f564d1 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -226,7 +226,7 @@ enum IOMMUMemoryRegionAttr {
>   * The IOMMU implementation must use the IOMMU notifier infrastructure
>   * to report whenever mappings are changed, by calling
>   * memory_region_notify_iommu() (or, if necessary, by calling
> - * memory_region_notify_one() for each registered notifier).
> + * memory_region_notify_iommu_one() for each registered notifier).
>   *
>   * Conceptually an IOMMU provides a mapping from input address
>   * to an output TLB entry. If the IOMMU is aware of memory transaction
> @@ -1274,7 +1274,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>                                  IOMMUTLBEntry entry);
>  
>  /**
> - * memory_region_notify_one: notify a change in an IOMMU translation
> + * memory_region_notify_iommu_one: notify a change in an IOMMU translation
>   *                           entry to a single notifier
>   *
>   * This works just like memory_region_notify_iommu(), but it only
> @@ -1285,7 +1285,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>   *         replaces all old entries for the same virtual I/O address range.
>   *         Deleted entries have .@perm == 0.
>   */
> -void memory_region_notify_one(IOMMUNotifier *notifier,
> +void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>                                IOMMUTLBEntry *entry);
>  
>  /**
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 70b93104e8..961c25b42f 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1890,8 +1890,8 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>      memory_region_update_iommu_notify_flags(iommu_mr, NULL);
>  }
>  
> -void memory_region_notify_one(IOMMUNotifier *notifier,
> -                              IOMMUTLBEntry *entry)
> +void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> +                                    IOMMUTLBEntry *entry)
>  {
>      IOMMUNotifierFlag request_flags;
>      hwaddr entry_end = entry->iova + entry->addr_mask;
> @@ -1927,7 +1927,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>  
>      IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
>          if (iommu_notifier->iommu_idx == iommu_idx) {
> -            memory_region_notify_one(iommu_notifier, &entry);
> +            memory_region_notify_iommu_one(iommu_notifier, &entry);
>          }
>      }
>  }
> 


