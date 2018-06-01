Received: from eggs.gnu.org ([2001:4830:134:3::10]:38584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOjIb-000387-QH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOjIa-00039N-O2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:36:53 -0400
References: <20180601115923.17159-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f213cf47-2145-b108-f3da-bc5c135963b1@redhat.com>
Date: Fri, 1 Jun 2018 14:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180601115923.17159-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="01KLzWkck9MSrQeN5TWmJMou4AJyzXC8t"
Subject: Re: [Qemu-devel] [PATCH] iotests: improve pause_job
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
--01KLzWkck9MSrQeN5TWmJMou4AJyzXC8t
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <f213cf47-2145-b108-f3da-bc5c135963b1@redhat.com>
Subject: Re: [PATCH] iotests: improve pause_job
References: <20180601115923.17159-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180601115923.17159-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-01 13:59, Vladimir Sementsov-Ogievskiy wrote:
> It's possible, that job was finished during waiting. In this case we
> will see error message "Timeout waiting for job to pause" which is not
> very informative. So, let's check during waiting iteration that the job=

> exists.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--01KLzWkck9MSrQeN5TWmJMou4AJyzXC8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRPdwACgkQ9AfbAGHV
z0AZGwf/QVjuCNf+3uQBpzT1yztXmWEpNxDd15i+cKpS1skMUC+d66LkaFwUNxX5
W3qraJPXgnYKF47OQo57jRdp838apL5xzFBGubAW5xd3c14qWumOQ7Si5OeA3Ah4
j0olmwn1V7Ihed+tP2TBUdp1KlqCaJDMsOAFdfiPypVWG8fsKfTu8l7Xjho2pvvR
61Ftgfl4iEwNLUYr2t8TgtEWm9m4SL+OxOKkv6NvzrFQdzWnn5TPKE35OeMoiGUp
cyWFSCgq0/wqAZwIVIyKqJI7J19x4cZXWT4xm+f0z5l/MIEBxBfkOP7eRlM9cBgJ
5vPZDYNR7Xw1CmApqBkX7Pb1iCdgnQ==
=MQe2
-----END PGP SIGNATURE-----

--01KLzWkck9MSrQeN5TWmJMou4AJyzXC8t--
