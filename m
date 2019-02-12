Received: from eggs.gnu.org ([209.51.188.92]:47118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gteZI-0007XK-UE
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gteZH-0001q3-TF
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:22:12 -0500
References: <20190212200750.27521-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44d4452d-8b94-205a-dc28-c617be80c29c@redhat.com>
Date: Tue, 12 Feb 2019 14:16:49 -0600
MIME-Version: 1.0
In-Reply-To: <20190212200750.27521-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Uh7Tc7Duul9tbAnVpnd6X0tN0RI3jI7B"
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Uh7Tc7Duul9tbAnVpnd6X0tN0RI3jI7B
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <44d4452d-8b94-205a-dc28-c617be80c29c@redhat.com>
Subject: Re: [PATCH v2] blockdev: acquire aio_context for bitmap add/remove
References: <20190212200750.27521-1-jsnow@redhat.com>
In-Reply-To: <20190212200750.27521-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/12/19 2:07 PM, John Snow wrote:
> When bitmaps are persistent, they may incur a disk read or write when b=
itmaps
> are added or removed. For configurations like virtio-dataplane, failing=
 to
> acquire this lock will abort QEMU when disk IO occurs.
>=20
> We used to acquire aio_context as part of the bitmap lookup, so re-intr=
oduce
> the lock for just the cases that have an IO penalty.

It would be nice to call out which commit id dropped the aio_context
acquisition during bitmap lookup (making it easier to analyze how long
this has broken, and which downstream builds need the backport.

>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1672010
> Reported-By: Aihua Liang <aliang@redhat.com>
> ---
>  blockdev.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5Uh7Tc7Duul9tbAnVpnd6X0tN0RI3jI7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjKbEACgkQp6FrSiUn
Q2oitwf/Zy886LYeqj/8rv2TPUvrDDKKve2eCzEE5wdeSEuJ1PLog9Qz5qqwIIux
sqbiLe3sa4l4SDylGxPCJmcvQ7k6zZmh/oy9EO0VzsvUniSkIaQ2pNk7JLtdu+bP
o3IhE0iEcxFDQ3h0OA+ZZxGGCPLpp1QUUKkNqxRb6VsyFT6jCZ927BnNmwPL/9KJ
/hxu+XxyeL+8+x6JW7WkbPW4JrGwAu5l5q5wGYWg7AIEfx3aNxhUA+pf+QUSiBSW
szXq0k+qnFCdWYkFvgm+zp+1/VXl9uoGUsyhQFyeB/w7I7TfK679NKli+Upv9+MV
77gy8/5Yf23vTUblWgDvzNBLrN5GnQ==
=x1ef
-----END PGP SIGNATURE-----

--5Uh7Tc7Duul9tbAnVpnd6X0tN0RI3jI7B--
