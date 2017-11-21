Received: from eggs.gnu.org ([2001:4830:134:3::10]:32920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eGwZH-000742-EO
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eGwZG-00083P-I2
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:37:39 -0500
References: <20171120145006.551-1-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <110d5277-9e7d-eab9-f40a-bc91797c4c1d@redhat.com>
Date: Mon, 20 Nov 2017 19:37:30 -0500
MIME-Version: 1.0
In-Reply-To: <20171120145006.551-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/3] block: Error out on load_vm
 with active dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org



On 11/20/2017 09:50 AM, Kevin Wolf wrote:
> Following the discussing at
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03572.html
> this implements the error return for loading a snapshot while dirty
> bitmaps are active.
> 
> Kevin Wolf (3):
>   block: Add errp to bdrv_snapshot_goto()
>   block: Add errp to bdrv_all_goto_snapshot()
>   block: Error out on load_vm with active dirty bitmaps
> 
>  include/block/snapshot.h |  6 ++++--
>  block/snapshot.c         | 43 +++++++++++++++++++++++--------------------
>  migration/savevm.c       |  6 +++---
>  qemu-img.c               |  6 +++---
>  4 files changed, 33 insertions(+), 28 deletions(-)
> 

You have enough reviews, but just so it's unambiguous, I'm fine with
this approach in lieu of Vladimir's; so:

Reviewed-by: John Snow <jsnow@redhat.com>
