Received: from eggs.gnu.org ([2001:4830:134:3::10]:54492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3NXS-000525-TA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3NXJ-0000mZ-JL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:03:26 -0400
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30f7fab5-7e25-5648-f6b3-c60452c6b8f3@redhat.com>
Date: Wed, 26 Apr 2017 09:03:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170426134649.9042-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hg3v6qvHx5hq9seO8ralb5DGx1q9X4qmw"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-img/convert: Use @opts for one
 thing only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hg3v6qvHx5hq9seO8ralb5DGx1q9X4qmw
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30f7fab5-7e25-5648-f6b3-c60452c6b8f3@redhat.com>
Subject: Re: [PATCH v2 1/3] qemu-img/convert: Use @opts for one thing only
References: <20170426134649.9042-1-mreitz@redhat.com>
 <20170426134649.9042-2-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 08:46 AM, Max Reitz wrote:
> After storing the creation options for the new image into @opts, we
> fetch some things for our own information, like the backing file name,
> or whether to use encryption or preallocation.
>=20
> With the -n parameter, there will not be any creation options; this is
> not too bad because this just means that querying a NULL @opts will
> always return the default value.
>=20
> However, we also use @opts for the --object options. Therefore, @opts i=
s
> not necessarily NULL if -n was specified; instead, it may contain those=

> options. In practice, this probably does not cause any problems because=

> there most likely is no object that supports any of the parameters we
> query here, but this is neither something we should rely on nor does
> this variable reuse make the code very nice to read.
>=20
> Therefore, just use an own variable for the --object options.

Reads better with s/an own/a separate/

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-img.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20

R-b still stands.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hg3v6qvHx5hq9seO8ralb5DGx1q9X4qmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKiWAAoJEKeha0olJ0Nq1CIH/R1E0MJIUQmhXEdyw9A3GH6z
3/xSibb6PLxouRVSMJB2rlA2ZXIlPd4hkelerewyU1cgT0029E3ihBBbVDfkEP79
FOW4mXXQoQ6rCjvFySdup9z60LzxV1G5xwhIcYUmeVTdZIvXXyDs86rztnhwQ6yW
uFsMOa1AkVK2de8ZbP+zjpu7+dLUBkQIWy5HoDqLaXdbQNK5R9DoZllRa4I6ea7b
UIYTUBc4/jdCcGQeLXQ2Kq6ETyrobGwZ79jftFfv8x6wg7umj0h0NnDhx2LvbHYf
p+eTva37g600vKaAJm5wZzsd7bymU66PUu5M6C78R1ZIrEdW8Ef/hcrXUP3Tgsw=
=AVad
-----END PGP SIGNATURE-----

--Hg3v6qvHx5hq9seO8ralb5DGx1q9X4qmw--
