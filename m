Received: from eggs.gnu.org ([209.51.188.92]:55576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1wCx-00053R-OG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1wCw-0002yI-Pf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:49:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1wCw-0002xp-JA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:49:22 -0500
Date: Thu, 7 Mar 2019 16:49:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307164911.GI32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307110441-mutt-send-email-mst@kernel.org>
	<20190307161944.GH32268@redhat.com>
	<20190307113538-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307113538-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

On Thu, Mar 07, 2019 at 11:46:19AM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 04:19:44PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Mar 07, 2019 at 11:05:36AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > > > The broadening of vhost-user support is useful with that in much =
the
> > > > same way I imagine.
> > >=20
> > > vhost user has more of an impact but is also a bigger maintainance
> > > burden as clients are packaged, can be restarted etc individually.
> >=20
> > It feels like we're having/accepted that cost already though since
> > vhostuser exists today & has been expanding to cover more backends.
>=20
> What I am trying to say is that we could eaily add support for
> extensions just for in-tree code since these don't create an API that
> needs to be maintained.
>=20
> So e.g. we do not need feature negotiation.

Ah, I see what you mean now. Having stuff in-tree makes migration
saner too since we don't have combinatorial expansion of impls to
worry about testnig

> But yes, this could be an extension of vhost-user in some way.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
