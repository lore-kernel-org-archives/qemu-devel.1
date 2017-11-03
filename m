Received: from eggs.gnu.org ([2001:4830:134:3::10]:59768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eAbwR-0005ls-KH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eAbwO-0004HW-FB
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eAbwO-0004HK-8I
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:23:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EC505275A
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 13:23:19 +0000 (UTC)
Date: Fri, 3 Nov 2017 13:23:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171103132314.GD2616@work-vm>
References: <20171030112112.6952-1-quintela@redhat.com>
	<20171030112112.6952-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030112112.6952-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] migration: print features as on off
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
> Once there, do one thing for line
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 4de3b551fe..706d2407ec 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2375,10 +2375,15 @@ void migration_global_dump(Monitor *mon)
>  {
>      MigrationState *ms = migrate_get_current();
>  
> -    monitor_printf(mon, "globals: store-global-state=%d, only_migratable=%d, "
> -                   "send-configuration=%d, send-section-footer=%d\n",
> -                   ms->store_global_state, ms->only_migratable,
> -                   ms->send_configuration, ms->send_section_footer);
> +    monitor_printf(mon, "globals:\n");
> +    monitor_printf(mon, "store-global-state: %s\n",
> +                   ms->store_global_state ? "on" : "off");
> +    monitor_printf(mon, "only-migratable: %s\n",
> +                   ms->only_migratable ? "on" : "off");
> +    monitor_printf(mon, "send-configuration: %s\n",
> +                   ms->send_configuration ? "on" : "off");
> +    monitor_printf(mon, "send-section-footer: %s\n",
> +                   ms->send_section_footer ? "on" : "off");
>  }
>  
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
