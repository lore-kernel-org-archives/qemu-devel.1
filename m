Received: from eggs.gnu.org ([2001:4830:134:3::10]:49410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgjC-0001wr-UF
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgj9-0003IP-Qj
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:24:26 -0500
Date: Mon, 19 Nov 2018 10:24:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119102417.GC19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-4-berrange@redhat.com>
	<abec84f9-d5c2-9488-3c1b-ca3c9b7df89f@redhat.com>
	<2183d0b1-2b88-a9eb-abb7-ea2fdf3f4388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2183d0b1-2b88-a9eb-abb7-ea2fdf3f4388@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: pull qemu-nbd iotest helpers
 into common.nbd file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 16, 2018 at 03:43:16PM -0600, Eric Blake wrote:
> On 11/16/18 3:41 PM, Eric Blake wrote:
>=20
> > > +#!/bin/bash
> >=20
> > I know we're using bash,
> >=20
> > > +
> > > +function nbd_server_stop()
> > > +{
> >=20
> > > +function nbd_server_wait_for_unix_socket()
> >=20
> > and bash supports 'function', but it is an obsolete syntactic sugar
> > thing that I don't recommend using.=C2=A0 (In ksh, it actually makes =
a
> > difference in behavior whether you use 'function' or not, and using i=
t
> > in 'bash' makes it harder to port code over to 'ksh' - and hence in b=
ash
> > it is obsolete because here it does NOT cause the change in behavior
> > that ksh users expect)
> >=20
>=20
> Of course, I hit send too soon, before getting to my punchline:
>=20
> Since we already have so many existing iotests that use 'function', it'=
s
> better to clean that up as a separate patch.

Yeah, I actually thought 'function' was the preferred syntax and
omitting it was bad since so many iotests used it :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
