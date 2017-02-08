Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbb3b-0003Zv-OS
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbb3Y-0003fD-NG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:49:47 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ae70524c-9c47-a1bb-fc3c-f4216eb68f5c@redhat.com>
Date: Wed, 8 Feb 2017 23:49:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xlDAp1NstSQPTN4mbUHGXCtxNDUVChIXG"
Subject: Re: [Qemu-devel] [PATCH v3 03/18] qcow: document another weakness
 of qcow AES encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xlDAp1NstSQPTN4mbUHGXCtxNDUVChIXG
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ae70524c-9c47-a1bb-fc3c-f4216eb68f5c@redhat.com>
Subject: Re: [PATCH v3 03/18] qcow: document another weakness of qcow AES
 encryption
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-4-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-4-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 11:18, Daniel P. Berrange wrote:
> Document that use of guest virtual sector numbers as the basis for
> the initialization vectors is a potential weakness, when combined
> with internal snapshots or multiple images using the same passphrase.
> This fixes the formatting of the itemized list too.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.texi | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xlDAp1NstSQPTN4mbUHGXCtxNDUVChIXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliboHsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+CMIALkiKtDNK2XCIs79FXPh8jmZ0GyVOmRF
B7qS7Tc9CPM8SM/8qPwQxRvjDcOIc0sWEXsVJIFoycQjkGRCB6GC7BnMoE5i3/lN
k/jkTcq3PCS6mP+8Zbh9znJ0LQYtjz1p+YmEHnBcJpgqOoLwfcErAf98MDG6OmFP
fWMr35Ja5YFcyTspNICEpJBUR2LDzTSrLxidOWdrWlQ4Xvvl4owDsQVDmT2Fb5Cs
z+Q3ZZH836a0fGnURm7oFgm3ezx872rimfS5cIWeD+kishr3oOWs9xn18k5GirUe
2VOmcWGy7/EyooEwqQgRxgdm/wd27FOP+1MWgF0CJIg1azPjP5njfPk=
=KXdq
-----END PGP SIGNATURE-----

--xlDAp1NstSQPTN4mbUHGXCtxNDUVChIXG--
