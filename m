Received: from eggs.gnu.org ([2001:4830:134:3::10]:44392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVP5-0000vY-8z
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVP1-0008LJ-Vk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVP1-0008Ke-Mg
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:42:43 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a85d5193-e500-d798-7048-d35701d4caa6@redhat.com>
Date: Fri, 7 Jul 2017 10:42:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s52G3eDKb9Hb0qvNGw6nWHI93kSHtdBIo"
Subject: Re: [Qemu-devel] [PATCH v3 02/10] nbd/server: refactor nbd_negotiate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s52G3eDKb9Hb0qvNGw6nWHI93kSHtdBIo
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <a85d5193-e500-d798-7048-d35701d4caa6@redhat.com>
Subject: Re: [PATCH v3 02/10] nbd/server: refactor nbd_negotiate
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Combine two successive "if (oldStyle) {...} else {...}" into one.
>=20
> Block "if (client->tlscreds)" under "if (oldStyle)" is unreachable,
> as we have "oldStyle =3D client->exp !=3D NULL && !client->tlscreds;".
> So, delete this block.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s52G3eDKb9Hb0qvNGw6nWHI93kSHtdBIo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX6vRAAoJEKeha0olJ0NqsKwH/i3V6czvoONZYqFlwDZNJfP7
zLliTuZ1tpbsqFaQi+NyJcmRlkmEuLrHxo2CfkL/PKgvm6p03lNV9OykcRjS7648
6h7G46zUQ29rUhdJ4+xpLATzGIHxU3dWSQCBnITjG+Xg6EjRzz8Zaxkp278nG7L8
xCU0FUVLkYEoFNvFmdsFTUetWFH1Dg1oPCMIgWBGyWWt/y8LsO9plamFn12cLY38
GTO44gI4ZWIRDv4DFUZfPBGhx4kwWggRLWkO1dm7G+FJACjOyZ17pUS3FfkTLZxy
q4bHvZFnSQZVn5JXkXjvcX209fnbZXTeYgdR1BT77ifigI1mJ2kXPEPTiqauI30=
=z+60
-----END PGP SIGNATURE-----

--s52G3eDKb9Hb0qvNGw6nWHI93kSHtdBIo--
