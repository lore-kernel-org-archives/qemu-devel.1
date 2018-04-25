Received: from eggs.gnu.org ([2001:4830:134:3::10]:48686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBJNk-0005Wz-5p
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBJNh-0004lu-1t
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:18:44 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c3a9ddd-a31b-74a2-1cce-3f353de1830f@redhat.com>
Date: Wed, 25 Apr 2018 14:18:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180421132929.21610-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VF9q4GwGyftxJNzUIVFq5YQRyi9AGkHgc"
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VF9q4GwGyftxJNzUIVFq5YQRyi9AGkHgc
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6c3a9ddd-a31b-74a2-1cce-3f353de1830f@redhat.com>
Subject: Re: [PATCH v2 0/9] block: Add COR filter driver
References: <20180421132929.21610-1-mreitz@redhat.com>
In-Reply-To: <20180421132929.21610-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-21 15:29, Max Reitz wrote:
> This series adds a copy-on-read block filter driver which works by
> simply setting the BDRV_REQ_COPY_ON_READ flag on write requests (and
> otherwise just passing everything through).
>=20
> Cover letter of v1:
> http://lists.nongnu.org/archive/html/qemu-block/2018-04/msg00285.html
>=20
>=20
> v2:
> - Renamed the driver "copy-on-read" (from just "cor") [Stefan]
> - Commit message typo fix in patch 2 [Stefan, Berto]
>=20
>=20
> git-backport-diff against v2:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/9:[0020] [FC] 'block: Add COR filter driver'
> 002/9:[----] [--] 'block: BLK_PERM_WRITE includes ..._UNCHANGED'
> 003/9:[----] [--] 'block: Add BDRV_REQ_WRITE_UNCHANGED flag'
> 004/9:[----] [--] 'block: Set BDRV_REQ_WRITE_UNCHANGED for COR writes'
> 005/9:[----] [--] 'block/quorum: Support BDRV_REQ_WRITE_UNCHANGED'
> 006/9:[----] [--] 'block: Support BDRV_REQ_WRITE_UNCHANGED in filters'
> 007/9:[----] [--] 'iotests: Clean up wrap image in 197'
> 008/9:[0010] [FC] 'iotests: Copy 197 for COR filter driver'
> 009/9:[0004] [FC] 'iotests: Add test for COR across nodes'

Thanks for the reviews, applied to my block branch.

Max


--VF9q4GwGyftxJNzUIVFq5YQRyi9AGkHgc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrgchEACgkQ9AfbAGHV
z0AZUAgAutsUTCdPehO4upxagahz8uOR2AxrrZCrOTwGac0T5k8hH4T+3SigVyGL
5WPkPiMey2UDlaDZHH8SUTrpDX9uAyZaYz0SAsHpwPBbde2XcohFTspVPM15FiFS
jGr6Hl16JAcz+tizyumi5CtoDULyZEBqBjFGfCBWSAz8hNyHVWOTmkuFq9J/wiwF
ma9BkHe3lz1Abn1w1NgrV1YbPJ6eBOISqY/PiPdSzPfrQ1l8Q9c9DonNKTHaj/mi
ITK6S+XCIL7rl6aUxTiiiK/0TuXMgMw19Wsr99sgeB8TT40cm1/46GeG/dEJLmy6
26IrqVf7mpOrdQ1SeliqQZZgyVFAUg==
=I9JJ
-----END PGP SIGNATURE-----

--VF9q4GwGyftxJNzUIVFq5YQRyi9AGkHgc--
