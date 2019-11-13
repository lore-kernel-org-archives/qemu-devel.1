Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1007C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F856206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lpaevlD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F856206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUyMu-0003vm-O6
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 14:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUyLJ-0003NE-1t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUyLF-00047E-JB
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:30:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUyLB-00042D-Uq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:30:12 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcc59bb0000>; Wed, 13 Nov 2019 11:30:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 13 Nov 2019 11:30:04 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 13 Nov 2019 11:30:04 -0800
Received: from [10.25.73.195] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 19:29:55 +0000
Subject: Re: [PATCH v9 Kernel 1/5] vfio: KABI for migration interface for
 device state
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-2-git-send-email-kwankhede@nvidia.com>
 <20191112153005.53bf324c@x1.home> <20191113112417.6e40ce96.cohuck@redhat.com>
 <20191113112733.49542ebc@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <94592507-fadb-0f10-ee17-f8d5678c70e5@nvidia.com>
Date: Thu, 14 Nov 2019 00:59:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191113112733.49542ebc@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573673403; bh=HsjPqQ4hOxhZCs+uNJwnCnNVsu1nj8I3kIdkeampWXc=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=lpaevlD4AFzX/IGXxo5IuXTJPwZnC+VKizPGPEHRf11mX9ZaXPiN/6+dKM1JK07sw
 EeR5klgGSGE/KATTGmV2/tgeX/IgboOrbXBlQDPLS1VGayxoZ1le2exzcdzNVs1x+q
 0x6MbrNE/nEWS0vEHcx+Wxq79UgM9dAnSIlN7QFeQlV7XqeSooy0Xh7cqXGf5zSe4W
 aUtiJlJLZBeWrBCVvfXZ+Xq7zohqco79Mhhki3s7+Az8I+lYC21F3DPFlnxgW+5Zbe
 SH0auLF9g3vCc8EjD5yahSufDniJQgJfbHDsSI/Mi1MjkdH+TsUQHWSZFL0Q2hzmh8
 P24KijOS6TMeQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, yan.y.zhao@intel.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 11:57 PM, Alex Williamson wrote:
> On Wed, 13 Nov 2019 11:24:17 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 12 Nov 2019 15:30:05 -0700
>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>
>>> On Tue, 12 Nov 2019 22:33:36 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    
>>>> - Defined MIGRATION region type and sub-type.
>>>> - Used 3 bits to define VFIO device states.
>>>>      Bit 0 => _RUNNING
>>>>      Bit 1 => _SAVING
>>>>      Bit 2 => _RESUMING
>>>>      Combination of these bits defines VFIO device's state during migration
>>>>      _RUNNING => Normal VFIO device running state. When its reset, it
>>>> 		indicates _STOPPED state. when device is changed to
>>>> 		_STOPPED, driver should stop device before write()
>>>> 		returns.
>>>>      _SAVING | _RUNNING => vCPUs are running, VFIO device is running but
>>>>                            start saving state of device i.e. pre-copy state
>>>>      _SAVING  => vCPUs are stopped, VFIO device should be stopped, and
>>>
>>> s/should/must/
>>>    
>>>>                  save device state,i.e. stop-n-copy state
>>>>      _RESUMING => VFIO device resuming state.
>>>>      _SAVING | _RESUMING and _RUNNING | _RESUMING => Invalid states
>>>
>>> A table might be useful here and in the uapi header to indicate valid
>>> states:
>>
>> I like that.
>>
>>>
>>> | _RESUMING | _SAVING | _RUNNING | Description
>>> +-----------+---------+----------+------------------------------------------
>>> |     0     |    0    |     0    | Stopped, not saving or resuming (a)
>>> +-----------+---------+----------+------------------------------------------
>>> |     0     |    0    |     1    | Running, default state
>>> +-----------+---------+----------+------------------------------------------
>>> |     0     |    1    |     0    | Stopped, migration interface in save mode
>>> +-----------+---------+----------+------------------------------------------
>>> |     0     |    1    |     1    | Running, save mode interface, iterative
>>> +-----------+---------+----------+------------------------------------------
>>> |     1     |    0    |     0    | Stopped, migration resume interface active
>>> +-----------+---------+----------+------------------------------------------
>>> |     1     |    0    |     1    | Invalid (b)
>>> +-----------+---------+----------+------------------------------------------
>>> |     1     |    1    |     0    | Invalid (c)
>>> +-----------+---------+----------+------------------------------------------
>>> |     1     |    1    |     1    | Invalid (d)
>>>
>>> I think we need to consider whether we define (a) as generally
>>> available, for instance we might want to use it for diagnostics or a
>>> fatal error condition outside of migration.
>>>
>>> Are there hidden assumptions between state transitions here or are
>>> there specific next possible state diagrams that we need to include as
>>> well?
>>
>> Some kind of state-change diagram might be useful in addition to the
>> textual description anyway. Let me try, just to make sure I understand
>> this correctly:
>>

During User application initialization, there is one more state change:

0) 0/0/0 ---- stop to running -----> 0/0/1

>> 1) 0/0/1 ---(trigger driver to start gathering state info)---> 0/1/1

not just gathering state info, but also copy device state to be 
transferred during pre-copy phase.

Below 2 state are not just to tell driver to stop, those 2 differ.
2) is device state changed from running to stop, this is when VM 
shutdowns cleanly, no need to save device state

>> 2) 0/0/1 ---(tell driver to stop)---> 0/0/0 

>> 3) 0/1/1 ---(tell driver to stop)---> 0/1/0

above is transition from pre-copy phase to stop-and-copy phase, where 
device data should be made available to user to transfer to destination 
or to save it to file in case of save VM or suspend.


>> 4) 0/0/1 ---(tell driver to resume with provided info)---> 1/0/0
> 
> I think this is to switch into resuming mode, the data will follow >
>> 5) 1/0/0 ---(driver is ready)---> 0/0/1
>> 6) 0/1/1 ---(tell driver to stop saving)---> 0/0/1
>

above can occur on migration cancelled or failed.


> I think also:
> 
> 0/0/1 --> 0/1/0 If user chooses to go directly to stop and copy

that's right, this happens in case of save VM or suspend VM.

> 
> 0/0/0 and 0/0/1 should be reachable from any state, though I could see
> that a vendor driver could fail transition from 1/0/0 -> 0/0/1 if the
> received state is incomplete.  Somehow though a user always needs to
> return the device to the initial state, so how does device_state
> interact with the reset ioctl?  Would this automatically manipulate
> device_state back to 0/0/1?

why would reset occur on 1/0/0 -> 0/0/1 failure?

1/0/0 -> 0/0/1 fails, then user should convey that to source that 
migration has failed, then resume at source.

>   
>> Not sure about the usefulness of 2).

I explained this above.

>> Also, is 4) the only way to
>> trigger resuming? 
Yes.

>> And is the change in 5) performed by the driver, or
>> by userspace?
>>
By userspace.

>> Are any other state transitions valid?
>>
>> (...)
>>
>>>> + * Sequence to be followed for _SAVING|_RUNNING device state or pre-copy phase
>>>> + * and for _SAVING device state or stop-and-copy phase:
>>>> + * a. read pending_bytes. If pending_bytes > 0, go through below steps.
>>>> + * b. read data_offset, indicates kernel driver to write data to staging buffer.
>>>> + *    Kernel driver should return this read operation only after writing data to
>>>> + *    staging buffer is done.
>>>
>>> "staging buffer" implies a vendor driver implementation, perhaps we
>>> could just state that data is available from (region + data_offset) to
>>> (region + data_offset + data_size) upon return of this read operation.
>>>    
>>>> + * c. read data_size, amount of data in bytes written by vendor driver in
>>>> + *    migration region.
>>>> + * d. read data_size bytes of data from data_offset in the migration region.
>>>> + * e. process data.
>>>> + * f. Loop through a to e. Next read on pending_bytes indicates that read data
>>>> + *    operation from migration region for previous iteration is done.
>>>
>>> I think this indicate that step (f) should be to read pending_bytes, the
>>> read sequence is not complete until this step.  Optionally the user can
>>> then proceed to step (b).  There are no read side-effects of (a) afaict.
>>>
>>> Is the use required to reach pending_bytes == 0 before changing
>>> device_state, particularly transitioning to !_RUNNING?  Presumably the
>>> user can exit this sequence at any time by clearing _SAVING.
>>
>> That would be transition 6) above (abort saving and continue). I think
>> it makes sense not to forbid this.
>>
>>>    
>>>> + *
>>>> + * Sequence to be followed while _RESUMING device state:
>>>> + * While data for this device is available, repeat below steps:
>>>> + * a. read data_offset from where user application should write data.
>>>> + * b. write data of data_size to migration region from data_offset.
>>>> + * c. write data_size which indicates vendor driver that data is written in
>>>> + *    staging buffer. Vendor driver should read this data from migration
>>>> + *    region and resume device's state.
>>>
>>> The device defaults to _RUNNING state, so a prerequisite is to set
>>> _RESUMING and clear _RUNNING, right?
>>

Sorry, I replied yes in my previous reply, but no. Default device state 
is _STOPPED. During resume _STOPPED -> _RESUMING

>> Transition 4) above. Do we need

I think, its not required.

>> 7) 0/0/0 ---(tell driver to resume with provided info)---> 1/0/0
>> as well? (Probably depends on how sensible the 0/0/0 state is.)
> 
> I think we must unless we require the user to transition from 0/0/1 to
> 1/0/0 in a single operation, but I'd prefer to make 0/0/0 generally
> available.  Thanks,
> 

its 0/0/0 -> 1/0/0 while resuming.

Thanks,
Kirti

> Alex
> 

