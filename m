Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcqh2-0001Rg-MA
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcqgx-0004w6-OA
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:20:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcqgx-0004vx-Ia
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:20:23 -0400
Date: Tue, 10 Jul 2018 12:20:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180710112019.GG2656@work-vm>
References: <20180710091902.28780-1-peterx@redhat.com>
	<20180710091902.28780-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710091902.28780-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 04/10] migration: show
 pause/recover state on dst host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Balamuruhan S <bala24@linux.vnet.ibm.com>

* Peter Xu (peterx@redhat.com) wrote:
> These two states will be missing when doing "query-migrate" on
> destination VM.  Add these states so that we can get the query results
> as expected.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0404c53215..8d56d56930 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -911,6 +911,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
