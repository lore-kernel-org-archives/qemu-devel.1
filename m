Received: from eggs.gnu.org ([2001:4830:134:3::10]:53145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1che1I-0008Os-ME
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1che1H-0002n8-NW
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:12:24 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-51-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8d7bede9-ca03-f121-afc7-806e2f892937@redhat.com>
Date: Sat, 25 Feb 2017 16:12:15 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-51-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3RScMBdoRfR6LtA8KxtXjcX1lrv7rBVHI"
Subject: Re: [Qemu-devel] [PATCH 50/54] block: Pass BdrvChild to
 bdrv_aligned_preadv/pwritev
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
--3RScMBdoRfR6LtA8KxtXjcX1lrv7rBVHI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <8d7bede9-ca03-f121-afc7-806e2f892937@redhat.com>
Subject: Re: [PATCH 50/54] block: Pass BdrvChild to
 bdrv_aligned_preadv/pwritev
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-51-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-51-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This is where we want to check the permissions, so we need to have the
> BdrvChild around where they are stored.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

I was about to inquire about bdrv_co_do_pwrite_zeroes() which is called
by bdrv_co_do_copy_on_readv(), but then I saw that you make the latter
take a BdrvChild in the next patch. OK, but I think that change needs to
be here.

Max


--3RScMBdoRfR6LtA8KxtXjcX1lrv7rBVHI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixns8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkjMH/0FGLXTCHZyMmEIKlaB6jx7urhFN7K2Y
UxdQPjoYocEbXILoVLI33ODByBmQsa3QSEm7ZqJk+1SBypOxHret2bV439lecQpp
h7myiQq24+YQ1sj5UDQe7a2dALTkNP/KOG2z6nGhCH1XC3poZPnHukF3JRWz1tJJ
NkX/sl0na03DUIm75+h0abxF4O1O5OFvmLjMl5SwHxhtlI7JPSHw5Uhkw8jPEXYW
OxvugKdFgkUlrcwiNX/l0ATMqibdk/Tz341xxwIS770NJLkmJPATxkhBq49jPlMh
qHoVbEjK69ZbjHuycKECXDZMObPDAOjIYs1MPqDOLVrwK1ehmZ4X9xk=
=sMTE
-----END PGP SIGNATURE-----

--3RScMBdoRfR6LtA8KxtXjcX1lrv7rBVHI--
