Received: from eggs.gnu.org ([209.51.188.92]:57246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmKAy-0001G8-Kt
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmKAx-0001Ew-2J
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:10:48 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cc018a7-beab-915d-ca4b-561e80c0925a@redhat.com>
Date: Wed, 23 Jan 2019 09:10:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Eory5xiQqoZ1lT8NCN2KKs5fpUqdKXdej"
Subject: Re: [Qemu-devel] [PATCH 2/9] iotests: Remove superfluous rm from 232
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Eory5xiQqoZ1lT8NCN2KKs5fpUqdKXdej
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <9cc018a7-beab-915d-ca4b-561e80c0925a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] iotests: Remove superfluous rm from 232
References: <20190123144610.8842-1-mreitz@redhat.com>
 <20190123144610.8842-3-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 8:46 AM, Max Reitz wrote:
> This test creates no such file.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/232 | 1 -
>  1 file changed, 1 deletion(-)

I'd really like it if we could revive Jeff's patches that made ./check
run all tests in their own subdirectory, and then where the framework
could either keep all temporary files or remove the directory, rather
than each test having to track which files it touches.

But that's a bigger task; in the meantime, this patch is fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Eory5xiQqoZ1lT8NCN2KKs5fpUqdKXdej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIg+8ACgkQp6FrSiUn
Q2olWQgAl75dG9goxIblq7Y07I5PFriSCB7WNFjIGRsxHtsWG8XYVwN2YG9dePrv
9czT4uIWq5vQgbiH237cI0EZMghGG69BLJnscajeniWcnzPVj5IxOq+vCJ/aVztp
TJKybNXe60LOka/X4WIXIvhA2HTyyWu/FJ5Dd5W+O8btE+G/4LGun+Sw+gl9pcBD
jEi4Gjjw1281+2TEmWuQ1Ylak69jJeGe3raon/qULrpEJdAFxG1fo3jvX4qXlZKz
6MAPA8v4Lz8OzD5NLYSgFG4X1+rVlT7HNyPBS3IYTWFQY1s4uqHjzR1wEoLpgW1S
TedPxuLyj8DvhugX/C/WahHjkbyevA==
=DN/r
-----END PGP SIGNATURE-----

--Eory5xiQqoZ1lT8NCN2KKs5fpUqdKXdej--
