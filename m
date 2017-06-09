Received: from eggs.gnu.org ([2001:4830:134:3::10]:54533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJFTW-0000k6-81
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJFTT-0003rn-0P
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJFTS-0003rU-Ki
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:40:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5118C04B316
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 08:40:53 +0000 (UTC)
Date: Fri, 9 Jun 2017 16:40:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170609084048.GO3628@pxdev.xzpeter.org>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<87tw3p8uun.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tw3p8uun.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jun 09, 2017 at 09:48:32AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > v2
> > - (I didn't add Juan's r-b since I touched the patches)
> > - remove once parameter in migrate_get_current() since not needed
> > - add one more patch to export register_compat_prop(), then use it in
> >   the following patches in xen_init().
> >
> > I picked this topic out as suggested by Juan. Also I did what Juan has
> > suggested in previous discussions that I moved lots of global
> > parameters into MigrationState, and let them be properties. Then we
> > can use HW_COMPAT_* and "-global migration.xxx=xxx" formular.
> >
> > Currently register_compat_prop() is exported to be used by xen_init().
> >
> > If this can be merged and okay, we can move on to convert more things
> > into properties for migration.
> >
> > Please review. Thanks.
> 
> Hi
> 
> Nice work, thanks.
> 
> One question, once this is accepted, it would be easy to add to this the
> migration_capabilities and migration_paramenters, right?

Yes. If this series would be merged, I'll work on them soon. Thanks,

-- 
Peter Xu
