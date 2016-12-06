Received: from eggs.gnu.org ([2001:4830:134:3::10]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENxC-00042m-1W
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENx8-0002U3-3E
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:11:13 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <26985621-a5f8-7bcb-99b0-8365e5b574fb@redhat.com>
Date: Tue, 6 Dec 2016 23:10:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161202192223.15153-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GPNDgJqRqpw8V5SX0j1W86quaqjFnRUdm"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] blkdebug: Simplify override logic
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
--GPNDgJqRqpw8V5SX0j1W86quaqjFnRUdm
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <26985621-a5f8-7bcb-99b0-8365e5b574fb@redhat.com>
Subject: Re: [PATCH v3 3/5] blkdebug: Simplify override logic
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-4-eblake@redhat.com>
In-Reply-To: <20161202192223.15153-4-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.12.2016 20:22, Eric Blake wrote:
> Rather than store into a local variable, the copy to the struct
> if the value is valid, then reporting errors otherwise,

It is rather difficult to part this sentence starting from "the copy".

>                                                         it is
> simpler to just store into the struct and report errors if the
> value is invalid.  This however requires that the struct store
> a 64-bit number, rather than a narrower type.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v3: new patch
> ---
>  block/blkdebug.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Anyway, thanks! If you can explain to me how to parse the commit message
or make it easier to read:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GPNDgJqRqpw8V5SX0j1W86quaqjFnRUdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHN3ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnpgH/2cD4q2m9tliYiaTLqvkvuusqrV1flDl
rSJ2WvqjVLuC/92pyJQtI9+kj9hmPc1atFU+G8aFDBV+3+vAn/kIimwxdS3AarG2
ecnW1D83f87wDPQkrGq2gXMPcTAgbe+S/nVFHTL8/kQbeDHWRQXcIJ5P7lB6lf7w
rkCV8ABtX2XwfuA0p/smokRefta8Q+eQMcXwiS8gqUlgyuCtBfoRADL+lzb9pIBu
+0/eFucCBU1cTxZ8CkZ3ZKHgDeuXm7qrfPQJD+VskCxGDrvScN/+ith89BsKg2J6
uOnR4o5VL7/Ezx8h2bmSZ6BCLDhLp3kFHQ/tQ5h5mb/CVS0ljmFFyBE=
=jyjM
-----END PGP SIGNATURE-----

--GPNDgJqRqpw8V5SX0j1W86quaqjFnRUdm--
