Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0523CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0523CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCu8-0005LZ-Js
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 13:07:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hYCt7-0004u3-J9
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hYCt6-0002oF-Hu
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:06:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:39868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kenneth.heitke@intel.com>)
	id 1hYCt6-0002Qe-73; Tue, 04 Jun 2019 13:06:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jun 2019 10:06:07 -0700
Received: from unknown (HELO [10.232.112.171]) ([10.232.112.171])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	04 Jun 2019 10:06:06 -0700
To: Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, keith.busch@intel.com,
	qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org
References: <20190520174030.1647-1-kenneth.heitke@intel.com>
	<20190528061836.GB32236@apples.localdomain>
	<20190603111409.GD6523@linux.fritz.box>
	<a58ef975-78f2-9c5c-35c2-b2dd359a4c03@intel.com>
	<20190604082828.GA11013@apples.localdomain>
	<20190604084645.GB14925@linux.fritz.box>
	<20190604091358.GB11013@apples.localdomain>
From: "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <6eecf534-edaa-6763-c91a-8b159313a493@intel.com>
Date: Tue, 4 Jun 2019 11:06:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604091358.GB11013@apples.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] nvme: add Get/Set Feature
 Timestamp support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/4/2019 3:13 AM, Klaus Birkelund wrote:
> On Tue, Jun 04, 2019 at 10:46:45AM +0200, Kevin Wolf wrote:
>> Am 04.06.2019 um 10:28 hat Klaus Birkelund geschrieben:
>>> On Mon, Jun 03, 2019 at 09:30:53AM -0600, Heitke, Kenneth wrote:
>>>>
>>>>
>>>> On 6/3/2019 5:14 AM, Kevin Wolf wrote:
>>>>> Am 28.05.2019 um 08:18 hat Klaus Birkelund geschrieben:
>>>>>> On Mon, May 20, 2019 at 11:40:30AM -0600, Kenneth Heitke wrote:
>>>>>>> Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
>>>>>
>>>>>>> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
>>>>>>> index 56c9d4b4b1..d7277e72b7 100644
>>>>>>> --- a/hw/block/nvme.h
>>>>>>> +++ b/hw/block/nvme.h
>>>>>>> @@ -69,6 +69,7 @@ typedef struct NvmeCtrl {
>>>>>>>        uint16_t    max_prp_ents;
>>>>>>>        uint16_t    cqe_size;
>>>>>>>        uint16_t    sqe_size;
>>>>>>> +    uint16_t    oncs;
>>>>>>
>>>>>> Looks like this unused member snuck its way into the patch. But I see no
>>>>>> harm in it being there.
>>>>>
>>>>> Good catch. I'll just remove it again from my branch.
>>>>>
>>>>>>> +static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
>>>>>>> +{
>>>>>>> +    trace_nvme_setfeat_timestamp(ts);
>>>>>>> +
>>>>>>> +    n->host_timestamp = le64_to_cpu(ts);
>>>>>>> +    n->timestamp_set_qemu_clock_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
>>>>>>> +{
>>>>>>> +    uint64_t current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>>>
>>>>> Here I wonder why we use QEMU_CLOCK_REALTIME in a device emulation.
>>>>> Wouldn't QEMU_CLOCK_VIRTUAL make more sense?
>>>>>
>>>>
>>>> QEMU_CLOCK_VIRTUAL probably would make more sense. When I was reading
>>>> through the differences I wasn't really sure what to pick. iven that this is
>>>> the time within the device's context, the virtual time seems more correct.
>>>>
>>>   
>>> I thought about this too when I reviewed, but came to the conclusion
>>> that REALTIME was correct. The timestamp is basically a value that the
>>> host stores in the controller. When the host uses Get Features to get
>>> the the current time it would expect it to match the progression for its
>>> own wall clockright? If I understand REALTIME vs VIRTUAL correctly,
>>> using VIRTUAL, it would go way out of sync.
>>
>> Which two things would go out of sync with VIRTUAL?
>>
>> Not an expert on clocks myself, but I think the main question is what
>> happens to the clock while the VM is stopped. REALTIME continues running
>> where as VIRTUAL is stopped. If we expose REALTIME measurements to the
>> guest, the time passed may look a lot longer than what the guest's clock
>> actually says. So this is the thing I am worried would go out of sync
>> with REALTIME.
>>
> 
> OK, fair point.
> 
> Thinking about this some more, I agree that VIRTUAL is more correct. An
> application should never track elapsed time using real wall clock time,
> but some monotonic clock that is oblivious to say NTP adjustments.
> 
> Klaus
> 

Kevin, would you like me to update the patch to reflect this change or 
will you make the change directly?

thanks,
Ken

