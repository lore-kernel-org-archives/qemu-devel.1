Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e2L1q-0004px-Kb
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e2L1p-0005fG-KI
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:42:46 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-2-eblake@redhat.com>
	<20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
	<67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
	<46e7ca23-fb38-7620-90fb-04982e5b9ad0@redhat.com>
	<06af49fb-6e94-d8c0-3701-7579e55c92a5@redhat.com>
	<20171011084214.GB4593@dhcp-200-186.str.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <de191a4c-342a-bf26-277b-2744951dcf29@redhat.com>
Date: Wed, 11 Oct 2017 13:42:31 -0400
MIME-Version: 1.0
In-Reply-To: <20171011084214.GB4593@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/23] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/11/2017 04:42 AM, Kevin Wolf wrote:
> Am 10.10.2017 um 21:24 hat John Snow geschrieben:
>>
>>
>> On 10/10/2017 03:00 PM, Eric Blake wrote:
>>> On 10/10/2017 09:43 AM, Eric Blake wrote:
>>>
>>>>>> ---
>>>>>> v5: use second label for cleaner exit logic [John], use local_pnum
>>>>
>>>>>> @@ -1811,16 +1811,19 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>>>>>>      int64_t total_sectors;
>>>>>>      int64_t n;
>>>>>>      int64_t ret, ret2;
>>>>>> +    BlockDriverState *local_file = NULL;
>>>>>> +    int local_pnum = 0;
>>>>>
>>>>> I don't quite see what the point of local_pnum is if we assert anyway
>>>>> that the real pnum is non-NULL.
>>>>
>>>> I did it in parallel with fallout from John's review on v4:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06958.html
>>>>
>>>> but since it wasn't specifically asked for, and is now getting
>>>> questions, I'm fine with not having it in v6.
>>>
>>> Okay, I re-read v4, and here's the comment (on 21/23) that led to my
>>> experiment in v5 patch 1 with local_pnum:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00293.html
>>>
>>> and I did argue:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00311.html
>>
>> Well, Kevin's the boss :D
> 
> I'm not sure how renaming *pnum into local_pnum addresses your concerns?
> We still update local_pnum before we undo our alignment corrections. Or
> are you talking about some other part of these mails?
> 
> Kevin
> 

I made only a stylistic comment and it looked to me at a glance like it
had resulted in conflicting feedback from you (since I all but asked for
a local pnum) -- but my feedback was only minor stylistic stuff, so I'm
deferring to you.

--js
