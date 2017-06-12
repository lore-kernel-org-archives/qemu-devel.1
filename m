Received: from eggs.gnu.org ([2001:4830:134:3::10]:42739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKNyN-0000VW-GK
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKNyK-0002oM-FN
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dKNyK-0002oE-9f
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:57:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 096D84E02D
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:57:27 +0000 (UTC)
Date: Mon, 12 Jun 2017 12:57:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170612115715.GE3146@work-vm>
References: <20170607105810.3003-1-quintela@redhat.com>
	<20170607105810.3003-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607105810.3003-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ram: Now POSTCOPY_ACTIVE is the
 same that STATUS_ACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Merge them.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index cfa266b..b31a195 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -541,20 +541,8 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>          break;
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_CANCELLING:
> -        info->has_status = true;
> -        info->has_total_time = true;
> -        info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
> -            - s->total_time;
> -        info->has_expected_downtime = true;
> -        info->expected_downtime = s->expected_downtime;
> -        info->has_setup_time = true;
> -        info->setup_time = s->setup_time;
> -
> -        populate_ram_info(info, s);
> -        populate_disk_info(info);
> -        break;
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> -        /* Mostly the same as active; TODO add some postcopy stats */
> +         /* TODO add some postcopy stats */
>          info->has_status = true;
>          info->has_total_time = true;
>          info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
