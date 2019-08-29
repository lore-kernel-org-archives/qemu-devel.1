Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B8C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1902B2342D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1902B2342D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3FSA-000580-BL
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 04:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i3FRA-0004Kq-84
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i3FR8-0004DZ-M0
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:05:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i3FR8-0004DM-Gc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A9B13086228;
 Thu, 29 Aug 2019 08:05:41 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A501B19D7A;
 Thu, 29 Aug 2019 08:05:28 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190812074531.28970-1-peterx@redhat.com>
 <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
 <e128decc-8b40-160e-fe8e-673682530750@redhat.com>
 <20190829011850.GC8729@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ba2df187-81cd-6dbb-992b-6ae9a7b35e37@redhat.com>
Date: Thu, 29 Aug 2019 10:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190829011850.GC8729@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 29 Aug 2019 08:05:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 8/29/19 3:18 AM, Peter Xu wrote:
> On Wed, Aug 28, 2019 at 02:59:45PM +0200, Auger Eric wrote:
>> Hi Peter,
> 
> Hi, Eric,
> 
> [...]
> 
>> In
>> [PATCH v4 2/5] memory: Add IOMMU_ATTR_HW_NESTED_PAGING IOMMU memory
>> region attribute (https://patchwork.kernel.org/patch/11109701/)
> 
> [1]
> 
>>
>> [PATCH v4 3/5] hw/vfio/common: Fail on VFIO/HW nested paging detection
>> (https://patchwork.kernel.org/patch/11109697/)
>>
>> I proposed to introduce a new IOMMU MR attribute to retrieve whether the
>> vIOMMU uses HW nested paging to integrate with VFIO. I wonder whether
>> this kind of solution would fit your need too.
>>
>> Assuming we would rename the attribute (whose name is challenged by
>> Peter anyway) into something like IOMMU_ATTR_PHYS_MAP_MODE
>> taking the possible values: NONE, CM, HW_NESTED_PAGING. SMMUv3 would
>> return HW_NESTED_PAGING, Intel IOMMU would return CM if CM is enabled or
>> NONE in the negative. Then we could implement the check directly in VFIO
>> common.c. That way I don't think you would need the new notifiers and
>> this would satisfy both requirements?
> 
> IMHO it'll suffer from the similar issue we have now with
> flag_changed, because at the very beginning of x86 system boots DMAR
> is not yet enabled, the intel-iommu device is using the same mode as
> its passthrough mode so there's no IOMMU memory region at all in the
> DMA address spaces of the devices.

Ah OK I did not get this initially. We don't have this issue with SMMUv3
as the IOMMU MR exists from the very beginning and does not depend on
its enablement by the guest. Also it stays there. So the detection can
be made immediatly.

  Hence even with patch [1] above we
> still can't really reach the get_attr() check until DMAR enabled?
> 
> Maybe we can figure out a good way to expose IOMMU attributes rather
> than the IOMMU memory region attributes then we let vfio to pick that
> up, but I'm not very sure whether that's clean enough.
> 
> Thanks,
> 

Thanks

Eric

