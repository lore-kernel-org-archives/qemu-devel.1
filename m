Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E58C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78A72087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78A72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57HA-00043U-ET
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i57Fj-00037O-2t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i57Fh-0004c4-JD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i57Fe-0004ZX-KC; Tue, 03 Sep 2019 07:45:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 710561E2E6;
 Tue,  3 Sep 2019 11:45:33 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0497E60A35;
 Tue,  3 Sep 2019 11:45:23 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-10-eric.auger@redhat.com>
 <20190819082424.GB13560@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d3759ba2-6ae6-2ae4-a71e-69965285f3f4@redhat.com>
Date: Tue, 3 Sep 2019 13:45:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190819082424.GB13560@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 03 Sep 2019 11:45:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 09/15] virtio-iommu: Implement
 translate
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

On 8/19/19 10:24 AM, Peter Xu wrote:
> On Tue, Jul 30, 2019 at 07:21:31PM +0200, Eric Auger wrote:
>> @@ -464,19 +464,75 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                                              int iommu_idx)
>>  {
>>      IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>> +    VirtIOIOMMU *s = sdev->viommu;
>>      uint32_t sid;
>> +    viommu_endpoint *ep;
>> +    viommu_mapping *mapping;
>> +    viommu_interval interval;
>> +    bool bypass_allowed;
>> +
>> +    interval.low = addr;
>> +    interval.high = addr + 1;
>>  
>>      IOMMUTLBEntry entry = {
>>          .target_as = &address_space_memory,
>>          .iova = addr,
>>          .translated_addr = addr,
>> -        .addr_mask = ~(hwaddr)0,
>> +        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
>>          .perm = IOMMU_NONE,
>>      };
>>  
>> +    bypass_allowed = virtio_has_feature(s->acked_features,
>> +                                        VIRTIO_IOMMU_F_BYPASS);
>> +
>>      sid = virtio_iommu_get_sid(sdev);
>>  
>>      trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
>> +    qemu_mutex_lock(&s->mutex);
>> +
>> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
>> +    if (!ep) {
>> +        if (!bypass_allowed) {
>> +            error_report("%s sid=%d is not known!!", __func__, sid);
> 
> Maybe use error_report_once() to avoid DOS attack?  Also would it be
> good to unify the debug prints?  I see both error_report() and
> qemu_log_mask() are used in the whole patchset.  Or is that attempted?

I switched to error_report_once()

I understand that qemu_log_mask() should be used whenever the root cause
is a bad action of the guest OS (in below case, the EP was not attached
to any domain). Above, there is an EP that attempts to talk through the
IOMMU and this was not expected (rather a platform description issue or
a qemu bug).

Thanks

Eric
> 
>> +        } else {
>> +            entry.perm = flag;
>> +        }
>> +        goto unlock;
>> +    }
>> +
>> +    if (!ep->domain) {
>> +        if (!bypass_allowed) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s %02x:%02x.%01x not attached to any domain\n",
>> +                          __func__, PCI_BUS_NUM(sid),
>> +                          PCI_SLOT(sid), PCI_FUNC(sid));
>> +        } else {
>> +            entry.perm = flag;
>> +        }
>> +        goto unlock;
>> +    }
>> +
>> +    mapping = g_tree_lookup(ep->domain->mappings, (gpointer)(&interval));
>> +    if (!mapping) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s no mapping for 0x%"PRIx64" for sid=%d\n",
>> +                      __func__, addr, sid);
>> +        goto unlock;
>> +    }
>> +
>> +    if (((flag & IOMMU_RO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
>> +        ((flag & IOMMU_WO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "Permission error on 0x%"PRIx64"(%d): allowed=%d\n",
>> +                      addr, flag, mapping->flags);
>> +        goto unlock;
>> +    }
>> +    entry.translated_addr = addr - mapping->virt_addr + mapping->phys_addr;
>> +    entry.perm = flag;
>> +    trace_virtio_iommu_translate_out(addr, entry.translated_addr, sid);
>> +
>> +unlock:
>> +    qemu_mutex_unlock(&s->mutex);
>>      return entry;
>>  }
>>  
>> -- 
>> 2.20.1
>>
> 
> Regards,
> 

