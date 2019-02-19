Received: from eggs.gnu.org ([209.51.188.92]:54681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw6sI-00046U-1I
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw6sH-0000WY-3e
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:59:57 -0500
References: <20190218233154.19303-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3374bbeb-cc15-acbb-88d8-a057bbfe5482@redhat.com>
Date: Tue, 19 Feb 2019 08:59:47 -0600
MIME-Version: 1.0
In-Reply-To: <20190218233154.19303-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com

On 2/18/19 5:31 PM, John Snow wrote:
> When bitmaps are persistent, they may incur a disk read or write when bitmaps
> are added or removed. For configurations like virtio-dataplane, failing to
> acquire this lock will abort QEMU when disk IO occurs.
> 
> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
> the lock for just the cases that have an IO penalty. Commit 2119882c removed
> these locks, and I failed to notice this when we committed fd5ae4cc, so this
> has been broken since persistent bitmaps were introduced.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
> Reported-By: Aihua Liang <aliang@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
> v5: I'm having a really bad day. This version actually has the semicolon.
> ---
>  blockdev.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

and yes, this time it builds.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
