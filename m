Received: from eggs.gnu.org ([2001:4830:134:3::10]:46892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evlx3-00058R-U2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evlx0-0005eH-20
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:34:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evlwz-0005e9-TS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:34:53 -0400
Date: Tue, 13 Mar 2018 15:34:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313153449.GC3079@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180313153210.28264-1-alex.bennee@linaro.org>
	<20180313153210.28264-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313153210.28264-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/4] .travis.yml: add --disable-user
 with the rest of the disables
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

On Tue, Mar 13, 2018 at 03:32:09PM +0000, Alex Benn=C3=A9e wrote:
> As all the disabled features only affect system emulation we might as
> well disable user mode to save compile time.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 75e5b408d0..c1e99237b2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -52,7 +52,7 @@ env:
>      - CONFIG=3D"--disable-system"
>      - CONFIG=3D"--disable-user"
>      - CONFIG=3D"--enable-debug --enable-debug-tcg"
> -    - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --=
disable-brlapi --disable-uuid --disable-libusb"
> +    - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --=
disable-brlapi --disable-uuid --disable-libusb --disable-user"
>      - CONFIG=3D"--enable-modules --disable-linux-user"
>      - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
>      - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"

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
