Received: from eggs.gnu.org ([2001:4830:134:3::10]:35650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIMdT-0000uL-1H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIMdS-0004t0-6Y
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:12:06 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-42-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc7740cc-4ee4-cbc8-2c84-bbad4c0ae593@redhat.com>
Date: Tue, 15 May 2018 01:11:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-42-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pVw0DDi9XYEZHd2jjJAPOsCKfoL6nPvao"
Subject: Re: [Qemu-devel] [PATCH 41/42] iotests: Move qmp_to_opts() to VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pVw0DDi9XYEZHd2jjJAPOsCKfoL6nPvao
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <dc7740cc-4ee4-cbc8-2c84-bbad4c0ae593@redhat.com>
Subject: Re: [PATCH 41/42] iotests: Move qmp_to_opts() to VM
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-42-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-42-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> qmp_to_opts() used to be a method of QMPTestCase, but recently we
> started to add more Python test cases that don't make use of
> QMPTestCase. In order to make the method usable there, move it to VM.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/041        |  6 +++---
>  tests/qemu-iotests/155        |  2 +-
>  tests/qemu-iotests/iotests.py | 45 ++++++++++++++++++++++-------------=
--------
>  3 files changed, 27 insertions(+), 26 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--pVw0DDi9XYEZHd2jjJAPOsCKfoL6nPvao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6F70ACgkQ9AfbAGHV
z0D57Qf/YcPQFBsVSjD6Xdu5VQim7ll/12VqyJFymxaWi4pY0d2rA/baT/LK0oJL
z8hn/wjpSD4C89eXwgKw6eq9Borum5BzRpSn2P3+vZ2rr0U7EBYrePIAWHAOGIP0
jBQKIBDb2en69Flm3IEODCmTVGI2uwuuRr+56pkt9gjCz0ysPbMF+/E2UclQTocn
v3JJHePO6+/yuuZ4SGBixdZ6j3qGlaYaoAoIh1RUh+VUv8tBZN1dkVXZyse9mRAP
vsAB2fn+2Pac5wR5Tg0ev/C0zZ2UiN5Iwo5om7jvp2t9OSQdsSEmcEXvbBAABhba
cSGdP8dqUKGF+KpvNGHSJBP+2TwA+w==
=Mu8v
-----END PGP SIGNATURE-----

--pVw0DDi9XYEZHd2jjJAPOsCKfoL6nPvao--
