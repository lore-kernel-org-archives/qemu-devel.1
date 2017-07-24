Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbYf-00016L-17
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbYe-0003pH-7S
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:29:53 -0400
Date: Mon, 24 Jul 2017 12:29:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724112944.GA2784@stefanha-x1.localdomain>
References: <20170721183243.22706-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20170721183243.22706-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based
 block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 01:32:41PM -0500, Eric Blake wrote:
> Series 2-4 of my byte-based conversion missed soft freeze, so they
> are now 2.11 material.  However, there are some bug fixes in those
> series that we should fix now in 2.10 (patch 1 from series two
> on dirty bitmaps, patch 2 extracted from "qcow2: Switch qcow2_measure()
> to byte-based iteration" from series three on block status).
>=20
> I don't know if it is worth enhancing iotest 178 to probe the size
> of a 2T image.  The test is simple, and fast when patched:
>=20
> $ qemu-img create -f qcow2 -o cluster_size=3D2M huge 2T
> $ time ./qemu-img measure -O qcow2 -f qcow2 huge
> required size: 335806464
> fully allocated size: 2199359062016
>=20
> real	0m0.021s
> user	0m0.017s
> sys	0m0.004s
>=20
> but the inf-loop when unpatched is annoying; meanwhile, 'huge' only
> occupies 6 megabytes on disk, so it's not that invasive.
>=20
> Eric Blake (2):
>   dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
>   qcow2: Fix sector calculation in qcow2_measure()
>=20
>  block/dirty-bitmap.c | 2 +-
>  block/qcow2.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.13.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZddooAAoJEJykq7OBq3PIqJIH/RZGw69/RiyxPtEEW1UMkNCZ
g6J13JXaXw/NjfgnqGYDpCH8g/cpNDcxR9CBzhk4Aszjmj40AgWmgVIZ0EPvvMHQ
6k7s4epmpoZQE3ipjspIkYtV0pvB7+0yyOwSCaKWI0VB0MXqh/oebo/VcQUX2Whx
KcMdJj6lgSUuI5Xum19+28O35oJoTqVg6Vv5upJq9sCATDDJ+ggRayUcLyNsBBTG
nFeQjSytL0iYRnySLx5hcbZMDqBibY36zxmUCc/2wdHI5q6rHHiJMl332Rje5lC4
Otoi7qkXuXM4n/nIdcQEtSlqWL6P0oZxg+Ho5ZHVQl4UGtkDNO2G9xSbfv4HcpA=
=AAcc
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
