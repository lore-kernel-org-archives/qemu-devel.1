Received: from eggs.gnu.org ([2001:4830:134:3::10]:43288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZro-000702-Kt
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZrk-0001lP-1r
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:45:00 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e41e2284-d4ea-5692-2f5e-b5ca87ffc1b6@redhat.com>
Date: Sat, 28 Jan 2017 21:44:41 +0100
MIME-Version: 1.0
In-Reply-To: <20161220191523.5779-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B52o0Suw9dkedVHkOSTUlNAGd49OPxFk4"
Subject: Re: [Qemu-devel] [PATCH v4 5/7] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B52o0Suw9dkedVHkOSTUlNAGd49OPxFk4
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:blkdebug"
 <qemu-block@nongnu.org>
Message-ID: <e41e2284-d4ea-5692-2f5e-b5ca87ffc1b6@redhat.com>
Subject: Re: [PATCH v4 5/7] blkdebug: Simplify override logic
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-6-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-6-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.12.2016 20:15, Eric Blake wrote:
> Rather than store into a local variable, then copy to the struct
> if the value is valid, then reporting errors otherwise, it is
> simpler to just store into the struct and report errors if the
> value is invalid.  This however requires that the struct store
> a 64-bit number, rather than a narrower type.  Move the errno
> assignment into a label that will be reused from more places in
> the next patch.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v4: fix typo in commit message, move errno assignment
> v3: new patch
> ---
>  block/blkdebug.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--B52o0Suw9dkedVHkOSTUlNAGd49OPxFk4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNArkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4LsIAJxNGxdN2YHQrKf88GmAJ4LT4YRfEC/4
adhIa7LgmX64D0WkfJIJUvJp0JykUZPtV7dc9SRK2UIcN5Xep864lHiigl18vlYB
TuCy1y4RhZRbR0ZZtChzmqiqlx4c7kJzDjnGQ/SUHHaTNf2IB38VtJewEJ8TETGu
MZxMs3E+iyRobnQy0cMNQYxmY1muxxs35JDaqAGVhTb6VjV8YpBQRMGY4lC4Ngwj
lGk9pR+N2HP+YJ+9p0g0FDjFaEuOMUDLhvbKEtJ0+jv8IpELHsA/pS9I1+oa/aT4
A33fp6qdusEQBrOxhXKDiiszydvZ1I5N0hsczFFy7qr1X+zuxhKrgBY=
=AC+w
-----END PGP SIGNATURE-----

--B52o0Suw9dkedVHkOSTUlNAGd49OPxFk4--
