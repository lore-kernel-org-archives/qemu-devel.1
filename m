Received: from eggs.gnu.org ([2001:4830:134:3::10]:50840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi0BF-0005QR-DZ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi0BC-0000FL-4R
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:28:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi0BB-0000Ef-VV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:28:54 -0400
Date: Tue, 24 Jul 2018 17:28:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180724162849.GF48553@work-vm>
References: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
	<1532434585-14732-2-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532434585-14732-2-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: fix duplicate
 initialization for expected_downtime and cleanup_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> migrate_fd_connect duplicate initialize expected_downtime and cleanup_bh.

Queued (just 2/2)

> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/migration.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ff05422..b8c4fec 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3032,8 +3032,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      } else {
>          /* This is a fresh new migration */
>          rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
> -        s->expected_downtime = s->parameters.downtime_limit;
> -        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
>  
>          /* Notify before starting migration thread */
>          notifier_list_notify(&migration_state_notifiers, s);
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
