Received: from eggs.gnu.org ([2001:4830:134:3::10]:55396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Zeq-0006kh-5v
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Zep-0007lP-43
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:23:28 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7bb96664-b433-7850-db3b-dcec0c2016a3@redhat.com>
Date: Tue, 18 Apr 2017 15:23:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x7lCXKWeuffrwgomlAbOKE3AsWrpiELuq"
Subject: Re: [Qemu-devel] [PATCH 00/31] make bdrv_get_block_status byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x7lCXKWeuffrwgomlAbOKE3AsWrpiELuq
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, jsnow@redhat.com,
 qemu-block@nongnu.org
Message-ID: <7bb96664-b433-7850-db3b-dcec0c2016a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/31] make bdrv_get_block_status byte-based
References: <20170418013356.3578-1-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 08:33 PM, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
>=20
> This is part three of that conversion: dirty-bitmap. Earlier parts

Correction: this is part three: bdrv_get_block_status

> have been (mostly) reviewed, for bdrv_is_allocated and dirty-bitmaps.
>=20
> Perhaps I could have split this in two; patches 1-10 vs. 11-31 make
> a nice division of labor.
>=20
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v1
>=20
> It requires the following (v1 of bdrv_is_allocated, v1 of dirty-bitmap,=

> v9 of blkdebug, and Max's block-next tree):
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01995.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01723.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02163.html
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--x7lCXKWeuffrwgomlAbOKE3AsWrpiELuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9nW0AAoJEKeha0olJ0Nqm2kIAJTeLyYmkPDPCs18VO1DHgou
UHWf+QtuEOj7cUwxe5uVm2lAoJ2HvIM+OUa3BRDkUBMDniuey1UjjzCykE1mzhYa
onru4eYKB78ZFKfpiWxPQlU5+lzBbgRH4HTgqRHJYXFCRrXXBD1iNaiSTQWM/7Nj
icmN6AXLuMmf76jNYMi5ncH/QgaaJkkvAzGTpXV9bnjOoZbwPLJbDlBqgxlRQcQ4
Z1nIS5Tr4OiyWnB7sGunVbtsenYWA+71dEQkRmbnTJ9Wwg99YSkyamZ03nGAiexW
ovSYJlD5U29hq98P/bVAEdYtrmRgtuTuKxgEASz20uomjowDacQa4kVTSnjMfFY=
=8C2E
-----END PGP SIGNATURE-----

--x7lCXKWeuffrwgomlAbOKE3AsWrpiELuq--
