Received: from eggs.gnu.org ([209.51.188.92]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghHQ8-0002cq-Vb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghHQ7-0006Vf-MW
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:13:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghHQ7-0006Ov-GB
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:13:35 -0500
Date: Wed, 9 Jan 2019 17:13:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109171311.GA3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
	<20190109163114.17010-10-berrange@redhat.com>
	<87zhs9vk72.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhs9vk72.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/13] travis: move macOS brew setup into
 the macOS matrix entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>

On Wed, Jan 09, 2019 at 05:01:53PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > There is no need to use shell conditionals to run commands when they =
can
> > simply be listed under the appropriate matrix entry.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  .travis.yml | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index fa70429459..b5f520034f 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -68,9 +68,6 @@ git:
> >    submodules: false
> >
> >
> > -before_install:
> > -  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
> > -  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi =
gettext glib pixman ; fi
> >  before_script:
> >    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> >    - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
> > @@ -171,6 +168,8 @@ matrix:
> >        os: osx
> >        osx_image: xcode9.4
> >        compiler: clang
> > +      before_install:
> > +        - brew update && brew install libffi gettext glib pixman
> >
> >
> >      - env:
> > @@ -178,6 +177,8 @@ matrix:
> >        os: osx
> >        osx_image: xcode10
> >        compiler: clang
> > +      before_install:
> > +        - brew update && brew install libffi gettext glib pixman
>=20
> Does this override the global before_install:? I appreciate we've just
> cleaned that up but if we add it again....

Yes, anything defined under the matrix: generally overrides the same
named setting at the top level. I think the env: is the only exception
which instead augments top level settings.

> Regardless there is a homebrew add-ons now we can use.

Oh that's even better if it works for us.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
