Received: from eggs.gnu.org ([2001:4830:134:3::10]:47594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evlyi-0007IS-EQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evlye-0006pc-JS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:36:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evlye-0006pK-E7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:36:36 -0400
Date: Tue, 13 Mar 2018 15:36:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313153631.GD3079@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180313153210.28264-1-alex.bennee@linaro.org>
	<20180313153210.28264-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313153210.28264-5-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/4] .travis.yml: add --disable-tools to
 the modules build
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

On Tue, Mar 13, 2018 at 03:32:10PM +0000, Alex Benn=C3=A9e wrote:
> The tools are already built elsewhere so we might as well not build it
> here as we just need to test the modules build of QEMU itself.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index c1e99237b2..373181c109 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -53,7 +53,7 @@ env:
>      - CONFIG=3D"--disable-user"
>      - CONFIG=3D"--enable-debug --enable-debug-tcg"
>      - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --=
disable-brlapi --disable-uuid --disable-libusb --disable-user"
> -    - CONFIG=3D"--enable-modules --disable-linux-user"
> +    - CONFIG=3D"--enable-modules --disable-tools --disable-linux-user"
>      - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
>      - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
>  git:

Modules affects the block drivers in particular, which could in theory
affect the qemu-img, qemu-io and qemu-nbd tools, so possibly worth
keeping that enabled.... but only if we actually run those tools
during the job otherwise we're not likely to catch any problems ?=20


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
