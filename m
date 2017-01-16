Received: from eggs.gnu.org ([2001:4830:134:3::10]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTECa-0008Q5-Gl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTECZ-0003Ut-Lg
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:48:28 -0500
References: <20170113205237.30386-1-mreitz@redhat.com>
	<20170113205237.30386-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <063e9c1e-d053-10cb-a86f-3c1ac3e03d66@redhat.com>
Date: Mon, 16 Jan 2017 14:48:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170113205237.30386-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1phgWFJGHsao4WMDsjmtukbojS14PjmT4"
Subject: Re: [Qemu-devel] [PATCH v6 4/9] block: Do not blindly copy filename
 from file
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
--1phgWFJGHsao4WMDsjmtukbojS14PjmT4
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <063e9c1e-d053-10cb-a86f-3c1ac3e03d66@redhat.com>
Subject: Re: [PATCH v6 4/9] block: Do not blindly copy filename from file
References: <20170113205237.30386-1-mreitz@redhat.com>
 <20170113205237.30386-5-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 02:52 PM, Max Reitz wrote:
> bdrv_refresh_filename() can do the same and it has some checks whether
> the filename can actually be inherited or not, so we can let it do its
> job in bdrv_open_inherit() after bdrv_open_common() has been called.
>=20
> The only thing we need to set in bdrv_open_common() is the
> exact_filename of a BDS without an underlying file, for two reasons:
> (1) It cannot be inherited from an underlying file BDS, so it has to be=

>     set somewhere.
> (2) The driver may need the filename in its bdrv_file_open()
>     implementation (format drivers do not need their own filename,
>     though they may need their file BDS's name).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1phgWFJGHsao4WMDsjmtukbojS14PjmT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfTGTAAoJEKeha0olJ0NqHmgH/jgQVTAH9it7WLNtds1DpV9x
J5DM40L+91XeBZlq68InBGJuv7Wes+Dp40CGu7WPpil5KIUxMw3EhO26q5xEpEWq
IwBg7OFsFrSDOcMyoqXXwkYnMIynqwXC8bd9BaxvDQ0QrX3HKbwo6IdkY59Cr0pJ
IwpxYWyBiWDN7R6sEpvFGpA/g0zfccQo80EwFzR/U8rht/zkcbupYk1HlrvnlFG2
TGHPLb+xx/94WrVvgvzc441uotnTQIQmpDMUzgadBkBR2zONCNiwpQ3a4kBLJwL2
SAg35tjZRww6I9ZYHme7S1660A2dkODhhc5kS5q3WVyH3ePnRgW4yJmiW3yRC3Y=
=+xtJ
-----END PGP SIGNATURE-----

--1phgWFJGHsao4WMDsjmtukbojS14PjmT4--
