Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE9C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D79B2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D79B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39863 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVff9-0003Lj-Mz
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 13:13:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVfeI-00030L-Qz
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVfeG-0003Gk-Tr
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:12:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hVfe5-00030k-3F; Tue, 28 May 2019 13:12:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62342306E61C;
	Tue, 28 May 2019 17:12:03 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B3D235D6A9;
	Tue, 28 May 2019 17:11:47 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
	<20190527114203.2762-10-eric.auger@redhat.com>
	<20190528044825.GB23180@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <07ac6fac-44d5-9a0a-dda9-1d0a70ff9901@redhat.com>
Date: Tue, 28 May 2019 19:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190528044825.GB23180@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 28 May 2019 17:12:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 09/27] memory: Prepare for different kinds
 of IOMMU MR notifiers
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

On 5/28/19 6:48 AM, Peter Xu wrote:
> On Mon, May 27, 2019 at 01:41:45PM +0200, Eric Auger wrote:
> 
> [...]
> 
>> @@ -3368,8 +3368,9 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>  {
>>      IOMMUTLBEntry entry;
>>      hwaddr size;
>> -    hwaddr start = n->start;
>> -    hwaddr end = n->end;
>> +
> 
> (extra new line)
> 
>> +    hwaddr start = n->iotlb_notifier.start;
>> +    hwaddr end = n->iotlb_notifier.end;
>>      IntelIOMMUState *s = as->iommu_state;
>>      DMAMap map;
> 
> [...]
> 
>>  typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
>>                              IOMMUTLBEntry *data);
>>  
>> -struct IOMMUNotifier {
>> +typedef struct IOMMUIOLTBNotifier {
>>      IOMMUNotify notify;
> 
> Hi, Eric,
> 
> I wasn't following the thread much before so sorry to ask this if too
> late - have you thought about using the Notifier struct direct?
> Because then it'll (1) allow the user to register with both IOTLB |
> CONFIG flags in the same notifier while currently we'll need to
> register one for each (and this worries me a bit on when we grow the
> types of flags further then one register can have quite a few
> notifiers) (2) the notifier part can be shared by different events.
> Then when notify the (void *) data can be an union:
> 
> struct IOMMUEvent {
>   int event; // can be one of the notifier flags
>   union {
>     struct IOTLBEvent {
>       ...
>     };
>     struct PASIDEvent {
>       ...
>     };
>   }
> }

I am currently prototyping your suggestion. I think this would clarify
some parts of the code to see clearly the type of event that is
propagated. I will send a separate RFC for this change.

Thanks!

Eric
> 
> Then the handler hook would be simple too:
> 
> handler (data)
> {
>   switch (data.event) {
>     ...
>   }
> }
> 
> I would be fine with current patch if this series is close to be
> merged because even if we want that we can do that on top when we
> introduce even more notifiers, but just to ask loud first.
> 
>> -    IOMMUNotifierFlag notifier_flags;
>>      /* Notify for address space range start <= addr <= end */
>>      hwaddr start;
>>      hwaddr end;
>> +} IOMMUIOLTBNotifier;
>> +
>> +struct IOMMUNotifier {
>> +    IOMMUNotifierFlag notifier_flags;
>> +    union {
>> +        IOMMUIOLTBNotifier iotlb_notifier;
>> +    };
>>      int iommu_idx;
>>      QLIST_ENTRY(IOMMUNotifier) node;
>>  };
>> @@ -126,15 +132,18 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>>  /* RAM is a persistent kind memory */
>>  #define RAM_PMEM (1 << 5)
>>  
>> -static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>> -                                       IOMMUNotifierFlag flags,
>> -                                       hwaddr start, hwaddr end,
>> -                                       int iommu_idx)
>> +static inline void iommu_iotlb_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>> +                                             IOMMUNotifierFlag flags,
>> +                                             hwaddr start, hwaddr end,
>> +                                             int iommu_idx)
>>  {
>> -    n->notify = fn;
>> +    assert(flags & IOMMU_NOTIFIER_IOTLB_MAP ||
>> +           flags & IOMMU_NOTIFIER_IOTLB_UNMAP);
> 
> Can use IOMMU_NOTIFIER_IOTLB_ALL directly?
> 
>> +    assert(start < end);
>>      n->notifier_flags = flags;
>> -    n->start = start;
>> -    n->end = end;
>> +    n->iotlb_notifier.notify = fn;
>> +    n->iotlb_notifier.start = start;
>> +    n->iotlb_notifier.end = end;
>>      n->iommu_idx = iommu_idx;
>>  }
> 
> Otherwise the patch looks good to me.
> 
> Regards,
> 

