Received: from eggs.gnu.org ([2001:4830:134:3::10]:54455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edY3z-0008IR-3V
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edY3u-0006Ju-4H
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:06:47 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-14-vsementsov@virtuozzo.com>
	<20171228063330.GL9192@lemon>
	<e7950241-1eee-a415-3e28-9468f1020d1b@virtuozzo.com>
	<17c25946-8cce-21e8-d70f-856fb1924b8c@redhat.com>
	<753ed688-ea9f-4070-b98f-ddbd35f49a32@virtuozzo.com>
	<b2f0c083-d5b3-774b-e931-c7bbe6dc1eac@virtuozzo.com>
	<94f7d424-0a97-6360-1551-3c7df9f7b203@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <184221ee-ee7a-a90e-914f-4aaf6f661b8e@virtuozzo.com>
Date: Mon, 22 Jan 2018 12:06:32 +0300
MIME-Version: 1.0
In-Reply-To: <94f7d424-0a97-6360-1551-3c7df9f7b203@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 13/13] iotests: add dirty bitmap
 postcopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

20.01.2018 03:37, John Snow wrote:
>
> On 01/19/2018 01:08 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 18.01.2018 12:57, Vladimir Sementsov-Ogievskiy wrote:
>>> 17.01.2018 21:30, John Snow wrote:
>>>> On 12/28/2017 06:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Thank you for reviewing my code!
>>>>>
>>>> Time for the re-spin? There's pretty good pressure to get this into 2.12
>>>> and say the non-nbd workflow model is feature complete.
>>> Yes, you are right. Hope to do it today or tomorrow.
>>>
>> I've rebased, applied comments from review, and even one some new fixes,
>> but now I understand that it is too early for re-spin.
>>
>> Now this series depends on
>> 1. [PATCH v2 0/3] fix bitmaps migration through shared storage
>>    - we need to decide, how to fix it. May be, we just do not need
>> bitmaps in inactive state, and should not load them in do_qcow2_open in
>> this case
>>    [I can ignore it, just dropping one test case from new iotest, and fix
>> it later, but..
> I'll look at this next.
>
>> 2. [PATCH v2 0/6] qmp dirty bitmap API
>>   - here autoload is dropped, and migration should be rebased on it.
>>
> For (2) I really want to see a test case showing the utility for enable,
> disable and merge to be added to the API, *or* add an x- prefix to them
> for now.

tests are inevitable, I'll make them)

>
> I want to see some use-case tests that demonstrate how they are to be
> safely used, basically. You might want to expand test 124 for this.
>
> I'm not sure we need this entire series for migration, but I don't want
> to make you re-order absolutely everything. Can we merge patch one by
> itself for the purposes of the migration patchset?

I think yes, will try.

>> so, I'll re-spin migration after these two questions are resolved.
>>
> Thanks for your patience, as always. Please send me pings every day on
> whatever you have to in order to get migration in to 2.12 -- I'm going
> to try to stay focused too, but I've got the attention span of a
> goldfish. If I miss something, please speak up.
>
> --js


-- 
Best regards,
Vladimir
