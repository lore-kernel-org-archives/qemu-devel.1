Received: from eggs.gnu.org ([2001:4830:134:3::10]:45162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgYHt-0001w1-GG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgYHs-0003fD-Ql
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:53:01 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-28-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2bd25bf9-a4f4-c7b9-8c17-a0adbe449e29@redhat.com>
Date: Wed, 22 Feb 2017 15:52:49 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-28-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iQbA9gPSVtda3cCBEO3ifGDTN9WK4PeTx"
Subject: Re: [Qemu-devel] [PATCH 27/54] block: Request real permissions in
 blk_new_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iQbA9gPSVtda3cCBEO3ifGDTN9WK4PeTx
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <2bd25bf9-a4f4-c7b9-8c17-a0adbe449e29@redhat.com>
Subject: Re: [PATCH 27/54] block: Request real permissions in blk_new_open()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-28-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> We can figure out the necessary permissions from the flags that the
> caller passed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--iQbA9gPSVtda3cCBEO3ifGDTN9WK4PeTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitpcESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AO2MIAJepetjRt2a4glhJRB8mrRcs35E7QPsV
R9gijTjq3XZPBFR+qzmofldt+nFBcs0lRa+BMM2Ma3868VB94ty03UYuDQvhRuNb
z5CTUCqT/cwb5OSNuPgo0IT1vYDqzUyRYi0nOUJqF/WaxN/6GTjxbBaIRLWh7prp
QI9/I13vg7yYzcCzDfXchFuP3hbuWlNoNYY7k94d8kdrFv2S4lWJMjAKxw2kNx8k
6t4e3fHkKGndtY0obUm3gPrnXDjiK40S75XscTdggRCM5YRA56loPD/D2h3+JDjd
tDXFVpgRb3TFfHQOpMqi2W7GYfma46YWMGX1gf6xvydZAhuQap/Qu8c=
=OkfZ
-----END PGP SIGNATURE-----

--iQbA9gPSVtda3cCBEO3ifGDTN9WK4PeTx--
