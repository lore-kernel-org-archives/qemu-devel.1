Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnfo-0003bW-SQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnfl-0002jG-Cm
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFnfl-0002hX-3v
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:23:21 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34441624-9b52-e942-2b14-eec35ccc4c74@redhat.com>
Date: Tue, 30 May 2017 15:23:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UKAU4ex4XkGR6qre6XtwK6I2liJ3Jjr4C"
Subject: Re: [Qemu-devel] [PATCH 02/19] nbd/server: get rid of ssize_t
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
--UKAU4ex4XkGR6qre6XtwK6I2liJ3Jjr4C
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <34441624-9b52-e942-2b14-eec35ccc4c74@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/19] nbd/server: get rid of ssize_t
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Now read_sync and friends return int, so get rid of ssize_t.

In particular, it was your earlier commit "nbd: read_sync and friends:
return 0 on success" that changed the semantics of the return value to
just be 0 instead of a size; and this is just a followup cleanup (now
that we aren't returning a size, ssize_t is overkill).

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UKAU4ex4XkGR6qre6XtwK6I2liJ3Jjr4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLdS2AAoJEKeha0olJ0Nq4owIAKNeY2D9jX6kYjPiPvjiSXt2
ys3vfIXnvi55cyb69AVVqO6uQAWkmlCF9AkN30qoyzAeAPCQHYrvADekzjv9/ZEH
5UzW9V5vRIpGyDk8p/BUGWgrN/xSit0KJO90ig4JS6NBri8sE1V7i40KwmEfN8ha
ubGZ/Uux+IdLFo2uEvqGZDbNJMoagJc5tGmDlhdwUFoMCTs9+JWEYmsRP70TiZqh
umJ2uCykp9MVCF/nYIQNMBMWk3nL1z9JashDRL08wyO9dtA+/ec8NNDSVXAXdnA3
AAeU2sF7W50tiS/PKMv29nQP/UdLohBVJuPG9FVbeTEuSfpRibSjtqPa+EQRvnY=
=I6qC
-----END PGP SIGNATURE-----

--UKAU4ex4XkGR6qre6XtwK6I2liJ3Jjr4C--
