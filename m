Received: from eggs.gnu.org ([2001:4830:134:3::10]:44401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cu1nu-0007WG-8U
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cu1nr-0002OI-6Q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:01:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cu1nr-0002No-0i
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:01:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2A422E605A
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 19:01:41 +0000 (UTC)
Date: Fri, 31 Mar 2017 20:01:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331190136.GG2408@work-vm>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
	<1490599288-11751-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490599288-11751-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] hmp: info migrate_capability format
 tunes
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
> Dump the info in a single line is hard to read. Do it one per line.
> Also, the first "capabilities:" didn't help much. Let's remove it.
> 
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

agreed, although you may find it breaks some peoples scripts, but
we're allowed to do that in HMP and it should be more readable, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index edb8970..95eef8c 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -265,13 +265,11 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>      caps = qmp_query_migrate_capabilities(NULL);
>  
>      if (caps) {
> -        monitor_printf(mon, "capabilities: ");
>          for (cap = caps; cap; cap = cap->next) {
> -            monitor_printf(mon, "%s: %s ",
> +            monitor_printf(mon, "%s: %s\n",
>                             MigrationCapability_lookup[cap->value->capability],
>                             cap->value->state ? "on" : "off");
>          }
> -        monitor_printf(mon, "\n");
>      }
>  
>      qapi_free_MigrationCapabilityStatusList(caps);
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
