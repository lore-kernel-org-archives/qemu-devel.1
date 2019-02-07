Received: from eggs.gnu.org ([209.51.188.92]:48153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlPN-0007rT-KY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlPN-0006qi-2m
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:16:09 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31b23e95-179a-d757-53a5-65939065f3cf@redhat.com>
Date: Thu, 7 Feb 2019 09:15:50 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BN2EGL8IlJxMaf9TpHgEfJIM7tdDL90AM"
Subject: Re: [Qemu-devel] [PATCH v3 09/17] block/qcow2: use
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
--BN2EGL8IlJxMaf9TpHgEfJIM7tdDL90AM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <31b23e95-179a-d757-53a5-65939065f3cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/17] block/qcow2: use
 qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-10-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BN2EGL8IlJxMaf9TpHgEfJIM7tdDL90AM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcS6YACgkQp6FrSiUn
Q2qZVwgApiVQPic0weYxuEeIn9xeokQE62ciDSQG+drC2YcGE82dWWtu53Bu1zbY
RrdsqFR6q24g8bMpSLD00Zp8o3Zl0cF9uXo7wFhXSVnAi0TUt3QlElIiERuUDg8+
0q9YskAmh3NYa+vjp5dl3RsPS5JRiCHPFLHE7bgojdT9hzsJjKAGaMnmVnWC7lo1
CQX1E0+kR38YE9euirz5+dYdAFHvmC4eNaoJ79Sbn89yeEQdUpAYX73ajYk5Ru8u
P1LDXmYF2fxByoUEDcN+057D4Ce/bL1To1WuI1Ru9HfbzuWmtltagitL2Eb3JoJ0
v+7IyW5jINFrabLAT0wdYNhRoxJy2g==
=iSf8
-----END PGP SIGNATURE-----

--BN2EGL8IlJxMaf9TpHgEfJIM7tdDL90AM--
