Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cu1dB-0002EE-2p
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cu1d7-0005A9-TT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cu1d7-00059w-NH
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:50:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B00B83F3E
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 18:50:36 +0000 (UTC)
Date: Fri, 31 Mar 2017 19:50:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331185030.GE2408@work-vm>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
	<1490599288-11751-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490599288-11751-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] migration: set current_active_state
 once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> We set it right above this one. No need to set it twice.

Ah good spot, yes set in the declaration of current_active_state.

> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 54060f7..f9f4d98 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1938,7 +1938,6 @@ static void *migration_thread(void *opaque)
>      qemu_savevm_state_begin(s->to_dst_file, &s->params);
>  
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> -    current_active_state = MIGRATION_STATUS_ACTIVE;
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                        MIGRATION_STATUS_ACTIVE);


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
