Received: from eggs.gnu.org ([2001:4830:134:3::10]:48789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dRzb9-00072h-TM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dRzb6-0008AP-Oo
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:32:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dRzb6-0008A1-J6
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0ADD83F44
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 11:32:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1499049848-18012-2-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 3 Jul 2017 10:44:05 +0800")
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-2-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Jul 2017 13:32:51 +0200
Message-ID: <87y3s54uxo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: fix handling for
 --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> MigrateState object is not ready at that time, so we'll get an
> assertion. Use qemu_global_option() instead.
>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Fixes: 3df663e ("migration: move only_migratable to MigrationState")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

>  bool migration_in_postcopy_after_devices(MigrationState *);
> -void migration_only_migratable_set(void);
>  void migration_global_dump(Monitor *mon);

Nice, one less exported function.

> -                migration_only_migratable_set();
> +                qemu_global_option("migration.only-migratable=true");
>                  break;
>              case QEMU_OPTION_nodefaults:
>                  has_defaults = 0;

aha, that is a much, much nicer way to set functions.

Later, Juan.
