Received: from eggs.gnu.org ([2001:4830:134:3::10]:48445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbY2H-0005b5-09
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbY2D-0000Ws-3i
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:36:13 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba4d7b16-c600-9bf9-5f74-f32410e17365@redhat.com>
Date: Wed, 8 Feb 2017 13:35:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M3OMWCv2mHPfHbTGnx4vTCHNp8aqQgmJC"
Subject: Re: [Qemu-devel] [PATCH v3 08/18] qcow: make encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M3OMWCv2mHPfHbTGnx4vTCHNp8aqQgmJC
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <ba4d7b16-c600-9bf9-5f74-f32410e17365@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/18] qcow: make encrypt_sectors encrypt
 in place
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-9-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2017 04:18 AM, Daniel P. Berrange wrote:
> Instead of requiring separate input/output buffers for
> encrypting data, change encrypt_sectors() to assume
> use of a single buffer, encrypting in place. One current
> caller uses the same buffer for input/output already
> and the other two callers are easily converted to do so.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c | 44 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--M3OMWCv2mHPfHbTGnx4vTCHNp8aqQgmJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm3MbAAoJEKeha0olJ0NqSrYH/1FEwCaH77bqjNExXgpLh6Qa
ZQuRHs2l+lMUKqCxKsMtPKn7vN0avu4kMP3Pr/y/y0/Vxc3GjHTnrPY1XMSyWng/
NIWSwYKZqHCzaiLqHtiy53olL+pqJbKzklkFhsjlv+A4n1LrT6p45x22eVA/xy1C
npseZpclVwTHDlJEWxcfiIHaiDvPGf5EsnveADP+2n7BciyCiXnYaYhW1+e/UkN2
pSTyyQndth+nkQCL6kFNFhRjZynzQr1YysGduCfq86KoWhVC4RSfmpC8dFwevwiR
wUt9s7B2rXuARAHJ/dUWbMn5BxZsdAVMcJOXokdLyecoa+FBlVawFOZNRwU/L6I=
=vwSX
-----END PGP SIGNATURE-----

--M3OMWCv2mHPfHbTGnx4vTCHNp8aqQgmJC--
