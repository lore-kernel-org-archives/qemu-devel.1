Received: from eggs.gnu.org ([2001:4830:134:3::10]:45395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTmqc-0007ZB-8F
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTmqb-0000Ws-Ag
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:24:54 -0400
Date: Fri, 15 Jun 2018 12:24:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615112436.GC13796@work-vm>
References: <20180530112424.204835-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530112424.204835-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: fix
 dirty_bitmap_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-stable@nongnu.org, eblake@redhat.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> dirty_bitmap_load_header return code is obtained but not handled. Fix
> this.
> 
> Bug was introduced in b35ebdf076d697bc
> "migration: add postcopy migration of dirty bitmaps" with the whole
> function.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Queued via migration

> ---
>  migration/block-dirty-bitmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 8819aabe3a..2c541c985d 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -672,6 +672,9 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>  
>      do {
>          ret = dirty_bitmap_load_header(f, &s);
> +        if (ret < 0) {
> +            return ret;
> +        }
>  
>          if (s.flags & DIRTY_BITMAP_MIG_FLAG_START) {
>              ret = dirty_bitmap_load_start(f, &s);
> -- 
> 2.11.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
