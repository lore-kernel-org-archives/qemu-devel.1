Received: from eggs.gnu.org ([2001:4830:134:3::10]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evoP1-0008Ve-8s
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evoP0-0006oz-D0
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:11:59 -0400
Date: Tue, 13 Mar 2018 18:11:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180313181144.GL3545@work-vm>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
	<20180313180320.339796-11-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313180320.339796-11-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 10/13] migration: allow qmp command
 migrate-start-postcopy for any postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> Allow migrate-start-postcopy for any postcopy type
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 094196c236..59b4fe6090 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1022,7 +1022,7 @@ void qmp_migrate_start_postcopy(Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    if (!migrate_postcopy_ram()) {
> +    if (!migrate_postcopy()) {
>          error_setg(errp, "Enable postcopy with migrate_set_capability before"
>                           " the start of migration");
>          return;
> -- 
> 2.11.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
