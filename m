Received: from eggs.gnu.org ([2001:4830:134:3::10]:34646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSIxj-0005GA-Sa
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSIxe-0003mk-UJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSIxe-0003mD-Nw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:13:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C19EA8125F
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 08:13:29 +0000 (UTC)
Date: Tue, 4 Jul 2017 16:13:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170704081327.GA19896@pxdev.xzpeter.org>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-5-git-send-email-peterx@redhat.com>
	<878tk4sk5q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tk4sk5q.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 4/4] doc: update TYPE_MIGRATION documents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Jul 04, 2017 at 10:04:01AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > [Peter collected Eduardo's patch comment and formatted into patch]
> >
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index dbdc121..6c64b99 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2052,12 +2052,15 @@ static void migration_instance_init(Object *obj)
> >  static const TypeInfo migration_type = {
> >      .name = TYPE_MIGRATION,
> >      /*
> > -     * NOTE: "migration" itself is not really a device. We used
> > -     * TYPE_DEVICE here only to leverage some existing QDev features
> > -     * like "-global" properties, and HW_COMPAT_* fields (which are
> > -     * finally applied as global properties as well). If one day the
> > -     * global property feature can be migrated from QDev to QObject in
> > -     * general, then we can switch to QObject as well.
> > +     * NOTE:
> > +     *
> > +     * TYPE_MIGRATION is not really a device, as the object is not
> > +     * created using qdev_create(), it is not attached to the qdev
> > +     * device tree, and it is never realized.
> > +     *
> > +     * If one day we allow non-device QOM objects to use the global
> > +     * property system, we can switch this from TYPE_DEVICE to
> > +     * TYPE_OBJECT.
> 
> Suggest to turn this paragraph into a TODO:
> 
>         * TODO Make this TYPE_OBJECT once QOM provides something like
>         * TYPE_DEVICE's "-global" properties.

Sure. Will modify in next version. Thanks,

-- 
Peter Xu
