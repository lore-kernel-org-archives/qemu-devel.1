Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNlU-0006xe-CM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNlT-0005P1-1B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:24 -0400
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-5-farosas@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <78c48f4a-1da1-e5da-4c0a-69f9ee799d04@redhat.com>
Date: Mon, 12 Mar 2018 14:45:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180309182202.31206-5-farosas@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XV6YTBtRivLpiuhs0iZ9noaA4UGXxtqb2"
Subject: Re: [Qemu-devel] [PATCH 4/5] block/blkreplay: Remove
 protocol-related fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XV6YTBtRivLpiuhs0iZ9noaA4UGXxtqb2
From: Max Reitz <mreitz@redhat.com>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78c48f4a-1da1-e5da-4c0a-69f9ee799d04@redhat.com>
Subject: Re: [PATCH 4/5] block/blkreplay: Remove protocol-related fields
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
 <20180309182202.31206-5-farosas@linux.vnet.ibm.com>
In-Reply-To: <20180309182202.31206-5-farosas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 19:22, Fabiano Rosas wrote:
> The blkreplay driver is not a protocol so it should implement bdrv_open=

> instead of bdrv_file_open and not provide a protocol_name.
>=20
> Attempts to invoke this driver using protocol syntax
> (i.e. blkreplay:<filename:options:...>) will now fail gracefully:
>=20
>   $ qemu-img info blkreplay:foo
>   qemu-img: Could not open 'blkreplay:foo': Unknown protocol 'blkreplay=
'
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> ---
>  block/blkreplay.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--XV6YTBtRivLpiuhs0iZ9noaA4UGXxtqb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmhGwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AO/UH/1mfq8MrtHJuTELeFzJGvLDZaEwaAdzK
7j4GW2MuXEQsa3k8R1zWt5DU0au3Z6WrV/8P0s1AruHqTBKUdUY8UXSBQDF/z9Mc
VBE9div48NbJu29gY12fx9QBmUvTRBVeFh1ks+4XwHMaYJGtvh/+O7HOrLKK15po
l8IcwkG1wX88EDG5/hFosUEQXqiSOPN6yNoY+izBa2GiXWj6ugOWTm2EFgUXSOe8
hsJ0VqWENqkWoa7LVS8sCQvf8yEljnVavEDgDxNILso67qhCLBn+gGFudruXi7oT
O992/l1HYnoXctaYw7IdU5Nkb/wDX+JH9HCr0jwmFpVgGyc/1hIBWVE=
=oUVY
-----END PGP SIGNATURE-----

--XV6YTBtRivLpiuhs0iZ9noaA4UGXxtqb2--
