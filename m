Received: from eggs.gnu.org ([2001:4830:134:3::10]:46612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dV0Oa-0006nu-D7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dV0OX-0003V2-CW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:00:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dV0OX-0003Ui-45
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:00:25 -0400
References: <20170705125738.8777-1-stefanha@redhat.com>
	<20170705125738.8777-7-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1f21847-9d29-8d8e-0399-18b07a8e101d@redhat.com>
Date: Tue, 11 Jul 2017 13:59:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170705125738.8777-7-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oJ9epV2CJPowjVTtBTf4QqUPGC5eTEemC"
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
--oJ9epV2CJPowjVTtBTf4QqUPGC5eTEemC
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <a1f21847-9d29-8d8e-0399-18b07a8e101d@redhat.com>
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

> =20
> +static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverStat=
e *in_bs,

> +        } else {
> +            int cluster_sectors =3D cluster_size / BDRV_SECTOR_SIZE;
> +            int64_t sector_num;
> +            int pnum =3D 0;
> +
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

Oh what fun. More sector-based iteration that I get to convert to
byte-based on another respin of my work ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oJ9epV2CJPowjVTtBTf4QqUPGC5eTEemC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZSApAAoJEKeha0olJ0NqBsMIAKpgjCWtv9Ms7ptFCrcQxTIS
Zr8kxQsCDd/uP44585Bz991irY8VyQA+ltGoYLzUWf9ZCuqKo/4eFFYgvkjZyU1N
CiN8PmNOsGd8e9/dJwAZkJ+Yjv+ydZ9CBTsN0oAhgqlujrDk+EyaTor1WePbtg80
be2xAj93XeDx+vPypcch6BA9fJz0Q2qtUYHq2xnExav1zQM4NW2VnMToM/HU0v/U
j8/UkJX+c0LGnuy4lzH9rEOTiKuHeAGwSBg3rNdLaimqEytrPH4m5Z63dJaD+Gor
e9FiXlqYrpqPutILkpoG5z3HVLJunUvgXzFgoztaSilQQQNQedmAPGwtCZdx45s=
=uLbs
-----END PGP SIGNATURE-----

--oJ9epV2CJPowjVTtBTf4QqUPGC5eTEemC--
