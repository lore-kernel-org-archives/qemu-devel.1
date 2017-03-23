Received: from eggs.gnu.org ([2001:4830:134:3::10]:38610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr7Md-0000GC-En
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr7MZ-0001OE-C7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:21:35 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr7MZ-0001Nx-5P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:21:31 -0400
Received: by mail-wm0-x242.google.com with SMTP id z133so829467wmb.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 11:21:31 -0700 (PDT)
Date: Thu, 23 Mar 2017 18:21:27 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323182127.GK12560@stefanha-x1.localdomain>
References: <20170323092211.29990-1-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline
In-Reply-To: <20170323092211.29990-1-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [PATCH qemu-ga v2] qga: Make qemu-ga compile
 statically for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>, Peter Maydell <peter.maydell@linaro.org>


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 11:22:11AM +0200, Sameeh Jubran wrote:
> Attempting to compile qemu-ga statically as follows for Windows causes
> the following error:
>=20
> Compilation:
>     ./configure --disable-docs --target-list=3Dx86_64-softmmu \
>     --cross-prefix=3Dx86_64-w64-mingw32- --static \
>     --enable-guest-agent-msi --with-vss-sdk=3D/path/to/VSSSDK72
>=20
>     make -j8 qemu-ga
>=20
> Error:
>     path/to/qemu/stubs/error-printf.c:7: undefined reference to `__imp_g_=
test_config_vars'
>     collect2: error: ld returned 1 exit status
>     Makefile:444: recipe for target 'qemu-ga.exe' failed
>     make: *** [qemu-ga.exe] Error 1
>=20
> This is caused by a bug in the pkg-config file for glib as it doesn't def=
ine
> GLIB_STATIC_COMPILATION for pkg-config --static.

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>

Please remove this.  I didn't post my Signed-off-by.  Only add
Signed-off-by for someone else if they ask you to do so.

For details on Signed-off-by please read:
"11) Sign your work - the Developer's Certificate of Origin"
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  configure | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/configure b/configure
> index b9a30cf..8210494 100755
> --- a/configure
> +++ b/configure
> @@ -3041,6 +3041,13 @@ if test "$modules" =3D yes; then
>      glib_modules=3D"$glib_modules gmodule-2.0"
>  fi
> =20
> +# This workaround is required due to a bug in pkg-config file for glib a=
s it
> +# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static

Please add:

# See https://bugzilla.gnome.org/show_bug.cgi?id=3D780399 for the glib bug
# report.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1BInAAoJEJykq7OBq3PIPSEIAJSrsCw3U9UuCc5S0oD6u9q5
VmVcb47SeBwwdSWUuc7CEpMbbbpgpF8cW4OV5UTqwY/XMSXpB3MhGJVcpf35/f0o
YgUFqtO2yl8ttPT1kfAfFsUHt2i2JJog3c7x9VV4IGvAvZT/jkDTLqg2tOkI8K5U
/3prNKaHeqnLTuaPaNsD17stQfDsXMKU8VPFHUED9i13X2tCy1igtmKdjT50LxWj
QrJAmSGqVwSQ9C0vKnq7YgzX2HY5VMe1FyoE+vSTf7Q1B+w9paWJQhjAr9K9hwAe
IYGJHdFMAId5A+xDTcpxRUHVd1oX21/1CU286WUJOEltq2V0tdeGiSI2iB3jgz4=
=jpbZ
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
