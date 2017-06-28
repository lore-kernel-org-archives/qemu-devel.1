Received: from eggs.gnu.org ([2001:4830:134:3::10]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQGWM-0006Dh-4w
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQGWH-00015k-6X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:12:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQGWG-00014y-U4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:12:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04ECD81127
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 17:12:48 +0000 (UTC)
Date: Wed, 28 Jun 2017 14:12:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170628171244.GA5167@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-11-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498536619-14548-11-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/10] migration: hmp: dump globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 27, 2017 at 12:10:19PM +0800, Peter Xu wrote:
> Now we have some globals that can be configured for migration. Dump them
> in HMP info migration for better debugging.
> 
> (we can also use this to monitor whether COMPAT fields are applied
> correctly on compatible machines)
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
[...]
> +void migration_global_dump(Monitor *mon)
> +{
> +    MigrationState *ms = migrate_get_current();
> +
> +    monitor_printf(mon, "globals: store-global-state=%d, only_migratable=%d, "
> +                   "send-configuration=%d, send-section-footer=%d\n",
> +                   ms->store_global_state, ms->only_migratable,
> +                   ms->send_configuration, ms->send_section_footer);

I wouldn't call them "globals", I would just call them "properties" (or
maybe just "settings").  They happen to be affected by global properties
if the accel/machine/user sets them, but they are just plain old QOM
properties.


> +}
> +
>  static Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),
> -- 
> 2.7.4
> 

-- 
Eduardo
