Received: from eggs.gnu.org ([2001:4830:134:3::10]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTOsy-00054i-3N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTOsv-0002n9-2B
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:45:12 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:6432 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTOsu-0002jC-M6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:45:08 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-5-eblake@redhat.com>
	<c9ed6265-d0d4-49cf-8f0f-c859a1f02171@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <499c217c-01bc-5ad5-cead-12a9ffcb4096@virtuozzo.com>
Date: Fri, 7 Jul 2017 11:44:57 +0300
MIME-Version: 1.0
In-Reply-To: <c9ed6265-d0d4-49cf-8f0f-c859a1f02171@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 04/17] dirty-bitmap: Drop unused
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

07.07.2017 02:43, John Snow wrote:
>
> On 07/03/2017 11:10 AM, Eric Blake wrote:
>> We had several functions that no one is currently using, and which
>> use sector-based interfaces.  I'm trying to convert towards byte-based
>> interfaces, so it's easier to just drop the unused functions:
>>
>> bdrv_dirty_bitmap_get_meta
>> bdrv_dirty_bitmap_get_meta_locked
>> bdrv_dirty_bitmap_reset_meta
>> bdrv_dirty_bitmap_meta_granularity
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
> Admittedly I forget entirely why some of these are here, or to be more
> precise I forget entirely why they are unused as I remember exactly why
> we needed them -- but I forget why we merged them without a caller.
>
> Oh well. If they're unused, they're unused, and can be re-added,
> especially if we're changing the underpinnings.
>
> I bet my last review on this email used nearly identical wordings.
>
> I'm CCing Vladimir so he has a chance to see that we're removing
> functions that he may have wanted to use for his migration series.
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>

Meta bitmaps was first approach of my dirty-bitmap migration 
realization, and their first realization was in early bitmap-migration 
series. However, now my series are based on postcopy approach and meta 
bitmaps are not needed.

Current realization of meta bitmaps was started by Fam, he wanted to use 
them not only for my migration, but also for persistent bitmap 
optimization (to reduce amount of dirt-bitmap data to be saved, to save 
only changed parts).

This is still true: we can try to make persistent bitmaps storing more 
efficient, using meta bitmaps, but I'm not sure that it is worth doing 
and I have no plans on it for now.



-- 
Best regards,
Vladimir
