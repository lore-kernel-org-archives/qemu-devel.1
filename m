Received: from eggs.gnu.org ([2001:4830:134:3::10]:59084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSJmI-0002fd-9q
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSJmE-0006Hs-NV
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 04:38:06 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-5-vsementsov@virtuozzo.com>
	<c4c884df-d07a-295b-1f30-aea9e1fe82c1@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <67f12ba5-dce8-5cd9-9ccf-f090e2325a01@virtuozzo.com>
Date: Fri, 22 Dec 2017 12:37:54 +0300
MIME-Version: 1.0
In-Reply-To: <c4c884df-d07a-295b-1f30-aea9e1fe82c1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 04/13] dirty-bitmap: add locked state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

22.12.2017 05:03, John Snow wrote:
>
> On 12/20/2017 10:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add special state, when qmp operations on the bitmap are disabled.
>> It is needed during bitmap migration. "Frozen" state is not
>> appropriate here, because it looks like bitmap is unchanged.
>>
> As of right now this breaks test 124, do you want me to review the rest
> anyway?
>
> --js
>
> (As a warning, most of the US goes on holiday today, but I will try to
> check my mail for just this one series as I'd really like it get it
> through. I will be back to normal duties 9th January.)

Yes, there is a tiny mistake (which shows that I didn't run iotests, but 
now it's done), the rest should be reviewed.
(But I think, it is better have a rest on holidays :)

-- 
Best regards,
Vladimir
