Received: from eggs.gnu.org ([2001:4830:134:3::10]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Ts2-0006ws-V9
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Ts2-0001Nu-4L
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:49:07 -0400
References: <20170407113404.9351-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0c3fc385-0713-a2fa-7c04-998623514e6f@redhat.com>
Date: Wed, 26 Apr 2017 22:48:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170407113404.9351-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2KesV0ojX4VSCtlJqvMIpDbf4kuOuAW9d"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: improve
 convert_iteration_sectors()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2KesV0ojX4VSCtlJqvMIpDbf4kuOuAW9d
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <0c3fc385-0713-a2fa-7c04-998623514e6f@redhat.com>
Subject: Re: [PATCH] qemu-img: improve convert_iteration_sectors()
References: <20170407113404.9351-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170407113404.9351-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.04.2017 13:34, Vladimir Sementsov-Ogievskiy wrote:
> Do not do extra call to _get_block_status()
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Also, I'm not sure about last line:
> s->status =3D s->target_has_backing ? BLK_BACKING_FILE : BLK_DATA;
>=20
> (which is equal to old code)
>=20
> may be, it should be
> s->status =3D s->target_has_backing ? BLK_BACKING_FILE : BLK_ZERO;
>=20
> as it is the case, when range is not allocated at all. Should we copy i=
t in this case?

Intuitively, I don't think the else branch can happen in that case at
all. If it does, BLK_DATA will be safe, so it seems the best choice to me=
=2E

Thanks, applied to my block-next branch:

https://github.com/XanClic/qemu/commits/block-next

Max


--2KesV0ojX4VSCtlJqvMIpDbf4kuOuAW9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkBB7cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ak2QH/j2z8C2R8ddwhbeneaOxB11sgVt4bVsf
NBvAJZwQ7YVoTdpi8u6+zIqjcWBKAvmeMbrhhZkialawJD1iq/V2TXtceLL1sQjo
KuVkgMkfI8NRK3qXdWpc6ldznbu1b8xXwyLPZk4eVLOIjJmdTK9XQ+/j0AWu/Nnm
rDTNyJhf2bkWCCdPHFLZg6EDd6dOCrbFCMfKnmDoHrbnQVyPJrjugViK71YbmRvq
t2DeOS6eZL0dVFgdO2TcyEhupQb6nuXvuI8L5zQhh/X+wIEnto/1oY25oO9y+NEc
C1R/9VCeZ/7hIu1ZergJjTfg+sB0wuiGEIcx3MTTIXwqhYddr3NrKaA=
=CBfM
-----END PGP SIGNATURE-----

--2KesV0ojX4VSCtlJqvMIpDbf4kuOuAW9d--
