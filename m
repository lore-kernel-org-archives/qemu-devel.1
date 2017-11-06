Received: from eggs.gnu.org ([2001:4830:134:3::10]:34623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBh5F-00007x-Qx
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBh5E-0001qd-Qz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:04:57 -0500
Date: Mon, 6 Nov 2017 13:04:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171106130448.GD4557@stefanha-x1.localdomain>
References: <20171103154041.12617-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
In-Reply-To: <20171103154041.12617-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] aio-posix: drop QEMU_AIO_POLL_MAX_NS env
 var
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, thuth@redhat.com


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 03:40:41PM +0000, Stefan Hajnoczi wrote:
> This hunk should not have been merged but I forgot to remove it.  Let's
> remove it before it slips into a QEMU release.
>=20
> =C2=AF\_(=E3=83=84)_/=C2=AF
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c | 7 -------
>  1 file changed, 7 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAF3wAAoJEJykq7OBq3PIoIcIAMS8AUgv9LHcCIooftwdKp6r
yUEalNRpv9mOWQ9UvSiyHPO93JWLMF0ThXu6bPheUQdDTfFy7V3Va9JpDiY+Zldg
ZQNkBAN1y7Xn2h4wDY08BbOKjlr0GMBZ1tfDO9z2Pm9p/Szjm/Ff2M9zMs6IIgaW
cBADiY14WRvWyWDT4NPpX6JpQ/KHjjNhxvHN6AgVIjOddqksEdQrpQ4m5B4XkBUD
O/Cj8Rfj8EsrN3i+Q5PZwt5aFGJT2oK4LEeNDBGtsAqYR6Pz6yBeukjhJ+jU/LtF
AHS4OShyF4ORKPgd1tDXyaAgYv6Lb75tqIT9E145gpdFErn8BachqtzqlndYPLk=
=hSG3
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
