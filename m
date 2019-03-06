Received: from eggs.gnu.org ([209.51.188.92]:55009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YIz-00052B-0D
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YIx-00063a-1w
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:18:00 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-4-jsnow@redhat.com>
	<353c0119-bd27-a833-fdd0-a207ac824fcb@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8ed30b12-1a60-69fc-3544-4192f0268856@redhat.com>
Date: Wed, 6 Mar 2019 10:17:41 -0500
MIME-Version: 1.0
In-Reply-To: <353c0119-bd27-a833-fdd0-a207ac824fcb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 3/6/19 8:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.03.2019 22:15, John Snow wrote:
>> Instead of checking against busy, inconsistent, or read only directly,
>> use a check function with permissions bits that let us streamline the
>> checks without reproducing them in many places.
>>
>> Included in this patch are permissions changes that simply add the
>> inconsistent check to existing permissions call spots, without
>> addressing existing bugs.
>>
>> In general, this means that busy+readonly checks become BDRV_BITMAP_DEFAULT,
>> which checks against all three conditions. busy-only checks become
>> BDRV_BITMAP_ALLOW_RO.
> 
> so, it's a conversion + check on inconsistance. backup/disable/enable correctness
> postponed.
> 
> you've left bdrv_dirty_bitmap_create_successor as is..
> 

... That's an oversight! Will fix.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
