Received: from eggs.gnu.org ([2001:4830:134:3::10]:42896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZlY-0004wv-M2
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXZlU-0000iS-36
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:38:32 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-5-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c7227435-f3c3-7460-5098-8b135847d7a2@redhat.com>
Date: Sat, 28 Jan 2017 21:38:13 +0100
MIME-Version: 1.0
In-Reply-To: <20161220191523.5779-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C1DCHpCNO5XC09ob4oPdXDIwBpR0FHL58"
Subject: Re: [Qemu-devel] [PATCH v4 4/7] blkdebug: Add pass-through
 write_zero and discard support
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
--C1DCHpCNO5XC09ob4oPdXDIwBpR0FHL58
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:blkdebug"
 <qemu-block@nongnu.org>
Message-ID: <c7227435-f3c3-7460-5098-8b135847d7a2@redhat.com>
Subject: Re: [PATCH v4 4/7] blkdebug: Add pass-through write_zero and discard
 support
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-5-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-5-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.12.2016 20:15, Eric Blake wrote:
> In order to test the effects of artificial geometry constraints
> on operations like write zero or discard, we first need blkdebug
> to manage these actions.  It also allows us to inject errors on
> those operations, just like we can for read/write/flush.
>=20
> We can also test the contract promised by the block layer; namely,
> if a device has specified limits on alignment or maximum size,
> then those limits must be obeyed (for now, the blkdebug driver
> merely inherits limits from whatever it is wrapping, but the next
> patch will further enhance it to allow specific limit overrides).
>=20
> This patch intentionally refuses to service requests smaller than
> the requested alignments; this is because an upcoming patch adds
> a qemu-iotest to prove that the block layer is correctly handling
> fragmentation, but the test only works if there is a way to tell
> the difference at artificial alignment boundaries when blkdebug is
> using a larger-than-default alignment.  If we let the blkdebug
> layer always defer to the underlying layer, which potentially has
> a smaller granularity, the iotest will be thwarted.
>=20
> Tested by setting up an NBD server with export 'foo', then invoking:
> $ ./qemu-io
> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809/foo
> qemu-io> d 0 15M
> qemu-io> w -z 0 15M
>=20
> Pre-patch, the server never sees the discard (it was silently
> eaten by the block layer); post-patch it is passed across the
> wire.  Likewise, pre-patch the write is always passed with
> NBD_WRITE (with 15M of zeroes on the wire), while post-patch
> it can utilize NBD_WRITE_ZEROES (for less traffic).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v4: correct error injection to respect byte range, tweak formatting
> v3: rebase to byte-based read/write, improve docs on why no
> partial write zero passthrough
> v2: new patch
> ---
>  block/blkdebug.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 86 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--C1DCHpCNO5XC09ob4oPdXDIwBpR0FHL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNATUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfwAH/ifT3CSC1KKi2shgvGFRVNh/Q5Lng9Zy
bLfw5peuahtY/CloqeRyvE/N8LsnedjF1fZv1FO9mIaQcFXrbafGVRtj2SSx+FvN
9VEWsJwdbrZ3iGKO9yxIpaElYctxfvEihkYu+Cak2aNlb9/h6ChAq25wpRPQpjnc
IOY5/3IX0MxbloXlFC6hvHaC8AeTTl9vMmqH7MeaD5RYwRabhkfVnOy8uAj36fBz
BLw+jTle4fZq01DMj8Ev0SlzC7sDjLBuaIXJ+zq/G1s4YNkUGj7D3E/ggu2aHf4o
aO2Sf/k2Ld/tRIkjUR8kjNhXzvWSmXwQP1hwgmkwIS9Ej8q4QEAX+GM=
=QU0Z
-----END PGP SIGNATURE-----

--C1DCHpCNO5XC09ob4oPdXDIwBpR0FHL58--
