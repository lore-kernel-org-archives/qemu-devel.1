Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE23C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3132081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3132081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbay-00063r-Vj
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:52:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVbZv-0005Zh-BO
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVbZu-0006yb-9x
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hVbZr-0006uf-Q8; Tue, 28 May 2019 08:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA402C0528CB;
	Tue, 28 May 2019 12:51:27 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B53611C5;
	Tue, 28 May 2019 12:51:23 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
	<20190527114203.2762-9-eric.auger@redhat.com>
	<20190528024747.GA23180@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6e747747-8069-3f85-2e29-4b95f03e0719@redhat.com>
Date: Tue, 28 May 2019 14:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190528024747.GA23180@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 28 May 2019 12:51:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 08/27] hw/vfio/common: Force nested if
 iommu requires it
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, drjones@redhat.com, yi.l.liu@intel.com,
	mst@redhat.com, jean-philippe.brucker@arm.com,
	zhangfei.gao@foxmail.com, qemu-devel@nongnu.org,
	alex.williamson@redhat.com, qemu-arm@nongnu.org,
	vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 5/28/19 4:47 AM, Peter Xu wrote:
> On Mon, May 27, 2019 at 01:41:44PM +0200, Eric Auger wrote:
>> In case we detect the address space is translated by
>> a virtual IOMMU which requires nested stages, let's set up
>> the container with the VFIO_TYPE1_NESTING_IOMMU iommu_type.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - add "nested only is selected if requested by @force_nested"
>>   comment in this patch
>> ---
>>  hw/vfio/common.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 1f1deff360..99ade21056 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1136,14 +1136,19 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>>   * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
>>   */
>>  static int vfio_get_iommu_type(VFIOContainer *container,
>> +                               bool force_nested,
>>                                 Error **errp)
>>  {
>> -    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>> +    int iommu_types[] = { VFIO_TYPE1_NESTING_IOMMU,
>> +                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>>                            VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
>>      int i;
>>  
>>      for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
>>          if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
>> +            if (iommu_types[i] == VFIO_TYPE1_NESTING_IOMMU && !force_nested) {
> 
> If force_nested==true and if the kernel does not support
> VFIO_TYPE1_NESTING_IOMMU, we will still return other iommu types?
> That seems to not match with what "force" mean here.
> 
> What I feel like is that we want an "iommu_nest_types[]" which only
> contains VFIO_TYPE1_NESTING_IOMMU.  Then:
> 
>         if (nested) {
>                 target_types = iommu_nest_types;
>         } else {
>                 target_types = iommu_types;
>         }
> 
>         foreach (target_types)
>                 ...
> 
>         return -EINVAL;
> 
> Might be clearer?  Then we can drop [2] below since we'll fail earlier
> at [1].

agreed. I can fail immediately in case the nested mode was requested and
not supported. This will be clearer.

Thanks!


Eric
> 
>> +                continue;
>> +            }
>>              return iommu_types[i];
>>          }
>>      }
>> @@ -1152,11 +1157,11 @@ static int vfio_get_iommu_type(VFIOContainer *container,
>>  }
>>  
>>  static int vfio_init_container(VFIOContainer *container, int group_fd,
>> -                               Error **errp)
>> +                               bool force_nested, Error **errp)
>>  {
>>      int iommu_type, ret;
>>  
>> -    iommu_type = vfio_get_iommu_type(container, errp);
>> +    iommu_type = vfio_get_iommu_type(container, force_nested, errp);
>>      if (iommu_type < 0) {
>>          return iommu_type;
> 
> [1]
> 
>>      }
>> @@ -1192,6 +1197,14 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>      VFIOContainer *container;
>>      int ret, fd;
>>      VFIOAddressSpace *space;
>> +    IOMMUMemoryRegion *iommu_mr;
>> +    bool force_nested = false;
>> +
>> +    if (as != &address_space_memory && memory_region_is_iommu(as->root)) {
>> +        iommu_mr = IOMMU_MEMORY_REGION(as->root);
>> +        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
>> +                                     (void *)&force_nested);
>> +    }
>>  
>>      space = vfio_get_address_space(as);
>>  
>> @@ -1252,12 +1265,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>      QLIST_INIT(&container->giommu_list);
>>      QLIST_INIT(&container->hostwin_list);
>>  
>> -    ret = vfio_init_container(container, group->fd, errp);
>> +    ret = vfio_init_container(container, group->fd, force_nested, errp);
>>      if (ret) {
>>          goto free_container_exit;
>>      }
>>  
>> +    if (force_nested && container->iommu_type != VFIO_TYPE1_NESTING_IOMMU) {
>> +            error_setg(errp, "nested mode requested by the virtual IOMMU "
>> +                       "but not supported by the vfio iommu");
>> +    }
> 
> [2]
> 
>> +
>>      switch (container->iommu_type) {
>> +    case VFIO_TYPE1_NESTING_IOMMU:
>>      case VFIO_TYPE1v2_IOMMU:
>>      case VFIO_TYPE1_IOMMU:
>>      {
>> -- 
>> 2.20.1
>>
> 
> Regards,
> 

