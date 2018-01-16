Received: from eggs.gnu.org ([2001:4830:134:3::10]:52373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebX3O-0004mN-0E
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebX3N-0003RB-BW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:37:50 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4baaa624-f7e2-42be-bd79-f9e758007c87@redhat.com>
Date: Tue, 16 Jan 2018 13:37:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EM71NZGaTu5qABN1Xe2eAgYdPt7kFNAOr"
Subject: Re: [Qemu-devel] [RFC PATCH 06/10] qcow2: Use
 QCryptoBlockCreateOptions in qcow2_create2()
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
--EM71NZGaTu5qABN1Xe2eAgYdPt7kFNAOr
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <4baaa624-f7e2-42be-bd79-f9e758007c87@redhat.com>
Subject: Re: [RFC PATCH 06/10] qcow2: Use QCryptoBlockCreateOptions in
 qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-7-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> Instead of passing the encryption format name and the QemuOpts down, us=
e
> the QCryptoBlockCreateOptions contained in BlockdevCreateOptions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 62 +++++++++++++++++++++++++++++++++++++++++++--------=
--------
>  1 file changed, 45 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EM71NZGaTu5qABN1Xe2eAgYdPt7kFNAOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeVHgACgkQp6FrSiUn
Q2rPvggAlwPStd7PiFXX3bnuPbKGPVrK8i0PI5Z7jIxlp1q1peyVJexoWgIeZ2ir
A2oj8pBjvvpNMYIwAaCAM7kZ4CAcTqnajRVFLb1gHaynqNsYP3OSD0dsziJN35GX
bpytoKOjcgPq8Y/t1d48+SfZ2MMqNkj0i9cl65WJ90vIg2ADX2rre8GPY4crincJ
X5AF4tSzZTqOq41whtuLI0g/uPpqBb4pum+KLkbeCVzjo8tHkL0xKQE4jgRmcFyj
YjCCEsMMmSjStdX0Dx47MNfmGqPgjocsrUjxN1UG9k07pv82uF8AU/2qoUg1P/cO
hKIz36B2I2wbBTuB9GhXKdh99EXOgA==
=mN5+
-----END PGP SIGNATURE-----

--EM71NZGaTu5qABN1Xe2eAgYdPt7kFNAOr--
