Received: from eggs.gnu.org ([2001:4830:134:3::10]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVZS-0000Ei-RG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXVZR-0004d0-TA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:18:50 -0500
References: <20180917145732.48590-1-vsementsov@virtuozzo.com>
	<504d170c-56ee-0cf5-78e0-47aded4c132f@virtuozzo.com>
	<43def1dd-732e-a358-d15f-492eefae0a80@redhat.com>
	<c4c5d8ec-eb90-915c-03d3-95c7517b4b57@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <091d787b-c2e8-6296-792f-6223015f0d0e@redhat.com>
Date: Thu, 13 Dec 2018 13:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <c4c5d8ec-eb90-915c-03d3-95c7517b4b57@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ping2 Re: [PATCH v4 0/8] dirty-bitmap: rewrite
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "famz@redhat.com" <famz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 12/13/18 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.12.2018 23:41, John Snow wrote:
>>
>>
>> On 12/12/18 4:27 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> ping. No dependencies, apply to master.
>>>
>>
>> Sure thing.
>>
>> Staged to jsnow/bitmaps.
> 
> 
> Thank you!
> 
> Oops, I've missed your email about s/firt_dirty_off/first_dirty_off
> 
> I can resend, or you can fix in your branch, as you prefer.
> The variable touches two commits in jsnow/bitmaps:
> 

Whoops, I forgot too. I just remember that I was waiting on a requisite
and it got lost so I was in a hurry to stage it for you. I'll just
squash any fixes in.

I'll try to send the PR when the qemu-img bitmap info patch is ready,
alongside my series to drop the x-prefix (and adjust the merge API.)

Anything else urgent for the start of the 4.0 window before we all
disappear on holiday break?

--js

> commit f235204c39dd5ce122666d87f18005264eb56e51
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Mon Sep 17 17:57:27 2018 +0300
> 
>      dirty-bitmap: add bdrv_dirty_bitmap_next_dirty_area
> 
> and the last one:
> 
> commit 7f73174ca1c8a92e4a5139b35f2a2273f59ce29b (jnsnow/bitmaps)
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Mon Sep 17 17:57:32 2018 +0300
> 
>      Revert "hbitmap: Add @advance param to hbitmap_iter_next()"
> 
> 
> 
> 
