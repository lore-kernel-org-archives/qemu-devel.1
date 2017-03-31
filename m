Received: from eggs.gnu.org ([2001:4830:134:3::10]:40456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctwIW-00036a-I9
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctwIV-0008E5-LP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:09:00 -0400
References: <20170330221243.17333-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <68601720-203d-9b96-b4e3-41caa39e9872@redhat.com>
Date: Fri, 31 Mar 2017 15:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170330221243.17333-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9VUDB8gp7KnB464NMTkLcHGl9nO0ldbkK"
Subject: Re: [Qemu-devel] [PATCH for-2.9] iotests: Fix test 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9VUDB8gp7KnB464NMTkLcHGl9nO0ldbkK
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <68601720-203d-9b96-b4e3-41caa39e9872@redhat.com>
Subject: Re: [PATCH for-2.9] iotests: Fix test 147
References: <20170330221243.17333-1-mreitz@redhat.com>
In-Reply-To: <20170330221243.17333-1-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 00:12, Max Reitz wrote:
> This test has been broken by changing NBD's blockdev-add interface (fro=
m
> taking a SocketAddress to taking a SocketAddressFlat). This patch makes=

> it work again.
>=20
> Unfortunately, we cannot just flatten all of the addresses because
> nbd-server-start still takes a plain SocketAddress. Therefore, we need
> both and this is most easily achieved by writing the SocketAddress into=

> the code and flattening it where necessary.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I can be convinced to squash this into Markus' patch "nbd: Tidy up
> blockdev-add interface" which is the reason this test broke. I
> personally don't have a strong opinion on the matter other than "We
> won't get Markus to send a v4".
> ---
>  tests/qemu-iotests/147 | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Squashed into said patch:

https://github.com/XanClic/qemu/commit/block^

(on my block branch: https://github.com/XanClic/qemu/commits/block)

Max


--9VUDB8gp7KnB464NMTkLcHGl9nO0ldbkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeVOESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApfkIAJ5E5VwPPQUYVYtXPYcez1m2c/mZ/Oah
/oqxm5PIHR35YVD862ZtBIe+10JJVey4ZM0kYkl6ABasBCDG7Jg9Iia7iucaeWHk
jXTTag3uRQGYffFkSHqUP6lyhhB8x8/FDw1EZuvj/IOCsIEPXg0tEQbe4yA+6s6m
phJD+jkLRs04sqdVQzMfMYoMYnQV11rO0Ctqs/2vySnFkUzPjwndtwqVYhxluWuu
IrT2Pu9/MR41lxNqfcDGdjZlmbR+LUFNVOi9uCldBjtx0jQxDCF6gan58PlaAxJG
MX9gBM8K1eIVV2ttCb9uZT7rK8RFw+WZZL2y56GkbqPDVGcJCcuObq4=
=xDTo
-----END PGP SIGNATURE-----

--9VUDB8gp7KnB464NMTkLcHGl9nO0ldbkK--
