Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D75C74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791E020872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791E020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlS3u-0000r7-P6
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 01:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hlS3R-0000MN-57
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hlS3P-0002fC-Sv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hlS3M-0002a7-OJ; Thu, 11 Jul 2019 01:55:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24EBD59461;
 Thu, 11 Jul 2019 05:55:33 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C7E60600;
 Thu, 11 Jul 2019 05:55:20 +0000 (UTC)
To: Zhangfei Gao <zhangfei.gao@gmail.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
 <CAMj5BkgsJxKY89hURnf3dp2GE0quLr-NOPtQsYFQjOPEx6=Cqw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <63543f88-bdf7-753d-0337-67e7e86f0893@redhat.com>
Date: Thu, 11 Jul 2019 07:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMj5BkgsJxKY89hURnf3dp2GE0quLr-NOPtQsYFQjOPEx6=Cqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 11 Jul 2019 05:55:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 00/27] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
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
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 yi.l.liu@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com, qemu-devel@nongnu.org,
 peterx@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zhangfei,

On 7/11/19 3:53 AM, Zhangfei Gao wrote:
> On Mon, May 27, 2019 at 7:44 PM Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Up to now vSMMUv3 has not been integrated with VFIO. VFIO
>> integration requires to program the physical IOMMU consistently
>> with the guest mappings. However, as opposed to VTD, SMMUv3 has
>> no "Caching Mode" which allows easy trapping of guest mappings.
>> This means the vSMMUV3 cannot use the same VFIO integration as VTD.
>>
>> However SMMUv3 has 2 translation stages. This was devised with
>> virtualization use case in mind where stage 1 is "owned" by the
>> guest whereas the host uses stage 2 for VM isolation.
>>
>> This series sets up this nested translation stage. It only works
>> if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
>> other words, it does not work if there is a physical SMMUv2).
>>
>> The series uses a new kernel user API [1], still under definition.
>>
>> - We force the host to use stage 2 instead of stage 1, when we
>>   detect a vSMMUV3 is behind a VFIO device. For a VFIO device
>>   without any virtual IOMMU, we still use stage 1 as many existing
>>   SMMUs expect this behavior.
>> - We introduce new IOTLB "config" notifiers, requested to notify
>>   changes in the config of a given iommu memory region. So now
>>   we have notifiers for IOTLB changes and config changes.
>> - vSMMUv3 calls config notifiers when STE (Stream Table Entries)
>>   are updated by the guest.
>> - We implement a specific UNMAP notifier that conveys guest
>>   IOTLB invalidations to the host
>> - We implement a new MAP notifiers only used for MSI IOVAs so
>>   that the host can build a nested stage translation for MSI IOVAs
>> - As the legacy MAP notifier is not called anymore, we must make
>>   sure stage 2 mappings are set. This is achieved through another
>>   memory listener.
>> - Physical SMMUs faults are reported to the guest via en eventfd
>>   mechanism and reinjected into this latter.
>>
>> Note: The first patch is a code cleanup and was sent separately.
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v4.0.0-2stage-rfcv4
>>
>> Compatible with kernel series:
>> [PATCH v8 00/29] SMMUv3 Nested Stage Setup
>> (https://lkml.org/lkml/2019/5/26/95)
>>
> 
> Have tested vfio mode in qemu on arm64 platform.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> qemu: https://github.com/eauger/qemu/tree/v4.0.0-2stage-rfcv4
> kernel: https://github.com/eauger/linux/tree/v5.2-rc1-2stage-v8

Your testing is really appreciated.

Both kernel and QEMU series will be respinned. I am currently waiting
for 5.3 kernel window as it will resolve some dependencies on the fault
reporting APIs. My focus is to get the updated kernel series reviewed
and tested and then refine the QEMU integration accordingly.

Thanks

Eric


> 

