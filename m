Received: from eggs.gnu.org ([2001:4830:134:3::10]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXGs7-0000Qj-HS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXGs4-00074U-HM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:00:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXGs4-00073f-BP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02D357C82B
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:00:15 +0000 (UTC)
Date: Tue, 18 Jul 2017 09:00:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170718010003.GV27284@pxdev.xzpeter.org>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-4-git-send-email-peterx@redhat.com>
	<20170717175231.GX6020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717175231.GX6020@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 17, 2017 at 02:52:31PM -0300, Eduardo Habkost wrote:
> On Mon, Jul 17, 2017 at 04:26:03PM +0800, Peter Xu wrote:
> > Do the same thing to migration capabilities, just like what we did in
> > previous patch for migration parameters.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index ad2505c..3208162 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2001,6 +2001,9 @@ void migration_global_dump(Monitor *mon)
> >                     ms->send_configuration, ms->send_section_footer);
> >  }
> >  
> > +#define DEFINE_PROP_MIG_CAP(name, x)             \
> > +    DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)
> > +
> 
> Maybe for the future: have you considered replacing the
> enabled_capabilities array with a uint32_t and using
> DEFINE_PROP_BIT?

Yes, this sounds reasonable.  Noted.

> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks!

-- 
Peter Xu
