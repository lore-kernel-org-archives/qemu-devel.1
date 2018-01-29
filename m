Received: from eggs.gnu.org ([2001:4830:134:3::10]:57581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFac-0002Tv-RS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egFac-0006Ed-5G
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:59:38 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-8-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c551b293-3966-6003-686f-43b2a60190b6@redhat.com>
Date: Mon, 29 Jan 2018 20:59:28 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-8-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jCGB59oUgOVD9BaqdxneIJK2m2qEoU7K8"
Subject: Re: [Qemu-devel] [PATCH v7 7/9] qcow2: move is_zero() up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jCGB59oUgOVD9BaqdxneIJK2m2qEoU7K8
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <c551b293-3966-6003-686f-43b2a60190b6@redhat.com>
Subject: Re: [PATCH v7 7/9] qcow2: move is_zero() up
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-8-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:49, Anton Nefedov wrote:
> To be used in the following commit without a forward declaration.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jCGB59oUgOVD9BaqdxneIJK2m2qEoU7K8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvfSASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhV0H/j/7tzz9f+ZE91mz++EWwM1x6ZlPSYma
/WSnR78ULKqH2quq43qdGTXueUtSH6f/eL9+N0GbB9myoYW/ofazfWgPUn/XFs7b
FKR3f0vUzFbkWMy6Z1HaiwPNLPiQ/HM80abyD1Xzo5ZZcb2hKkzOhMBGOBNChWCv
GTnxkcHwVEUEWD1t+kHTq4mmJElsCeE7SY+xkuKmDrGFj7E8Dkg0lBndDEh9pKj7
eTxyAawczOiBcdmtFDj6HAH8bWvCRUw58RghaD+M6u7l6E1Nxv41ErreX18NWA2f
fhXPkfyWykQTuaoMBcUlJZAFyZ1JguVr3bBMivmANA9jvUZ1YeJCupc=
=i1l8
-----END PGP SIGNATURE-----

--jCGB59oUgOVD9BaqdxneIJK2m2qEoU7K8--
