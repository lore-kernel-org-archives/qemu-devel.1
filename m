Received: from eggs.gnu.org ([2001:4830:134:3::10]:55329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ej7er-0001e6-35
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ej7eq-0002qs-1u
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:07:53 -0500
Date: Tue, 6 Feb 2018 18:07:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180206180742.GN20001@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180206171642.19826-1-vsementsov@virtuozzo.com>
	<20180206172907.GL20001@redhat.com>
	<b4ddc41e-0c96-7f91-96c6-957271baf6a4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4ddc41e-0c96-7f91-96c6-957271baf6a4@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com

On Tue, Feb 06, 2018 at 08:57:38PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> 06.02.2018 20:29, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Feb 06, 2018 at 08:16:42PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> > > Support default luks options in VM.add_drive and in new library
> > > function qemu_img_create. Use it in 205 iotests.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
> > > ---
> > >=20
> > > instead of
> > >    [PATCH] iotests: 205: support only raw format
> > >=20
> > > let's just support luks. This patch also makes it simple to support
> > > luks in any other python iotest.
> > >=20
> > >   tests/qemu-iotests/205        |  4 ++--
> > >   tests/qemu-iotests/iotests.py | 33 ++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 35 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iot=
ests.py
> > > index 5a10b2d534..4b9a4445cd 100644
> > > --- a/tests/qemu-iotests/iotests.py
> > > +++ b/tests/qemu-iotests/iotests.py
> > > @@ -58,6 +58,13 @@ qemu_default_machine =3D os.environ.get('QEMU_DE=
FAULT_MACHINE')
> > >   socket_scm_helper =3D os.environ.get('SOCKET_SCM_HELPER', 'socket=
_scm_helper')
> > >   debug =3D False
> > > +luks_default_secret_id =3D 'luks_secret_default_iotests_id'
> > Can we just call this  "keysec0", so we matchh convention used by
> > the shell script based tests.
>=20
> Here I'm trying to avoid intersection with some user-defined id.

The "user" here is the person writing individual I/O tests. They already
have to know to avoid keysec0 because that's the standard we've defined
for the shell based scripts. So I don't see any benefit to divering in
the Python - just doubles the stuff they need to remember.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
