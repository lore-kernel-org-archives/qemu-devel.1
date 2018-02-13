Received: from eggs.gnu.org ([2001:4830:134:3::10]:36583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elbtl-0006d9-Os
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elbtk-0001mn-O8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:49:33 -0500
References: <cover.1517840876.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5fb0140a-5f5d-fcff-1df5-714d6c797099@redhat.com>
Date: Tue, 13 Feb 2018 15:49:23 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tFSCOcrmhUZKFP5XSSUSbcLfCFoiDEJrA"
Subject: Re: [Qemu-devel] [PATCH v4 00/39] Allow configuring the qcow2 L2
 cache entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFSCOcrmhUZKFP5XSSUSbcLfCFoiDEJrA
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <5fb0140a-5f5d-fcff-1df5-714d6c797099@redhat.com>
Subject: Re: [PATCH v4 00/39] Allow configuring the qcow2 L2 cache entry size
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 15:33, Alberto Garcia wrote:
> this is the new revision of the patch series to allow configuring the
> entry size of the qcow2 L2 cache. Follow this link for the full
> description from the first version:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html
>=20
> And here are some numbers showing the performance improvements:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html
>=20
> Regards,
>=20
> Berto

Thanks, applied to my block branch
(with s/intead/instead/ and s/=3D300/=3D4242/):

https://github.com/XanClic/qemu/commits/block

Max


--tFSCOcrmhUZKFP5XSSUSbcLfCFoiDEJrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqC+vMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APLAH/ig7vq5s9efh5Nd/yueXrutmQEmF4+KR
yFDPurYTF2awF2HS3rUZzK6RMw9JHO9xiYsf305he3zLhOS6Ka0ZPoGAU5I1pz6+
i+A4nlkyRYP1QnJtSFSudphQWN3kUsWtLnNZt2ClbseMAYncMLyHwJgr4NYfFQsG
fAqDiuSgha6p66VOWdbI2E5Nv91Mie3ijCQcEixDXGdmXXlyOVNT72UyYdRu7xbv
AbooW2dp6cweQj+9BenaxxMYiA28EpzBxyAlH1WgKdrHI/ZwcVoy7NpnXmulSnY3
wxw/S5N72oxbOlu8JzaANoRBnPC3QWfuH9PdnMAke/FD9EII9jfZ3kM=
=4GFl
-----END PGP SIGNATURE-----

--tFSCOcrmhUZKFP5XSSUSbcLfCFoiDEJrA--
