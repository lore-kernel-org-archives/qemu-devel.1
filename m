Received: from eggs.gnu.org ([2001:4830:134:3::10]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW1nh-0007xR-4A
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW1ng-00060v-7J
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:42:37 -0400
References: <20170714143548.32559-1-el13635@mail.ntua.gr>
	<20170714143548.32559-2-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <886a2d3b-5ec0-9464-8b7c-1590fd69b9c1@redhat.com>
Date: Fri, 14 Jul 2017 09:42:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170714143548.32559-2-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HRt95pvcqH4RMQHbUkt4tSXAJgtn1Vb7O"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] block: fix dangling
 bs->explicit_options in block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HRt95pvcqH4RMQHbUkt4tSXAJgtn1Vb7O
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <886a2d3b-5ec0-9464-8b7c-1590fd69b9c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] block: fix dangling
 bs->explicit_options in block.c
References: <20170714143548.32559-1-el13635@mail.ntua.gr>
 <20170714143548.32559-2-el13635@mail.ntua.gr>
In-Reply-To: <20170714143548.32559-2-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 09:35 AM, Manos Pitsidianakis wrote:
> In some error paths it is possible to QDECREF a freed dangling
> explicit_options, resulting in a heap overflow crash.  For example
> bdrv_open_inherit()'s fail unrefs it, then calls bdrv_unref which calls=

> bdrv_close which also unrefs it.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Can you pinpoint which commit introduced the bug, in order to decide if
this affects 2.9 and should therefore be cc'd to qemu-stable?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HRt95pvcqH4RMQHbUkt4tSXAJgtn1Vb7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaNhOAAoJEKeha0olJ0NqbdkH/3QR46p161vroX5S2bYjnq18
KZZOg3929xqqkueL9eo0dKr2EJ93Bh//4SaUT5xPpGPn3GGUguML5Lz+fTrFQjXO
7srLaB5vNGGNyF8ILkMAU+kGR351nKTdJ9DYtZJYUrnDQP2wfzxZY787oWmTanHs
N2tQb3U0agvSNrzVXGT0clS+Gu642/7K/scaq8K6noILNUpFjGbS6w3jXTd4i1Bx
ScpEJmep1Fc2MSccE3tjRVwtNQKrM+glwwMy1Ac07nPvJYSgQcM/lbKBDveg+qK3
o6Sl8zfqbMx/4cDNIBDcTin++7SotmkaXizl+7pSpFTs3RYm0Ofqk52fRVLaqec=
=o6Rb
-----END PGP SIGNATURE-----

--HRt95pvcqH4RMQHbUkt4tSXAJgtn1Vb7O--
