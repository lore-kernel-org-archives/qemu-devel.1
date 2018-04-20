Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9boY-0007Ej-PV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9boX-0000oB-Vo
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:35:22 -0400
References: <20180406151731.4285-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <73e2d9e7-270c-4f7b-284f-7b65cf842fd0@redhat.com>
Date: Fri, 20 Apr 2018 21:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180406151731.4285-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UZsoqzs1aMp8QChoWzR0lJZDSdFBiEW9e"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Skip 181 and 201 without
 userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UZsoqzs1aMp8QChoWzR0lJZDSdFBiEW9e
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <73e2d9e7-270c-4f7b-284f-7b65cf842fd0@redhat.com>
Subject: Re: [PATCH 0/2] iotests: Skip 181 and 201 without userfaultfd
References: <20180406151731.4285-1-mreitz@redhat.com>
In-Reply-To: <20180406151731.4285-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-06 17:17, Max Reitz wrote:
> My non-Fedora testing system does not have a kernel with userfaultfd
> support which causes 181 and 201 to fail.  That is annoying.  This
> series makes those tests recognize the issue and convert it into a
> _notrun.
>=20
>=20
> Max Reitz (2):
>   iotests: Add failure matching to common.qemu
>   iotests: Skip 181 and 201 without userfaultfd
>=20
>  tests/qemu-iotests/181         | 13 ++++++++++
>  tests/qemu-iotests/201         | 13 ++++++++++
>  tests/qemu-iotests/common.qemu | 58 ++++++++++++++++++++++++++++++++++=
+++-----
>  3 files changed, 77 insertions(+), 7 deletions(-)

Applied to my block-next branch.

Max


--UZsoqzs1aMp8QChoWzR0lJZDSdFBiEW9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlraQOoACgkQ9AfbAGHV
z0AgzggAuPz6owl8M6qPlzI//EIXoF+CHpKLUf7Yyknqux8vRhvKuneyrxSwKLAF
DULdgnFcGDm5u3EYhXmNmbf6SERwtAYo790+QCDTJKAku2190GQza/i5xDHBRmEB
fYmzQY9mwVkGGd/vxbfb752fRCrzaHL1LuU0XrwOB/8LW4g194fqlDsaRgO1JRmQ
qGAWtU0PlFA3ScZnuN0Jz9GxLNQUjbVxKBFw0vEHk/8G4tGrNS/q8fWuS7R4F1Ld
KLXUOPdw+0HyWM/K8yLde1UThhGSltCvkPlAzZ1hzadYN9S+z9MLlc97muRcEwfX
OHpL3a8GdcmjVIPAAl0gRPAy8jJ0CQ==
=3roE
-----END PGP SIGNATURE-----

--UZsoqzs1aMp8QChoWzR0lJZDSdFBiEW9e--
