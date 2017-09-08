Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqIkf-0004oi-Qu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqIkf-0003VL-7b
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:17 -0400
Date: Fri, 8 Sep 2017 14:51:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908125102.GH3283@localhost.localdomain>
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-11-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830210542.2153-11-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/18] dirty-bitmap: Change
 bdrv_get_dirty_count() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
> Thanks to recent cleanups, all callers were scaling a return value
> of sectors into bytes; do the scaling internally instead.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

> diff --git a/block/mirror.c b/block/mirror.c
> index af13f5d658..cc47e21814 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -811,11 +811,10 @@ static void coroutine_fn mirror_run(void *opaque)

There is one more place before this one that needs to be converted,
mirror_iteration() at line 343:

    trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap) *
                              BDRV_SECTOR_SIZE);

Kevin
