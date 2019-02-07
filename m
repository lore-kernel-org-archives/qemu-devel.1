Received: from eggs.gnu.org ([209.51.188.92]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlTj-00020o-AP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlTi-0000S2-JT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:20:39 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-13-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28042421-0eba-1412-ccb3-058069cc7cf5@redhat.com>
Date: Thu, 7 Feb 2019 09:20:03 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-13-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O47Ll5Hgpjh3wPLRCMg9kAIm9QjKjK5Ft"
Subject: Re: [Qemu-devel] [PATCH v3 12/17] qemu-img: use qemu_iovec_init_buf
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
--O47Ll5Hgpjh3wPLRCMg9kAIm9QjKjK5Ft
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <28042421-0eba-1412-ccb3-058069cc7cf5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/17] qemu-img: use qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-13-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qemu-img.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--O47Ll5Hgpjh3wPLRCMg9kAIm9QjKjK5Ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcTKMACgkQp6FrSiUn
Q2rKIwf+PJBrbUQaZM5R1QLLi+1Gw8Q9NtjJ16frFievlldYDK6mehzpjf054mDt
Uugx79/dGgwO3eOCawIlG7nUlwevp21tcuVpoiNR8dGiL/7IuCfr8rkKG2h4wTzi
DNidporqFz9fzjeQRTQikqsNCN2rA5wJDfrIs55mTMkw0qUJ8DXUPzhdqEE+2KJN
rYU6Gf4fS+GasftgiU1sjEC5ydzUHjdKQVnUILJFJERhRFiFlq+vRGUR2DMhmPmm
UuW3BmZEzXuf6Vh2xMk2hxSEXanBjKNcs+ayCOTqtKBnJv0AonqZA9QDhEQeSFDA
5ntGUPO8Cu6GuOKM2z4GrsLXP4obIg==
=AyUc
-----END PGP SIGNATURE-----

--O47Ll5Hgpjh3wPLRCMg9kAIm9QjKjK5Ft--
