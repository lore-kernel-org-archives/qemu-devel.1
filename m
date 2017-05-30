Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnhw-0004eA-As
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnht-0003Kz-2V
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFnhs-0003Kt-QQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:25:33 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14be5f9a-21ca-734b-9977-7db0b2d45fe1@redhat.com>
Date: Tue, 30 May 2017 15:25:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OO2KUj9caxaNWqr5eUQXtMNSTh58B1LfF"
Subject: Re: [Qemu-devel] [PATCH 03/19] nbd/server: refactor
 nbd_co_send_reply
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
--OO2KUj9caxaNWqr5eUQXtMNSTh58B1LfF
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <14be5f9a-21ca-734b-9977-7db0b2d45fe1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/19] nbd/server: refactor nbd_co_send_reply
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> As write_sync never returns value > 0, we can get rid of extra ret.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OO2KUj9caxaNWqr5eUQXtMNSTh58B1LfF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLdU6AAoJEKeha0olJ0Nqr54H/228FbkO3p80UxaPlujJyqsY
nN3tRIaKJNsUVDy9Vy/XuNPD6/aH+eEmgPMdawfIooUBH+lyq9h7neqx5YWzneYT
0gO9JIDYZmBIOGVQftWR26ERqNhQxZeuOG+ENuRJpCzB4MoZ9uaFMRPIuwJ/M6jy
of98sA8lWtj9Onz0U1oltkewSpwAMFRGVQkZIZtxo4a6TTSNb4tbjVVgTwmAP+aK
bT3JYR4jdncMN6qDyr8l85yUbBHHZDoicq36IsI4iv4UFSwUdWOJQ3w/zsermkeZ
1me5aZ08UyHW6uITYrzrcoUaswWbwCoOUEdLYf99QerF2ys3hqWkpcQ7u7tB5fs=
=v2uJ
-----END PGP SIGNATURE-----

--OO2KUj9caxaNWqr5eUQXtMNSTh58B1LfF--
