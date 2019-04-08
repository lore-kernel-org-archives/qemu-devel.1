Received: from eggs.gnu.org ([209.51.188.92]:60800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZ8z-00052X-Pq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZ8y-0005j5-PT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:37:21 -0400
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b60b581-8e60-d8c7-f607-7699ff8d8c9b@redhat.com>
Date: Mon, 8 Apr 2019 13:37:13 -0500
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-2-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CqMjhCzh9fmm4amnOvBnayWnpnUk1ck46"
Subject: Re: [Qemu-devel] [PATCH 01/15] qemu-img: Use error_vreport() in
 error_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CqMjhCzh9fmm4amnOvBnayWnpnUk1ck46
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <2b60b581-8e60-d8c7-f607-7699ff8d8c9b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] qemu-img: Use error_vreport() in
 error_exit()
References: <20190408083627.7479-1-armbru@redhat.com>
 <20190408083627.7479-2-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 3:36 AM, Markus Armbruster wrote:
> error_exit() uses low-level error_printf() to report errors.
> Modernize it to use error_vreport().
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-img.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index aa6f81f1ea..55201fb913 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -85,13 +85,11 @@ static void QEMU_NORETURN GCC_FMT_ATTR(1, 2) error_=
exit(const char *fmt, ...)
>  {
>      va_list ap;
> =20
> -    error_printf("qemu-img: ");
> -
>      va_start(ap, fmt);
> -    error_vprintf(fmt, ap);
> +    error_vreport(fmt, ap);
>      va_end(ap);
> =20
> -    error_printf("\nTry 'qemu-img --help' for more information\n");
> +    error_printf("Try 'qemu-img --help' for more information\n");
>      exit(EXIT_FAILURE);
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--CqMjhCzh9fmm4amnOvBnayWnpnUk1ck46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyrlNkACgkQp6FrSiUn
Q2qATQgAoyaK6QQQESEcalQkL2Yd4gOMzTWOgtBDxFP+tNZWEsFOgCXR3jKIFxMi
xjY8j+D8oB39LvZocsJFVHO1BUVJ7r9qt5oHv4PEh1I2PeWh3QywHfUm6Ikfwp5m
RXmA9TlIl22RIBtx0u6+n3U8zpaKDm5VrTfikPLlTL6zmIFDqRrAnqfChEkZ8BiL
RNTpwnZ8t1neBP3bv1XKtC11W+8cKjNAVehex6MHGx7Xt4WARp0RMMPqpl8oOH+e
UaOYrJmfOmeg9yVZ9C3hO5gXzpHT6O3169YuxGzOXP1PBImMYMKdpaa5r0yGVqGb
dgVydi2ZUPqPrMn81hEBuLGfEdnvhA==
=1dMa
-----END PGP SIGNATURE-----

--CqMjhCzh9fmm4amnOvBnayWnpnUk1ck46--
