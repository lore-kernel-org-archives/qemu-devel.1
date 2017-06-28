Received: from eggs.gnu.org ([2001:4830:134:3::10]:45001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQFOr-0003mE-Dk
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQFOn-0004FL-IP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:01:05 -0400
References: <20170627163145.GC4792@noname.redhat.com>
	<612358d1-4be0-7118-0e88-d5fce2b19d18@redhat.com>
	<87injgd1lu.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <71f333d8-5954-26a6-59fb-3f34ccf73934@redhat.com>
Date: Wed, 28 Jun 2017 12:00:49 -0400
MIME-Version: 1.0
In-Reply-To: <87injgd1lu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] QMP design: Fixing query-block
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org



On 06/28/2017 03:15 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 06/27/2017 12:31 PM, Kevin Wolf wrote:
>>> Hi,
>>>
>>> I haven't really liked query-block for a long time, but now that
>>> blockdev-add and -blockdev have settled, it might finally be the time to
>>> actually do something about it. In fact, if used together with these
>>> modern interfaces, our query commands are simply broken, so we have to
>>> fix something.
>>>
>>
>> [...words...]
>>
>>>
>>> So how do we go forward from here?
>>>
>>> I guess we could add a few hacks o fix the really urgent things, and
>>> just adding more information is always possible (at the cost of even
>>> more duplication).
>>>
>>
>> I think you've included this suggestion so that you can summarily
>> dismiss it as foolish.
>>
>>> However, it appears to me that I dislike so many thing about our current
>>> query commands that I'm tempted to say: Throw it all away and start
>>> over.
>>>
>>
>> Inclined to agree. The structure of the block layer has changed so much
>> in the past few years and this is easily seen by the gap you've outlined
>> here.
>>
>> We have to keep the old query commands around for a while as Eric says,
>> but I worry that they are so wrong and misleading as to be actively harmful.
>>
>> Maybe there's some hair trigger somewhere that if $NEW_FEATURE_X is used
>> to configure QEMU in some way, that the old commands can be deprecated
>> at runtime, such that we can more aggressively force their retirement.
> 
> We warn on use of deprecated command line and HMP features.  I think we
> want the same for QMP, within QMP.
> 
> [...]
> 

I was thinking of something even stronger than a warning in this case.
Warn if you use it anyway, but if you use $SOME_2.10_FEATURE, it
actually disables it.

"Hi, I know that you have seen the 2.10 API. I'm removing access to this
feature, because you REALLY ought not use it."

Could be as simple as actually disabling the old query command if the
new query command is utilized.

--js
