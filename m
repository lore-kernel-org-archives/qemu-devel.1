Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46FCC04AB4
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 02:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B997E21880
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 02:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B997E21880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56389 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRonh-0007DQ-O7
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 22:10:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hRomu-0006pT-9O
	for qemu-devel@nongnu.org; Fri, 17 May 2019 22:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hRoYR-0001mG-70
	for qemu-devel@nongnu.org; Fri, 17 May 2019 21:54:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:33247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kenneth.heitke@intel.com>)
	id 1hRoTY-0001K0-Q8; Fri, 17 May 2019 21:49:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 May 2019 18:49:20 -0700
Received: from unknown (HELO [10.232.112.136]) ([10.232.112.136])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	17 May 2019 18:49:19 -0700
To: qemu-block@nongnu.org, keith.busch@intel.com, kwolf@redhat.com,
	qemu-devel@nongnu.org, mreitz@redhat.com
References: <20190405214117.1850-1-kenneth.heitke@intel.com>
	<20190514060225.GA1350@apples.localdomain>
	<1f607df5-b523-e517-c439-392725fd441b@intel.com>
	<20190517053504.GA17341@apples.localdomain>
	<20190517062442.GB17341@apples.localdomain>
From: "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <78248b8b-2684-409a-1e33-77b4c0907cd6@intel.com>
Date: Fri, 17 May 2019 19:49:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517062442.GB17341@apples.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nvme: add Get/Set Feature
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



On 5/17/2019 12:24 AM, Klaus Birkelund wrote:
> On Fri, May 17, 2019 at 07:35:04AM +0200, Klaus Birkelund wrote:
>> Hi Kenneth,
>>
>> On Thu, May 16, 2019 at 05:24:47PM -0600, Heitke, Kenneth wrote:
>>> Hi Klaus, thank you for you review. I have one comment inline
>>>
>>> On 5/14/2019 12:02 AM, Klaus Birkelund wrote:
>>>> On Fri, Apr 05, 2019 at 03:41:17PM -0600, Kenneth Heitke wrote:
>>>>> Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
>>>>> ---
>>>>>    hw/block/nvme.c       | 120 +++++++++++++++++++++++++++++++++++++++++-
>>>>>    hw/block/nvme.h       |   3 ++
>>>>>    hw/block/trace-events |   2 +
>>>>>    include/block/nvme.h  |   2 +
>>>>>    4 files changed, 125 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>>>> index 7caf92532a..e775e89299 100644
>>>>> --- a/hw/block/nvme.c
>>>>> +++ b/hw/block/nvme.c
>>>>> @@ -219,6 +219,30 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>>>>>        return NVME_INVALID_FIELD | NVME_DNR;
>>>>>    }
>>>>> +static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>>>>> +                                   uint64_t prp1, uint64_t prp2)
>>>>> +{
>>>>> +    QEMUSGList qsg;
>>>>> +    QEMUIOVector iov;
>>>>> +    uint16_t status = NVME_SUCCESS;
>>>>> +
>>>>> +    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
>>>>> +        return NVME_INVALID_FIELD | NVME_DNR;
>>>>> +    }
>>>>> +    if (qsg.nsg > 0) {
>>>>> +        if (dma_buf_write(ptr, len, &qsg)) {
>>>>> +            status = NVME_INVALID_FIELD | NVME_DNR;
>>>>> +        }
>>>>> +        qemu_sglist_destroy(&qsg);
>>>>> +    } else {
>>>>> +        if (qemu_iovec_from_buf(&iov, 0, ptr, len) != len) {
>>>>
>>>> This should be `qemu_iovec_to_buf`.
>>>>
>>>
>>> This function is transferring data from the "host" to the device so I
>>> believe I am using the correct function.
>>>
>>
>> Exactly, but this means that you need to populate `ptr` with data
>> described by the prps, hence dma_buf_*write* and qemu_iovec_*to*_buf. In
>> this case `ptr` is set to the address of the uint64_t timestamp, and
>> that is what we need to write to.
>>
> 
> I was going to argue with the fact that nvme_dma_read_prp uses
> qemu_iovec_from_buf. But it uses _to_buf which as far as I can tell is
> also wrong.
> 

Okay, I'm onboard. You're correct. I'll update my patch and re-submit. I 
can also submit a patch to fix nvme_dma_read_prp() unless you or someone 
else wants to.

Thanks

