Received: from eggs.gnu.org ([2001:4830:134:3::10]:46756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evlwk-0004ie-3K
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evlwg-0005SC-8A
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evlwg-0005S2-3M
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:34:34 -0400
Date: Tue, 13 Mar 2018 15:34:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313153427.GB3079@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180313153210.28264-1-alex.bennee@linaro.org>
	<20180313153210.28264-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313153210.28264-3-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] .travis.yml: split default config
 into system and user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, Mar 13, 2018 at 03:32:08PM +0000, Alex Benn=C3=A9e wrote:
> As the build times have risen we keep timing out. Split the default
> config into system and user builds.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 92c343a1ef..75e5b408d0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -49,7 +49,8 @@ env:
>      - TEST_CMD=3D"make check"
>      - MAKEFLAGS=3D"-j3"
>    matrix:
> -    - CONFIG=3D""
> +    - CONFIG=3D"--disable-system"
> +    - CONFIG=3D"--disable-user"

Could add --disable-tools here too, just to avoid duplication between the
two entries but that's minor.

>      - CONFIG=3D"--enable-debug --enable-debug-tcg"
>      - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --=
disable-brlapi --disable-uuid --disable-libusb"
>      - CONFIG=3D"--enable-modules --disable-linux-user"

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
