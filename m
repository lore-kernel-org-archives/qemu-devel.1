Received: from eggs.gnu.org ([2001:4830:134:3::10]:52672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQxt-0006M9-Dp
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQxr-0005F6-5L
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:42:49 -0500
Date: Thu, 28 Dec 2017 13:42:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228054210.GF9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-8-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-8-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 07/13] migration: include
 migrate_dirty_bitmaps in migrate_postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Enable postcopy if dirty bitmap migration is enabled.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 1526cd4bff..e973837bfd 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1487,7 +1487,7 @@ bool migrate_postcopy_ram(void)
>  
>  bool migrate_postcopy(void)
>  {
> -    return migrate_postcopy_ram();
> +    return migrate_postcopy_ram() || migrate_dirty_bitmaps();
>  }
>  
>  bool migrate_auto_converge(void)
> -- 
> 2.11.1
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
