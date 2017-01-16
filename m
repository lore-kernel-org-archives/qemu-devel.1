Received: from eggs.gnu.org ([2001:4830:134:3::10]:57800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTF5j-0007tY-6H
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTF5i-0003PG-Bh
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:45:27 -0500
References: <20170113205237.30386-1-mreitz@redhat.com>
	<20170116161547.9005-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e5a301d-9b73-711b-767f-48c19771e883@redhat.com>
Date: Mon, 16 Jan 2017 15:45:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170116161547.9005-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wXelUc2UTUAV7UjVRKlx9Cc2pPxmniHKH"
Subject: Re: [Qemu-devel] [PATCH v6 6/9] qemu-img: Use bdrv_filename() for
 map
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
--wXelUc2UTUAV7UjVRKlx9Cc2pPxmniHKH
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1e5a301d-9b73-711b-767f-48c19771e883@redhat.com>
Subject: Re: [PATCH v6 6/9] qemu-img: Use bdrv_filename() for map
References: <20170113205237.30386-1-mreitz@redhat.com>
 <20170116161547.9005-1-mreitz@redhat.com>
In-Reply-To: <20170116161547.9005-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 10:15 AM, Max Reitz wrote:
> Replaces bs->filename by the result of bdrv_filename() in the
> qemu-img map subcommand. Since that value is queried relatively often,
> however, we should try to reuse the last result.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wXelUc2UTUAV7UjVRKlx9Cc2pPxmniHKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfT7uAAoJEKeha0olJ0Nqvf8H/3SekeIebJ7yRHO1581hAz17
AlrTWxN1GH9Mq43WPby0IKqKR7GPCiljZxy/zRD+8y5gnrMx29jd+mif7aJEiVGi
SAdxqlGugzlh+JPHgp0OBzM+P+VouxB0iwNtmG28T2HGLEXrhQx/A091IpEUdN4i
VGL8mzt2DTNID58ove1QjzuZ9kSQDiMmRpnfsMB+qqlGwY9anD2TgSTXuXDPghp3
AmK8ri3O5/aC5ClkfWtykKM+PrUWMj8/oydU/xlcSvG8wqrtAtrI7N4F76Th0C6m
/lSmCxL2pLGOSEq6uB0gzCCBYdQBSKcifFenP1VNMKT2pUApztZLecwD4ZwXbC0=
=yeeT
-----END PGP SIGNATURE-----

--wXelUc2UTUAV7UjVRKlx9Cc2pPxmniHKH--
