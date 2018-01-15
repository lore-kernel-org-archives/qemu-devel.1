Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb2PD-0005IE-1d
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb2P9-0000rg-8p
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:54:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb2P9-0000qs-0H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:54:15 -0500
Date: Mon, 15 Jan 2018 10:53:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115105357.GF8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-14-berrange@redhat.com>
	<3ea0dbad-1ec3-3a0f-957d-36fa3e262cbe@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ea0dbad-1ec3-3a0f-957d-36fa3e262cbe@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/13] docker: change Fedora images to
 run with python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jan 15, 2018 at 07:47:29AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 01/15/2018 07:26 AM, Daniel P. Berrange wrote:
> > Fedora has switched to Python 3 by default, so it makes sense to use =
that
> > for testing QEMU builds, so we get testing of Python 3 compatibility.
>=20
> I'd rather keep Fedora 25 with Python 2, and use Python 3 in Fedora 27.

FYI, Fedora 25 went end of life 2 weeks ago, so I'm not sure it is worth
keeping that around in QEMU CI all that much much longer.

To your general point though - I just picked Fedora since all non-EOL
versions of Fedora now ship with Python3 only by default. I'm happy to
see any arbitrary combo of Docker images changed, as long as we get a
nice mixture of python 2/3 versions covered across the set. So feel free
to suggest anything that gets us good coverage of 2+3.

> If you agree, I can apply this patch once your series is merged, on top
> of http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02569.htm=
l
>=20
> relevant patches:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02574.html
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02575.html
>=20
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/docker/dockerfiles/fedora.docker | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/do=
ckerfiles/fedora.docker
> > index 4b26c3aded..a22fe16157 100644
> > --- a/tests/docker/dockerfiles/fedora.docker
> > +++ b/tests/docker/dockerfiles/fedora.docker
> > @@ -1,6 +1,6 @@
> >  FROM fedora:latest
> >  ENV PACKAGES \
> > -    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 ho=
stname \
> > +    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 ho=
stname \
> >      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> >      gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> >      nettle-devel \
> > @@ -12,6 +12,7 @@ ENV PACKAGES \
> >      mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-=
libtasn1 \
> >      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh=
2 \
> >      mingw64-bzip2
> > +ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
> > =20
> >  RUN dnf install -y $PACKAGES
> >  RUN rpm -q $PACKAGES | sort > /packages.txt
> >=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
