Received: from eggs.gnu.org ([2001:4830:134:3::10]:48933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dV0SV-00086f-V0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dV0SR-0005np-NH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dV0SR-0005nC-E9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:04:27 -0400
References: <20170705125738.8777-1-stefanha@redhat.com>
	<20170705125738.8777-7-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4adda7cf-6f55-c96f-2448-e662f1e7ea72@redhat.com>
Date: Tue, 11 Jul 2017 14:04:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170705125738.8777-7-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7nstbOsHejaxFfAgcSr86euRs8Pc0NSUj"
Subject: Re: [Qemu-devel] [PATCH v9 6/9] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7nstbOsHejaxFfAgcSr86euRs8Pc0NSUj
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <4adda7cf-6f55-c96f-2448-e662f1e7ea72@redhat.com>
Subject: Re: [PATCH v9 6/9] qcow2: add bdrv_measure() support
References: <20170705125738.8777-1-stefanha@redhat.com>
 <20170705125738.8777-7-stefanha@redhat.com>
In-Reply-To: <20170705125738.8777-7-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 07:57 AM, Stefan Hajnoczi wrote:
> Use qcow2_calc_prealloc_size() to get the required file size.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---

> +            for (sector_num =3D 0;
> +                 sector_num < ssize / BDRV_SECTOR_SIZE;
> +                 sector_num +=3D pnum) {
> +                int nb_sectors =3D MAX(ssize / BDRV_SECTOR_SIZE - sect=
or_num,
> +                                     INT_MAX);
> +                BlockDriverState *file;
> +                int64_t ret;
> +
> +                ret =3D bdrv_get_block_status_above(in_bs, NULL,
> +                                                  sector_num, nb_secto=
rs,
> +                                                  &pnum, &file);

Shouldn't that be MIN(), not MAX(), in the computation of nb_sectors?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7nstbOsHejaxFfAgcSr86euRs8Pc0NSUj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZSEuAAoJEKeha0olJ0NqQ7kH/0ErjuR6ohV7BFB3QNnLd/W0
oufLxZCjFoPwDgybXWj4qdgrtoHQwv7khfWwp5zUYcTHYauFh8+jfytzkQ/5tDz5
RPDXpQlQlGqfAAd0MJ0fugTBHAce6YUxJV0ADSXjHRD4HkP8WfO6e0l8VZveXh+D
Ab9OsmOWx7uj1j/Grnr7Kr1MyPTP5tr5jDHwL26rAOdw2SEMT4baug6APL+R0M7V
XQmyvFS/M6olKOLplBQmWlK8Vhwb5X0o6FQSHASr7iE9ReMhZY1aB0nwEn44l+rx
d+WKfokt8HsRe0vZJ7vPkbSSsM5Qv+px3x5/N/mKBuzovDlO+YNHL6zRk4bQVOI=
=Vv8b
-----END PGP SIGNATURE-----

--7nstbOsHejaxFfAgcSr86euRs8Pc0NSUj--
