Received: from eggs.gnu.org ([2001:4830:134:3::10]:35722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnNlK-0005Ga-Ma
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnNlH-0007YJ-EW
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:40:26 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <a742f854-1db4-66f3-fa1c-1780841f2d47@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-5-lbloch@janustech.com>
	<w51in4lt6zv.fsf@maestria.local.igalia.com>
	<28c19ef6-4e22-7509-f4b9-f683385933f7@janustech.com>
	<w51ftzpt6jd.fsf@maestria.local.igalia.com>
	<a742f854-1db4-66f3-fa1c-1780841f2d47@janustech.com>
Date: Wed, 08 Aug 2018 14:40:21 +0200
Message-ID: <w51a7pxt4ju.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qcow2: Set the default
 cache-clean-interval to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 08 Aug 2018 02:17:47 PM CEST, Leonid Bloch wrote:
> On 08/08/2018 02:57 PM, Alberto Garcia wrote:
>> On Wed 08 Aug 2018 01:49:08 PM CEST, Leonid Bloch wrote:
>>> On 08/08/2018 02:47 PM, Alberto Garcia wrote:
>>>> On Wed 08 Aug 2018 09:10:50 AM CEST, Leonid Bloch wrote:
>>>>> The default cache-clean-interval is set to 30 seconds, in order to lower
>>>>> the overhead of the qcow2 caches (before the default was 0, i.e.
>>>>> disabled).
>>>>>
>>>>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>>>>
>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>>
>>>>> +#define DEFAULT_CACHE_CLEAN_INTERVAL 30  /* seconds */
>>>>
>>>> I wonder if it shouldn't be a bit higher, though. Isn't 30 seconds too
>>>> low for a default?
>>>
>>> I also had this thought. What would you suggest?
>> 
>> I don't know, 5 minutes at least. It should discard cache entries that
>> haven't been used in a while.
>> 
>> It my opinion the default should be for saving memory in VMs that are
>> mostly idle. If the VM is more or less active I wouldn't want to clean
>> cache entries that are used frequently.
>
> How about 10 minutes?

Sounds good to me.

Berto
