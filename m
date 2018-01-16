Received: from eggs.gnu.org ([2001:4830:134:3::10]:53253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebX6K-0006kf-Sg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebX6J-0005UR-Og
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:40:52 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5b1b87c-68b8-97f5-b822-e78a121adcfa@redhat.com>
Date: Tue, 16 Jan 2018 13:40:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="heOmjX5XwYrtZqTzzJdrsO6gDaa33EyQI"
Subject: Re: [Qemu-devel] [RFC PATCH 07/10] qcow2: Handle full/falloc
 preallocation in qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--heOmjX5XwYrtZqTzzJdrsO6gDaa33EyQI
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <f5b1b87c-68b8-97f5-b822-e78a121adcfa@redhat.com>
Subject: Re: [RFC PATCH 07/10] qcow2: Handle full/falloc preallocation in
 qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-8-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> Once qcow2_create2() can be called directly on an already existing node=
,
> we must provide the 'full' and 'falloc' preallocation modes outside of
> creating the image on the protocol layer. Fortunately, we have
> preallocated truncate now which can provide this functionality.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--heOmjX5XwYrtZqTzzJdrsO6gDaa33EyQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeVToACgkQp6FrSiUn
Q2q0jwgAgPzZVwwtz59OU7YEegiNFPEMxYjc2r5U/8hvfSM6ONyF3uTk6zZWUFos
bmxQsIwA/MaHFKdZrXfAg717PPjFrzmYnfmHm7eMvALIJgrVq4Tu+POW4INJqdsK
iZm671+VM3fv+GeawahVk/Zk9f/MUrc++f01Ql/AcaQJmoKPX/lLNhAOQHsLUnWM
XbLnnuCarPGNEEjw1ON+hqf8mW8XM/QgEiYYCurugGLn7eAI1MXHiJv0D2LEBs/R
dEN7EN6pMwCHzgMQH1ZsIvczCHdVvYiSvt3aIks88UsjUF8Zt2l1WIxrMVBYQyJA
zK42SMYL54R5pxnrIalNlGDK5cpbTw==
=NEVo
-----END PGP SIGNATURE-----

--heOmjX5XwYrtZqTzzJdrsO6gDaa33EyQI--
