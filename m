Received: from eggs.gnu.org ([2001:4830:134:3::10]:50963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwbPa-0001bO-KP
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwbPZ-00077A-Up
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:59:34 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8fcd173-3232-6df4-809f-759f83e00b38@redhat.com>
Date: Mon, 25 Sep 2017 16:59:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170925135801.144261-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k4D94mvxhdBrbOi44hDq9HEgEfnmGALqj"
Subject: Re: [Qemu-devel] [PATCH 2/8] block/nbd-client: refactor
 nbd_co_receive_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k4D94mvxhdBrbOi44hDq9HEgEfnmGALqj
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <c8fcd173-3232-6df4-809f-759f83e00b38@redhat.com>
Subject: Re: [PATCH 2/8] block/nbd-client: refactor nbd_co_receive_reply
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
 <20170925135801.144261-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 08:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Pass handle parameter directly, as the whole request isn't needed.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k4D94mvxhdBrbOi44hDq9HEgEfnmGALqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJfD0ACgkQp6FrSiUn
Q2oncAgArdbOevoy4UkCl5IEU1Q9N1dt8H0tUtS+59zc7Ag/H6skcnzgM8MXuxnd
fdOxC5nHP3Svc43dWzBlofDTsZanfhO/Ca7Ifmpy4egrZbtY3+BFoPy9bI/5TnzY
dmpWCNhH3X8caLalN4gFFTuKogTVQ5I/i1TMfZoCWj6W41DT2Th4CRaxvyHMtGEf
luSapCwsHGXTvpVPLq+pADhSmlI8EkXagOdxcZAH8wNk4NrofIAEb4m/mEhx/HE/
2c2z//I4JNE9WsW00FHsbqe3icfk5KFSQmRIa8MQAfi4IILQJezDEP+b9bsWuG65
0X1+es2GmuRlJAUs3hU+TqsoRqbs7Q==
=EnuO
-----END PGP SIGNATURE-----

--k4D94mvxhdBrbOi44hDq9HEgEfnmGALqj--
