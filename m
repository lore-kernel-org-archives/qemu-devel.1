Received: from eggs.gnu.org ([2001:4830:134:3::10]:60950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1da0qO-00062m-TR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1da0qL-00036j-PF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1da0qL-00035O-JM
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:29:49 -0400
Date: Tue, 25 Jul 2017 15:22:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725142217.GQ26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-35-f4bug@amsat.org>
	<87k22weh78.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k22weh78.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 34/35] docker: add debian
 'bleeding' image with gcc7 and clang5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Tue, Jul 25, 2017 at 03:15:07PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  .../docker/dockerfiles/debian-bleeding-dev.docker  | 94 ++++++++++++=
++++++++++
> >  1 file changed, 94 insertions(+)
> >  create mode 100644 tests/docker/dockerfiles/debian-bleeding-dev.dock=
er
> >
> > diff --git a/tests/docker/dockerfiles/debian-bleeding-dev.docker b/te=
sts/docker/dockerfiles/debian-bleeding-dev.docker
> > new file mode 100644
> > index 0000000000..d6ae20692c
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles/debian-bleeding-dev.docker


> > +RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/v=
irglrenderer
> > +RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure
> > --with-glx --disable-tests && make install
>=20
> There are a lot of moving parts basing this in debian unstable and
> compiling extra bleeding edge stuff. What does this buy that the clang
> and toolchain builds in Travis don't already cover?

FWIW, the clang version in Travis is somewhat old compared to the version
that Peter uses during merge testing. I recently had a pull request that
passed travis tests, but failed with modern clang.

Doesn't neccessarily mean we need debian bleeding edge though - a Fedora
26 image would have detected that since it has new clang.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
