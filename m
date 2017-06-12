Received: from eggs.gnu.org ([2001:4830:134:3::10]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKO2b-0002MB-Bh
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKO2X-0004vH-L9
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKO2X-0004ui-Fh
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7068280F95
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 12:01:48 +0000 (UTC)
References: <20170607105810.3003-1-quintela@redhat.com>
	<20170607105810.3003-3-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c2d4cb5b-6223-f6e7-66c2-069826394519@redhat.com>
Date: Mon, 12 Jun 2017 14:01:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170607105810.3003-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 07/06/2017 12:58, Juan Quintela wrote:
> Merge them.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

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
> 
