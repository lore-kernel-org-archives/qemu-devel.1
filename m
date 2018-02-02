Received: from eggs.gnu.org ([2001:4830:134:3::10]:37159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehcXp-0007fs-VV
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehcXo-0001QE-UH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:42:26 -0500
References: <20180202052310.7870-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <12e310bb-02c9-8ef3-4657-014660d91b2a@redhat.com>
Date: Fri, 2 Feb 2018 14:22:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180202052310.7870-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PBbfuMCCsUeBCwkVFQsxYapUm8HE76B6X"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PBbfuMCCsUeBCwkVFQsxYapUm8HE76B6X
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com
Message-ID: <12e310bb-02c9-8ef3-4657-014660d91b2a@redhat.com>
Subject: Re: [PATCH v3] iotests: Fix CID for VMDK afl image
References: <20180202052310.7870-1-famz@redhat.com>
In-Reply-To: <20180202052310.7870-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-02 06:23, Fam Zheng wrote:
> This reverts commit 76bf133c4 which updated the reference output, and
> fixed the reference image, because the code path we want to exercise is=

> actually the invalid image size.
>=20
> The descriptor block in the image, which includes the CID to verify, ha=
s been
> invalid since the reference image was added. Since commit 9877860e7bd w=
e report
> this error earlier than the "file too large", so 059.out mismatches.
>=20
> The binary change is generated along the operations of:
>=20
>   $ bunzip2 afl9.vmdk.bz2
>   $ qemu-img create -f vmdk fix.vmdk 1G
>   $ dd if=3Dafl9.vmdk of=3Dfix.vmdk bs=3D512 count=3D1 conv=3Dnotrunc
>   $ mv fix.vmdk afl9.vmdk
>   $ bzip2 afl9.vmdk
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v3: Skip test when ENOMEM. [Max, Eric]
>=20
> v2: Fix commit message "qcow2 -> vmdk". [Kevin]
>     Revert 76bf133c4.
> ---
>  tests/qemu-iotests/059                         |   5 ++---
>  tests/qemu-iotests/059.out                     |   2 +-
>  tests/qemu-iotests/sample_images/afl9.vmdk.bz2 | Bin 178 -> 618 bytes
>  3 files changed, 3 insertions(+), 4 deletions(-)

Nice, thanks.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--PBbfuMCCsUeBCwkVFQsxYapUm8HE76B6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp0ZiMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWyIIAJEp98uyPXgB34KkmoTNWy0MeApzGRfD
GPz0IndBQFeSoVcKXgk0h9a/b8QBTURjFIZ9QrLj7wKvNN83+tqkzbsF6OvSWwqZ
QsZzjQ5v3xBEafddPlQTEXt4szpUPvkhyLI7lXxTVWuYsywHAeWeKasiMe6mU+U5
tPk6N/uhM1D8rXnvXuzkj5b0z9cC0Azw4SeUieMTrtgDwGVHohW0H+dpdLZZnh1U
i84qobLK5zjS6PNmqpsGP0QXvWgmsxNOu9msqhF3z6cVXzZClJjURgUoX3gLk0Ve
93EMmzJQiEMvprzEX8phZ+1sNewcRdoq8N93JaTWsE/zUJ7oX/1YJKI=
=z3f/
-----END PGP SIGNATURE-----

--PBbfuMCCsUeBCwkVFQsxYapUm8HE76B6X--
