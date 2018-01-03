Received: from eggs.gnu.org ([2001:4830:134:3::10]:45382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWeqC-0002Vf-Ko
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWeq9-00088Z-69
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:56:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWeq9-00087x-0K
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:56:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 120BB624DA
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 08:56:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-4-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 13:40:35 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-4-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 09:55:54 +0100
Message-ID: <871sj748yt.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/11] migration: remove "enable_colo" var
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> It's only used once, clean it up a bit.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

See my previous comment on patch 1.  We can remove the variable, but the
move to ose assert is wrong IMHO.

Later, Juan.


> ---
>  migration/migration.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index edbda43246..20f7565527 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2177,7 +2177,6 @@ static void *migration_thread(void *opaque)
>      bool entered_postcopy = false;
>      /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
>      enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
> -    bool enable_colo = migrate_colo_enabled();
>  
>      rcu_register_thread();
>  
> @@ -2305,7 +2304,7 @@ static void *migration_thread(void *opaque)
>          runstate_set(RUN_STATE_POSTMIGRATE);
>      } else {
>          if (s->state == MIGRATION_STATUS_ACTIVE) {
> -            assert(enable_colo);
> +            assert(migrate_colo_enabled());
>              migrate_start_colo_process(s);
>              /*
>              * Fixme: we will run VM in COLO no matter its old running state.
