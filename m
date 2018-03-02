Received: from eggs.gnu.org ([2001:4830:134:3::10]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eriHM-00058L-8X
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eriHI-0004xv-UI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:51:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eriHI-0004xO-PB
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:51:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C6F78D6EF
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 10:51:04 +0000 (UTC)
Date: Fri, 2 Mar 2018 10:51:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180302105101.GC26972@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-6-peterx@redhat.com>
	<20180301104717.GB14643@redhat.com> <20180302035852.GX27381@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302035852.GX27381@xz-mi>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/15] qio: refactor net listener source
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Mar 02, 2018 at 11:58:52AM +0800, Peter Xu wrote:
> On Thu, Mar 01, 2018 at 10:47:17AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Mar 01, 2018 at 04:44:28PM +0800, Peter Xu wrote:
> > > Three functions are abstracted from the old code:
> > >=20
> > > - qio_net_listener_source_add(): create one source for listener
> > > - qio_net_listener_sources_clear(): unset existing net lister sourc=
es
> > > - qio_net_listener_sources_update(): setup all sources for listener
> > >=20
> > > Use them where possible.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  io/net-listener.c | 82 +++++++++++++++++++++++++++----------------=
------------
> > >  1 file changed, 41 insertions(+), 41 deletions(-)
> >=20
> > This patch can be dropped since nothing else in the series now
> > depends on it.
>=20
> Do you think it's still acceptable even as a cleanup?  Thanks,

I don't think it really adds value over what's there already.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
