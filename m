Received: from eggs.gnu.org ([209.51.188.92]:41437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hF0f7-0002d4-DF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hF0f5-0006cC-IV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hF0f3-0006YP-Jm
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:12:27 -0400
References: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
	<4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
	<20190412122133.GG4522@linux.fritz.box>
	<663b6339-d82d-17a8-8351-0cd10ed4fad7@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <7567f598-d3c6-5db1-5bac-11d71b2356be@redhat.com>
Date: Fri, 12 Apr 2019 14:12:21 -0400
MIME-Version: 1.0
In-Reply-To: <663b6339-d82d-17a8-8351-0cd10ed4fad7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0?] hmp: delvm: use hmp_handle_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, dgilbert@redhat.com

On 4/12/19 10:55 AM, Eric Blake wrote:
> On 4/12/19 7:21 AM, Kevin Wolf wrote:
>> Am 10.04.2019 um 20:27 hat Eric Blake geschrieben:
>>> On 4/10/19 1:03 PM, Cole Robinson wrote:
>>>> This gives us the consistent 'Error:' prefix added in 66363e9a43f,
>>>> which helps users like libvirt who still need to scrape hmp error
>>>> messages to detect failure.
>>>>
>>>> Signed-off-by: Cole Robinson <crobinso@redhat.com>
>>>> ---
>>>>  hmp.c | 7 ++++---
>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> Not enough to drive -rc4 on its own, but worth adding to our wishlist of
>>> potential easy patches if we do have a release blocker surface.
>>
>> As we are going to have an -rc4, I had a look at this.
>>
>> Commit 66363e9a43f was in February and explicitly says "Note: Some
>> places don't use hmp_handle_error". So this doesn't seem to be a
>> regression and even if it's fixed, it's likely not the last place that
>> doesn't use the "Error:" prefix. This would suggest that this isn't for
>> -rc4.
>>
>> Am I misunderstanding the situation?
> 
> No, I think your read is accurate, and delaying this to 4.1 is okay.
>

Yup, this isn't really fixing any specific thing in libvirt, just a bit
of future proofing

> 
>>>> +        error_prepend(&err,
>>>> +                      "Error while deleting snapshot on device '%s': ",
>>>
>>> Do we want to reword the message (maybe s/Error while //) to avoid the
>>> word "Error" twice in the same line?
> 
> especially since we still would want this resolved via a v2, rather than
> taking this patch as-is.
> 
> 

I'll send a v2 after 4.0 is out

Thanks,
Cole
