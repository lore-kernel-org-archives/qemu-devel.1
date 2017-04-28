Received: from eggs.gnu.org ([2001:4830:134:3::10]:38836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d49Rv-0005QR-2V
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d49Ru-0006f4-8Z
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:12:55 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b485217-3320-62c9-fc28-18f412be3af8@redhat.com>
Date: Fri, 28 Apr 2017 19:12:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NWsgDUQOHqk6fj2EB76wepxxwI010FucN"
Subject: Re: [Qemu-devel] [PATCH v10 01/17] block: Update comments on
 BDRV_BLOCK_* meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NWsgDUQOHqk6fj2EB76wepxxwI010FucN
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <8b485217-3320-62c9-fc28-18f412be3af8@redhat.com>
Subject: Re: [PATCH v10 01/17] block: Update comments on BDRV_BLOCK_* meanings
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-2-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> We had some conflicting documentation: a nice 8-way table that
> described all possible combinations of DATA, ZERO, and
> OFFSET_VALID, couple with text that implied that OFFSET_VALID
> always meant raw data could be read directly.  As the 8-way
> table is the intended semantics, simplify the rest of the text
> to get rid of the confusion.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: new patch
> ---
>  include/block/block.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!


--NWsgDUQOHqk6fj2EB76wepxxwI010FucN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDeA0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5C0H+gIH7BeefHPbrglD8+/teaYG8LLCq5DR
3pIjh7NWsdZYcE4tLL1wfq+QGnXJZ71jaf0fOQR2ckg+xGOSgFZWjarb3dni2xmo
uPic6Gz5LctnkVxqUqV1XHkC4dtfb1bjct5qtvH7FkvcZ75VKItjkatwYL/5RUJq
qy6P6NNQl3vGrkms0cmgi+ti+QxiC4pjN9v9C7Bt3BFmMVbopyApopcjRF2WZKVa
0e2vHrjFbVYdQmlCOG2CCIMIh0sdC0jIcJ0PQIZUlKThmUzwvUHiqO6btekTx5Zr
1Qa7jlStGScT3OuIFrMrCF65UHttJvBKwrVCcZ8TFCy3q1aLg4/uJK4=
=BQac
-----END PGP SIGNATURE-----

--NWsgDUQOHqk6fj2EB76wepxxwI010FucN--
