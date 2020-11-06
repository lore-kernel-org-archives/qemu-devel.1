Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACFC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E449920735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XHrSRLK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6wn-0005fl-Kr
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kb6vs-0004qA-TT
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:57:56 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kb6vq-0000gz-Dj
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:57:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa59cae0000>; Fri, 06 Nov 2020 10:57:50 -0800
Received: from [10.40.102.53] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 18:57:49 +0000
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
 <20201029125221.69352b48.cohuck@redhat.com>
 <9479dffd-e434-e336-6ed8-07fc2edd2453@nvidia.com>
 <20201029130519.7eb1e704@w520.home>
 <47f8ccea-f75a-dfb7-b646-28d5123b322f@nvidia.com>
 <20201103132758.04b18f5c@w520.home>
 <a27dee38-2fa9-a6ae-de30-eb7b57629393@nvidia.com>
 <20201104054527.22bbace7@x1.home>
 <6abf200c-972a-cbdb-8106-d197dccb780d@nvidia.com>
 <20201105121150.44e347ed@w520.home>
 <1d8ab1f9-8bf7-5f1f-ea3c-b23129492597@nvidia.com>
 <20201105142645.2f5718b0@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <0bc1f224-fe97-588a-3263-305f771ca6d0@nvidia.com>
Date: Sat, 7 Nov 2020 00:27:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201105142645.2f5718b0@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604689070; bh=ydJ/o5TwQ8UnjielMdpS2VWJFNHbwjEiIvQWLD1rwOI=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=XHrSRLK0HaTOPVhVRO/11mtNeKJ2ZTl9WAqoSu/0c+e4fI4U5k7SxwDamym9UWqvo
 ssrx5gUf1ZP08TwgPRs8+Ts3DgkqcwS4Q/P7P3NWObDssDjhAefLppMhhSun7Fhml8
 a2IF3jA/8NwySzJ2awwdF8hAmsnmqdiPgWXlbeFO1Hque8KyyhRV6hbYNEoYOmy4QF
 Kc8mmQh/jHbUPyWrXyU/xHGezjzTjFZKKkZuhuNDDVpAIaT4ut/+moIOUsiiX7jjdG
 Z/LLXBk56cXVt27JOHiAGR8nfc1kTza/ogAtSYtHh1mvp2kpa/RlYfpPbclm/dHBZ8
 K03cHrcqApcDw==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 13:57:52
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/6/2020 2:56 AM, Alex Williamson wrote:
> On Fri, 6 Nov 2020 02:22:11 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 11/6/2020 12:41 AM, Alex Williamson wrote:
>>> On Fri, 6 Nov 2020 00:29:36 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    
>>>> On 11/4/2020 6:15 PM, Alex Williamson wrote:
>>>>> On Wed, 4 Nov 2020 13:25:40 +0530
>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>       
>>>>>> On 11/4/2020 1:57 AM, Alex Williamson wrote:
>>>>>>> On Wed, 4 Nov 2020 01:18:12 +0530
>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>          
>>>>>>>> On 10/30/2020 12:35 AM, Alex Williamson wrote:
>>>>>>>>> On Thu, 29 Oct 2020 23:11:16 +0530
>>>>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>>>>>>>             
>>>>>>>>
>>>>>>>> <snip>
>>>>>>>>         
>>>>>>>>>>>> +System memory dirty pages tracking
>>>>>>>>>>>> +----------------------------------
>>>>>>>>>>>> +
>>>>>>>>>>>> +A ``log_sync`` memory listener callback is added to mark system memory pages
>>>>>>>>>>>
>>>>>>>>>>> s/is added to mark/marks those/
>>>>>>>>>>>                
>>>>>>>>>>>> +as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried
>>>>>>>>>>>
>>>>>>>>>>> s/by/by the/
>>>>>>>>>>> s/Dirty/The dirty/
>>>>>>>>>>>                
>>>>>>>>>>>> +per container. All pages pinned by vendor driver through vfio_pin_pages()
>>>>>>>>>>>
>>>>>>>>>>> s/by/by the/
>>>>>>>>>>>                
>>>>>>>>>>>> +external API have to be marked as dirty during migration. When there are CPU
>>>>>>>>>>>> +writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
>>>>>>>>>>>> +by vendor driver can also be written by device. There is currently no device
>>>>>>>>>>>
>>>>>>>>>>> s/by/by the/ (x2)
>>>>>>>>>>>                
>>>>>>>>>>>> +which has hardware support for dirty page tracking. So all pages which are
>>>>>>>>>>>> +pinned by vendor driver are considered as dirty.
>>>>>>>>>>>> +Dirty pages are tracked when device is in stop-and-copy phase because if pages
>>>>>>>>>>>> +are marked dirty during pre-copy phase and content is transfered from source to
>>>>>>>>>>>> +destination, there is no way to know newly dirtied pages from the point they
>>>>>>>>>>>> +were copied earlier until device stops. To avoid repeated copy of same content,
>>>>>>>>>>>> +pinned pages are marked dirty only during stop-and-copy phase.
>>>>>>>>>>
>>>>>>>>>>            
>>>>>>>>>>> Let me take a quick stab at rewriting this paragraph (not sure if I
>>>>>>>>>>> understood it correctly):
>>>>>>>>>>>
>>>>>>>>>>> "Dirty pages are tracked when the device is in the stop-and-copy phase.
>>>>>>>>>>> During the pre-copy phase, it is not possible to distinguish a dirty
>>>>>>>>>>> page that has been transferred from the source to the destination from
>>>>>>>>>>> newly dirtied pages, which would lead to repeated copying of the same
>>>>>>>>>>> content. Therefore, pinned pages are only marked dirty during the
>>>>>>>>>>> stop-and-copy phase." ?
>>>>>>>>>>>                
>>>>>>>>>>
>>>>>>>>>> I think above rephrase only talks about repeated copying in pre-copy
>>>>>>>>>> phase. Used "copied earlier until device stops" to indicate both
>>>>>>>>>> pre-copy and stop-and-copy till device stops.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Now I'm confused, I thought we had abandoned the idea that we can only
>>>>>>>>> report pinned pages during stop-and-copy.  Doesn't the device needs to
>>>>>>>>> expose its dirty memory footprint during the iterative phase regardless
>>>>>>>>> of whether that causes repeat copies?  If QEMU iterates and sees that
>>>>>>>>> all memory is still dirty, it may have transferred more data, but it
>>>>>>>>> can actually predict if it can achieve its downtime tolerances.  Which
>>>>>>>>> is more important, less data transfer or predictability?  Thanks,
>>>>>>>>>             
>>>>>>>>
>>>>>>>> Even if QEMU copies and transfers content of all sys mem pages during
>>>>>>>> pre-copy (worst case with IOMMU backed mdev device when its vendor
>>>>>>>> driver is not smart to pin pages explicitly and all sys mem pages are
>>>>>>>> marked dirty), then also its prediction about downtime tolerance will
>>>>>>>> not be correct, because during stop-and-copy again all pages need to be
>>>>>>>> copied as device can write to any of those pinned pages.
>>>>>>>
>>>>>>> I think you're only reiterating my point.  If QEMU copies all of guest
>>>>>>> memory during the iterative phase and each time it sees that all memory
>>>>>>> is dirty, such as if CPUs or devices (including assigned devices) are
>>>>>>> dirtying pages as fast as it copies them (or continuously marks them
>>>>>>> dirty), then QEMU can predict that downtime will require copying all
>>>>>>> pages.
>>>>>>
>>>>>> But as of now there is no way to know if device has dirtied pages during
>>>>>> iterative phase.
>>>>>
>>>>>
>>>>> This claim doesn't make any sense, pinned pages are considered
>>>>> persistently dirtied, during the iterative phase and while stopped.
>>>>>
>>>>>         
>>>>>>> If instead devices don't mark dirty pages until the VM is
>>>>>>> stopped, then QEMU might iterate through memory copy and predict a short
>>>>>>> downtime because not much memory is dirty, only to be surprised that
>>>>>>> all of memory is suddenly dirty.  At that point it's too late, the VM
>>>>>>> is already stopped, the predicted short downtime takes far longer than
>>>>>>> expected.  This is exactly why we made the kernel interface mark pinned
>>>>>>> pages persistently dirty when it was proposed that we only report
>>>>>>> pinned pages once.  Thanks,
>>>>>>>          
>>>>>>
>>>>>> Since there is no way to know if device dirtied pages during iterative
>>>>>> phase, QEMU should query pinned pages in stop-and-copy phase.
>>>>>
>>>>>
>>>>> As above, I don't believe this is true.
>>>>>
>>>>>       
>>>>>> Whenever there will be hardware support or some software mechanism to
>>>>>> report pages dirtied by device then we will add a capability bit in
>>>>>> migration capability and based on that capability bit qemu/user space
>>>>>> app should decide to query dirty pages in iterative phase.
>>>>>
>>>>>
>>>>> Yes, we could advertise support for fine granularity dirty page
>>>>> tracking, but I completely disagree that we should consider pinned
>>>>> pages clean until suddenly exposing them as dirty once the VM is
>>>>> stopped.  Thanks,
>>>>>       
>>>>
>>>> Should QEMU copy dirtied pages twice, during iterative phase and then
>>>> when VM is stopped?
>>>
>>> I don't understand why this is controversial.  We cannot decide within
>>> the vfio device to only expose device dirtied pages in the final stage
>>> of migration.  It's not our job to minimize the number of pages copied
>>> beyond the hardware granularity.  If core QEMU migration code asks for
>>> dirty pages, we provide them, regardless of how many times we report a
>>> page as dirty.  So yes, if that migration code asks for dirty pages in
>>> the iterative stage and the stopped stage, we provide them both times.
>>
>> Isn't that would increase total migration time?
> 
> As I explained, that's not a policy decision that we as a device within
> the VM should be making.  We do not have the visibility to determine
> how the footprint of our device will affect the migration and by
> preventing QEMU migration code from understanding the device footprint,
> we're creating a scenario where QEMU absolutely cannot predict the
> downtime.
>

If VFIO device dirtied lot of memory and each time VFIO device reports 
all those as dirty during iterative phase, then migration would never 
converge.

If there is a way to track dirty pages during iterative phase and there 
is a way to know that pages weren't dirtied again, then it makes sense 
for them to reported during the iterative phase.

Since there is no hardware support to track pages dirtied by device, for 
now best way would be to report those during stop-and-copy.

Thanks,
Kirti

>>> If someone wants to skip the iterative phase altogether, I imagine
>>> there are migration parameters that allow it, but we should not be
>>> determining that policy at the device level.  Thanks,
>>>    
>>
>> What is that parameter? should that be documented here?
> 
> Dunno, but clearly we could pause the VM, migration, and resume on the
> target.  I imagine there are migration tuning parameters that might do
> essentially that automatically.  Thanks,
> 
> Alex
> 

