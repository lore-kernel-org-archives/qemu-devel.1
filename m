Received: from eggs.gnu.org ([209.51.188.92]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlSn-0001HC-Sb
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlSl-0008Ck-HO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:19:41 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae162b8f-03e1-7537-255a-ec370579ba4e@redhat.com>
Date: Thu, 7 Feb 2019 09:19:17 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nc5fnKV6alzcBFXFKeMVhbgZFGjqo2zOF"
Subject: Re: [Qemu-devel] [PATCH v3 11/17] block/vmdk: use
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
--nc5fnKV6alzcBFXFKeMVhbgZFGjqo2zOF
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <ae162b8f-03e1-7537-255a-ec370579ba4e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/17] block/vmdk: use qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-12-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/vmdk.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nc5fnKV6alzcBFXFKeMVhbgZFGjqo2zOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcTHYACgkQp6FrSiUn
Q2o2iQf+OF4EhM9bikD67ip6lwgufID7gjU2z/2v8fa6He2yZWLpdVyymu+DgW7C
fK6lAO4pSQNEk+dBsoCNzD6Lk3BYKkgA1RGVlmnUhkDvnLn/uph9s4HafwkrbvK9
kLYDw23p8D+E+GRiMIvpLUvxDp0rFiekBH8wtDuFqh4FYUktcgd7c+yU9IUnEJqA
MFzSUcXngcWg+C9eLmF+pVZLg8gL+FHSijap3Kshh+fsx9ktqAp+hdIbO5jb4DZE
Nc49HMigL0hDYLfNVd0x7dQy/317LslF4K5wnsLIHNZ7h2ycvO1wghdMDcovQfqd
dxv0kcVLbNEwkyGmcunDXpK01LUQMg==
=kQiG
-----END PGP SIGNATURE-----

--nc5fnKV6alzcBFXFKeMVhbgZFGjqo2zOF--
