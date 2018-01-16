Received: from eggs.gnu.org ([2001:4830:134:3::10]:40156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZUg-0001SG-TN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZUf-0004fp-RC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:14:10 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<967bbc1a89d1d7afd169350c5e61da19ee0166ec.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b2294f1-bedd-89f2-034c-9f1665123b33@redhat.com>
Date: Tue, 16 Jan 2018 16:14:02 -0600
MIME-Version: 1.0
In-Reply-To: <967bbc1a89d1d7afd169350c5e61da19ee0166ec.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n6bUUuUTqCcyigpdu7MBozhrbL0JH7KX8"
Subject: Re: [Qemu-devel] [PATCH v2 15/32] qcow2: Update l2_load() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n6bUUuUTqCcyigpdu7MBozhrbL0JH7KX8
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <7b2294f1-bedd-89f2-034c-9f1665123b33@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/32] qcow2: Update l2_load() to support
 L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <967bbc1a89d1d7afd169350c5e61da19ee0166ec.1513342045.git.berto@igalia.com>
In-Reply-To: <967bbc1a89d1d7afd169350c5e61da19ee0166ec.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> Each entry in the qcow2 L2 cache stores a full L2 table (which uses a
> complete cluster in the qcow2 image). A cluster is usually too large
> to be used efficiently as the size for a cache entry, so we want to
> decouple both values by allowing smaller cache entries. Therefore the
> qcow2 L2 cache will no longer return full L2 tables but slices
> instead.
>=20
> This patch updates l2_load() so it can handle L2 slices correctly.
> Apart from the offset of the L2 table (which we already had) we also
> need the guest offset in order to calculate which one of the slices
> we need.
>=20
> An L2 slice has currently the same size as an L2 table (one cluster),
> so for now this function will load exactly the same data as before.
>=20
> This patch also removes a stale comment about the return value being
> a pointer to the L2 table. This function returns an error code since
> 55c17e9821c474d5fcdebdc82ed2fc096777d611.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n6bUUuUTqCcyigpdu7MBozhrbL0JH7KX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeeSoACgkQp6FrSiUn
Q2q1XAf+KRuvAHR7aHZlI/DEg3ka+z8VnDf2kI2r1xgXhzmH/kqhF6yljeOevZt6
YxiqHFqDK8MD1S6EIoXoIJHlJQXCz6zkYzfdjWh7fh0Aj6K1yzVZqsKmgr/i/v7O
qYJ7LgJCrRJ2BUWPj3cKfE1BduAXmTUkG3167bRNhybEB9JrrMOquEYaEq+R3FTY
DE3V2C81YYMN7LRK1UwAvhUVPWBO7f1T98PiWJ/TdATwzBfN6qjMac+54lrLGqyN
9F1i0Fr8I3rnYsPhiUAKt1rUFKoA3aUYyV42Ow0cwXS4rE/4EtfMpOA1MCc8GLP4
1hf2ZnUcGT0OywmBQrPz66fbEAuIrA==
=JLWN
-----END PGP SIGNATURE-----

--n6bUUuUTqCcyigpdu7MBozhrbL0JH7KX8--
