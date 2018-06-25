Received: from eggs.gnu.org ([2001:4830:134:3::10]:49059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXZJk-0001iQ-3F
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXZJj-0007k4-0S
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:46:36 -0400
References: <20180625165745.25259-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <17d590b3-47b1-e9d8-f8f1-0c6dd2b91833@redhat.com>
Date: Mon, 25 Jun 2018 17:46:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180625165745.25259-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] dirty bitmap fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 06/25/2018 12:57 PM, Vladimir Sementsov-Ogievskiy wrote:
> Vladimir Sementsov-Ogievskiy (2):
>   block/dirty-bitmap: add bdrv_enable_dirty_bitmap_locked
>   dirty-bitmap: fix double lock on bitmap enabling
> 
>  include/block/dirty-bitmap.h   |  1 +
>  block/dirty-bitmap.c           | 12 +++++++++---
>  migration/block-dirty-bitmap.c |  4 ++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 

Thanks, applied to my bitmaps tree:

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
