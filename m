Received: from eggs.gnu.org ([2001:4830:134:3::10]:51095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyk9p-0002ly-P2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyk9o-0007aL-M6
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:11:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cyk9o-0007Zs-GS
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:11:52 -0400
References: <1491405505-31620-1-git-send-email-den@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c6f2e558-87a6-50a4-cd42-f307b769e2a0@redhat.com>
Date: Thu, 13 Apr 2017 21:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <1491405505-31620-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lLKRR3IMRE8xmCnn3u1bDOIJKElJOrMFW"
Subject: Re: [Qemu-devel] [PATCH for 2.10 0/2] block: simple changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lLKRR3IMRE8xmCnn3u1bDOIJKElJOrMFW
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <c6f2e558-87a6-50a4-cd42-f307b769e2a0@redhat.com>
Subject: Re: [PATCH for 2.10 0/2] block: simple changes
References: <1491405505-31620-1-git-send-email-den@openvz.org>
In-Reply-To: <1491405505-31620-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.2017 17:18, Denis V. Lunev wrote:
> First patch here is one we have agreed on during the initial discussion=

> about truncate() in parallels format driver, another one is simple
> coding style change spotted by my student.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
>=20
> Denis V. Lunev (1):
>   block: assert no image modification under BDRV_O_INACTIVE
>=20
> Klim Kireev (1):
>   block: fix obvious coding style mitakes in block_int.h
>=20
>  block.c                   | 2 ++
>  include/block/block_int.h | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)

Thanks, fixed the subject of the first patch and applied to my
block-next branch:

https://github.com/XanClic/qemu/commits/block-next

Max


--lLKRR3IMRE8xmCnn3u1bDOIJKElJOrMFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljvzXUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASggIAKQ5/VN84v84MNzR3JD2prmF03MAzAHu
0FZDjdHOTqbCYkrIee5jafchOPpgmwdSLsXzR5sirOv2QqVSAg551CKGbkCS+egd
5ZtHurn6bn4vuRG6EOI9JYaW/0cPaoH2rLd1SGIjBmPIfYU92sPVVSnP/iPQOs48
Rak0d1e5o3/Zsbg1bw4YX/VQzzbxUCE/bkU46yQiL/UILKbzOEjHZGhoraAMA0Z1
Jux+kCd4IgMsaK17VSDU5luXkI/5w2+fpt4BvMczuAUZ0ec56Si2FGYaAL8JScDl
YgpXbjnXmGPIy6KggL+/JSRyeJNMXgqu2dtnR6vSLbwjM9bqI9yHUkE=
=ZWBF
-----END PGP SIGNATURE-----

--lLKRR3IMRE8xmCnn3u1bDOIJKElJOrMFW--
