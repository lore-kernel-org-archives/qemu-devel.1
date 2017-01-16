Received: from eggs.gnu.org ([2001:4830:134:3::10]:55211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTEu4-0006Nk-V4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTEu3-0008JT-UU
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:33:24 -0500
References: <20170113205237.30386-1-mreitz@redhat.com>
	<20170113205237.30386-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4dc688e8-c784-afb5-9010-94734216d880@redhat.com>
Date: Mon, 16 Jan 2017 15:33:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170113205237.30386-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NevuS5rSsJ5R5BG9S9WC9O8vBFh26vS4S"
Subject: Re: [Qemu-devel] [PATCH v6 5/9] block: Add bdrv_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NevuS5rSsJ5R5BG9S9WC9O8vBFh26vS4S
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4dc688e8-c784-afb5-9010-94734216d880@redhat.com>
Subject: Re: [PATCH v6 5/9] block: Add bdrv_filename()
References: <20170113205237.30386-1-mreitz@redhat.com>
 <20170113205237.30386-6-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 02:52 PM, Max Reitz wrote:
> Split the part which actually refreshes the BlockDriverState.filename
> field off of bdrv_refresh_filename() into a more generic function
> bdrv_filename(), which first calls bdrv_refresh_filename() and then
> stores a qemu-usable filename in the given buffer instead of
> BlockDriverState.filename.
>=20
> Since bdrv_refresh_filename() therefore no longer refreshes that field,=

> all of the existing calls to that function have to be replaced by calls=

> to bdrv_filename() "manually" refreshing the BDS filename field (this i=
s
> only temporary).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h |  1 +
>  block.c               | 50 +++++++++++++++++++++++++++++++++++++++++--=
-------
>  block/replication.c   |  2 +-
>  blockdev.c            |  3 ++-
>  4 files changed, 45 insertions(+), 11 deletions(-)
>=20

> +
> +/* First refreshes exact_filename and full_open_options by calling
> + * bdrv_refresh_filename(). Then, if exact_filename is set, it is copi=
ed into
> + * the target buffer. Otherwise, full_open_options is converted to a J=
SON
> + * object, prefixed with "json:" (for use through the JSON pseudo prot=
ocol) and
> + * put there.
> + *
> + * If @dest is not NULL, the filename will be truncated to @sz - 1 byt=
es and
> + * placed there. If @sz > 0, it will always be null-terminated.
> + *
> + * If @dest is NULL, @sz is ignored and a new buffer will be allocated=
 which is
> + * large enough to hold the filename and the trailing '\0'. This buffe=
r is then
> + * returned and has to be freed by the caller when it is no longer nee=
ded.
> + *
> + * Returns @dest if it is not NULL, and the newly allocated buffer oth=
erwise.
> + */
> +char *bdrv_filename(BlockDriverState *bs, char *dest, size_t sz)

Seems like a reasonable interface.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NevuS5rSsJ5R5BG9S9WC9O8vBFh26vS4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfTwaAAoJEKeha0olJ0Nq69IH/38ayPAlS2ucsGAltTWJ8qsI
sGpLghrxWB+8Z5Vb/et7ptpLX0luB7/mNzvGvoVWElT2dlIYuycSwbHIBEbj1KZq
GwbvwDUJp2pnCtwdhVbKzmE1n8DPU4tx8ocZAyoa/NOX7MRbLbv21pQMPtLVeZYF
kBzjNfNxoP+QQicBCK6JG+OwROsvv9fynuG3l6DjgvUolcrHQC0GphETycor6qKA
S5g6bcTQIDoyCEs+FcC8z+EVBUTwKu2zAt9Qrqy1i5jQFY0bfPk7bOS4BRhuouFC
4FdiMjF+5BTqGz4y0kGD7qiKKGBmsalibedNhECRDtkRXE1JgMOErjXiPIEawxk=
=iC30
-----END PGP SIGNATURE-----

--NevuS5rSsJ5R5BG9S9WC9O8vBFh26vS4S--
