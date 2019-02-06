Received: from eggs.gnu.org ([209.51.188.92]:58721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUnO-00032S-2O
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grUnM-0004MM-5n
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:50 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-9-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ae3dfa3-6f0b-45c1-0824-36cd78215f60@redhat.com>
Date: Wed, 6 Feb 2019 15:31:41 -0600
MIME-Version: 1.0
In-Reply-To: <20190206195551.28893-9-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yKrOhEclt7pCgVNr5XE0FbkArzLX5DDF2"
Subject: Re: [Qemu-devel] [PATCH v3 8/8] iotests: qcow2's encrypt.format is
 now optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yKrOhEclt7pCgVNr5XE0FbkArzLX5DDF2
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1ae3dfa3-6f0b-45c1-0824-36cd78215f60@redhat.com>
Subject: Re: [PATCH v3 8/8] iotests: qcow2's encrypt.format is now optional
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-9-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-9-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:55 PM, Max Reitz wrote:
> Remove the encrypt.format option from the two blockdev-add test cases
> for encrypted qcow2 images in 087 to explicitly test that this paramete=
r
> is now optional.
>=20
> Additionally, show that explicitly specifying encrypt.format=3Dauto wor=
ks
> just as well, the same for specifying the correct format
> (encrypt.format=3Dluks here), and that specifying the wrong format
> (encrypt.format=3Daes) results in an error.
>=20
> While touching this test case, reduce the LUKS iteration time to 10 so
> the test stays reasonably fast.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/087     | 65 +++++++++++++++++++++++---------------=

>  tests/qemu-iotests/087.out | 26 ++++++++++++++-
>  2 files changed, 64 insertions(+), 27 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yKrOhEclt7pCgVNr5XE0FbkArzLX5DDF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbUj0ACgkQp6FrSiUn
Q2o8KAgAqysXBXNbQtSI+o9eHKa96mnp77WG6Ayj2f+nj1rVv45bzenTsUEiOEHH
okQu3vTdbLY2pxEsyv5qaf2k72Q9rVdKlaCP8TfFZLysvNEVy97w+4fpxMCYXPow
KqYwY5Y2Y+mkAA0/u8tVMxMUqlC0iMFdf0ibiNMf3AOxdEmEpFtSBb+TRQ2NVYJP
uiOVqCZow/7ZUHNEpk+WCCan/tqO8MoMH05wljp4DGiXt6vc0s3bTh5zNIYVtXfN
s+tGpOx7oPwkFgKikM54ZXIyR+DgMjiDzd3ec7vcFI4UwkN5Lzbn4XFILiyw/Qwv
v2Q3L0NOA4H2glgkLhXoSGETRRYdoQ==
=9Mjb
-----END PGP SIGNATURE-----

--yKrOhEclt7pCgVNr5XE0FbkArzLX5DDF2--
