Received: from eggs.gnu.org ([2001:4830:134:3::10]:38095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dNVzZ-0002zB-Bo
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dNVzU-0002BD-9p
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:07:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dNVzU-0002B9-3c
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:07:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F9994E4CA
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 03:07:34 +0000 (UTC)
Date: Wed, 21 Jun 2017 11:07:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170621030728.GD3662@pxdev.xzpeter.org>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-12-git-send-email-peterx@redhat.com>
	<87shiw9dt1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87shiw9dt1.fsf@secure.mitica>
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
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 19, 2017 at 05:50:50PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > One less global variable, and it does only matter with migration.
> >
> > We keep the old "--only-migratable" option, but also now we support:
> >
> >   -global migration.only-migratable=true
> >
> > Currently still keep the old interface.
> >
> > Hmm, now vl.c has no way to access migrate_get_current(). Export a
> > function for it to setup only_migratable.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> If you have to respin

So there will be. :-)

> 
> +void migration_only_migratable_set(bool only_migratable);
> +
> 
> only is used with "true".  I think that it is easier without parameter.
> 
> But it is just a question of taste, so, as you are the one doing the
> code ....

Sure.  Thanks,

-- 
Peter Xu
