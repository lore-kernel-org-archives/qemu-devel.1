Received: from eggs.gnu.org ([2001:4830:134:3::10]:50607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecIu0-0003Sv-1Y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecItz-00039K-1h
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:43:20 -0500
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
	<20180118181123.37056-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b78ed017-a01d-2e03-e998-e99c4d5c1f57@redhat.com>
Date: Thu, 18 Jan 2018 16:43:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180118181123.37056-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7eQg22hJLc73Tcbm0aNUFyHp8Y1ngmVbV"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7eQg22hJLc73Tcbm0aNUFyHp8Y1ngmVbV
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <b78ed017-a01d-2e03-e998-e99c4d5c1f57@redhat.com>
Subject: Re: [PATCH v2 6/6] iotest 201: new test for qmp nbd-server-remove
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
 <20180118181123.37056-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180118181123.37056-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/201     | 159 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/201.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 165 insertions(+)
>  create mode 100644 tests/qemu-iotests/201
>  create mode 100644 tests/qemu-iotests/201.out
>=20

> +
> +    def assertExistingClients(self, result):
> +        self.assert_qmp(result, 'error/desc',
> +                        "NBD export 'exp' has 1 active connection. To =
force "
> +                        "remove it (and hard disconnect clients) use "=

> +                        "mode=3D'hard'")

Needs tweaking if we massage the error message earlier in the series.

I'm still worried that this test may fail spuriously due to a hard-coded
port, but some testing is better than none, and if the CI engines don't
immediately reject it, whoever first encounters it will be nice and let
us know.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7eQg22hJLc73Tcbm0aNUFyHp8Y1ngmVbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphIv4ACgkQp6FrSiUn
Q2oO0QgAmWHDhN+lcnngfAk3NhSAIhHMHZSxiDRW2ek6cJrjJWW2eZkOpTc9S4M5
J7paJKv76M1IyYX4Hd1RkLRCxhKqjTQhLA6jq4q9LYPGSvFh04uHbF8TnZuXWLXa
Pgim20eVK5MN18Sa1ZK2k2NlmCwz0V5+hEN1t9HCi6DyHjPc3OCe6PFAm27GppAB
ou3zB7cn9sbuKJuWddtFU4I9hp69zclVXntsTkFmrB4plbrvfZFMmdSo3uXs2OVd
1za6aflOPAzYm+FRAOdqvjNW5tgRUje1veq8DTs+jg+3tU6c61xT2N7tb0jCHM5g
k3d3PxciN4k2H2yxGhF6xiBFYEnqcQ==
=anYr
-----END PGP SIGNATURE-----

--7eQg22hJLc73Tcbm0aNUFyHp8Y1ngmVbV--
