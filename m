Received: from eggs.gnu.org ([2001:4830:134:3::10]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eGntV-0005zA-Dc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eGntP-0000uY-NX
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:21:57 -0500
References: <20171120145006.551-1-kwolf@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <daa12314-459e-fcbc-72de-4a8770d7461c@openvz.org>
Date: Mon, 20 Nov 2017 18:21:43 +0300
MIME-Version: 1.0
In-Reply-To: <20171120145006.551-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org

On 11/20/2017 05:50 PM, Kevin Wolf wrote:
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
Reviewed-by: Denis V. Lunev <den@openvz.org>
