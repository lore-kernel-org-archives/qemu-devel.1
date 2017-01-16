Received: from eggs.gnu.org ([2001:4830:134:3::10]:36520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTFSB-00057Q-05
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTFSA-0001xr-7x
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:08:38 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dea04126-fa02-54e6-28fb-c4808c7dcf5c@redhat.com>
Date: Mon, 16 Jan 2017 16:08:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170116204921.31578-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DaU6pwfLwSBD7MdUKVsUjRxp2XRF0tR4S"
Subject: Re: [Qemu-devel] [PATCH v4 09/25] block: Fix
 bdrv_find_backing_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DaU6pwfLwSBD7MdUKVsUjRxp2XRF0tR4S
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <dea04126-fa02-54e6-28fb-c4808c7dcf5c@redhat.com>
Subject: Re: [PATCH v4 09/25] block: Fix bdrv_find_backing_image()
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-2-mreitz@redhat.com>
In-Reply-To: <20170116204921.31578-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:49 PM, Max Reitz wrote:
> bdrv_find_backing_image() should use bdrv_get_full_backing_filename() o=
r
> bdrv_make_absolute_filename() instead of trying to do what those
> functions do by itself.
>=20
> path_combine_deprecated() can now be dropped, so let's do that.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DaU6pwfLwSBD7MdUKVsUjRxp2XRF0tR4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfURhAAoJEKeha0olJ0NqUPgH/i1FnSASeTfYg1zcJvkzjBpx
D212LblXSwB8thXd/0b1xXqx+76iBpkUyhlIQL3j+Yv4HY/abK1mNsTEjUEaJ1BE
RDwAD1DuDYjbatYYRwUBQtBS4p+3/a7TnjOp6LfCVXM2OXfOVQBp9zxv2IzXwSFZ
a0+ycpeCAJ6rsyP4HK2BSTiqIEZ0h2ZWFXcKz7of+akVB55C6DziNT5yHxBERh10
5Kx6J8hakt968tNFIn9PhKnmzT1RFWOXDXe1EIzkPYKK2yHsu9ZfpYIRSQrkfDUt
I+QotvoL//suea61BGBuR2UDKHYHoclywT2bVl0eRgAa7lt8FlF25ZkDky0i94s=
=xETF
-----END PGP SIGNATURE-----

--DaU6pwfLwSBD7MdUKVsUjRxp2XRF0tR4S--
