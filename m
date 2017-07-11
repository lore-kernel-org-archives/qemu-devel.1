Received: from eggs.gnu.org ([2001:4830:134:3::10]:59520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUx4L-0005am-Mw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUx4G-0002t0-Of
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:27:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUx4G-0002ru-Gw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:27:16 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21so483296lfk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:27:16 -0700 (PDT)
Date: Tue, 11 Jul 2017 16:26:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711152610.GB31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-6-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/35] coroutine: remove coroutine_fn from
 qemu_co_queue_run_restart()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:16AM +0200, Marc-Andr=E9 Lureau wrote:
> The function can be invoked from non-coroutine context.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/coroutine_int.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZO4SAAoJEJykq7OBq3PIkp8H/RFoouJ4fDnwkf0CgspEwd8G
p1+snCaazOQFXXH3Q8IurKbP+1zGUX2k3YH8azJryVSjag/HAS2rC1qo9OM32MO/
n3lZMUa9MMgbi72aCFdtkjholF99QQ5YvBQkrScw2laMdGNhEjVHED0Ophvs+Ttm
7AYnojQCLi8DJ6kITB/KnYDt9jbzfim5x0sn2wzgilbQG9Vq7GSYIIwSYFK6q2rv
hD8nUZWbpWlKjVU5FpwlkP8Qkg4XUUVEhUYzepOXIvMX7+tmDJNGBtDAIkxibA5f
OEm0eMkmzxDFrTkj1zuLQz0wdcsYOvx3COMTZrjt3uFWL1FCap6EG2Jj1xwORNE=
=60W8
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
