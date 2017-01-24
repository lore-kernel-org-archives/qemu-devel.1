Received: from eggs.gnu.org ([2001:4830:134:3::10]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVzkB-0003ej-9Y
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVzkA-0005fd-J8
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cVzkA-0005fH-DG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5109A7FE90
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:58:34 +0000 (UTC)
Date: Tue, 24 Jan 2017 11:58:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170124115829.GE20224@work-vm>
References: <1485178976-15225-1-git-send-email-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485178976-15225-1-git-send-email-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Change name of live
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com

* Pankaj Gupta (pagupta@redhat.com) wrote:
> Change the name of live migration thread from 'migration'
> to 'live_migration' to identify it clearly. 'migration'
> is a generic word and kernel also has  tasks for process
> migration with the name 'migration/cpu#'.
> 
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Queued.

Dave

> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index f498ab8..6b58976 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1969,7 +1969,7 @@ void migrate_fd_connect(MigrationState *s)
>      }
>  
>      migrate_compress_threads_create();
> -    qemu_thread_create(&s->thread, "migration", migration_thread, s,
> +    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
>                         QEMU_THREAD_JOINABLE);
>      s->migration_thread_running = true;
>  }
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
