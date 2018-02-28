Received: from eggs.gnu.org ([2001:4830:134:3::10]:36793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er5sP-0005k6-Jw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er5sO-00020M-Rt
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:50:49 -0500
References: <20180202052310.7870-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1a2f11f4-2807-69de-fa4a-46541753b487@redhat.com>
Date: Wed, 28 Feb 2018 18:50:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180202052310.7870-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2XqvIZNhXjDDXMaNv2TwUV8KDpARlVx4h"
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
--2XqvIZNhXjDDXMaNv2TwUV8KDpARlVx4h
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com
Message-ID: <1a2f11f4-2807-69de-fa4a-46541753b487@redhat.com>
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

Could you rebase this on master (so only the _notrun portion remains)?
It appears that v2 has hit master already...

Max


--2XqvIZNhXjDDXMaNv2TwUV8KDpARlVx4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqW6+ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASEwH/AygAs2kqMTmDWw/I2amOOlW0hMVRM3p
IDwA+Zc8dv0ntBBgAENl3HfSxO3XMZxZuDHCJEBjKno6eauTxZirNyRUOEiVMmM2
h9dNSz8n4nerol49nAN7Y8K73Mlv8psu2oOjHZ2jluVpsYpekxoHX417BvbgVMag
0fdKtqD+oHGi0Tg5Nf9xAuDzRCxYJkgrWFHqWUH5fD3lfJZ39/Y+Y5/LpSjr30pj
6OLAljIpSSi7vzIt8z7YFYBDQVNwE4oyH0nbQfg7MQBO/0nbbMuy4sSKNP/e30Cu
2HG0g7WjUovs8jpfx9/qT5lRvsOT5JjJhW9rtYBKa8oFLtJwsK0baLM=
=dzoS
-----END PGP SIGNATURE-----

--2XqvIZNhXjDDXMaNv2TwUV8KDpARlVx4h--
