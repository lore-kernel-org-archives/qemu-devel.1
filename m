Received: from eggs.gnu.org ([2001:4830:134:3::10]:48955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy88-0007AR-3I
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egy87-0001Cz-DA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:33:12 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<c4ea2491c0424cfa8fe44cff177755c5599da7f2.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dd0bde53-c4ae-9cdf-7bfb-a3689334cf77@redhat.com>
Date: Wed, 31 Jan 2018 20:33:01 +0100
MIME-Version: 1.0
In-Reply-To: <c4ea2491c0424cfa8fe44cff177755c5599da7f2.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iaPPqe1tYUWftOsrUPKDVjtT93aGHcOgy"
Subject: Re: [Qemu-devel] [PATCH v3 07/39] qcow2: Remove BDS parameter from
 qcow2_cache_put()
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
--iaPPqe1tYUWftOsrUPKDVjtT93aGHcOgy
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <dd0bde53-c4ae-9cdf-7bfb-a3689334cf77@redhat.com>
Subject: Re: [PATCH v3 07/39] qcow2: Remove BDS parameter from
 qcow2_cache_put()
References: <cover.1516978645.git.berto@igalia.com>
 <c4ea2491c0424cfa8fe44cff177755c5599da7f2.1516978645.git.berto@igalia.com>
In-Reply-To: <c4ea2491c0424cfa8fe44cff177755c5599da7f2.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_idx(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c    |  2 +-
>  block/qcow2-cluster.c  | 28 ++++++++++++++--------------
>  block/qcow2-refcount.c | 30 +++++++++++++++---------------
>  block/qcow2.h          |  2 +-
>  4 files changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--iaPPqe1tYUWftOsrUPKDVjtT93aGHcOgy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGe0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADBgH/1hteqyXPDTBNfuXXpH8UlUeWIqVxq5s
smlIDE7bzeHGa5U/wqvaPtx5nhFsd2cbMn1Vk7sH/KxIh484UAfzCjXjhQJuYEhM
k/KthwhXug7r3JVNBTzFp870Sqf89BuQXkFb16L+RXAlibOw0T4FBy7Yk+NEzRwj
GsrTf1SWyRhtWNHXzy2c5cVM/PPUnPloYyQPGRxWOgn3Itznn569zWWTJ7bkl6Ve
LHnCx8lfjgjxmBDR4XfxDZxrO/HVF0ega/T5qtjdwiHI0+do+ohQwifiefYNDciC
oIgtyVV+VEM95TqLnlyLAXck8qumUeWAUBE0Ajyr9bwdHzeXhsMpT+U=
=FoK5
-----END PGP SIGNATURE-----

--iaPPqe1tYUWftOsrUPKDVjtT93aGHcOgy--
