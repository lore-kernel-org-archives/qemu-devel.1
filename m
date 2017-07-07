Received: from eggs.gnu.org ([2001:4830:134:3::10]:46933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVX2-0005GP-Ml
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVX1-0003iG-UF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVX1-0003fY-Kn
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:50:59 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84742f4f-1504-1701-dd35-38abdbec2230@redhat.com>
Date: Fri, 7 Jul 2017 10:50:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RFgsdA33Q7G9S6q2Lkqh4TOOsWepOV8WM"
Subject: Re: [Qemu-devel] [PATCH v3 08/10] nbd/server: rename clientflags
 var in nbd_negotiate_options
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
--RFgsdA33Q7G9S6q2Lkqh4TOOsWepOV8WM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <84742f4f-1504-1701-dd35-38abdbec2230@redhat.com>
Subject: Re: [PATCH v3 08/10] nbd/server: rename clientflags var in
 nbd_negotiate_options
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Rename 'clientflags' to just 'option'. This variable has nothing to do
> with flags, but is a single integer representing the option requested
> by the client.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RFgsdA33Q7G9S6q2Lkqh4TOOsWepOV8WM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX63eAAoJEKeha0olJ0NqoBgIAIPaQGMl8ySJ3QEhS3UZIHcp
QTZaCN/sf79xa5Mf8utA4T34UJwmzzQbV+sOJagjK7UyJr5btN6Cvc5LubLs+sXw
Kw6bwaarCUblDeRZ65sim6j4jHFe3lD/ORTY00I2dzkM7I/oXJ6pqe4CWkxgRbfA
zULApGm6xCYQPSNMChHtZ08PL9qhko+PUjevZySQilRySy0ZeTTta9rheD0ZVzI3
kNnNOXN9/a5m5uo1QS49gv/lDQ2Gq7vH3fy1vR1xgHlr2+1SkBm6ZwsPKyKW71nG
3M0HrvCD24K9eyAhuiUSBseqIPWoC1BiyfvrGLPGzu6NEOCVROFrGxPuC2xwaKQ=
=c6JB
-----END PGP SIGNATURE-----

--RFgsdA33Q7G9S6q2Lkqh4TOOsWepOV8WM--
