Received: from eggs.gnu.org ([2001:4830:134:3::10]:35796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDCGt-0000XK-DK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDCGs-0003j5-D3
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:35:11 -0500
References: <20171103144113.7188-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
Date: Fri, 10 Nov 2017 10:34:59 -0600
MIME-Version: 1.0
In-Reply-To: <20171103144113.7188-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LmkqlFqEiV7NCItjtE9rwKrWWJnBBiXp4"
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LmkqlFqEiV7NCItjtE9rwKrWWJnBBiXp4
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after committing
 qcow2 image into base
References: <20171103144113.7188-1-berrange@redhat.com>
In-Reply-To: <20171103144113.7188-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 09:41 AM, Daniel P. Berrange wrote:
> After committing the qcow2 image contents into the base image, qemu-img=

> will call bdrv_make_empty to drop the payload in the layered image.
>=20
> When this is done for qcow2 images, it blows away the LUKS encryption
> header, making the resulting image unusable. There are two codepaths
> for emptying a qcow2 image, and the second (slower) codepaths leaves
> the LUKS header intact, so force use of that codepath.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> NB, ideally we would fix the faster codepath in make_completely_empty, =
but
> having looked at the code, I've really no idea how to even start on fix=
ing that
> to not kill the LUKS header clusters.

Hmm - I wonder if persistent bitmaps are also corrupted in the fast path.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LmkqlFqEiV7NCItjtE9rwKrWWJnBBiXp4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloF1TMACgkQp6FrSiUn
Q2rm8gf/Rs6Xz+NW4jZV/ljvgZGHaQTXfab5h6iHnN/NWAzhiqmqd/twUVOIRJsQ
VE5+GQOmv4gRKkJRUKhF4iubBV7Rgfw7yUT+vhbNhnP6BEVhJR6Afv7Wr3yVelVf
JuczOo3Tv6QkATgoFvYbnfvlRFGUmdZxF5kaBye1go83v9hzfw/lt4A3p9MTdRDx
gY1B91rS9HZf5dPthpO/Qu1VFztSCt4CMf3HiztUQAtHaySGNpjhWG2jDy9E2YlV
qW4Um6b62Lq2/tQ7qslzgThWbfv2zo05T9imfC0nlNg88Tp9ewzJDAamLNRDx2UB
NSAdBtik628oJNeqUgq+hP5Q9y992w==
=zOp8
-----END PGP SIGNATURE-----

--LmkqlFqEiV7NCItjtE9rwKrWWJnBBiXp4--
