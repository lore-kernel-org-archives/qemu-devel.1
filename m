Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444FC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F5821882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F5821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibXe-0004N6-Lu
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hibI3-0001eo-Mx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hibI1-00025o-Mn
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:10:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hibHo-0001gn-72; Wed, 03 Jul 2019 05:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7801730B824C;
 Wed,  3 Jul 2019 09:10:42 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D8CAB240E;
 Wed,  3 Jul 2019 09:10:36 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-3-eric.auger@redhat.com> <20190703054236.GF10408@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <49890b46-cd8d-898a-8b73-6043a443297c@redhat.com>
Date: Wed, 3 Jul 2019 11:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190703054236.GF10408@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 09:10:42 +0000 (UTC)
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

Hi Peter,

On 7/3/19 7:42 AM, Peter Xu wrote:
> On Mon, Jul 01, 2019 at 11:30:30AM +0200, Eric Auger wrote:
>> We introduce a new IOMMU Memory Region attribute,
>> IOMMU_ATTR_VFIO_NESTED that tells whether the virtual IOMMU
>> requires physical nested stages for VFIO integration.
>>
>> Current Intel virtual IOMMU device supports "Caching
>> Mode" and does not require 2 stages at physical level to be
>> integrated with VFIO. However SMMUv3 does not implement such
>> "caching mode" and requires to use physical stage 1 for VFIO
>> integration.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  include/exec/memory.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index bdd76653a8..dd7ef23f96 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -204,7 +204,8 @@ struct MemoryRegionOps {
>>  };
>>  
>>  enum IOMMUMemoryRegionAttr {
>> -    IOMMU_ATTR_SPAPR_TCE_FD
>> +    IOMMU_ATTR_SPAPR_TCE_FD,
>> +    IOMMU_ATTR_VFIO_NESTED,
> 
> IMHO it'll be better if this patch can be squashed into the first user
> of the new flag to better clarify itself on why it will be needed (if
> finally we still would like to have this flag).
sure I will squash it.

Nested mode requires important adaptations in the current
hw/vfio/common.c code to register specific notifiers: UNMAP, config
change, MSI binding notifiers (this one actually uses a MAP notifier by
the way). So there we need to recognize an IOMMU works in nested mode
one way or another.

Thanks

Eric
> 
> Regards,
> 

