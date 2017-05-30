Received: from eggs.gnu.org ([2001:4830:134:3::10]:42472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpQl-0004n4-TR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFpQh-0004X5-Oa
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFpQh-0004Wl-FY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 18:15:55 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d43c75e4-64f6-ec5e-ad06-be70c2bf6a97@redhat.com>
Date: Tue, 30 May 2017 17:15:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dBBVb0LoDKoHtjVE3lq1cikKMQtd92sN9"
Subject: Re: [Qemu-devel] [PATCH 09/19] nbd/server: rename rc to ret
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
--dBBVb0LoDKoHtjVE3lq1cikKMQtd92sN9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <d43c75e4-64f6-ec5e-ad06-be70c2bf6a97@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/19] nbd/server: rename rc to ret
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> For consistency use 'ret' name for saving return code everywhere
> in the file.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dBBVb0LoDKoHtjVE3lq1cikKMQtd92sN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLe8YAAoJEKeha0olJ0NqlEwH/2IH4FgXY/U2WCAfWE/OSuio
hatqkWRLDcj0j1rEysHJ4oLCLbGKRQKs9ghcFNsEIZkoXM2vgOV0mfIVwMkf15VF
JOAp8ZvjidTQZ1zCyk7bUfpSQWw5Nb0ZvfkKwTmu++ClQViFREq1QrQ5G6QRcjI9
7yFdKwb0gh/PbOPFKqLrswBl0w+Tibp6Q1iccddr0eeYgtBSqIaTB1DKT30oEUGX
liDLbcbAB5E2gojzaXa+eQYD1wrE9os9mb61bFDq80wFAVLJBiZ2kCulC7Y1NzTe
vQNhhlPzN4sS/T7E9CBb1v8HqOjQa3ou0BEtKPXMMAST8IZmWX8yw1A/nNlsqPo=
=O9UG
-----END PGP SIGNATURE-----

--dBBVb0LoDKoHtjVE3lq1cikKMQtd92sN9--
