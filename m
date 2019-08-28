Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA34C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513382070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513382070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2rOz-0001hp-DK
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 02:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i2rO7-00015U-5K
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i2rO6-0004ax-8L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i2rO4-0004Xf-47; Wed, 28 Aug 2019 02:24:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 282FD1089041;
 Wed, 28 Aug 2019 06:24:55 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3F26600D1;
 Wed, 28 Aug 2019 06:24:48 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190822172350.12008-1-eric.auger@redhat.com>
 <20190822172350.12008-3-eric.auger@redhat.com>
 <CAFEAcA94O=o+Kr25on40kv4UvyjdwVt29rVa9ObzgweJaYZuQg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ea3f7af8-3d08-9133-82f1-1f46f5cafb78@redhat.com>
Date: Wed, 28 Aug 2019 08:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94O=o+Kr25on40kv4UvyjdwVt29rVa9ObzgweJaYZuQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 28 Aug 2019 06:24:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/5] memory: Add
 IOMMU_ATTR_HW_NESTED_PAGING IOMMU memory region attribute
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/27/19 6:19 PM, Peter Maydell wrote:
> On Thu, 22 Aug 2019 at 18:24, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> We introduce a new IOMMU Memory Region attribute,
>> IOMMU_ATTR_HW_NESTED_PAGING that tells whether the virtual
>> IOMMU relies on physical IOMMU HW nested paging capability
>> when protecting host assigned devices.
> 
> I'm still not really happy with the name of this attribute.
> "IOMMU_ATTR_HW_NESTED_PAGING" sounds like it ought to mean
> "true if this IOMMU supports/is using hardware nested paging". What
> your commit message suggests it means is "true if this IOMMU
> *needs* hardware nested paging", but there's no NEEDS in the
> attribute name.

OK I will respin and add "_NEED_".

Thanks

Eric
> 
>> Current Intel virtual IOMMU device supports "Caching
>> Mode" and does not require 2 stages at physical level to be
>> integrated with VFIO. However SMMUv3 does not implement such
>> "caching mode" and requires to use HW nested paging.
>>
>> As such SMMUv3 is the first IOMMU device to advertise this
>> attribute.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> The code changes look good to me though.
> 
> thanks
> -- PMM
> 

