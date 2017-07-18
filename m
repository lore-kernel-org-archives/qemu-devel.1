Received: from eggs.gnu.org ([2001:4830:134:3::10]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXHOw-0008EI-RO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXHOt-0001Vt-M0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXHOt-0001Ug-Fi
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BBCA61D0F
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:34:09 +0000 (UTC)
Date: Tue, 18 Jul 2017 09:34:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170718013403.GZ27284@pxdev.xzpeter.org>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-4-git-send-email-peterx@redhat.com>
	<878tjn0zln.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tjn0zln.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v2 03/11] migration: export capabilities to
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 17, 2017 at 06:58:44PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Do the same thing to migration capabilities, just like what we did in
> > previous patch for migration parameters.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks!

> 
> 
> A pitty that the preprocessor is not able to pass to uppercase ...
> 
> > +#define DEFINE_PROP_MIG_CAP(name, x)             \
> > +    DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)
> 
> #define DEFINE_PROP_MIG_CAP(name)             \
>     DEFINE_PROP_BOOL(#name, MigrationState,
>     enabled_capabilities[MIGRATION_CAPABILITY_##name], false)

Yes a pity, this is more beautiful (though this may let the grepping
of specific MIGRATION_CAPABILITY_* slightly harder since it breaks the
macro).

-- 
Peter Xu
