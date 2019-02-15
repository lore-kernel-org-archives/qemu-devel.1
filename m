Received: from eggs.gnu.org ([209.51.188.92]:59564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1guitx-0002KX-TS
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1guitx-0006EP-74
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:11:57 -0500
References: <20190123103323.4516-1-stefanha@redhat.com>
	<20190123103323.4516-2-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <43742d53-a271-8db4-f641-7e19d1712156@redhat.com>
Date: Fri, 15 Feb 2019 20:11:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190123103323.4516-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Uyn9UMb70mUMtanIue2TsmebrndFM9a04"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: include LUKS payload
 overhead in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uyn9UMb70mUMtanIue2TsmebrndFM9a04
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <43742d53-a271-8db4-f641-7e19d1712156@redhat.com>
Subject: Re: [PATCH v2 1/2] qcow2: include LUKS payload overhead in qemu-img
 measure
References: <20190123103323.4516-1-stefanha@redhat.com>
 <20190123103323.4516-2-stefanha@redhat.com>
In-Reply-To: <20190123103323.4516-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 11:33, Stefan Hajnoczi wrote:
> LUKS encryption reserves clusters for its own payload data.  The size o=
f
> this area must be included in the qemu-img measure calculation so that
> we arrive at the correct minimum required image size.
>=20
> (Ab)use the qcrypto_block_create() API to determine the payload
> overhead.  We discard the payload data that qcrypto thinks will be
> written to the image.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/qcow2.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++-=

>  1 file changed, 71 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Uyn9UMb70mUMtanIue2TsmebrndFM9a04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxnDvAACgkQ9AfbAGHV
z0CGFwgAmiPn8L+6ljBXWMmdtodGSsDsUQAhkhD4rsjSrqABs6IHMrLrC+ndi272
7jvvvOIE9TI8veV4jTGQ2dqxuhIXryMzQMFaz1UU9iuMG2uKXsgtH3gPm8Rn97Pe
ugzC7GzLFWS0GVffU1Il4l3clVgfSpoaePuReXUq5GI3u4UjUmW7w7vt422HLhMi
GdGn6osGlfLQ4o8/TpM3P+lHcJaP347xqScuzdMiset1I5UZhbzvCxFqEQZ50wJZ
4H1K5BbLidk9a2il1jm9RhFklTjN0UVzKmricNGzKlJUMBBS/PxcIgNDqX8nwAXu
ytQt0KmrCCBoMf8sLASe4y+h/DuEMQ==
=ekkx
-----END PGP SIGNATURE-----

--Uyn9UMb70mUMtanIue2TsmebrndFM9a04--
