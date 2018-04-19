Received: from eggs.gnu.org ([2001:4830:134:3::10]:47155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gvh-0002aQ-39
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gvg-0001Pz-0h
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:17:21 -0400
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
	<20180416114414.18406-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6b81372f-7d02-12d9-abaf-1bc2e4c6fbdf@redhat.com>
Date: Thu, 19 Apr 2018 17:17:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180416114414.18406-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/dirty-bitmap: add lock to
 bdrv_enable/disable_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org



On 04/16/2018 07:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> Functions write to BdrvDirtyBitmap field, so the should take the lock.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Looks like this won't introduce any recursive locking that I can spot,
so this looks correct.

Reviewed-by: John Snow <jsnow@redhat.com>
