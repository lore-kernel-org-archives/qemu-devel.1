Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwQNA-00031u-3r
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwQN6-00064M-7i
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwQN6-000644-1Z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:40:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B553C0827DF
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 09:39:59 +0000 (UTC)
Date: Fri, 7 Apr 2017 10:39:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407093955.GC2138@work-vm>
References: <20170406130913.2232-1-quintela@redhat.com>
	<20170406130913.2232-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406130913.2232-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/54] ram: Change byte_xfer_now type to
 uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

OK, subject is a bit misleading since it also does _prev,
but yes:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index aeef563..d13674f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -158,7 +158,7 @@ struct RAMState {
>      /* last time we did a full bitmap_sync */
>      int64_t time_last_bitmap_sync;
>      /* bytes transferred at start_time */
> -    int64_t bytes_xfer_prev;
> +    uint64_t bytes_xfer_prev;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -660,7 +660,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      RAMBlock *block;
>      MigrationState *s = migrate_get_current();
>      int64_t end_time;
> -    int64_t bytes_xfer_now;
> +    uint64_t bytes_xfer_now;
>  
>      rs->bitmap_sync_count++;
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
