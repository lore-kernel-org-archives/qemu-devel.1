Received: from eggs.gnu.org ([2001:4830:134:3::10]:42885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrmd-000512-BR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrmZ-0001wv-Kq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:41:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrmZ-0001wJ-F4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:41:43 -0400
Date: Fri, 29 Jun 2018 12:41:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629114137.GH27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625111935.26108-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 01/10] travis: do not waste time cloning
 unused submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, Jun 25, 2018 at 12:19:26PM +0100, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Builds only require:
> - dtc
> - keycodemapdb
> - capstone
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [AJB: drop wget cache]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index bd66c18fed..134d5331fe 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -66,8 +66,7 @@ git:
>  before_install:
>    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
>    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi ge=
ttext glib pixman ; fi
> -  - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git=
-seed.tar.xz | tar -xvJ
> -  - git submodule update --init --recursive
> +  - git submodule update --init --recursive capstone dtc ui/keycodemap=
db
>  before_script:
>    - ./configure ${CONFIG} || { cat config.log && exit 1; }
>  script:

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
