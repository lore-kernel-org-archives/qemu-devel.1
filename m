Received: from eggs.gnu.org ([2001:4830:134:3::10]:51283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUoT-0003tk-Ia
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGUoS-0007Eb-IB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:31:45 -0400
References: <20180421163957.29872-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <018f5304-fbd6-944e-1761-6812c2bab78c@redhat.com>
Date: Wed, 9 May 2018 21:31:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180421163957.29872-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kE4It0dqsUwAVvYxxO8LPlD4WHCaBltMG"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Check post-truncation size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kE4It0dqsUwAVvYxxO8LPlD4WHCaBltMG
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <018f5304-fbd6-944e-1761-6812c2bab78c@redhat.com>
Subject: Re: [PATCH v2] qemu-img: Check post-truncation size
References: <20180421163957.29872-1-mreitz@redhat.com>
In-Reply-To: <20180421163957.29872-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-21 18:39, Max Reitz wrote:
> Some block drivers (iscsi and file-posix when dealing with device files=
)
> do not actually support truncation, even though they provide a
> .bdrv_truncate() method and will happily return success when providing =
a
> new size that does not exceed the current size.  This is because these
> drivers expect the user to resize the image outside of qemu and then
> provide qemu with that information through the block_resize command
> (compare cb1b83e740384b4e0d950f3d7c81c02b8ce86c2e).
>=20
> Of course, anyone using qemu-img resize will find that behavior useless=
=2E
> So we should check the actual size of the image after the supposedly
> successful truncation took place, emit an error if nothing changed and
> emit a warning if the target size was not met.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1523065
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Drop dots in {error,warn}_report() messages [Eric]
>=20
> v1: http://lists.nongnu.org/archive/html/qemu-block/2018-04/msg00441.ht=
ml
> ---
>  qemu-img.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)

Thanks for the reviews (v1 and v2), applied to my block branch.

Max


--kE4It0dqsUwAVvYxxO8LPlD4WHCaBltMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzTJgACgkQ9AfbAGHV
z0Dt/Qf/WmivVIVeoBIbCxnYCAiHPb638R7f+vOE+d58vvAZcVjyS2xogGHeOC7U
k+9iyDDhJ7nv14+ym8L8y3QlsvsuQhS/Cl3MJ/vMncmLPEMJQ/u/K/MJ+hecOHkc
QmzFcBbnKKokaAJtu2c80WUYsJpy8OAzsAyP/E/JtR7nWtHAV5R6hkxFwj+R5rdL
E+jl23xP1X/xarpDmWlSzbyZrhk78NQ752EoszKOhHHw0rmLwAY+L2v8jmqjGv68
ltdv3cmpCfNgVM7sPACAd/SI5McAxby+R+9pk8bILNJ1KiPh+Zoyy4Kx/dFoOC0C
P+c7dIGs7nP2y8Th0kGobBUmTVVxYg==
=icpA
-----END PGP SIGNATURE-----

--kE4It0dqsUwAVvYxxO8LPlD4WHCaBltMG--
