Received: from eggs.gnu.org ([2001:4830:134:3::10]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ1XF-00068L-D2
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ1XE-0005fd-Fd
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:29:45 -0500
References: <1485942829-10756-1-git-send-email-pl@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c10da007-5e10-b471-56c4-c3457bedb909@redhat.com>
Date: Wed, 1 Feb 2017 21:29:32 +0100
MIME-Version: 1.0
In-Reply-To: <1485942829-10756-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u3n14tlsDQKIBDdj4DLTtCPbcinAEwkAT"
Subject: Re: [Qemu-devel] [PATCH V3 0/2] fix segfault and naming of runtime
 opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u3n14tlsDQKIBDdj4DLTtCPbcinAEwkAT
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 ashijeetacharya@gmail.com, jcody@redhat.com, armbru@redhat.com
Message-ID: <c10da007-5e10-b471-56c4-c3457bedb909@redhat.com>
Subject: Re: [PATCH V3 0/2] fix segfault and naming of runtime opts
References: <1485942829-10756-1-git-send-email-pl@kamp.de>
In-Reply-To: <1485942829-10756-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 10:53, Peter Lieven wrote:
> commit 94d6a7a accidently left the naming of runtime opts and QAPI
> scheme inconsistent. Furthermore a NULL pointer dereference resulted
> in a segfault when parsing URI parameters.
>=20
> v1->v2: Patch 1: fixed type in commit msg [Eric]
>         Patch 2: noted backwards incompatiblity with 2.8 [Eric]
> v2->v3: Patch 2: also change names in nfs_refresh_filename [Max]
>                  fix typo in commit msg [Eric]
>=20
> Peter Lieven (2):
>   block/nfs: fix NULL pointer dereference in URI parsing
>   block/nfs: fix naming of runtime opts
>=20
>  block/nfs.c | 49 +++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)

Thanks, applied to my block tree (with the spelling fix proposed by Eric)=
:

https://github.com/XanClic/qemu/commits/block

Max


--u3n14tlsDQKIBDdj4DLTtCPbcinAEwkAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSRSwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A++QH9inJDmuyIpWHadNR+qkPq4tVii06zEQw
9anzHKwpOMYsd2ZrLtC0pcUfD8ZlJGIzQRRL7TDovQTdAUvEzH8JT+fSDwJMnBQ/
0RET5spARMaVJqsOAmkQRLozbjrMY76pxE5XUc/8T4dVNdvDsXKh1IVAgFSK+z6o
HvvzivrWNvrFvsOBk2yH05R7KdWJXec2ie/GzqHAYItwn08th4l+LGZ0ujBBHMid
OHWrjoAZ9ykZAxqCT9rG0/W2aeaec1X268srzUtbNEAzme0NWGB2RL8RuQk4T+in
YDR6VeGlEOBYqL0HwZeI6kyVG+vPDPpKIdcght4aFVUIB3AlrZO00Q==
=7yQ3
-----END PGP SIGNATURE-----

--u3n14tlsDQKIBDdj4DLTtCPbcinAEwkAT--
