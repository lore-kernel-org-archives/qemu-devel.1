Received: from eggs.gnu.org ([209.51.188.92]:47614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlNI-00062h-Gt
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlNH-0005Fv-RQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:14:00 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9aefe465-8652-0806-300b-3c711c52cf62@redhat.com>
Date: Thu, 7 Feb 2019 09:13:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a4PwmXF4vddcGGddrDYrvrFXtIx8LBORX"
Subject: Re: [Qemu-devel] [PATCH v3 08/17] block/qcow: use
 qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a4PwmXF4vddcGGddrDYrvrFXtIx8LBORX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <9aefe465-8652-0806-300b-3c711c52cf62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/17] block/qcow: use qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-9-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--a4PwmXF4vddcGGddrDYrvrFXtIx8LBORX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcSyMACgkQp6FrSiUn
Q2qa3Qf+JMXGeCi4WVM4EhuNQajaDavcfVsCyDnG0k7yobFHUMToHGoQA335rXRQ
Aom1FwLutWSGP+Rit2eEbShoHtB8G1d1wHpkf92JXtwJ6S1jq4cm2LIDusjZnEwg
nvJqohvRPmhtD1m8Q15Z5+4/0NUg0CXr2iJVZFw7x5JoLWYtoKeVIHGFgOr7xBcr
OkuBq8GfNkNHYAceZNZ0PUzW/zKlcq+8/a9w9/R9DI3vb8QPhwCn6gOwqPVhBVVt
aw5MPBJ9nYt+O8oDzb6uMlo8bBjlOUinthrPo3vqU0ON9SMvKz+FNkWvVslhgCD0
Adv9SqCY3vmAXAB1B4IBN1txrST1vw==
=bgGW
-----END PGP SIGNATURE-----

--a4PwmXF4vddcGGddrDYrvrFXtIx8LBORX--
