Received: from eggs.gnu.org ([2001:4830:134:3::10]:55818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gShzk-0000xZ-1o
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gShzj-0001r1-8A
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:34:07 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f650fd81-f2a0-dd20-c35b-17a59e61e509@redhat.com>
Date: Fri, 30 Nov 2018 13:33:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181129101801.6421-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YXL3G628wEahAYzdA7G5DWydM1jLiipWF"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YXL3G628wEahAYzdA7G5DWydM1jLiipWF
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org
Message-ID: <f650fd81-f2a0-dd20-c35b-17a59e61e509@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: simple mirror test with kvm on 1G image
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <20181129101801.6421-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181129101801.6421-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
> This test is broken without previous commit fixing dead-lock in mirror.=

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/235     | 59 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/235.out |  1 +
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 61 insertions(+)
>  create mode 100755 tests/qemu-iotests/235
>  create mode 100644 tests/qemu-iotests/235.out

[...]

> diff --git a/tests/qemu-iotests/235.out b/tests/qemu-iotests/235.out
> new file mode 100644
> index 0000000000..d6ccbad8fa
> --- /dev/null
> +++ b/tests/qemu-iotests/235.out
> @@ -0,0 +1 @@
> +{u'return': {}}
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 8c56a0ad11..61a6d98ebd 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -232,3 +232,4 @@
>  232 auto quick
>  233 auto quick
>  234 auto quick migration
> +235 auto quick

Oh, and I don't really think this test belongs into the quick group.
Even if it is quick (depending on your hardware), it writes so much data
that I wouldn't put it there.

Max


--YXL3G628wEahAYzdA7G5DWydM1jLiipWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBLjEACgkQ9AfbAGHV
z0CAQwf/aqgfCnUA9Qfk6eym66U6v3mvWsAiLlkBkWGQ16gL2E5W1ycBnVZd2WxL
WQgRTJ76HLWD096sbzCNyt9F3Sbcvbcuz1RyK7TC6YNZQ/rAcoIfPU6YHNPmlAto
qV7lb4+up2dmOotqWKl64jLvyUbN7VKTtoAaOMG5/EABkPriMeclj3ZWt0auCsPO
hOlZbRzsAc4A/OrzFH9ouBo8VwcjIYtnaNkL0wpc+yhrhYebFD6UaBxU4HPGArRi
lDBecX/xpnOAhSmwBlJDv2i25z2VvcIrzBQsSzHXLtY56LvekBNg3NRZvS+P6Nkj
5siLrzfFvZbP9RjIcz5bFGC/cFKjrQ==
=XWmv
-----END PGP SIGNATURE-----

--YXL3G628wEahAYzdA7G5DWydM1jLiipWF--
