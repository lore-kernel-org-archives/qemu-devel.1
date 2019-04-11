Received: from eggs.gnu.org ([209.51.188.92]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hEOZU-00042o-Qc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hEOZT-0008GU-UH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:32:08 -0400
References: <20190409210655.777-1-jsnow@redhat.com>
	<87y34i2zbt.fsf@dusky.pond.sub.org>
	<3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
	<e050a83f-4603-db8d-c869-53593027bf01@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d36b8962-ed7d-f315-479b-d7de78d906e6@redhat.com>
Date: Wed, 10 Apr 2019 21:32:01 -0400
MIME-Version: 1.0
In-Reply-To: <e050a83f-4603-db8d-c869-53593027bf01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 4/10/19 2:22 PM, Eric Blake wrote:
> On 4/10/19 12:37 PM, John Snow wrote:
>>
>>
>> On 4/10/19 1:39 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> It turns out that having options listed in three places continues to be
>>>> a bad idea. I'm still toying with the idea of an improved infrastructure
>>>> here, but in the meantime, another bandaid.
>>>>
> 
>>>
>>> Nice to have in 4.0.
>>>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>
>>
>> If it can go in for 4.0, who stages it? Kevin?
> 
> At this point, we've missed -rc3; the fix on its own is not a
> release-blocker, but if something else comes up that requires -rc4 for
> an actual release blocker, we can sort out someone sending a pull
> request for this one at the same time. (I'm aware of a couple of iotest
> fixups in the same boat... Guess it's time to start updating the wiki to
> point to email threads where we document 'wish list' patches)
> 

OK. I also have... a pretty major bitmaps documentation rewrite which I
probably won't have ready in time for a theoretical rc4 either, so I
guess I'll need to include it for 4.0.1.

I didn't realize how badly out of date the bitmaps.rst file had gotten.
I'll keep hammering away at it.

--js
