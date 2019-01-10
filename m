Received: from eggs.gnu.org ([209.51.188.92]:44917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghezS-000656-Ab
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghezP-0007Ff-Fq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:23:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghezP-0007F4-8d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:23:35 -0500
Date: Thu, 10 Jan 2019 18:23:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190110182327.GW2178@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-12-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110174516.21586-12-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 11/19] travis: use homebrew addon for
 MacOSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, ymankad@redhat.com, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Thu, Jan 10, 2019 at 05:45:08PM +0000, Alex Benn=C3=A9e wrote:
> Rather than poking homebrew manually we can specify the packages
> needed via the homebrew addon. These are only installed on MacOS based
> builds.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Dupe

> ---
>  .travis.yml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/.travis.yml b/.travis.yml
> index fa70429459..2ef7997d25 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,12 @@ addons:
>        - sparse
>        - uuid-dev
>        - gcovr
> +  homebrew:
> +    packages:
> +      - libffi
> +      - gettext

A separate patch can also drop libffi & gettext since travis logs show
they are already installed these days.

> +      - glib
> +      - pixman
> =20
> =20
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> @@ -68,9 +74,6 @@ git:
>    submodules: false
> =20
> =20
> -before_install:
> -  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
> -  - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi ge=
ttext glib pixman ; fi
>  before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>    - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
