Received: from eggs.gnu.org ([2001:4830:134:3::10]:37839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMyxG-0002ce-Rz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMyx5-0006w9-J7
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dMyx5-0006th-CO
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:50:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28C9080C26
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:50:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497876588-947-12-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 19 Jun 2017 20:49:46 +0800")
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-12-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 19 Jun 2017 17:50:50 +0200
Message-ID: <87shiw9dt1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 11/13] migration: move only_migratable
 to MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> One less global variable, and it does only matter with migration.
>
> We keep the old "--only-migratable" option, but also now we support:
>
>   -global migration.only-migratable=true
>
> Currently still keep the old interface.
>
> Hmm, now vl.c has no way to access migrate_get_current(). Export a
> function for it to setup only_migratable.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

If you have to respin

+void migration_only_migratable_set(bool only_migratable);
+

only is used with "true".  I think that it is easier without parameter.

But it is just a question of taste, so, as you are the one doing the
code ....

Later, Juan.
