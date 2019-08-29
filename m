Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461EBC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 14:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11825208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 14:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11825208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3LN7-0002Hs-7a
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 10:25:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i3LLx-0001XK-9q
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i3LLw-0001pI-69
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i3LLp-0001d0-4g; Thu, 29 Aug 2019 10:24:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 472CA2CE955;
 Thu, 29 Aug 2019 14:24:35 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BA3F5D9D3;
 Thu, 29 Aug 2019 14:24:25 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-8-eric.auger@redhat.com> <20190816042749.GC3114@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2cf934e9-ff47-72b6-d22c-1fc01c17500e@redhat.com>
Date: Thu, 29 Aug 2019 16:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190816042749.GC3114@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 29 Aug 2019 14:24:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 07/15] virtio-iommu: Implement
 attach/detach command
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 8/16/19 6:27 AM, Peter Xu wrote:
> On Tue, Jul 30, 2019 at 07:21:29PM +0200, Eric Auger wrote:
>> This patch implements the endpoint attach/detach to/from
>> a domain.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> ---
>>  hw/virtio/virtio-iommu.c | 40 ++++++++++++++++++++++++++++++++++------
>>  1 file changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 77dccecc0a..5ea0930cc2 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -80,8 +80,8 @@ static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
>>      ep->domain = NULL;
>>  }
>>  
>> -viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id);
>> -viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id)
> 
> These lines were just introduced in previous patch, I wanted to ask
> why the definition was needed but I don't know whether it'll be used
> in follow up patches.  Looks like it wasn't really used.
> 
> I would prefer patches like these to be squashed together not only to
> avoid the maintainance of diffs like this between patches, but also as
> a reviewer it'll be easier too when with all the contexts together.
> But I won't ask for it because it can be a personal preference only...

Yes that's a tradeoff. I tried to split the series to ease the review;
helpers were introduced separately in previous patch but not yet used.
Here I introduce call sites and they become static.
> 
>> +static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>> +                                                  uint32_t ep_id)
>>  {
>>      viommu_endpoint *ep;
>>  
>> @@ -110,8 +110,8 @@ static void virtio_iommu_put_endpoint(gpointer data)
>>      g_free(ep);
>>  }
>>  
>> -viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id);
>> -viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id)
>> +static viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s,
>> +                                              uint32_t domain_id)
>>  {
>>      viommu_domain *domain;
>>  
>> @@ -187,10 +187,27 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>  {
>>      uint32_t domain_id = le32_to_cpu(req->domain);
>>      uint32_t ep_id = le32_to_cpu(req->endpoint);
>> +    viommu_domain *domain;
>> +    viommu_endpoint *ep;
>>  
>>      trace_virtio_iommu_attach(domain_id, ep_id);
>>  
>> -    return VIRTIO_IOMMU_S_UNSUPP;
>> +    ep = virtio_iommu_get_endpoint(s, ep_id);
>> +    if (ep->domain) {
>> +        /*
>> +         * the device is already attached to a domain,
>> +         * detach it first
>> +         */
>> +        virtio_iommu_detach_endpoint_from_domain(ep);
> 
> Hmm... so this can be called without virtio_iommu_put_endpoint().
> Then I think we'd better move:
> 
>         g_tree_unref(ep->domain->mappings);
> 
> From virtio_iommu_put_endpoint() to inside
> virtio_iommu_detach_endpoint_from_domain() otherwise domain refs might
> leak?

I agree with you. I Also removed g_tree_destroy from
virtio_iommu_put_domain as detaching all its end points should now do
the job.

Thanks

Eric
> 
>> +    }
>> +
>> +    domain = virtio_iommu_get_domain(s, domain_id);
>> +    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
>> +
>> +    ep->domain = domain;
>> +    g_tree_ref(domain->mappings);
>> +
>> +    return VIRTIO_IOMMU_S_OK;
>>  }
> 
> Regards,
> 

