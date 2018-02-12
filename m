Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elGAb-0002mF-8m
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elGAY-00038j-TF
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:37:29 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-17-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <196cb789-9ad9-14f6-cb6f-2a0ee133a065@redhat.com>
Date: Mon, 12 Feb 2018 16:36:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-17-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VviHnEGRloko3IBwRHbT1lXoh9cUDFPH6"
Subject: Re: [Qemu-devel] [PATCH 16/27] nfs: Use QAPI options in
 nfs_client_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VviHnEGRloko3IBwRHbT1lXoh9cUDFPH6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <196cb789-9ad9-14f6-cb6f-2a0ee133a065@redhat.com>
Subject: Re: [PATCH 16/27] nfs: Use QAPI options in nfs_client_open()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-17-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Using the QAPI visitor to turn all options into QAPI BlockdevOptionsNfs=

> simplifies the code a lot. It will also be useful for implementing the
> QAPI based .bdrv_co_create callback.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/nfs.c | 176 ++++++++++++++++++----------------------------------=
--------
>  1 file changed, 53 insertions(+), 123 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VviHnEGRloko3IBwRHbT1lXoh9cUDFPH6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBtJsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUagIAJfHl5PUflGlcOC5B2sQhgq0lR0RDeov
UOx7IRcx43GHgEjpaxxRph5pQVhopi+O9L3so27wJ/JqvIRTiVP3L98cy9LCPf5I
oUladbRFqIqRwUXOgIU2q1ZIkt8A6ms9ZXAliGbcEmge8W3d3Z0c2xJW4stPUXk7
1nzpHdSVTpr5nazBCdxseqSQRKWqfPvwtwLlyY+1q5BDibtmCEnV/B8lgT0dw+dP
F/Bx4RUVDeRXf/wA3JNmez8wJWC6t3DtusntCblfihQ1caxdv1rAzaEfNxlQ0LU8
ctBfcBvR6C0YdWRzn40dldCdSJ/CusQVJlQjWkM6zg/1QNx4GAg4HmA=
=ce3L
-----END PGP SIGNATURE-----

--VviHnEGRloko3IBwRHbT1lXoh9cUDFPH6--
