Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG8eW-0004aZ-68
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG8eT-0003kr-3H
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dG8eS-0003kZ-R5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:47:25 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7d0b7f3-038a-0cc1-ce0f-c27e02e74dd3@redhat.com>
Date: Wed, 31 May 2017 13:47:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170531165541.47338-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VMV9LeBSD7IXxWAq1gKH1urm8x18Ra88C"
Subject: Re: [Qemu-devel] [PATCH 02/12] nbd: make nbd_drop public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VMV9LeBSD7IXxWAq1gKH1urm8x18Ra88C
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <d7d0b7f3-038a-0cc1-ce0f-c27e02e74dd3@redhat.com>
Subject: Re: [PATCH 02/12] nbd: make nbd_drop public
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
 <20170531165541.47338-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170531165541.47338-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 11:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> Following commit will reuse it for nbd server too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c       | 26 --------------------------
>  nbd/common.c       | 26 ++++++++++++++++++++++++++
>  nbd/nbd-internal.h |  2 ++
>  3 files changed, 28 insertions(+), 26 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VMV9LeBSD7IXxWAq1gKH1urm8x18Ra88C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLw+6AAoJEKeha0olJ0NqbbAH/icIu8r0l6C1FfIUO3RkhBIT
HA5aDQYLh+OoKnWqFaLLoa9NAUfjr99FXivDCDfDCUKDFvzg7vs1HQKcWMY812Q9
v8ckpVn/QYf+waWW8R5qAD8EQxzsw4iMaDaCEfKZ+p79g0J6cyGmYTH62FIkcp6g
2JPLSVXEJkLS0CNPtK40siBiHzsLxRL6Dd8b6lqsYgEBmisdYPunOVLPN336p9E8
H6k6SKTh4Dyl8Eco3dGJ6/hZNwiydxEjS7+jRMDnfCDby/Bndt0QTEUisfvDYWI/
gx2EOFO74cEeny5AmrFBOrpNetXNE8gQ42qgMhojRebM5MeAoOXFZ6pMnuWJrH4=
=o3IG
-----END PGP SIGNATURE-----

--VMV9LeBSD7IXxWAq1gKH1urm8x18Ra88C--
