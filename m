Received: from eggs.gnu.org ([2001:4830:134:3::10]:57394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYrwQ-0008Mt-Rx
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYrwQ-0007gy-1H
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:15:06 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:30669 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYrwP-0007gU-MP
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:15:05 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-25-vsementsov@virtuozzo.com>
	<d7e217d7-2080-ebaa-3d66-f97a64770a31@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a8645a9c-e613-6e30-e6c5-26c471847a74@virtuozzo.com>
Date: Wed, 1 Feb 2017 13:14:49 +0300
MIME-Version: 1.0
In-Reply-To: <d7e217d7-2080-ebaa-3d66-f97a64770a31@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/24] qcow2-bitmap: cache bitmap list in
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

01.02.2017 02:27, Max Reitz wrote:
> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>> Do not reload bitmap list every time it is needed.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2-bitmap.c | 125 ++++++++++++++++++++++++++++++++++-----------------
>>   block/qcow2.c        |   2 +
>>   block/qcow2.h        |   4 ++
>>   3 files changed, 89 insertions(+), 42 deletions(-)
> Hm, difficult. On a glance, this patch seems alright, and it probably
> makes sense. Maybe it would make the code actually a bit easier to
> understand if it was squashed into the other patches. But OTOH it would
> mean that I would have to start review from scratch for those patches...
>
> So in my opinion this patch makes sense and you should keep it updated,
> but I think we should keep it separate from the rest of the series. Get
> the first 23 patches in first and then we can merge this on top later on.
>
> Would that be OK?

Yes, that's OK.

>
> Max
>


-- 
Best regards,
Vladimir
