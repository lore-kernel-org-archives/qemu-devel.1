Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11341C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99162087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99162087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i578R-0001Xf-3R
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i577g-0000zN-LH
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i577f-0008L5-JC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i577c-0008JE-PI; Tue, 03 Sep 2019 07:37:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF64D8535D;
 Tue,  3 Sep 2019 11:37:15 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA5165D9E1;
 Tue,  3 Sep 2019 11:37:12 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-9-eric.auger@redhat.com> <20190819081143.GA13560@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b5e2ff32-eed8-829e-ffd4-2b62ed6b2fda@redhat.com>
Date: Tue, 3 Sep 2019 13:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190819081143.GA13560@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 03 Sep 2019 11:37:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 08/15] virtio-iommu: Implement
 map/unmap
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

On 8/19/19 10:11 AM, Peter Xu wrote:
> On Tue, Jul 30, 2019 at 07:21:30PM +0200, Eric Auger wrote:
> 
> [...]
> 
>> +    mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
>> +
>> +    while (mapping) {
>> +        viommu_interval current;
>> +        uint64_t low  = mapping->virt_addr;
>> +        uint64_t high = mapping->virt_addr + mapping->size - 1;
>> +
>> +        current.low = low;
>> +        current.high = high;
>> +
>> +        if (low == interval.low && size >= mapping->size) {
>> +            g_tree_remove(domain->mappings, (gpointer)(&current));
>> +            interval.low = high + 1;
>> +            trace_virtio_iommu_unmap_left_interval(current.low, current.high,
>> +                interval.low, interval.high);
>> +        } else if (high == interval.high && size >= mapping->size) {
>> +            trace_virtio_iommu_unmap_right_interval(current.low, current.high,
>> +                interval.low, interval.high);
>> +            g_tree_remove(domain->mappings, (gpointer)(&current));
>> +            interval.high = low - 1;
>> +        } else if (low > interval.low && high < interval.high) {
>> +            trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
>> +            g_tree_remove(domain->mappings, (gpointer)(&current));
>> +        } else {
>> +            break;
>> +        }
>> +        if (interval.low >= interval.high) {
>> +            return VIRTIO_IOMMU_S_OK;
>> +        } else {
>> +            mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
>> +        }
>> +    }
>> +
>> +    if (mapping) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
>> +                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported\n",
>> +                     __func__, interval.low, size,
>> +                     mapping->virt_addr, mapping->size);
>> +    } else {
>> +        return VIRTIO_IOMMU_S_OK;
>> +    }
>> +
>> +    return VIRTIO_IOMMU_S_INVAL;
> 
> Could the above chunk be simplified as something like below?
> 
>   while ((mapping = g_tree_lookup(domain->mappings, &interval))) {
>     g_tree_remove(domain->mappings, mapping);
>   }
Indeed the code could be simplified. I only need to make sure I don't
split an existing mapping.

Also I needed to use g_tree_lookup_extended to retrieve the actual key
to remove. The usage of g_tree_lookup_extended() allows me to remove the
virt_addr and size fields from the mapping value value struct as those
info can be retrieved from the key.

Thanks!

Eric
> 
> Thanks,
> 

