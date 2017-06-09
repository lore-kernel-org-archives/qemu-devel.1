Received: from eggs.gnu.org ([2001:4830:134:3::10]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEeu-0001KR-44
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEer-0000Wh-1m
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dJEeq-0000W2-Rk
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4B52C049D5C
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 07:48:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 9 Jun 2017 11:48:56 +0800")
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 09 Jun 2017 09:48:32 +0200
Message-ID: <87tw3p8uun.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/6] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> v2
> - (I didn't add Juan's r-b since I touched the patches)
> - remove once parameter in migrate_get_current() since not needed
> - add one more patch to export register_compat_prop(), then use it in
>   the following patches in xen_init().
>
> I picked this topic out as suggested by Juan. Also I did what Juan has
> suggested in previous discussions that I moved lots of global
> parameters into MigrationState, and let them be properties. Then we
> can use HW_COMPAT_* and "-global migration.xxx=xxx" formular.
>
> Currently register_compat_prop() is exported to be used by xen_init().
>
> If this can be merged and okay, we can move on to convert more things
> into properties for migration.
>
> Please review. Thanks.

Hi

Nice work, thanks.

One question, once this is accepted, it would be easy to add to this the
migration_capabilities and migration_paramenters, right?

Later, Juan.
