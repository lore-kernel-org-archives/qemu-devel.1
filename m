Received: from eggs.gnu.org ([2001:4830:134:3::10]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0s0p-00016M-Oe
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0s0o-0005Fv-TX
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:36:11 -0400
References: <20180914151515.21242-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ffc45199-3e98-1560-08d9-2f1f187b8bb9@redhat.com>
Date: Fri, 14 Sep 2018 13:36:00 -0400
MIME-Version: 1.0
In-Reply-To: <20180914151515.21242-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] transaction support for bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 09/14/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is a last brick, necessary to play with nbd bitmap export in
> conjunction with image fleecing.
> 
> v3:
> 01: fix type in commit message, add John's r-b
> 02: splitted refactoring
> 03: improve commit message, split some refactoring to 02
> 04: add John's r-b
> 05: drop extra state variable, make it local instead. John's r-b.
> 
> 
> v2: don't compare with v1, it is changed a lot, to do the whole thing
>     in .prepare instead of .commit. It is needed to be compatible with
>     backup block job transaction actions [John]
> 
> Vladimir Sementsov-Ogievskiy (5):
>   dirty-bitmap: switch assert-fails to errors in bdrv_merge_dirty_bitmap
>   dirty-bitmap: rename bdrv_undo_clear_dirty_bitmap
>   dirty-bitmap: make it possible to restore bitmap after merge
>   blockdev: rename block-dirty-bitmap-clear transaction handlers
>   qapi: add transaction support for x-block-dirty-bitmap-merge
> 
>  qapi/transaction.json        |  2 ++
>  include/block/block_int.h    |  2 +-
>  include/block/dirty-bitmap.h |  2 +-
>  include/qemu/hbitmap.h       | 25 +++++++++------
>  block/dirty-bitmap.c         | 36 +++++++++++++++++-----
>  blockdev.c                   | 59 +++++++++++++++++++++++++-----------
>  util/hbitmap.c               | 11 +++++--
>  7 files changed, 99 insertions(+), 38 deletions(-)
> 

Thanks, applied to my bitmaps tree:

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
