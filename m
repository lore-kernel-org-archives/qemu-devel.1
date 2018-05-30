Received: from eggs.gnu.org ([2001:4830:134:3::10]:60502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO04d-0003Qb-5s
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO04c-0003i0-Cb
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:19:27 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-5-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <94f47dcc-bbe8-882f-0dda-85a406fb714a@redhat.com>
Date: Wed, 30 May 2018 14:19:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-5-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a6rcBDyYhHzn31niqKXSdMtyvbCuhmQJO"
Subject: Re: [Qemu-devel] [PATCH 04/17] iotest 030: skip quorum test
 setup/teardown too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a6rcBDyYhHzn31niqKXSdMtyvbCuhmQJO
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <94f47dcc-bbe8-882f-0dda-85a406fb714a@redhat.com>
Subject: Re: [PATCH 04/17] iotest 030: skip quorum test setup/teardown too
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-5-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-5-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> If quorum driver is not enabled, test 030 skips the corresponding
> testcase.  This, however, is insufficient: quorum is first used in the
> testsuite's setUp.
>=20
> To avoid erroring out here, skip setUp/tearDown, too.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/030 | 6 ++++++
>  1 file changed, 6 insertions(+)

Not sure if there is any nicer way of doing this, but:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--a6rcBDyYhHzn31niqKXSdMtyvbCuhmQJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOlsIACgkQ9AfbAGHV
z0DtzwgAkLyQdCaKrbm16C0GjmFqhC2RdYNZQ5ET8b18xoIxTotlUlCKl02DHDbc
x1A8UcxCsQZ2RFfzKD5RXGg18K7Le1B3Hn8ug4QvFGQm0jo9XfcVgAmLxRU+KVuX
17oifdT2U4fM6rBfFTe/LgTYMXz42EMD9KkK7vypaJ+5ga+gTemx71OKQv68c8+4
0zGaZ9cRpq9BDpl5Inr5yljiF6nJFfDBmuRSM8CSyTVO19o5rb3g2hm0l5j5fzW9
26aYMx8rKGx3W8rYOFxVcYktQ9n2q0OkYUEsEfWO84BhkOyOzig4hwL7VJGn+76L
bECea59nUhPgooeNqgVfDzKRQ8L37g==
=FHlP
-----END PGP SIGNATURE-----

--a6rcBDyYhHzn31niqKXSdMtyvbCuhmQJO--
